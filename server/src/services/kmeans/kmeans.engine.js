// Engine K-Means Lloyd murni (tanpa Prisma/HTTP) - TIKET BE-KM-1.
// Index baris seed & urutan fitur DIIMPOR dari kmeans.seed.js (DILARANG duplikat/hardcode angka).
// Rezim presisi TERKUNCI MODE D (R-KM-36 v3, TIKET BE-KM-6 — produksi = rezim manual terdokumentasi):
// pada fase ASSIGN, jarak Euclidean yang DIBANDINGKAN, menang tie-break, dan DISIMPAN adalah
// roundRegime(sqrt(...)) HALF_UP 4 dp SEGERA setelah sqrt (persis rumus kolom jarak Excel Owner);
// setiap koordinat centroid hasil UPDATE tetap dibulatkan HALF_UP ke PRECISION_REGIME.decimals
// desimal di batas (setelah pembagian rata-rata selesai) sebelum dipakai iterasi berikutnya;
// seed = baris tersimpan apa adanya; DILARANG rounding di tengah akumulasi mean.
// SEJARAH MODE A (BE-KM-3): centroid bulat 4dp di batas, jarak presisi penuh saat perbandingan,
// bulat hanya di output distances. HASIL BRIDGE (kmeans.regime.bridge.js, fixture reduced_data
// 105 baris server/DB/edukluster_widuri.sql): Mode A == Mode D == ORACLE_MANUAL Owner
// moves=[105,15,5,4,2,2,1,1,0] convergedAt=8 totalIterations=9 distribusi=[10,1,14,3,14,28,5,13,9,8]
// -> nol divergensi penempatan pada dataset periode berjalan; penguncian Mode D membuat label
// rezim jujur terhadap formula-bar Excel tanpa mengubah trajectory. Mode A tinggal sebagai
// jalur QA (opts.qaMode === 'A') dan instrumen bridge tiap dataset periode baru.
// Variabel PRECISION_REGIME di bawah adalah satu-satunya tuas regime; decimals=null berarti
// presisi penuh (Mode B/QA) — DILARANG untuk produksi.
// Refactor readability BE-KM-1.5: tanpa variabel 1 huruf, ZERO perubahan logika.
// Refactor seed BE-KM-1.6: centroid awal DIEKSTRAK DINAMIS dari baris dataset (anti precision drift).

'use strict';

const { SEED_ROW_INDICES, FEATURE_ORDER } = require('./kmeans.seed');

const DIM = FEATURE_ORDER.length; // 25

// ---- TIKET BE-KM-6 (R-KM-36 v3): presisi regime TERKUNCI MODE D = rezim manual Excel Owner.
// Bridge BE-KM-5/BE-KM-6 pada fixture reduced_data 105 baris: Mode A == Mode D == ORACLE_MANUAL
// (moves [105,15,5,4,2,2,1,1,0], convergedAt 8, distribusi [10,1,14,3,14,28,5,13,9,8]) — nol
// divergensi penempatan pada dataset periode berjalan. Penguncian ke 'D' membuat perilaku produksi
// secara eksplisit membulat jarak di titik perbandingan (persis formula-bar), bukan sekadar kebetulan
// identik. `decimals: null` berarti presisi penuh (Mode B) — hanya untuk QA, DILARANG produksi.
const PRECISION_REGIME = Object.freeze({ mode: 'D', decimals: 4 });

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
 * Rezim produksi MODE D (R-KM-36 v3): hasil sqrt dibulatkan HALF_UP 4 dp SEGERA setelah sqrt —
 * nilai bulat itulah yang dibandingkan, menang tie-break, dan disimpan (persis rumus Excel Owner).
 * @param {number[]} leftVector vektor kiri.
 * @param {number[]} rightVector vektor kanan.
 * @param {boolean} [roundAtSqrt=true] false = presisi penuh di sqrt (jalur QA Mode A / bridge).
 * @returns {number} jarak sesuai rezim (float64).
 */
function euclid(leftVector, rightVector, roundAtSqrt = true) {
  let squaredDistanceSum = 0;
  for (let featureIndex = 0; featureIndex < leftVector.length; featureIndex++) {
    const coordinateDelta = leftVector[featureIndex] - rightVector[featureIndex];
    squaredDistanceSum += coordinateDelta * coordinateDelta;
  }
  const rawDistance = Math.sqrt(squaredDistanceSum);
  // Mode D: pembulatan terjadi DI TITIK PERBANDINGAN (setelah sqrt), bukan hanya di output.
  return roundAtSqrt ? roundRegime(rawDistance) : rawDistance;
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
 * @param {boolean} [roundDistance=true] Mode D produksi: jarak yang dibandingkan & disimpan sudah
 *        dibulatkan HALF_UP 4dp di sqrt; false = jalur QA Mode A (presisi penuh saat banding).
 * @returns {{code:number, dist:number}} kode cluster pemenang & jaraknya (sesuai rezim).
 */
function nearestCentroid(featureVector, centroids, roundDistance = true) {
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
 * @param {{k?:number, maxIter?:number, seedIndices?:number[], customSeedMatrix?:number[][], qaMode?:string}} opts
 *        k = totalClusters (default panjang seed), maxIter default 50,
 *        seedIndices = index baris 1-based sumber centroid (default SEED_ROW_INDICES),
 *        customSeedMatrix = matriks seed eksplisit (khusus injeksi unit test; menang atas seedIndices),
 *        qaMode = 'A' -> jalur QA historis Mode A (jarak presisi penuh saat perbandingan); produksi
 *                 TIDAK pernah mengirim opsi ini (default: rezim terkunci Mode D).
 * @returns iterations[{number(0-based), assignments, moves, centroids}], finalAssignments,
 *          distances, distribution[totalClusters], converged, convergedAt.
 */
function runKMeans(rows, opts = {}) {
  const maxIter = opts.maxIter ?? 50;
  const seedRowIndices = opts.seedIndices ?? SEED_ROW_INDICES;
  if (!Array.isArray(rows) || rows.length === 0) throw new Error('rows kosong');

  const vectors = rows.map(toVector);
  // Rezim jarak fase ASSIGN: produksi SELALU Mode D (bulat HALF_UP 4dp segera setelah sqrt).
  // opts.qaMode === 'A' -> jalur QA/bridge historis; tidak pernah dipakai service/controller.
  const roundDistancesAtComparison = opts.qaMode !== 'A';
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
      const nearest = nearestCentroid(vectors[pointIndex], centroids, roundDistancesAtComparison);
      assignments[pointIndex] = nearest.code;
      // Mode D produksi: nearest.dist SUDAH dibulatkan HALF_UP 4dp segera setelah sqrt (di titik
      // perbandingan) — round4 di bawah idempoten. Jalur QA Mode A: presisi penuh -> bulat di output.
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
            // Batas round-before-use (R-KM-36 v3): akumulasi mean presisi penuh,
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
