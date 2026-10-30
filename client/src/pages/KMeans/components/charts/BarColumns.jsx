import { useState, useMemo } from 'react';
import ReactECharts from 'echarts-for-react';
import useTheme, { prefersDarkScheme } from '../../../../hooks/useTheme';
import { KMEANS_PALETTE } from '../../../../constants/kmeans';

export default function BarColumns({ distribution = [] }) {
  const { mode } = useTheme();
  const isDark = mode === 'dark' || (mode === 'system' && prefersDarkScheme());

  const lineColor = isDark ? '#3F3F46' : '#E4E4E7';
  const labelColor = isDark ? '#A1A1AA' : '#52525B';
  const cardBg = isDark ? '#18181B' : '#FFFFFF';

  // Bar ordering state: 'count_desc', 'count_asc', 'cluster_asc', 'cluster_desc'
  const [barOrder, setBarOrder] = useState('count_desc');

  // Build baseline 10 clusters (C1 to C10) with counts
  const rawData = useMemo(() => {
    const counts = distribution.map((item) =>
      typeof item === 'object' && item !== null ? (item.count ?? 0) : Number(item || 0)
    );
    return Array.from({ length: 10 }, (_, i) => ({
      clusterIndex: i,
      clusterName: `C${i + 1}`,
      count: counts[i] ?? 0,
      color: KMEANS_PALETTE[i % KMEANS_PALETTE.length],
    }));
  }, [distribution]);

  const orderedData = useMemo(() => {
    const list = [...rawData];
    if (barOrder === 'count_desc') {
      list.sort((a, b) => b.count - a.count || a.clusterIndex - b.clusterIndex);
    } else if (barOrder === 'count_asc') {
      list.sort((a, b) => a.count - b.count || a.clusterIndex - b.clusterIndex);
    } else if (barOrder === 'cluster_asc') {
      list.sort((a, b) => a.clusterIndex - b.clusterIndex);
    } else if (barOrder === 'cluster_desc') {
      list.sort((a, b) => b.clusterIndex - a.clusterIndex);
    }
    return list;
  }, [rawData, barOrder]);

  const maxVal = rawData.length > 0 ? Math.max(...rawData.map((d) => d.count)) : 0;
  const minVal = rawData.length > 0 ? Math.min(...rawData.map((d) => d.count)) : 0;

  const seriesData = orderedData.map((item) => {
    return {
      value: item.count,
      itemStyle: {
        color: item.color,
        borderRadius: [4, 4, 0, 0],
      },
      label: {
        show: true,
        position: 'top',
        color: item.color,
        textBorderColor: cardBg,
        textBorderWidth: 3,
        fontSize: 12,
        fontWeight: 'bold',
      },
    };
  });

  const option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'shadow' },
      backgroundColor: cardBg,
      borderColor: lineColor,
      textStyle: { color: isDark ? '#FAFAFA' : '#18181B', fontSize: 12 },
      formatter: (params) => {
        const item = params[0];
        const dataObj = orderedData[item.dataIndex];
        return `<b>Cluster ${dataObj.clusterIndex + 1} (${dataObj.clusterName})</b><br/>Jumlah Siswa: <b>${item.value}</b>`;
      },
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      top: '15%',
      containLabel: true,
    },
    xAxis: {
      type: 'category',
      data: orderedData.map((d) => d.clusterName),
      axisTick: { alignWithLabel: true },
      axisLine: { lineStyle: { color: lineColor } },
      axisLabel: { color: labelColor, fontSize: 12 },
    },
    yAxis: {
      type: 'value',
      axisLine: { show: false },
      splitLine: { lineStyle: { color: lineColor, type: 'dashed' } },
      axisLabel: { color: labelColor, fontSize: 12 },
    },
    series: [
      {
        name: 'Jumlah Siswa',
        type: 'bar',
        barWidth: '50%',
        data: seriesData,
      },
    ],
  };

  return (
    <div className="space-y-4">
      {/* Chart Header */}
      <div className="flex flex-col gap-3 border-b border-line pb-3 sm:flex-row sm:items-center sm:justify-between">
        <div className="flex items-center gap-3">
          <h3 className="text-sm font-semibold text-main">
            Distribusi Siswa per Cluster
          </h3>
          <div className="flex items-center gap-1.5 text-xs text-muted">
            <label htmlFor="select-bar-order" className="font-medium">Urutan bar:</label>
            <select
              id="select-bar-order"
              value={barOrder}
              onChange={(e) => setBarOrder(e.target.value)}
              className="h-8 rounded-md border border-line bg-card px-2 text-xs font-medium text-main shadow-sm focus:border-brand focus:outline-none"
            >
              <option value="count_desc">Jumlah anggota (desc)</option>
              <option value="count_asc">Jumlah anggota (asc)</option>
              <option value="cluster_asc">Cluster (C1-&gt;C10)</option>
              <option value="cluster_desc">Cluster (C10-&gt;C1)</option>
            </select>
          </div>
        </div>

        <div className="font-mono text-xs font-medium text-muted">
          Max: <span className="font-bold text-main">{maxVal}</span> | Min:{' '}
          <span className="font-bold text-main">{minVal}</span>
        </div>
      </div>

      {/* Legend Chips C1-C10 */}
      <div className="flex flex-wrap items-center gap-1.5">
        {Array.from({ length: 10 }, (_, i) => (
          <span
            key={i}
            className="inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[10px] font-medium"
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
        ))}
      </div>

      {/* ECharts View */}
      <div className="h-72 w-full">
        <ReactECharts
          key={isDark ? 'dark' : 'light'}
          option={option}
          style={{ height: '100%', width: '100%' }}
          notMerge={true}
          lazyUpdate={true}
        />
      </div>
    </div>
  );
}
