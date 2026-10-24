import { useState, useEffect } from 'react';
import { useForm } from 'react-hook-form';
import Button from '../../ui/Button';
import Dialog from '../../ui/Dialog';
import InfoBanner from '../InfoBanner';
import ImputationForm from './ImputationForm';
import CategoryMappingCard from './CategoryMappingCard';
import { useCleaningConfig, useRunCleaning } from '../../../hooks/usePreprocessing';
import { formatAngka, formatTimestamp } from '../../../lib/format';
import { Play, RotateCcw, Lock, AlertTriangle, AlertCircle } from 'lucide-react';

export default function CleaningTab({
  periodeId,
  stageData = {},
  integrasiState = 'MENUNGGU',
  siswaCount = 0,
  onSuccess,
  refetchPipeline,
  setToast,
}) {
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [submitError, setSubmitError] = useState(null);

  const isIntegrasiCompleted = integrasiState === 'SELESAI';
  const isCleaningCompleted = stageData?.state === 'SELESAI';

  const {
    data: configData,
    isLoading: isConfigLoading,
    isError: isConfigError,
    refetch: refetchConfig,
  } = useCleaningConfig(periodeId, {
    enabled: isIntegrasiCompleted,
  });

  const runCleaningMutation = useRunCleaning();

  const {
    register,
    handleSubmit,
    watch,
    reset,
    formState: { errors },
  } = useForm({
    defaultValues: {
      imputationMethod: 'mean',
      mappings: {},
    },
  });

  useEffect(() => {
    if (configData) {
      const initialMappings = {};
      if (Array.isArray(configData.fields)) {
        configData.fields.forEach((f) => {
          if (!f.fieldName) return;
          initialMappings[f.fieldName] = {};
          if (Array.isArray(f.mappings)) {
            f.mappings.forEach((m) => {
              if (m.rawValue != null) {
                initialMappings[f.fieldName][m.rawValue] = m.standardValue ?? m.rawValue;
              }
            });
          }
        });
      }
      reset({
        imputationMethod: configData.imputationMethod || 'mean',
        mappings: initialMappings,
      });
    }
  }, [configData, reset]);

  const onSubmitForm = async (formData) => {
    setSubmitError(null);
    try {
      await runCleaningMutation.mutateAsync({
        periodeId,
        imputationMethod: formData.imputationMethod,
        mappings: formData.mappings,
      });

      setToast?.({
        open: true,
        message: 'Konfigurasi cleaning disimpan & dijalankan.',
        tone: 'success',
      });

      refetchPipeline?.();
      onSuccess?.();
    } catch (err) {
      const msg = err.response?.data?.message || 'Gagal menyimpan dan menjalankan cleaning data.';
      setSubmitError(msg);
    }
  };

  const handleCtaClick = () => {
    if (isCleaningCompleted) {
      setConfirmOpen(true);
    } else {
      handleSubmit(onSubmitForm)();
    }
  };

  const handleConfirmReRun = async () => {
    setConfirmOpen(false);
    handleSubmit(onSubmitForm)();
  };

  // Condition A: Integrasi belum SELESAI
  if (!isIntegrasiCompleted) {
    return (
      <div className="pt-6 space-y-6">
        <div>
          <h2 className="text-base font-semibold leading-6 text-ink">Cleaning Data</h2>
          <p className="mt-1 text-sm text-muted">
            Pilih metode imputasi untuk nilai kosong dan petakan penulisan kategori yang berbeda.
          </p>
        </div>

        <InfoBanner>
          Jalankan Integrasi Data terlebih dahulu pada tab sebelumnya.
        </InfoBanner>

        <div className="flex flex-col items-center justify-center rounded-lg border border-dashed border-line bg-page p-12 text-center">
          <div className="mb-3 flex size-10 items-center justify-center rounded-full bg-brand-tint text-brand">
            <Lock size={20} aria-hidden="true" />
          </div>
          <h3 className="text-sm font-semibold text-ink">Tahap Cleaning Data Terkunci</h3>
          <p className="mt-1 max-w-sm text-xs text-muted">
            Fitur konfigurasi cleaning baru dapat diakses setelah tahap Integrasi Data selesai dijalankan.
          </p>
        </div>
      </div>
    );
  }

  // Condition B: Config loading / error state
  if (isConfigLoading) {
    return (
      <div className="flex h-64 items-center justify-center pt-6 p-6">
        <div className="flex items-center gap-2 text-sm text-muted">
          <div className="size-4 animate-spin rounded-full border-2 border-brand border-t-transparent" />
          <span>Memuat konfigurasi cleaning data...</span>
        </div>
      </div>
    );
  }

  if (isConfigError) {
    return (
      <div className="space-y-4 pt-6">
        <InfoBanner>
          Gagal memuat konfigurasi cleaning data dari server.
        </InfoBanner>
        <div className="flex justify-start">
          <Button variant="outline" onClick={refetchConfig}>
            Coba Lagi
          </Button>
        </div>
      </div>
    );
  }

  const durationText =
    stageData?.durationMs != null
      ? stageData.durationMs >= 1000
        ? `${(stageData.durationMs / 1000).toFixed(2)} s`
        : `${stageData.durationMs} ms`
      : '-';

  const fields = configData?.fields ?? [];
  const academicMissing = configData?.academicMissing ?? [];

  return (
    <form onSubmit={handleSubmit(onSubmitForm)} className="flex flex-col pt-6 space-y-8">
      {/* Active Stage Header */}
      <div>
        <h2 className="text-base font-semibold leading-6 text-ink">Cleaning Data</h2>
        <p className="mt-1 text-sm text-muted">
          Pilih metode imputasi untuk nilai kosong dan petakan penulisan kategori yang berbeda.
        </p>
      </div>

      {/* Summary Run-Meta Block (saat SELESAI) */}
      {isCleaningCompleted && (
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

      {/* Section 1: Imputasi Missing Values (Akademik) */}
      <ImputationForm
        academicMissing={academicMissing}
        register={register}
        watch={watch}
        errors={errors}
      />

      {/* Section 2: Standardisasi Kategori (Mapping L1) */}
      <div className="space-y-4 pt-4 border-t border-line">
        <div>
          <h3 className="text-base font-semibold text-ink">
            Standardisasi Kategori (Mapping L1)
          </h3>
          <p className="mt-1 text-sm text-muted">
            Standardisasi teks untuk 7 field non-akademik agar penulisan kategori sejenis menjadi konsisten.
          </p>
        </div>

        <div className="space-y-4">
          {fields.map((fieldItem) => (
            <CategoryMappingCard
              key={fieldItem.fieldName}
              fieldData={fieldItem}
              register={register}
              errors={errors}
            />
          ))}
        </div>
      </div>

      {/* Submission Error Banner */}
      {submitError && (
        <div className="flex items-start gap-3 rounded-lg border border-danger/30 bg-danger-tint px-4 py-3 text-danger">
          <AlertCircle size={16} className="mt-0.5 shrink-0 text-danger" aria-hidden="true" />
          <p className="text-sm leading-5 font-medium">{submitError}</p>
        </div>
      )}

      {/* Footer CTA */}
      <div className="flex justify-end border-t border-line pt-4">
        <Button
          variant="solid"
          type="button"
          onClick={handleCtaClick}
          disabled={runCleaningMutation.isPending}
          className="min-w-50"
        >
          {runCleaningMutation.isPending ? (
            <div className="flex items-center gap-2">
              <div className="size-4 animate-spin rounded-full border-2 border-on-brand border-t-transparent" />
              <span>Memproses...</span>
            </div>
          ) : isCleaningCompleted ? (
            <div className="flex items-center gap-2">
              <RotateCcw size={16} />
              <span>Jalankan Ulang Cleaning</span>
            </div>
          ) : (
            <div className="flex items-center gap-2">
              <Play size={16} />
              <span>Simpan Konfigurasi &amp; Lanjut</span>
            </div>
          )}
        </Button>
      </div>

      {/* Dialog Konfirmasi Re-run */}
      <Dialog
        open={confirmOpen}
        onClose={() => setConfirmOpen(false)}
        labelledBy="dialog-rerun-cleaning-title"
      >
        <div className="space-y-4">
          <div className="flex items-center gap-3">
            <div className="flex size-10 items-center justify-center rounded-full bg-warning-tint text-warning">
              <AlertTriangle size={20} aria-hidden="true" />
            </div>
            <h3 id="dialog-rerun-cleaning-title" className="text-base font-semibold text-ink">
              Jalankan Ulang Cleaning Data?
            </h3>
          </div>

          <p className="text-sm text-muted">
            Mengulang cleaning akan mereset Transformasi dan Reduksi.
          </p>

          <div className="flex justify-end gap-3 pt-2">
            <Button
              variant="outline"
              onClick={() => setConfirmOpen(false)}
              disabled={runCleaningMutation.isPending}
            >
              Batal
            </Button>
            <Button
              variant="solid"
              onClick={handleConfirmReRun}
              disabled={runCleaningMutation.isPending}
            >
              {runCleaningMutation.isPending ? 'Memproses...' : 'Jalankan Ulang'}
            </Button>
          </div>
        </div>
      </Dialog>
    </form>
  );
}
