import { AlertTriangle } from 'lucide-react';
import Dialog from '../../ui/Dialog';
import Button from '../../ui/Button';

export default function DeleteSiswaDialog({ student, open, onClose, onConfirm, isDeleting }) {
  if (!open || !student) return null;

  const nama = student.nama ?? 'Siswa';

  return (
    <Dialog open={open} onClose={onClose} labelledBy="delete-siswa-title" className="max-w-md p-6">
      <div className="flex items-start gap-4">
        <div className="flex size-10 shrink-0 items-center justify-center rounded-full bg-danger-tint text-danger-text">
          <AlertTriangle size={20} aria-hidden="true" />
        </div>
        <div className="min-w-0 flex-1">
          <h2 id="delete-siswa-title" className="text-base font-semibold leading-6 text-ink">
            Hapus Data Siswa?
          </h2>
          <p className="mt-2 text-sm leading-5 text-muted">
            Data siswa atas nama <strong className="font-semibold text-ink">{nama}</strong> akan dihapus permanen dari periode ini. Tindakan ini tidak dapat dibatalkan.
          </p>
        </div>
      </div>

      <div className="mt-6 flex items-center justify-end gap-3">
        <Button variant="outline" onClick={onClose} disabled={isDeleting}>
          Batal
        </Button>
        <Button
          variant="destructive"
          disabled={isDeleting}
          onClick={() => onConfirm?.(student)}
        >
          {isDeleting ? 'Menghapus...' : 'Hapus'}
        </Button>
      </div>
    </Dialog>
  );
}
