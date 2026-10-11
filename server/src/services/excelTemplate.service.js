const XLSX = require('xlsx');
const ApiError = require('../utils/ApiError');
const {
  SHEET_RAPOR,
  SHEET_PTS,
  SHEET_PAS,
  SHEET_NON_AKADEMIK,
  HEADERS_RAPOR,
  HEADERS_PTS,
  HEADERS_PAS,
  HEADERS_NON_AKADEMIK,
} = require('../utils/excelConstants');

// Bangun satu worksheet dari header saja (AOA -> urutan kolom terjamin persis kontrak C2).
function buildSheet(headers) {
  const ws = XLSX.utils.aoa_to_sheet([headers]);
  // Lebar kolom nyaman untuk Excel/LibreOffice saat dibuka.
  ws['!cols'] = headers.map((h) => ({ wch: Math.max(10, String(h).length + 2) }));
  return ws;
}

// GET /api/siswa/template-excel — generate buffer .xlsx kosong (header only), 4 sheet kanonik.
// Nama sheet & header DIJAMIN persis utils/excelConstants (satu sumber kebenaran dgn parser).
function generateTemplateBuffer() {
  try {
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, buildSheet(HEADERS_RAPOR), SHEET_RAPOR);
    XLSX.utils.book_append_sheet(wb, buildSheet(HEADERS_PTS), SHEET_PTS);
    XLSX.utils.book_append_sheet(wb, buildSheet(HEADERS_PAS), SHEET_PAS);
    XLSX.utils.book_append_sheet(wb, buildSheet(HEADERS_NON_AKADEMIK), SHEET_NON_AKADEMIK);
    // type:'buffer' -> Buffer xlsx utuh siap dikirim via res.send().
    return XLSX.write(wb, { bookType: 'xlsx', type: 'buffer' });
  } catch (err) {
    throw new ApiError(500, `Gagal membuat template Excel: ${err.message}`);
  }
}

module.exports = { generateTemplateBuffer };
