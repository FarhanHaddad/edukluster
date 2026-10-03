// Util format tampilan (FE only): angka & timestamp pakai JetBrains Mono (DESIGN.md).

const TANGGAL_FMT = new Intl.DateTimeFormat('id-ID', {
  day: '2-digit',
  month: 'short',
  year: 'numeric',
});

const JAM_FMT = new Intl.DateTimeFormat('id-ID', {
  hour: '2-digit',
  minute: '2-digit',
});

// 105 -> "105"; null/undefined -> fallback.
export function formatAngka(value, fallback = '0') {
  if (value === null || value === undefined || value === '') return fallback;
  return new Intl.NumberFormat('id-ID').format(Number(value));
}

// ISO -> "12 Okt 2025" (mono-safe, satu baris).
export function formatTanggal(iso) {
  if (!iso) return '-';
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return '-';
  return TANGGAL_FMT.format(d);
}

// ISO -> "12 Okt 2025 • 11:25".
export function formatTimestamp(iso) {
  if (!iso) return '-';
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return '-';
  return `${TANGGAL_FMT.format(d)} \u2022 ${JAM_FMT.format(d)}`;
}
