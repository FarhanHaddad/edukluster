import { useState, useMemo } from 'react';
import ReactECharts from 'echarts-for-react';
import useTheme, { prefersDarkScheme } from '../../../../hooks/useTheme';
import { KMEANS_PALETTE, FEATURE_OPTIONS } from '../../../../constants/kmeans';

export default function ParallelCoords({ assignments = [] }) {
  const { mode } = useTheme();
  const isDark = mode === 'dark' || (mode === 'system' && prefersDarkScheme());

  const lineColor = isDark ? '#3F3F46' : '#E4E4E7';
  const labelColor = isDark ? '#A1A1AA' : '#52525B';
  const cardBg = isDark ? '#18181B' : '#FFFFFF';

  // Multi-toggle active clusters state: default all 10 true
  const [activeClusters, setActiveClusters] = useState(
    Array.from({ length: 10 }, () => true)
  );

  const toggleCluster = (index) => {
    setActiveClusters((prev) => {
      const next = [...prev];
      next[index] = !next[index];
      return next;
    });
  };

  const visibleAssignments = useMemo(() => {
    return assignments.filter((item) => {
      const idx = Number(item.clusterIndex);
      return activeClusters[idx] ?? true;
    });
  }, [assignments, activeClusters]);

  const parallelAxis = useMemo(() => {
    return FEATURE_OPTIONS.map((opt, idx) => ({
      dim: idx,
      name: opt.label,
      type: 'value',
      nameLocation: 'end',
      nameGap: 10,
      nameTextStyle: {
        fontSize: 10,
        color: labelColor,
      },
      axisLine: { lineStyle: { color: lineColor } },
      axisTick: { lineStyle: { color: lineColor } },
      axisLabel: {
        color: labelColor,
        fontSize: 9,
      },
    }));
  }, [labelColor, lineColor]);

  const seriesList = useMemo(() => {
    return Array.from({ length: 10 }, (_, clusterIdx) => {
      if (!activeClusters[clusterIdx]) {
        return {
          name: `C${clusterIdx + 1}`,
          type: 'parallel',
          smooth: true,
          data: [],
        };
      }

      const clusterItems = visibleAssignments.filter(
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
  }, [visibleAssignments, activeClusters]);

  const option = {
    tooltip: {
      padding: 10,
      backgroundColor: cardBg,
      borderColor: lineColor,
      textStyle: { color: isDark ? '#FAFAFA' : '#18181B', fontSize: 11 },
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

        {/* Legend Chips C1-C10 Interactive Toggle */}
        <div className="flex flex-wrap items-center gap-1.5">
          {Array.from({ length: 10 }, (_, i) => {
            const isActive = activeClusters[i];
            return (
              <button
                key={i}
                type="button"
                onClick={() => toggleCluster(i)}
                className={`inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[10px] font-medium transition-all select-none cursor-pointer ${
                  !isActive ? 'opacity-30 grayscale' : 'opacity-100'
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
              </button>
            );
          })}
        </div>
      </div>

      <div className="h-100 w-full overflow-x-auto">
        <ReactECharts
          key={isDark ? 'dark' : 'light'}
          option={option}
          style={{ height: '100%', minWidth: '900px', width: '100%' }}
          notMerge={true}
          lazyUpdate={true}
        />
      </div>

      <div className="text-right text-xs font-medium text-muted">
        <span className="font-bold text-main">{visibleAssignments.length}</span> garis • opacity rendah • hover untuk fokus satu siswa
      </div>
    </div>
  );
}
