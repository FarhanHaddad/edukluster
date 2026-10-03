import { Link } from 'react-router-dom';
import {
  Database,
  CircleSlash2,
  Play,
  Layers,
  Upload,
  SlidersHorizontal,
  Brain,
  FileDown,
  ChartScatter,
  CircleDot,
  CalendarPlus,
  Users,
  FolderSearch,
  FileSpreadsheet,
} from 'lucide-react';
import useDashboardSummary from '../hooks/useDashboardSummary';
import PageHeader from '../components/domain/PageHeader';
import PeriodChip from '../components/domain/PeriodChip';
import StatCard from '../components/domain/StatCard';
import EmptyState from '../components/domain/EmptyState';
import StepCard from '../components/domain/StepCard';
import RunCard from '../components/domain/RunCard';
import Card from '../components/ui/Card';
import Button from '../components/ui/Button';
import { formatAngka } from '../lib/format';

// Fallback ikon utk versi lucide tanpa nama baru.
const ClusterIcon = ChartScatter ?? CircleDot;

// Peta status run BE -> nilai kartu (mono-friendly) + caption badge (DESIGN.md).
const PREPROC_MAP = {
  BELUM_ADA: { value: '0', caption: 'Belum Dimulai', tone: 'neutral' },
  MENUNGGU: { value: '—', caption: 'Menunggu', tone: 'neutral' },
  BERJALAN: { value: '—', caption: 'Sedang Berjalan', tone: 'info' },
  SELESAI: { value: '✓', caption: 'Selesai', tone: 'success' },
  SUKSES: { value: '✓', caption: 'Selesai', tone: 'success' },
  GAGAL: { value: '✕', caption: 'Gagal', tone: 'danger' },
};

const KMEANS_MAP = {
  BELUM_ADA: { value: '0', caption: 'Belum Dijalankan', tone: 'neutral' },
  MENUNGGU: { value: '—', caption: 'Menunggu', tone: 'neutral' },
  BERJALAN: { value: '—', caption: 'Sedang Berjalan', tone: 'info' },
  SELESAI: { value: '✓', caption: 'Selesai', tone: 'success' },
  SUKSES: { value: '✓', caption: 'Selesai', tone: 'success' },
  GAGAL: { value: '✕', caption: 'Gagal', tone: 'danger' },
};

function mapStatus(map, status) {
  return map[status] ?? { value: '—', caption: String(status ?? '-'), tone: 'neutral' };
}

// Quick action (State B): tombol 40px dalam baris grid, gap 12px (8pt grid).
function QuickAction({ to, icon: Icon, label, variant = 'outline' }) {
  return (
    <Link to={to} className="min-w-0">
      <Button variant={variant} className="w-full">
        <Icon size={16} shrink-0 aria-hidden="true" />
        <span className="truncate">{label}</span>
      </Button>
    </Link>
  );
}

// Screen 2 Dashboard — HANYA komposisi; semua blok hidup di components/domain & ui.
export default function DashboardPage() {
  const { data: summary, isLoading } = useDashboardSummary();

  const periodeAktif = summary?.periodeAktif ?? null;
  const totalSiswa = summary?.totalSiswa ?? 0;
  const recentRuns = summary?.recentRuns ?? [];

  const preproc = mapStatus(PREPROC_MAP, summary?.preprocessingStatus ?? 'BELUM_ADA');
  const kmeans = mapStatus(KMEANS_MAP, summary?.kmeansStatus ?? 'BELUM_ADA');

  // CTA kosong: ada periode aktif -> tambah data; belum -> buat periode dulu.
  const emptyCta = periodeAktif
    ? { label: 'Tambah Data Siswa', to: '/siswa', icon: Users }
    : { label: 'Buat Periode Pertama', to: '/periode', icon: CalendarPlus };

  // Caption kartu Total Siswa mengikuti konteks periode (kontrak frame State A/C).
  const totalCaption = periodeAktif ? 'Belum ada data diunggah' : 'Belum Ada Periode Aktif';

  // Heading/deskripsi EmptyState mengikuti state frame:
  // A (belum ada periode) vs C (periode aktif tapi data kosong).
  const emptyCopy = periodeAktif
    ? {
        title: 'Belum Ada Data Periode Berjalan',
        description:
          'Periode aktif sudah dibuat. Unggah data nilai siswa untuk memulai pipeline klasterisasi.',
      }
    : {
        title: 'Belum Ada Data Periode Berjalan',
        description:
          'Buat periode aktif terlebih dahulu, lalu unggah data nilai siswa untuk menjalankan pipeline klasterisasi.',
      };

  return (
    <div className="mx-auto max-w-6xl space-y-6">
      <PageHeader
        title="Dashboard"
        active={Boolean(periodeAktif)}
        description="Ringkasan analisis klasterisasi siswa dan rekomendasi jurusan."
        periodChip={<PeriodChip namaPeriode={periodeAktif?.namaPeriode} />}
      />

      {/* ROW 2: empat kartu metrik */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">
        <StatCard
          label="Total Siswa"
          value={isLoading ? '—' : formatAngka(totalSiswa)}
          caption={totalSiswa === 0 ? totalCaption : undefined}
          tone="neutral"
          icon={Database}
        />
        <StatCard
          label="Status Preprocessing"
          value={isLoading ? '—' : preproc.value}
          caption={preproc.caption}
          tone={preproc.tone}
          icon={CircleSlash2}
        />
        <StatCard
          label="Status K-Means"
          value={isLoading ? '—' : kmeans.value}
          caption={kmeans.caption}
          tone={kmeans.tone}
          icon={Play}
        />
        <StatCard
          label="Jumlah Cluster"
          value={isLoading ? '—' : formatAngka(summary?.jumlahCluster ?? 0)}
          caption={`${formatAngka(summary?.jumlahCluster ?? 0)} Klaster`}
          tone="neutral"
          icon={Layers}
        />
      </div>

      {totalSiswa === 0 ? (
        /* STATE A/C: belum ada data pada periode berjalan */
        <>
          <EmptyState
            icon={Upload}
            title="Belum Ada Data Periode Berjalan"
            description="Mulai dengan membuat periode aktif lalu unggah data nilai siswa untuk menjalankan pipeline klasterisasi."
            ctaLabel={emptyCta.label}
            ctaTo={emptyCta.to}
            linkLabel="Pelajari Alur Kerja Klasterisasi"
            linkTo="/periode"
          >
            <div className="grid grid-cols-1 gap-3 sm:grid-cols-3">
              <StepCard
                step="01"
                title="Siapkan Periode & Data Siswa"
                description="Buat periode aktif lalu unggah nilai rapor, PTS, dan PAS seluruh siswa."
              />
              <StepCard
                step="02"
                title="Jalankan Preprocessing"
                description="Integrasi, cleaning, transformasi, dan reduksi data siap untuk diklaster."
              />
              <StepCard
                step="03"
                title="Eksekusi K-Means"
                description="Kelompokkan siswa, tinjau profil klaster, dan dapatkan rekomendasi jurusan."
              />
            </div>
          </EmptyState>

          {/* Banner panduan template (tombol dirender; wiring unduh = Sprint 3) */}
          <Card className="flex flex-wrap items-center justify-between gap-3">
            <div className="flex min-w-0 items-center gap-3">
              <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-brand-tint">
                <FileSpreadsheet size={18} className="text-brand" aria-hidden="true" />
              </div>
              <div className="min-w-0">
                <p className="text-sm font-semibold leading-5 text-ink">
                  Panduan Penyiapan Template Data Siswa
                </p>
                <p className="text-xs leading-4 text-muted">
                  Gunakan template resmi agar kolom data sesuai kontrak sistem.
                </p>
              </div>
            </div>
            <Button variant="outline" type="button">
              Unduh Template CSV / Excel
            </Button>
          </Card>
        </>
      ) : (
        /* STATE B: sudah ada data siswa pada periode aktif */
        <>
          <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 xl:grid-cols-4">
            <QuickAction to="/siswa" icon={Upload} label="Tambah Data Siswa" />
            <QuickAction
              to="/preprocessing"
              icon={SlidersHorizontal}
              label="Jalankan Preprocessing"
            />
            <QuickAction to="/kmeans" icon={Brain} label="Eksekusi K-Means" variant="emphasis" />
            <QuickAction to="/laporan" icon={FileDown} label="Unduh Laporan PDF" />
          </div>

          <div className="grid grid-cols-1 gap-6 lg:grid-cols-3">
            {/* Grafik distribusi — ECharts SKIP (Sprint 5); placeholder catatan saja */}
            <Card className="lg:col-span-2">
              <div className="flex items-center gap-2">
                <ClusterIcon size={16} className="shrink-0 text-faint" aria-hidden="true" />
                <h2 className="text-sm font-semibold leading-5 text-ink">
                  Distribusi Klaster Siswa (C1 - C10)
                </h2>
              </div>
              <div className="flex min-h-48 items-center justify-center py-8">
                <p className="max-w-xs text-center text-sm leading-5 text-muted">
                  Distribusi klaster muncul setelah K-Means dijalankan.
                </p>
              </div>
            </Card>

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
        </>
      )}
    </div>
  );
}
