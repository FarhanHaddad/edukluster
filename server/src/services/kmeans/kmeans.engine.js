// Engine K-Means Lloyd murni (tanpa Prisma/HTTP) - TIKET BE-KM-1.
// Index baris seed & urutan fitur DIIMPOR dari kmeans.seed.js (DILARANG duplikat/hardcode angka).
// Rezim presisi TERKUNCI MODE A (TIKET BE-KM-3, bridge kmeans.regime.bridge.js): setiap koordinat
// centroid hasil UPDATE dibulatkan HALF_UP ke PRECISION_REGIME.decimals desimal SEBELUM dipakai
// iterasi berikutnya dan sebelum dikembalikan; jarak dihitung presisi penuh dari operand tsb lalu
// dibulatkan pada output distances; seed = baris tersimpan apa adanya; DILARANG rounding di tengah
// akumulasi mean (bulatkan hanya di batas: setelah pembagian rata-rata selesai).
// HASIL BRIDGE BE-KM-3: MODE A (4dp), MODE B (presisi penuh, bulat hanya boundary simpan/display),
// dan MODE C (3dp) menghasilkan trajectory IDENTIK [105,16,10,5,1,0] convergedAt 5 distribusi
// [3,3,23,3,14,26,5,12,9,7] -> TIDAK ADA mode yang mereproduksi oracle Excel skripsi
// ([105,14,7,2,0], convergedAt 4, [3,3,22,5,14,26,5,12,8,7]). Sesuai AC: STOP & LAPOR; engine
// TIDAK diubah perilakunya (tetap Mode A sebagai rezim produksi default sampai Owner menindaklanjuti
// laporan input). Variabel PRECISION_REGIME di bawah adalah satu-satunya tuas regime untuk
// eksperimen QA lanjutan; perubahan nilai desimal tidak mengubah hasil pada fixture 105 baris.
// Refactor readability BE-KM-1.5: tanpa variabel 1 huruf, ZERO perubahan logika.
// Refactor seed BE-KM-1.6: centroid awal DIEKSTRAK DINAMIS dari baris dataset (anti precision drift).

'use strict';

const { SEED_ROW_INDICES, FEATURE_ORDER } = require('./kmeans.seed');

const DIM = FEATURE_ORDER.length; // 25

// ---- TIKET BE-KM-3: presisi regime TERKUNCI.
// Hasil bridge (lihat header): Mode A/B/C menghasilkan trajectory yang sama pada fixture
// reduced_data 105 baris, sehingga pembulatan intermediat BUKAN penyebab selisih vs oracle
// Excel. Keputusan: kunci rezim produksi = MODE A (intermediat HALF_UP 4 desimal), nilai lama,
// nol perubahan perilaku. `decimals: null` berarti presisi penuh (Mode B) — hanya untuk QA.
const PRECISION_REGIME = Object.freeze({ mode: 'A', decimals: 4 });

// Bulatkan HALF_UP ke PRECISION_REGIME.decimals desimal (default 4, rezim R-KM-36/BE-KM-3).
// Epsilon EPSILON*|scaled| mengoreksi representasi biner float (mis. 0.1505*10^4 -> 1504.9999...)
// agar tepat setengah naik. decimals=null -> tanpa pembulatan (presisi penuh, Mode B/QA).
function roundRegime(value, decimals = PRECISION_REGIME.decimals) {
  if (!Number.isFinite(value) || decimals === null) return value;
  const factor = 10 ** decimals;
  const scaled = value * factor;
  return Math.round(scaled + Number.EPSILON * Math.abs(scaled)) / factor;
}

// Nama historis tetap diekspor (dipakai test/service); identik dengan roundRegime default 4dp.
const round4 = roundRegime;

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
 * Ekstraksi centroid awal secara DINAMIS dari baris dataset (BE-KM-1.6).
 * Mencegah "precision drift": TIDAK ada angka hardcoded, vektor siswa dibaca
 * langsung dari rows via toVector() lalu di-clone.
 * @param {Array<Array<number>|Object>} vectors daftar vektor fitur seluruh baris.
 * @param {number[]} seedRowIndices index baris 1-based (urutan siswa ke-N).
 * @returns {number[][]} matriks centroid awal (clone dari vektor dataset).
 */
function extractSeedCentroids(vectors, seedRowIndices) {
  return seedRowIndices.map((oneBasedIndex) => {
    const zeroBasedIndex = oneBasedIndex - 1;
    if (!Number.isInteger(zeroBasedIndex) || zeroBasedIndex < 0 || zeroBasedIndex >= vectors.length) {
      throw new Error(`seed row index ${oneBasedIndex} (1-based) out-of-bounds: dataset hanya ${vectors.length} baris`);
    }
    return vectors[zeroBasedIndex].slice();
  });
}

/**
 * Lloyd murni deterministik.
 * @param {Array<Array<number>|Object>} rows titik data (fitur sesuai FEATURE_ORDER).
 * @param {{k?:number, maxIter?:number, seedIndices?:number[], customSeedMatrix?:number[][]}} opts
 *        k = totalClusters (default panjang seed), maxIter default 50,
 *        seedIndices = index baris 1-based sumber centroid (default SEED_ROW_INDICES),
 *        customSeedMatrix = matriks seed eksplisit (khusus injeksi unit test; menang atas seedIndices).
 * @returns iterations[{number(0-based), assignments, moves, centroids}], finalAssignments,
 *          distances, distribution[totalClusters], converged, convergedAt.
 */
function runKMeans(rows, opts = {}) {
  const maxIter = opts.maxIter ?? 50;
  const seedRowIndices = opts.seedIndices ?? SEED_ROW_INDICES;
  if (!Array.isArray(rows) || rows.length === 0) throw new Error('rows kosong');

  const vectors = rows.map(toVector);
  // Inisialisasi centroid: matrix custom (test) -> pakai apa adanya;
  // selain itu -> ekstrak dinamis dari baris dataset pada seedRowIndices.
  const seedCentroids = opts.customSeedMatrix !== undefined
    ? opts.customSeedMatrix.map((seedRow) => seedRow.slice())
    : extractSeedCentroids(vectors, seedRowIndices);

  const totalClusters = opts.k ?? seedCentroids.length;
  if (!Number.isInteger(totalClusters) || totalClusters < 1 || totalClusters > seedCentroids.length) {
    throw new Error('k tidak valid');
  }

  let centroids = seedCentroids.slice(0, totalClusters).map((seedRow) => seedRow.slice());
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
      // Jarak: presisi penuh dari operand 4-desimal, dibulatkan HALF_UP 4 desimal di output.
      distances[pointIndex] = round4(nearest.dist);
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
            // Batas round-before-use (R-KM-36): akumulasi mean presisi penuh,
            // pembulatan HALF_UP 4 dp HANYA setelah pembagian selesai.
            round4(coordinateSum / memberCounts[clusterIndex])));
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

module.exports = { runKMeans, euclid, nearestCentroid, round4, roundRegime, PRECISION_REGIME };
