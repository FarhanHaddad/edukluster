const { Router } = require('express');
const dashboardController = require('../controllers/dashboard.controller');
const { protect } = require('../middleware/auth.middleware');

const router = Router();

// Semua endpoint dashboard wajib token admin (req.admin).
router.use(protect);

// GET /api/dashboard — FR-B03
router.get('/', dashboardController.getSummary);

module.exports = router;
