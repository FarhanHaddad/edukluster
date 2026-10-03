import { useEffect } from 'react';
import { createPortal } from 'react-dom';
import { cn } from '../../lib/utils';

// Primitif Dialog headless TANPA library baru (SHELL-POLISH #4):
// - portal ke <body>, centered di atas backdrop dim,
// - tutup via Escape + klik pada backdrop (bukan isi panel),
// - fokus awal ke panel; restore fokus saat tertutup tidak diperlukan
//   (aksi lanjutan sudah memindahkan fokus secara eksplisit).
export default function Dialog({ open, onClose, className, labelledBy, ariaLabel, children }) {
  useEffect(() => {
    if (!open) return undefined;
    function onKeyDown(e) {
      if (e.key === 'Escape') onClose?.();
    }
    document.addEventListener('keydown', onKeyDown);
    // Kunci scroll background selama dialog terbuka.
    const prevOverflow = document.body.style.overflow;
    document.body.style.overflow = 'hidden';
    return () => {
      document.removeEventListener('keydown', onKeyDown);
      document.body.style.overflow = prevOverflow;
    };
  }, [open, onClose]);

  if (!open) return null;

  return createPortal(
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4"
      role="dialog"
      aria-modal="true"
      aria-labelledby={labelledBy}
      aria-label={ariaLabel}
    >
      {/* Backdrop dim (bukan blur/gradien — GLOBAL LOCK RULES) */}
      <button
        type="button"
        aria-label="Tutup dialog"
        onClick={onClose}
        className="absolute inset-0 cursor-default bg-black/50"
      />
      <div
        ref={(el) => el?.focus()}
        tabIndex={-1}
        className={cn(
          'relative w-full max-w-md rounded-lg border border-line bg-elevated p-6 shadow-lg outline-none',
          className
        )}
      >
        {children}
      </div>
    </div>,
    document.body
  );
}
