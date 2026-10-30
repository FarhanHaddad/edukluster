import { useState, useMemo } from 'react';
import ReactECharts from 'echarts-for-react';
import useTheme, { prefersDarkScheme } from '../../../../hooks/useTheme';
import { KMEANS_PALETTE, SCATTER_AXIS_OPTIONS } from '../../../../constants/kmeans';

const CATEGORY_TICKS = ['C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10'];

export default function ScatterBubble({
  assignments = [],
  axisX = 'mtk_wajib',
  onAxisXChange,
  axisY = 'kemampuan',
  onAxisYChange,
}) {
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

  const labelX = SCATTER_AXIS_OPTIONS.find((o) => o.value === axisX)?.label || axisX;
  const labelY = SCATTER_AXIS_OPTIONS.find((o) => o.value === axisY)?.label || axisY;

  const nameX = axisX === 'cluster' ? 'X: CLUSTER (C1 - C10)' : labelX;
  const nameY = axisY === 'cluster' ? 'Y: CLUSTER (C1 - C10)' : labelY;

  const seriesList = useMemo(() => {
    return Array.from({ length: 10 }, (_, i) => {
      if (!activeClusters[i]) {
        return {
          name: `C${i + 1}`,
          type: 'scatter',
          data: [],
          itemStyle: { color: KMEANS_PALETTE[i] },
        };
      }

      const clusterItems = visibleAssignments.filter(
        (item) => Number(item.clusterIndex) === i
      );

      const data = clusterItems.map((item) => {
        const clusterIdx = Number(item.clusterIndex) || 0;
        const xVal = axisX === 'cluster' ? clusterIdx : parseFloat(item.features?.[axisX] ?? 0);
        const yVal = axisY === 'cluster' ? clusterIdx : parseFloat(item.features?.[axisY] ?? 0);
        const dist = parseFloat(item.distance ?? 0);

        const xDisplay = axisX === 'cluster' ? `C${clusterIdx + 1}` : xVal;
        const yDisplay = axisY === 'cluster' ? `C${clusterIdx + 1}` : yVal;

        return {
          value: [xVal, yVal, dist],
          symbolSize: Math.max(8, dist * 40),
          itemStyle: {
            color: KMEANS_PALETTE[i],
            opacity: 0.85,
          },
          rawItem: {
            nis: item.nis,
            nama: item.nama,
            kelas: item.kelas,
            clusterIndex: item.clusterIndex,
            distance: item.distance,
            xVal,
            yVal,
            xDisplay,
            yDisplay,
          },
        };
      });

      return {
        name: `C${i + 1}`,
        type: 'scatter',
        data,
        itemStyle: {
          color: KMEANS_PALETTE[i],
        },
      };
    });
  }, [visibleAssignments, activeClusters, axisX, axisY]);

  const option = {
    tooltip: {
      trigger: 'item',
      backgroundColor: cardBg,
      borderColor: lineColor,
      textStyle: { color: isDark ? '#FAFAFA' : '#18181B', fontSize: 12 },
      formatter: (params) => {
        const raw = params.data?.rawItem;
        if (!raw) return '';
        const clusterNum = (Number(raw.clusterIndex) || 0) + 1;
        const textColor = isDark ? '#FAFAFA' : '#18181B';
        const mutedColor = isDark ? '#A1A1AA' : '#71717A';

        const featureLines = [];
        if (axisX !== 'cluster') {
          featureLines.push(`${labelX}: <b>${raw.xDisplay}</b>`);
        }
        if (axisY !== 'cluster') {
          featureLines.push(`${labelY}: <b>${raw.yDisplay}</b>`);
        }

        return `
          <div style="font-weight:600;margin-bottom:4px;color:${textColor}">${raw.nama} (${raw.nis})</div>
          <div style="font-size:11px;color:${mutedColor}">
            Kelas: ${raw.kelas}<br/>
            Cluster: <b>C${clusterNum}</b><br/>
            ${featureLines.length > 0 ? featureLines.join('<br/>') + '<br/>' : ''}Distance: <b>${raw.distance}</b>
          </div>
        `;
      },
    },
    grid: {
      left: '4%',
      right: '4%',
      bottom: '10%',
      top: '8%',
      containLabel: true,
    },
    xAxis: {
      type: axisX === 'cluster' ? 'category' : 'value',
      data: axisX === 'cluster' ? CATEGORY_TICKS : undefined,
      name: nameX,
      nameLocation: 'middle',
      nameGap: 28,
      nameTextStyle: { color: labelColor, fontSize: 12, fontWeight: 500 },
      axisLine: { lineStyle: { color: lineColor } },
      splitLine: { lineStyle: { color: lineColor, type: 'dashed' } },
      axisLabel: { color: labelColor, fontSize: 11 },
    },
    yAxis: {
      type: axisY === 'cluster' ? 'category' : 'value',
      data: axisY === 'cluster' ? CATEGORY_TICKS : undefined,
      name: nameY,
      nameLocation: 'middle',
      nameGap: 36,
      nameTextStyle: { color: labelColor, fontSize: 12, fontWeight: 500 },
      axisLine: { show: false },
      splitLine: { lineStyle: { color: lineColor, type: 'dashed' } },
      axisLabel: { color: labelColor, fontSize: 11 },
    },
    series: seriesList,
  };

  return (
    <div className="space-y-4">
      {/* Header controls & legend */}
      <div className="flex flex-col gap-3 border-b border-line pb-3 sm:flex-row sm:items-center sm:justify-between">
        <div className="flex flex-wrap items-center gap-3">
          <div className="flex items-center gap-1.5 text-xs text-muted">
            <label htmlFor="select-axis-x" className="font-medium">Sumbu X:</label>
            <select
              id="select-axis-x"
              value={axisX}
              onChange={(e) => onAxisXChange?.(e.target.value)}
              className="h-8 rounded-md border border-line bg-card px-2 text-xs font-medium text-main shadow-sm focus:border-brand focus:outline-none"
            >
              {SCATTER_AXIS_OPTIONS.map((opt) => (
                <option key={opt.value} value={opt.value}>
                  {opt.label}
                </option>
              ))}
            </select>
          </div>

          <div className="flex items-center gap-1.5 text-xs text-muted">
            <label htmlFor="select-axis-y" className="font-medium">Sumbu Y:</label>
            <select
              id="select-axis-y"
              value={axisY}
              onChange={(e) => onAxisYChange?.(e.target.value)}
              className="h-8 rounded-md border border-line bg-card px-2 text-xs font-medium text-main shadow-sm focus:border-brand focus:outline-none"
            >
              {SCATTER_AXIS_OPTIONS.map((opt) => (
                <option key={opt.value} value={opt.value}>
                  {opt.label}
                </option>
              ))}
            </select>
          </div>
        </div>

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
                C${i + 1}
              </button>
            );
          })}
        </div>
      </div>

      {/* Chart */}
      <div className="h-96 w-full">
        <ReactECharts
          key={isDark ? 'dark' : 'light'}
          option={option}
          style={{ height: '100%', width: '100%' }}
          notMerge={true}
          lazyUpdate={true}
        />
      </div>

      {/* Dynamic Caption */}
      <div className="text-right text-xs font-medium text-muted">
        N = <span className="font-bold text-main">${visibleAssignments.length}</span> data
      </div>
    </div>
  );
}
