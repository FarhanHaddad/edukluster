import { useState, useEffect } from 'react';
import useDashboardSummary from '../hooks/useDashboardSummary';
import { usePreprocessingStatus, useRunIntegration } from '../hooks/usePreprocessing';
import PageHeader from '../components/domain/PageHeader';
import PeriodChip from '../components/domain/PeriodChip';
import Card from '../components/ui/Card';
import InfoBanner from '../components/domain/InfoBanner';
import Button from '../components/ui/Button';
import PreprocessingTabBar from '../components/domain/preprocessing/PreprocessingTabBar';
import IntegrasiTab from '../components/domain/preprocessing/IntegrasiTab';
import CleaningTab from '../components/domain/preprocessing/CleaningTab';
import TransformasiTab from '../components/domain/preprocessing/TransformasiTab';
import ReduksiTab from '../components/domain/preprocessing/ReduksiTab';
import PreprocessingEmptyState from '../components/domain/preprocessing/PreprocessingEmptyState';
import Toast from '../components/domain/siswa/Toast';

function getDefaultTab(stages) {
  if (!stages) return 'integrasi';
  const order = ['integrasi', 'cleaning', 'transformasi', 'reduksi'];
  for (const key of order) {
    const st = stages[key]?.state;
    if (st === 'MENUNGGU' || st === 'RESET') {
      return key;
    }
  }
  const allSelesai = order.every((key) => stages[key]?.state === 'SELESAI');
  if (allSelesai) return 'reduksi';
  return 'integrasi';
}

export default function PreprocessingPage() {
  const { data: summary } = useDashboardSummary();
  const activePeriode = summary?.periodeAktif ?? null;
  const periodeNama = activePeriode?.namaPeriode ?? '2025/2026 Ganjil';

  const {
    data: pipelineStatus,
    isLoading,
    isError,
    refetch,
  } = usePreprocessingStatus(activePeriode?.id);

  const runMutation = useRunIntegration();

  const [activeTab, setActiveTab] = useState('integrasi');
  const [hasManuallySelectedTab, setHasManuallySelectedTab] = useState(false);
  const [toast, setToast] = useState({ open: false, message: '', title: '', description: '', tone: 'success' });

  const stages = pipelineStatus?.run?.stages ?? {
    integrasi: { state: 'MENUNGGU' },
    cleaning: { state: 'TERKUNCI' },
    transformasi: { state: 'TERKUNCI' },
    reduksi: { state: 'TERKUNCI' },
  };

  useEffect(() => {
    if (!hasManuallySelectedTab && pipelineStatus) {
      setActiveTab(getDefaultTab(stages));
    }
  }, [pipelineStatus, hasManuallySelectedTab]);

  const handleSelectTab = (tabId) => {
    setHasManuallySelectedTab(true);
    setActiveTab(tabId);
  };

  const handleRunIntegration = async () => {
    try {
      await runMutation.mutateAsync(activePeriode?.id);
      setToast({
        open: true,
        message: 'Integrasi Data berhasil dijalankan.',
        title: '',
        description: '',
        tone: 'success',
      });
      refetch();
    } catch (err) {
      const msg = err.response?.data?.message || 'Gagal menjalankan integrasi data.';
      setToast({
        open: true,
        message: msg,
        title: '',
        description: '',
        tone: 'danger',
      });
    }
  };

  const siswaCount = pipelineStatus?.siswaCount ?? 0;
  const isEmptyData = !isLoading && !isError && pipelineStatus && siswaCount === 0;

  return (
    <div className="mx-auto max-w-6xl space-y-6">
      <PageHeader
        title="Preprocessing"
        description="Jalankan pipeline preprocessing berurutan: Integrasi Data, Cleaning Data, Transformasi Data, Reduksi Data."
        periodChip={<PeriodChip namaPeriode={periodeNama} />}
      />

      {isLoading ? (
        <Card className="flex h-64 items-center justify-center p-6">
          <div className="flex items-center gap-2 text-sm text-muted">
            <div className="size-4 animate-spin rounded-full border-2 border-brand border-t-transparent" />
            <span>Memuat status pipeline preprocessing...</span>
          </div>
        </Card>
      ) : isError ? (
        <Card className="space-y-4 p-6">
          <InfoBanner>
            Gagal mengambil status pipeline preprocessing dari server.
          </InfoBanner>
          <div className="flex justify-start">
            <Button variant="outline" onClick={refetch}>
              Coba Lagi
            </Button>
          </div>
        </Card>
      ) : isEmptyData ? (
        <PreprocessingEmptyState />
      ) : (
        <Card className="p-6">
          <PreprocessingTabBar
            activeTab={activeTab}
            onSelectTab={handleSelectTab}
            stages={stages}
          />

          {activeTab === 'integrasi' ? (
            <IntegrasiTab
              periodeId={activePeriode?.id}
              stageData={stages.integrasi}
              siswaCount={siswaCount}
              onRunIntegration={handleRunIntegration}
              isRunning={runMutation.isPending}
            />
          ) : activeTab === 'cleaning' ? (
            <CleaningTab
              periodeId={activePeriode?.id}
              stageData={stages.cleaning}
              integrasiState={stages.integrasi?.state}
              siswaCount={siswaCount}
              onSuccess={() => handleSelectTab('transformasi')}
              refetchPipeline={refetch}
              setToast={setToast}
            />
          ) : activeTab === 'transformasi' ? (
            <TransformasiTab
              periodeId={activePeriode?.id}
              stageData={stages.transformasi}
              cleaningState={stages.cleaning?.state}
              siswaCount={siswaCount}
              onSuccess={() => handleSelectTab('reduksi')}
              refetchPipeline={refetch}
              setToast={setToast}
            />
          ) : activeTab === 'reduksi' ? (
            <ReduksiTab
              periodeId={activePeriode?.id}
              stageData={stages.reduksi}
              transformasiState={stages.transformasi?.state}
              siswaCount={siswaCount}
              refetchPipeline={refetch}
              setToast={setToast}
            />
          ) : null}
        </Card>
      )}

      <Toast
        open={toast.open}
        message={toast.message}
        title={toast.title}
        description={toast.description}
        tone={toast.tone}
        onClose={() => setToast((prev) => ({ ...prev, open: false }))}
      />
    </div>
  );
}
