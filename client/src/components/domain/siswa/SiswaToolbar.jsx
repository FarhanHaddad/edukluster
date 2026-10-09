import { useState, useEffect } from 'react';
import { Search, ChevronDown } from 'lucide-react';
import { formatAngka } from '../../../lib/format';

export default function SiswaToolbar({
  search,
  onSearchChange,
  kelas,
  onKelasChange,
  source,
  onSourceChange,
  total = 0,
}) {
  const [localSearch, setLocalSearch] = useState(search ?? '');

  // Debounce search ~300ms
  useEffect(() => {
    setLocalSearch(search ?? '');
  }, [search]);

  useEffect(() => {
    const handler = setTimeout(() => {
      if (localSearch !== search) {
        onSearchChange(localSearch);
      }
    }, 300);
    return () => clearTimeout(handler);
  }, [localSearch, search, onSearchChange]);

  return (
    <div className="flex flex-wrap items-center justify-between gap-3 p-4 border-b border-line">
      {/* Controls kiri: Search + Dropdowns */}
      <div className="flex flex-wrap items-center gap-3 min-w-0 flex-1">
        {/* Search Input */}
        <div className="relative min-w-[220px] max-w-xs flex-1">
          <Search
            size={16}
            className="absolute left-3 top-1/2 -translate-y-1/2 text-faint"
            aria-hidden="true"
          />
          <input
            type="text"
            value={localSearch}
            onChange={(e) => setLocalSearch(e.target.value)}
            placeholder="Cari NIS atau nama siswa..."
            className="h-10 w-full rounded-lg border border-line bg-input pl-9 pr-3 text-sm text-ink placeholder:text-faint focus:border-brand focus:outline-none focus:ring-2 focus:ring-brand/30 transition-colors"
          />
        </div>

        {/* Dropdown Kelas */}
        <div className="relative">
          <select
            value={kelas}
            onChange={(e) => onKelasChange(e.target.value)}
            className="h-10 cursor-pointer appearance-none rounded-lg border border-line bg-input pl-3 pr-8 text-sm font-medium text-ink focus:border-brand focus:outline-none focus:ring-2 focus:ring-brand/30 transition-colors"
          >
            <option value="">Semua Kelas</option>
            <option value="XII-1">XII-1</option>
            <option value="XII-2">XII-2</option>
            <option value="XII-3">XII-3</option>
            <option value="XII-4">XII-4</option>
          </select>
          <ChevronDown
            size={16}
            className="pointer-events-none absolute right-2.5 top-1/2 -translate-y-1/2 text-faint"
            aria-hidden="true"
          />
        </div>

        {/* Dropdown Source */}
        <div className="relative">
          <select
            value={source}
            onChange={(e) => onSourceChange(e.target.value)}
            className="h-10 cursor-pointer appearance-none rounded-lg border border-line bg-input pl-3 pr-8 text-sm font-medium text-ink focus:border-brand focus:outline-none focus:ring-2 focus:ring-brand/30 transition-colors"
          >
            <option value="">Semua Source</option>
            <option value="excel">Excel</option>
            <option value="single_input">Manual</option>
          </select>
          <ChevronDown
            size={16}
            className="pointer-events-none absolute right-2.5 top-1/2 -translate-y-1/2 text-faint"
            aria-hidden="true"
          />
        </div>
      </div>

      {/* Counter kanan */}
      <div className="text-sm font-medium text-muted">
        <span className="font-mono font-semibold text-ink">{formatAngka(total)}</span> siswa
      </div>
    </div>
  );
}
