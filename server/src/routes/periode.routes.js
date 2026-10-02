const { Router } = require('express');
const periodeController = require('../controllers/periode.controller');
const { protect } = require('../middleware/auth.middleware');

const router = Router();

// Semua endpoint periode wajib token admin (req.admin).
router.use(protect);

// GET /api/periodes — FR-B01
router.get('/', periodeController.listPeriodes);

// GET /api/periodes/active — FR-B02
router.get('/active', periodeController.getActivePeriode);

// POST /api/periodes — FR-B01
router.post('/', periodeController.createPeriode);

// PATCH /api/periodes/:id/activate — FR-B02
router.patch('/:id/activate', periodeController.activatePeriode);

module.exports = router;
