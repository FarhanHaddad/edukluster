const dashboardService = require('../services/dashboard.service');

// GET /api/dashboard — ringkasan Screen 2 (FR-B03). Skinny: tanpa logika.
async function getSummary(_req, res, next) {
  try {
    const data = await dashboardService.getDashboardSummary();
    return res.json({
      success: true,
      message: 'Berhasil mengambil ringkasan dashboard',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

module.exports = { getSummary };
