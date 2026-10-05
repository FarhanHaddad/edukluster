// PageHeader (GLOBAL LOCK RULES #6): kiri = h1 (+badge lama, kini TIDAK dipakai —
// Screen 3 rev2 membuang badge header) + deskripsi; kanan = chip periode.
// Prop `active` dibiarkan no-op demi kompatibilitas pemanggil lama.
export default function PageHeader({ title, description, periodChip }) {
  return (
    <header className="flex flex-wrap items-start justify-between gap-3">
      <div className="min-w-0">
        <div className="flex flex-wrap items-center gap-2">
          <h1 className="text-xl font-semibold leading-7 tracking-[-0.015em] text-ink">{title}</h1>
        </div>
        {description ? (
          <p className="mt-1 text-sm leading-5 text-muted">{description}</p>
        ) : null}
      </div>
      {periodChip ?? null}
    </header>
  );
}
