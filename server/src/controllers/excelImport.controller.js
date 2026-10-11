const excelTemplateService = require('../services/excelTemplate.service');
const excelImportService = require('../services/excelImport.service');
const ApiError = require('../utils/ApiError');
const { XLSX_MIME, TEMPLATE_FILENAME } = require('../utils/excelConstants');

// GET /api/siswa/template-excel — unduh template .xlsx 4 sheet (RAPOR, PTS, PAS, NON-AKADEMIK).
// Controller skinny: hanya memanggil service lalu menyematkan header download + buffer.
async function downloadTemplate(req, res) {
  const buffer = excelTemplateService.generateTemplateBuffer();
  res.setHeader('Content-Type', XLSX_MIME);
  res.setHeader('Content-Disposition', `attachment; filename="${TEMPLATE_FILENAME}"`);
  return res.send(buffer);
}

// POST /api/siswa/import-excel/preview — parse & validasi file Excel, kembalikan JSON preview.
// TIDAK ada insert ke DB (write = tiket B2). Response 200 walau status validation_error.
async function previewImport(req, res, next) {
  try {
    // Kehadiran file dicek di sini (multer sudah menormalisasi ukuran/ekstensi via middleware).
    if (!req.file) {
      const err = new ApiError(400, 'File Excel (.xlsx) wajib diunggah pada field "file".');
      err.code = 'INVALID_FILE';
      throw err;
    }
    const result = await excelImportService.parseAndPreview(req.file);
    return res.json({ success: true, ...result });
  } catch (err) {
    return next(err);
  }
}

module.exports = { downloadTemplate, previewImport };
