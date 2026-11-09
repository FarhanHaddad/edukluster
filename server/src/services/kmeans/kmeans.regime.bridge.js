// QA-ONLY bridge rezim presisi — TIKET BE-KM-5 (Mode D). TIDAK di-require route/service mana pun.
// Jalankan: node server/src/services/kmeans/kmeans.regime.bridge.js
// Bandingkan pada fixture reduced_data 105 baris (server/DB/edukluster_widuri.sql, ORDER BY id ASC):
//   MODE A = perilaku engine produksi SEKARANG: centroid hasil update dibulatkan HALF_UP 4 dp di
//            batas; jarak dihitung presisi penuh dari operand tsb saat perbandingan (tanpa bulat).
//   MODE D = rezim manual Owner: jarak EUCLIDEAN dibulatkan HALF_UP 4 dp SEGERA setelah sqrt; nilai
//            bulat itu yang dipakai penempatan cluster (perbandingan & tie-break) DAN yang disimpan;
//            centroid tetap rata-rata anggota -> dibulatkan HALF_UP 4 dp (sama seperti Mode A).
// Cetak per mode: moves[], convergedAt, totalIterations, distribution[10]. Tidak mengubah engine.
'use strict';

const fs = require('fs');
const path = require('path');
const { SEED_ROW_INDICES, FEATURE_ORDER } = require('./kmeans.seed');

const DIM = FEATURE_ORDER.length; // 25
const DECIMALS = 4;

// Bulatkan HALF_UP ke `decimals` desimal; epsilon mengoreksi representasi biner float (identik round4 engine).
function roundHalfUp(value, decimals = DECIMALS) {
  if (!Number.isFinite(value)) return value;
  const factor = 10 ** decimals;
  const scaled = value * factor;
  return Math.round(scaled + Number.EPSILON * Math.abs(scaled)) / factor;
}

// ---- Muat fixture: blok INSERT INTO `reduced_data` ... VALUES (...),(...); dari dump SQL.
function loadFixtureRows() {
  const sqlPath = process.env.KMEANS_FIXTURE_SQL
    || path.resolve(__dirname, '../../../DB/edukluster_widuri.sql');
  const sqlDump = fs.readFileSync(sqlPath, 'utf8');
  const insertMatch = sqlDump.match(/INSERT INTO `reduced_data` \([^)]*\) VALUES\n([\s\S]*?);\n/);
  if (!insertMatch) throw new Error('blok INSERT reduced_data tidak ditemukan di dump SQL');
  const rows = [];
  for (const rawLine of insertMatch[1].split('\n')) {
    const line = rawLine.trim().replace(/,$/, '');
    if (!line.startsWith('(')) continue;
    const fields = line.slice(1, -1).split(',').map((field) => field.trim());
    // fields[0]=id, fields[1]=preprocessing_run_id, fields[2]=siswa_periode_id, fields[3..27]=25 fitur.
    rows.push({ id: Number(fields[0]), features: fields.slice(3, 28).map(Number) });
  }
  rows.sort((left, right) => left.id - right.id); // urutan kanonik ORDER BY id ASC
  return rows.map((row) => row.features);
}

// Jarak Euclidean; bila roundDistance=true, hasil sqrt dibulatkan HALF_UP 4 dp SEGERA setelah sqrt.
function euclid(leftVector, rightVector, roundDistance) {
  let squaredDistanceSum = 0;
  for (let featureIndex = 0; featureIndex < leftVector.length; featureIndex++) {
    const coordinateDelta = leftVector[featureIndex] - rightVector[featureIndex];
    squaredDistanceSum += coordinateDelta * coordinateDelta;
  }
  const rawDistance = Math.sqrt(squaredDistanceSum);
  return roundDistance ? roundHalfUp(rawDistance) : rawDistance;
}

// Nearest centroid; tie-break ketat "<" -> indeks cluster terkecil menang (identik kedua mode).
function nearestCentroid(featureVector, centroids, roundDistance) {
  let bestClusterIndex = 0;
  let bestDistance = Infinity;
  for (let clusterIndex = 0; clusterIndex < centroids.length; clusterIndex++) {
    const candidateDistance = euclid(featureVector, centroids[clusterIndex], roundDistance);
    if (candidateDistance < bestDistance) {
      bestDistance = candidateDistance;
      bestClusterIndex = clusterIndex;
    }
  }
  return { code: bestClusterIndex, dist: bestDistance };
}

// Lloyd deterministik generik. roundDistancesAtComparison=true -> MODE D; false -> MODE A.
// Mengembalikan juga assignment per iterasi utk analisis divergensi antar mode.
function runLloydDetailed(vectors, roundDistancesAtComparison, maxIter = 50) {
  const centroids = SEED_ROW_INDICES.map((oneBasedIndex) => vectors[oneBasedIndex - 1].slice());
  const totalClusters = centroids.length;
  let prevAssign = null;
  const moves = [];
  const assignmentsByIteration = [];
  let convergedAt = null;
  for (let iterationNumber = 0; iterationNumber <= maxIter; iterationNumber++) {
    const assignments = vectors.map((vector) => nearestCentroid(vector, centroids, roundDistancesAtComparison).code);
    const moveCount = prevAssign === null
      ? assignments.length
      : assignments.reduce((count, assignedCluster, pointIndex) =>
          count + (assignedCluster !== prevAssign[pointIndex] ? 1 : 0), 0);
    moves.push(moveCount);
    assignmentsByIteration.push(assignments);
    prevAssign = assignments;
    if (moveCount === 0) { convergedAt = iterationNumber; break; }
    const coordinateSums = centroids.map(() => new Array(DIM).fill(0));
    const memberCounts = new Array(totalClusters).fill(0);
    assignments.forEach((assignedCluster, pointIndex) => {
      memberCounts[assignedCluster] += 1;
      for (let featureIndex = 0; featureIndex < DIM; featureIndex++) {
        coordinateSums[assignedCluster][featureIndex] += vectors[pointIndex][featureIndex];
      }
    });
    centroids.forEach((oldCentroid, clusterIndex) => {
      if (memberCounts[clusterIndex] === 0) return;
      for (let featureIndex = 0; featureIndex < DIM; featureIndex++) {
        oldCentroid[featureIndex] = roundHalfUp(coordinateSums[clusterIndex][featureIndex] / memberCounts[clusterIndex]);
      }
    });
  }
  const finalAssignments = assignmentsByIteration[assignmentsByIteration.length - 1];
  const distribution = new Array(totalClusters).fill(0);
  for (const assignedCluster of finalAssignments) distribution[assignedCluster] += 1;
  return { moves, convergedAt, totalIterations: moves.length, distribution, assignmentsByIteration };
}

// Baris siswa (1-based, urutan id fixture) yang PERTAMA KALI berbeda penempatannya antar dua mode.
function firstDivergingRows(resultA, resultD, limit = 3) {
  const out = [];
  const pointCount = resultA.assignmentsByIteration[0].length;
  for (let pointIndex = 0; pointIndex < pointCount && out.length < limit; pointIndex++) {
    for (let iterationNumber = 0; iterationNumber < resultA.assignmentsByIteration.length; iterationNumber++) {
      const assignA = resultA.assignmentsByIteration[iterationNumber][pointIndex];
      const assignD = resultD.assignmentsByIteration[iterationNumber][pointIndex];
      if (assignA !== assignD) {
        out.push(`siswa#${pointIndex + 1} iter${iterationNumber}: A=C${assignA + 1} vs D=C${assignD + 1}`);
        break;
      }
    }
  }
  return out;
}

function printResult(modeLabel, result) {
  console.log(`[${modeLabel}] moves=[${result.moves.join(',')}] ` +
    `convergedAt=${result.convergedAt} totalIterations=${result.totalIterations} ` +
    `distribution=[${result.distribution.join(',')}]`);
}

function main() {
  const vectors = loadFixtureRows();
  if (vectors.length !== 105) {
    console.error(`STOP: fixture reduced_data = ${vectors.length} baris (HARUS 105).`);
    process.exitCode = 2;
    return;
  }
  console.log(`Fixture reduced_data: ${vectors.length} baris (ORDER BY id ASC), ${DIM} fitur.`);
  const modeA = runLloydDetailed(vectors, false); // Mode A: jarak presisi penuh saat perbandingan
  const modeD = runLloydDetailed(vectors, true);  // Mode D: jarak dibulatkan HALF_UP 4dp segera setelah sqrt
  printResult('MODE A', modeA);
  printResult('MODE D', modeD);
  const divergences = firstDivergingRows(modeA, modeD, 3);
  console.log(divergences.length === 0
    ? '[DIVERGEN] tidak ada perbedaan penempatan intermediate A vs D'
    : `[DIVERGEN] 3 baris batas pertama: ${divergences.join(' | ')}`);
}

if (require.main === module) main();

module.exports = { loadFixtureRows, runLloydDetailed, firstDivergingRows, roundHalfUp };
