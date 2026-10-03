import { CalendarCheck } from 'lucide-react';
import Dialog from '../ui/Dialog';
import Button from '../ui/Button';
import useActivatePeriode from '../../hooks/useActivatePeriode';

// Dialog konfirmasi aktivasi (frame 3C/3D): menyebut periode target + catatan
// bahwa periode AKTIF sekarang akan ditandai SELESAI. Sukses -> tutup + invalidate
// (['periodes'] & ['dashboard-summary'] sudah di-handle hook mutation).
export default function ActivatePeriodeDialog({ open, onClose, periode, aktifNow }) {
  const mutation = useActivatePeriode();

  if (!periode) return null;

  async function onConfirm() {
    try {
      await mutation.mutateAsync(periode.id);
      onClose();
    } catch (err) {
      // 409 "sudah aktif" / 404: biarkan dialog terbuka, tampilkan pesan BE inline.
      void err;
    }
  }

  const errorMessage = mutation.error?.response?.data?.message ?? null;

  return (
    <Dialog open={open} onClose={onClose} labelledBy="activate-periode-title" className="max-w-md">
      <div className="flex items-center gap-3">
        <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-brand-tint text-brand">
          <CalendarCheck size={20} aria-hidden="true" />
        </div>
        <h2 id="activate-periode-title" className="text-base font-semibold text-ink">
          Aktifkan Periode Ini?
        </h2>
      </div>

      <p className="mt-4 text-sm leading-5 text-ink">
        Periode <span className="font-semibold">{periode.namaPeriode}</span> akan menjadi periode
        aktif dan dipakai seluruh alur klasterisasi.
      </p>
      {aktifNow ? (
        <p className="mt-2 text-sm leading-5 text-muted">
          Periode aktif saat ini{' '}
          <span className="font-semibold text-ink">{aktifNow.namaPeriode}</span> akan ditandai
          SELESAI.
        </p>
      ) : null}

      {errorMessage ? (
        <p className="mt-3 text-sm leading-5 text-danger-text">{errorMessage}</p>
      ) : null}

      {/* Footer kanan: Batal (outline) + CTA solid "Aktifkan" */}
      <div className="mt-6 flex items-center justify-end gap-3">
        <Button variant="outline" onClick={onClose}>
          Batal
        </Button>
        <Button onClick={onConfirm} disabled={mutation.isPending}>
          {mutation.isPending ? 'Mengaktifkan...' : 'Aktifkan'}
        </Button>
      </div>
    </Dialog>
  );
}
