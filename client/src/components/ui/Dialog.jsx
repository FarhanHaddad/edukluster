import { useEffect, useRef } from 'react';
import { createPortal } from 'react-dom';
import { cn } from '../../lib/utils';

// Primitif Dialog headless TANPA library baru (SHELL-POLISH #4):
// - portal ke <body>, centered di atas backdrop dim,
// - tutup via Escape + klik pada backdrop (bukan isi panel),
// - fokus AWAL dipindah SEKALI ke panel tepat saat dialog membuka
//   (deps [open]; ref stabil agar tidak ada work per-render yang bisa
//   menyulik focus input di dalam form tiap keystroke — FOCUS-FIX);
//   restore fokus saat tertutup tidak diperlukan (aksi lanjutan sudah
//   memindahkan fokus secara eksplisit).
export default function Dialog({ open, onClose, className, labelledBy, ariaLabel, children }) {
  const panelRef = useRef(null);

  // Stabilkan identitas onClose untuk effect ber-deps [open] saja:
  // handler terbaru selalu dibaca lewat ref, tanpa me-resubscribe listener.
  const closeRef = useRef(onClose);
  closeRef.current = onClose;

  useEffect(() => {
    if (!open) return undefined;
    // Auto-focus panel HANYA saat transisi closed -> open (sekali per buka).
    panelRef.current?.focus();
    function onKeyDown(e) {
      if (e.key === 'Escape') closeRef.current?.();
    }
    document.addEventListener('keydown', onKeyDown);
    // Kunci scroll background selama dialog terbuka.
    const prevOverflow = document.body.style.overflow;
    document.body.style.overflow = 'hidden';
    return () => {
      document.removeEventListener('keydown', onKeyDown);
      document.body.style.overflow = prevOverflow;
    };
  }, [open]);

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
        ref={panelRef}
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
