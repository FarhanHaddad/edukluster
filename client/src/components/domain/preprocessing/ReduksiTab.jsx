import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useReductionSummary, useRunReduction } from '../../../hooks/usePreprocessing';
import InfoBanner from '../InfoBanner';
import Button from '../../ui/Button';
import Dialog from '../../ui/Dialog';
import { formatAngka, formatWaktu } from '../../../lib/format';
import { Play, RotateCcw, Lock, AlertTriangle, ArrowRight } from 'lucide-react';

export default function ReduksiTab({
  periodeId,
  stageData = {},
  transformasiState = 'TERKUNCI',
  siswaCount = 0,
  refetchPipeline,
  setToast,
}) {
  const navigate = useNavigate();
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [runError, setRunError] = useState(null);

  const isTransformCompleted = transformasiState === 'SELESAI';
  const isCompleted = stageData?.state === 'SELESAI';

  const {
    data: summaryData,
    isLoading: isSummaryLoading,
    isError: isSummaryError,
    refetch: refetchSummary,
  } = useReductionSummary(periodeId, {
    enabled: isTransformCompleted && isCompleted,
  });

  const runReductionMut = useRunReduction();

  const executeRunReduction = async () => {
    setRunError(null);
    try {
      await runReductionMut.mutateAsync(periodeId);
      setToast?.({
        open: true,
        title: 'Preprocessing berhasil disimpan.',
        description:
          'Data siswa periode ini akan terkunci (tidak dapat diubah atau dihapus) setelah K-Means dijalankan.',
        tone: 'success',
      });
      refetchPipeline?.();
      refetchSummary?.();
    } catch (err) {
      setRunError(
        err.response?.data?.message || err.message || 'Gagal menjalankan reduksi data.'
      );
    }
  };

  const handleConfirmReRun = async () => {
    setConfirmOpen(false);
    await executeRunReduction();
  };

  if (!isTransformCompleted) {
    return (
      <div className="pt-6 space-y-6">
        <div>
          <h2 className="text-base font-semibold text-ink">Reduksi Data</h2>
          <p className="mt-1 text-sm text-muted">
            Memilih dan membobot atribut relevan untuk mempersiapkan dataset analisis K-Means.
          </p>
        </div>
        <InfoBanner>
          Jalankan Transformasi Data terlebih dahulu pada tab sebelumnya.
        </InfoBanner>
        <div className="flex flex-col items-center justify-center rounded-lg border border-dashed border-line bg-page p-12 text-center">
          <div className="mb-3 flex size-10 items-center justify-center rounded-full bg-brand-tint text-brand">
            <Lock size={20} aria-hidden="true" />
          </div>
          <h3 className="text-sm font-semibold text-ink">
            Tahap Reduksi Data Terkunci
          </h3>
          <p className="mt-1 max-w-sm text-xs text-muted">
            Konfigurasi dan eksekusi untuk Reduksi Data akan tersedia setelah Transformasi Data selesai.
          </p>
        </div>
      </div>
    );
  }

  const durationText =
    summaryData?.durasiMs != null
      ? summaryData.durasiMs >= 1000
        ? `${(summaryData.durasiMs / 1000).toFixed(2)}s`
        : `${summaryData.durasiMs}ms`
      : stageData?.durationMs != null
      ? stageData.durationMs >= 1000
        ? `${(stageData.durationMs / 1000).toFixed(2)}s`
        : `${stageData.durationMs}ms`
      : '-';

  const barisProcessed = summaryData?.barisDiproses ?? siswaCount;
  const kolomDropped = Array.isArray(summaryData?.kolomDibuang)
    ? summaryData.kolomDibuang.join(', ')
    : summaryData?.kolomDibuang || 'Nama, Kelas, Jenis Kelamin';
  const fiturFinalText = summaryData?.fiturFinal || '25 numerik + NIS (meta)';
  const adminUser = summaryData?.adminUsername || stageData?.adminUsername || '-';
  const timeFormatted = formatWaktu(summaryData?.waktu || stageData?.executedAt);

  return (
    <div className="pt-6 space-y-6">
      <div>
        <h2 className="text-base font-semibold text-ink">Reduksi Data</h2>
        <p className="mt-1 text-sm text-muted">
          Memilih dan membobot atribut relevan untuk mempersiapkan dataset analisis K-Means.
        </p>
      </div>

      {runError && (
        <div className="space-y-3">
          <InfoBanner>{runError}</InfoBanner>
          <div className="flex justify-start">
            <Button
              variant="outline"
              type="button"
              onClick={executeRunReduction}
              disabled={runReductionMut.isPending}
            >
              Coba Lagi
            </Button>
          </div>
        </div>
      )}

      {isSummaryLoading && isCompleted && (
        <div className="flex h-32 items-center justify-center p-6">
          <div className="flex items-center gap-2 text-sm text-muted">
            <div className="size-4 animate-spin rounded-full border-2 border-brand border-t-transparent" />
            <span>Memuat ringkasan reduksi...</span>
          </div>
        </div>
      )}

      {isSummaryError && isCompleted && (
        <div className="space-y-3">
          <InfoBanner>Gagal memuat ringkasan reduksi data.</InfoBanner>
          <div className="flex justify-start">
            <Button variant="outline" type="button" onClick={refetchSummary}>
              Coba Lagi
            </Button>
          </div>
        </div>
      )}

      {isCompleted && summaryData && (
        <div className="space-y-3">
          <p className="text-xs text-muted">
            Atribut identitas dibuang; NIS dipertahankan sebagai meta.
          </p>
          <div className="divide-y divide-line rounded-lg border border-line bg-page overflow-hidden">
            <div className="flex items-center justify-between px-4 py-3 text-sm">
              <span className="text-muted">Baris diproses</span>
              <span className="font-mono font-semibold text-ink">
                {formatAngka(barisProcessed)}
              </span>
            </div>
            <div className="flex items-center justify-between px-4 py-3 text-sm">
              <span className="text-muted">Kolom dibuang</span>
              <span className="font-medium text-ink">{kolomDropped}</span>
            </div>
            <div className="flex items-center justify-between px-4 py-3 text-sm">
              <span className="text-muted">Fitur final</span>
              <span className="font-medium text-ink">{fiturFinalText}</span>
            </div>
            <div className="flex items-center justify-between px-4 py-3 text-sm">
              <span className="text-muted">Durasi</span>
              <span className="font-mono font-semibold text-ink">{durationText}</span>
            </div>
            <div className="flex items-center justify-between px-4 py-3 text-sm">
              <span className="text-muted">Dijalankan oleh</span>
              <span className="font-medium text-ink">{adminUser}</span>
            </div>
            <div className="flex items-center justify-between px-4 py-3 text-sm">
              <span className="text-muted">Waktu</span>
              <span className="font-mono font-semibold text-ink">{timeFormatted}</span>
            </div>
          </div>
        </div>
      )}

      {/* Action Footer */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-end border-t border-line pt-4 gap-3">
        {isCompleted ? (
          <>
            <Button
              variant="outline"
              type="button"
              onClick={() => setConfirmOpen(true)}
              disabled={runReductionMut.isPending}
            >
              <div className="flex items-center gap-2">
                <RotateCcw size={16} aria-hidden="true" />
                <span>Jalankan Ulang Reduksi</span>
              </div>
            </Button>
            <Button
              variant="solid"
              type="button"
              onClick={() => navigate('/kmeans')}
            >
              <div className="flex items-center gap-2">
                <span>Lanjut ke K-Means & Visualisasi</span>
                <ArrowRight size={16} aria-hidden="true" />
              </div>
            </Button>
          </>
        ) : (
          <Button
            variant="solid"
            type="button"
            onClick={executeRunReduction}
            disabled={runReductionMut.isPending}
            className="min-w-50"
          >
            {runReductionMut.isPending ? (
              <div className="flex items-center gap-2">
                <div className="size-4 animate-spin rounded-full border-2 border-on-brand border-t-transparent" />
                <span>Memproses...</span>
              </div>
            ) : (
              <div className="flex items-center gap-2">
                <Play size={16} aria-hidden="true" />
                <span>Jalankan Reduksi Data</span>
              </div>
            )}
          </Button>
        )}
      </div>

      {/* Confirmation Dialog for Re-running Reduksi */}
      <Dialog
        open={confirmOpen}
        onClose={() => setConfirmOpen(false)}
        labelledBy="dialog-rerun-reduksi-title"
      >
        <div className="space-y-4">
          <div className="flex items-center gap-3">
            <div className="flex size-10 items-center justify-center rounded-full bg-warning-tint text-warning">
              <AlertTriangle size={20} aria-hidden="true" />
            </div>
            <h3 id="dialog-rerun-reduksi-title" className="text-base font-semibold text-ink">
              Jalankan Ulang Reduksi Data?
            </h3>
          </div>
          <p className="text-sm text-muted">
            Mengulang reduksi akan memproses ulang dataset hasil transformasi.
          </p>
          <div className="flex justify-end gap-3 pt-2">
            <Button
              variant="outline"
              onClick={() => setConfirmOpen(false)}
              disabled={runReductionMut.isPending}
            >
              Batal
            </Button>
            <Button
              variant="solid"
              onClick={handleConfirmReRun}
              disabled={runReductionMut.isPending}
            >
              {runReductionMut.isPending ? (
                <div className="flex items-center gap-2">
                  <div className="size-4 animate-spin rounded-full border-2 border-on-brand border-t-transparent" />
                  <span>Memproses...</span>
                </div>
              ) : (
                'Jalankan Ulang'
              )}
            </Button>
          </div>
        </div>
      </Dialog>
    </div>
  );
}
