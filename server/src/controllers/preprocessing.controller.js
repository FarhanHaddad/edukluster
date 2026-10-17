const preprocessingService = require('../services/preprocessing.service');
const {
  pipelineStatusQuerySchema,
  sourcePreviewQuerySchema,
  cleaningBodySchema,
  transformConfigQuerySchema,
  transformOptionBodySchema,
  transformOptionIdParamSchema,
  transformAssignmentsBodySchema,
  reductionRunQuerySchema,
} = require('../validations/preprocessing.validation');

// GET /api/preprocessing/pipeline-status — badge 4 stage + run-meta (FR-D01). Skinny: tanpa logika.
async function getPipelineStatus(req, res, next) {
  try {
    const query = pipelineStatusQuerySchema.parse(req.query);
    const data = await preprocessingService.getPipelineStatus(query, req.admin);
    return res.json({ success: true, message: 'Berhasil mengambil status pipeline', data });
  } catch (err) {
    return next(err);
  }
}

// GET /api/preprocessing/source-preview — raw values 4 tab sumber (Frame PRE-1D).
async function getSourcePreview(req, res, next) {
  try {
    const query = sourcePreviewQuerySchema.parse(req.query);
    const data = await preprocessingService.getSourcePreview(query);
    return res.json({ success: true, message: 'Berhasil mengambil pratinjau sumber', data });
  } catch (err) {
    return next(err);
  }
}

// POST /api/preprocessing/integration — eksekusi stage integrasi pada run AKTIF.
// Response = shape pipeline-status terbaru (kontrak mentor).
async function runIntegration(req, res, next) {
  try {
    const query = pipelineStatusQuerySchema.parse(req.query);
    const data = await preprocessingService.runIntegration(req.admin, query);
    return res.json({ success: true, message: 'Integrasi berhasil dijalankan', data });
  } catch (err) {
    return next(err);
  }
}

// GET /api/preprocessing/cleaning/config — distribusi raw non-akademik + mapping L1
// + statistik missing akademik (BE-PRE-2). Skinny: tanpa logika.
async function getCleaningConfig(req, res, next) {
  try {
    const query = pipelineStatusQuerySchema.parse(req.query);
    const data = await preprocessingService.getCleaningConfig(query);
    return res.json({ success: true, message: 'Berhasil mengambil konfigurasi cleaning', data });
  } catch (err) {
    return next(err);
  }
}

// POST /api/preprocessing/cleaning — jalankan cleaning pada run AKTIF (BE-PRE-2).
// Response = shape pipeline-status terbaru (kontrak mentor).
async function runCleaning(req, res, next) {
  try {
    const body = cleaningBodySchema.parse(req.body);
    const query = pipelineStatusQuerySchema.parse(req.query);
    const data = await preprocessingService.runCleaning(body, req.admin, query);
    return res.json({ success: true, message: 'Cleaning berhasil dijalankan', data });
  } catch (err) {
    return next(err);
  }
}

// ===== BE-PRE-3 Transformasi (semua skinny: Zod -> service -> response standar).

// GET /api/preprocessing/transform/config — kamus bidang + assignedValues + unmapped.
async function getTransformConfig(req, res, next) {
  try {
    const query = transformConfigQuerySchema.parse(req.query);
    const data = await preprocessingService.getTransformConfig(query);
    return res.json({ success: true, message: 'Berhasil mengambil konfigurasi transformasi', data });
  } catch (err) {
    return next(err);
  }
}

// POST /api/preprocessing/transform/options — buat bidang kamus (code default max+1; V-3 create-only).
async function createTransformOption(req, res, next) {
  try {
    const body = transformOptionBodySchema.parse(req.body);
    const query = pipelineStatusQuerySchema.parse(req.query);
    const data = await preprocessingService.createTransformOption(body, query);
    return res.status(201).json({ success: true, message: 'Bidang kamus berhasil dibuat', data });
  } catch (err) {
    return next(err);
  }
}

// DELETE /api/preprocessing/transform/options/:id — trash bidang; V-4 bila transformed ada.
async function deleteTransformOption(req, res, next) {
  try {
    const params = transformOptionIdParamSchema.parse(req.params);
    const query = pipelineStatusQuerySchema.parse(req.query);
    const data = await preprocessingService.deleteTransformOption(params, query);
    return res.json({ success: true, message: 'Bidang kamus berhasil dihapus', data });
  } catch (err) {
    return next(err);
  }
}

// POST /api/preprocessing/transform/assignments — upsert L2 nilai standar -> bidang.
async function saveTransformAssignments(req, res, next) {
  try {
    const body = transformAssignmentsBodySchema.parse(req.body);
    const query = pipelineStatusQuerySchema.parse(req.query);
    const data = await preprocessingService.saveTransformAssignments(body, query);
    return res.json({ success: true, message: 'Pemetaan bidang berhasil disimpan', data });
  } catch (err) {
    return next(err);
  }
}

// POST /api/preprocessing/transform/run — encode + min-max pada run AKTIF.
// Response sukses = shape pipeline-status terbaru (kontrak mentor).
async function runTransform(req, res, next) {
  try {
    const query = pipelineStatusQuerySchema.parse(req.query);
    const data = await preprocessingService.runTransform(req.admin, query);
    return res.json({ success: true, message: 'Transformasi berhasil dijalankan', data });
  } catch (err) {
    return next(err);
  }
}

// POST /api/preprocessing/reduction/run — proyeksi transformed_data -> reduced_data (BE-PRE-4).
// Gate transformasi SELESAI di service; response sukses = shape pipeline-status terbaru.
async function runReduction(req, res, next) {
  try {
    const query = reductionRunQuerySchema.parse(req.query);
    const data = await preprocessingService.runReduction(req.admin, query);
    return res.json({ success: true, message: 'Reduksi berhasil dijalankan', data });
  } catch (err) {
    return next(err);
  }
}

// GET /api/preprocessing/reduction/summary — ringkasan reduksi run terbaru (BE-PRE-4).
async function getReductionSummary(req, res, next) {
  try {
    const query = reductionRunQuerySchema.parse(req.query);
    const data = await preprocessingService.getReductionSummary(query);
    return res.json({ success: true, message: 'Berhasil mengambil ringkasan reduksi', data });
  } catch (err) {
    return next(err);
  }
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
  runReduction,
  getReductionSummary,
};
