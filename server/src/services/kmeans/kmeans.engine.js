// Engine K-Means Lloyd murni (tanpa Prisma/HTTP) - TIKET BE-KM-1.
// Seed centroid & urutan fitur DIIMPOR dari kmeans.seed.js (DILARANG duplikat).
// Internal float64; konversi Decimal(8,4) HALF_UP hanya di lapisan DBI.

'use strict';

const { SEED_CENTROIDS, FEATURE_ORDER } = require('./kmeans.seed');

const DIM = FEATURE_ORDER.length; // 25

// Jarak Euclidean antar vektor berdimensi sama.
function euclid(a, b) {
  let sum = 0;
  for (let f = 0; f < a.length; f++) {
    const d = a[f] - b[f];
    sum += d * d;
  }
  return Math.sqrt(sum);
}

// Ambil vektor fitur baris: array numerik langsung, atau objek ber-key FEATURE_ORDER.
function toVector(row) {
  if (Array.isArray(row)) {
    if (row.length !== DIM) throw new Error(`baris array harus ${DIM} fitur`);
    return row.map(Number);
  }
  return FEATURE_ORDER.map((key) => Number(row[key]));
}

// Cari centroid terdekat; tie-break: indeks (kode) cluster terkecil menang.
function nearestCentroid(vec, centroids) {
  let best = 0;
  let bestDist = Infinity;
  for (let c = 0; c < centroids.length; c++) {
    const dist = euclid(vec, centroids[c]);
    if (dist < bestDist) {
      bestDist = dist;
      best = c;
    }
  }
  return { code: best, dist: bestDist };
}

/**
 * Lloyd murni deterministik.
 * @param {Array<Array<number>|Object>} rows titik data (fitur sesuai FEATURE_ORDER).
 * @param {{k?:number, maxIter?:number, seed?:number[][]}} opts
 * @returns iterations[{number(0-based), assignments, moves, centroids}], finalAssignments,
 *          distances, distribution[k], converged, convergedAt.
 */
function runKMeans(rows, opts = {}) {
  const k = opts.k ?? SEED_CENTROIDS.length;
  const maxIter = opts.maxIter ?? 50;
  const seed = opts.seed ?? SEED_CENTROIDS;
  if (!Number.isInteger(k) || k < 1 || k > seed.length) throw new Error('k tidak valid');
  if (!Array.isArray(rows) || rows.length === 0) throw new Error('rows kosong');

  const vectors = rows.map(toVector);
  let centroids = seed.slice(0, k).map((c) => c.slice());
  let prevAssign = null;
  let lastDistances = [];
  const iterations = [];
  let converged = false;
  let convergedAt = null;

  for (let it = 0; it <= maxIter; it++) {
    // ASSIGN: setiap titik -> centroid terdekat.
    const assignments = new Array(vectors.length);
    const distances = new Array(vectors.length);
    for (let i = 0; i < vectors.length; i++) {
      const near = nearestCentroid(vectors[i], centroids);
      assignments[i] = near.code;
      distances[i] = near.dist;
    }
    // MOVES vs assignment sebelumnya (iterasi 0: semua baris dianggap pindah).
    const moves = prevAssign === null
      ? assignments.length
      : assignments.reduce((m, a, i) => m + (a !== prevAssign[i] ? 1 : 0), 0);

    iterations.push({ number: it, assignments, moves, centroids: centroids.map((c) => c.slice()) });
    lastDistances = distances;
    if (moves === 0) {
      converged = true;
      convergedAt = it;
      break;
    }
    prevAssign = assignments;

    // UPDATE: centroid = rata-rata anggota; cluster kosong -> centroid lama dipertahankan.
    const sums = centroids.map(() => new Array(DIM).fill(0));
    const counts = new Array(k).fill(0);
    for (let i = 0; i < vectors.length; i++) {
      const c = assignments[i];
      counts[c]++;
      for (let f = 0; f < DIM; f++) sums[c][f] += vectors[i][f];
    }
    centroids = centroids.map((old, c) =>
      counts[c] === 0 ? old.slice() : sums[c].map((s) => s / counts[c]));
  }

  const last = iterations[iterations.length - 1];
  const distribution = new Array(k).fill(0);
  for (const a of last.assignments) distribution[a]++;

  return {
    iterations,
    finalAssignments: last.assignments,
    distances: lastDistances, // jarak titik ke centroid terpilih pada iterasi terakhir
    distribution,
    converged,
    convergedAt,
  };
}

module.exports = { runKMeans, euclid, nearestCentroid };
