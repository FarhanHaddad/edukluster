// Engine K-Means Lloyd murni (tanpa Prisma/HTTP) - TIKET BE-KM-1.
// Seed centroid & urutan fitur DIIMPOR dari kmeans.seed.js (DILARANG duplikat).
// Internal float64; konversi Decimal(8,4) HALF_UP hanya di lapisan DBI.
// Refactor readability BE-KM-1.5: tanpa variabel 1 huruf, ZERO perubahan logika.

'use strict';

const { SEED_CENTROIDS, FEATURE_ORDER } = require('./kmeans.seed');

const DIM = FEATURE_ORDER.length; // 25

/**
 * Jarak Euclidean antar dua vektor berdimensi sama.
 * @param {number[]} leftVector vektor kiri.
 * @param {number[]} rightVector vektor kanan.
 * @returns {number} jarak Euclidean (float64).
 */
function euclid(leftVector, rightVector) {
  let squaredDistanceSum = 0;
  for (let featureIndex = 0; featureIndex < leftVector.length; featureIndex++) {
    const coordinateDelta = leftVector[featureIndex] - rightVector[featureIndex];
    squaredDistanceSum += coordinateDelta * coordinateDelta;
  }
  return Math.sqrt(squaredDistanceSum);
}

// Ambil vektor fitur baris: array numerik langsung, atau objek ber-key FEATURE_ORDER.
function toVector(row) {
  if (Array.isArray(row)) {
    if (row.length !== DIM) throw new Error(`baris array harus ${DIM} fitur`);
    return row.map(Number);
  }
  return FEATURE_ORDER.map((featureKey) => Number(row[featureKey]));
}

/**
 * Cari centroid terdekat; tie-break: indeks (kode) cluster terkecil menang
 * (perbandingan ketat "<" menjaga kandidat berindeks terkecil tetap unggul).
 * @param {number[]} featureVector vektor titik data.
 * @param {number[][]} centroids daftar centroid per cluster.
 * @returns {{code:number, dist:number}} kode cluster pemenang & jaraknya.
 */
function nearestCentroid(featureVector, centroids) {
  let bestClusterIndex = 0;
  let bestDistance = Infinity;
  for (let clusterIndex = 0; clusterIndex < centroids.length; clusterIndex++) {
    const candidateDistance = euclid(featureVector, centroids[clusterIndex]);
    if (candidateDistance < bestDistance) {
      bestDistance = candidateDistance;
      bestClusterIndex = clusterIndex;
    }
  }
  return { code: bestClusterIndex, dist: bestDistance };
}

/**
 * Lloyd murni deterministik.
 * @param {Array<Array<number>|Object>} rows titik data (fitur sesuai FEATURE_ORDER).
 * @param {{k?:number, maxIter?:number, seed?:number[][]}} opts
 *        k = totalClusters (default panjang seed), maxIter default 50, seed default SEED_CENTROIDS.
 * @returns iterations[{number(0-based), assignments, moves, centroids}], finalAssignments,
 *          distances, distribution[totalClusters], converged, convergedAt.
 */
function runKMeans(rows, opts = {}) {
  const totalClusters = opts.k ?? SEED_CENTROIDS.length;
  const maxIter = opts.maxIter ?? 50;
  const seed = opts.seed ?? SEED_CENTROIDS;
  if (!Number.isInteger(totalClusters) || totalClusters < 1 || totalClusters > seed.length) {
    throw new Error('k tidak valid');
  }
  if (!Array.isArray(rows) || rows.length === 0) throw new Error('rows kosong');

  const vectors = rows.map(toVector);
  let centroids = seed.slice(0, totalClusters).map((seedRow) => seedRow.slice());
  let prevAssign = null;
  let lastDistances = [];
  const iterations = [];
  let converged = false;
  let convergedAt = null;

  for (let iterationNumber = 0; iterationNumber <= maxIter; iterationNumber++) {
    // ASSIGN: setiap titik -> centroid terdekat.
    const assignments = new Array(vectors.length);
    const distances = new Array(vectors.length);
    for (let pointIndex = 0; pointIndex < vectors.length; pointIndex++) {
      const nearest = nearestCentroid(vectors[pointIndex], centroids);
      assignments[pointIndex] = nearest.code;
      distances[pointIndex] = nearest.dist;
    }
    // MOVES vs assignment sebelumnya (iterasi 0: semua baris dianggap pindah).
    const moves = prevAssign === null
      ? assignments.length
      : assignments.reduce(
          (moveCount, assignedCluster, pointIndex) =>
            moveCount + (assignedCluster !== prevAssign[pointIndex] ? 1 : 0),
          0,
        );

    iterations.push({
      number: iterationNumber,
      assignments,
      moves,
      centroids: centroids.map((centroidRow) => centroidRow.slice()),
    });
    lastDistances = distances;
    if (moves === 0) {
      converged = true;
      convergedAt = iterationNumber;
      break;
    }
    prevAssign = assignments;

    // UPDATE: centroid = rata-rata anggota; cluster kosong -> centroid lama dipertahankan.
    const coordinateSums = centroids.map(() => new Array(DIM).fill(0));
    const memberCounts = new Array(totalClusters).fill(0);
    for (let pointIndex = 0; pointIndex < vectors.length; pointIndex++) {
      const assignedCluster = assignments[pointIndex];
      memberCounts[assignedCluster]++;
      for (let featureIndex = 0; featureIndex < DIM; featureIndex++) {
        coordinateSums[assignedCluster][featureIndex] += vectors[pointIndex][featureIndex];
      }
    }
    centroids = centroids.map((oldCentroid, clusterIndex) =>
      memberCounts[clusterIndex] === 0
        ? oldCentroid.slice()
        : coordinateSums[clusterIndex].map((coordinateSum) =>
            coordinateSum / memberCounts[clusterIndex]));
  }

  const lastIteration = iterations[iterations.length - 1];
  const distribution = new Array(totalClusters).fill(0);
  for (const assignedCluster of lastIteration.assignments) distribution[assignedCluster]++;

  return {
    iterations,
    finalAssignments: lastIteration.assignments,
    distances: lastDistances, // jarak titik ke centroid terpilih pada iterasi terakhir
    distribution,
    converged,
    convergedAt,
  };
}

module.exports = { runKMeans, euclid, nearestCentroid };
