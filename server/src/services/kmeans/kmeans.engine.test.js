// QA lokal engine K-Means + DBI (TANPA DB/HTTP) - TIKET BE-KM-1.
// Jalankan: node server/src/services/kmeans/kmeans.engine.test.js
// Oracle AC: A (fixture 6 titik), B (tie-break), C (cluster kosong), D (determinisme), E (maxIter).

'use strict';

const { runKMeans } = require('./kmeans.engine');
const { computeDBI } = require('./kmeans.dbi');

let failures = 0;
function check(name, cond, detail) {
  const ok = Boolean(cond);
  if (!ok) failures++;
  console.log(`${ok ? 'PASS' : 'FAIL'} | ${name}${detail !== undefined ? ` | ${detail}` : ''}`);
}

// ---- Helper: pad vektor 2D ke 25 fitur agar kompatibel dgn seed/FEATURE_ORDER.
// Fitur 3..24 diisi konstanta yang sama utk semua titik & seed (tidak memengaruhi jarak relatif).
const SEED2 = [[0, 0], [1, 1]]; // seed fixture A: baris idx 0 & 3
function pad(vec2, base) {
  const v = vec2.slice();
  for (let f = vec2.length; f < 25; f++) v.push(base[f]);
  return v;
}
// Base 25-dim utk seed2D: pakai centroid seed asli idx 0 lalu geser sumbu 2D via pad di bawah.
const BASE25 = new Array(25).fill(0);
const pts2 = [[0, 0], [0.1, 0], [0, 0.1], [1, 1], [1.1, 1], [1, 1.1]];
const rowsA = pts2.map((p) => pad(p, BASE25));
const seedA = [pad(SEED2[0], BASE25), pad(SEED2[1], BASE25)];

// ================= FIXTURE A =================
const resA = runKMeans(rowsA, { k: 2, maxIter: 50, seed: seedA });
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
const seedB = [[0, 0, ...BASE25.slice(2)], [1, 0, ...BASE25.slice(2)]];
const resB = runKMeans([pad([0.5, 0], BASE25)], { k: 2, maxIter: 1, seed: seedB });
check('B.tie->kode terkecil', resB.finalAssignments[0] === 0, `assign=${resB.finalAssignments[0]}`);

// ================= FIXTURE C: cluster kosong tidak crash =================
// Semua titik dekat seed0; seed1 jauh -> cluster 1 kosong, centroid lama dipertahankan.
const seedC = [[0, 0, ...BASE25.slice(2)], [9, 9, ...BASE25.slice(2)]];
const rowsC = [pad([0, 0], BASE25), pad([0.1, 0], BASE25), pad([0, 0.1], BASE25)];
let resC, errC = null;
try {
  resC = runKMeans(rowsC, { k: 2, maxIter: 10, seed: seedC });
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
const resD1 = runKMeans(rowsA, { k: 2, maxIter: 50, seed: seedA });
const resD2 = runKMeans(rowsA, { k: 2, maxIter: 50, seed: seedA });
check('D.deterministik', JSON.stringify(resD1) === JSON.stringify(resD2));

// ================= FIXTURE E: maxIter=3, paksa tak konvergen =================
// Seed kembar (identik) -> tie-break melempar semua ke kode 0; centroid beku memicu
// re-assign berulang -> moves>0 tiap iterasi, tidak konvergen dalam 3 iterasi.
const seedE = [[0, 0, ...BASE25.slice(2)], [0, 0, ...BASE25.slice(2)], [0, 0, ...BASE25.slice(2)]];
const rowsE = [pad([0, 0], BASE25), pad([1, 1], BASE25), pad([4, 4], BASE25)];
const resE = runKMeans(rowsE, { k: 3, maxIter: 3, seed: seedE });
check('E.converged=false', resE.converged === false, `converged=${resE.converged}`);
check('E.iterations<=4', resE.iterations.length <= 4, `len=${resE.iterations.length}`);

// ================= RINGKASAN =================
console.log(`\n${failures === 0 ? 'ALL PASS' : failures + ' FAILURE(S)'}`);
process.exit(failures === 0 ? 0 : 1);
