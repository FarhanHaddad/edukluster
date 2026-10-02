const prisma = require('../lib/prisma');
const ApiError = require('../utils/ApiError');

// Vocabulary status periode (app-level, tanpa enum DB).
const STATUS = { AKTIF: 'AKTIF', NONAKTIF: 'NONAKTIF', SELESAI: 'SELESAI' };

// Label human-readable untuk semester tersimpan.
function semesterLabel(semester) {
  return semester === 'GANJIL' ? 'Ganjil' : 'Genap';
}

// RULE WAJIB: BigInt -> Number di semua response + flatten _count siswa_periode.
function toResponseItem(periode) {
  return {
    id: Number(periode.id),
    tahunAjaran: periode.tahunAjaran,
    semester: periode.semester,
    namaPeriode: periode.namaPeriode,
    status: periode.status,
    totalSiswa: periode._count?.siswa_periode ?? 0,
    createdAt: periode.createdAt,
  };
}

const PERIODE_WITH_COUNT_INCLUDE = { include: { _count: { select: { siswa_periode: true } } } };

// GET /api/periodes — daftar periode terbaru dulu (FR-B01).
async function listPeriodes() {
  const periodes = await prisma.periode.findMany({
    orderBy: [{ tahunAjaran: 'desc' }, { semester: 'desc' }],
    ...PERIODE_WITH_COUNT_INCLUDE,
  });

  const items = periodes.map(toResponseItem);
  return { items, total: items.length };
}

// GET /api/periodes/active — satu-satunya periode berstatus AKTIF (FR-B02).
async function getActivePeriode() {
  const periode = await prisma.periode.findFirst({
    where: { status: STATUS.AKTIF },
    ...PERIODE_WITH_COUNT_INCLUDE,
  });

  if (!periode) {
    throw new ApiError(404, 'Belum ada periode aktif.');
  }

  return toResponseItem(periode);
}

// POST /api/periodes — buat periode baru; status awal NONAKTIF (FR-B01).
async function createPeriode({ tahunAjaran, semester }) {
  const namaPeriode = `${tahunAjaran} ${semesterLabel(semester)}`;

  try {
    const periode = await prisma.periode.create({
      data: { tahunAjaran, semester, namaPeriode, status: STATUS.NONAKTIF },
      ...PERIODE_WITH_COUNT_INCLUDE,
    });
    return toResponseItem(periode);
  } catch (err) {
    // Unique constraint periode_index_0 (tahunAjaran, semester).
    if (err && err.code === 'P2002') {
      throw new ApiError(409, `Periode ${namaPeriode} sudah terdaftar.`);
    }
    throw err;
  }
}

// PATCH /api/periodes/:id/activate — aktivasi tunggal via transaksi (FR-B02):
// periode AKTIF lama menjadi SELESAI, target menjadi AKTIF.
async function activatePeriode(id) {
  const target = await prisma.periode.findUnique({ where: { id } });

  if (!target) {
    throw new ApiError(404, 'Periode tidak ditemukan.');
  }
  if (target.status === STATUS.AKTIF) {
    throw new ApiError(409, 'Periode ini sudah aktif.');
  }

  const activated = await prisma.$transaction(async (tx) => {
    await tx.periode.updateMany({
      where: { status: STATUS.AKTIF },
      data: { status: STATUS.SELESAI },
    });
    return tx.periode.update({
      where: { id },
      data: { status: STATUS.AKTIF },
      ...PERIODE_WITH_COUNT_INCLUDE,
    });
  });

  return toResponseItem(activated);
}

module.exports = { listPeriodes, getActivePeriode, createPeriode, activatePeriode };
