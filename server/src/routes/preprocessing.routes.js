const { Router } = require('express');
const preprocessingController = require('../controllers/preprocessing.controller');
const { protect } = require('../middleware/auth.middleware');

const router = Router();

// Semua endpoint preprocessing wajib token admin (req.admin).
router.use(protect);

// GET /api/preprocessing/pipeline-status — FR-D01 + badge pipeline + empty state (BE-PRE-1).
router.get('/pipeline-status', preprocessingController.getPipelineStatus);

// GET /api/preprocessing/source-preview?jenis=rapor|pts|pas|non_akademik&page&limit (BE-PRE-1).
router.get('/source-preview', preprocessingController.getSourcePreview);

// POST /api/preprocessing/integration — jalankan integrasi pada run AKTIF; re-run -> SUPERSEDED (BE-PRE-1).
router.post('/integration', preprocessingController.runIntegration);

// GET /api/preprocessing/cleaning/config — distribusi raw + mapping L1 + statistik missing akademik (BE-PRE-2).
router.get('/cleaning/config', preprocessingController.getCleaningConfig);

// POST /api/preprocessing/cleaning — cleaning pada run AKTIF: imputasi global + L1; invalidasi hilir V-4 (BE-PRE-2).
router.post('/cleaning', preprocessingController.runCleaning);

module.exports = router;
