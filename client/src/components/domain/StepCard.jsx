import { cn } from '../../lib/utils';

// StepCard: kartu langkah alur kerja 01/02/03 (dipakai EmptyState Screen 2).
// Nomor = mono (angka); judul Inter semibold; deskripsi muted.
export default function StepCard({ step, title, description, className }) {
  return (
    <div
      className={cn(
        'flex flex-col items-center gap-2 rounded-lg border border-line bg-card p-4 text-center shadow-sm',
        className
      )}
    >
      <span className="font-mono text-xs font-semibold leading-4 tracking-[0.04em] text-brand">
        {step}
      </span>
      <p className="text-sm font-semibold leading-5 text-ink">{title}</p>
      {description ? (
        <p className="text-xs leading-4 text-muted">{description}</p>
      ) : null}
    </div>
  );
}
