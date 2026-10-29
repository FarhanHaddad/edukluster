import { useMemo } from 'react';
import ReactECharts from 'echarts-for-react';
import { KMEANS_PALETTE, FEATURE_OPTIONS } from '../../../../constants/kmeans';

export default function ScatterBubble({
  assignments = [],
  filterCluster = 'all',
  axisX = 'mtk_wajib',
  onAxisXChange,
  axisY = 'kemampuan',
  onAxisYChange,
}) {
  const filteredAssignments = useMemo(() => {
    if (filterCluster === 'all') return assignments;
    const targetClusterIndex = Number(filterCluster) - 1;
    return assignments.filter(
      (item) => Number(item.clusterIndex) === targetClusterIndex
    );
  }, [assignments, filterCluster]);

  const labelX = FEATURE_OPTIONS.find((o) => o.value === axisX)?.label || axisX;
  const labelY = FEATURE_OPTIONS.find((o) => o.value === axisY)?.label || axisY;

  const activeClusterIndex = filterCluster !== 'all' ? Number(filterCluster) - 1 : -1;

  const seriesList = useMemo(() => {
    return Array.from({ length: 10 }, (_, i) => {
      const clusterItems = filteredAssignments.filter(
        (item) => Number(item.clusterIndex) === i
      );

      const data = clusterItems.map((item) => {
        const xVal = parseFloat(item.features?.[axisX] ?? 0);
        const yVal = parseFloat(item.features?.[axisY] ?? 0);
        const dist = parseFloat(item.distance ?? 0);

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
  }, [filteredAssignments, axisX, axisY]);

  const option = {
    tooltip: {
      trigger: 'item',
      backgroundColor: 'var(--color-card, #FFFFFF)',
      borderColor: 'var(--color-line, #E2E8F0)',
      textStyle: { color: 'var(--color-main, #0F172A)', fontSize: 12 },
      formatter: (params) => {
        const raw = params.data?.rawItem;
        if (!raw) return '';
        const clusterNum = (Number(raw.clusterIndex) || 0) + 1;
        return `
          <div style="font-weight:600;margin-bottom:4px;">${raw.nama} (${raw.nis})</div>
          <div style="font-size:11px;color:var(--color-muted,#64748B);">
            Kelas: ${raw.kelas}<br/>
            Cluster: <b>C${clusterNum}</b><br/>
            ${labelX}: <b>${raw.xVal}</b><br/>
            ${labelY}: <b>${raw.yVal}</b><br/>
            Distance: <b>${raw.distance}</b>
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
      type: 'value',
      name: labelX,
      nameLocation: 'middle',
      nameGap: 28,
      nameTextStyle: { color: 'var(--color-muted, #64748B)', fontSize: 12, fontWeight: 500 },
      axisLine: { lineStyle: { color: 'var(--color-line, #E2E8F0)' } },
      splitLine: { lineStyle: { color: 'var(--color-line, #E2E8F0)', type: 'dashed' } },
      axisLabel: { color: 'var(--color-muted, #64748B)', fontSize: 11 },
    },
    yAxis: {
      type: 'value',
      name: labelY,
      nameLocation: 'middle',
      nameGap: 36,
      nameTextStyle: { color: 'var(--color-muted, #64748B)', fontSize: 12, fontWeight: 500 },
      axisLine: { show: false },
      splitLine: { lineStyle: { color: 'var(--color-line, #E2E8F0)', type: 'dashed' } },
      axisLabel: { color: 'var(--color-muted, #64748B)', fontSize: 11 },
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
              {FEATURE_OPTIONS.map((opt) => (
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
              {FEATURE_OPTIONS.map((opt) => (
                <option key={opt.value} value={opt.value}>
                  {opt.label}
                </option>
              ))}
            </select>
          </div>
        </div>

        {/* Legend Chips C1-C10 */}
        <div className="flex flex-wrap items-center gap-1.5">
          {Array.from({ length: 10 }, (_, i) => {
            const isDimmed = activeClusterIndex !== -1 && activeClusterIndex !== i;
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

      {/* Chart */}
      <div className="h-96 w-full">
        <ReactECharts
          option={option}
          style={{ height: '100%', width: '100%' }}
          notMerge={true}
          lazyUpdate={true}
        />
      </div>

      {/* Dynamic Caption */}
      <div className="text-right text-xs font-medium text-muted">
        N = <span className="font-bold text-main">{filteredAssignments.length}</span> data
      </div>
    </div>
  );
}
