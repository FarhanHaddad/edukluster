import { useEffect, useState } from 'react';
import { Moon, Sun } from 'lucide-react';

// Theme toggle: menambah/menghapus class `dark` di <html> + simpan preferensi.
// Dark variant mengikuti DARK MODE CONTRACT (DESIGN.md v1.14/v1.15).
const THEME_KEY = 'edukluster.theme';

function getInitialDark() {
  if (typeof document !== 'undefined') {
    return document.documentElement.classList.contains('dark');
  }
  return false;
}

export default function ThemeToggle() {
  const [isDark, setIsDark] = useState(getInitialDark);

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
      className={
        // SHELL TOKEN LOCK (dark): theme toggle bg #27272A border #3F3F46.
        'flex h-10 w-10 items-center justify-center rounded-lg border transition-colors ' +
        'border-zinc-200 bg-white text-zinc-600 hover:bg-zinc-100 hover:text-zinc-900 ' +
        'dark:border-zinc-700 dark:bg-zinc-700/60 dark:text-zinc-300 dark:hover:bg-zinc-700 dark:hover:text-white'
      }
    >
      {isDark ? <Sun size={18} /> : <Moon size={18} />}
    </button>
  );
}
