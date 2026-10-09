import { Eye, Pencil, Trash2, MoreVertical, Users, FileSpreadsheet } from 'lucide-react';
import Badge from '../../ui/Badge';
import Button from '../../ui/Button';
import Menu, { MenuItem } from '../../ui/Menu';
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
          {items.map((item, index) => {
            const sourceType = item.source_type || item.source;
            const isExcel = sourceType === 'excel';
            const sourceLabel = isExcel ? 'Excel' : 'Manual';
            const sourceTone = isExcel ? 'info' : 'warning';
            const isNearBottom = index >= items.length - 2 && items.length > 2;

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
                  <div className="flex justify-end">
                    <Menu align="right" placement={isNearBottom ? 'up' : 'down'}>
                      {({ open, toggle, close }) => [
                        <button
                          key="trigger"
                          type="button"
                          onClick={toggle}
                          aria-haspopup="menu"
                          aria-expanded={open}
                          aria-label={`Menu aksi untuk ${item.nama}`}
                          className="flex size-8 items-center justify-center rounded-lg border border-line bg-card text-muted hover:bg-line hover:text-ink transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand/40"
                        >
                          <MoreVertical size={16} aria-hidden="true" />
                        </button>,
                        <div key="panel" className="w-36 space-y-0.5">
                          <MenuItem
                            icon={Eye}
                            onClick={() => {
                              close();
                              onViewDetail?.(item);
                            }}
                          >
                            Lihat Detail
                          </MenuItem>

                          <Tooltip content="Segera hadir (Tiket FE-2)" side="left" className="w-full">
                            <button
                              type="button"
                              disabled
                              className="flex h-9 w-full items-center gap-2 rounded-md px-3 text-sm font-medium text-muted opacity-50 cursor-not-allowed"
                            >
                              <Pencil size={16} className="shrink-0" aria-hidden="true" />
                              <span className="truncate">Edit</span>
                            </button>
                          </Tooltip>

                          <div className="my-1 border-b border-line" role="separator" />

                          <MenuItem
                            icon={Trash2}
                            danger
                            onClick={() => {
                              close();
                              onDelete?.(item);
                            }}
                          >
                            Hapus
                          </MenuItem>
                        </div>,
                      ]}
                    </Menu>
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
