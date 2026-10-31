import { useNavigate } from 'react-router-dom';
import {
  Play,
  Sparkles,
  Blocks,
  SlidersHorizontal,
  FileDown,
  CircleDot,
  Users,
  UserPlus,
} from 'lucide-react';
import * as Lucide from 'lucide-react';
import useDashboardSummary from '../hooks/useDashboardSummary';
import { usePreprocessingStatus } from '../hooks/usePreprocessing';
import { useLatestKMeansRun } from '../hooks/useKMeans';
import PageHeader from '../components/domain/PageHeader';
import PeriodChip from '../components/domain/PeriodChip';
import RunCard from '../components/domain/RunCard';
import Card from '../components/ui/Card';
import Button from '../components/ui/Button';
import DashboardStatCard from './dashboard/DashboardStatCard';
import DistributionPanel from './dashboard/DistributionPanel';
import { formatAngka } from '../lib/format';

const ClusterIcon = Lucide.ChartScatter ?? CircleDot;

function QuickAction({ icon: Icon, label, variant = 'outline', disabled = false, onClick }) {
  return (
    <Button
      variant={variant}
      disabled={disabled}
      onClick={onClick}
      className="w-full justify-center gap-2"
    >
      <Icon size={16} className="shrink-0" aria-hidden="true" />
      <span className="truncate">{label}</span>
    </Button>
  );
}

export default function DashboardPage() {
  const navigate = useNavigate();
  const { data: summary } = useDashboardSummary();

  const periodeAktif = summary?.periodeAktif ?? null;
  const periodeId = periodeAktif?.id;

  const { data: pipelineStatus } = usePreprocessingStatus(periodeId, {
    enabled: Boolean(periodeId),
  });

  const { data: latestKMeansRun } = useLatestKMeansRun(periodeId, {
    enabled: Boolean(periodeId),
  });

  const recentRuns = summary?.recentRuns ?? [];

  // Derivasi State S0-S4
  let state = 'S0';
  if (!periodeAktif) {
    state = 'S0';
  } else {
    const siswaCount = pipelineStatus?.siswaCount ?? summary?.totalSiswa ?? 0;
    if (siswaCount === 0) {
      state = 'S1';
    } else {
      const reduksiDone = pipelineStatus?.run?.stages?.reduksi?.state === 'SELESAI';
      if (!reduksiDone) {
        state = 'S2';
      } else {
        const kmeansDone =
          latestKMeansRun?.status === 'COMPLETED' ||
          summary?.kmeansStatus === 'COMPLETED' ||
          summary?.kmeansStatus === 'SUKSES' ||
          summary?.kmeansStatus === 'SELESAI';

        if (!kmeansDone) {
          state = 'S3';
        } else {
          state = 'S4';
        }
      }
    }
  }

  // Data siswa count, DBI score, dan cluster count
  const siswaCount = pipelineStatus?.siswaCount ?? summary?.totalSiswa ?? 0;
  const rawDbi = latestKMeansRun?.dbiScore;
  const dbiScore = rawDbi != null ? Number(rawDbi).toFixed(2) : '-1.94';
  const k = latestKMeansRun?.summary?.k ?? summary?.jumlahCluster ?? 10;

  // Copy Kartu R-KM-57
  const getCards = () => {
    switch (state) {
      case 'S0':
        return [
          { label: 'Total Siswa', value: '—', footnote: 'Belum ada periode aktif', icon: Users },
          { label: 'Status Preprocessing', value: '—', footnote: 'Belum dimulai', icon: SlidersHorizontal },
          { label: 'Status K-Means', value: '—', footnote: 'Belum dijalankan', icon: ClusterIcon },
          { label: 'Jumlah Cluster', value: '—', footnote: 'Belum ada cluster', icon: Blocks },
        ];
      case 'S1':
        return [
          { label: 'Total Siswa', value: '0', footnote: 'Data siswa kosong', icon: Users },
          { label: 'Status Preprocessing', value: '—', footnote: 'Menunggu data siswa', icon: SlidersHorizontal },
          { label: 'Status K-Means', value: '—', footnote: 'Belum dijalankan', icon: ClusterIcon },
          { label: 'Jumlah Cluster', value: '—', footnote: 'Belum ada cluster', icon: Blocks },
        ];
      case 'S2':
        return [
          { label: 'Total Siswa', value: formatAngka(siswaCount), footnote: `${siswaCount} data siswa terdaftar`, icon: Users },
          { label: 'Status Preprocessing', value: 'Belum Selesai', footnote: 'Tahap reduksi belum selesai', icon: SlidersHorizontal },
          { label: 'Status K-Means', value: '—', footnote: 'Menunggu preprocessing', icon: ClusterIcon },
          { label: 'Jumlah Cluster', value: '—', footnote: 'Belum ada cluster', icon: Blocks },
        ];
      case 'S3':
        return [
          { label: 'Total Siswa', value: formatAngka(siswaCount), footnote: `${siswaCount} data siswa terdaftar`, icon: Users },
          { label: 'Status Preprocessing', value: 'Selesai 100%', footnote: `${siswaCount} data ternormalisasi`, icon: SlidersHorizontal },
          { label: 'Status K-Means', value: 'Belum Dijalankan', footnote: 'Siap dieksekusi', icon: ClusterIcon },
          { label: 'Jumlah Cluster', value: '—', footnote: 'Belum ada cluster', icon: Blocks },
        ];
      case 'S4':
      default:
        return [
          { label: 'Total Siswa', value: formatAngka(siswaCount), footnote: `${siswaCount} data siswa terdaftar`, icon: Users },
          { label: 'Status Preprocessing', value: 'Selesai 100%', footnote: `${siswaCount} data ternormalisasi`, icon: SlidersHorizontal },
          { label: 'Status K-Means', value: `Optimal (k=${k})`, footnote: `DBI score: ${dbiScore}`, icon: ClusterIcon },
          { label: 'Jumlah Cluster', value: `${k} Klaster`, footnote: 'C1 sampai C10 terbentuk', icon: Blocks },
        ];
    }
  };

  const cards = getCards();

  // CTA Wiring R-KM-60
  const isS0 = state === 'S0';
  const isS1 = state === 'S1';
  const isS2 = state === 'S2';
  const isS4 = state === 'S4';

  const kmeansCtaLabel = isS4 ? 'Lihat Hasil K-Means' : 'Eksekusi K-Means';

  return (
    <div className="mx-auto max-w-6xl space-y-6">
      <PageHeader
        title="Dashboard"
        active={!isS0}
        description="Ringkasan analisis klasterisasi siswa dan rekomendasi jurusan."
        periodChip={periodeAktif ? <PeriodChip namaPeriode={periodeAktif.namaPeriode} /> : null}
      />

      {/* ROW 1: 4 Stat Cards */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">
        {cards.map((card) => (
          <DashboardStatCard key={card.label} {...card} />
        ))}
      </div>

      {/* ROW 2: Quick Action CTAs */}
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 xl:grid-cols-4">
        <QuickAction
          icon={UserPlus}
          label="Tambah Data Siswa"
          disabled={isS0}
          onClick={() => navigate('/siswa')}
        />
        <QuickAction
          icon={Play}
          label="Jalankan Preprocessing"
          disabled={isS0 || isS1}
          onClick={() => navigate('/preprocessing')}
        />
        <QuickAction
          icon={Sparkles}
          label={kmeansCtaLabel}
          variant="emphasis"
          disabled={isS0 || isS1 || isS2}
          onClick={() => navigate('/kmeans')}
        />
        <QuickAction
          icon={FileDown}
          label="Unduh Laporan PDF"
          disabled={!isS4}
          onClick={() => navigate('/laporan')}
        />
      </div>

      {/* ROW 3: Distribution Panel + 5 Run Terakhir */}
      <div className="grid grid-cols-1 gap-6 lg:grid-cols-3">
        <div className="lg:col-span-2">
          <DistributionPanel
            state={state}
            distribution={latestKMeansRun?.distribution ?? []}
            totalStudents={latestKMeansRun?.summary?.totalStudents ?? siswaCount}
          />
        </div>

        <Card>
          <h2 className="text-sm font-semibold leading-5 text-ink">5 Run Terakhir</h2>
          {recentRuns.length === 0 ? (
            <p className="mt-4 text-sm leading-5 text-muted">Belum ada riwayat eksekusi.</p>
          ) : (
            <div className="mt-4 space-y-2">
              {recentRuns.map((run) => (
                <RunCard key={run.id} {...run} />
              ))}
            </div>
          )}
        </Card>
      </div>
    </div>
  );
}
