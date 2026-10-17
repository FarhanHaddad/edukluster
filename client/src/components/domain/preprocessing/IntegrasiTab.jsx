import { useState } from 'react';
import Button from '../../ui/Button';
import Dialog from '../../ui/Dialog';
import SourcePreviewTable from './SourcePreviewTable';
import { useSourcePreview } from '../../../hooks/usePreprocessing';
import { formatAngka, formatTimestamp } from '../../../lib/format';
import { cn } from '../../../lib/utils';
import { Play, RotateCcw, AlertTriangle } from 'lucide-react';

const SUB_TABS = [
  { id: 'rapor', label: 'RAPOR' },
  { id: 'pts', label: 'PTS' },
  { id: 'pas', label: 'PAS' },
  { id: 'non_akademik', label: 'NON-AKADEMIK' },
];

export default function IntegrasiTab({
  periodeId,
  stageData = {},
  siswaCount = 0,
  onRunIntegration,
  isRunning = false,
}) {
  const [previewJenis, setPreviewJenis] = useState('rapor');
  const [page, setPage] = useState(1);
  const [confirmOpen, setConfirmOpen] = useState(false);

  const {
    data: previewData,
    isLoading: isPreviewLoading,
    isError: isPreviewError,
    refetch: refetchPreview,
  } = useSourcePreview({
    jenis: previewJenis,
    limit: 1000,
    periodeId,
  });

  const handleSubTabChange = (id) => {
    setPreviewJenis(id);
    setPage(1);
  };

  const handleCtaClick = () => {
    if (stageData?.state === 'SELESAI') {
      setConfirmOpen(true);
    } else {
      onRunIntegration?.();
    }
  };

  const handleConfirmReRun = async () => {
    setConfirmOpen(false);
    onRunIntegration?.();
  };

  const isCompleted = stageData?.state === 'SELESAI';
  const durationText =
    stageData?.durationMs != null
      ? stageData.durationMs >= 1000
        ? `${(stageData.durationMs / 1000).toFixed(2)} s`
        : `${stageData.durationMs} ms`
      : '-';

  return (
    <div className="flex flex-col pt-6 space-y-6">
      {/* Active Stage Header */}
      <div>
        <h2 className="text-base font-semibold leading-6 text-ink">Integrasi Data</h2>
        <p className="mt-1 text-sm text-muted">
          Menghitung rata-rata Rapor, PTS, PAS dan menggabungkan data non-akademik per siswa pada periode aktif.
        </p>
      </div>

      {/* Summary Run-Meta Block (saat SELESAI) */}
      {isCompleted && (
        <div className="grid grid-cols-2 gap-4 rounded-lg border border-line bg-page p-4 sm:grid-cols-4">
          <div>
            <p className="text-xs text-muted">Baris Diproses</p>
            <p className="mt-1 font-mono text-sm font-semibold text-ink">
              {formatAngka(siswaCount)} baris
            </p>
          </div>
          <div>
            <p className="text-xs text-muted">Durasi</p>
            <p className="mt-1 font-mono text-sm font-semibold text-ink">
              {durationText}
            </p>
          </div>
          <div>
            <p className="text-xs text-muted">Dijalankan Oleh</p>
            <p className="mt-1 text-sm font-semibold text-ink">
              {stageData?.adminUsername || '-'}
            </p>
          </div>
          <div>
            <p className="text-xs text-muted">Waktu</p>
            <p className="mt-1 font-mono text-sm font-semibold text-ink">
              {formatTimestamp(stageData?.executedAt)}
            </p>
          </div>
        </div>
      )}

      {/* Section Pratinjau Data Sumber */}
      <div className="space-y-4">
        <h3 className="text-sm font-semibold text-ink">Pratinjau Data Sumber</h3>

        {/* Sub-tab Navigation */}
        <div className="flex border-b border-line gap-6 text-sm">
          {SUB_TABS.map((sub) => {
            const isActive = previewJenis === sub.id;
            return (
              <button
                key={sub.id}
                type="button"
                onClick={() => handleSubTabChange(sub.id)}
                className={cn(
                  'pb-2 font-medium transition-colors border-b-2 -mb-px outline-none',
                  isActive
                    ? 'border-brand text-brand font-semibold'
                    : 'border-transparent text-muted hover:text-ink'
                )}
              >
                {sub.label}
              </button>
            );
          })}
        </div>

        {/* Preview Table */}
        <SourcePreviewTable
          jenis={previewJenis}
          rows={previewData?.rows ?? []}
          isLoading={isPreviewLoading}
          isError={isPreviewError}
          onRetry={refetchPreview}
          page={page}
          onPageChange={(p) => setPage(p)}
        />
      </div>

      {/* Footer CTA */}
      <div className="flex justify-end border-t border-line pt-4">
        <Button
          variant="solid"
          onClick={handleCtaClick}
          disabled={isRunning}
          className="min-w-45"
        >
          {isRunning ? (
            <div className="flex items-center gap-2">
              <div className="size-4 animate-spin rounded-full border-2 border-on-brand border-t-transparent" />
              <span>Memproses...</span>
            </div>
          ) : isCompleted ? (
            <div className="flex items-center gap-2">
              <RotateCcw size={16} />
              <span>Jalankan Ulang Integrasi</span>
            </div>
          ) : (
            <div className="flex items-center gap-2">
              <Play size={16} />
              <span>Jalankan Integrasi Data</span>
            </div>
          )}
        </Button>
      </div>

      {/* Confirmation Dialog for Re-run */}
      <Dialog
        open={confirmOpen}
        onClose={() => setConfirmOpen(false)}
        labelledBy="dialog-rerun-title"
      >
        <div className="space-y-4">
          <div className="flex items-center gap-3">
            <div className="flex size-10 items-center justify-center rounded-full bg-warning-tint text-warning">
              <AlertTriangle size={20} aria-hidden="true" />
            </div>
            <h3 id="dialog-rerun-title" className="text-base font-semibold text-ink">
              Jalankan Ulang Integrasi Data?
            </h3>
          </div>

          <p className="text-sm text-muted">
            Mengulang integrasi akan mereset Cleaning, Transformasi, dan Reduksi.
          </p>

          <div className="flex justify-end gap-3 pt-2">
            <Button
              variant="outline"
              onClick={() => setConfirmOpen(false)}
              disabled={isRunning}
            >
              Batal
            </Button>
            <Button
              variant="solid"
              onClick={handleConfirmReRun}
              disabled={isRunning}
            >
              {isRunning ? 'Memproses...' : 'Jalankan Ulang'}
            </Button>
          </div>
        </div>
      </Dialog>
    </div>
  );
}
