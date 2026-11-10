// QA lokal engine K-Means + DBI (TANPA DB/HTTP) - TIKET BE-KM-1.
// Jalankan: node server/src/services/kmeans/kmeans.engine.test.js
// Oracle AC: A (fixture 6 titik), B (tie-break), C (cluster kosong), D (determinisme), E (maxIter),
// F (rezim presisi 4dp R-KM-36), G (TIKET BE-KM-6: rezim produksi TERKUNCI Mode D == ORACLE_MANUAL
// Owner, assert COCOK — bukan lagi STOP&LAPOR).
// Fixture G dimuat dari dump SQL yang ADA di repo: server/DB/edukluster_widuri.sql (blok INSERT
// reduced_data, 105 baris, ORDER BY id ASC). Override path JSON eksplisit tetap didukung:
//   KMEANS_FIXTURE_JSON=/path/rows.json node .../kmeans.engine.test.js
// (JSON = array of arrays numerik per baris, urutan fitur = FEATURE_ORDER kmeans.seed.js).

'use strict';

const { runKMeans } = require('./kmeans.engine');
const { computeDBI } = require('./kmeans.dbi');

let failures = 0;
function check(name, cond, detail) {
  const ok = Boolean(cond);
  if (!ok) failures++;
  console.log(`${ok ? 'PASS' : 'FAIL'} | ${name}${detail !== undefined ? ` | ${detail}` : ''}`);
}

// ---- Helper: pad vektor 2D ke 25 fitur agar kompatibel dgn FEATURE_ORDER.
// Fitur 3..24 diisi konstanta yang sama utk semua titik & seed (tidak memengaruhi jarak relatif).
function pad(vec2, base) {
  const v = vec2.slice();
  for (let f = vec2.length; f < 25; f++) v.push(base[f]);
  return v;
}
// Base 25-dim: nol di sumbu tambahan -> jarak antar titik murni ditentukan koordinat 2D pertama.
const BASE25 = new Array(25).fill(0);
const pts2 = [[0, 0], [0.1, 0], [0, 0.1], [1, 1], [1.1, 1], [1, 1.1]];
const rowsA = pts2.map((p) => pad(p, BASE25));
// Centroid awal fixture A kini DIEKSTRAK DINAMIS dari baris dataset (seedIndices [1,4]
// -> siswa ke-1 = (0,0) dan ke-4 = (1,1)), bukan matrix hardcoded.

// ================= FIXTURE A =================
// 6 baris; seedIndices [1,4] (1-based) -> centroid awal = baris ke-0 (0,0) & ke-3 (1,1).
const resA = runKMeans(rowsA, { k: 2, maxIter: 50, seedIndices: [1, 4] });
check('A.iter0.moves=6', resA.iterations[0].moves === 6, `moves=${resA.iterations[0].moves}`);
check('A.iter1.moves=0', resA.iterations[1] && resA.iterations[1].moves === 0,
  `moves=${resA.iterations[1] ? resA.iterations[1].moves : 'N/A'}`);
check('A.convergedAt=1', resA.converged === true && resA.convergedAt === 1,
  `converged=${resA.converged} convergedAt=${resA.convergedAt}`);
check('A.distribution=[3,3]', JSON.stringify(resA.distribution) === '[3,3]',
  JSON.stringify(resA.distribution));

// DBI dari hasil akhir: kelompokkan titik per assignment final, centroid = centroid iterasi terakhir.
const lastCentroids = resA.iterations[resA.iterations.length - 1].centroids;
// Untuk DBI gunakan centroid TERBARU (rata-rata anggota) sesuai definisi cluster pasca-update.
const clustersA = [[], []];
rowsA.forEach((p, i) => clustersA[resA.finalAssignments[i]].push(p));
const centroidsA = clustersA.map((c, i) =>
  c.length === 0 ? lastCentroids[i]
    : c[0].map((_, f) => c.reduce((s, p) => s + p[f], 0) / c.length));
const dbiA = computeDBI(clustersA, centroidsA);
const dbiNum = Number(dbiA);
check('A.DBI="0.0925"(+-0.0005)', Math.abs(dbiNum - 0.0925) <= 0.0005, `DBI=${dbiA}`);

// ================= FIXTURE B: tie-break equidistant =================
// Titik (0.5,0) equidistant ke seed (0,0) & (1,0) -> harus menang kode terkecil (0).
// Seed bukan baris dataset -> injeksi customSeedMatrix (jalur khusus unit test).
const seedB = [[0, 0, ...BASE25.slice(2)], [1, 0, ...BASE25.slice(2)]];
const resB = runKMeans([pad([0.5, 0], BASE25)], { k: 2, maxIter: 1, customSeedMatrix: seedB });
check('B.tie->kode terkecil', resB.finalAssignments[0] === 0, `assign=${resB.finalAssignments[0]}`);

// ================= FIXTURE C: cluster kosong tidak crash =================
// Semua titik dekat seed0; seed1 jauh -> cluster 1 kosong, centroid lama dipertahankan.
// Seed1 (9,9) TIDAK ada di rowsC -> injeksi customSeedMatrix.
const seedC = [[0, 0, ...BASE25.slice(2)], [9, 9, ...BASE25.slice(2)]];
const rowsC = [pad([0, 0], BASE25), pad([0.1, 0], BASE25), pad([0, 0.1], BASE25)];
let resC, errC = null;
try {
  resC = runKMeans(rowsC, { k: 2, maxIter: 10, customSeedMatrix: seedC });
} catch (e) {
  errC = e;
}
const keptOld = resC && (() => {
  const itLast = resC.iterations[resC.iterations.length - 1];
  // centroid cluster 1 pada iterasi terakhir (setelah update iterasi sebelum itu) == seedC[1]
  return JSON.stringify(itLast.centroids[1]) === JSON.stringify(seedC[1]);
})();
check('C.no-crash', errC === null, errC ? String(errC) : 'ok');
check('C.empty-cluster-centroid-lama', keptOld === true, `kept=${keptOld}`);
check('C.distribution=[3,0]', resC && JSON.stringify(resC.distribution) === '[3,0]',
  resC ? JSON.stringify(resC.distribution) : 'N/A');

// ================= FIXTURE D: determinisme byte-for-byte =================
const resD1 = runKMeans(rowsA, { k: 2, maxIter: 50, seedIndices: [1, 4] });
const resD2 = runKMeans(rowsA, { k: 2, maxIter: 50, seedIndices: [1, 4] });
check('D.deterministik', JSON.stringify(resD1) === JSON.stringify(resD2));

// ================= FIXTURE E: maxIter=3, paksa tak konvergen =================
// Seed kembar (identik) -> tie-break melempar semua ke kode 0; centroid beku memicu
// re-assign berulang -> moves>0 tiap iterasi, tidak konvergen dalam 3 iterasi.
// Seed (0,0) kembar TIDAK bisa dari index baris rowsE yang unik -> customSeedMatrix.
const seedE = [[0, 0, ...BASE25.slice(2)], [0, 0, ...BASE25.slice(2)], [0, 0, ...BASE25.slice(2)]];
const rowsE = [pad([0, 0], BASE25), pad([1, 1], BASE25), pad([4, 4], BASE25)];
const resE = runKMeans(rowsE, { k: 3, maxIter: 3, customSeedMatrix: seedE });
check('E.converged=false', resE.converged === false, `converged=${resE.converged}`);
check('E.iterations<=4', resE.iterations.length <= 4, `len=${resE.iterations.length}`);

// ================= FIXTURE F: rezim presisi 4 desimal R-KM-36 (BE-KM-2 R4) =================
// rows [[0],[1],[3]] k=1 seedIndices [1] -> iterasi 0 moves=3; centroid update = mean(0,1,3)=1.3333
// dibulatkan HALF_UP 4 dp SEBELUM dipakai (round-before-use); distances output semua 4 desimal.
const rowsF = [pad([0], BASE25), pad([1], BASE25), pad([3], BASE25)];
const resF = runKMeans(rowsF, { k: 1, maxIter: 50, seedIndices: [1] });
check('F.iter0.moves=3', resF.iterations[0].moves === 3, `moves=${resF.iterations[0].moves}`);
check('F.iter1.centroid=1.3333 (round-before-use)',
  resF.iterations[1] && resF.iterations[1].centroids[0][0] === 1.3333,
  `c=${resF.iterations[1] ? resF.iterations[1].centroids[0][0] : 'N/A'}`);
const allFourDecimals = resF.distances.every((distanceValue) => {
  const asString = String(distanceValue);
  const dotIndex = asString.indexOf('.');
  return dotIndex === -1 || asString.length - dotIndex - 1 <= 4;
});
check('F.distances<=4dp', allFourDecimals === true, JSON.stringify(resF.distances));
check('F.convergedAt=1', resF.converged === true && resF.convergedAt === 1,
  `converged=${resF.converged} at=${resF.convergedAt}`);

// ================= FIXTURE G: TIKET BE-KM-6 — rezim produksi TERKUNCI Mode D == ORACLE_MANUAL ===
// (1) Regim produksi terkunci Mode D (R-KM-36 v3): jarak dibulatkan HALF_UP 4dp di titik
//     perbandingan (segera setelah sqrt); centroid tetap rata-rata -> bulat 4dp di batas.
const { PRECISION_REGIME } = require('./kmeans.engine');
check('G.rezim TERKUNCI mode D decimals=4',
  PRECISION_REGIME.mode === 'D' && PRECISION_REGIME.decimals === 4,
  JSON.stringify(PRECISION_REGIME));

// (2) Fixture reduced_data 105 baris (dump server/DB/edukluster_widuri.sql; override via
//     env KMEANS_FIXTURE_JSON — lihat header). Bridge QA-only: node kmeans.regime.bridge.js.
function loadReducedFixture() {
  const fs = require('fs');
  const path = require('path');
  const envPath = process.env.KMEANS_FIXTURE_JSON;
  if (envPath) return JSON.parse(fs.readFileSync(envPath, 'utf8')).map((r) => r.map(Number));
  const sqlDump = fs.readFileSync(
    path.resolve(__dirname, '../../../DB/edukluster_widuri.sql'), 'utf8');
  const insertMatch = sqlDump.match(/INSERT INTO `reduced_data` \([^)]*\) VALUES\n([\s\S]*?);\n/);
  if (!insertMatch) return null;
  const rows = [];
  for (const rawLine of insertMatch[1].split('\n')) {
    const line = rawLine.trim().replace(/,$/, '');
    if (!line.startsWith('(')) continue;
    const fields = line.slice(1, -1).split(',').map((f) => f.trim());
    rows.push(fields.slice(3, 28).map(Number));
  }
  return rows;
}
const fixtureG = loadReducedFixture();
if (fixtureG && fixtureG.length === 105) {
  const resG = runKMeans(fixtureG, { k: 10 });
  const movesG = resG.iterations.map((it) => it.moves);
  // ORACLE_MANUAL Owner (dataset synced 2025/2026 Ganjil, verifikasi Mentor sel-per-sel):
  // rezim terkunci Mode D HARUS mereproduksi angka ini persis (assert COCOK, BE-KM-6).
  const ORACLE_MANUAL = {
    moves: [105, 15, 5, 4, 2, 2, 1, 1, 0],
    convergedAt: 8,
    totalIterations: 9,
    distribution: [10, 1, 14, 3, 14, 28, 5, 13, 9, 8],
  };
  check('G.fixture105 moves==ORACLE_MANUAL [105,15,5,4,2,2,1,1,0]',
    JSON.stringify(movesG) === JSON.stringify(ORACLE_MANUAL.moves), JSON.stringify(movesG));
  check('G.fixture105 convergedAt=8 totalIterations=9',
    resG.convergedAt === ORACLE_MANUAL.convergedAt &&
    resG.iterations.length === ORACLE_MANUAL.totalIterations,
    `at=${resG.convergedAt} len=${resG.iterations.length}`);
  check('G.fixture105 distribution==ORACLE_MANUAL [10,1,14,3,14,28,5,13,9,8]',
    JSON.stringify(resG.distribution) === JSON.stringify(ORACLE_MANUAL.distribution),
    JSON.stringify(resG.distribution));
  // Oracle lama BE-KM-3 ([105,16,10,5,1,0] / at 5 / [3,3,23,...]) berasal dari dump pra-sync
  // dan SUDAH digantikan ORACLE_MANUAL di atas — assert tidak-cocok (STOP&LAPOR) dihapus.
  check('G.semua jarak output <=4dp (Mode D idempoten di round4)',
    resG.distances.every((distanceValue) => {
      const asString = String(distanceValue);
      const dotIndex = asString.indexOf('.');
      return dotIndex === -1 || asString.length - dotIndex - 1 <= 4;
    }),
    `n=${resG.distances.length}`);
} else {
  check('G.fixture105 tersedia', false, 'dump reduced_data tidak ditemukan (skip via env?)');
}

// ================= RINGKASAN =================
console.log(`\n${failures === 0 ? 'ALL PASS' : failures + ' FAILURE(S)'}`);
process.exit(failures === 0 ? 0 : 1);
