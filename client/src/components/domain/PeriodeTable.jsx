import { formatAngka } from '../../lib/format';
import Badge from '../ui/Badge';
import Button from '../ui/Button';

// Peta status periode -> Badge (frame 3A rev2): label sentence case —
// "Aktif" success + dot, "Selesai"/"Non-aktif" neutral.
const STATUS_BADGE = {
  AKTIF: { label: 'Aktif', tone: 'success', dot: true },
  SELESAI: { label: 'Selesai', tone: 'neutral', dot: false },
  NONAKTIF: { label: 'Non-aktif', tone: 'neutral', dot: false },
};

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

// PeriodeTable (frame 3A rev2): KOLOM FINAL = TAHUN AJARAN (bold) | SEMESTER |
// TOTAL SISWA (mono) | STATUS | AKSI — kolom lama dibuang sesuai frame terkunci.
// Baris AKTIF tetap brand-tint + strip kiri; sel AKSI-nya italic muted
// "Periode berjalan"; baris lain outline "Aktifkan" -> dialog konfirmasi via onActivate.
export default function PeriodeTable({ items, activeId, onActivate }) {
  const n = items.length;

  return (
    <div className="overflow-x-auto">
      <table className="w-full border-collapse text-sm">
        <thead>
          {/* Elevated surface utk header tabel (DARK MODE CONTRACT #1E1E24) */}
          <tr className="border-b border-line bg-elevated">
            <Th className="pl-6">Tahun Ajaran</Th>
            <Th>Semester</Th>
            <Th className="text-right">Total Siswa</Th>
            <Th>Status</Th>
            <Th className="text-right">Aksi</Th>
          </tr>
        </thead>
        <tbody>
          {items.map((p) => {
            const isActive = p.status === 'AKTIF' || p.id === activeId;
            const badge = STATUS_BADGE[p.status] ?? {
              label: String(p.status ?? '-'),
              tone: 'neutral',
              dot: false,
            };
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
                <td className="py-3 pl-6 pr-4 font-semibold text-ink">{p.tahunAjaran}</td>
                <td className="px-4 py-3 text-ink">{SEMESTER_LABEL[p.semester] ?? p.semester}</td>
                <td className="px-4 py-3 text-right font-mono text-ink">
                  {formatAngka(p.totalSiswa)}
                </td>
                <td className="px-4 py-3">
                  <Badge tone={badge.tone}>
                    {badge.dot ? (
                      <span
                        aria-hidden="true"
                        className="size-1.5 shrink-0 rounded-full bg-success"
                      />
                    ) : null}
                    {badge.label}
                  </Badge>
                </td>
                <td className="px-4 py-3 text-right">
                  {isActive ? (
                    <span className="italic text-muted">Periode berjalan</span>
                  ) : (
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
