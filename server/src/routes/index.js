const { Router } = require('express');
const authRoutes = require('./auth.routes');
const periodeRoutes = require('./periode.routes');
const dashboardRoutes = require('./dashboard.routes');
const adminRoutes = require('./admin.routes');
const siswaRoutes = require('./siswa.routes');

const router = Router();

// Health check sederhana untuk monitoring/deploy.
router.get('/health', (_req, res) => {
  res.json({ success: true, message: 'ok', timestamp: new Date().toISOString() });
});

router.use('/auth', authRoutes);
router.use('/periodes', periodeRoutes);
router.use('/dashboard', dashboardRoutes);
router.use('/admins', adminRoutes);
router.use('/siswa', siswaRoutes);

module.exports = router;
