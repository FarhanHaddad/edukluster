const { Router } = require('express');
const authController = require('../controllers/auth.controller');
const { protect } = require('../middleware/auth.middleware');

const router = Router();

// POST /api/auth/login — FR-A01
router.post('/login', authController.login);

// GET /api/auth/me — FR-A02 (wajib token)
router.get('/me', protect, authController.me);

module.exports = router;
