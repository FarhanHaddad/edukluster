import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Play, Loader2, ArrowRight, BarChart2 } from 'lucide-react';
import useDashboardSummary from '../../hooks/useDashboardSummary';
import { usePreprocessingStatus } from '../../hooks/usePreprocessing';
import { useLatestKMeansRun, useRunKMeans } from '../../hooks/useKMeans';
import PageHeader from '../../components/domain/PageHeader';
import PeriodChip from '../../components/domain/PeriodChip';
import Card from '../../components/ui/Card';
import Button from '../../components/ui/Button';
import InfoBanner from '../../components/domain/InfoBanner';
import EmptyState from '../../components/domain/EmptyState';
import Toast from '../../components/domain/siswa/Toast';
import StatCards from './components/StatCards';
import ChartTabs from './components/ChartTabs';
import FilterSortToolbar from './components/FilterSortToolbar';
import BarColumns from './components/charts/BarColumns';
import ScatterBubble from './components/charts/ScatterBubble';
import ParallelCoords from './components/charts/ParallelCoords';
import ResultTable from './components/ResultTable';
import IterationHistory from './components/IterationHistory';
import DbiEvaluation from './components/DbiEvaluation';

export default function KMeansPage() {
  const navigate = useNavigate();
  const { data: summary } = useDashboardSummary();
  const activePeriode = summary?.periodeAktif ?? null;
  const periodeId = activePeriode?.id;
  const periodeNama = activePeriode?.namaPeriode ?? '2025/2026 Ganjil';

  const {
    data: pipelineStatus,
    isLoading: isPipelineLoading,
    isError: isPipelineError,
    refetch: refetchPipeline,
  } = usePreprocessingStatus(periodeId);

  const {
    data: runData,
    isLoading: isRunLoading,
    isError: isRunError,
    error: runError,
    refetch: refetchRun,
  } = useLatestKMeansRun(periodeId, { enabled: Boolean(periodeId) });

  const runKMeansMutation = useRunKMeans();

  const [runActionError, setRunActionError] = useState('');
  const [activeTab, setActiveTab] = useState('distribution');

  // Lifted state for Filter & Sort
  const [filterCluster, setFilterCluster] = useState('all');
  const [sortBy, setSortBy] = useState('nis');

  // Lifted state for Scatter Sumbu X & Y to persist across tab navigation
  const [axisX, setAxisX] = useState('mtk_wajib');
  const [axisY, setAxisY] = useState('kemampuan');

  const [toast, setToast] = useState({
    open: false,
    message: '',
    title: '',
    description: '',
    tone: 'success',
  });

  const handleRunKMeans = async () => {
    if (!periodeId || runKMeansMutation.isPending) return;
    setRunActionError('');
    try {
      await runKMeansMutation.mutateAsync(periodeId);
      setToast({
        open: true,
        message: '',
        title: 'K-Means berhasil dijalankan.',
        description: 'Data siswa periode ini terkunci (ubah & hapus).',
        tone: 'success',
      });
    } catch (err) {
      const msg = err.response?.data?.message || 'Gagal menjalankan K-Means.';
      if (err.response?.status === 409) {
        setToast({
          open: true,
          message: '',
          title: msg,
          description: '',
          tone: 'danger',
        });
      } else {
        setRunActionError(msg);
      }
    }
  };

  const reduksiStage = pipelineStatus?.run?.stages?.reduksi;
  const isReduksiSelesai = reduksiStage?.state === 'SELESAI';
  const isRunExecuted = Boolean(runData && runData.status === 'COMPLETED');

  const isLoading = isPipelineLoading || (isRunLoading && Boolean(periodeId));
  const isError = isPipelineError || isRunError;

  return (
    <div className="mx-auto max-w-6xl space-y-6">
      <PageHeader
        title="K-Means & Visualisasi"
        description="Pengelompokan data siswa menggunakan algoritma K-Means dan visualisasi hasil klasterisasi."
        periodChip={<PeriodChip namaPeriode={periodeNama} />}
      />

      {isLoading ? (
        <Card className="flex h-64 items-center justify-center p-6">
          <div className="flex items-center gap-2 text-sm text-muted">
            <Loader2 className="size-4 animate-spin text-brand" />
            <span>Memuat data K-Means...</span>
          </div>
        </Card>
      ) : isError ? (
        <Card className="space-y-4 p-6">
          <InfoBanner tone="danger">
            {runError?.response?.data?.message || 'Gagal mengambil data K-Means dari server.'}
          </InfoBanner>
          <div className="flex justify-start">
            <Button
              variant="outline"
              onClick={() => {
                refetchPipeline();
                refetchRun();
              }}
            >
              Coba Lagi
            </Button>
          </div>
        </Card>
      ) : !isReduksiSelesai ? (
        <Card className="p-6">
          <EmptyState
            title="Tahap Reduksi Belum Selesai"
            description="Jalankan pipeline preprocessing hingga tahap Reduksi Data selesai sebelum menjalankan K-Means."
            action={
              <Button variant="primary" onClick={() => navigate('/preprocessing')}>
                <span>Buka Preprocessing</span>
                <ArrowRight className="size-4" />
              </Button>
            }
          />
        </Card>
      ) : (
        <div className="space-y-6">
          <StatCards runData={runData} isRunExecuted={isRunExecuted} />

          <Card className="p-6 space-y-4">
            {isRunExecuted && activeTab !== 'iterations' && activeTab !== 'dbi' && (
              <FilterSortToolbar
                filterCluster={filterCluster}
                onFilterChange={setFilterCluster}
                sortBy={sortBy}
                onSortChange={setSortBy}
              />
            )}

            <ChartTabs
              activeTab={activeTab}
              onSelectTab={setActiveTab}
              isRunExecuted={isRunExecuted}
            >
              {!isRunExecuted ? (
                <div className="space-y-6">
                  {runActionError ? (
                    <InfoBanner tone="danger">{runActionError}</InfoBanner>
                  ) : null}

                  <div className="py-12 flex flex-col items-center justify-center text-center">
                    <div className="mb-4 flex size-12 items-center justify-center rounded-full bg-brand-tint text-brand">
                      <BarChart2 className="size-6 text-brand" />
                    </div>
                    <h3 className="text-base font-semibold text-main">Belum ada hasil clustering</h3>
                    <p className="mt-1 text-sm text-muted">Jalankan K-Means untuk melihat visualisasi.</p>
                  </div>

                  <div className="border-t border-line pt-4 flex justify-end">
                    <Button
                      variant="primary"
                      onClick={handleRunKMeans}
                      disabled={runKMeansMutation.isPending || isLoading}
                    >
                      {runKMeansMutation.isPending ? (
                        <>
                          <Loader2 className="size-4 animate-spin" />
                          <span>Memproses...</span>
                        </>
                      ) : (
                        <>
                          <Play className="size-4" />
                          <span>Jalankan K-Means</span>
                        </>
                      )}
                    </Button>
                  </div>
                </div>
              ) : activeTab === 'distribution' ? (
                <div className="space-y-8">
                  <BarColumns
                    distribution={runData?.distribution || []}
                    filterCluster={filterCluster}
                  />
                  <ResultTable
                    assignments={runData?.assignments || []}
                    filterCluster={filterCluster}
                    sortBy={sortBy}
                  />
                </div>
              ) : activeTab === 'scatter' ? (
                <ScatterBubble
                  assignments={runData?.assignments || []}
                  filterCluster={filterCluster}
                  axisX={axisX}
                  onAxisXChange={setAxisX}
                  axisY={axisY}
                  onAxisYChange={setAxisY}
                />
              ) : activeTab === 'parallel' ? (
                <ParallelCoords
                  assignments={runData?.assignments || []}
                  filterCluster={filterCluster}
                />
              ) : activeTab === 'iterations' ? (
                <IterationHistory runData={runData} periodeId={periodeId} />
              ) : (
                <DbiEvaluation runData={runData} />
              )}
            </ChartTabs>
          </Card>
        </div>
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
