const { Router } = require('express');
const authRoutes = require('./auth.routes');

const router = Router();

// Health check sederhana untuk monitoring/deploy.
router.get('/health', (_req, res) => {
  res.json({ success: true, message: 'ok', timestamp: new Date().toISOString() });
});

router.use('/auth', authRoutes);

module.exports = router;
