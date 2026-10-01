const authService = require('../services/auth.service');
const { loginSchema } = require('../validations/auth.validation');

// POST /api/auth/login
async function login(req, res, next) {
  try {
    const payload = loginSchema.parse(req.body);
    const data = await authService.login(payload);
    return res.json({
      success: true,
      message: 'Login berhasil',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// GET /api/auth/me (dilindungi protect)
async function me(req, res, next) {
  try {
    const data = await authService.me(req.admin.id);
    return res.json({
      success: true,
      message: 'Berhasil mengambil profil admin',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

module.exports = { login, me };
