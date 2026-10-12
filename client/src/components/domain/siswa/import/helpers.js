import { MAPPEL } from '../../../../lib/constants';

// Dictionary mapping for human readable labels (O3)
const FIELD_HUMAN_LABELS = {
  nis: 'NIS',
  nama: 'Nama Siswa',
  kelas: 'Kelas',
  ekstrakurikuler: 'Ekstrakurikuler',
  prestasi: 'Prestasi',
  kemampuan: 'Kemampuan',
  organisasi: 'Organisasi',
  kursus: 'Kursus',
  jurusan_1: 'Pilihan Jurusan 1',
  jurusan_2: 'Pilihan Jurusan 2',
};

MAPPEL.forEach((item) => {
  FIELD_HUMAN_LABELS[item.key] = item.label;
});

export function getHumanLabel(field) {
  if (!field) return '';
  const lower = String(field).toLowerCase();
  return FIELD_HUMAN_LABELS[lower] || FIELD_HUMAN_LABELS[field] || field;
}

export const SHEET_NAMES = ['RAPOR', 'PTS', 'PAS', 'NON-AKADEMIK'];

export function formatFileSize(bytes) {
  if (!bytes) return '0 B';
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
}
