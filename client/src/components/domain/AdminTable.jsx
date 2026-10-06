import { Edit2, Trash2 } from 'lucide-react';
import Badge from '../ui/Badge';
import Button from '../ui/Button';
import Tooltip from '../ui/Tooltip';

export default function AdminTable({
  items = [],
  currentAdminId,
  currentAdminUsername,
  onEdit,
  onDelete,
}) {
  const totalCount = items.length;

  return (
    <div className="overflow-x-auto">
      <table className="w-full text-left text-sm">
        <thead>
          <tr className="border-b border-line text-xs font-semibold uppercase tracking-wider text-muted">
            <th scope="col" className="px-6 py-3">USERNAME</th>
            <th scope="col" className="px-6 py-3">STATUS</th>
            <th scope="col" className="px-6 py-3">DIBUAT</th>
            <th scope="col" className="px-6 py-3 text-right">AKSI</th>
          </tr>
        </thead>
        <tbody className="divide-y divide-line text-ink">
          {items.map((item) => {
            const isSelf =
              (currentAdminId && item.id === currentAdminId) ||
              (currentAdminUsername && item.username === currentAdminUsername);
            const isOnlyOne = totalCount === 1;
            const isDeleteDisabled = isSelf || isOnlyOne;

            let tooltipText = '';
            if (isSelf) {
              tooltipText = 'Anda tidak dapat menghapus akun sendiri.';
            } else if (isOnlyOne) {
              tooltipText = 'Tidak dapat menghapus admin terakhir.';
            }

            return (
              <tr key={item.id ?? item.username} className="hover:bg-input/50 transition-colors">
                <td className="px-6 py-4 font-medium">
                  <div className="flex items-center gap-2">
                    <span>{item.username}</span>
                    {isSelf && (
                      <span className="rounded-full bg-brand-tint px-2 py-0.5 text-xs font-semibold text-brand">
                        Anda
                      </span>
                    )}
                  </div>
                </td>
                <td className="px-6 py-4">
                  <Badge tone={item.status ? 'success' : 'neutral'}>
                    {item.status ? 'Aktif' : 'Nonaktif'}
                  </Badge>
                </td>
                <td className="px-6 py-4 text-muted">
                  {item.createdAt ? formatDate(item.createdAt) : '-'}
                </td>
                <td className="px-6 py-4 text-right">
                  <div className="flex items-center justify-end gap-2">
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => onEdit?.(item)}
                    >
                      <Edit2 size={14} aria-hidden="true" />
                      Edit
                    </Button>

                    <Tooltip content={tooltipText} disabled={!isDeleteDisabled}>
                      <Button
                        variant="outline"
                        size="sm"
                        disabled={isDeleteDisabled}
                        onClick={() => !isDeleteDisabled && onDelete?.(item)}
                        className={isDeleteDisabled ? 'opacity-50 cursor-not-allowed' : ''}
                      >
                        <Trash2 size={14} aria-hidden="true" />
                        Delete
                      </Button>
                    </Tooltip>
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

function formatDate(dateStr) {
  try {
    const d = new Date(dateStr);
    if (isNaN(d.getTime())) return dateStr;
    return d.toLocaleDateString('id-ID', {
      day: '2-digit',
      month: 'short',
      year: 'numeric',
    });
  } catch {
    return dateStr;
  }
}
