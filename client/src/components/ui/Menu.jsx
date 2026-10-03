import { useEffect, useRef, useState } from 'react';
import { cn } from '../../lib/utils';

// Primitif dropdown headless TANPA library baru (SHELL-POLISH #5):
// - anchor `relative`; panel absolut dibuka ke bawah/down atau ke atas/up,
// - tutup saat click-outside (pointerdown) dan Escape,
// - API render-prop: children = fn ({ open, toggle, close }); child kedua
//   yang dirender fn tsb adalah ISI panel menu (auto dibungkus panel).
export default function Menu({ align = 'right', placement = 'down', className, children }) {
  const [open, setOpen] = useState(false);
  const rootRef = useRef(null);

  useEffect(() => {
    if (!open) return undefined;
    function onPointerDown(e) {
      if (rootRef.current && !rootRef.current.contains(e.target)) setOpen(false);
    }
    function onKeyDown(e) {
      if (e.key === 'Escape') setOpen(false);
    }
    document.addEventListener('pointerdown', onPointerDown);
    document.addEventListener('keydown', onKeyDown);
    return () => {
      document.removeEventListener('pointerdown', onPointerDown);
      document.removeEventListener('keydown', onKeyDown);
    };
  }, [open]);

  const rendered = children({ open, toggle: () => setOpen((p) => !p), close: () => setOpen(false) });
  // Render-prop mengembalikan array [trigger, panelContent]; normalisasi React.Children.
  const nodes = Array.isArray(rendered) ? rendered : [rendered];
  const [trigger, ...panelChildren] = nodes;

  return (
    <div ref={rootRef} className="relative shrink-0">
      {trigger}
      {open && (
        <div
          role="menu"
          className={cn(
            'absolute z-30 min-w-44 rounded-lg border border-line bg-elevated p-1 shadow-md',
            placement === 'up' ? 'bottom-full mb-2' : 'top-full mt-2',
            align === 'left' ? 'left-0' : 'right-0',
            className
          )}
        >
          {panelChildren}
        </div>
      )}
    </div>
  );
}

// Item menu standar: ikon kiri + label; varian danger utk aksi destruktif.
export function MenuItem({ icon: Icon, danger = false, onClick, children, className, ...props }) {
  return (
    <button
      type="button"
      role="menuitem"
      onClick={onClick}
      className={cn(
        'flex h-9 w-full items-center gap-2 rounded-md px-3 text-sm font-medium transition-colors',
        danger
          ? 'text-danger-text hover:bg-danger-tint'
          : 'text-ink hover:bg-line',
        className
      )}
      {...props}
    >
      {Icon && <Icon size={16} shrink-0 aria-hidden="true" />}
      <span className="truncate">{children}</span>
    </button>
  );
}
