const { ZodError } = require('zod');
const env = require('../config/env');
const ApiError = require('../utils/ApiError');

// 404 untuk route yang tidak dikenal.
function notFound(req, res, next) {
  next(new ApiError(404, `Route ${req.method} ${req.originalUrl} tidak ditemukan`));
}

// Error handler terpusat.
// eslint-disable-next-line no-unused-vars
function errorHandler(err, req, res, next) {
  // Zod: balasan 400 dengan detail per-field.
  if (err instanceof ZodError) {
    return res.status(400).json({
      success: false,
      message: 'Validasi gagal',
      errors: err.issues.map((issue) => ({
        field: issue.path.join('.') || '_',
        message: issue.message,
      })),
    });
  }

  // ApiError: pakai statusCode bawaan.
  if (err instanceof ApiError) {
    return res.status(err.statusCode).json({
      success: false,
      message: err.message,
    });
  }

  // Fallback 500: sembunyikan detail error di production.
  if (env.NODE_ENV !== 'production') {
    console.error(err);
  }

  const message =
    env.NODE_ENV === 'production' ? 'Terjadi kesalahan pada server' : err.message;

  return res.status(err.statusCode || 500).json({
    success: false,
    message,
  });
}

module.exports = { notFound, errorHandler };
