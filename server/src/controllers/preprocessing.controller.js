const preprocessingService = require('../services/preprocessing.service');
const {
  pipelineStatusQuerySchema,
  sourcePreviewQuerySchema,
  cleaningBodySchema,
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

module.exports = {
  getPipelineStatus,
  getSourcePreview,
  runIntegration,
  getCleaningConfig,
  runCleaning,
};
