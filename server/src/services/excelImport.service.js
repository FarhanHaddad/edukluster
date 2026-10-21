const crypto = require('crypto');
const XLSX = require('xlsx');
const prisma = require('../lib/prisma');
const ApiError = require('../utils/ApiError');
const {
  SHEET_RAPOR,
  SHEET_PTS,
  SHEET_PAS,
  SHEET_NON_AKADEMIK,
  REQUIRED_SHEETS,
  normalizeLabel,
  MATA_PELAJARAN_COLUMNS,
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
  normalizeJenisKelamin,
  PREVIEW_TTL_MS,
} = require('../utils/excelConstants');
// Katalog pesan + perakit keterangan per sheet (tiket BE-IMP-FIX-3A -> dipakai di 3B).
const { IMPORT_MESSAGES, buildRowKeterangan } = require('../utils/importMessages');

// ===== Taksonomi status (C6): valid | missing | error. Prioritas terburuk: error > missing > valid.
const STATUS_RANK = { valid: 0, missing: 1, error: 2 };
const worstStatus = (a, b) => (STATUS_RANK[b] > STATUS_RANK[a] ? b : a);

// ===== Error fatal (struktur file tidak bisa dipakai sama sekali).
// Code FATAL_PARSE_ERROR dipakai utk: bukan .xlsx (konten), sheet kurang/tidak match, header kurang.
// Controller memetakan LIMIT_ERR / code INVALID_FILE / FILE_TOO_LARGE dari multer -> 400 dengan message spesifik.
function fatal(message) {
  const err = new ApiError(400, message);
  err.code = 'FATAL_PARSE_ERROR';
  // Kode error juga dibungkus sebagai statusCode agar error.middleware ikut memancarkannya.
  err.statusCode = 400;
  return err;
}

// ===== Util sel: selalu pakai raw value (SheetJS `raw: true`) agar angka Excel tetap number.
function cellStr(value) {
  if (value === null || value === undefined) return '';
  return String(value).trim();
}

function isBlankStr(value) {
  return value === '' || value === null || value === undefined;
}

// Normalisasi NIS: angka Excel 20250001 -> "20250001" (hindari notasi ilmiah).
function normalizeNis(raw) {
  if (typeof raw === 'number') {
    return Number.isInteger(raw) ? String(raw) : String(raw);
  }
  return cellStr(raw);
}

// ===== Validasi satu sel nilai akademik.
// Return: { ok:true, value:num } | { ok:true, blank:true } (missing) | { ok:false, message }.
function validateNilai(cell) {
  if (cell === null || cell === undefined || cell === '') {
    return { ok: true, blank: true }; // C6: sel kosong -> status missing, nilai null di previewData
  }
  let num;
  if (typeof cell === 'number') {
    num = cell;
  } else {
    const s = String(cell).trim().replace(',', '.');
    // Hanya terima teks angka murni ("85", "85.5", "8,5"); selain itu non-numerik.
    if (!/^\d+([.]\d+)?$/.test(s)) {
      return { ok: false, message: 'bukan numerik' };
    }
    num = Number(s);
  }
  if (!Number.isFinite(num)) {
    return { ok: false, message: 'bukan numerik' };
  }
  if (num < 0 || num > 100) {
    return { ok: false, message: 'di luar rentang (0-100)' };
  }
  return { ok: true, value: num };
}

// ===== Muat & validasi struktur satu sheet (C3: urutan kolom bebas, kolom ekstra diabaikan).
// Return { rows: [{ __row, cells }], headerIndex: Map(label->colIdx) }.
function loadSheet(wb, sheetName, expectedHeaders) {
  const ws = wb.Sheets[sheetName];
  const aoa = XLSX.utils.sheet_to_json(ws, { header: 1, defval: null, blankrows: false, raw: true });
  if (!aoa.length || !Array.isArray(aoa[0])) {
    throw fatal(`Sheet ${sheetName} kosong: baris header wajib ada.`);
  }

  // Bangun peta label-normalisasi -> indeks kolom (kolom ekstra seperti "No" diabaikan).
  const headerIndex = new Map();
  aoa[0].forEach((h, idx) => {
    const key = normalizeLabel(h);
    if (key !== '' && !headerIndex.has(key)) headerIndex.set(key, idx);
  });

  // Kolom wajib kurang = error struktural fatal.
  const missing = expectedHeaders.filter((h) => !headerIndex.has(normalizeLabel(h)));
  if (missing.length) {
    throw fatal(missing.map((h) => `Kolom ${h} tidak ditemukan pada sheet ${sheetName}.`).join(' '));
  }

  // Baris data: array sel per posisi kolom asli; nomor baris = posisi riil spreadsheet (header = baris 1).
  const rows = [];
  for (let i = 1; i < aoa.length; i++) {
    const arr = aoa[i] || [];
    const hasContent = arr.some((c) => c !== null && c !== undefined && String(c).trim() !== '');
    if (!hasContent) continue; // lewati baris benar-benar kosong
    const cells = {};
    for (const [label, idx] of headerIndex) {
      cells[label] = arr[idx] === undefined ? null : arr[idx];
    }
    rows.push({ __row: i + 1, cells });
  }
  return { rows, headerIndex };
}

// ===== Cache preview in-memory (TTL 15 menit). Dipakai endpoint confirm pada tiket B2 —
// pada tiket ini hanya diisi, TIDAK dibaca/dipakai insert apa pun.
const previewCache = new Map(); // previewId -> { expiresAt, data }

function pruneExpiredPreviews() {
  const now = Date.now();
  for (const [id, entry] of previewCache) {
    if (entry.expiresAt <= now) previewCache.delete(id);
  }
}

function storePreview(data) {
  pruneExpiredPreviews();
  const previewId = crypto.randomUUID();
  previewCache.set(previewId, { expiresAt: Date.now() + PREVIEW_TTL_MS, data });
  return previewId;
}

// ===== Helper pembentuk pesan error (C8: Bahasa Indonesia, sebut label + sheet kanonik).
function makeAddError(errors) {
  return ({ row, sheet, field, nis, message }) => {
    errors.push({ row, sheet, field, nis: nis ?? null, message });
  };
}

// ===== Perakit keterangan PER SHEET (tiket BE-IMP-FIX-3B; dipakai preview & confirm).
// Factory murni (tanpa I/O): menerima registrasi hasil pass validasi, mengembalikan fungsi
// (sheetName, nis) -> string keterangan dari buildRowKeterangan (katalog 3A). Registrasi:
//   globalErrors        : Map kNis -> array pesan ERROR GLOBAL/identitas  -> SEMUA tab baris itu.
//   localErrorsBySheetNis: Map "SHEET\0NIS" -> array pesan ERROR LOKAL     -> HANYA tab sheet itu.
//   missingBySheetNis   : Map key sama -> Set label mapel kosong           -> HANYA tab akademik tsb.
//   defaultFieldsByNis  : Map kNis -> array field non-akademik ter-default -> HANYA tab NON-AKADEMIK.
// Baris bersih di tab ini -> "-". Key NIS null memakai sentinel '\u0000null' (mis. NIS kosong).
const NILAI_SHEETS = new Set([SHEET_RAPOR, SHEET_PTS, SHEET_PAS]);
function sheetNisKeyOf(sheetName, nis) {
  return `${sheetName}\u0000${nis == null ? '\u0000null' : String(nis)}`;
}
function nisKeyOf(nis) {
  return nis == null ? '\u0000null' : String(nis);
}
function makeBuildKeteranganForSheet({
  globalErrors,
  localErrorsBySheetNis,
  missingBySheetNis,
  defaultFieldsByNis,
}) {
  return (sheetName, nis) => {
    const kNis = nisKeyOf(nis);
    const key = sheetNisKeyOf(sheetName, nis);
    // localErrorsBySheetNis sudah ber-key (SHEET, NIS) sehingga secara struktural hanya berisi
    // pesan sheet itu — "NIS tidak ditemukan di sheet X" hanya terdaftar di key sheet X dan
    // tidak pernah bocor ke tab lain.
    return buildRowKeterangan({
      globalErrors: globalErrors.get(kNis) ?? [],
      localErrors: localErrorsBySheetNis.get(key) ?? [],
      missingLabels: NILAI_SHEETS.has(sheetName) ? [...(missingBySheetNis.get(key) ?? [])] : [],
      defaultFields: sheetName === SHEET_NON_AKADEMIK ? defaultFieldsByNis.get(kNis) ?? [] : [],
    });
  };
}

// ===== Pipeline utama: parse + validasi + join by NIS. READ-ONLY terhadap DB (tidak ada insert).
async function parseAndPreview(file) {
  // --- Validasi kehadiran & ekstensi file (fatal bila gagal). ---
  if (!file || !file.buffer || !file.buffer.length) {
    throw fatal('File Excel (.xlsx) wajib diunggah pada field "file".');
  }
  if (!/\.xlsx$/i.test(file.originalname || '')) {
    throw fatal('File harus berformat .xlsx.');
  }

  // --- Baca workbook. ---
  let wb;
  try {
    wb = XLSX.read(file.buffer, { type: 'buffer', cellDates: false });
  } catch (err) {
    throw fatal(`File tidak dapat dibaca sebagai Excel (.xlsx): ${err.message}`);
  }

  // --- C1: 4 sheet wajib, match trim + case-insensitive. Pesan menyebut nama kanonik uppercase. ---
  const sheetByNorm = new Map();
  for (const name of wb.SheetNames) {
    const key = normalizeLabel(name);
    if (!sheetByNorm.has(key)) sheetByNorm.set(key, name);
  }
  const resolvedSheets = {};
  for (const canonical of REQUIRED_SHEETS) {
    const found = sheetByNorm.get(normalizeLabel(canonical));
    if (!found) {
      throw fatal(`Sheet ${canonical} tidak ditemukan.`);
    }
    resolvedSheets[canonical] = found;
  }

  // --- Muat 4 sheet (fatal bila header wajib kurang). ---
  const rapor = loadSheet(wb, resolvedSheets[SHEET_RAPOR], HEADERS_RAPOR);
  const pts = loadSheet(wb, resolvedSheets[SHEET_PTS], HEADERS_PTS);
  const pas = loadSheet(wb, resolvedSheets[SHEET_PAS], HEADERS_PAS);
  const nonAk = loadSheet(wb, resolvedSheets[SHEET_NON_AKADEMIK], HEADERS_NON_AKADEMIK);

  const NILAI_SPECS = [
    { sheetName: SHEET_RAPOR, jenis: 'rapor', data: rapor },
    { sheetName: SHEET_PTS, jenis: 'pts', data: pts },
    { sheetName: SHEET_PAS, jenis: 'pas', data: pas },
  ];

  const errors = [];
  const addError = makeAddError(errors);

  // ===== Registrasi error TERSTRUKTUR utk perakit keterangan per sheet (tiket BE-IMP-FIX-3B).
  // Satu-satunya sumber pesan: katalog IMPORT_MESSAGES (utils/importMessages.js, hasil 3A) —
  // string error di `errors`, `keterangan` rows[] preview, maupun alasan rejectedRows confirm
  // identik persis. Struktur disimpan di `registrasi` dan ikut di-cache (lihat storePreview).
  const globalByNis = new Map(); // kNis -> array pesan ERROR GLOBAL/identitas (semua tab)
  const localBySheetNis = new Map(); // "SHEET\0NIS" -> array pesan ERROR LOKAL (hanya tab itu)
  const missingBySheetNis = new Map(); // "SHEET\0NIS" -> Set label mapel kosong di sheet itu
  const defaultFieldsByNis = new Map(); // kNis -> field non-akademik terisi default D4 (tab NON-AKADEMIK)
  const registrasi = {
    globalErrors: globalByNis,
    localErrorsBySheetNis: localBySheetNis,
    missingBySheetNis,
    defaultFieldsByNis,
  };
  const pushGlobal = (nis, message) => {
    const k = nisKeyOf(nis);
    if (!globalByNis.has(k)) globalByNis.set(k, []);
    const arr = globalByNis.get(k);
    if (!arr.includes(message)) arr.push(message);
  };
  const pushLocal = (sheetName, nis, message) => {
    const k = sheetNisKeyOf(sheetName, nis);
    if (!localBySheetNis.has(k)) localBySheetNis.set(k, []);
    localBySheetNis.get(k).push(message);
  };
  const pushMissing = (sheetName, nis, header) => {
    const k = sheetNisKeyOf(sheetName, nis);
    if (!missingBySheetNis.has(k)) missingBySheetNis.set(k, new Set());
    missingBySheetNis.get(k).add(header);
  };

  // ===== Perakit SATU pesan error dari KATALOG (tiket BE-IMP-FIX-3B; sumber tunggal: importMessages.js).
  // kind 'global' -> dicatat di globalByNis (muncul di SEMUA tab sheet baris itu).
  // kind 'local'  -> dicatat di localBySheetNis (hanya muncul di tab sheet tempat nilai bermasalah).
  // Pesan yang TIDAK ada di katalog (mis. 'Jenis kelamin kosong.' — varian kasus khusus) tetap
  // diteruskan apa adanya ke `errors` & ikut keterangan, tanpa mengubah string existing.
  const catalogError = ({ kind, row, sheet, field, nis, message }) => {
    if (kind === 'global') pushGlobal(nis, message);
    else pushLocal(sheet, nis, message);
    addError({ row, sheet, field, nis: nis ?? null, message });
  };
  // Varian utk sel nilai akademik: pilih template katalog persis (bukan numerik / di luar rentang),
  // catat sbg error LOKAL sheet tsb, dan kembalikan pesannya (dipakai juga utk pass 1/2 lama).
  const addNilaiError = ({ row, sheet, header, res, nis }) => {
    const message =
      res.message === 'di luar rentang (0-100)'
        ? IMPORT_MESSAGES.nilaiDiLuarRentang(header)
        : IMPORT_MESSAGES.nilaiBukanNumerik(header);
    catalogError({ kind: 'local', row, sheet, field: header, nis, message });
    return message;
  };

  // Register per NIS (join lintas sheet) + register per-sheet utk tabel UI.
  const entries = new Map(); // nis -> entry
  const ensureEntry = (nis) => {
    if (!entries.has(nis)) {
      entries.set(nis, {
        nis,
        identitas: null, // { nama, kelas, jenis_kelamin } dari RAPOR
        nilai: {}, // jenis -> { mapelObjek, rowStatus }
        nonAkademik: null,
        sheetsSeen: new Set(),
        rowRefs: {}, // sheetName -> nomor baris
        status: 'valid', // status global (worst-case lintas sheet)
        sheetStatus: {}, // sheetName -> status per sheet (worst-case baris di sheet tsb)
      });
    }
    return entries.get(nis);
  };

  // --- Pass 1: sheet RAPOR (identitas + 18 nilai rapor). ---
  const seenRapornNis = new Set();
  for (const { __row, cells } of rapor.rows) {
    const nis = normalizeNis(cells[normalizeLabel(HEADER_NIS)]);
    if (nis === '') {
      catalogError({ kind: 'global', row: __row, sheet: SHEET_RAPOR, field: HEADER_NIS, nis: null, message: IMPORT_MESSAGES.NIS_KOSONG });
      continue;
    }
    if (seenRapornNis.has(nis)) {
      catalogError({ kind: 'global', row: __row, sheet: SHEET_RAPOR, field: HEADER_NIS, nis, message: IMPORT_MESSAGES.NIS_DUPLIKAT });
      const e = ensureEntry(nis);
      e.status = worstStatus(e.status, 'error');
      e.sheetStatus[SHEET_RAPOR] = worstStatus(e.sheetStatus[SHEET_RAPOR] ?? 'valid', 'error');
      continue;
    }
    seenRapornNis.add(nis);

    const entry = ensureEntry(nis);
    entry.sheetsSeen.add(SHEET_RAPOR);
    entry.rowRefs[SHEET_RAPOR] = __row;

    // Identitas (hanya ada di RAPOR).
    const nama = cellStr(cells[normalizeLabel(HEADER_NAMA)]);
    const kelas = cellStr(cells[normalizeLabel(HEADER_KELAS)]);
    // JK: normalisasi lewat util shared normalizeJenisKelamin (tiket BE-IMP-FIX-1) —
    // terima kode 'L'/'P' maupun label 'Laki-laki'/'Perempuan' (case-insensitive).
    // previewData menyimpan hasil TER-NORMALISASI ('L'/'P'), bukan raw label, supaya confirm & insert konsisten.
    const jkRaw = cellStr(cells[normalizeLabel(HEADER_JENIS_KELAMIN)]);
    const jk = normalizeJenisKelamin(jkRaw);

    let rowStatus = 'valid';
    if (nama === '') {
      catalogError({ kind: 'global', row: __row, sheet: SHEET_RAPOR, field: HEADER_NAMA, nis, message: IMPORT_MESSAGES.NAMA_KOSONG });
      rowStatus = 'error';
    }
    if (!VALID_KELAS.includes(kelas)) {
      catalogError({ kind: 'global', row: __row, sheet: SHEET_RAPOR, field: HEADER_KELAS, nis, message: IMPORT_MESSAGES.KELAS_TIDAK_VALID });
      rowStatus = 'error';
    }
    if (jkRaw === '') {
      addError({ row: __row, sheet: SHEET_RAPOR, field: HEADER_JENIS_KELAMIN, nis, message: 'Jenis kelamin kosong.' });
      pushGlobal(nis, 'Jenis kelamin kosong.');
      rowStatus = 'error';
    } else if (jk === null) {
      catalogError({ kind: 'global', row: __row, sheet: SHEET_RAPOR, field: HEADER_JENIS_KELAMIN, nis, message: IMPORT_MESSAGES.JK_TIDAK_VALID });
      rowStatus = 'error';
    }
    entry.identitas = { nama, kelas, jenis_kelamin: jk ?? jkRaw };

    // 18 nilai mapel RAPOR.
    const mapelObj = {};
    for (const { dbKey, header } of MATA_PELAJARAN_COLUMNS) {
      const res = validateNilai(cells[normalizeLabel(header)]);
      if (!res.ok) {
        addNilaiError({ row: __row, sheet: SHEET_RAPOR, header, res, nis });
        rowStatus = 'error';
        mapelObj[dbKey] = null;
      } else if (res.blank) {
        rowStatus = worstStatus(rowStatus, 'missing');
        pushMissing(SHEET_RAPOR, nis, header);
        mapelObj[dbKey] = null; // previewData: nilai kosong = null
      } else {
        mapelObj[dbKey] = res.value;
      }
    }
    entry.nilai.rapor = mapelObj;
    entry.status = worstStatus(entry.status, rowStatus);
    entry.sheetStatus[SHEET_RAPOR] = worstStatus(entry.sheetStatus[SHEET_RAPOR] ?? 'valid', rowStatus);
  }

  // --- Pass 2: sheet PTS & PAS (18 nilai per NIS). ---
  for (const spec of [NILAI_SPECS[1], NILAI_SPECS[2]]) {
    const seen = new Set();
    for (const { __row, cells } of spec.data.rows) {
      const nis = normalizeNis(cells[normalizeLabel(HEADER_NIS)]);
      if (nis === '') {
        catalogError({ kind: 'global', row: __row, sheet: spec.sheetName, field: HEADER_NIS, nis: null, message: IMPORT_MESSAGES.NIS_KOSONG });
        continue;
      }
      if (seen.has(nis)) {
        catalogError({ kind: 'global', row: __row, sheet: spec.sheetName, field: HEADER_NIS, nis, message: IMPORT_MESSAGES.NIS_DUPLIKAT });
        const e = ensureEntry(nis);
        e.status = worstStatus(e.status, 'error');
        e.sheetStatus[spec.sheetName] = worstStatus(e.sheetStatus[spec.sheetName] ?? 'valid', 'error');
        continue;
      }
      seen.add(nis);

      const entry = ensureEntry(nis);
      entry.sheetsSeen.add(spec.sheetName);
      entry.rowRefs[spec.sheetName] = __row;

      let rowStatus = 'valid';
      const mapelObj = {};
      for (const { dbKey, header } of MATA_PELAJARAN_COLUMNS) {
        const res = validateNilai(cells[normalizeLabel(header)]);
        if (!res.ok) {
          addNilaiError({ row: __row, sheet: spec.sheetName, header, res, nis });
          rowStatus = 'error';
          mapelObj[dbKey] = null;
        } else if (res.blank) {
          rowStatus = worstStatus(rowStatus, 'missing');
          pushMissing(spec.sheetName, nis, header);
          mapelObj[dbKey] = null;
        } else {
          mapelObj[dbKey] = res.value;
        }
      }
      entry.nilai[spec.jenis] = mapelObj;
      entry.status = worstStatus(entry.status, rowStatus);
      entry.sheetStatus[spec.sheetName] = worstStatus(entry.sheetStatus[spec.sheetName] ?? 'valid', rowStatus);
    }
  }

  // --- Pass 3: sheet NON-AKADEMIK (default C4 saat sel kosong; baris tetap valid). ---
  {
    const seen = new Set();
    for (const { __row, cells } of nonAk.rows) {
      const nis = normalizeNis(cells[normalizeLabel(HEADER_NIS)]);
      if (nis === '') {
        catalogError({ kind: 'global', row: __row, sheet: SHEET_NON_AKADEMIK, field: HEADER_NIS, nis: null, message: IMPORT_MESSAGES.NIS_KOSONG });
        continue;
      }
      if (seen.has(nis)) {
        catalogError({ kind: 'global', row: __row, sheet: SHEET_NON_AKADEMIK, field: HEADER_NIS, nis, message: IMPORT_MESSAGES.NIS_DUPLIKAT });
        const e = ensureEntry(nis);
        e.status = worstStatus(e.status, 'error');
        e.sheetStatus[SHEET_NON_AKADEMIK] = worstStatus(e.sheetStatus[SHEET_NON_AKADEMIK] ?? 'valid', 'error');
        continue;
      }
      seen.add(nis);

      const entry = ensureEntry(nis);
      entry.sheetsSeen.add(SHEET_NON_AKADEMIK);
      entry.rowRefs[SHEET_NON_AKADEMIK] = __row;

      const na = {};
      const defaulted = []; // field non-akademik yang terisi default D4 (catatan utk tab NON-AKADEMIK)
      for (const [header, field] of Object.entries(NON_AKADEMIK_FIELD_MAP)) {
        const val = cellStr(cells[normalizeLabel(header)]);
        if (isBlankStr(val)) {
          na[field] = NON_AKADEMIK_DEFAULTS[field];
          defaulted.push(field);
        } else {
          na[field] = val;
        }
      }
      if (defaulted.length) defaultFieldsByNis.set(String(nis), defaulted);
      entry.nonAkademik = na;
      // Non-akademik tidak menghasilkan status missing/error (sel kosong otomatis ter-default).
      entry.sheetStatus[SHEET_NON_AKADEMIK] = worstStatus(entry.sheetStatus[SHEET_NON_AKADEMIK] ?? 'valid', 'valid');
    }
  }

  // --- Kelengkapan join: setiap NIS wajib punya baris di 4 sheet. ---
  for (const entry of entries.values()) {
    for (const sheetName of REQUIRED_SHEETS) {
      if (!entry.sheetsSeen.has(sheetName)) {
        const refRow = entry.rowRefs[SHEET_RAPOR] ?? entry.rowRefs[SHEET_NON_AKADEMIK] ?? 0;
        catalogError({ kind: 'local', row: refRow, sheet: sheetName, field: HEADER_NIS, nis: entry.nis, message: IMPORT_MESSAGES.nisTidakDitemukan(sheetName) });
        entry.status = worstStatus(entry.status, 'error');
        entry.sheetStatus[sheetName] = worstStatus(entry.sheetStatus[sheetName] ?? 'valid', 'error');
      }
    }
  }

  // --- Cek NIS vs database (READ-ONLY: findMany saja, TIDAK ADA insert pada tiket ini). ---
  const allNis = [...entries.keys()];
  if (allNis.length) {
    const existing = await prisma.siswa.findMany({
      where: { nis: { in: allNis } },
      select: { nis: true },
    });
    for (const row of existing) {
      const entry = entries.get(row.nis);
      if (!entry) continue;
      const refRow = entry.rowRefs[SHEET_RAPOR] ?? entry.rowRefs[SHEET_NON_AKADEMIK] ?? 0;
      catalogError({ kind: 'global', row: refRow, sheet: SHEET_RAPOR, field: HEADER_NIS, nis: entry.nis, message: IMPORT_MESSAGES.NIS_SUDAH_TERDAFTAR });
      entry.status = worstStatus(entry.status, 'error');
      entry.sheetStatus[SHEET_RAPOR] = worstStatus(entry.sheetStatus[SHEET_RAPOR] ?? 'valid', 'error');
    }
  }

  // --- Susun previewData (simetris body POST /api/siswa single input; hanya baris tanpa error). ---
  // Baris "missing" TETAP ikut previewData dengan nilai=null dan tetap importable (C6/C7).
  const previewData = [];
  for (const entry of entries.values()) {
    if (entry.status === 'error') continue;
    if (entry.sheetsSeen.size !== REQUIRED_SHEETS.length) continue; // tak lengkap -> sudah ditandai error
    const ident = entry.identitas || { nama: '', kelas: '', jenis_kelamin: '' };
    previewData.push({
      nis: entry.nis,
      nama: ident.nama,
      kelas: ident.kelas,
      jenis_kelamin: ident.jenis_kelamin,
      nilai: {
        rapor: entry.nilai.rapor ?? null,
        pts: entry.nilai.pts ?? null,
        pas: entry.nilai.pas ?? null,
      },
      non_akademik: entry.nonAkademik,
    });
  }

  // --- summary 5 angka (C7). totalRows = jumlah NIS UNIK hasil join 4 sheet (C5). ---
  let validRows = 0;
  let missingRows = 0;
  let errorRows = 0;
  for (const entry of entries.values()) {
    if (entry.status === 'valid') validRows += 1;
    else if (entry.status === 'missing') missingRows += 1;
    else errorRows += 1;
  }
  const totalRows = entries.size;
  const summary = {
    totalRows,
    validRows,
    missingRows,
    errorRows,
    importableRows: validRows + missingRows,
  };

  // --- sheets[] utk tabel UI per tab (nama & kelas di-join dari RAPOR). ---
  // PERLUASAN PAYLOAD PREVIEW (tiket BE-IMP-3, Opsi A; hotfix BE-IMP-3b): tiap item rows[] dapat 2 field BARU —
  //   jenis_kelamin: "L"|"P" hasil normalizeJenisKelamin via JOIN identitas RAPOR by NIS (sumber sama dgn nama/kelas),
  //     terisi di SEMUA sheet; null hanya bila identitas RAPOR baris tsb kosong/invalid (kasus error).
  //   values: object isi sel per sheet, supaya FE bisa merender nilai langsung dari rows TANPA join previewData.
  // Semantik values per status baris (kontrak presisi):
  //   - Sheet akademik (RAPOR/PTS/PAS), status valid|missing -> 18 key mapel PASCA-normalisasi (number|null;
  //     sel kosong/invalid => null — sama dgn previewData).
  //   - Sheet akademik, status error -> RAW parse (kebutuhan forensik: admin melihat sel penyebab error, mis. 150).
  //   - Sheet NON-AKADEMIK -> 7 key string; status valid|missing memakai default C4 pasca-normalisasi;
  //     status error -> RAW trim (kosong => '').
  // Field lama (row, nis, nama, kelas, status, keterangan) TIDAK berubah; summary/sheets[].status/
  // sheets[].errors/previewData/errors/previewId juga TIDAK berubah.
  const rawNilaiCell = (cells, header) => {
    const c = cells[normalizeLabel(header)];
    if (c === null || c === undefined || c === '') return null;
    if (typeof c === 'number') return Number.isFinite(c) ? c : null;
    return cellStr(c); // teks non-numerik ikut tampil mentah (forensik baris error)
  };

  // Sumber nilai TER-NORMALISASI per sheet dari entry hasil pass validasi (no-duplication logika).
  const normalizedForSheet = (sheetName, entry) => {
    if (!entry) return null;
    if (sheetName === SHEET_RAPOR) return entry.nilai.rapor ?? null;
    if (sheetName === SHEET_PTS) return entry.nilai.pts ?? null;
    if (sheetName === SHEET_PAS) return entry.nilai.pas ?? null;
    if (sheetName === SHEET_NON_AKADEMIK) return entry.nonAkademik ?? null;
    return null;
  };

  // Bangun `values` per baris. Kontrak semantik (tiket BE-IMP-3):
  // - Baris dgn error LOKAL di sheet ini (validasi gagal pada sel sheet ini: numerik/rentang/kosong)
  //   -> nilai RAW hasil parse (forensik: admin melihat sel penyebab error, mis. 150).
  // - Status valid/missing (termasuk baris yg kena error GLOBAL seperti NIS dup / tidak ditemukan
  //   di sheet lain — selnya sendiri tetap lolos validasi) -> nilai PASCA-normalisasi:
  //   akademik missing = null; non-akademik kosong = string default D4.
  const buildValuesObject = (sheetName, hasLocalError, cells, entry) => {
    const values = {};
    const normalized = normalizedForSheet(sheetName, entry);
    if (sheetName === SHEET_NON_AKADEMIK) {
      for (const [header, field] of Object.entries(NON_AKADEMIK_FIELD_MAP)) {
        if (hasLocalError) {
          // Forensik: tampilkan RAW hasil parse (bukan default C4) pada baris error lokal.
          values[field] = cellStr(cells[normalizeLabel(header)]);
        } else {
          // Valid/missing: identik dgn normalisasi pass 3 (default C4 saat sel kosong) — no-duplication.
          values[field] = normalized?.[field] ?? NON_AKADEMIK_DEFAULTS[field];
        }
      }
      return values;
    }
    // Sheet akademik: kunci = dbKey mapel (agama..ekonomi), nilai number|null.
    for (const { dbKey, header } of MATA_PELAJARAN_COLUMNS) {
      if (hasLocalError) {
        values[dbKey] = rawNilaiCell(cells, header); // RAW utk keperluan forensik
      } else {
        values[dbKey] = normalized?.[dbKey] ?? null; // PASCA-normalisasi (missing = null)
      }
    }
    return values;
  };

  // ===== Perakit KETERANGAN PER SHEET (tiket BE-IMP-FIX-3B; memakai buildRowKeterangan hasil 3A).
  // Kontrak semantik rows[].keterangan pada tiap tab sheet:
  //   - Pesan GLOBAL/identitas (NIS kosong/duplikat/sudah terdaftar, Nama kosong, Kelas/JK invalid)
  //     -> muncul di SEMUA tab sheet utk baris NIS itu.
  //   - Pesan LOKAL (nilai non-numerik / di luar rentang; "NIS tidak ditemukan di sheet X")
  //     -> HANYA di tab sheet tempat pesan itu terjadi.
  //   - Catatan "Missing nilai" -> HANYA di tab akademik tempat mapel kosong (per sheet).
  //   - Catatan default non-akademik -> HANYA di tab NON-AKADEMIK.
  //   - Baris bersih tanpa apa pun di tab ini -> "-".
  // Status baris per sheet TIDAK berubah (tetap worstStatusLocal); summary chips juga tidak berubah.
  const notFoundPrefix = 'NIS tidak ditemukan di sheet ';
  const buildKeteranganForSheet = makeBuildKeteranganForSheet(registrasi);

  const buildSheetBlock = (sheetName, rowsIter, nisOf) => {
    const sheetErrors = errors.filter((e) => e.sheet === sheetName);
    // Kumpulkan NIS yang punya error LOKAL di sheet ini. Pengecualian: pesan "NIS tidak ditemukan
    // di sheet <X>" diregistrasikan pd sheet X utk baris yang absen (tak ada cells utk row tsb) —
    // bukan indikator kegagalan validasi sel, jadi tidak memicu mode RAW.
    const localErrorNis = new Set(
      sheetErrors.filter((e) => !(e.field === HEADER_NIS && typeof e.message === 'string' && e.message.startsWith(notFoundPrefix))).map((e) => String(e.nis ?? ''))
    );
    const rows = rowsIter.map(({ __row, cells }) => {
      const nis = nisOf(__row);
      const entry = nis ? entries.get(nis) : null;
      // Keterangan PER SHEET dari katalog (buildKeteranganForSheet) — bukan lagi join mentah rowErrs.
      const keterangan = buildKeteranganForSheet(sheetName, nis);
      const status = entry ? worstStatusLocal(sheetName, entry) : 'error';
      return {
        row: __row,
        nis: nis ?? '',
        nama: entry?.identitas?.nama ?? '',
        kelas: entry?.identitas?.kelas ?? '',
        status,
        keterangan,
        // ===== Field baru (perluasan tiket BE-IMP-3, hotfix BE-IMP-3b) =====
        // jenis_kelamin: HASIL JOIN identitas RAPOR by NIS — mekanisme yang SAMA persis dengan
        // join nama & kelas di atas (entry?.identitas?.*). Bukan baca kolom sheet sendiri,
        // karena hanya sheet RAPOR yang punya kolom JK; sheet lain akan selalu null (bug lama).
        // Nilai = hasil normalizeJenisKelamin ('L'/'P') yang tersimpan di entry.identitas saat pass 1;
        // null hanya bila identitas RAPOR baris tsb memang kosong/invalid (kasus error), atau NIS tak terdaftar.
        jenis_kelamin: entry?.identitas?.jenis_kelamin ?? null,
        values: buildValuesObject(sheetName, localErrorNis.has(String(nis ?? '')), cells, entry),
      };
    });
    return {
      name: sheetName,
      status: rows.reduce((acc, r) => worstStatus(acc, r.status), 'valid'),
      rows,
      errors: sheetErrors.map((e) => ({ row: e.row, nis: e.nis, message: e.message })),
    };
  };

  // Status per-sheet utk satu baris: ambil dari entry.sheetStatus bila sheet itu dilihat entry.
  function worstStatusLocal(sheetName, entry) {
    if (!entry.sheetsSeen.has(sheetName)) return 'error';
    return entry.sheetStatus[sheetName] ?? 'valid';
  }

  const indexByRow = (dataRows) => {
    const map = new Map();
    for (const { __row, cells } of dataRows) {
      map.set(__row, normalizeNis(cells[normalizeLabel(HEADER_NIS)]) || null);
    }
    return map;
  };

  const sheets = [
    buildSheetFrom(rapor.rows, SHEET_RAPOR),
    buildSheetFrom(pts.rows, SHEET_PTS),
    buildSheetFrom(pas.rows, SHEET_PAS),
    buildSheetFrom(nonAk.rows, SHEET_NON_AKADEMIK),
  ];

  function buildSheetFrom(dataRows, sheetName) {
    const rowToNis = indexByRow(dataRows);
    return buildSheetBlock(sheetName, dataRows, (r) => rowToNis.get(r) ?? null);
  }

  // --- Errors global: gabungan semua sheet, urut row (lalu urut sheet sesuai REQUIRED_SHEETS). ---
  const sheetOrder = new Map(REQUIRED_SHEETS.map((s, i) => [s, i]));
  errors.sort((a, b) => a.row - b.row || sheetOrder.get(a.sheet) - sheetOrder.get(b.sheet));

  const status = errors.length === 0 ? 'success' : 'validation_error';

  // --- Simpan cache previewId utk tiket B2 (confirm) — TIDAK ada write ke DB. ---
  // PERLUASAN PAYLOAD CACHE (tiket B2): `errors` ikut disimpan supaya service confirm
  // dapat membentuk rejectedRows (baris error yang DITOLAK, tidak diinsert) tanpa
  // menyentuh kontrak response preview (field respons publik tetap sama).
  const previewId = storePreview({ previewData, summary, errors, registrasi, fileName: file.originalname, uploadedAt: new Date().toISOString() });

  return {
    previewId,
    fileName: file.originalname,
    fileSize: file.size ?? file.buffer.length,
    status,
    summary,
    sheets,
    previewData,
    errors,
  };
}

module.exports = {
  parseAndPreview,
  previewCache,
  // Eksport helper perakit keterangan (tiket BE-IMP-FIX-3B) — dipakai excelConfirm.service.js
  // supaya alasan rejectedRows memakai KATALOG & registrasi yang SAMA dengan preview.
  makeBuildKeteranganForSheet,
  sheetNisKeyOf,
  nisKeyOf,
};
