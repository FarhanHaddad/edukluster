// QA-ONLY — TIKET BE-KM-3: Precision-regime bridge.
// Jalankan engine K-Means pada fixture reduced_data (105 baris, dump server/DB) dalam 3 MODE:
//   A = intermediat centroid dibulatkan 4 desimal (perilaku sekarang / R-KM-36);
//   B = intermediat presisi penuh, pembulatan HANYA di boundary simpan/display;
//   C = intermediat dibulatkan 3 desimal.
// Cetak per mode: moves[], convergedAt, totalIterations, distribution[10].
// Pemenang = mode yang mereproduksi oracle Excel skripsi:
//   moves [105,14,7,2,0], convergedAt 4, totalIterations 5,
//   distribution [3,3,22,5,14,26,5,12,8,7].
// Tidak ada DB/HTTP; murni engine + fixture. DILARANG dipakai sebagai modul runtime.

'use strict';

const path = require('path');
const fs = require('fs');
const { runKMeans } = require('./kmeans.engine');
const { SEED_ROW_INDICES, FEATURE_ORDER } = require('./kmeans.seed');

// ---- Oracle Excel skripsi (kontrak angka Screen 8 v1.18 DESIGN.md).
const ORACLE = {
  moves: [105, 14, 7, 2, 0],
  convergedAt: 4,
  totalIterations: 5,
  distribution: [3, 3, 22, 5, 14, 26, 5, 12, 8, 7],
};

// ---- Fixture: baca dump reduced_data dari SQL skripsi (sumber kebenaran tunggal, anti drift).
function loadFixtureRows() {
  const envPath = process.env.KMEANS_FIXTURE_JSON;
  if (envPath) {
    return JSON.parse(fs.readFileSync(envPath, 'utf8')).map((row) => row.map(Number));
  }
  const sqlPath = path.resolve(__dirname, '../../../DB/edukluster_widuri_new.sql');
  const sqlDump = fs.readFileSync(sqlPath, 'utf8');
  const insertMatch = sqlDump.match(/INSERT INTO `reduced_data` \([^)]*\) VALUES\n([\s\S]*?);\n/);
  if (!insertMatch) throw new Error('fixture: blok INSERT reduced_data tidak ditemukan di dump SQL');
  const rows = [];
  for (const rawLine of insertMatch[1].split('\n')) {
    const line = rawLine.trim().replace(/,$/, '');
    if (!line.startsWith('(')) continue;
    const fields = line.slice(1, -1).split(',').map((field) => field.trim());
    // Kolom: id, preprocessing_run_id, siswa_periode_id, lalu 25 fitur (agama..jurusan_2).
    const featureFields = fields.slice(3, 3 + FEATURE_ORDER.length);
    if (featureFields.length !== FEATURE_ORDER.length) throw new Error('fixture: jumlah kolom fitur != 25');
    rows.push(featureFields.map((value) => Number(value)));
  }
  return rows;
}

// ---- Bulat HALF_UP ke n desimal (regime simulator untuk MODE B/C di luar engine).
function roundTo(value, decimals) {
  const factor = 10 ** decimals;
  const scaled = value * factor;
  return Math.round(scaled + Number.EPSILON * Math.abs(scaled)) / factor;
}

// Lloyd deterministik dengan knobs presisi terpisah (bridge vs engine produksi):
//   updateDecimals = null -> presisi penuh (B); angka -> bulat intermediat (A: 4, C: 3);
//   boundaryDecimals -> pembulatan HANYA saat hasil disimpan/ditampilkan (display/simpan).
function runRegime(rows, { updateDecimals, boundaryDecimals }) {
  const dim = FEATURE_ORDER.length;
  const vectors = rows.map((row) => row.map(Number));
  let centroids = SEED_ROW_INDICES.map((oneBased) => vectors[oneBased - 1].slice());
  const totalClusters = 10;

  const emit = (value) => (boundaryDecimals === null ? value : roundTo(value, boundaryDecimals));

  let prevAssign = null;
  const movesSequence = [];
  let convergedAt = null;
  let finalAssignments = null;
  let iterationCount = 0;

  for (let iterationNumber = 0; iterationNumber <= 50; iterationNumber++) {
    iterationCount = iterationNumber + 1;
    const assignments = vectors.map((vector) => {
      let bestCode = 0;
      let bestDistance = Infinity;
      for (let clusterIndex = 0; clusterIndex < totalClusters; clusterIndex++) {
        let squaredSum = 0;
        for (let featureIndex = 0; featureIndex < dim; featureIndex++) {
          const delta = vector[featureIndex] - centroids[clusterIndex][featureIndex];
          squaredSum += delta * delta;
        }
        const candidateDistance = Math.sqrt(squaredSum);
        if (candidateDistance < bestDistance) {
          bestDistance = candidateDistance;
          bestCode = clusterIndex;
        }
      }
      return bestCode;
    });
    const moveCount = prevAssign === null
      ? assignments.length
      : assignments.reduce((count, code, i) => count + (code !== prevAssign[i] ? 1 : 0), 0);
    movesSequence.push(emit(moveCount));
    finalAssignments = assignments;
    if (moveCount === 0) {
      convergedAt = iterationNumber;
      break;
    }
    prevAssign = assignments;

    const sums = centroids.map(() => new Array(dim).fill(0));
    const counts = new Array(totalClusters).fill(0);
    assignments.forEach((code, pointIndex) => {
      counts[code]++;
      for (let featureIndex = 0; featureIndex < dim; featureIndex++) {
        sums[code][featureIndex] += vectors[pointIndex][featureIndex];
      }
    });
    centroids = centroids.map((oldCentroid, clusterIndex) => {
      if (counts[clusterIndex] === 0) return oldCentroid.slice();
      return sums[clusterIndex].map((sum) => {
        const meanValue = sum / counts[clusterIndex];
        return updateDecimals === null ? meanValue : roundTo(meanValue, updateDecimals);
      });
    });
  }

  const distribution = new Array(totalClusters).fill(0);
  for (const code of finalAssignments) distribution[code]++;
  return {
    moves: movesSequence.map(Number),
    convergedAt,
    totalIterations: iterationCount,
    distribution: distribution.map(Number),
  };
}

function matchesOracle(result) {
  return (
    JSON.stringify(result.moves) === JSON.stringify(ORACLE.moves) &&
    result.convergedAt === ORACLE.convergedAt &&
    result.totalIterations === ORACLE.totalIterations &&
    JSON.stringify(result.distribution) === JSON.stringify(ORACLE.distribution)
  );
}

function main() {
  const rows = loadFixtureRows();
  if (rows.length !== 105) console.error(`PERINGATAN: fixture ${rows.length} baris (harap 105)`);

  // Sanity: jalur engine produksi (rezim A) harus identik dengan simulasi MODE A.
  const engineResult = runKMeans(rows, { seedIndices: SEED_ROW_INDICES, k: 10 });
  const engineSummary = {
    moves: engineResult.iterations.map((iteration) => iteration.moves),
    convergedAt: engineResult.convergedAt,
    totalIterations: engineResult.iterations.length,
    distribution: engineResult.distribution,
  };

  const modes = [
    { name: 'A (round-before-use 4dp = perilaku engine sekarang)', spec: { updateDecimals: 4, boundaryDecimals: null } },
    { name: 'B (presisi penuh, bulat hanya boundary simpan/display)', spec: { updateDecimals: null, boundaryDecimals: 4 } },
    { name: 'C (intermediat 3dp)', spec: { updateDecimals: 3, boundaryDecimals: null } },
  ];

  console.log('== TIKET BE-KM-3 precision-regime bridge ==');
  console.log(`Oracle : moves ${JSON.stringify(ORACLE.moves)} convergedAt ${ORACLE.convergedAt}` +
    ` totalIterations ${ORACLE.totalIterations} distribution ${JSON.stringify(ORACLE.distribution)}`);
  console.log(`Engine (produksi, rezim A): moves ${JSON.stringify(engineSummary.moves)}` +
    ` convergedAt ${engineSummary.convergedAt} totalIterations ${engineSummary.totalIterations}` +
    ` distribution ${JSON.stringify(engineSummary.distribution)}` +
    ` | cocok oracle: ${matchesOracle(engineSummary) ? 'YA' : 'TIDAK'}`);

  let winner = null;
  const table = [];
  for (const mode of modes) {
    const result = runRegime(rows, mode.spec);
    const ok = matchesOracle(result);
    if (ok && !winner) winner = mode.name;
    table.push({ mode: mode.name, ...result, cocok: ok });
    console.log(`Mode ${mode.name}: moves ${JSON.stringify(result.moves)}` +
      ` convergedAt ${result.convergedAt} totalIterations ${result.totalIterations}` +
      ` distribution ${JSON.stringify(result.distribution)} => ${ok ? 'COCCOK ORACLE' : 'tidak cocok'}`);
  }

  console.log('\n-- Cross-check input (baris seed, 25 fitur sesuai FEATURE_ORDER) --');
  SEED_ROW_INDICES.forEach((oneBased, slot) => {
    console.log(`C${slot + 1} = baris ${oneBased}: ` + rows[oneBased - 1].join(', '));
  });

  if (winner) {
    console.log(`\nPEMENANG: ${winner}`);
    process.exit(0);
  }
  console.log('\nTIDAK ADA MODE yang cocok dengan oracle -> STOP & LAPOR (lihat tabel di atas).');
  console.table(table.map(({ mode, moves, convergedAt, totalIterations, distribution, cocok }) =>
    ({ mode, moves: JSON.stringify(moves), convergedAt, totalIterations, distribution: JSON.stringify(distribution), cocok })));
  process.exit(2);
}

main();
