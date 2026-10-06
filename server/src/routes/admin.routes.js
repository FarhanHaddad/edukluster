const { Router } = require('express');
const adminController = require('../controllers/admin.controller');
const { protect } = require('../middleware/auth.middleware');

const router = Router();

// Semua endpoint admin wajib token admin (req.admin).
router.use(protect);

// GET /api/admins — FR-A03
router.get('/', adminController.listAdmins);

// POST /api/admins — FR-A03
router.post('/', adminController.createAdmin);

// PUT /api/admins/:id — FR-A03
router.put('/:id', adminController.updateAdmin);

// PATCH /api/admins/:id/status — FR-M02 (toggle, tanpa body)
router.patch('/:id/status', adminController.toggleAdminStatus);

// DELETE /api/admins/:id — FR-A03
router.delete('/:id', adminController.deleteAdmin);

module.exports = router;
