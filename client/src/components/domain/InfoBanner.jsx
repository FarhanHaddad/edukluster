import { useState } from 'react';
import { Info, X } from 'lucide-react';

// Banner info dismissible (frame 3A rev2): ikon info + teks whitelisted + tombol X.
// Gaya mengikuti aturan semantic-color: soft tint (info) saja, tanpa gradient/glow.
export default function InfoBanner({ children, className = '' }) {
  const [dismissed, setDismissed] = useState(false);

  if (dismissed) return null;

  return (
    <div
      role="note"
      className={`flex items-start gap-3 rounded-lg border border-line bg-info-tint px-4 py-3 ${className}`}
    >
      <Info size={16} className="mt-0.5 shrink-0 text-info" aria-hidden="true" />
      <p className="min-w-0 flex-1 text-sm leading-5 text-ink">{children}</p>
      <button
        type="button"
        onClick={() => setDismissed(true)}
        aria-label="Tutup informasi"
        title="Tutup"
        className="-mr-1 shrink-0 rounded-md p-1 text-muted transition-colors hover:bg-card hover:text-ink"
      >
        <X size={16} aria-hidden="true" />
      </button>
    </div>
  );
}
