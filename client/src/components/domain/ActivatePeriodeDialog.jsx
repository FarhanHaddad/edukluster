import { TriangleAlert, X } from 'lucide-react';
import Dialog from '../ui/Dialog';
import Button from '../ui/Button';
import useActivatePeriode from '../../hooks/useActivatePeriode';

// Nama periode human-readable dari item API (fallback gabungan field).
function labelPeriode(p) {
  if (!p) return null;
  return p.namaPeriode ?? (`${p.tahunAjaran ?? ''}`.trim() || null);
}

// Dialog konfirmasi aktivasi (frame 3C/3D rev2): ikon warning amber, judul
// "Aktifkan Periode?", body dinamis menyebut periode TARGET + periode AKTIF
// sekarang (akan ditandai selesai), footer Batal + "Ya, Aktifkan" -> PATCH
// /periodes/:id/activate. Sukses -> tutup + invalidate (['periodes'] &
// ['dashboard-summary'] sudah di-handle hook mutation).
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
  const target = labelPeriode(periode);
  const current = labelPeriode(aktifNow);

  return (
    <Dialog open={open} onClose={onClose} labelledBy="activate-periode-title" className="max-w-md">
      {/* Kop: ikon warning amber + judul; X penutup kanan atas. */}
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
        <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-warning-tint text-warning">
          <TriangleAlert size={20} aria-hidden="true" />
        </div>
        <h2 id="activate-periode-title" className="text-base font-semibold text-ink">
          Aktifkan Periode?
        </h2>
      </div>

      {/* Body dinamis: target jadi aktif; aktif-now ditandai selesai (tanpa nama bila belum ada). */}
      <p className="mt-4 text-sm leading-5 text-ink">
        Periode <span className="font-semibold">{target}</span> akan menjadi periode aktif.{' '}
        {current ? (
          <>
            Periode <span className="font-semibold">{current}</span> akan ditandai selesai dan
          </>
        ) : null}{' '}
        seluruh modul akan mengikuti periode baru ini.
      </p>

      {errorMessage ? (
        <p className="mt-3 text-sm leading-5 text-danger-text">{errorMessage}</p>
      ) : null}

      {/* Footer kanan: Batal (outline) + CTA solid "Ya, Aktifkan" */}
      <div className="mt-6 flex items-center justify-end gap-3">
        <Button variant="outline" onClick={onClose}>
          Batal
        </Button>
        <Button onClick={onConfirm} disabled={mutation.isPending}>
          {mutation.isPending ? 'Mengaktifkan...' : 'Ya, Aktifkan'}
        </Button>
      </div>
    </Dialog>
  );
}
