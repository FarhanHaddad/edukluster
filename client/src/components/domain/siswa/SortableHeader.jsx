import { ArrowUpDown, ArrowUp, ArrowDown } from 'lucide-react';

export default function SortableHeader({
  field,
  label,
  sortBy,
  sortOrder,
  onSortChange,
  className = '',
}) {
  const isActive = sortBy === field;
  const isAsc = isActive && sortOrder === 'asc';

  let ariaLabel = `Urutkan ${label} menaik`;
  if (isActive) {
    ariaLabel = isAsc ? `Urutkan ${label} menurun` : `Urutkan ${label} menaik`;
  }

  const Icon = !isActive ? ArrowUpDown : isAsc ? ArrowUp : ArrowDown;

  return (
    <th className={`px-4 py-3 text-left text-xs font-semibold uppercase tracking-wide text-muted ${className}`}>
      <button
        type="button"
        onClick={() => onSortChange?.(field)}
        aria-label={ariaLabel}
        className="inline-flex items-center gap-1.5 font-semibold text-muted hover:text-ink transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand/40 rounded px-1 py-0.5 -ml-1 uppercase tracking-wide"
      >
        <span>{label}</span>
        <Icon size={14} className={isActive ? 'text-brand' : 'text-faint'} aria-hidden="true" />
      </button>
    </th>
  );
}
