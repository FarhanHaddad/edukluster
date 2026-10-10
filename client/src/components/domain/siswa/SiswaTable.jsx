import { Link } from 'react-router-dom';
import { Eye, Pencil, Trash2, Users, FileSpreadsheet } from 'lucide-react';
import Badge from '../../ui/Badge';
import Button from '../../ui/Button';
import Tooltip from '../../ui/Tooltip';

function Th({ children, className = '' }) {
  return (
    <th
      className={`px-6 py-3 text-left text-xs font-semibold uppercase tracking-wide text-muted ${className}`}
    >
      {children}
    </th>
  );
}

export default function SiswaTable({
  items = [],
  isLoading = false,
  onViewDetail,
  onDelete,
  onSwitchTab,
}) {
  if (isLoading) {
    return (
      <div className="flex min-h-64 items-center justify-center py-12">
        <p className="text-sm font-medium text-muted">Memuat data siswa...</p>
      </div>
    );
  }

  if (items.length === 0) {
    return (
      <div className="flex flex-col items-center px-6 py-12 text-center">
        <div className="mb-4 flex size-12 items-center justify-center rounded-lg bg-brand-tint">
          <Users size={24} className="text-brand" aria-hidden="true" />
        </div>
        <h2 className="text-base font-semibold leading-6 text-ink">Belum ada data siswa</h2>
        <p className="mt-2 max-w-md text-sm leading-5 text-muted">
          Mulai dengan menambahkan siswa satu per satu atau import berkas Excel template sesuai format clustering EduCluster.
        </p>
        <div className="mt-6 flex flex-wrap items-center justify-center gap-3">
          <Tooltip content="Segera hadir">
            <Button variant="solid" disabled className="w-full sm:w-auto">
              <FileSpreadsheet size={16} aria-hidden="true" />
              Import Excel
            </Button>
          </Tooltip>

          <Button variant="outline" className="w-full sm:w-auto" onClick={() => onSwitchTab?.('single_input')}>
            Single Input
          </Button>

          <Tooltip content="Segera hadir">
            <span className="text-sm font-semibold text-muted opacity-60 cursor-not-allowed underline-offset-4 hover:underline">
              Unduh Template Excel (.xlsx)
            </span>
          </Tooltip>
        </div>
      </div>
    );
  }

  return (
    <div className="overflow-x-auto">
      <table className="w-full border-collapse text-sm">
        <thead>
          <tr className="border-b border-line bg-elevated">
            <Th className="pl-6">NIS</Th>
            <Th>Nama Siswa</Th>
            <Th>Kelas</Th>
            <Th>Source</Th>
            <Th className="pr-6 text-right">Aksi</Th>
          </tr>
        </thead>
        <tbody className="divide-y divide-line text-ink">
          {items.map((item) => {
            const sourceType = item.source_type || item.source;
            const isExcel = sourceType === 'excel';
            const sourceLabel = isExcel ? 'Excel' : 'Manual';
            const sourceTone = isExcel ? 'info' : 'warning';

            return (
              <tr key={item.id} className="hover:bg-input/50 transition-colors">
                <td className="py-3.5 pl-6 font-mono text-sm font-medium text-ink">
                  {item.nis}
                </td>
                <td className="px-4 py-3.5 font-medium text-ink">{item.nama}</td>
                <td className="px-4 py-3.5 text-ink">{item.kelas}</td>
                <td className="px-4 py-3.5">
                  <Badge tone={sourceTone}>{sourceLabel}</Badge>
                </td>
                <td className="py-3.5 pr-6 text-right">
                  <div className="flex items-center justify-end gap-1">
                    <button
                      type="button"
                      onClick={() => onViewDetail?.(item)}
                      aria-label={`Lihat detail ${item.nama}`}
                      className="flex size-8 items-center justify-center rounded-lg text-muted hover:bg-line hover:text-ink transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand/40"
                    >
                      <Eye size={16} aria-hidden="true" />
                    </button>

                    <Link
                      to={`/siswa/${item.id}/edit`}
                      aria-label={`Edit ${item.nama}`}
                      className="flex size-8 items-center justify-center rounded-lg text-muted hover:bg-line hover:text-ink transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand/40"
                    >
                      <Pencil size={16} aria-hidden="true" />
                    </Link>

                    <button
                      type="button"
                      onClick={() => onDelete?.(item)}
                      aria-label={`Hapus ${item.nama}`}
                      className="flex size-8 items-center justify-center rounded-lg text-danger hover:bg-danger-tint hover:text-danger transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-danger/40"
                    >
                      <Trash2 size={16} aria-hidden="true" />
                    </button>
                  </div>
                </td>
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}
