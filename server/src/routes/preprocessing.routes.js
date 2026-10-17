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

// ===== BE-PRE-3 Transformasi (Kamus Bidang L2 + Encode + Min-Max).

// GET /api/preprocessing/transform/config — kamus bidang per periode (lazy seed) + assignedValues + unmapped.
router.get('/transform/config', preprocessingController.getTransformConfig);

// POST /api/preprocessing/transform/options — buat bidang kamus; code default max+1; duplikat -> 422; TIDAK invalidate (V-3).
router.post('/transform/options', preprocessingController.createTransformOption);

// DELETE /api/preprocessing/transform/options/:id — trash bidang; assignment cascade; V-4 bila transformed_data ada.
router.delete('/transform/options/:id', preprocessingController.deleteTransformOption);

// POST /api/preprocessing/transform/assignments — upsert L2 (periode+field+standard_value); V-4 bila transformed_data ada.
router.post('/transform/assignments', preprocessingController.saveTransformAssignments);

// POST /api/preprocessing/transform/run — gate cleaning+unmapped; encode 7 field; min-max 25 kolom; clear flag hilir.
router.post('/transform/run', preprocessingController.runTransform);

// ===== BE-PRE-4 Reduksi (FR-D04).

// POST /api/preprocessing/reduction/run — proyeksi murni transformed_data -> reduced_data (25 fitur + FK);
// gate transformasi SELESAI else 400; re-run delete+insert satu transaksi; run.status -> COMPLETED.
router.post('/reduction/run', preprocessingController.runReduction);

// GET /api/preprocessing/reduction/summary — ringkasan reduksi run terbaru; 404 bila belum pernah jalan.
router.get('/reduction/summary', preprocessingController.getReductionSummary);

module.exports = router;
