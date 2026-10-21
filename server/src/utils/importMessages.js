// Katalog pesan keterangan import + helper perakit (TIKET BE-IMP-FIX-3A).
// Module PURE: tanpa dependensi I/O, tanpa DB — mudah diuji.
// Sumber label mapel & field non-akademik: excelConstants.js (SATU-SATUNYA sumber kebenaran).

const {
  MATA_PELAJARAN_COLUMNS,
  NON_AKADEMIK_FIELD_MAP,
} = require('./excelConstants');

// ===== Nama sheet KANONIK (uppercase) — lihat excelConstants REQUIRED_SHEETS.
const SHEET_NAMES = ['RAPOR', 'PTS', 'PAS', 'NON-AKADEMIK'];

// ===== Peta field non-akademik (key DB) -> label manusia, dari NON_AKADEMIK_FIELD_MAP yang sudah ada.
// Urutan mengikuti deklarasi map: Agama..Ekonomi utk mapel; ekstrakurikuler..jurusan_2 utk non-akademik.
const NON_AKADEMIK_LABEL_BY_FIELD = Object.entries(NON_AKADEMIK_FIELD_MAP).reduce(
  (acc, [label, field]) => {
    acc[field] = label;
    return acc;
  },
  {}
);

// ===== Aturan cap daftar (kontrak tiket): <=5 sebut semua; >5 -> 5 pertama + " +{n-5} lainnya".
const MAX_LISTED = 5;
function formatDaftar(list) {
  const items = (Array.isArray(list) ? list : []).map((s) => String(s)).filter((s) => s !== '');
  const n = items.length;
  if (n === 0) return { daftar: '', n: 0 };
  if (n <= MAX_LISTED) return { daftar: items.join(', '), n };
  const shown = items.slice(0, MAX_LISTED).join(', ');
  return { daftar: `${shown} +${n - MAX_LISTED} lainnya`, n };
}

// ===== KATALOG PESAN KANONIK (string persis; fungsi utk template {Label}/{SHEET}/{daftar}/{n}).
const IMPORT_MESSAGES = {
  // --- Global / identitas (error tingkat baris) ---
  NIS_KOSONG: 'NIS kosong.',
  NIS_DUPLIKAT: 'NIS duplikat di dalam file.',
  NIS_SUDAH_TERDAFTAR: 'NIS sudah terdaftar di periode aktif.',
  nisTidakDitemukan: (sheet) => `NIS tidak ditemukan di sheet ${String(sheet ?? '').toUpperCase()}.`,
  NAMA_KOSONG: 'Nama siswa kosong.',
  KELAS_TIDAK_VALID: 'Kelas tidak valid (wajib XII-1 sampai XII-4).',
  JK_TIDAK_VALID: 'Jenis kelamin tidak valid (wajib L/P atau Laki-laki/Perempuan).',

  // --- Lokal sheet (error tingkat nilai) ---
  nilaiBukanNumerik: (label) => `Nilai ${label} bukan numerik.`,
  nilaiDiLuarRentang: (label) => `Nilai ${label} di luar rentang (0-100).`,

  // --- Catatan (bukan error) ---
  missingNilai: (daftar, n) => `Missing nilai: ${daftar} (${n} kolom).`,
  nonAkademikDefault: (daftar, n) => `Non-akademik kosong diisi default: ${daftar} (${n} kolom).`,
};

// ===== Resolver label manusiawi ({Label}) untuk mata pelajaran.
// Terima header persis ('B. Indonesia'), dbKey ('b_indonesia'), atau padanan longgar
// (trim/case-insensitive/spasi internal dirapikan). Unknown -> string aslinya apa adanya.
function resolveMapelLabel(value) {
  const raw = String(value ?? '');
  const hit = MATA_PELAJARAN_COLUMNS.find((c) => c.header === raw || c.dbKey === raw);
  if (hit) return hit.header;
  const norm = raw.trim().toLowerCase().replace(/\s+/g, ' ');
  const fuzzy = MATA_PELAJARAN_COLUMNS.find(
    (c) => c.header.toLowerCase() === norm || c.dbKey === norm
  );
  return fuzzy ? fuzzy.header : raw;
}

// ===== Resolver label manusia untuk field non-akademik (7 field: Ekstrakurikuler..Jurusan Universitas 2).
function resolveNonAkademikLabel(value) {
  const raw = String(value ?? '');
  if (NON_AKADEMIK_FIELD_MAP[raw]) return raw; // sudah label persis
  const byField = NON_AKADEMIK_LABEL_BY_FIELD[raw];
  if (byField) return byField; // key DB -> label
  const norm = raw.trim().toLowerCase().replace(/\s+/g, ' ');
  const labelHit = Object.keys(NON_AKADEMIK_FIELD_MAP).find(
    (label) => label.toLowerCase() === norm
  );
  return labelHit ?? raw;
}

// ===== Helper konstruksi pesan lokal (memakai katalog kanonik secara persis).
function msgNilaiBukanNumerik(label) {
  return IMPORT_MESSAGES.nilaiBukanNumerik(resolveMapelLabel(label));
}
function msgNilaiDiLuarRentang(label) {
  return IMPORT_MESSAGES.nilaiDiLuarRentang(resolveMapelLabel(label));
}
function msgNisTidakDitemukan(sheet) {
  return IMPORT_MESSAGES.nisTidakDitemukan(sheet);
}

// ===== Perakit keterangan per baris.
// buildRowKeterangan({ globalErrors[], localErrors[], missingLabels[], defaultFields[] }) -> string
// Urutan join: error (global -> lokal) -> missing -> catatan default. Separator " • ".
// Hasil bersih (tanpa apa pun) -> "-".
function buildRowKeterangan({
  globalErrors = [],
  localErrors = [],
  missingLabels = [],
  defaultFields = [],
} = {}) {
  const parts = [];

  // 1) Error global (identitas), apa adanya — diasumsikan sudah string kanonik dari katalog.
  for (const e of Array.isArray(globalErrors) ? globalErrors : []) {
    const s = String(e ?? '').trim();
    if (s) parts.push(s);
  }

  // 2) Error lokal per sheet (nilai), apa adanya.
  for (const e of Array.isArray(localErrors) ? localErrors : []) {
    const s = String(e ?? '').trim();
    if (s) parts.push(s);
  }

  // 3) Missing nilai (catatan): label mapel dinormalisasi ke label kanonik, lalu cap daftar.
  const missingNorm = (Array.isArray(missingLabels) ? missingLabels : []).map(resolveMapelLabel);
  const missing = formatDaftar(missingNorm);
  if (missing.n > 0) parts.push(IMPORT_MESSAGES.missingNilai(missing.daftar, missing.n));

  // 4) Non-akademik diisi default (catatan): field dinormalisasi ke label manusia, lalu cap daftar.
  const defaultNorm = (Array.isArray(defaultFields) ? defaultFields : []).map(
    resolveNonAkademikLabel
  );
  const defaults = formatDaftar(defaultNorm);
  if (defaults.n > 0) {
    parts.push(IMPORT_MESSAGES.nonAkademikDefault(defaults.daftar, defaults.n));
  }

  if (parts.length === 0) return '-';
  return parts.join(' • ');
}

module.exports = {
  IMPORT_MESSAGES,
  SHEET_NAMES,
  MAX_LISTED,
  formatDaftar,
  resolveMapelLabel,
  resolveNonAkademikLabel,
  msgNilaiBukanNumerik,
  msgNilaiDiLuarRentang,
  msgNisTidakDitemukan,
  buildRowKeterangan,
};
