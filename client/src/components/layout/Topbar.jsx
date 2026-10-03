import { Search } from 'lucide-react';
import ThemeToggle from '../ui/ThemeToggle';
import widuri from '../../assets/widuri.png';

// Topbar (GLOBAL LOCK RULES #1): HANYA search (+chip ⌘K), theme toggle, avatar.
// NOL bell, NOL help, NOL ikon ekstra.
export default function Topbar() {
  return (
    <header className="flex h-16 shrink-0 items-center gap-3 border-b border-line bg-card px-6">
      {/* Search global: recessed input + chip shortcut mono */}
      <div className="relative w-full max-w-md">
        <Search
          size={16}
          className="pointer-events-none absolute left-3 top-1/2 -translate-y-1/2 text-faint"
          aria-hidden="true"
        />
        <input
          type="search"
          placeholder="Cari data, menu, laporan..."
          aria-label="Cari data, menu, laporan"
          className="h-10 w-full rounded-lg border border-line bg-search-bg pl-9 pr-14 text-sm text-ink outline-none transition-colors placeholder:text-faint focus:border-brand focus:ring-2 focus:ring-brand/20"
        />
        <kbd className="pointer-events-none absolute right-2 top-1/2 -translate-y-1/2 rounded-md border border-line-strong bg-chip-bg px-1.5 py-0.5 font-mono text-xs font-medium leading-4 text-muted">
          ⌘K
        </kbd>
      </div>

      <div className="ml-auto flex items-center gap-3">
        <ThemeToggle />
        {/* Avatar polos 32px circle (tanpa wrapper tint) — SHELL & IDENTITY LOCK */}
        <img
          src={widuri}
          alt="Avatar admin"
          className="size-8 shrink-0 rounded-full object-cover"
        />
      </div>
    </header>
  );
}
