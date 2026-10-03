import { formatAngka, formatTimestamp } from '../../lib/format';
import Badge from '../ui/Badge';
import Button from '../ui/Button';

// Peta status periode -> tone Badge (frame 3A: AKTIF success; NONAKTIF/SELESAI neutral).
const STATUS_TONE = { AKTIF: 'success', NONAKTIF: 'neutral', SELESAI: 'neutral' };

// Label semester human-readable (kontrak BE periode.service semesterLabel).
const SEMESTER_LABEL = { GANJIL: 'Ganjil', GENAP: 'Genap' };

// Header sel tabel — Inter 12px semibold uppercase muted (DESIGN.md, bukan mono).
function Th({ children, className = '' }) {
  return (
    <th
      className={`px-4 py-3 text-left text-xs font-semibold uppercase tracking-wide text-muted ${className}`}
    >
      {children}
    </th>
  );
}

// PeriodeTable (frame 3A): baris AKTIF = left-border brand tanpa border lain;
// kolom AKSI hanya terisi untuk periode NONAKTIF (SELESAI read-only, baris aktif
// n/a) — tombol "Aktifkan" membuka dialog konfirmasi via onActivate.
export default function PeriodeTable({ items, activeId, onActivate }) {
  const n = items.length;

  return (
    <div className="overflow-x-auto">
      <table className="w-full border-collapse text-sm">
        <thead>
          {/* Elevated surface utk header tabel (DARK MODE CONTRACT #1E1E24) */}
          <tr className="border-b border-line bg-elevated">
            <Th className="pl-6">Periode</Th>
            <Th>Tahun Ajaran</Th>
            <Th>Semester</Th>
            <Th className="text-right">Total Siswa</Th>
            <Th>Status</Th>
            <Th>Dibuat</Th>
            <Th className="text-right">Aksi</Th>
          </tr>
        </thead>
        <tbody>
          {items.map((p) => {
            const isActive = p.status === 'AKTIF' || p.id === activeId;
            return (
              <tr
                key={p.id}
                className={
                  isActive
                    ? // Baris AKTIF: strip kiri brand + tint tipis (frame 3A)
                      'border-b border-line bg-brand-tint/40 shadow-[inset_3px_0_0_0_var(--color-brand)] last:border-b-0'
                    : 'border-b border-line last:border-b-0'
                }
              >
                <td className="py-3 pl-6 pr-4 font-semibold text-ink">{p.namaPeriode}</td>
                <td className="px-4 py-3 font-mono text-ink">{p.tahunAjaran}</td>
                <td className="px-4 py-3 text-ink">{SEMESTER_LABEL[p.semester] ?? p.semester}</td>
                <td className="px-4 py-3 text-right font-mono text-ink">
                  {formatAngka(p.totalSiswa)}
                </td>
                <td className="px-4 py-3">
                  <Badge tone={STATUS_TONE[p.status] ?? 'neutral'}>{p.status}</Badge>
                </td>
                <td className="whitespace-nowrap px-4 py-3 font-mono text-muted">
                  {formatTimestamp(p.createdAt)}
                </td>
                <td className="px-4 py-3 text-right">
                  {isActive || p.status === 'SELESAI' ? null : (
                    <Button variant="outline" onClick={() => onActivate(p)}>
                      Aktifkan
                    </Button>
                  )}
                </td>
              </tr>
            );
          })}
        </tbody>
      </table>

      {/* Footer ringkas list kecil (frame 3A); angka pakai mono. */}
      <div className="border-t border-line px-6 py-3 text-sm text-muted">
        Menampilkan <span className="font-mono text-ink">1-{n}</span> dari{' '}
        <span className="font-mono text-ink">{n}</span> periode
      </div>
    </div>
  );
}
