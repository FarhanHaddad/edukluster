import { useState, useEffect, useMemo } from 'react';
import Badge from '../../../components/ui/Badge';
import { ChevronLeft, ChevronRight } from 'lucide-react';

export default function ResultTable({ assignments = [], filterCluster = 'all', sortBy = 'nis' }) {
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

  return (
    <div className="space-y-4">
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
                const clusterNum = (Number(row.clusterIndex) || 0) + 1;
                return (
                  <tr key={row.nis || idx} className="hover:bg-page/50 transition-colors">
                    <td className="py-3 px-4 font-mono">{row.nis}</td>
                    <td className="py-3 px-4 font-medium">{row.nama}</td>
                    <td className="py-3 px-4">{row.kelas}</td>
                    <td className="py-3 px-4">
                      <Badge tone="primary">C{clusterNum}</Badge>
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

      {/* Footer Pagination */}
      <div className="flex flex-col items-center justify-between gap-3 sm:flex-row text-xs text-muted">
        <div>
          Menampilkan <span className="font-semibold text-main">{startDisplay}</span>-
          <span className="font-semibold text-main">{endDisplay}</span> dari{' '}
          <span className="font-semibold text-main">{totalFiltered}</span> siswa
        </div>

        <div className="flex items-center gap-2">
          <button
            onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
            disabled={safePage <= 1}
            className="flex items-center gap-1 rounded-md border border-line bg-card px-2.5 py-1.5 font-medium text-main hover:bg-page disabled:opacity-40 disabled:hover:bg-card"
          >
            <ChevronLeft className="size-3.5" />
            <span>Sebelumnya</span>
          </button>
          <span className="px-2 font-medium">
            {safePage} / {totalPages}
          </span>
          <button
            onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
            disabled={safePage >= totalPages}
            className="flex items-center gap-1 rounded-md border border-line bg-card px-2.5 py-1.5 font-medium text-main hover:bg-page disabled:opacity-40 disabled:hover:bg-card"
          >
            <span>Selanjutnya</span>
            <ChevronRight className="size-3.5" />
          </button>
        </div>
      </div>
    </div>
  );
}
