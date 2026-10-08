const prisma = require('../lib/prisma');
const ApiError = require('../utils/ApiError');

// Vocabulary level (app-level, tanpa enum DB).
const STATUS_PERIODE = { AKTIF: 'AKTIF' };
const SOURCE_SINGLE_INPUT = 'single_input';
const JENIS_NILAI = ['rapor', 'pts', 'pas'];

// Field siswa yang boleh dikirim ke response — TANPA created_at/updated_at.
const SAFE_SISWA_SELECT = {
  id: true,
  nis: true,
  nama: true,
  jenis_kelamin: true,
};

// RULE WAJIB: BigInt -> Number di semua response.
function toNumber(value) {
  if (value === null || value === undefined) return null;
  return Number(value);
}

// Peta satu row nilai_akademik (Prisma Decimal -> Number) menjadi objek respons.
function mapNilaiRow(row) {
  if (!row) return null;
  return {
    id: toNumber(row.id),
    jenis_nilai: row.jenis_nilai,
    agama: toNumber(row.agama),
    pkn: toNumber(row.pkn),
    b_indonesia: toNumber(row.b_indonesia),
    b_inggris: toNumber(row.b_inggris),
    mtk_wajib: toNumber(row.mtk_wajib),
    sejarah: toNumber(row.sejarah),
    pjok: toNumber(row.pjok),
    seni_rupa: toNumber(row.seni_rupa),
    b_jepang: toNumber(row.b_jepang),
    biologi: toNumber(row.biologi),
    fisika: toNumber(row.fisika),
    kimia: toNumber(row.kimia),
    informatika: toNumber(row.informatika),
    mtk_lanjut: toNumber(row.mtk_lanjut),
    geografi: toNumber(row.geografi),
    sosial: toNumber(row.sosial),
    pkwu: toNumber(row.pkwu),
    ekonomi: toNumber(row.ekonomi),
  };
}

// 3 row nilai_akademik -> object { rapor, pts, pas }.
function mapNilaiAkademik(rows) {
  const byJenis = {};
  for (const row of rows) {
    byJenis[row.jenis_nilai] = mapNilaiRow(row);
  }
  return {
    rapor: byJenis.rapor ?? null,
    pts: byJenis.pts ?? null,
    pas: byJenis.pas ?? null,
  };
}

// Baris siswa_periode -> objek respons ringan (dipakai list & detail).
function mapSiswaPeriode(siswaPeriode) {
  if (!siswaPeriode) return null;
  return {
    id: toNumber(siswaPeriode.id),
    siswa_id: toNumber(siswaPeriode.siswa_id),
    periode_id: toNumber(siswaPeriode.periode_id),
    kelas: siswaPeriode.kelas,
    source_type: siswaPeriode.source_type,
    createdAt: siswaPeriode.created_at,
  };
}

// Peta error unique Prisma (P2002) ke pesan 409 sesuai kontrak FE.
function throwUniqueConflict(err) {
  if (err && err.code === 'P2002') {
    const target = (err.meta && err.meta.target) || '';
    // Constraint unik pada modul siswa: NIS siswa atau keanggotaan periode.
    if (String(target).includes('siswa_periode')) {
      throw new ApiError(409, 'Siswa sudah terdaftar di periode ini.');
    }
    throw new ApiError(409, 'NIS sudah terdaftar.');
  }
  throw err;
}

// RULE WAJIB: BigInt -> Number di semua response item siswa.
function toResponseItem(siswa) {
  return {
    id: toNumber(siswa.id),
    nis: siswa.nis,
    nama: siswa.nama,
    jenis_kelamin: siswa.jenis_kelamin,
  };
}

// Ambil periode target: validasi eksplisit bila dikirim, fallback periode AKTIF.
// throwWhenMissing=true dipakai jalur tulis (POST) — sesuai kontrak FR-C01.
async function resolvePeriodeId(periodeId, { throwWhenMissing = false } = {}) {
  if (periodeId !== undefined && periodeId !== null) {
    const periode = await prisma.periode.findUnique({ where: { id: BigInt(periodeId) } });
    if (!periode) {
      throw new ApiError(404, 'Periode tidak ditemukan.');
    }
    return periode.id;
  }

  const periodeAktif = await prisma.periode.findFirst({ where: { status: STATUS_PERIODE.AKTIF } });

  if (!periodeAktif && throwWhenMissing) {
    throw new ApiError(409, 'Tidak ada periode aktif. Buat periode terlebih dahulu.');
  }

  return periodeAktif ? periodeAktif.id : null;
}

// Konversi body nilai (object mapel per jenis) menjadi data Prisma Decimal-friendly.
function buildNilaiData(jenisNilai, mapel) {
  const data = { jenis_nilai: jenisNilai };
  for (const key of Object.keys(mapel)) {
    data[key] = mapel[key];
  }
  return data;
}

// GET /api/siswa — daftar siswa pada satu periode + search/filter/pagination (FR-C01).
async function listSiswa({ periode_id, q, kelas, source, page = 1, limit = 10 }) {
  const periodeId = await resolvePeriodeId(periode_id);

  // Tanpa periode sama sekali (tidak ada AKTIF) → daftar kosong, bukan error.
  if (!periodeId) {
    return { items: [], total: 0, page, limit };
  }

  const where = {
    periode_id: periodeId,
    // Catatan: MySQL (collation default case-insensitive) → contains sudah 'insensitive'.
    siswa: q ? { OR: [{ nis: { contains: q } }, { nama: { contains: q } }] } : {},
    ...(kelas ? { kelas } : {}),
    ...(source ? { source_type: source } : {}),
  };

  const [rows, total] = await prisma.$transaction([
    prisma.siswa_periode.findMany({
      where,
      orderBy: { siswa: { nis: 'asc' } },
      skip: (page - 1) * limit,
      take: limit,
      select: {
        id: true,
        kelas: true,
        source_type: true,
        created_at: true,
        siswa: { select: SAFE_SISWA_SELECT },
      },
    }),
    prisma.siswa_periode.count({ where }),
  ]);

  const items = rows.map((row) => ({
    id: toNumber(row.siswa.id),
    siswa_periode_id: toNumber(row.id),
    nis: row.siswa.nis,
    nama: row.siswa.nama,
    jenis_kelamin: row.siswa.jenis_kelamin,
    kelas: row.kelas,
    source_type: row.source_type,
    createdAt: row.created_at,
  }));

  return { items, total, page, limit };
}

// GET /api/siswa/:id — detail siswa + periode + 3 jenis nilai + non-akademik (FR-C01).
async function getSiswaDetail(id, periode_id) {
  const siswa = await prisma.siswa.findUnique({ where: { id: BigInt(id) } });
  if (!siswa) {
    throw new ApiError(404, 'Siswa tidak ditemukan.');
  }

  const periodeId = await resolvePeriodeId(periode_id);
  if (!periodeId) {
    throw new ApiError(404, 'Siswa tidak ditemukan.');
  }

  const siswaPeriode = await prisma.siswa_periode.findUnique({
    where: { siswa_id_periode_id: { siswa_id: BigInt(id), periode_id: periodeId } },
    include: {
      periode: true,
      nilai_akademik: true,
      non_akademik: true,
    },
  });

  if (!siswaPeriode) {
    throw new ApiError(404, 'Siswa tidak ditemukan.');
  }

  const nonAkademik = siswaPeriode.non_akademik
    ? {
        id: toNumber(siswaPeriode.non_akademik.id),
        ekstrakurikuler: siswaPeriode.non_akademik.ekstrakurikuler,
        prestasi: siswaPeriode.non_akademik.prestasi,
        kemampuan: siswaPeriode.non_akademik.kemampuan,
        organisasi: siswaPeriode.non_akademik.organisasi,
        kursus: siswaPeriode.non_akademik.kursus,
        jurusan_1: siswaPeriode.non_akademik.jurusan_1,
        jurusan_2: siswaPeriode.non_akademik.jurusan_2,
      }
    : null;

  return {
    siswa: {
      id: toNumber(siswa.id),
      nis: siswa.nis,
      nama: siswa.nama,
      jenis_kelamin: siswa.jenis_kelamin,
      createdAt: siswa.created_at,
      updatedAt: siswa.updated_at,
    },
    siswa_periode: {
      ...mapSiswaPeriode(siswaPeriode),
      periode: {
        id: toNumber(siswaPeriode.periode.id),
        tahunAjaran: siswaPeriode.periode.tahunAjaran,
        semester: siswaPeriode.periode.semester,
        namaPeriode: siswaPeriode.periode.namaPeriode,
        status: siswaPeriode.periode.status,
      },
    },
    nilai_akademik: mapNilaiAkademik(siswaPeriode.nilai_akademik),
    non_akademik: nonAkademik,
  };
}

// POST /api/siswa — single input manual dalam SATU transaksi 6 operasi (FR-C01).
async function createSiswa(payload) {
  const { nis, nama, jenis_kelamin, kelas, nilai, non_akademik } = payload;

  // Periode target: body.periode_id atau fallback AKTIF (409 bila tidak ada).
  const periodeId = await resolvePeriodeId(payload.periode_id, { throwWhenMissing: true });

  try {
    const result = await prisma.$transaction(async (tx) => {
      // a. Identitas siswa (unique NIS).
      const createdSiswa = await tx.siswa.create({
        data: { nis, nama, jenis_kelamin, created_at: new Date(), updated_at: new Date() },
        select: SAFE_SISWA_SELECT,
      });

      // b/c. Keanggotaan periode dengan flag sumber input manual.
      const createdSiswaPeriode = await tx.siswa_periode.create({
        data: {
          siswa_id: createdSiswa.id,
          periode_id: periodeId,
          kelas,
          source_type: SOURCE_SINGLE_INPUT,
          created_at: new Date(),
          updated_at: new Date(),
        },
      });

      // d. Tiga row nilai_akademik (rapor/pts/pas) — BUKAN auto-duplikasi.
      const nilaiRows = [];
      for (const jenis of JENIS_NILAI) {
        const row = await tx.nilai_akademik.create({
          data: {
            siswa_periode_id: createdSiswaPeriode.id,
            ...buildNilaiData(jenis, nilai[jenis]),
            created_at: new Date(),
            updated_at: new Date(),
          },
        });
        nilaiRows.push(row);
      }

      // e. Satu baris non-akademik (selalu dibuat, field boleh null).
      const na = non_akademik || {};
      const createdNonAkademik = await tx.non_akademik.create({
        data: {
          siswa_periode_id: createdSiswaPeriode.id,
          ekstrakurikuler: na.ekstrakurikuler ?? null,
          prestasi: na.prestasi ?? null,
          kemampuan: na.kemampuan ?? null,
          organisasi: na.organisasi ?? null,
          kursus: na.kursus ?? null,
          jurusan_1: na.jurusan_1 ?? null,
          jurusan_2: na.jurusan_2 ?? null,
          created_at: new Date(),
          updated_at: new Date(),
        },
      });

      return { createdSiswa, createdSiswaPeriode, nilaiRows, createdNonAkademik };
    });

    return {
      ...toResponseItem(result.createdSiswa),
      siswa_periode_id: toNumber(result.createdSiswaPeriode.id),
      periode_id: toNumber(result.createdSiswaPeriode.periode_id),
      kelas: result.createdSiswaPeriode.kelas,
      source_type: result.createdSiswaPeriode.source_type,
      nilai_akademik: mapNilaiAkademik(result.nilaiRows),
      non_akademik: {
        id: toNumber(result.createdNonAkademik.id),
        ekstrakurikuler: result.createdNonAkademik.ekstrakurikuler,
        prestasi: result.createdNonAkademik.prestasi,
        kemampuan: result.createdNonAkademik.kemampuan,
        organisasi: result.createdNonAkademik.organisasi,
        kursus: result.createdNonAkademik.kursus,
        jurusan_1: result.createdNonAkademik.jurusan_1,
        jurusan_2: result.createdNonAkademik.jurusan_2,
      },
    };
  } catch (err) {
    throwUniqueConflict(err);
  }
}

// PUT /api/siswa/:id — update identitas + upsert nilai & non-akademik (FR-C01).
async function updateSiswa(id, payload) {
  const existing = await prisma.siswa.findUnique({ where: { id: BigInt(id) } });
  if (!existing) {
    throw new ApiError(404, 'Siswa tidak ditemukan.');
  }

  const { nis, nama, jenis_kelamin, kelas, nilai, non_akademik } = payload;

  // Bila NIS diubah dan sudah dipakai siswa lain → 409 (cek manual sebelum simpan).
  if (nis && nis !== existing.nis) {
    const bentrok = await prisma.siswa.findFirst({
      where: { nis, NOT: { id: BigInt(id) } },
      select: { id: true },
    });
    if (bentrok) {
      throw new ApiError(409, 'NIS sudah terdaftar.');
    }
  }

  const periodeId = await resolvePeriodeId(payload.periode_id, { throwWhenMissing: true });

  try {
    const result = await prisma.$transaction(async (tx) => {
      // a. Identitas siswa — hanya field yang dikirim.
      const siswaData = {};
      if (nis !== undefined) siswaData.nis = nis;
      if (nama !== undefined) siswaData.nama = nama;
      if (jenis_kelamin !== undefined) siswaData.jenis_kelamin = jenis_kelamin;

      const updatedSiswa = await tx.siswa.update({
        where: { id: BigInt(id) },
        data: { ...siswaData, updated_at: new Date() },
        select: SAFE_SISWA_SELECT,
      });

      // b. Keanggotaan periode (kelas) — buat bila siswa belum terdaftar di periode ini.
      const updatedSiswaPeriode = await tx.siswa_periode.upsert({
        where: { siswa_id_periode_id: { siswa_id: BigInt(id), periode_id: periodeId } },
        update: {
          ...(kelas !== undefined ? { kelas } : {}),
          updated_at: new Date(),
        },
        create: {
          siswa_id: BigInt(id),
          periode_id: periodeId,
          kelas: kelas ?? null,
          source_type: SOURCE_SINGLE_INPUT,
          created_at: new Date(),
          updated_at: new Date(),
        },
      });

      // c. Upsert per jenis_nilai — unique (siswa_periode_id, jenis_nilai).
      const nilaiRows = [];
      for (const jenis of JENIS_NILAI) {
        if (!nilai || nilai[jenis] === undefined) continue;
        const row = await tx.nilai_akademik.upsert({
          where: {
            siswa_periode_id_jenis_nilai: {
              siswa_periode_id: updatedSiswaPeriode.id,
              jenis_nilai: jenis,
            },
          },
          update: { ...buildNilaiData(jenis, nilai[jenis]), updated_at: new Date() },
          create: {
            siswa_periode_id: updatedSiswaPeriode.id,
            ...buildNilaiData(jenis, nilai[jenis]),
            created_at: new Date(),
            updated_at: new Date(),
          },
        });
        nilaiRows.push(row);
      }

      // d. Non-akademik: satu baris per siswa_periode (unique) — upsert penuh.
      let updatedNonAkademik = null;
      if (non_akademik !== undefined) {
        const na = non_akademik || {};
        updatedNonAkademik = await tx.non_akademik.upsert({
          where: { siswa_periode_id: updatedSiswaPeriode.id },
          update: {
            ekstrakurikuler: na.ekstrakurikuler ?? null,
            prestasi: na.prestasi ?? null,
            kemampuan: na.kemampuan ?? null,
            organisasi: na.organisasi ?? null,
            kursus: na.kursus ?? null,
            jurusan_1: na.jurusan_1 ?? null,
            jurusan_2: na.jurusan_2 ?? null,
            updated_at: new Date(),
          },
          create: {
            siswa_periode_id: updatedSiswaPeriode.id,
            ekstrakurikuler: na.ekstrakurikuler ?? null,
            prestasi: na.prestasi ?? null,
            kemampuan: na.kemampuan ?? null,
            organisasi: na.organisasi ?? null,
            kursus: na.kursus ?? null,
            jurusan_1: na.jurusan_1 ?? null,
            jurusan_2: na.jurusan_2 ?? null,
            created_at: new Date(),
            updated_at: new Date(),
          },
        });
      }

      const existingNilai = await tx.nilai_akademik.findMany({
        where: { siswa_periode_id: updatedSiswaPeriode.id },
      });

      return { updatedSiswa, updatedSiswaPeriode, existingNilai, updatedNonAkademik };
    });

    return {
      ...toResponseItem(result.updatedSiswa),
      siswa_periode_id: toNumber(result.updatedSiswaPeriode.id),
      periode_id: toNumber(result.updatedSiswaPeriode.periode_id),
      kelas: result.updatedSiswaPeriode.kelas,
      source_type: result.updatedSiswaPeriode.source_type,
      nilai_akademik: mapNilaiAkademik(result.existingNilai),
      non_akademik: result.updatedNonAkademik
        ? {
            id: toNumber(result.updatedNonAkademik.id),
            ekstrakurikuler: result.updatedNonAkademik.ekstrakurikuler,
            prestasi: result.updatedNonAkademik.prestasi,
            kemampuan: result.updatedNonAkademik.kemampuan,
            organisasi: result.updatedNonAkademik.organisasi,
            kursus: result.updatedNonAkademik.kursus,
            jurusan_1: result.updatedNonAkademik.jurusan_1,
            jurusan_2: result.updatedNonAkademik.jurusan_2,
          }
        : null,
    };
  } catch (err) {
    throwUniqueConflict(err);
  }
}

// DELETE /api/siswa/:id — proteksi RESTRICT cluster_result/recommendation (FR-C03).
async function deleteSiswa(id, periode_id) {
  const siswa = await prisma.siswa.findUnique({ where: { id: BigInt(id) } });
  if (!siswa) {
    throw new ApiError(404, 'Siswa tidak ditemukan.');
  }

  const periodeId = await resolvePeriodeId(periode_id);
  if (!periodeId) {
    throw new ApiError(404, 'Siswa tidak ditemukan.');
  }

  const siswaPeriode = await prisma.siswa_periode.findUnique({
    where: { siswa_id_periode_id: { siswa_id: BigInt(id), periode_id: periodeId } },
  });

  if (!siswaPeriode) {
    throw new ApiError(404, 'Siswa tidak ditemukan.');
  }

  // Guard FR-C03: sudah punya hasil clustering/rekomendasi → blokir (RESTRICT).
  const [clusterCount, rekomendasiCount] = await Promise.all([
    prisma.cluster_result.count({ where: { siswa_periode_id: siswaPeriode.id } }),
    prisma.recommendation.count({ where: { siswa_periode_id: siswaPeriode.id } }),
  ]);

  if (clusterCount > 0 || rekomendasiCount > 0) {
    throw new ApiError(
      409,
      'Siswa tidak dapat dihapus karena sudah memiliki hasil clustering dan rekomendasi.'
    );
  }

  await prisma.$transaction(async (tx) => {
    // Urutan child -> parent (eksplisit, tidak mengandalkan cascade).
    await tx.non_akademik.deleteMany({ where: { siswa_periode_id: siswaPeriode.id } });
    await tx.nilai_akademik.deleteMany({ where: { siswa_periode_id: siswaPeriode.id } });
    await tx.siswa_periode.delete({ where: { id: siswaPeriode.id } });

    // Siswa hanya dihapus bila tidak lagi terdaftar di periode lain.
    const sisaKeanggotaan = await tx.siswa_periode.count({ where: { siswa_id: BigInt(id) } });
    if (sisaKeanggotaan === 0) {
      await tx.siswa.delete({ where: { id: BigInt(id) } });
    }
  });

  return { id: toNumber(siswa.id), nis: siswa.nis, nama: siswa.nama };
}

module.exports = { listSiswa, getSiswaDetail, createSiswa, updateSiswa, deleteSiswa };
