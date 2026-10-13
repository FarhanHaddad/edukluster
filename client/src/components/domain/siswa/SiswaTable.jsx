import { Link } from 'react-router-dom';
import { Eye, Pencil, Trash2, Users, FileSpreadsheet, AlertTriangle } from 'lucide-react';
import Badge from '../../ui/Badge';
import Button from '../../ui/Button';
import { getSourceBadgeProps } from '../../../lib/constants';

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
  isError = false,
  onRetry,
  page = 1,
  limit = 10,
  onViewDetail,
  onDelete,
  onSwitchTab,
  onDownloadTemplate,
  hasActiveFilter = false,
  onResetFilter,
}) {
  if (isLoading) {
    return (
      <div className="flex min-h-64 items-center justify-center py-12">
        <p className="text-sm font-medium text-muted">Memuat data siswa...</p>
      </div>
    );
  }

  if (isError) {
    return (
      <div className="flex flex-col items-center px-6 py-12 text-center">
        <div className="mb-4 flex size-12 items-center justify-center rounded-lg bg-warning-tint">
          <AlertTriangle size={24} className="text-warning" aria-hidden="true" />
        </div>
        <h2 className="text-base font-semibold leading-6 text-ink">
          Gagal memuat data siswa.
        </h2>
        <p className="mt-2 max-w-md text-sm leading-5 text-muted">
          Terjadi kesalahan saat mengambil data dari server. Coba beberapa saat lagi.
        </p>
        <div className="mt-6 flex justify-center">
          <Button variant="solid" onClick={onRetry} className="w-full sm:w-auto">
            Coba Lagi
          </Button>
        </div>
      </div>
    );
  }

  if (items.length === 0) {
    return (
      <div className="flex flex-col items-center px-6 py-12 text-center">
        <div className="mb-4 flex size-12 items-center justify-center rounded-lg bg-brand-tint">
          <Users size={24} className="text-brand" aria-hidden="true" />
        </div>
        <h2 className="text-base font-semibold leading-6 text-ink">
          {hasActiveFilter
            ? 'Tidak ada siswa yang cocok dengan pencarian/filter aktif.'
            : 'Belum ada data siswa'}
        </h2>
        <p className="mt-2 max-w-md text-sm leading-5 text-muted">
          {hasActiveFilter
            ? 'Coba ubah kata kunci atau atur ulang filter untuk melihat data siswa.'
            : 'Mulai dengan menambahkan siswa satu per satu atau import berkas Excel template sesuai format clustering EduCluster.'}
        </p>
        <div className="mt-6 flex flex-wrap items-center justify-center gap-3">
          {hasActiveFilter && (
            <Button variant="outline" onClick={onResetFilter} className="w-full sm:w-auto">
              Reset Filter
            </Button>
          )}

          <Button
            variant="solid"
            onClick={() => onSwitchTab?.('excel')}
            className="w-full sm:w-auto"
          >
            <FileSpreadsheet size={16} aria-hidden="true" />
            Import Excel
          </Button>

          <Button
            variant="outline"
            className="w-full sm:w-auto"
            onClick={() => onSwitchTab?.('single_input')}
          >
            Single Input
          </Button>

          <button
            type="button"
            onClick={onDownloadTemplate}
            className="text-sm font-semibold text-brand hover:underline underline-offset-4 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand/40 rounded px-1 cursor-pointer"
          >
            Unduh Template Excel (.xlsx)
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="overflow-x-auto">
      <table className="w-full border-collapse text-sm">
        <thead>
          <tr className="border-b border-line bg-elevated">
            <Th className="pl-6 w-16">NO</Th>
            <Th className="px-4">NIS</Th>
            <Th className="px-4">Nama Siswa</Th>
            <Th className="px-4">Kelas</Th>
            <Th className="px-4">Source</Th>
            <Th className="pr-6 text-right">Aksi</Th>
          </tr>
        </thead>
        <tbody className="divide-y divide-line text-ink">
          {items.map((item, index) => {
            const rowNumber = (page - 1) * limit + index + 1;
            const sourceType = item.source_type || item.source;
            const badgeProps = getSourceBadgeProps(sourceType);

            return (
              <tr key={item.id} className="hover:bg-input/50 transition-colors">
                <td className="py-3.5 pl-6 font-mono text-sm text-muted">
                  {rowNumber}
                </td>
                <td className="px-4 py-3.5 font-mono text-sm font-medium text-ink">
                  {item.nis}
                </td>
                <td className="px-4 py-3.5 font-medium text-ink">{item.nama}</td>
                <td className="px-4 py-3.5 text-ink">{item.kelas}</td>
                <td className="px-4 py-3.5">
                  <Badge tone={badgeProps.tone}>{badgeProps.label}</Badge>
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
