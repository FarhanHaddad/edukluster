// ===== KAMUS BIDANG (sumber: workbook sheet "Inisial"; Owner spot-check saat QA).
// Konstanta murni — TIDAK boleh require modul lain (dipakai service & seed lazy).
// Struktur: { <field_name>: [ { name, code } ] } utk 7 field non-akademik.
// Kode bidang bersifat CREATE-ONLY (ruling V-3): tidak ada endpoint update kode;
// ganti kode = hapus bidang (trash) lalu buat baru.
const KAMUS_BIDANG = {
  ekstrakurikuler: [
    { name: 'Tidak Ada', code: 0 },
    { name: 'Olahraga', code: 1 },
    { name: 'Seni', code: 2 },
    { name: 'Sains', code: 3 },
    { name: 'Literasi', code: 4 },
  ],
  prestasi: [
    { name: 'Tidak Ada', code: 0 },
    { name: 'Olahraga', code: 1 },
    { name: 'Seni', code: 2 },
    { name: 'E-Sport', code: 3 },
    { name: 'Sosial', code: 4 },
    { name: 'Sains', code: 5 },
  ],
  kemampuan: [
    { name: 'Tidak Ada', code: 0 },
    { name: 'Olahraga', code: 1 },
    { name: 'Musik', code: 2 },
    { name: 'Seni', code: 3 },
    { name: 'Digital', code: 4 },
    { name: 'Bisnis', code: 5 },
    { name: 'Sains&Teknik', code: 6 },
    { name: 'Tata boga', code: 7 },
    { name: 'Komunikasi', code: 8 },
  ],
  organisasi: [
    { name: 'Tidak Ada', code: 0 },
    { name: 'Olahraga', code: 1 },
    { name: 'Sosial', code: 2 },
    { name: 'Kepemimpinan', code: 3 },
    { name: 'Kesehatan', code: 4 },
  ],
  kursus: [
    { name: 'Tidak Ada', code: 0 },
    { name: 'Akademik', code: 1 },
    { name: 'Bahasa Inggris', code: 2 },
    { name: 'Hukum', code: 3 },
    { name: 'Seni', code: 4 },
    { name: 'Olahraga', code: 5 },
  ],
  jurusan_1: [
    { name: 'Tidak Ada', code: 0 },
    { name: 'Teknik', code: 1 },
    { name: 'Komputer', code: 2 },
    { name: 'Ekonomi', code: 3 },
    { name: 'Sosial', code: 4 },
    { name: 'Bahasa', code: 5 },
    { name: 'Seni', code: 6 },
    { name: 'Kesehatan', code: 7 },
    { name: 'Olahraga', code: 8 },
    { name: 'Sains Terapan', code: 9 },
    { name: 'Perancangan Bangunan', code: 10 },
    { name: 'Pendidikan Guru', code: 11 },
  ],
  jurusan_2: [
    { name: 'Tidak Ada', code: 0 },
    { name: 'Teknik', code: 1 },
    { name: 'Komputer', code: 2 },
    { name: 'Ekonomi', code: 3 },
    { name: 'Sosial', code: 4 },
    { name: 'Bahasa', code: 5 },
    { name: 'Seni', code: 6 },
    { name: 'Kesehatan', code: 7 },
    { name: 'Olahraga', code: 8 },
    { name: 'Sains Terapan', code: 9 },
    { name: 'Perancangan Bangunan', code: 10 },
    { name: 'Pendidikan Guru', code: 11 },
  ],
};

module.exports = { KAMUS_BIDANG };
