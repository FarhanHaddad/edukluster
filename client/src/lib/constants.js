export const APP_VERSION = 'v0.3.0';

export const KELAS_OPTIONS = ['XII-1', 'XII-2', 'XII-3', 'XII-4'];

export const SOURCE_TYPES = {
  SINGLE_INPUT: 'single_input',
  EXCEL_IMPORT: 'excel_import',
};

export const SOURCE_CONFIG = {
  [SOURCE_TYPES.SINGLE_INPUT]: {
    label: 'Single Input',
    tone: 'warning',
  },
  [SOURCE_TYPES.EXCEL_IMPORT]: {
    label: 'Import Excel',
    tone: 'info',
  },
};

export function getSourceBadgeProps(code) {
  if (code && SOURCE_CONFIG[code]) {
    return SOURCE_CONFIG[code];
  }
  return {
    label: code || '-',
    tone: 'neutral',
  };
}

export const MAPPEL = [
  { key: 'agama', label: 'Agama' },
  { key: 'pkn', label: 'PKN' },
  { key: 'b_indonesia', label: 'B. Indonesia' },
  { key: 'b_inggris', label: 'B. Inggris' },
  { key: 'mtk_wajib', label: 'MTK Wajib' },
  { key: 'sejarah', label: 'Sejarah' },
  { key: 'pjok', label: 'PJOK' },
  { key: 'seni_rupa', label: 'Seni Rupa' },
  { key: 'b_jepang', label: 'B. Jepang' },
  { key: 'biologi', label: 'Biologi' },
  { key: 'fisika', label: 'Fisika' },
  { key: 'kimia', label: 'Kimia' },
  { key: 'informatika', label: 'Informatika' },
  { key: 'mtk_lanjut', label: 'MTK Lanjut' },
  { key: 'geografi', label: 'Geografi' },
  { key: 'sosial', label: 'Sosial' },
  { key: 'pkwu', label: 'PKWU' },
  { key: 'ekonomi', label: 'Ekonomi' },
];
