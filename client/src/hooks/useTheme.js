import { useCallback, useEffect, useState } from 'react';

// Theme mode terpusat (Ticket SHELL-POLISH): 'light' | 'dark' | 'system'.
// - Persist di localStorage key 'theme-mode' (kontrak tiket).
// - light => hapus class 'dark' di <html>; dark => tambah;
//   system => ikuti matchMedia('(prefers-color-scheme: dark)') + listener 'change'
//   selama mode = system.
// - Key lama 'edukluster.theme' dimigrasi sekali (back-compat Screen 1).
// - Inisialisasinya DITULIS ULANG secara identik di inline script index.html
//   (anti-FOUC); JAGA KEDUANYA TETAK SINKRON bila logika ini berubah.
export const THEME_MODE_KEY = 'theme-mode';
const LEGACY_THEME_KEY = 'edukluster.theme';

export function prefersDarkScheme() {
  return (
    typeof window !== 'undefined' &&
    typeof window.matchMedia === 'function' &&
    window.matchMedia('(prefers-color-scheme: dark)').matches
  );
}

export function readStoredMode() {
  try {
    const m = localStorage.getItem(THEME_MODE_KEY);
    if (m === 'light' || m === 'dark' || m === 'system') return m;
    // Migrasi preferensi lama ('dark' | 'light') dari era ThemeToggle dua-ikon.
    const legacy = localStorage.getItem(LEGACY_THEME_KEY);
    if (legacy === 'dark') return 'dark';
    if (legacy === 'light') return 'light';
  } catch {
    /* noop */
  }
  // Default pengikut sistem — sama persis dengan inline script index.html.
  return 'system';
}

export function applyThemeMode(mode) {
  const dark = mode === 'dark' || (mode === 'system' && prefersDarkScheme());
  document.documentElement.classList.toggle('dark', dark);
}

export default function useTheme() {
  const [mode, setModeState] = useState(readStoredMode);

  // Terapkan class `dark` tiap mode/sistem-preferensi berubah (idempoten dgn inline script).
  useEffect(() => {
    applyThemeMode(mode);
    if (mode !== 'system') return undefined;
    const mq = window.matchMedia('(prefers-color-scheme: dark)');
    const onChange = () => applyThemeMode('system');
    mq.addEventListener('change', onChange);
    return () => mq.removeEventListener('change', onChange);
  }, [mode]);

  const setMode = useCallback((next) => {
    setModeState(next);
    try {
      localStorage.setItem(THEME_MODE_KEY, next);
    } catch {
      /* noop */
    }
  }, []);

  return { mode, setMode };
}
