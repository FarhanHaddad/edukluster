// Konfigurasi seed K-Means - TIKET BE-KM-1.6.
// DILARANG hardcode angka centroid (presisi bulatan Excel -> "precision drift" vs oracle skripsi).
// Engine WAJIB mengekstrak vektor fitur dari baris dataset secara dinamis saat runtime:
// Centroid awal C1..C10 = siswa ke-[8, 17, 21, 28, 36, 48, 58, 69, 88, 99] (index 1-based)
// pada dataset reduced_data (Reduction 2025/2026 Ganjil), kolom per FEATURE_ORDER.

'use strict';

// 25 kunci snake_case, PERSIS sesuai kolom model reduced_data di server/prisma/schema.prisma.
const FEATURE_ORDER = [
  'agama', 'pkn', 'b_indonesia', 'b_inggris', 'mtk_wajib',
  'sejarah', 'pjok', 'seni_rupa', 'b_jepang', 'biologi',
  'fisika', 'kimia', 'informatika', 'mtk_lanjut', 'geografi',
  'sosial', 'pkwu', 'ekonomi', 'ekstrakurikuler', 'prestasi',
  'kemampuan', 'organisasi', 'kursus', 'jurusan_1', 'jurusan_2',
];

// Index BARIS (1-based / urutan siswa ke-N) sumber centroid awal C1..C10 - Tabel 3.14 skripsi.
// Engine mengonversi ke 0-based lalu mengambil vektor siswa tsb langsung dari rows dataset.
const SEED_ROW_INDICES = [8, 17, 21, 28, 36, 48, 58, 69, 88, 99];

module.exports = { SEED_ROW_INDICES, FEATURE_ORDER };
