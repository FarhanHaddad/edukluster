import ReactECharts from 'echarts-for-react';
import Card from '../../components/ui/Card';
import useTheme, { prefersDarkScheme } from '../../hooks/useTheme';
import { KMEANS_PALETTE } from '../../constants/kmeans';

export default function DistributionPanel({ state = 'S0', distribution = [], totalStudents = 0 }) {
  const { mode } = useTheme();
  const isDark = mode === 'dark' || (mode === 'system' && prefersDarkScheme());

  const lineColor = isDark ? '#3F3F46' : '#E4E4E7';
  const labelColor = isDark ? '#A1A1AA' : '#52525B';
  const cardBg = isDark ? '#18181B' : '#FFFFFF';

  const isS4 = state === 'S4' && distribution.length > 0;

  const rawData = Array.from({ length: 10 }, (_, i) => {
    const item = distribution[i];
    const count = typeof item === 'object' && item !== null ? (item.count ?? 0) : Number(item || 0);
    return {
      clusterIndex: i,
      clusterName: `C${i + 1}`,
      count,
      color: KMEANS_PALETTE[i % KMEANS_PALETTE.length],
    };
  });

  const seriesData = rawData.map((item) => ({
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
  }));

  const option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'shadow' },
      backgroundColor: cardBg,
      borderColor: lineColor,
      textStyle: { color: isDark ? '#FAFAFA' : '#18181B', fontSize: 12 },
      formatter: (params) => {
        const item = params[0];
        const dataObj = rawData[item.dataIndex];
        return `<b>Cluster ${dataObj.clusterIndex + 1} (${dataObj.clusterName})</b><br/>Jumlah Siswa: <b>${item.value}</b>`;
      },
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      top: '12%',
      containLabel: true,
    },
    xAxis: {
      type: 'category',
      data: rawData.map((d) => d.clusterName),
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

  const emptyText =
    state === 'S0'
      ? 'Belum ada periode aktif.'
      : 'Distribusi klaster muncul setelah K-Means dijalankan.';

  return (
    <Card className="flex flex-col gap-4">
      {/* Header + Chip N */}
      <div className="flex flex-wrap items-center justify-between gap-2 border-b border-line pb-3">
        <div>
          <h2 className="text-sm font-semibold leading-5 text-ink">
            Distribusi Klaster Siswa (C1 - C10)
          </h2>
          {isS4 && (
            <p className="text-xs text-muted">
              Sebaran {totalStudents} siswa SMA Widuri berdasarkan hasil klasterisasi K-Means
            </p>
          )}
        </div>
        <span className="rounded-md bg-subtle px-2 py-0.5 font-mono text-xs font-medium text-muted">
          N = {totalStudents}
        </span>
      </div>

      {isS4 ? (
        <>
          {/* Legend chips C1-C10 DI ATAS chart */}
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

          {/* Bar Chart */}
          <div className="h-64 w-full">
            <ReactECharts
              key={isDark ? 'dark' : 'light'}
              option={option}
              style={{ height: '100%', width: '100%' }}
              notMerge={true}
              lazyUpdate={true}
            />
          </div>
        </>
      ) : (
        /* Empty State */
        <div className="flex min-h-56 items-center justify-center py-8">
          <p className="max-w-xs text-center text-sm leading-5 text-muted">
            {emptyText}
          </p>
        </div>
      )}
    </Card>
  );
}
