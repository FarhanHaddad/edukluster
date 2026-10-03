import { useEffect, useState } from 'react';
import { Moon, Sun } from 'lucide-react';
import { cn } from '../../lib/utils';

// Theme toggle SHARED (dipakai LoginPage + Topbar): menambah/menghapus class
// `dark` di <html> + simpan preferensi di localStorage (FE Conventions).
// Inisialisasi pra-render dilakukan inline script di index.html (anti-FOUC);
// komponen ini hanya membaca state awal dari class yang sudah terpasang.
const THEME_KEY = 'edukluster.theme';

function getInitialDark() {
  if (typeof document !== 'undefined') {
    return document.documentElement.classList.contains('dark');
  }
  return false;
}

export default function ThemeToggle({ className }) {
  const [isDark, setIsDark] = useState(getInitialDark);

  // Sinkronkan class `dark` pada <html> terhadap state (idempoten dgn inline script).
  useEffect(() => {
    document.documentElement.classList.toggle('dark', isDark);
  }, [isDark]);

  function handleToggle() {
    setIsDark((prev) => {
      const next = !prev;
      try {
        localStorage.setItem(THEME_KEY, next ? 'dark' : 'light');
      } catch {
        /* noop */
      }
      return next;
    });
  }

  return (
    <button
      type="button"
      onClick={handleToggle}
      aria-label={isDark ? 'Aktifkan mode terang' : 'Aktifkan mode gelap'}
      title={isDark ? 'Mode terang' : 'Mode gelap'}
      className={cn(
        // SHELL TOKEN LOCK: toggle bg #27272A border #3F3F46 (dark) — lewat token semantik.
        'flex h-10 w-10 shrink-0 items-center justify-center rounded-lg border transition-colors',
        'border-line-strong bg-chip-bg text-muted hover:text-ink',
        className
      )}
    >
      {isDark ? <Sun size={18} /> : <Moon size={18} />}
    </button>
  );
}
