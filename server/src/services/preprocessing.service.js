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

// ===== BE-PRE-2 Cleaning: statistik missing + mapping L1 + imputasi GLOBAL.
// Keputusan Owner: imputasi dihitung LINTAS seluruh siswa periode (bukan per kelas).
// Imputasi HANYA utk 18 mapel akademik — non-akademik sudah di-default saat Integrasi.

const IMPUTATION_METHODS = ['mean', 'median', 'mode'];

// Nilai terimputasi utk satu kolom dari daftar nilai non-null (sudah dibulatkan Decimal 4 dp).
// - mean   : jumlah / n (HALF_UP 4 dp)
// - median : rata-rata dua nilai tengah bila genap (standar; HALF_UP 4 dp)
// - mode   : nilai dengan frekuensi tertinggi; seri lengkap -> null (tidak ada dominasi)
// Edge-case didokumentasikan: semua metode menghasilkan null bila TIDAK ADA nilai sama sekali.
function computeImputedValue(method, values) {
  if (!values || values.length === 0) return null;
  const dec = values.map((v) => new Prisma.Decimal(v));
  if (method === 'mean') {
    const sum = dec.reduce((acc, v) => acc.add(v), new Prisma.Decimal(0));
    return sum.div(dec.length).toDecimalPlaces(4, Prisma.Decimal.ROUND_HALF_UP);
  }
  if (method === 'median') {
    const sorted = [...dec].sort((a, b) => a.cmp(b));
    const mid = Math.floor(sorted.length / 2);
    if (sorted.length % 2 === 1) return sorted[mid].toDecimalPlaces(4, Prisma.Decimal.ROUND_HALF_UP);
    return sorted[mid - 1]
      .add(sorted[mid])
      .div(2)
      .toDecimalPlaces(4, Prisma.Decimal.ROUND_HALF_UP);
  }
  // mode
  const freq = new Map();
  for (const v of dec) {
    const k = v.toFixed(4);
    freq.set(k, (freq.get(k) ?? 0) + 1);
  }
  let bestKey = null;
  let bestCount = 0;
  let tie = false;
  for (const [k, c] of freq) {
    if (c > bestCount) { bestKey = k; bestCount = c; tie = false; }
    else if (c === bestCount) { tie = true; }
  }
  if (bestKey === null || tie) return null; // semua unik / seri tanpa dominan -> biarkan null
  return new Prisma.Decimal(bestKey);
}

// Ambil hasil integrasi run AKTIF (dipakai config & eksekusi cleaning).
async function getActiveRunIntegratedRows(periodeIdBigInt) {
  const activeRun = await prisma.preprocessing_run.findFirst({
    where: { periode_id: periodeIdBigInt, status: RUN_STATUS.ACTIVE },
    orderBy: [{ started_at: 'desc' }, { id: 'desc' }],
  });
  if (!activeRun) return { activeRun: null, integratedRows: [] };
  const integratedRows = await prisma.integrated_data.findMany({
    where: { preprocessing_run_id: activeRun.id },
    orderBy: { siswa_periode_id: 'asc' },
  });
  return { activeRun, integratedRows };
}

// GET /api/preprocessing/cleaning/config — distribusi raw non-akademik + mapping L1
// run aktif (pre-fill identity bila rawValue belum ter-mapping) + statistik missing akademik.
async function getCleaningConfig(query) {
  const periode = await resolvePeriode(query.periodeId);
  const { activeRun, integratedRows } = await getActiveRunIntegratedRows(periode.id);

  // Mapping L1 tersimpan pada run aktif (category_mapping per run).
  let mappingsByField = {};
  if (activeRun) {
    const mappingRows = await prisma.category_mapping.findMany({
      where: { preprocessing_run_id: activeRun.id },
    });
    for (const m of mappingRows) {
      if (!m.field_name || !m.raw_value) continue;
      (mappingsByField[m.field_name] ??= []).push({
        rawValue: m.raw_value,
        standardValue: m.standard_value ?? m.raw_value,
      });
    }
  }

  const fields = NON_AKADEMIK_FIELDS.map((fieldName) => {
    // GROUP BY in-memory atas kolom ini di integrated_data (null tidak dihitung —
    // Integrasi sudah mengisi default kamus sehingga praktis tidak ada null di sini).
    const counts = new Map();
    for (const row of integratedRows) {
      const raw = row[fieldName];
      if (raw === null || raw === undefined) continue;
      counts.set(raw, (counts.get(raw) ?? 0) + 1);
    }
    const rawDistribution = [...counts.entries()]
      .map(([rawValue, count]) => ({ rawValue, count }))
      .sort((a, b) => b.count - a.count || String(a.rawValue).localeCompare(String(b.rawValue)));

    const stored = mappingsByField[fieldName] ?? [];
    const storedByRaw = new Map(stored.map((m) => [m.rawValue, m.standardValue]));
    // Pre-fill identity utk rawValue yang belum punya category_mapping.
    const mappings = rawDistribution.map(({ rawValue }) => ({
      rawValue,
      standardValue: storedByRaw.has(rawValue) ? storedByRaw.get(rawValue) : rawValue,
    }));

    return { fieldName, rawDistribution, mappings };
  });

  // Statistik missing 18 mapel akademik: sel NULL vs total siswa terintegrasi.
  const academicMissing = NUMERIC_FIELDS.map((fieldName) => {
    let missingCount = 0;
    for (const row of integratedRows) {
      if (row[fieldName] === null || row[fieldName] === undefined) missingCount += 1;
    }
    return { fieldName, missingCount, totalCount: integratedRows.length };
  });

  return {
    imputationMethod: activeRun?.imputation_method ?? null,
    fields,
    academicMissing,
  };
}

// POST /api/preprocessing/cleaning — jalankan stage cleaning pada run AKTIF.
// Kontrak BE-PRE-2 (transaksi atomik):
// a) replace category_mapping run aktif; b) imputasi GLOBAL 18 mapel (abaikan NULL);
// c) apply mapping L1 ke 7 non-akademik; d) bulk insert cleaned_data;
// e) audit cleaned_at/duration/imputation_method; f) invalidasi hilir V-4
// (transformed_invalidated_at & reduced_invalidated_at = now, DELETE transformed/reduced rows);
// g) response = shape pipeline-status terbaru.
async function runCleaning(body, adminInfo, query) {
  const startedWall = Date.now();
  const periode = await resolvePeriode(query.periodeId);
  const periodeIdBigInt = periode.id;

  const { activeRun, integratedRows } = await getActiveRunIntegratedRows(periodeIdBigInt);
  if (!activeRun || integratedRows.length === 0) {
    throw new ApiError(400, 'Stage integrasi belum selesai dijalankan. Jalankan integrasi terlebih dahulu sebelum cleaning.');
  }

  // Normalisasi body.mappings -> Map(field -> Map(raw -> standard)), hanya entri string.
  const mappingMap = new Map();
  for (const [fieldName, pairs] of Object.entries(body.mappings ?? {})) {
    if (!NON_AKADEMIK_FIELDS.includes(fieldName) || typeof pairs !== 'object' || pairs === null) continue;
    const inner = new Map();
    for (const [rawValue, standardValue] of Object.entries(pairs)) {
      if (typeof standardValue !== 'string') continue;
      inner.set(rawValue, standardValue);
    }
    if (inner.size > 0) mappingMap.set(fieldName, inner);
  }

  // (b) Imputasi GLOBAL: kumpulkan nilai non-null per mapel lintas seluruh siswa run ini.
  const method = body.imputationMethod;
  const imputedByField = {};
  for (const field of NUMERIC_FIELDS) {
    const present = [];
    for (const row of integratedRows) {
      const v = row[field];
      if (v !== null && v !== undefined) present.push(v);
    }
    imputedByField[field] = computeImputedValue(method, present);
  }

  const targetRunId = activeRun.id;
  const now = new Date();

  await prisma.$transaction(async (tx) => {
    // (a) Replace mapping L1 run aktif.
    await tx.category_mapping.deleteMany({ where: { preprocessing_run_id: targetRunId } });
    const mappingCreates = [];
    for (const [fieldName, inner] of mappingMap) {
      for (const [rawValue, standardValue] of inner) {
        mappingCreates.push({
          preprocessing_run_id: targetRunId,
          field_name: fieldName,
          raw_value: rawValue,
          standard_value: standardValue,
        });
      }
    }
    if (mappingCreates.length > 0) {
      await tx.category_mapping.createMany({ data: mappingCreates });
    }

    // (c)+(d) Bangun & simpan cleaned_data (bulk) utk seluruh baris integrasi run aktif.
    await tx.cleaned_data.deleteMany({ where: { preprocessing_run_id: targetRunId } });
    const creates = integratedRows.map((row) => {
      const out = {
        preprocessing_run_id: targetRunId,
        siswa_periode_id: row.siswa_periode_id,
      };
      for (const field of NUMERIC_FIELDS) {
        const v = row[field];
        // Sel missing akademik diisi nilai imputasi GLOBAL; tetap null bila
        // imputasi tak terdefinisi (mis. mode seri lengkap tanpa dominasi).
        out[field] = v !== null && v !== undefined ? v : imputedByField[field];
      }
      for (const field of NON_AKADEMIK_FIELDS) {
        const raw = row[field];
        const inner = mappingMap.get(field);
        // Identity fallback bila rawValue tidak ada di mapping FE (tetap ter-standardisasi).
        out[field] = inner?.get(raw) ?? raw;
      }
      return out;
    });
    if (creates.length > 0) {
      await tx.cleaned_data.createMany({ data: creates });
    }

    // (f) Invalidasi hilir sesuai matriks V-4: Transformasi & Reduksi WAJIB di-reset.
    await tx.transformed_data.deleteMany({ where: { preprocessing_run_id: targetRunId } });
    await tx.reduced_data.deleteMany({ where: { preprocessing_run_id: targetRunId } });

    // (e) Audit stage cleaning + penanda invalidasi hilir.
    const finishedAt = new Date();
    await tx.preprocessing_run.update({
      where: { id: targetRunId },
      data: {
        cleaned_at: finishedAt,
        cleaned_duration_ms: Math.max(0, finishedAt.getTime() - startedWall),
        imputation_method: method,
        transformed_invalidated_at: now,
        reduced_invalidated_at: now,
      },
    });
  });

  // (g) Response = shape pipeline-status terbaru (kontrak mentor).
  return assemblePipelineStatus(periode);
}

// ===== BE-PRE-3 Transformasi: Kamus Bidang per Periode (L2) + Encode + Min-Max.
// Model dua lapis: L1 standardisasi (category_mapping, per run — selesai di BE-PRE-2);
// L2 pemetaan nilai standar -> bidang berkode (category_option + category_assignment,
// per periode). Ruling terkunci: V-3 kode CREATE-ONLY (tanpa endpoint update);
// V-2 kolom konstan (min=max) saat Min-Max -> 0; V-4 mutasi assignment/hapus bidang
// saat transformed_data ada -> invalidasi hilir; buat bidang TANPA assignment = TIDAK invalidate.

const { KAMUS_BIDANG } = require('../constants/kamus-bidang');

// Lazy seed kamus: bila kategori option periode = 0 baris, insert seluruh KAMUS_BIDANG
// dalam SATU transaksi. Idempoten — aman dipanggil berkali-kali (race dua GET perdana:
// yang menang insert, yang kalah melihat count>0 dan skip).
async function ensureKamusSeeded(tx, periodeIdBigInt) {
  const existing = await tx.category_option.count({ where: { periode_id: periodeIdBigInt } });
  if (existing > 0) return false;
  const creates = [];
  for (const [fieldName, entries] of Object.entries(KAMUS_BIDANG)) {
    for (const { name, code } of entries) {
      creates.push({ periode_id: periodeIdBigInt, field_name: fieldName, name, code });
    }
  }
  await tx.category_option.createMany({ data: creates });
  return true;
}

// Run AKTIF + row cleaned_data-nya (prasyarat semua endpoint transform).
async function getActiveRunCleanedRows(periodeIdBigInt) {
  const activeRun = await prisma.preprocessing_run.findFirst({
    where: { periode_id: periodeIdBigInt, status: RUN_STATUS.ACTIVE },
    orderBy: [{ started_at: 'desc' }, { id: 'desc' }],
  });
  if (!activeRun) return { activeRun: null, cleanedRows: [] };
  const cleanedRows = await prisma.cleaned_data.findMany({
    where: { preprocessing_run_id: activeRun.id },
    orderBy: { siswa_periode_id: 'asc' },
  });
  return { activeRun, cleanedRows };
}

// Distribusi distinct nilai standar per field dari cleaned_data run aktif (list terurut).
function stdValueCounts(cleanedRows, fieldName) {
  const counts = new Map();
  for (const row of cleanedRows) {
    const v = row[fieldName];
    if (v === null || v === undefined) continue;
    counts.set(v, (counts.get(v) ?? 0) + 1);
  }
  return [...counts.entries()]
    .map(([standardValue, count]) => ({ standardValue, count }))
    .sort((a, b) => b.count - a.count || String(a.standardValue).localeCompare(String(b.standardValue)));
}

// Invalidasi hilir sesuai matriks V-4: DELETE transformed_data + reduced_data run aktif,
// set transformed_invalidated_at & reduced_invalidated_at = now(). Hanya bila ada
// transformed_data pada run aktif (mutasi assignment / hapus bidang).
async function invalidateDownstreamIfTransformed(tx, runIdBigInt, now) {
  const transformedCount = await tx.transformed_data.count({ where: { preprocessing_run_id: runIdBigInt } });
  if (transformedCount === 0) return false;
  await tx.transformed_data.deleteMany({ where: { preprocessing_run_id: runIdBigInt } });
  await tx.reduced_data.deleteMany({ where: { preprocessing_run_id: runIdBigInt } });
  await tx.preprocessing_run.update({
    where: { id: runIdBigInt },
    data: { transformed_invalidated_at: now, reduced_invalidated_at: now },
  });
  return true;
}

// GET /api/preprocessing/transform/config — kamus bidang (opsi + assignedValues + unmapped).
// 400 Bahasa Indonesia bila Cleaning belum SELESAI (kontrak; Gate FE disable CTA "Jalankan").
async function getTransformConfig(query) {
  const periode = await resolvePeriode(query.periodeId);
  const { activeRun, cleanedRows } = await getActiveRunCleanedRows(periode.id);
  if (!activeRun || cleanedRows.length === 0) {
    throw new ApiError(400, 'Stage cleaning belum selesai dijalankan. Jalankan cleaning terlebih dahulu sebelum konfigurasi transformasi.');
  }

  // Lazy seed kamus bidang utk periode ini (AC oracle: GET config perdana -> DB terisi).
  await prisma.$transaction(async (tx) => { await ensureKamusSeeded(tx, periode.id); });

  const [options, assignments] = await Promise.all([
    prisma.category_option.findMany({
      where: { periode_id: periode.id },
      orderBy: [{ field_name: 'asc' }, { code: 'asc' }],
    }),
    prisma.category_assignment.findMany({ where: { periode_id: periode.id } }),
  ]);

  const assignedByFieldOption = new Map(); // `${field}\u0000${optionId}` -> rows
  const assignedSet = new Set(); // `${field}\u0000${standardValue}`
  for (const a of assignments) {
    const key = `${a.field_name}\u0000${toNumber(a.option_id)}`;
    if (!assignedByFieldOption.has(key)) assignedByFieldOption.set(key, []);
    assignedByFieldOption.get(key).push(a);
    assignedSet.add(`${a.field_name}\u0000${a.standard_value}`);
  }

  // Distribusi distinct nilai standar per field dari cleaned_data run aktif —
  // dipakai untuk mengisi `count` pada assignedValues DAN unmapped (kontrak:
  // count = jumlah siswa dengan nilai standar tersebut di run aktif).
  const stdCountsByField = new Map();
  for (const fieldName of NON_AKADEMIK_FIELDS) {
    const map = new Map();
    for (const { standardValue, count } of stdValueCounts(cleanedRows, fieldName)) {
      map.set(standardValue, count);
    }
    stdCountsByField.set(fieldName, map);
  }

  const optionsByField = new Map();
  for (const o of options) {
    if (!optionsByField.has(o.field_name)) optionsByField.set(o.field_name, []);
    optionsByField.get(o.field_name).push(o);
  }

  const fields = NON_AKADEMIK_FIELDS.map((fieldName) => {
    const fieldCounts = stdCountsByField.get(fieldName);
    const fieldOptions = (optionsByField.get(fieldName) ?? []).map((o) => {
      const assigned = assignedByFieldOption.get(`${fieldName}\u0000${toNumber(o.id)}`) ?? [];
      const assignedValues = assigned
        .map((a) => ({ standardValue: a.standard_value, count: fieldCounts.get(a.standard_value) ?? 0 }))
        .sort((x, y) => y.count - x.count || String(x.standardValue).localeCompare(String(y.standardValue)));
      return { id: toNumber(o.id), name: o.name, code: o.code, assignedValues };
    });
    const unmapped = stdValueCounts(cleanedRows, fieldName)
      .filter(({ standardValue }) => !assignedSet.has(`${fieldName}\u0000${standardValue}`))
      .map(({ standardValue, count }) => ({ standardValue, count }));
    return { fieldName, options: fieldOptions, unmapped };
  });

  return { fields };
}

// POST /api/preprocessing/transform/options — buat bidang kamus (CREATE-ONLY, V-3).
// code default = max(code)+1 per (periode, field) bila tidak dikirim.
// Duplikat (periode,field,name) ATAU (periode,field,code) -> 422 Bahasa Indonesia.
// TIDAK invalidate hilir (buat bidang tanpa assignment = no-op bagi data hilir).
async function createTransformOption(body, query) {
  const periode = await resolvePeriode(query.periodeId);
  if (!NON_AKADEMIK_FIELDS.includes(body.fieldName)) {
    throw new ApiError(400, 'Field tidak termasuk field non-akademik yang dapat ditransformasi.');
  }

  const option = await prisma.$transaction(async (tx) => {
    // Seed dulu agar tabrakan dgn kode kamus terdeteksi sebagai duplikat (422), bukan 500.
    await ensureKamusSeeded(tx, periode.id);

    const dupName = await tx.category_option.findFirst({
      where: { periode_id: periode.id, field_name: body.fieldName, name: body.name },
      select: { id: true },
    });
    if (dupName) {
      throw new ApiError(422, `Nama bidang "${body.name}" sudah ada pada field "${body.fieldName}" untuk periode ini.`);
    }

    let code = body.code;
    if (code === undefined) {
      const maxRow = await tx.category_option.aggregate({
        where: { periode_id: periode.id, field_name: body.fieldName },
        _max: { code: true },
      });
      code = (maxRow._max.code ?? -1) + 1;
    } else {
      const dupCode = await tx.category_option.findFirst({
        where: { periode_id: periode.id, field_name: body.fieldName, code },
        select: { id: true },
      });
      if (dupCode) {
        throw new ApiError(422, `Kode bidang ${code} sudah dipakai pada field "${body.fieldName}" untuk periode ini.`);
      }
    }

    return tx.category_option.create({
      data: { periode_id: periode.id, field_name: body.fieldName, name: body.name, code },
    });
  });

  return { id: toNumber(option.id), fieldName: option.field_name, name: option.name, code: option.code };
}

// DELETE /api/preprocessing/transform/options/:id — trash bidang; assignment cascade hilang
// -> nilai standar balik ke unmapped. JIKA transformed_data run aktif ada -> invalidasi V-4.
async function deleteTransformOption(idParam, query) {
  const periode = await resolvePeriode(query.periodeId);
  const now = new Date();

  const result = await prisma.$transaction(async (tx) => {
    const option = await tx.category_option.findUnique({ where: { id: BigInt(idParam.id) } });
    if (!option || toNumber(option.periode_id) !== toNumber(periode.id)) {
      throw new ApiError(404, 'Opsi bidang tidak ditemukan untuk periode ini.');
    }
    await tx.category_option.delete({ where: { id: option.id } }); // assignment ON DELETE CASCADE
    const invalidated = await invalidateDownstreamIfTransformed(tx, periode.id, now);
    return { fieldName: option.field_name, code: option.code, name: option.name, invalidated };
  });

  return {
    id: toNumber(idParam.id),
    fieldName: result.fieldName,
    name: result.name,
    code: result.code,
    downstreamInvalidated: result.invalidated,
  };
}

// POST /api/preprocessing/transform/assignments — upsert L2 (unique periode+field+standard_value).
// optionId WAJIB milik (periode, field) yg sama. JIKA transformed_data run aktif ada -> V-4.
async function saveTransformAssignments(body, query) {
  const periode = await resolvePeriode(query.periodeId);
  if (!NON_AKADEMIK_FIELDS.includes(body.fieldName)) {
    throw new ApiError(400, 'Field tidak termasuk field non-akademik yang dapat ditransformasi.');
  }
  const now = new Date();
  // De-dup input (last-wins) agar createMany tidak menabrak unique-nya sendiri.
  const values = [...new Set(body.standardValues)];

  const result = await prisma.$transaction(async (tx) => {
    const option = await tx.category_option.findUnique({ where: { id: BigInt(body.optionId) } });
    if (!option || toNumber(option.periode_id) !== toNumber(periode.id)) {
      throw new ApiError(404, 'Opsi bidang tidak ditemukan untuk periode ini.');
    }
    if (option.field_name !== body.fieldName) {
      throw new ApiError(422, 'Opsi bidang tidak sesuai field yang diminta.');
    }

    // Re-map: assignment lama utk nilai-nilai ini diganti (upsert) -> menunjuk option baru.
    await tx.category_assignment.deleteMany({
      where: {
        periode_id: periode.id,
        field_name: body.fieldName,
        standard_value: { in: values },
      },
    });
    await tx.category_assignment.createMany({
      data: values.map((standardValue) => ({
        periode_id: periode.id,
        field_name: body.fieldName,
        standard_value: standardValue,
        option_id: option.id,
      })),
    });

    const invalidated = await invalidateDownstreamIfTransformed(tx, periode.id, now);
    return { option, invalidated };
  });

  return {
    fieldName: body.fieldName,
    optionId: toNumber(result.option.id),
    assignedCount: values.length,
    downstreamInvalidated: result.invalidated,
  };
}

// Min-Max satu kolom Decimal lintas seluruh siswa (V-2: kolom konstan min==max -> 0).
// Presisi penuh via Prisma.Decimal; HALF_UP 4 dp sesuai kolom Decimal(8,4).
function minMaxNormalizeColumn(values, min, max) {
  const range = max.sub(min);
  const out = [];
  for (const v of values) {
    if (v === null || v === undefined) { out.push(null); continue; }
    if (range.isZero()) { out.push(new Prisma.Decimal(0)); continue; } // V-2
    out.push(v.sub(min).div(range).toDecimalPlaces(4, Prisma.Decimal.ROUND_HALF_UP));
  }
  return out;
}

// POST /api/preprocessing/transform/run — Gate + Encode + Min-Max + audit + clear flag hilir.
// Gate: cleaning SELESAI else 400; unmapped tidak kosong else 422 berisi daftar unmapped.
// Encode: 7 field non-akademik = cleaned value -> assignment -> code option.
// Min-Max: 25 kolom (18 akademik + 7 code) Decimal(8,4) LINTAS seluruh siswa run aktif.
// Re-run: delete+insert transformed_data run aktif dalam satu transaksi; sukses ->
// clear transformed_invalidated_at DAN reduced_invalidated_at (Reduksi jadi MENUNGGU, bukan RESET).
async function runTransform(adminInfo, query) {
  const startedWall = Date.now();
  const periode = await resolvePeriode(query.periodeId);
  const periodeIdBigInt = periode.id;

  const { activeRun, cleanedRows } = await getActiveRunCleanedRows(periodeIdBigInt);
  if (!activeRun || cleanedRows.length === 0) {
    throw new ApiError(400, 'Stage cleaning belum selesai dijalankan. Jalankan cleaning terlebih dahulu sebelum transformasi.');
  }

  // Gate unmapped: setiap distinct nilai standar wajib punya category_assignment.
  const assignments = await prisma.category_assignment.findMany({ where: { periode_id: periodeIdBigInt } });
  const assignedSet = new Set(assignments.map((a) => `${a.field_name}\u0000${a.standard_value}`));
  const unmappedList = [];
  for (const fieldName of NON_AKADEMIK_FIELDS) {
    for (const { standardValue, count } of stdValueCounts(cleanedRows, fieldName)) {
      if (!assignedSet.has(`${fieldName}\u0000${standardValue}`)) {
        unmappedList.push({ fieldName, standardValue, count });
      }
    }
  }
  if (unmappedList.length > 0) {
    const err = new ApiError(422, 'Transformasi tidak dapat dijalankan: masih ada nilai standar yang belum dipetakan ke bidang.');
    err.payload = { unmapped: unmappedList };
    throw err;
  }

  const targetRunId = activeRun.id;
  const finishedAt = new Date();

  await prisma.$transaction(async (tx) => {
    // Peta lookup: field+standard_value -> code option (include opsi utk validasi kepemilikan).
    const rowsWithOption = await tx.category_assignment.findMany({
      where: { periode_id: periodeIdBigInt },
      include: { option: { select: { code: true, periode_id: true, field_name: true } } },
    });
    const codeByFieldStd = new Map();
    for (const a of rowsWithOption) {
      if (!a.option || toNumber(a.option.periode_id) !== toNumber(periodeIdBigInt)) continue;
      if (a.field_name !== a.option.field_name) continue; // guard integritas L2
      codeByFieldStd.set(`${a.field_name}\u0000${a.standard_value}`, a.option.code);
    }

    // (1) Encode: bangun row mentah per siswa — 18 akademik (Decimal cleaned) + 7 code.
    const encodedRows = cleanedRows.map((row) => {
      const out = { preprocessing_run_id: targetRunId, siswa_periode_id: row.siswa_periode_id };
      for (const field of NUMERIC_FIELDS) out[field] = row[field];
      for (const field of NON_AKADEMIK_FIELDS) {
        const std = row[field];
        const code = std === null || std === undefined ? undefined : codeByFieldStd.get(`${field}\u0000${std}`);
        out[field] = code === undefined ? null : new Prisma.Decimal(code);
      }
      return out;
    });

    // (2) Min-Max per kolom lintas SELURUH siswa (25 kolom), lalu timpa hasil normalisasi.
    const ALL_COLUMNS = [...NUMERIC_FIELDS, ...NON_AKADEMIK_FIELDS];
    for (const field of ALL_COLUMNS) {
      const present = [];
      for (const r of encodedRows) {
        const v = r[field];
        if (v !== null && v !== undefined) present.push(v);
      }
      if (present.length === 0) {
        for (const r of encodedRows) r[field] = null;
        continue;
      }
      let min = present[0];
      let max = present[0];
      for (const v of present) {
        if (v.cmp(min) < 0) min = v;
        if (v.cmp(max) > 0) max = v;
      }
      const norm = minMaxNormalizeColumn(encodedRows.map((r) => r[field]), min, max);
      encodedRows.forEach((r, i) => { r[field] = norm[i]; });
    }

    // (3) Re-run diizinkan: delete+insert transformed_data run aktif dalam transaksi sama.
    await tx.transformed_data.deleteMany({ where: { preprocessing_run_id: targetRunId } });
    if (encodedRows.length > 0) {
      await tx.transformed_data.createMany({ data: encodedRows });
    }

    // (4) Audit + derivasi badge: clear flag invalidasi MILIK SENDIRI DAN semua hilir
    // (reduced_invalidated_at ikut dibersihkan -> Reduksi MENUNGGU, bukan RESET).
    await tx.preprocessing_run.update({
      where: { id: targetRunId },
      data: {
        transformed_at: finishedAt,
        transformed_duration_ms: Math.max(0, finishedAt.getTime() - startedWall),
        transformed_invalidated_at: null,
        reduced_invalidated_at: null,
      },
    });
  });

  // Response = shape pipeline-status terbaru (kontrak mentor).
  return assemblePipelineStatus(periode);
}

module.exports = {
  getPipelineStatus,
  getSourcePreview,
  runIntegration,
  getCleaningConfig,
  runCleaning,
  getTransformConfig,
  createTransformOption,
  deleteTransformOption,
  saveTransformAssignments,
  runTransform,
  _internals: { STAGE_STATE, RUN_STATUS, buildStages, resolvePeriode, computeImputedValue, ensureKamusSeeded, minMaxNormalizeColumn },
};
