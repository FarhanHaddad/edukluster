import { useMemo } from 'react';
import ReactECharts from 'echarts-for-react';
import { KMEANS_PALETTE, FEATURE_OPTIONS } from '../../../../constants/kmeans';

export default function ParallelCoords({ assignments = [], filterCluster = 'all' }) {
  const filteredAssignments = useMemo(() => {
    if (filterCluster === 'all') return assignments;
    const targetClusterIndex = Number(filterCluster) - 1;
    return assignments.filter(
      (item) => Number(item.clusterIndex) === targetClusterIndex
    );
  }, [assignments, filterCluster]);

  const parallelAxis = useMemo(() => {
    return FEATURE_OPTIONS.map((opt, idx) => ({
      dim: idx,
      name: opt.label,
      type: 'value',
      nameLocation: 'end',
      nameGap: 10,
      nameTextStyle: {
        fontSize: 10,
        color: 'var(--color-muted, #64748B)',
      },
      axisLine: { lineStyle: { color: 'var(--color-line, #E2E8F0)' } },
      axisTick: { lineStyle: { color: 'var(--color-line, #E2E8F0)' } },
      axisLabel: {
        color: 'var(--color-muted, #64748B)',
        fontSize: 9,
      },
    }));
  }, []);

  const seriesList = useMemo(() => {
    return Array.from({ length: 10 }, (_, clusterIdx) => {
      const clusterItems = filteredAssignments.filter(
        (item) => Number(item.clusterIndex) === clusterIdx
      );

      const lineData = clusterItems.map((item) =>
        FEATURE_OPTIONS.map((opt) => parseFloat(item.features?.[opt.value] ?? 0))
      );

      return {
        name: `C${clusterIdx + 1}`,
        type: 'parallel',
        smooth: true,
        lineStyle: {
          width: 1.2,
          opacity: 0.15,
          color: KMEANS_PALETTE[clusterIdx],
        },
        emphasis: {
          lineStyle: {
            width: 3,
            opacity: 1.0,
            color: KMEANS_PALETTE[clusterIdx],
          },
        },
        data: lineData,
      };
    });
  }, [filteredAssignments]);

  const option = {
    tooltip: {
      padding: 10,
      backgroundColor: 'var(--color-card, #FFFFFF)',
      borderColor: 'var(--color-line, #E2E8F0)',
      textStyle: { color: 'var(--color-main, #0F172A)', fontSize: 11 },
    },
    parallel: {
      left: '3%',
      right: '4%',
      bottom: '12%',
      top: '18%',
      parallelAxisDefault: {
        type: 'value',
        nameLocation: 'end',
      },
    },
    parallelAxis,
    series: seriesList,
  };

  return (
    <div className="space-y-4">
      <div className="flex flex-col gap-2 border-b border-line pb-3 sm:flex-row sm:items-center sm:justify-between">
        <h3 className="text-sm font-semibold text-main">
          Profil 25 Fitur Siswa (Parallel Coordinates)
        </h3>

        {/* Legend Chips C1-C10 */}
        <div className="flex flex-wrap items-center gap-1.5">
          {Array.from({ length: 10 }, (_, i) => {
            const isDimmed =
              filterCluster !== 'all' && Number(filterCluster) - 1 !== i;
            return (
              <span
                key={i}
                className={`inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[10px] font-medium transition-opacity ${
                  isDimmed ? 'opacity-30' : 'opacity-100'
                }`}
                style={{
                  backgroundColor: `${KMEANS_PALETTE[i]}15`,
                  color: KMEANS_PALETTE[i],
                  border: `1px solid ${KMEANS_PALETTE[i]}40`,
                }}
              >
                <span
                  className="size-1.5 rounded-full"
                  style={{ backgroundColor: KMEANS_PALETTE[i] }}
                />
                C{i + 1}
              </span>
            );
          })}
        </div>
      </div>

      <div className="h-100 w-full overflow-x-auto">
        <ReactECharts
          option={option}
          style={{ height: '100%', minWidth: '900px', width: '100%' }}
          notMerge={true}
          lazyUpdate={true}
        />
      </div>

      <div className="text-right text-xs font-medium text-muted">
        <span className="font-bold text-main">{filteredAssignments.length}</span> garis • opacity rendah • hover untuk fokus satu siswa
      </div>
    </div>
  );
}
