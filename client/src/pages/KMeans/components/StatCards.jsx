import Card from '../../../components/ui/Card';
import Badge from '../../../components/ui/Badge';

export default function StatCards({ runData, isRunExecuted }) {
  const kValue = isRunExecuted ? (runData?.summary?.k ?? 10) : 10;
  const iterationsValue = isRunExecuted ? (runData?.totalIterations ?? '-') : '-';
  const dbiValue = isRunExecuted
    ? (typeof runData?.dbiScore === 'number' ? runData.dbiScore.toFixed(3) : (runData?.dbiScore ?? '-'))
    : '-';

  const isConverged = runData?.converged ?? false;
  const convergedAt = runData?.convergedAt ?? null;

  let statusLabel = 'Belum dijalankan';
  let badgeTone = 'secondary'; // muted / gray style

  if (isRunExecuted) {
    if (runData?.status === 'FAILED') {
      statusLabel = 'Gagal';
      badgeTone = 'danger';
    } else if (isConverged) {
      statusLabel = 'Konvergen';
      badgeTone = 'success';
    } else {
      statusLabel = 'Tidak Konvergen';
      badgeTone = 'warning';
    }
  }

  return (
    <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
      <Card className="p-5">
        <p className="text-xs font-semibold uppercase tracking-wider text-muted">
          Jumlah Cluster (K)
        </p>
        <div className="mt-2 flex items-baseline justify-between">
          <span className="text-2xl font-bold text-main">{kValue}</span>
          <span className="text-xs text-muted">Centroid Terpilih</span>
        </div>
      </Card>

      <Card className="p-5">
        <p className="text-xs font-semibold uppercase tracking-wider text-muted">
          Total Iterasi
        </p>
        <div className="mt-2 flex items-baseline justify-between">
          <span className="text-2xl font-bold text-main">{iterationsValue}</span>
          <span className="text-xs text-muted">Tahap Komputasi</span>
        </div>
      </Card>

      <Card className="p-5">
        <p className="text-xs font-semibold uppercase tracking-wider text-muted">
          Davies-Bouldin Index
        </p>
        <div className="mt-2 flex items-baseline justify-between">
          <span className="text-2xl font-bold text-main">{dbiValue}</span>
          <span className="text-xs text-muted">Skor Validitas</span>
        </div>
      </Card>

      <Card className="p-5">
        <p className="text-xs font-semibold uppercase tracking-wider text-muted">
          Status Konvergensi
        </p>
        <div className="mt-2 flex items-center justify-between">
          <Badge tone={badgeTone}>{statusLabel}</Badge>
          <span className="text-xs text-muted">
            {isRunExecuted && convergedAt ? `Pada iterasi ${convergedAt}` : 'Proses K-Means'}
          </span>
        </div>
      </Card>
    </div>
  );
}
