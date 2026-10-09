const { Router } = require('express');
const siswaController = require('../controllers/siswa.controller');
const { protect } = require('../middleware/auth.middleware');

const router = Router();

// Semua endpoint siswa wajib token admin (req.admin).
router.use(protect);

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
