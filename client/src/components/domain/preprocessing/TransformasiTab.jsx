import { useState } from 'react';
import {
  useTransformConfig,
  useCreateTransformOption,
  useDeleteTransformOption,
  useSaveTransformAssignments,
  useRunTransform,
} from '../../../hooks/usePreprocessing';
import InfoBanner from '../InfoBanner';
import UnmappedBanner from './UnmappedBanner';
import BidangAccordion from './BidangAccordion';
import NormalisasiInfo from './NormalisasiInfo';
import Button from '../../ui/Button';
import Dialog from '../../ui/Dialog';
import Badge from '../../ui/Badge';
import { formatAngka, formatTimestamp } from '../../../lib/format';
import { Play, RotateCcw, Lock, RefreshCw, AlertTriangle, AlertCircle } from 'lucide-react';

export default function TransformasiTab({
  periodeId,
  stageData = {},
  cleaningState = 'TERKUNCI',
  siswaCount = 0,
  onSuccess,
  refetchPipeline,
  setToast,
}) {
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [runError, setRunError] = useState(null);
  const [resetBannerDismissed, setResetBannerDismissed] = useState(false);

  const isCleaningCompleted = cleaningState === 'SELESAI';
  const isTransformCompleted = stageData?.state === 'SELESAI';
  const isResetState = stageData?.state === 'RESET';

  const {
    data: configData,
    isLoading: isConfigLoading,
    isError: isConfigError,
    refetch: refetchConfig,
  } = useTransformConfig(periodeId, { enabled: isCleaningCompleted });

  const createOptMut = useCreateTransformOption();
  const deleteOptMut = useDeleteTransformOption();
  const saveAssignMut = useSaveTransformAssignments();
  const runTransMut = useRunTransform();

  const handleCreateOption = ({ fieldName, name, code }) =>
    createOptMut.mutateAsync({ periodeId, fieldName, name, code });

  const handleDeleteOption = async (id) => {
    try {
      await deleteOptMut.mutateAsync({ id, periodeId });
      setToast?.({ open: true, message: 'Bidang berhasil dihapus.', tone: 'success' });
    } catch (err) {
      setToast?.({ open: true, message: err.response?.data?.message || 'Gagal menghapus bidang.', tone: 'danger' });
    }
  };

  const handleSaveAssignments = async ({ fieldName, optionId, standardValues }) => {
    try {
      await saveAssignMut.mutateAsync({ periodeId, fieldName, optionId, standardValues });
      setToast?.({ open: true, message: 'Nilai berhasil dipetakan.', tone: 'success' });
    } catch (err) {
      setToast?.({ open: true, message: err.response?.data?.message || 'Gagal memetakan nilai.', tone: 'danger' });
    }
  };

  const executeRunTransform = async () => {
    setRunError(null);
    try {
      await runTransMut.mutateAsync(periodeId);
      setToast?.({ open: true, message: 'Transformasi Data berhasil dijalankan.', tone: 'success' });
      refetchPipeline?.();
      onSuccess?.();
    } catch (err) {
      setRunError(err.response?.data?.message || err.message || 'Gagal menjalankan transformasi data.');
    }
  };

  if (!isCleaningCompleted) {
    return (
      <div className="pt-6 space-y-6">
        <div>
          <h2 className="text-base font-semibold text-ink">Transformasi Data</h2>
          <p className="mt-1 text-sm text-muted">Mengubah nilai non-akademik menjadi skala numerik dan melakukan normalisasi Min-Max.</p>
        </div>
        <InfoBanner>Jalankan Cleaning Data terlebih dahulu pada tab sebelumnya.</InfoBanner>
        <div className="flex flex-col items-center justify-center rounded-lg border border-dashed border-line bg-page p-12 text-center">
          <div className="mb-3 flex size-10 items-center justify-center rounded-full bg-brand-tint text-brand"><Lock size={20} /></div>
          <h3 className="text-sm font-semibold text-ink">Tahap Transformasi Data Terkunci</h3>
          <p className="mt-1 max-w-sm text-xs text-muted">Fitur pemetaan bidang dan normalisasi baru dapat diakses setelah Cleaning Data selesai.</p>
        </div>
      </div>
    );
  }

  if (isConfigLoading) {
    return (
      <div className="flex h-64 items-center justify-center pt-6 p-6">
        <div className="flex items-center gap-2 text-sm text-muted">
          <div className="size-4 animate-spin rounded-full border-2 border-brand border-t-transparent" />
          <span>Memuat konfigurasi transformasi data...</span>
        </div>
      </div>
    );
  }

  if (isConfigError) {
    return (
      <div className="space-y-4 pt-6">
        <InfoBanner>Gagal memuat konfigurasi transformasi data dari server.</InfoBanner>
        <Button variant="outline" onClick={refetchConfig}>Coba Lagi</Button>
      </div>
    );
  }

  const fields = configData?.fields ?? [];
  const totalUnmappedCount = fields.reduce((sum, f) => sum + (f.unmapped ?? []).length, 0);
  const isUnmappedEmpty = totalUnmappedCount === 0;
  const durationText = stageData?.durationMs != null ? (stageData.durationMs >= 1000 ? `${(stageData.durationMs / 1000).toFixed(2)} s` : `${stageData.durationMs} ms`) : '-';

  return (
    <div className="pt-6 space-y-8">
      {isResetState && !resetBannerDismissed && (
        <div className="flex items-start gap-3 rounded-lg border border-warning/40 bg-warning-tint p-4">
          <AlertTriangle size={18} className="mt-0.5 shrink-0 text-warning" />
          <div className="min-w-0 flex-1">
            <div className="flex items-center gap-2">
              <p className="text-sm font-semibold text-ink">Hasil Preprocessing Ter-reset</p>
              <Badge tone="warning">Reset</Badge>
            </div>
            <p className="mt-1 text-xs text-muted">Data cleaning diubah setelah transformasi ini pernah dijalankan. Jalankan ulang Transformasi Data untuk menyelaraskan data hilir.</p>
          </div>
          <button type="button" onClick={() => setResetBannerDismissed(true)} className="text-xs text-muted hover:text-ink font-semibold">Tutup</button>
        </div>
      )}

      <div>
        <h2 className="text-base font-semibold text-ink">Transformasi Data</h2>
        <p className="mt-1 text-sm text-muted">Mengubah nilai non-akademik menjadi skala numerik dan melakukan normalisasi Min-Max.</p>
      </div>

      {isTransformCompleted && (
        <div className="grid grid-cols-2 gap-4 rounded-lg border border-line bg-page p-4 sm:grid-cols-4">
          <div><p className="text-xs text-muted">Baris Diproses</p><p className="mt-1 font-mono text-sm font-semibold text-ink">{formatAngka(siswaCount)} baris</p></div>
          <div><p className="text-xs text-muted">Durasi</p><p className="mt-1 font-mono text-sm font-semibold text-ink">{durationText}</p></div>
          <div><p className="text-xs text-muted">Dijalankan Oleh</p><p className="mt-1 text-sm font-semibold text-ink">{stageData?.adminUsername || '-'}</p></div>
          <div><p className="text-xs text-muted">Waktu</p><p className="mt-1 font-mono text-sm font-semibold text-ink">{formatTimestamp(stageData?.executedAt)}</p></div>
        </div>
      )}

      {isResetState && (
        <div className="flex flex-col items-center justify-center rounded-lg border border-dashed border-warning/50 bg-warning-tint/10 p-8 text-center">
          <div className="mb-3 flex size-10 items-center justify-center rounded-full bg-warning-tint text-warning"><RefreshCw size={20} /></div>
          <h3 className="text-sm font-semibold text-ink">Hasil transformasi di-reset</h3>
          <p className="mt-1 max-w-md text-xs text-muted">Perubahan pada tahap cleaning telah membatalkan hasil transformasi dan reduksi sebelumnya. Silakan periksa kembali kamus bidang di bawah lalu jalankan ulang transformasi.</p>
        </div>
      )}

      {isUnmappedEmpty && (
        <div className="flex items-center gap-3 rounded-lg border border-success/30 bg-success-tint px-4 py-3 text-success">
          <p className="text-sm font-semibold text-success">Semua nilai periode ini sudah terpetakan.</p>
        </div>
      )}

      {!isUnmappedEmpty && (
        <UnmappedBanner
          fields={fields}
          onCreateOption={handleCreateOption}
          onSaveAssignments={handleSaveAssignments}
          isSubmitting={createOptMut.isPending || saveAssignMut.isPending}
        />
      )}

      <div className="space-y-4 pt-2">
        <div>
          <h3 className="text-base font-semibold text-ink">Tahap 1 &mdash; Kamus Bidang Non-Akademik</h3>
          <p className="mt-1 text-sm text-muted">Kode ditetapkan saat bidang dibuat dan tidak dapat diubah setelah disimpan. Hapus bidang untuk memetakan ulang nilainya.</p>
        </div>
        <BidangAccordion fields={fields} onDeleteOption={handleDeleteOption} isDeleting={deleteOptMut.isPending} />
      </div>

      <NormalisasiInfo />

      {runError && (
        <div className="flex items-start gap-3 rounded-lg border border-danger/30 bg-danger-tint px-4 py-3 text-danger">
          <AlertCircle size={16} className="mt-0.5 shrink-0 text-danger" />
          <p className="text-sm font-medium">{runError}</p>
        </div>
      )}

      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between border-t border-line pt-4 gap-3">
        <p className="text-xs text-muted">{!isUnmappedEmpty ? 'Petakan semua nilai baru untuk melanjutkan.' : 'Siap menjalankan proses transformasi dan normalisasi.'}</p>
        <Button variant="solid" type="button" onClick={() => (isTransformCompleted ? setConfirmOpen(true) : executeRunTransform())} disabled={!isUnmappedEmpty || runTransMut.isPending} className="min-w-55">
          {runTransMut.isPending ? 'Memproses...' : isTransformCompleted ? <div className="flex items-center gap-2"><RotateCcw size={16} /><span>Jalankan Ulang Transformasi</span></div> : <div className="flex items-center gap-2"><Play size={16} /><span>Jalankan Transformasi Data</span></div>}
        </Button>
      </div>

      <Dialog open={confirmOpen} onClose={() => setConfirmOpen(false)} labelledBy="dialog-rerun-transform-title">
        <div className="space-y-4">
          <div className="flex items-center gap-3">
            <div className="flex size-10 items-center justify-center rounded-full bg-warning-tint text-warning"><AlertTriangle size={20} /></div>
            <h3 id="dialog-rerun-transform-title" className="text-base font-semibold text-ink">Jalankan Ulang Transformasi Data?</h3>
          </div>
          <p className="text-sm text-muted">Mengulang transformasi akan mereset hasil Reduksi Data jika sudah dijalankan.</p>
          <div className="flex justify-end gap-3 pt-2">
            <Button variant="outline" onClick={() => setConfirmOpen(false)} disabled={runTransMut.isPending}>Batal</Button>
            <Button variant="solid" onClick={async () => { setConfirmOpen(false); await executeRunTransform(); }} disabled={runTransMut.isPending}>{runTransMut.isPending ? <div className="flex items-center gap-2"><div className="size-4 animate-spin rounded-full border-2 border-on-brand border-t-transparent" /><span>Memproses...</span></div> : 'Jalankan Ulang'}</Button>
          </div>
        </div>
      </Dialog>
    </div>
  );
}
