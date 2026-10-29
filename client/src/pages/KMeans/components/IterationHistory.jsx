import { useState } from 'react';
import { ChevronDown, ChevronUp, Loader2, CheckCircle, Info } from 'lucide-react';
import { FEATURE_OPTIONS, KMEANS_PALETTE } from '../../../constants/kmeans';
import { getKMeansCentroids } from '../../../api/kmeans';
import Badge from '../../../components/ui/Badge';

export default function IterationHistory({ runData, periodeId }) {
  const {
    converged = false,
    convergedAt = 0,
    totalIterations = 0,
    dbiScore = '0.0000',
    summary = {},
    iterations = [],
  } = runData || {};

  const totalStudents = summary.totalStudents ?? 0;
  const k = summary.k ?? 10;

  // Default expanded iterasi 1 (index 1 if exists) & iterasi terakhir (convergedAt)
  const [openAccordions, setOpenAccordions] = useState(() => {
    const initial = {};
    if (iterations.length > 1) initial[1] = true;
    if (iterations.length > 0) initial[convergedAt] = true;
    return initial;
  });

  const [openCentroids, setOpenCentroids] = useState({});
  const [centroidData, setCentroidData] = useState({});
  const [loadingCentroids, setLoadingCentroids] = useState({});

  const toggleAccordion = (num) => {
    setOpenAccordions((prev) => ({ ...prev, [num]: !prev[num] }));
  };

  const toggleCentroidCollapsible = async (num) => {
    const isCurrentlyOpen = !!openCentroids[num];
    setOpenCentroids((prev) => ({ ...prev, [num]: !isCurrentlyOpen }));

    if (!isCurrentlyOpen && !centroidData[num] && !loadingCentroids[num]) {
      setLoadingCentroids((prev) => ({ ...prev, [num]: true }));
      try {
        const res = await getKMeansCentroids(periodeId, num);
        setCentroidData((prev) => ({ ...prev, [num]: res.centroids || [] }));
      } catch (err) {
        // handle error silently
      } finally {
        setLoadingCentroids((prev) => ({ ...prev, [num]: false }));
      }
    }
  };

  return (
    <div className="space-y-6">
      {/* Header Info */}
      <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h3 className="text-base font-semibold text-main">Riwayat Iterasi K-Means</h3>
          <p className="text-sm text-muted">
            {totalIterations} iterasi • konvergen pada iterasi {convergedAt}
          </p>
        </div>
        <div className="inline-flex items-center rounded-md border border-line bg-page px-3 py-1.5 text-xs font-mono font-medium text-main shadow-xs">
          Total Dataset: {totalStudents} Siswa • 25 Fitur
        </div>
      </div>

      {/* Banner Hijau jika Converged */}
      {converged && (
        <div className="flex items-start gap-3 rounded-lg border border-emerald-500/20 bg-emerald-500/10 p-4 text-emerald-700">
          <CheckCircle className="size-5 shrink-0 text-emerald-600 mt-0.5" />
          <div className="text-sm leading-relaxed">
            <span className="font-medium">
              K-Means berhasil konvergen pada iterasi ke-{convergedAt}.
            </span>{' '}
            Tidak ada siswa yang berpindah cluster. Nilai Davies-Bouldin Index (DBI):{' '}
            <span className="font-semibold">{dbiScore}</span>.
          </div>
        </div>
      )}

      {/* List Accordion Iterasi */}
      <div className="space-y-3">
        {iterations.map((iter) => {
          const num = iter.number;
          const moves = iter.moves ?? 0;
          const movers = iter.movers || [];
          const isOpen = !!openAccordions[num];
          const isCentroidOpen = !!openCentroids[num];
          const isIterConverged = iter.isConverged;

          let badgeVariant = 'muted';
          let badgeLabel = 'Proses';
          if (num === 0) {
            badgeVariant = 'brand';
            badgeLabel = 'Inisialisasi';
          } else if (isIterConverged) {
            badgeVariant = 'success';
            badgeLabel = 'Konvergen';
          }

          const sisaMovers = moves > movers.length ? moves - movers.length : Math.max(0, moves - 5);
          const displayedMovers = movers.slice(0, 5);

          return (
            <div
              key={num}
              className="rounded-lg border border-line bg-card transition-colors overflow-hidden"
            >
              {/* Accordion Header */}
              <button
                type="button"
                onClick={() => toggleAccordion(num)}
                className="flex w-full items-center justify-between p-4 text-left hover:bg-page/50 transition-colors"
              >
                <div className="flex items-center gap-3">
                  <span className="text-sm font-semibold text-main">Iterasi {num}</span>
                  <Badge variant={badgeVariant}>{badgeLabel}</Badge>
                  <span className="rounded bg-page px-2 py-0.5 text-xs font-mono text-muted border border-line">
                    perpindahan: {moves} siswa
                  </span>
                </div>
                {isOpen ? (
                  <ChevronUp className="size-4 text-muted" />
                ) : (
                  <ChevronDown className="size-4 text-muted" />
                )}
              </button>

              {/* Accordion Body */}
              {isOpen && (
                <div className="border-t border-line p-4 space-y-4 bg-page/30">
                  {/* Tabel 4 Langkah (Derivasi G4) */}
                  <div className="rounded-md border border-line bg-card overflow-hidden text-xs">
                    <div className="bg-page px-3 py-2 font-medium text-main border-b border-line">
                      Langkah Komputasi Iterasi {num}
                    </div>
                    <div className="divide-y divide-line">
                      <div className="grid grid-cols-12 px-3 py-2">
                        <span className="col-span-4 font-medium text-muted">1. Hitung Jarak</span>
                        <span className="col-span-8 text-main font-mono">
                          {totalStudents} × {k} jarak dihitung
                        </span>
                      </div>
                      <div className="grid grid-cols-12 px-3 py-2">
                        <span className="col-span-4 font-medium text-muted">2. Re-assign Cluster</span>
                        <span className="col-span-8 text-main font-mono">
                          perpindahan: {moves} siswa
                        </span>
                      </div>
                      <div className="grid grid-cols-12 px-3 py-2">
                        <span className="col-span-4 font-medium text-muted">3. Update Centroid</span>
                        <span className="col-span-8 text-main font-mono">
                          {num < convergedAt ? `${k} centroid baru` : 'centroid tetap'}
                        </span>
                      </div>
                      <div className="grid grid-cols-12 px-3 py-2">
                        <span className="col-span-4 font-medium text-muted">4. Cek Konvergensi</span>
                        <span className="col-span-8 text-main font-mono">
                          {isIterConverged || moves === 0
                            ? 'Konvergen? Ya → proses berhenti'
                            : `Konvergen? Tidak (${moves} > 0)`}
                        </span>
                      </div>
                    </div>
                  </div>

                  {/* Tabel Movers (Siswa Berpindah) */}
                  {moves > 0 && (
                    <div className="space-y-2">
                      <div className="text-xs font-medium text-main">
                        Siswa Berpindah Cluster ({moves})
                      </div>
                      <div className="rounded-md border border-line bg-card overflow-x-auto">
                        <table className="w-full text-left text-xs">
                          <thead className="bg-page border-b border-line text-muted font-medium">
                            <tr>
                              <th className="px-3 py-2">NIS</th>
                              <th className="px-3 py-2">NAMA</th>
                              <th className="px-3 py-2">DARI</th>
                              <th className="px-3 py-2">KE</th>
                            </tr>
                          </thead>
                          <tbody className="divide-y divide-line text-main font-mono">
                            {displayedMovers.map((m, idx) => (
                              <tr key={m.nis || idx}>
                                <td className="px-3 py-1.5">{m.nis}</td>
                                <td className="px-3 py-1.5 font-sans font-medium">{m.nama}</td>
                                <td className="px-3 py-1.5 text-muted">
                                  {m.fromCluster !== undefined && m.fromCluster !== null
                                    ? `C${m.fromCluster + 1}`
                                    : '-'}
                                </td>
                                <td className="px-3 py-1.5 font-semibold text-brand">
                                  {m.toCluster !== undefined && m.toCluster !== null
                                    ? `C${m.toCluster + 1}`
                                    : '-'}
                                </td>
                              </tr>
                            ))}
                          </tbody>
                        </table>
                      </div>
                      {sisaMovers > 0 && (
                        <p className="text-xs text-muted italic">
                          ...{sisaMovers} siswa lain berpindah (total {moves})
                        </p>
                      )}
                    </div>
                  )}

                  {/* Collapsible Detail Centroid */}
                  <div className="pt-1">
                    <button
                      type="button"
                      onClick={() => toggleCentroidCollapsible(num)}
                      className="inline-flex items-center gap-1.5 text-xs font-medium text-brand hover:underline"
                    >
                      <span>Detail Centroid (25 fitur × 10 cluster)</span>
                      {isCentroidOpen ? (
                        <ChevronUp className="size-3.5" />
                      ) : (
                        <ChevronDown className="size-3.5" />
                      )}
                    </button>

                    {isCentroidOpen && (
                      <div className="mt-3">
                        {loadingCentroids[num] ? (
                          <div className="flex items-center gap-2 p-4 text-xs text-muted">
                            <Loader2 className="size-4 animate-spin text-brand" />
                            <span>Memuat detail centroid iterasi {num}...</span>
                          </div>
                        ) : centroidData[num] ? (
                          <div className="rounded-md border border-line bg-card overflow-x-auto max-h-72">
                            <table className="w-full text-left text-xs border-collapse">
                              <thead className="bg-page border-b border-line text-muted font-medium sticky top-0 z-10">
                                <tr>
                                  <th className="px-2 py-1.5 whitespace-nowrap bg-page">Cluster</th>
                                  {FEATURE_OPTIONS.map((f) => (
                                    <th key={f.value} className="px-2 py-1.5 whitespace-nowrap bg-page">
                                      {f.label}
                                    </th>
                                  ))}
                                </tr>
                              </thead>
                              <tbody className="divide-y divide-line text-main font-mono">
                                {centroidData[num].map((c) => {
                                  const cIdx = c.clusterIndex;
                                  const color = KMEANS_PALETTE[cIdx] || '#6366F1';
                                  return (
                                    <tr key={cIdx} className="hover:bg-page/40">
                                      <td className="px-2 py-1.5 font-semibold whitespace-nowrap bg-card">
                                        <span className="inline-flex items-center gap-1">
                                          <span
                                            className="size-2 rounded-full inline-block"
                                            style={{ backgroundColor: color }}
                                          />
                                          C{cIdx + 1}
                                        </span>
                                      </td>
                                      {FEATURE_OPTIONS.map((f) => (
                                        <td key={f.value} className="px-2 py-1.5 whitespace-nowrap">
                                          {c.features?.[f.value] ?? '-'}
                                        </td>
                                      ))}
                                    </tr>
                                  );
                                })}
                              </tbody>
                            </table>
                          </div>
                        ) : null}
                      </div>
                    )}
                  </div>
                </div>
              )}
            </div>
          );
        })}
      </div>

      {/* Footer Note */}
      <div className="flex items-center gap-2 text-xs text-muted pt-2 border-t border-line">
        <Info className="size-3.5 shrink-0" />
        <span>
          Hasil komputasi riwayat iterasi menggunakan algoritma Standar Lloyd K-Means.
        </span>
      </div>
    </div>
  );
}
