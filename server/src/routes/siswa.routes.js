const { Router } = require('express');
const siswaController = require('../controllers/siswa.controller');
const excelImportController = require('../controllers/excelImport.controller');
const { protect } = require('../middleware/auth.middleware');
const { uploadExcel } = require('../middleware/upload.middleware');

const router = Router();

// Semua endpoint siswa wajib token admin (req.admin).
router.use(protect);

// GET /api/siswa/template-excel — unduh template import .xlsx (FR-C02, tiket B1).
// WAJIB didaftarkan SEBELUM '/:id' supaya 'template-excel' tidak terbaca sebagai id.
router.get('/template-excel', excelImportController.downloadTemplate);

// POST /api/siswa/import-excel/preview — parse + validasi Excel, JSON preview tanpa insert DB.
// Sama: daftar sebelum '/:id'. Field upload: "file" (multipart, memoryStorage, maks 5 MB).
router.post('/import-excel/preview', uploadExcel, excelImportController.previewImport);

// GET /api/siswa — FR-C01
router.get('/', siswaController.listSiswa);

// POST /api/siswa — FR-C01
router.post('/', siswaController.createSiswa);

// GET /api/siswa/:id — FR-C01
router.get('/:id', siswaController.getSiswa);

// PUT /api/siswa/:id — FR-C01
router.put('/:id', siswaController.updateSiswa);

// DELETE /api/siswa/:id — FR-C03
router.delete('/:id', siswaController.deleteSiswa);

module.exports = router;
