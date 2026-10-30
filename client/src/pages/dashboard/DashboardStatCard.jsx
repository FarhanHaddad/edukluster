import Card from '../../components/ui/Card';
import { cn } from '../../lib/utils';

export default function DashboardStatCard({ label, value, footnote, icon: Icon, className }) {
  return (
    <Card className={cn('flex flex-col justify-between gap-3 p-4 min-h-[140px]', className)}>
      <div className="flex items-center justify-between gap-2">
        <span className="text-xs font-semibold uppercase leading-4 tracking-wider text-muted">
          {label}
        </span>
        {Icon ? <Icon size={18} className="shrink-0 text-faint" aria-hidden="true" /> : null}
      </div>
      <div className="flex flex-1 items-center justify-center py-1">
        <span className="font-mono text-3xl sm:text-[32px] font-semibold text-center leading-none text-ink select-none whitespace-nowrap">
          {value}
        </span>
      </div>
      {footnote ? (
        <p className="text-xs text-muted text-center leading-tight truncate">
          {footnote}
        </p>
      ) : null}
    </Card>
  );
}
