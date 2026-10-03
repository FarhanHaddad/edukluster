import Badge from '../ui/Badge';

// PageHeader (GLOBAL LOCK RULES #6): kiri = h1 + badge + deskripsi; kanan = chip periode.
// `active` opsional — PlaceholderPage tidak merender badge (cukup judul + teks).
export default function PageHeader({ title, description, active, periodChip }) {
  return (
    <header className="flex flex-wrap items-start justify-between gap-3">
      <div className="min-w-0">
        <div className="flex flex-wrap items-center gap-2">
          <h1 className="text-xl font-semibold leading-7 tracking-[-0.015em] text-ink">{title}</h1>
          {active === undefined || active === null ? null : (
            <Badge tone={active ? 'brand' : 'neutral'}>
              {active ? 'Aktif' : 'Belum Ada Periode Aktif'}
            </Badge>
          )}
        </div>
        {description ? (
          <p className="mt-1 text-sm leading-5 text-muted">{description}</p>
        ) : null}
      </div>
      {periodChip ?? null}
    </header>
  );
}
