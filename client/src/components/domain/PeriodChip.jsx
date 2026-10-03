import { CalendarDays } from 'lucide-react';

// PeriodChip: ikon kalender + "Periode:" muted + namaPeriode semibold.
// SHELL TOKEN LOCK dark: bg card, border line, shadow-sm, tinggi 40px.
export default function PeriodChip({ namaPeriode }) {
  if (!namaPeriode) return null;
  return (
    <div className="flex h-10 items-center gap-2 rounded-lg border border-line bg-card px-3 shadow-sm">
      <CalendarDays size={16} className="shrink-0 text-muted" aria-hidden="true" />
      <span className="text-sm text-muted">Periode:</span>
      <span className="truncate text-sm font-semibold text-ink">{namaPeriode}</span>
    </div>
  );
}
