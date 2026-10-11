// Sumber kebenaran tunggal kontrak template Excel import siswa (FR-C02 / TIKET B1).
// Dipakai oleh: excelTemplate.service (generate) & excelImport.service (parse/validasi).

// ===== C1: Nama sheet KANONIK (uppercase) — template emit persis string ini.
// Validator upload mencocokkan dengan trim + case-insensitive ("Rapor"/"rapor " tetap lolos).
const SHEET_RAPOR = 'RAPOR';
const SHEET_PTS = 'PTS';
const SHEET_PAS = 'PAS';
const SHEET_NON_AKADEMIK = 'NON-AKADEMIK';
const REQUIRED_SHEETS = [SHEET_RAPOR, SHEET_PTS, SHEET_PAS, SHEET_NON_AKADEMIK];

// Normalisasi pembanding (sheet & header): trim + lower + rapikan spasi internal.
const normalizeLabel = (s) => String(s ?? '').trim().toLowerCase().replace(/\s+/g, ' ');

// ===== C2/C5: 18 mata pelajaran — label manusiawi (header) -> key DB (snake_case).
// Urutan kolom sheet RAPOR/PTS/PAS persis seperti daftar ini (pasca kolom identitas).
const MATA_PELAJARAN_COLUMNS = [
  { dbKey: 'agama', header: 'Agama' },
  { dbKey: 'pkn', header: 'PKN' },
  { dbKey: 'b_indonesia', header: 'B. Indonesia' },
  { dbKey: 'b_inggris', header: 'B. Inggris' },
  { dbKey: 'mtk_wajib', header: 'MTK Wajib' },
  { dbKey: 'sejarah', header: 'Sejarah' },
  { dbKey: 'pjok', header: 'PJOK' },
  { dbKey: 'seni_rupa', header: 'Seni Rupa' },
  { dbKey: 'b_jepang', header: 'B. Jepang' },
  { dbKey: 'biologi', header: 'Biologi' },
  { dbKey: 'fisika', header: 'Fisika' },
  { dbKey: 'kimia', header: 'Kimia' },
  { dbKey: 'informatika', header: 'Informatika' },
  { dbKey: 'mtk_lanjut', header: 'MTK Lanjut' },
  { dbKey: 'geografi', header: 'Geografi' },
  { dbKey: 'sosial', header: 'Sosial' },
  { dbKey: 'pkwu', header: 'PKWU' },
  { dbKey: 'ekonomi', header: 'Ekonomi' },
];

// Header mapel saja (18), dipakai menyusun header tiap sheet nilai.
const MATA_PELAJARAN_HEADERS = MATA_PELAJARAN_COLUMNS.map((c) => c.header);

// ===== C2: Header baris-1 KANONIK per sheet (label manusiawi).
const HEADER_NIS = 'NIS';
const HEADER_NAMA = 'Nama Siswa';
const HEADER_KELAS = 'Kelas';
const HEADER_JENIS_KELAMIN = 'Jenis Kelamin';

const HEADERS_RAPOR = [
  HEADER_NIS,
  HEADER_NAMA,
  HEADER_KELAS,
  HEADER_JENIS_KELAMIN,
  ...MATA_PELAJARAN_HEADERS,
];
// PTS & PAS: NIS + 18 label mapel sama persis urutan RAPOR.
const HEADERS_PTS = [HEADER_NIS, ...MATA_PELAJARAN_HEADERS];
const HEADERS_PAS = [HEADER_NIS, ...MATA_PELAJARAN_HEADERS];
const HEADERS_NON_AKADEMIK = [
  HEADER_NIS,
  'Ekstrakurikuler',
  'Prestasi',
  'Kemampuan',
  'Organisasi',
  'Kursus',
  'Jurusan Universitas 1',
  'Jurusan Universitas 2',
];

// Peta header Non-Akademik (label) -> field respons (key DB single-input).
const NON_AKADEMIK_FIELD_MAP = {
  Ekstrakurikuler: 'ekstrakurikuler',
  Prestasi: 'prestasi',
  Kemampuan: 'kemampuan',
  Organisasi: 'organisasi',
  Kursus: 'kursus',
  'Jurusan Universitas 1': 'jurusan_1',
  'Jurusan Universitas 2': 'jurusan_2',
};

// ===== C4: Default non-akademik saat sel kosong/whitespace (baris tetap VALID;
// what you preview = what gets inserted nanti).
const NON_AKADEMIK_DEFAULTS = {
  ekstrakurikuler: 'Tidak Mengikuti',
  prestasi: 'Tidak',
  kemampuan: 'Tidak Ada',
  organisasi: 'Tidak',
  kursus: 'Tidak',
  jurusan_1: 'Tidak Memilih',
  jurusan_2: 'Tidak Memilih',
};

// ===== Domain validasi.
const VALID_KELAS = ['XII-1', 'XII-2', 'XII-3', 'XII-4'];
const VALID_JENIS_KELAMIN = ['L', 'P'];

// ===== Kontrak file & response.
const XLSX_MIME = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
const TEMPLATE_FILENAME = 'template-import-siswa.xlsx';
const MAX_FILE_SIZE_BYTES = 5 * 1024 * 1024; // 5 MB
const PREVIEW_TTL_MS = 15 * 60 * 1000; // previewId cache in-memory 15 menit (dipakai endpoint confirm tiket B2)

module.exports = {
  SHEET_RAPOR,
  SHEET_PTS,
  SHEET_PAS,
  SHEET_NON_AKADEMIK,
  REQUIRED_SHEETS,
  normalizeLabel,
  MATA_PELAJARAN_COLUMNS,
  MATA_PELAJARAN_HEADERS,
  HEADER_NIS,
  HEADER_NAMA,
  HEADER_KELAS,
  HEADER_JENIS_KELAMIN,
  HEADERS_RAPOR,
  HEADERS_PTS,
  HEADERS_PAS,
  HEADERS_NON_AKADEMIK,
  NON_AKADEMIK_FIELD_MAP,
  NON_AKADEMIK_DEFAULTS,
  VALID_KELAS,
  VALID_JENIS_KELAMIN,
  XLSX_MIME,
  TEMPLATE_FILENAME,
  MAX_FILE_SIZE_BYTES,
  PREVIEW_TTL_MS,
};
