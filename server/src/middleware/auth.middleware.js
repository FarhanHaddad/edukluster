const jwt = require('jsonwebtoken');
const env = require('../config/env');
const ApiError = require('../utils/ApiError');

// Proteksi route: wajib header "Authorization: Bearer <token>".
function protect(req, _res, next) {
  const header = req.headers.authorization || '';

  if (!header.startsWith('Bearer ')) {
    return next(new ApiError(401, 'Token tidak valid.'));
  }

  const token = header.slice('Bearer '.length).trim();

  try {
    const decoded = jwt.verify(token, env.JWT_SECRET);
    // RULE WAJIB: sub sudah Number saat signing; jaga tetap Number di sini.
    req.admin = { id: Number(decoded.sub), username: decoded.username };
    return next();
  } catch (err) {
    if (err.name === 'TokenExpiredError') {
      return next(new ApiError(401, 'Sesi berakhir. Silakan login kembali.'));
    }
    return next(new ApiError(401, 'Token tidak valid.'));
  }
}

module.exports = { protect };
