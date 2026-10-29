import { Filter, ArrowUpDown } from 'lucide-react';

export default function FilterSortToolbar({
  filterCluster,
  onFilterChange,
  sortBy,
  onSortChange,
}) {
  return (
    <div className="flex flex-wrap items-center justify-end gap-3 pb-2">
      <div className="flex items-center gap-2">
        <Filter className="size-4 text-muted" />
        <label htmlFor="filter-cluster" className="text-xs font-medium text-muted">
          Filter:
        </label>
        <select
          id="filter-cluster"
          value={filterCluster}
          onChange={(e) => onFilterChange(e.target.value)}
          className="h-9 rounded-md border border-line bg-card px-3 py-1 text-xs text-main shadow-sm focus:border-brand focus:outline-none"
        >
          <option value="all">Semua Cluster</option>
          {Array.from({ length: 10 }, (_, i) => i + 1).map((n) => (
            <option key={n} value={String(n)}>
              Cluster {n} (C{n})
            </option>
          ))}
        </select>
      </div>

      <div className="flex items-center gap-2">
        <ArrowUpDown className="size-4 text-muted" />
        <label htmlFor="sort-by" className="text-xs font-medium text-muted">
          Urutkan:
        </label>
        <select
          id="sort-by"
          value={sortBy}
          onChange={(e) => onSortChange(e.target.value)}
          className="h-9 rounded-md border border-line bg-card px-3 py-1 text-xs text-main shadow-sm focus:border-brand focus:outline-none"
        >
          <option value="nis">NIS (default)</option>
          <option value="nama">Nama Siswa</option>
          <option value="cluster">Cluster</option>
          <option value="distance">Distance (Terdekat)</option>
        </select>
      </div>
    </div>
  );
}
