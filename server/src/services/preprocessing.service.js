const { Prisma } = require('@prisma/client');
const prisma = require('../lib/prisma');
const ApiError = require('../utils/ApiError');
const { MATA_PELAJARAN_COLUMNS, NON_AKADEMIK_DEFAULTS } = require('../utils/excelConstants');

// ===== Vokabulari app-level (tanpa enum DB).
// Status preprocessing_run: terkunci ACTIVE | COMPLETED | SUPERSEDED (lihat komentar schema BE-PRE-0).
const RUN_STATUS = { ACTIVE: 'ACTIVE', COMPLETED: 'COMPLETED', SUPERSEDED: 'SUPERSEDED' };
// State badge pipeline (kontrak FE FR-D01).
const STAGE_STATE = { MENUNGGU: 'MENUNGGU', SELESAI: 'SELESAI', RESET: 'RESET', TERKUNCI: 'TERKUNCI' };

// 18 mapel numerik (urutan kanonik excelConstants) + kolom non-akademik string.
const NUMERIC_FIELDS = MATA_PELAJARAN_COLUMNS.map((c) => c.dbKey);
const NON_AKADEMIK_FIELDS = ['ekstrakurikuler', 'prestasi', 'kemampuan', 'organisasi', 'kursus', 'jurusan_1', 'jurusan_2'];

// RULE WAJIB: BigInt -> Number di semua response.
function toNumber(value) {
  if (value === null || value === undefined) return null;
  return Number(value);
}

// Prisma Decimal -> string desimal PRESISI PENUH di JSON (mis. "80.0000").
// Kenapa string: oracle membandingkan integrated_data vs workbook dgn tolerance
// absolut ±0.005 — nilai tak-representable binary (mis. 76.6667) TIDAK boleh
// terkorupsi lewat konversi Number/JSON double. FE tinggal Number(v).
function decimalToRaw(value) {
  if (value === null || value === undefined) return null;
  return value.toString();
}

// Resolusi periode target: ?periodeId= eksplisit ATAU periode AKTIF (FR-B02 konvensi).
async function resolvePeriode(periodeId) {
  if (periodeId !== undefined) {
    const periode = await prisma.periode.findUnique({ where: { id: BigInt(periodeId) } });
    if (!periode) throw new ApiError(404, 'Periode tidak ditemukan.');
    return periode;
  }
  const aktif = await prisma.periode.findFirst({ where: { status: 'AKTIF' } });
  // Kontrak BE-PRE-1: tanpa periode AKTIF -> 400 Bahasa Indonesia.
  if (!aktif) throw new ApiError(400, 'Tidak ada periode aktif. Aktifkan satu periode terlebih dahulu.');
  return aktif;
}

// Run TERBARU per periode (deterministik: started_at desc lalu id desc — sama dgn dashboard).
async function findLatestRun(periodeIdBigInt) {
  return prisma.preprocessing_run.findFirst({
    where: { periode_id: periodeIdBigInt },
    orderBy: [{ started_at: 'desc' }, { id: 'desc' }],
  });
}

// Run AKTIF per periode; bila belum ada, buat baru (status ACTIVE, imputation default median).
async function ensureActiveRun(periodeIdBigInt, adminId, adminUsername) {
  const existing = await prisma.preprocessing_run.findFirst({
    where: { periode_id: periodeIdBigInt, status: RUN_STATUS.ACTIVE },
    orderBy: [{ started_at: 'desc' }, { id: 'desc' }],
  });
  if (existing) return existing;

  return prisma.preprocessing_run.create({
    data: {
      periode_id: periodeIdBigInt,
      admin_id: BigInt(adminId),
      imputation_method: 'median', // default run baru; diubah via config cleaning di tiket berikutnya
      status: RUN_STATUS.ACTIVE,
      started_at: new Date(),
    },
  }).catch(async (err) => {
    // Race dua POST bersamaan: pakai run ACTIVE yang menang, bukan 500.
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2002') {
      return prisma.preprocessing_run.findFirst({
        where: { periode_id: periodeIdBigInt, status: RUN_STATUS.ACTIVE },
        orderBy: [{ started_at: 'desc' }, { id: 'desc' }],
      });
    }
    throw err;
  });
}

// ===== Derivasi state 4 stage sesuai matriks invalidasi V-4 revisi.
// - SELESAI   : rows data stage ada pada run.
// - RESET     : penanda *_invalidated_at terisi DAN rows kosong (stage pernah jalan, dihapus).
//               (integrasi/cleaning memakai timestamp eksekusi sebagai penanda pernah jalan.)
// - MENUNGGU  : prasyarat stage sebelumnya SELESAI tapi rows belum ada.
// - TERKUNCI  : prasyarat belum SELESAI.
function buildStages(run, counts, invalidated) {
  const order = ['integrasi', 'cleaning', 'transformasi', 'reduksi'];
  const executedAtField = {
    integrasi: run?.integrated_at ?? null,
    cleaning: run?.cleaned_at ?? null,
    transformasi: run?.transformed_at ?? null,
    reduksi: run?.reduced_at ?? null,
  };
  const durationField = {
    integrasi: run?.integrated_duration_ms ?? null,
    cleaning: run?.cleaned_duration_ms ?? null,
    transformasi: run?.transformed_duration_ms ?? null,
    reduksi: run?.reduced_duration_ms ?? null,
  };
  // Penanda "pernah dieksekusi" utk deteksi RESET: kolom audit / invalidated_at.
  const everRanMarker = {
    integrasi: run?.integrated_at != null,
    cleaning: run?.cleaned_at != null,
    transformasi: invalidated.transformed_invalidated_at != null || run?.transformed_at != null,
    reduksi: invalidated.reduced_invalidated_at != null || run?.reduced_at != null,
  };

  const states = {};
  for (const stage of order) {
    const idx = order.indexOf(stage);
    const prerequisiteDone = idx === 0 ? true : states[order[idx - 1]].state === STAGE_STATE.SELESAI;

    let state;
    if (!prerequisiteDone) {
      state = STAGE_STATE.TERKUNCI;
    } else if (counts[stage] > 0) {
      state = STAGE_STATE.SELESAI;
    } else if (everRanMarker[stage]) {
      state = STAGE_STATE.RESET;
    } else {
      state = STAGE_STATE.MENUNGGU;
    }

    states[stage] = {
      state,
      executedAt: executedAtField[stage] ?? null,
      durationMs: durationField[stage] ?? null,
      adminUsername: executedAtField[stage] != null ? (run?.adminUsername ?? null) : null,
    };
  }
  return states;
}

// Rakit payload pipeline-status dari run + agregat (shape kontrak mentor — jangan diubah).
async function assemblePipelineStatus(periode, adminInfo) {
  const periodeIdBigInt = periode.id;

  const [siswaCount, run] = await Promise.all([
    prisma.siswa_periode.count({ where: { periode_id: periodeIdBigInt } }),
    findLatestRun(periodeIdBigInt),
  ]);

  if (!run) {
    // Empty state (Frame PRE-1D): belum pernah ada run -> semua stage TERKUNCI/MENUNGGU nol.
    return {
      periodeId: toNumber(periodeIdBigInt),
      siswaCount: toNumber(siswaCount),
      lockedByKmeans: false,
      run: null,
    };
  }

  const runIdBigInt = run.id;
  const [integratedCount, cleanedCount, transformedCount, reducedCount, kmeansActiveCount, runAdmin] =
    await Promise.all([
      prisma.integrated_data.count({ where: { preprocessing_run_id: runIdBigInt } }),
      prisma.cleaned_data.count({ where: { preprocessing_run_id: runIdBigInt } }),
      prisma.transformed_data.count({ where: { preprocessing_run_id: runIdBigInt } }),
      prisma.reduced_data.count({ where: { preprocessing_run_id: runIdBigInt } }),
      prisma.kmeans_run.count({ where: { preprocessing_run_id: runIdBigInt, status: 'ACTIVE' } }),
      prisma.admin.findUnique({ where: { id: run.admin_id }, select: { username: true } }),
    ]);

  const stages = buildStages(
    { ...run, adminUsername: runAdmin?.username ?? null },
    { integrasi: integratedCount, cleaning: cleanedCount, transformasi: transformedCount, reduksi: reducedCount },
    {
      transformed_invalidated_at: run.transformed_invalidated_at,
      reduced_invalidated_at: run.reduced_invalidated_at,
    }
  );

  return {
    periodeId: toNumber(periodeIdBigInt),
    siswaCount: toNumber(siswaCount),
    lockedByKmeans: kmeansActiveCount > 0,
    run: {
      id: toNumber(run.id),
      imputationMethod: run.imputation_method,
      status: run.status,
      startedAt: run.started_at,
      completedAt: run.completed_at,
      adminUsername: runAdmin?.username ?? null,
      stages,
    },
  };
}

// GET /api/preprocessing/pipeline-status (FR-D01 + badge pipeline + empty state).
async function getPipelineStatus(query, adminInfo) {
  const periode = await resolvePeriode(query.periodeId);
  return assemblePipelineStatus(periode, adminInfo);
}

// ===== GET /api/preprocessing/source-preview — raw values 4 tab sumber (Frame PRE-1D).
const AKADEMIK_JENIS_SET = { rapor: 'rapor', pts: 'pts', pas: 'pas' };

function mapAkademikRow(sp, nilaiRow) {
  const values = {};
  for (const key of NUMERIC_FIELDS) {
    // Raw DB: Decimal -> string presisi penuh; tidak ada row jenis ini -> null.
    values[key] = nilaiRow ? decimalToRaw(nilaiRow[key]) : null;
  }
  return { nis: sp.siswa.nis ?? null, nama: sp.siswa.nama ?? null, values };
}

function mapNonAkademikRow(sp, naRow) {
  const values = {};
  for (const key of NON_AKADEMIK_FIELDS) {
    // Raw value; sel kosong/record absen -> default kamus import ("Tidak Ada"/"Tidak Mengikuti", dst).
    const raw = naRow?.[key];
    values[key] = raw !== null && raw !== undefined && String(raw).trim() !== ''
      ? raw
      : NON_AKADEMIK_DEFAULTS[key];
  }
  return { nis: sp.siswa.nis ?? null, nama: sp.siswa.nama ?? null, values };
}

async function getSourcePreview({ jenis, page, limit, periodeId }) {
  const periode = await resolvePeriode(periodeId);
  const whereSp = { periode_id: periode.id };

  const [total, siswaPeriodes] = await Promise.all([
    prisma.siswa_periode.count({ where: whereSp }),
    prisma.siswa_periode.findMany({
      where: whereSp,
      include: { siswa: { select: { nis: true, nama: true } } },
      orderBy: [{ id: 'asc' }],
      skip: (page - 1) * limit,
      take: limit,
    }),
  ]);

  let rows;
  if (jenis === 'non_akademik') {
    const ids = siswaPeriodes.map((sp) => sp.id);
    const naRows = await prisma.non_akademik.findMany({ where: { siswa_periode_id: { in: ids } } });
    const byId = new Map(naRows.map((r) => [toNumber(r.siswa_periode_id), r]));
    rows = siswaPeriodes.map((sp) => mapNonAkademikRow(sp, byId.get(toNumber(sp.id))));
  } else {
    const ids = siswaPeriodes.map((sp) => sp.id);
    const nilaiRows = await prisma.nilai_akademik.findMany({
      where: { siswa_periode_id: { in: ids }, jenis_nilai: AKADEMIK_JENIS_SET[jenis] },
    });
    const byId = new Map(nilaiRows.map((r) => [toNumber(r.siswa_periode_id), r]));
    rows = siswaPeriodes.map((sp) => mapAkademikRow(sp, byId.get(toNumber(sp.id))));
  }

  return { total: toNumber(total), page, limit, rows };
}

// ===== POST /api/preprocessing/integration — jalankan stage integrasi pada run AKTIF.
// Integrasi = rata-rata aritmetik non-null dari 3 jenis nilai (rapor/pts/pas) per mapel,
// hasil Decimal(8,4) EKSAK (pembulatan HALF_UP ke 4 desimal lewat Prisma.Decimal).
// Non-akademik disalin apa adanya dari tabel non_akademik (null -> default kamus).
// Matriks V-4: re-run Integration -> run lama SUPERSEDED + reset Cleaning+Transformasi+Reduksi.
async function runIntegration(adminInfo, query) {
  const startedWall = Date.now();
  const periode = await resolvePeriode(query.periodeId);
  const periodeIdBigInt = periode.id;

  const siswaCount = await prisma.siswa_periode.count({ where: { periode_id: periodeIdBigInt } });
  if (siswaCount === 0) {
    throw new ApiError(422, 'Belum ada siswa pada periode aktif. Tambahkan atau impor data siswa terlebih dahulu sebelum menjalankan integrasi.');
  }

  // Run AKTIF saat ini (buat baru bila belum ada run sama sekali).
  const activeRun = await ensureActiveRun(periodeIdBigInt, adminInfo.id, adminInfo.username);

  // Deteksi re-run sebelum transaksi: run aktif sudah punya hasil stage (rows ATAU
  // timestamp eksekusi hilir) -> sesuai matriks V-4 harus dibuat run baru.
  const [priorIntegrated, priorCleaned, priorTransformed, priorReduced] = await Promise.all([
    prisma.integrated_data.count({ where: { preprocessing_run_id: activeRun.id } }),
    prisma.cleaned_data.count({ where: { preprocessing_run_id: activeRun.id } }),
    prisma.transformed_data.count({ where: { preprocessing_run_id: activeRun.id } }),
    prisma.reduced_data.count({ where: { preprocessing_run_id: activeRun.id } }),
  ]);
  const isRerun =
    priorIntegrated > 0 || priorCleaned > 0 || priorTransformed > 0 || priorReduced > 0;

  // Jalur cepat: run belum pernah dieksekusi sama sekali -> TIDAK ada invalidasi (no-op),
  // cukup jalankan integrasi pada run ACTIVE yang sama.
  const neverExecuted =
    priorIntegrated === 0 && priorCleaned === 0 && priorTransformed === 0 && priorReduced === 0 &&
    activeRun.cleaned_at == null && activeRun.transformed_at == null && activeRun.reduced_at == null;

  const run = await prisma.$transaction(async (tx) => {
    let target = activeRun;

    if (!neverExecuted) {
      // Matriks V-4: re-run Integration -> run baru (ACTIVE); run lama SUPERSEDED
      // dengan penanda invalidasi Cleaning+Transformasi+Reduksi di-reset.
      target = await tx.preprocessing_run.create({
        data: {
          periode_id: periodeIdBigInt,
          admin_id: BigInt(adminInfo.id),
          imputation_method: activeRun.imputation_method,
          status: RUN_STATUS.ACTIVE,
          started_at: new Date(),
        },
      });
      await tx.preprocessing_run.update({
        where: { id: activeRun.id },
        data: {
          status: RUN_STATUS.SUPERSEDED,
          completed_at: new Date(),
          cleaned_at: null,
          cleaned_duration_ms: null,
          transformed_at: null,
          transformed_duration_ms: null,
          reduced_at: null,
          reduced_duration_ms: null,
          // Penanda invalidasi utk audit (stage hilir run lama dianggap di-reset).
          transformed_invalidated_at: new Date(),
          reduced_invalidated_at: new Date(),
        },
      });
    } else {
      // Eksekusi pertama / retry pada run ACTIVE yang sama: bersihkan rows integrasi lama.
      await tx.integrated_data.deleteMany({ where: { preprocessing_run_id: target.id } });
    }

    // Ambil seluruh data mentah periode ini (1 query per tabel, lalu agregat in-memory).
    const [nilaiRows, nonAkRows, spList] = await Promise.all([
      tx.nilai_akademik.findMany({ where: { siswa_periode: { periode_id: periodeIdBigInt } } }),
      tx.non_akademik.findMany({ where: { siswa_periode: { periode_id: periodeIdBigInt } } }),
      tx.siswa_periode.findMany({
        where: { periode_id: periodeIdBigInt },
        select: { id: true },
        orderBy: { id: 'asc' },
      }),
    ]);

    // Index: spId -> { rapor, pts, pas } dan spId -> row non_akademik.
    const nilaiBySp = new Map();
    for (const n of nilaiRows) {
      const k = toNumber(n.siswa_periode_id);
      if (!nilaiBySp.has(k)) nilaiBySp.set(k, {});
      nilaiBySp.get(k)[n.jenis_nilai] = n;
    }
    const nonAkBySp = new Map(nonAkRows.map((r) => [toNumber(r.siswa_periode_id), r]));

    const creates = spList.map((sp) => {
      const k = toNumber(sp.id);
      const byJenis = nilaiBySp.get(k) ?? {};
      const na = nonAkBySp.get(k);

      const row = { preprocessing_run_id: target.id, siswa_periode_id: sp.id };

      // Rata-rata non-null dari jenis yang ADA — Decimal eksak, HALF_UP ke 4 desimal.
      for (const field of NUMERIC_FIELDS) {
        const parts = [];
        for (const jenis of ['rapor', 'pts', 'pas']) {
          const v = byJenis[jenis]?.[field];
          if (v !== null && v !== undefined) parts.push(v);
        }
        if (parts.length === 0) {
          row[field] = null; // tetap null bila tidak ada satu pun jenis (tanpa imputasi di sini)
        } else {
          const sum = parts.reduce((acc, v) => acc.add(v), new Prisma.Decimal(0));
          row[field] = sum.div(parts.length).toDecimalPlaces(4, Prisma.Decimal.ROUND_HALF_UP);
        }
      }

      // Non-akademik: salin raw; kosong -> default kamus (konsisten dgn source-preview).
      for (const field of NON_AKADEMIK_FIELDS) {
        const raw = na?.[field];
        row[field] = raw !== null && raw !== undefined && String(raw).trim() !== ''
          ? raw
          : NON_AKADEMIK_DEFAULTS[field];
      }
      return row;
    });

    if (creates.length > 0) {
      await tx.integrated_data.createMany({ data: creates });
    }

    // Audit stage integrasi pada run target.
    const finishedAt = new Date();
    await tx.preprocessing_run.update({
      where: { id: target.id },
      data: {
        integrated_at: finishedAt,
        integrated_duration_ms: Math.max(0, finishedAt.getTime() - startedWall),
      },
    });

    return target;
  });

  // Response = shape pipeline-status TERBARU (kontrak mentor).
  return assemblePipelineStatus(periode);
}

module.exports = {
  getPipelineStatus,
  getSourcePreview,
  runIntegration,
  _internals: { STAGE_STATE, RUN_STATUS, buildStages, resolvePeriode },
};
