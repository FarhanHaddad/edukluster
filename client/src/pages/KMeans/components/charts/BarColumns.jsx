import ReactECharts from 'echarts-for-react';
import { KMEANS_PALETTE } from '../../../../constants/kmeans';

export default function BarColumns({ distribution = [], filterCluster = 'all' }) {
  const counts = distribution.map((item) =>
    typeof item === 'object' && item !== null ? (item.count ?? 0) : Number(item || 0)
  );

  // Fill up to 10 if less than 10
  const normalizedCounts = Array.from({ length: 10 }, (_, i) => counts[i] ?? 0);

  const maxVal = normalizedCounts.length > 0 ? Math.max(...normalizedCounts) : 0;
  const minVal = normalizedCounts.length > 0 ? Math.min(...normalizedCounts) : 0;

  const activeIndex =
    filterCluster !== 'all' ? Number(filterCluster) - 1 : -1;

  const seriesData = normalizedCounts.map((val, idx) => {
    const color = KMEANS_PALETTE[idx % KMEANS_PALETTE.length];
    const isDimmed = activeIndex !== -1 && activeIndex !== idx;
    return {
      value: val,
      itemStyle: {
        color: color,
        opacity: isDimmed ? 0.25 : 1,
        borderRadius: [4, 4, 0, 0],
      },
    };
  });

  const option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'shadow' },
      formatter: (params) => {
        const item = params[0];
        return `<b>Cluster ${item.dataIndex + 1} (C${item.dataIndex + 1})</b><br/>Jumlah Siswa: <b>${item.value}</b>`;
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
      data: Array.from({ length: 10 }, (_, i) => `C${i + 1}`),
      axisTick: { alignWithLabel: true },
      axisLine: { lineStyle: { color: 'var(--color-line, #E2E8F0)' } },
      axisLabel: { color: 'var(--color-muted, #64748B)', fontSize: 12 },
    },
    yAxis: {
      type: 'value',
      axisLine: { show: false },
      splitLine: { lineStyle: { color: 'var(--color-line, #E2E8F0)', type: 'dashed' } },
      axisLabel: { color: 'var(--color-muted, #64748B)', fontSize: 12 },
    },
    series: [
      {
        name: 'Jumlah Siswa',
        type: 'bar',
        barWidth: '50%',
        data: seriesData,
        label: {
          show: true,
          position: 'top',
          color: 'var(--color-main, #0F172A)',
          fontSize: 12,
          fontWeight: 'bold',
        },
      },
    ],
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between border-b border-line pb-3">
        <h3 className="text-sm font-semibold text-main">
          Distribusi Siswa per Cluster
        </h3>
        <div className="font-mono text-xs font-medium text-muted">
          Max: <span className="font-bold text-main">{maxVal}</span> | Min:{' '}
          <span className="font-bold text-main">{minVal}</span>
        </div>
      </div>

      <div className="h-72 w-full">
        <ReactECharts
          option={option}
          style={{ height: '100%', width: '100%' }}
          notMerge={true}
          lazyUpdate={true}
        />
      </div>
    </div>
  );
}
