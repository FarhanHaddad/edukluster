const prisma = require('../lib/prisma');
const ApiError = require('../utils/ApiError');
const { previewCache } = require('./excelImport.service');
const { MATA_PELAJARAN_COLUMNS } = require('../utils/excelConstants');

// ===== Tiket B2: Confirm & Mass Insert transaksional (all-or-nothing).
// Service TIDAK kenal req/res — controller yang membentuk response 201.

const STATUS_PERIODE_AKTIF = 'AKTIF';
const SOURCE_EXCEL_IMPORT = 'excel_import';
const JENIS_NILAI = ['rapor', 'pts', 'pas']; // VarChar(10), lowercase persis.

// Normalisasi jenis_kelamin -> kode 1 karakter (kolom DB VarChar(1)).
// Preview B1 sudah menyimpan 'L'/'P' uppercase, tapi peta label panjang ikut dijaga.
const JK_MAP = { L: 'L', P: 'P', 'Laki-laki': 'L', 'Perempuan': 'P' };
function normalizeJenisKelamin(value) {
  if (value === undefined || value === null) return null;
  const s = String(value).trim();
  if (s === '') return null;
  return JK_MAP[s] ?? s.toUpperCase() ?? null;
}

// Hitung jumlah baris nilai_akademik yang akan dibuat untuk satu item preview.
// Dipakai utk sanity-check pra-transaksi: 5 write per baris (1 siswa_periode +
// 3 nilai_akademik + 1 non_akademik); dengan batas Prisma ~100 concurrent writes,
// batch > ~20 baris berisiko timeout — gagal cepat (400) lebih baik daripada 500.
const MAX_CONFIRM_ROWS = 20;

// Satu item previewData -> data insert nilai_akademik utk satu jenis nilai.
// Sel missing (null) TETAP null di DB (kolom nullable) — JANGAN diisi 0.
function buildNilaiData(jenisNilai, mapelObj) {
  const data = { jenis_nilai: jenisNilai };
  for (const { dbKey } of MATA_PELAJARAN_COLUMNS) {
    const v = mapelObj && mapelObj[dbKey] !== undefined ? mapelObj[dbKey] : null;
    data[dbKey] = v === undefined ? null : v;
  }
  return data;
}

// Item dianggap "missing" bila punya >= 1 sel nilai null di salah dari 3 sheet nilai.
function hasMissingCell(item) {
  for (const jenis of JENIS_NILAI) {
    const mapelObj = item.nilai && item.nilai[jenis];
    if (!mapelObj) continue;
    for (const { dbKey } of MATA_PELAJARAN_COLUMNS) {
      if (mapelObj[dbKey] === null || mapelObj[dbKey] === undefined) return true;
    }
  }
  return false;
}

// Peta error unique Prisma (P2002) -> ApiError 409 dengan message menyebut NIS.
// Karena dilempar DI DALAM callback $transaction, seluruh write otomatis rollback.
function throwUniqueConflict(err, nisContext) {
  if (err && err.code === 'P2002') {
    const target = (err.meta && err.meta.target) || '';
    throw new ApiError(
      409,
      `Konflik data unik saat import (constraint: ${target || 'unknown'}). ` +
        `NIS penyebab: ${nisContext}. Seluruh transaksi di-rollback, tidak ada data yang masuk.`
    );
  }
  throw err;
}

// Cari NIS penyebab konflik unik (P2002) lewat read-only query SETELAH rollback:
// siswa mana dari preview yang sudah punya baris siswa_periode di periode AKTIF.
// Best-effort — kalau tetap tidak ketemu, kembalikan teks fallback.
async function findConflictNis(previewData) {
  try {
    const nisList = previewData.map((i) => i.nis).filter(Boolean);
    if (!nisList.length) return 'tidak dapat dipastikan';
    const periodeAktif = await prisma.periode.findFirst({ where: { status: STATUS_PERIODE_AKTIF } });
    if (!periodeAktif) return nisList.join(', ');
    // Candidate 1: master siswa dengan NIS sama sudah ada (konflik bisa muncul saat
    // create siswa_periode memakai id existing hasil reuse).
    const existingSiswa = await prisma.siswa.findMany({
      where: { nis: { in: nisList } },
      select: { id: true, nis: true },
    });
    if (!existingSiswa.length) return nisList.join(', ');
    // Candidate 2: sudah ada keanggotaan periode AKTIF utk siswa tsb -> itulah pemicu P2002.
    const conflicts = await prisma.siswa_periode.findMany({
      where: {
        periode_id: periodeAktif.id,
        siswa_id: { in: existingSiswa.map((s) => s.id) },
      },
      select: { siswa: { select: { nis: true } } },
    });
    const found = conflicts.map((r) => r.siswa && r.siswa.nis).filter(Boolean);
    return found.length ? found.join(', ') : existingSiswa.map((s) => s.nis).join(', ');
  } catch {
    return 'tidak dapat dipastikan';
  }
}

// ===== Entry point service confirm.
// @param {string} previewId - id cache dari respons preview B1.
// @returns {Promise<object>} ringkasan impor (BigInt sudah jadi Number, siap respons).
async function confirmImport(previewId) {
  // --- 1. Ambil cache by previewId. Miss/expired/kedaluwarsa -> 404. ---
  const entry = previewCache.get(previewId);
  const cacheHit =
    entry && typeof entry.expiresAt === 'number' && entry.expiresAt > Date.now();
  if (!cacheHit) {
    // Bersihkan diam-diam bila ternyata sudah expired tapi belum di-prune.
    previewCache.delete(previewId);
    throw new ApiError(
      404,
      'Data preview tidak ditemukan atau sudah kedaluwarsa. Silakan upload ulang.'
    );
  }
  const { previewData, summary, errors } = entry.data;

  // Sanity check payload cache (harus selalu benar karena ditulis B1 sendiri).
  if (!Array.isArray(previewData)) {
    throw new ApiError(
      404,
      'Data preview tidak ditemukan atau sudah kedaluwarsa. Silakan upload ulang.'
    );
  }
  if (previewData.length > MAX_CONFIRM_ROWS) {
    throw new ApiError(
      400,
      `Jumlah baris valid terlalu besar untuk sekali konfirmasi (maks ${MAX_CONFIRM_ROWS}). Silakan pecah file menjadi beberapa batch.`
    );
  }

  // --- 2..4 Semua write DI DALAM satu transaksi (all-or-nothing). ---
  let result;
  try {
    result = await prisma.$transaction(async (tx) => {
      // 2. Periode target = periode AKTIF. Tidak ada -> 400 (transaksi rollback total).
      const periode = await tx.periode.findFirst({ where: { status: STATUS_PERIODE_AKTIF } });
      if (!periode) {
        throw new ApiError(400, 'Tidak ada periode aktif. Buat dan aktifkan periode terlebih dahulu.');
      }

      let importedCount = 0;
      let missingCount = 0;

      // 3. Loop SEQUENTIAL per baris previewData (hanya baris valid+missing yang sampai sini;
      //    baris error TIDAK ada di previewData => otomatis DITOLAK / tidak diinsert).
      for (const item of previewData) {
        const nis = item.nis;
        const now = new Date();

        // 3a. Master siswa: reuse bila NIS sudah ada, create bila belum.
        let siswa = await tx.siswa.findUnique({ where: { nis } });
        if (!siswa) {
          siswa = await tx.siswa.create({
            data: {
              nis,
              nama: item.nama || null,
              jenis_kelamin: normalizeJenisKelamin(item.jenis_kelamin),
              created_at: now,
              updated_at: now,
            },
          });
        }

        // 3b. Keanggotaan periode, flag sumber excel_import.
        // Unique [siswa_id, periode_id] -> tabrak = P2002 (race condition) -> 409.
        const siswaPeriode = await tx.siswa_periode.create({
          data: {
            siswa_id: siswa.id,
            periode_id: periode.id,
            kelas: item.kelas || null,
            source_type: SOURCE_EXCEL_IMPORT,
            created_at: now,
            updated_at: now,
          },
        });

        // 3c. Tiga baris nilai_akademik: rapor / pts / pas.
        for (const jenis of JENIS_NILAI) {
          await tx.nilai_akademik.create({
            data: {
              siswa_periode_id: siswaPeriode.id,
              ...buildNilaiData(jenis, item.nilai && item.nilai[jenis]),
              created_at: now,
              updated_at: now,
            },
          });
        }

        // 3d. Satu baris non_akademik (nilai default sudah terisi dari preview B1 —
        //     what you preview = what gets inserted; jangan default ulang di sini).
        const na = item.non_akademik || {};
        await tx.non_akademik.create({
          data: {
            siswa_periode_id: siswaPeriode.id,
            ekstrakurikuler: na.ekstrakurikuler ?? null,
            prestasi: na.prestasi ?? null,
            kemampuan: na.kemampuan ?? null,
            organisasi: na.organisasi ?? null,
            kursus: na.kursus ?? null,
            jurusan_1: na.jurusan_1 ?? null,
            jurusan_2: na.jurusan_2 ?? null,
            created_at: now,
            updated_at: now,
          },
        });

        importedCount += 1;
        if (hasMissingCell(item)) missingCount += 1;
      }

      return {
        importedCount,
        missingCount,
        periode: { id: Number(periode.id), namaPeriode: periode.namaPeriode ?? null },
      };
    });
  } catch (err) {
    // 4. P2002 -> 409 dengan message menyebut NIS penyebab. Transaksi SUDAH
    //    rollback total secara otomatis (error dilempar dari dalam callback $transaction).
    if (err && err.code === 'P2002') {
      const nisCause = await findConflictNis(previewData);
      throwUniqueConflict(err, nisCause);
    }
    throw err; // ApiError (mis. 400 tanpa periode AKTIF) & lainnya diteruskan apa adanya.
  }

  // --- 5. Sukses: HAPUS cache previewId (idempotency: confirm kedua -> 404). ---
  previewCache.delete(previewId);

  const rejectedRows = (Array.isArray(errors) ? errors : []).map((e) => ({
    row: e.row,
    nis: e.nis ?? null,
    nama: e.nama ?? null, // FE render "[Kosong]" bila null
    message: e.message,
  }));

  return {
    message: 'Import berhasil.',
    importedCount: result.importedCount,
    missingCount: result.missingCount,
    rejectedCount: rejectedRows.length,
    rejectedRows,
    periode: result.periode,
    summary: summary || null,
  };
}

module.exports = { confirmImport };
