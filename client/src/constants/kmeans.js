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
