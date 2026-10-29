export const KMEANS_PALETTE = [
  '#6366F1', // C1
  '#3B82F6', // C2
  '#06B6D4', // C3
  '#10B981', // C4
  '#84CC16', // C5
  '#EAB308', // C6
  '#F97316', // C7
  '#EF4444', // C8
  '#EC4899', // C9
  '#8B5CF6', // C10
];

export const KMEANS_TABS = [
  { id: 'distribution', label: 'Distribusi Cluster', isAudit: false },
  { id: 'scatter', label: 'Scatter Bubble (2D)', isAudit: false },
  { id: 'parallel', label: 'Parallel Coordinates', isAudit: false },
  { id: 'iterations', label: 'Riwayat Iterasi', isAudit: true },
  { id: 'dbi', label: 'Evaluasi DBI', isAudit: true },
];

export const FEATURE_OPTIONS = [
  { value: 'agama', label: 'Agama' },
  { value: 'pkn', label: 'PKN' },
  { value: 'b_indonesia', label: 'B. Indonesia' },
  { value: 'b_inggris', label: 'B. Inggris' },
  { value: 'mtk_wajib', label: 'Mtk Wajib' },
  { value: 'sejarah', label: 'Sejarah' },
  { value: 'pjok', label: 'PJOK' },
  { value: 'seni_rupa', label: 'Seni Rupa' },
  { value: 'b_jepang', label: 'B. Jepang' },
  { value: 'biologi', label: 'Biologi' },
  { value: 'fisika', label: 'Fisika' },
  { value: 'kimia', label: 'Kimia' },
  { value: 'informatika', label: 'Informatika' },
  { value: 'mtk_lanjut', label: 'Mtk Lanjut' },
  { value: 'geografi', label: 'Geografi' },
  { value: 'sosial', label: 'Sosial' },
  { value: 'pkwu', label: 'PKWU' },
  { value: 'ekonomi', label: 'Ekonomi' },
  { value: 'ekstrakurikuler', label: 'Ekstrakurikuler' },
  { value: 'prestasi', label: 'Prestasi' },
  { value: 'kemampuan', label: 'Kemampuan' },
  { value: 'organisasi', label: 'Organisasi' },
  { value: 'kursus', label: 'Kursus' },
  { value: 'jurusan_1', label: 'Jurusan 1' },
  { value: 'jurusan_2', label: 'Jurusan 2' },
];

export const KMEANS_STATUS_BADGES = {
  NOT_RUN: { label: 'Belum dijalankan', variant: 'muted' },
  CONVERGED: { label: 'Konvergen', variant: 'success' },
  NOT_CONVERGED: { label: 'Tidak Konvergen', variant: 'warning' },
  FAILED: { label: 'Gagal', variant: 'danger' },
};

export const EMPTY_STATE_COPY = {
  NO_REDUCTION: {
    title: 'Tahap Reduksi Belum Selesai',
    description: 'Jalankan pipeline preprocessing hingga tahap Reduksi Data selesai sebelum menjalankan K-Means.',
    cta: 'Buka Preprocessing',
  },
  NO_RUN: {
    title: 'K-Means Belum Dijalankan',
    description: 'Klik tombol "Jalankan K-Means" di sudut kanan atas untuk mengelompokkan data siswa periode ini.',
    cta: 'Jalankan K-Means',
  },
};
