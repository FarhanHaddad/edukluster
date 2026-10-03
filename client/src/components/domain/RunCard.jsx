import Badge from '../ui/Badge';
import { formatTimestamp } from '../../lib/format';
import { cn } from '../../lib/utils';

// Peta status run BE -> label UI + tone badge (soft tinted badge saja — DESIGN.md).
const STATUS_MAP = {
  SELESAI: { label: 'Selesai', tone: 'success' },
  SUKSES: { label: 'Sukses', tone: 'success' },
  BERJALAN: { label: 'Berjalan', tone: 'info' },
  RUNNING: { label: 'Berjalan', tone: 'info' },
  GAGAL: { label: 'Gagal', tone: 'danger' },
  BELUM_ADA: { label: 'Belum Ada', tone: 'neutral' },
};

function statusBadge(status) {
  const mapped = STATUS_MAP[status] ?? { label: String(status ?? '-'), tone: 'neutral' };
  return <Badge tone={mapped.tone}>{mapped.label}</Badge>;
}

// RunCard: satu baris riwayat eksekusi K-Means pada card "5 Run Terakhir".
// ID & timestamp pakai JetBrains Mono (kontrak tipografi).
export default function RunCard({ id, status, startedAt, completedAt, className }) {
  return (
    <div
      className={cn(
        'flex flex-wrap items-center justify-between gap-x-4 gap-y-2 rounded-lg border border-line bg-page px-4 py-3',
        className
      )}
    >
      <div className="flex min-w-0 items-center gap-3">
        <span className="font-mono text-sm font-semibold leading-5 text-ink">#{id}</span>
        {statusBadge(status)}
      </div>
      <div className="flex items-center gap-2 font-mono text-xs leading-4 text-muted">
        <span>Mulai {formatTimestamp(startedAt)}</span>
        {completedAt ? (
          <>
            <span aria-hidden="true">&middot;</span>
            <span>Selesai {formatTimestamp(completedAt)}</span>
          </>
        ) : null}
      </div>
    </div>
  );
}
