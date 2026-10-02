const { Router } = require('express');
const authRoutes = require('./auth.routes');
const periodeRoutes = require('./periode.routes');

const router = Router();

// Health check sederhana untuk monitoring/deploy.
router.get('/health', (_req, res) => {
  res.json({ success: true, message: 'ok', timestamp: new Date().toISOString() });
});

router.use('/auth', authRoutes);
router.use('/periodes', periodeRoutes);

module.exports = router;
