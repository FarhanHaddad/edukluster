import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Play, Loader2, ArrowRight } from 'lucide-react';
import useDashboardSummary from '../../hooks/useDashboardSummary';
import { usePreprocessingStatus } from '../../hooks/usePreprocessing';
import { getLatestKMeansRun, runKMeans } from '../../api/kmeans';
import PageHeader from '../../components/domain/PageHeader';
import PeriodChip from '../../components/domain/PeriodChip';
import Card from '../../components/ui/Card';
import Button from '../../components/ui/Button';
import InfoBanner from '../../components/domain/InfoBanner';
import EmptyState from '../../components/domain/EmptyState';
import Toast from '../../components/domain/siswa/Toast';
import StatCards from './components/StatCards';
import ChartTabs from './components/ChartTabs';

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

  const [runData, setRunData] = useState(null);
  const [isRunLoading, setIsRunLoading] = useState(true);
  const [isRunError, setIsRunError] = useState(false);
  const [errorMessage, setErrorMessage] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [activeTab, setActiveTab] = useState('distribution');

  const [toast, setToast] = useState({
    open: false,
    message: '',
    title: '',
    description: '',
    tone: 'success',
  });

  const fetchLatestRun = async () => {
    if (!periodeId) return;
    setIsRunLoading(true);
    setIsRunError(false);
    try {
      const data = await getLatestKMeansRun(periodeId);
      setRunData(data);
    } catch (err) {
      if (err.response?.status === 404) {
        setRunData(null);
      } else {
        setIsRunError(true);
        setErrorMessage(
          err.response?.data?.message || 'Gagal mengambil data K-Means dari server.'
        );
      }
    } finally {
      setIsRunLoading(false);
    }
  };

  useEffect(() => {
    if (periodeId) {
      fetchLatestRun();
    } else {
      setIsRunLoading(false);
    }
  }, [periodeId]);

  const handleRunKMeans = async () => {
    if (!periodeId || isSubmitting) return;
    setIsSubmitting(true);
    try {
      await runKMeans(periodeId);
      setToast({
        open: true,
        message: 'K-Means berhasil dijalankan.',
        title: '',
        description: 'Data siswa periode ini terkunci (ubah & hapus).',
        tone: 'success',
      });
      await fetchLatestRun();
      await refetchPipeline();
    } catch (err) {
      const msg = err.response?.data?.message || 'Gagal menjalankan K-Means.';
      setToast({
        open: true,
        message: msg,
        title: '',
        description: '',
        tone: 'danger',
      });
    } finally {
      setIsSubmitting(false);
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
        description="Pengelompokan data siswa menggunakan algoritma K-Means dan visualisasi hasil klusterisasi."
        periodChip={<PeriodChip namaPeriode={periodeNama} />}
        action={
          isReduksiSelesai ? (
            <Button
              variant="primary"
              onClick={handleRunKMeans}
              disabled={isSubmitting || isLoading}
            >
              {isSubmitting ? (
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
          ) : null
        }
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
            {errorMessage || 'Gagal mengambil data dari server.'}
          </InfoBanner>
          <div className="flex justify-start">
            <Button
              variant="outline"
              onClick={() => {
                refetchPipeline();
                fetchLatestRun();
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

          <Card className="p-6">
            <ChartTabs
              activeTab={activeTab}
              onSelectTab={setActiveTab}
              isRunExecuted={isRunExecuted}
            >
              {!isRunExecuted ? (
                <EmptyState
                  title="K-Means Belum Dijalankan"
                  description="Klik tombol &quot;Jalankan K-Means&quot; di sudut kanan atas untuk mengelompokkan data siswa periode ini."
                />
              ) : (
                <div className="flex h-80 items-center justify-center rounded-lg border border-dashed border-line bg-page text-sm text-muted">
                  Konten Tab {activeTab} (F2-F5)
                </div>
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
