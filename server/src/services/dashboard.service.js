const prisma = require('../lib/prisma');

// Status netral ketika belum pernah ada run sama sekali (kontrak FE FR-B03).
const BELUM_ADA = 'BELUM_ADA';

// RULE WAJIB: BigInt -> Number di semua response (FR-B03).
function toNumber(value) {
  if (value === null || value === undefined) return null;
  return Number(value);
}

// Ringkasan periode aktif untuk kartu header dashboard.
function mapPeriode(periode) {
  return {
    id: toNumber(periode.id),
    tahunAjaran: periode.tahunAjaran,
    semester: periode.semester,
    namaPeriode: periode.namaPeriode,
    status: periode.status,
  };
}

// GET /api/dashboard — ringkasan Screen 2 (FR-B03).
async function getDashboardSummary() {
  // 1. Periode aktif ('AKTIF') | null.
  const periodeAktifRow = await prisma.periode.findFirst({
    where: { status: 'AKTIF' },
  });

  if (!periodeAktifRow) {
    return {
      periodeAktif: null,
      totalSiswa: 0,
      preprocessingStatus: BELUM_ADA,
      kmeansStatus: BELUM_ADA,
      jumlahCluster: 0,
      recentRuns: [],
    };
  }

  const periodeAktif = mapPeriode(periodeAktifRow);

  // 2. totalSiswa = count siswa_periode pada periode itu.
  const totalSiswa = await prisma.siswa_periode.count({
    where: { periode_id: periodeAktifRow.id },
  });

  // 3. preprocessingStatus = status preprocessing_run terakhir periode.
  const lastPreprocessing = await prisma.preprocessing_run.findFirst({
    where: { periode_id: periodeAktifRow.id },
    orderBy: [{ started_at: 'desc' }, { id: 'desc' }],
    select: { status: true },
  });

  // 4. kmeansStatus + jumlahCluster dari kmeans_run terakhir periode itu.
  const lastKmeans = await prisma.kmeans_run.findFirst({
    where: { preprocessing_run: { periode_id: periodeAktifRow.id } },
    orderBy: [{ started_at: 'desc' }, { id: 'desc' }],
    select: { id: true, status: true },
  });

  let jumlahCluster = 0;
  if (lastKmeans) {
    const distinctClusters = await prisma.cluster_result.findMany({
      where: { kmeans_run_id: lastKmeans.id, cluster_code: { not: null } },
      distinct: ['cluster_code'],
      select: { cluster_code: true },
    });
    jumlahCluster = distinctClusters.length;
  }

  // 5. recentRuns = 5 kmeans_run terakhir periode aktif.
  const recentRunsRows = await prisma.kmeans_run.findMany({
    where: { preprocessing_run: { periode_id: periodeAktifRow.id } },
    orderBy: [{ started_at: 'desc' }, { id: 'desc' }],
    take: 5,
    select: { id: true, status: true, started_at: true, completed_at: true },
  });

  const recentRuns = recentRunsRows.map((run) => ({
    id: toNumber(run.id),
    status: run.status ?? BELUM_ADA,
    startedAt: run.started_at,
    completedAt: run.completed_at,
  }));

  return {
    periodeAktif,
    totalSiswa: toNumber(totalSiswa),
    preprocessingStatus: lastPreprocessing?.status ?? BELUM_ADA,
    kmeansStatus: lastKmeans?.status ?? BELUM_ADA,
    jumlahCluster,
    recentRuns,
  };
}

module.exports = { getDashboardSummary };
