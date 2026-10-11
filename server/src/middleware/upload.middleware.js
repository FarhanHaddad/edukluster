const multer = require('multer');
const ApiError = require('../utils/ApiError');
const { MAX_FILE_SIZE_BYTES } = require('../utils/excelConstants');

// Upload Excel import siswa: memori saja (diparse langsung, TIDAK ditulis ke disk).
const storage = multer.memoryStorage();

// fileFilter: hanya ekstensi .xlsx. Selain itu -> ApiError 400 code INVALID_FILE.
const fileFilter = (_req, file, cb) => {
  if (/\.xlsx$/i.test(file.originalname || '')) {
    return cb(null, true);
  }
  const err = new ApiError(400, 'File harus berformat .xlsx.');
  err.code = 'INVALID_FILE';
  return cb(err);
};

const uploadExcelMiddleware = multer({
  storage,
  fileFilter,
  limits: { fileSize: MAX_FILE_SIZE_BYTES },
});

// Wrapper: tangkap error multer (LIMIT_ERR & fileFilter) lalu normalize jadi ApiError 400.
// - FILE_TOO_LARGE : "Ukuran file maksimal 5 MB."
// - INVALID_FILE   : "File harus berformat .xlsx." (dari fileFilter di atas)
// - FIELD_*        : field upload harus bernama "file".
function uploadExcel(req, res, next) {
  const handler = uploadExcelMiddleware.single('file');
  return handler(req, res, (err) => {
    if (err) {
      if (err instanceof ApiError && err.code === 'INVALID_FILE') {
        return next(err);
      }
      if (err instanceof multer.MulterError) {
        if (err.code === 'LIMIT_FILE_SIZE') {
          const e = new ApiError(400, 'Ukuran file maksimal 5 MB.');
          e.code = 'FILE_TOO_LARGE';
          return next(e);
        }
        if (err.code === 'LIMIT_UNEXPECTED_FILE') {
          const e = new ApiError(400, 'Field upload harus bernama "file".');
          e.code = 'INVALID_FILE';
          return next(e);
        }
        const e = new ApiError(400, `Upload file gagal: ${err.message}`);
        e.code = 'INVALID_FILE';
        return next(e);
      }
      return next(err);
    }
    return next();
  });
}

module.exports = { uploadExcel };
