import { useState, useEffect, useMemo } from 'react';
import { Filter, ArrowUpDown, ChevronLeft, ChevronRight } from 'lucide-react';
import { KMEANS_PALETTE } from '../../../constants/kmeans';

export default function ResultTable({ assignments = [] }) {
  const [filterCluster, setFilterCluster] = useState('all');
  const [sortBy, setSortBy] = useState('nis');
  const [currentPage, setCurrentPage] = useState(1);
  const pageSize = 10;

  // Reset to page 1 whenever filter or sort changes
  useEffect(() => {
    setCurrentPage(1);
  }, [filterCluster, sortBy]);

  const filteredData = useMemo(() => {
    if (filterCluster === 'all') return assignments;
    const targetClusterIndex = Number(filterCluster) - 1;
    return assignments.filter(
      (item) => Number(item.clusterIndex) === targetClusterIndex
    );
  }, [assignments, filterCluster]);

  const sortedData = useMemo(() => {
    const list = [...filteredData];
    list.sort((a, b) => {
      if (sortBy === 'nama') {
        return String(a.nama || '').localeCompare(String(b.nama || ''));
      }
      if (sortBy === 'cluster') {
        const cA = Number(a.clusterIndex ?? 0);
        const cB = Number(b.clusterIndex ?? 0);
        if (cA !== cB) return cA - cB;
        return String(a.nis || '').localeCompare(String(b.nis || ''));
      }
      if (sortBy === 'distance') {
        const dA = parseFloat(a.distance ?? 0);
        const dB = parseFloat(b.distance ?? 0);
        return dA - dB;
      }
      // default: nis
      return String(a.nis || '').localeCompare(String(b.nis || ''));
    });
    return list;
  }, [filteredData, sortBy]);

  const totalFiltered = sortedData.length;
  const totalPages = Math.max(1, Math.ceil(totalFiltered / pageSize));
  const safePage = Math.min(currentPage, totalPages);

  const startIndex = (safePage - 1) * pageSize;
  const pageData = sortedData.slice(startIndex, startIndex + pageSize);

  const startDisplay = totalFiltered === 0 ? 0 : startIndex + 1;
  const endDisplay = Math.min(startIndex + pageSize, totalFiltered);

  // Generates page number buttons list with ellipsis
  const getPageNumbers = () => {
    const pages = [];
    if (totalPages <= 7) {
      for (let i = 1; i <= totalPages; i++) pages.push(i);
    } else {
      pages.push(1);
      if (safePage > 3) pages.push('...');
      const start = Math.max(2, safePage - 1);
      const end = Math.min(totalPages - 1, safePage + 1);
      for (let i = start; i <= end; i++) pages.push(i);
      if (safePage < totalPages - 2) pages.push('...');
      pages.push(totalPages);
    }
    return pages;
  };

  return (
    <div className="space-y-4">
      {/* Table Scoped Toolbar */}
      <div className="flex flex-wrap items-center justify-between gap-3 border-b border-line pb-3">
        <h3 className="text-sm font-semibold text-main">
          Daftar Hasil Klaster Siswa
        </h3>

        <div className="flex flex-wrap items-center gap-3">
          <div className="flex items-center gap-1.5">
            <Filter className="size-3.5 text-muted" />
            <label htmlFor="filter-cluster-table" className="text-xs font-medium text-muted">
              Filter:
            </label>
            <select
              id="filter-cluster-table"
              value={filterCluster}
              onChange={(e) => setFilterCluster(e.target.value)}
              className="h-8 rounded-md border border-line bg-card px-2.5 py-1 text-xs text-main shadow-sm focus:border-brand focus:outline-none"
            >
              <option value="all">Semua Cluster</option>
              {Array.from({ length: 10 }, (_, i) => i + 1).map((n) => (
                <option key={n} value={String(n)}>
                  Cluster {n} (C{n})
                </option>
              ))}
            </select>
          </div>

          <div className="flex items-center gap-1.5">
            <ArrowUpDown className="size-3.5 text-muted" />
            <label htmlFor="sort-by-table" className="text-xs font-medium text-muted">
              Urutkan:
            </label>
            <select
              id="sort-by-table"
              value={sortBy}
              onChange={(e) => setSortBy(e.target.value)}
              className="h-8 rounded-md border border-line bg-card px-2.5 py-1 text-xs text-main shadow-sm focus:border-brand focus:outline-none"
            >
              <option value="nis">NIS (default)</option>
              <option value="nama">Nama Siswa</option>
              <option value="cluster">Cluster</option>
              <option value="distance">Distance (Terdekat)</option>
            </select>
          </div>
        </div>
      </div>

      {/* Table */}
      <div className="overflow-x-auto rounded-lg border border-line">
        <table className="w-full text-left text-xs">
          <thead className="bg-page text-muted uppercase tracking-wider font-semibold border-b border-line">
            <tr>
              <th className="py-3 px-4">NIS</th>
              <th className="py-3 px-4">Nama Siswa</th>
              <th className="py-3 px-4">Kelas</th>
              <th className="py-3 px-4">Cluster</th>
              <th className="py-3 px-4 text-right">Distance</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-line bg-card text-main">
            {pageData.length === 0 ? (
              <tr>
                <td colSpan={5} className="py-8 text-center text-muted">
                  Tidak ada data siswa yang sesuai dengan filter.
                </td>
              </tr>
            ) : (
              pageData.map((row, idx) => {
                const cIdx = Number(row.clusterIndex) || 0;
                const clusterNum = cIdx + 1;
                const paletteColor = KMEANS_PALETTE[cIdx % KMEANS_PALETTE.length];

                return (
                  <tr key={row.nis || idx} className="hover:bg-page transition-colors">
                    <td className="py-3 px-4 font-mono">{row.nis}</td>
                    <td className="py-3 px-4 font-medium">{row.nama}</td>
                    <td className="py-3 px-4">{row.kelas}</td>
                    <td className="py-3 px-4">
                      <span
                        className="inline-flex items-center gap-1 rounded-full px-2.5 py-0.5 text-xs font-semibold"
                        style={{
                          backgroundColor: `${paletteColor}15`,
                          color: paletteColor,
                          border: `1px solid ${paletteColor}40`,
                        }}
                      >
                        <span
                          className="size-1.5 rounded-full"
                          style={{ backgroundColor: paletteColor }}
                        />
                        C{clusterNum}
                      </span>
                    </td>
                    <td className="py-3 px-4 text-right font-mono text-muted">
                      {row.distance}
                    </td>
                  </tr>
                );
              })
            )}
          </tbody>
        </table>
      </div>

      {/* Footer Pagination Numbered */}
      <div className="flex flex-col items-center justify-between gap-3 sm:flex-row text-xs text-muted pt-1">
        <div>
          Menampilkan <span className="font-semibold text-main">{startDisplay}</span>-
          <span className="font-semibold text-main">{endDisplay}</span> dari{' '}
          <span className="font-semibold text-main">{totalFiltered}</span> siswa
        </div>

        <div className="flex items-center gap-1.5">
          <button
            type="button"
            onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
            disabled={safePage <= 1}
            className="flex h-8 items-center gap-1 rounded-md border border-line bg-card px-2.5 font-medium text-main hover:bg-page disabled:opacity-40 disabled:hover:bg-card transition-colors cursor-pointer"
          >
            <ChevronLeft className="size-3.5" />
            <span className="hidden sm:inline">Sebelumnya</span>
          </button>

          {getPageNumbers().map((p, idx) => {
            if (p === '...') {
              return (
                <span key={`ellipsis-${idx}`} className="px-1.5 text-muted select-none">
                  ...
                </span>
              );
            }

            const isActive = p === safePage;
            return (
              <button
                key={p}
                type="button"
                onClick={() => setCurrentPage(p)}
                className={
                  isActive
                    ? 'flex h-8 min-w-8 items-center justify-center rounded-md bg-brand text-on-brand font-semibold text-xs transition-colors cursor-pointer'
                    : 'flex h-8 min-w-8 items-center justify-center rounded-md border border-line bg-card text-main font-medium text-xs hover:bg-page transition-colors cursor-pointer'
                }
              >
                {p}
              </button>
            );
          })}

          <button
            type="button"
            onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
            disabled={safePage >= totalPages || totalFiltered === 0}
            className="flex h-8 items-center gap-1 rounded-md border border-line bg-card px-2.5 font-medium text-main hover:bg-page disabled:opacity-40 disabled:hover:bg-card transition-colors cursor-pointer"
          >
            <span className="hidden sm:inline">Selanjutnya</span>
            <ChevronRight className="size-3.5" />
          </button>
        </div>
      </div>
    </div>
  );
}
