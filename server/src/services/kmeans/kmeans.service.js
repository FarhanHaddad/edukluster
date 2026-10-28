// Service K-Means — TIKET BE-KM-2: wire engine ke Prisma + audit trail + derived lock.
// Lock siswa bersifat DERIVED (eksistensi kmeans_run status COMPLETED) — R-KM-27:
// TIDAK ADA update kolom lock di sini maupun di model siswa_periode.
'use strict';

const { Prisma } = require('@prisma/client');
const prisma = require('../../lib/prisma');
const ApiError = require('../../utils/ApiError');
const { runKMeans } = require('./kmeans.engine');
const { computeDBI } = require('./kmeans.dbi');
const { SEED_ROW_INDICES, FEATURE_ORDER } = require('./kmeans.seed');
const { resolvePeriode, resolveCurrentRun } = require('../preprocessing.service')._internals;

// Helper konversi BigInt -> Number (boundary JSON).
function toNumber(value) {
  if (value === null || value === undefined) return null;
  return Number(value);
}

const RUN_STATUS = { ACTIVE: 'ACTIVE', COMPLETED: 'COMPLETED', SUPERSEDED: 'SUPERSEDED' };
const DISTANCE_METHOD = 'EUCLIDEAN';

// Boundary JSON: string HALF_UP 4 desimal (kontrak FE); storage DB tetap Decimal(12,8).
function decimalTo4(value) {
  if (value === null || value === undefined) return null;
  return new Prisma.Decimal(value).toFixed(4, Prisma.Decimal.ROUND_HALF_UP);
}

// Guard bersama (satu-satunya derivasi lock untuk sisi K-Means): run COMPLETED per periode.
async function findCompletedRun(periodeIdBigInt) {
  return prisma.kmeans_run.findFirst({
    where: { preprocessing_run: { periode_id: periodeIdBigInt }, status: RUN_STATUS.COMPLETED },
    orderBy: [{ completed_at: 'desc' }, { id: 'desc' }],
  });
}

// Eksekusi penuh pipeline K-Means pada run preprocessing TERBARU periode target.
async function executeKmeansRun(periodId, adminInfo) {
  const periode = await resolvePeriode(periodId !== undefined ? periodId : undefined);
  const periodeIdBigInt = periode.id;

  // (a) Guard lock derived -> 409 Bahasa Indonesia.
  if (await findCompletedRun(periodeIdBigInt)) {
    throw new ApiError(409, 'K-Means sudah pernah dijalankan pada periode ini; data siswa terkunci.');
  }

  const preRun = await resolveCurrentRun(periodeIdBigInt);
  if (!preRun) {
    throw new ApiError(422, 'Data reduksi belum tersedia; jalankan preprocessing sampai tahap Reduksi.');
  }

  // (b) Guard data: reduced_data run aktif kosong -> 422.
  const rows = await prisma.reduced_data.findMany({
    where: { preprocessing_run_id: preRun.id },
    orderBy: { id: 'asc' }, // kontrak urutan sheet Reduction; seed index posisional di sini
  });
  if (rows.length === 0) {
    throw new ApiError(422, 'Data reduksi belum tersedia; jalankan preprocessing sampai tahap Reduksi.');
  }

  // (c) Mapping matriks via FEATURE_ORDER lalu Lloyd deterministik + DBI.
  const matrix = rows.map((row) => FEATURE_ORDER.map((key) => Number(row[key])));
  const result = runKMeans(matrix, { seedIndices: SEED_ROW_INDICES, k: 10 });
  // clusters per-CODE (index 0..k-1), BUKAN per titik — kontrak computeDBI.
  const clustersPoints = new Array(result.distribution.length).fill(null).map(() => []);
  matrix.forEach((vector, pointIndex) => clustersPoints[result.finalAssignments[pointIndex]].push(vector));
  const lastCentroids = result.iterations[result.iterations.length - 1].centroids;
  const dbiString = computeDBI(clustersPoints, lastCentroids);

  const now = new Date();
  const run = await prisma.$transaction(async (tx) => {
    const created = await tx.kmeans_run.create({
      data: {
        preprocessing_run_id: preRun.id,
        admin_id: BigInt(adminInfo.id),
        k: 10,
        distance_method: DISTANCE_METHOD,
        status: RUN_STATUS.COMPLETED,
        total_iteration: result.iterations.length,
        converged: result.converged,
        dbi_score: dbiString === null ? null : new Prisma.Decimal(dbiString),
        started_at: now,
        completed_at: now,
        created_at: now,
        updated_at: now,
      },
    });

    for (const iteration of result.iterations) {
      const iterRow = await tx.kmeans_iteration.create({
        data: {
          kmeans_run_id: created.id,
          iteration_number: iteration.number,
          is_converged: iteration.moves === 0,
          created_at: now,
        },
      });
      await tx.centroid.createMany({
        data: iteration.centroids.map((centroidVector, clusterIndex) => ({
          kmeans_iteration_id: iterRow.id,
          cluster_code: String(clusterIndex),
          ...Object.fromEntries(FEATURE_ORDER.map((key, featureIndex) => [key, centroidVector[featureIndex]])),
          created_at: now,
        })),
      });
      await tx.cluster_assignment.createMany({
        data: iteration.assignments.map((clusterCode, pointIndex) => ({
          kmeans_iteration_id: iterRow.id,
          siswa_periode_id: rows[pointIndex].siswa_periode_id,
          cluster_code: String(clusterCode),
          nearest_distance: new Prisma.Decimal(result.distances[pointIndex]),
          created_at: now,
        })),
      });
    }

    await tx.cluster_result.createMany({
      data: result.finalAssignments.map((clusterCode, pointIndex) => ({
        kmeans_run_id: created.id,
        siswa_periode_id: rows[pointIndex].siswa_periode_id,
        cluster_code: String(clusterCode),
        distance: new Prisma.Decimal(result.distances[pointIndex]),
        created_at: now,
      })),
    });
    return created;
  });

  return getLatestKmeansRun(periodId !== undefined ? periodId : undefined, run.id);
}

// Rakit response lengkap run terbaru: summary + iterations (moves/movers) + assignments final.
async function buildRunResponse(run) {
  const iterations = await prisma.kmeans_iteration.findMany({
    where: { kmeans_run_id: run.id },
    orderBy: { iteration_number: 'asc' },
    include: { cluster_assignment: { select: { siswa_periode_id: true, cluster_code: true } } },
  });
  const results = await prisma.cluster_result.findMany({
    where: { kmeans_run_id: run.id },
    include: { siswa_periode: { include: { siswa: { select: { nis: true, nama: true } } } } },
    orderBy: { id: 'asc' },
  });
  // Satu fetch siswa utk semua lookup movers + assignments (key = String(siswa_periode_id)).
  const studentById = new Map(
    results.map((r) => [String(r.siswa_periode_id), r.siswa_periode])
  );

  let prevAssign = null;
  const iterationPayload = iterations.map((iteration) => {
    const currentAssign = new Map(
      iteration.cluster_assignment.map((a) => [String(a.siswa_periode_id), Number(a.cluster_code)])
    );
    const moves = prevAssign === null
      ? currentAssign.size
      : [...currentAssign.entries()].filter(([sid, code]) => prevAssign.get(sid) !== code).length;
    const movers = prevAssign === null ? [] : [...currentAssign.entries()]
      .filter(([sid, code]) => prevAssign.get(sid) !== code)
      .map(([sid, code]) => {
        const student = studentById.get(sid);
        return {
          nis: student?.siswa?.nis ?? null,
          nama: student?.siswa?.nama ?? null,
          fromCluster: prevAssign.get(sid),
          toCluster: code,
        };
      });
    prevAssign = currentAssign;
    return { number: iteration.iteration_number, moves, movers };
  });

  const distribution = new Array(10).fill(0);
  const assignments = results.map((r) => {
    const clusterIndex = Number(r.cluster_code);
    distribution[clusterIndex] += 1;
    return {
      nis: r.siswa_periode?.siswa?.nis ?? null,
      nama: r.siswa_periode?.siswa?.nama ?? null,
      kelas: r.siswa_periode?.kelas ?? null,
      clusterIndex,
      distance: decimalTo4(r.distance),
    };
  });

  return {
    runId: toNumber(run.id),
    status: run.status,
    converged: run.converged,
    convergedAt: run.converged ? (run.total_iteration - 1) : null,
    totalIterations: run.total_iteration,
    dbiScore: decimalTo4(run.dbi_score),
    distribution,
    iterations: iterationPayload,
    assignments,
  };
}

// GET /kmeans/runs/latest — 404 Bahasa Indonesia bila belum pernah ada run.
async function getLatestKmeansRun(periodId, preFetchedRun = null) {
  const periode = await resolvePeriode(periodId !== undefined ? periodId : undefined);
  const run = preFetchedRun ?? (await findCompletedRun(periode.id));
  if (!run) throw new ApiError(404, 'Belum ada run K-Means pada periode ini.');
  return buildRunResponse(run);
}

// GET /kmeans/runs/latest/iterations/:n/centroids — 10 baris x 25 fitur (string 4 desimal, lazy accordion).
async function getIterationCentroids(periodId, iterationNumber) {
  const periode = await resolvePeriode(periodId !== undefined ? periodId : undefined);
  const run = await findCompletedRun(periode.id);
  if (!run) throw new ApiError(404, 'Belum ada run K-Means pada periode ini.');
  const iteration = await prisma.kmeans_iteration.findUnique({
    where: { id: (await prisma.kmeans_iteration.findFirstOrThrow({
      where: { kmeans_run_id: run.id, iteration_number: iterationNumber },
      select: { id: true },
    })).id },
    include: { centroid: { orderBy: { cluster_code: 'asc' } } },
  });
  return {
    iterationNumber,
    centroids: iteration.centroid.map((centroid) => ({
      clusterIndex: Number(centroid.cluster_code),
      features: Object.fromEntries(FEATURE_ORDER.map((key) => [key, decimalTo4(centroid[key])])),
    })),
  };
}

module.exports = { executeKmeansRun, getLatestKmeansRun, getIterationCentroids, _internals: { findCompletedRun } };
