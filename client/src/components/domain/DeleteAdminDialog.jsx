import { useEffect, useState } from 'react';
import { AlertTriangle, X } from 'lucide-react';
import Dialog from '../ui/Dialog';
import Button from '../ui/Button';
import useDeleteAdmin from '../../hooks/useDeleteAdmin';

export default function DeleteAdminDialog({ open, admin, onClose }) {
  const mutation = useDeleteAdmin();
  const [errorMessage, setErrorMessage] = useState(null);

  useEffect(() => {
    if (open) {
      setErrorMessage(null);
      mutation.reset?.();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open]);

  async function handleDelete() {
    if (!admin?.id) return;
    setErrorMessage(null);
    try {
      await mutation.mutateAsync(admin.id);
      onClose();
    } catch (err) {
      const msg = err.response?.data?.message ?? 'Gagal menghapus admin.';
      setErrorMessage(msg);
    }
  }

  return (
    <Dialog open={open} onClose={onClose} labelledBy="delete-admin-title" className="max-w-md">
      <button
        type="button"
        onClick={onClose}
        aria-label="Tutup dialog"
        title="Tutup"
        className="absolute right-4 top-4 rounded-md p-1 text-muted transition-colors hover:bg-line hover:text-ink"
      >
        <X size={16} aria-hidden="true" />
      </button>

      <div className="flex items-center gap-3 pr-8">
        <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-danger-tint text-danger-text">
          <AlertTriangle size={20} aria-hidden="true" />
        </div>
        <div className="min-w-0">
          <h2 id="delete-admin-title" className="text-base font-semibold text-ink">
            Hapus Akun Admin
          </h2>
          <p className="mt-0.5 text-sm leading-5 text-muted">
            Tindakan ini tidak dapat dibatalkan
          </p>
        </div>
      </div>

      <div className="mt-4 space-y-3">
        <p className="text-sm leading-6 text-ink">
          Apakah Anda yakin ingin menghapus akun admin{' '}
          <span className="font-semibold text-ink">{admin?.username}</span>?
        </p>

        {errorMessage && (
          <div className="rounded-lg border border-danger/30 bg-danger-tint px-3 py-2 text-sm text-danger-text">
            {errorMessage}
          </div>
        )}
      </div>

      <div className="flex items-center justify-end gap-3 pt-6">
        <Button variant="outline" onClick={onClose} type="button">
          Batal
        </Button>
        <Button variant="destructive" onClick={handleDelete} disabled={mutation.isPending}>
          {mutation.isPending ? 'Menghapus...' : 'Hapus Admin'}
        </Button>
      </div>
    </Dialog>
  );
}
