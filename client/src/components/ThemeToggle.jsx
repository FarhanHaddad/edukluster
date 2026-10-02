import { useEffect, useState } from 'react';
import { Moon, Sun } from 'lucide-react';

// Theme toggle: menambah/menghapus class `dark` di <html> + simpan preferensi.
// Kontrak: komponen hanya memakai token semantik (CONVENTIONS.md FE Conventions) —
// tanpa prefix `dark:`; dark variant hidup di variabel CSS `.dark` (index.css).
const THEME_KEY = 'edukluster.theme';

function getInitialDark() {
  if (typeof document !== 'undefined') {
    return document.documentElement.classList.contains('dark');
  }
  return false;
}

export default function ThemeToggle() {
  const [isDark, setIsDark] = useState(getInitialDark);

  // Sinkronkan state bila tema berubah dari sumber lain (mis. skrip pre-hydration index.html).
  useEffect(() => {
    setIsDark(document.documentElement.classList.contains('dark'));
  }, []);

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
      // SHELL TOKEN LOCK: theme toggle h-10, bg/tok border kuat (konsum token .dark otomatis).
      className="flex h-10 w-10 items-center justify-center rounded-lg border border-line-strong bg-chip text-content-secondary transition-colors hover:text-content"
    >
      {isDark ? <Sun size={18} /> : <Moon size={18} />}
    </button>
  );
}
