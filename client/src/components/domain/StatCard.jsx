import Card from '../ui/Card';
import Badge from '../ui/Badge';
import { cn } from '../../lib/utils';

// StatCard: kartu metrik Screen 2. label uppercase 12px semibold muted,
// value JetBrains Mono metric-lg (28px), caption/chip status mengikuti API.
export default function StatCard({ label, value, caption, tone = 'neutral', icon: Icon, className }) {
  return (
    <Card className={cn('flex flex-col gap-2', className)}>
      <div className="flex items-center justify-between gap-2">
        <span className="text-xs font-semibold uppercase leading-4 tracking-[0.04em] text-muted">
          {label}
        </span>
        {Icon ? <Icon size={16} className="shrink-0 text-faint" aria-hidden="true" /> : null}
      </div>
      <span className="font-mono text-[28px] font-semibold leading-8 tracking-[-0.02em] text-ink">
        {value}
      </span>
      {caption ? (
        <Badge tone={tone} className="self-start">
          {caption}
        </Badge>
      ) : null}
    </Card>
  );
}
