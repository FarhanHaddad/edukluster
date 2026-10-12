import { MAPPEL } from '../../../../lib/constants';
import ImportStatusBadge from './ImportStatusBadge';
import { cn } from '../../../../lib/utils';

export const NON_AKADEMIK_COLS = [
  { key: 'ekstrakurikuler', label: 'EKSTRAKURIKULER' },
  { key: 'prestasi', label: 'PRESTASI' },
  { key: 'kemampuan', label: 'KEMAMPUAN' },
  { key: 'organisasi', label: 'ORGANISASI' },
  { key: 'kursus', label: 'KURSUS' },
  { key: 'jurusan_1', label: 'JURUSAN 1' },
  { key: 'jurusan_2', label: 'JURUSAN 2' },
];

export default function PreviewTable({
  activeSheetTab,
  paginatedRows,
  activeErrors = [],
  previewPage = 1,
  pageSize = 10,
}) {
  const isNonAkademik = activeSheetTab.toUpperCase() === 'NON-AKADEMIK';
  const cols = isNonAkademik
    ? NON_AKADEMIK_COLS
    : MAPPEL.map((m) => ({ key: m.key, label: m.label.toUpperCase() }));

  const numCols = cols.length;

  return (
    <div className="relative overflow-x-auto border border-line rounded-xl bg-card shadow-inner">
      <table className="w-full text-left text-xs border-separate border-spacing-0 min-w-max">
        <thead className="bg-page text-muted font-semibold">
          <tr>
            {/* Sticky Left Header: NO */}
            <th className="sticky top-0 left-0 z-30 bg-page px-3 py-3 w-14 text-center border-b border-r border-line shadow-[4px_0_8px_-2px_rgba(0,0,0,0.15)]">
              NO
            </th>

            {/* Scrollable Middle Headers */}
            <th className="sticky top-0 z-20 bg-page px-4 py-3 min-w-28 border-b border-r border-line/50">
              NIS
            </th>
            <th className="sticky top-0 z-20 bg-page px-4 py-3 min-w-44 max-w-52 border-b border-r border-line/50">
              NAMA SISWA
            </th>
            <th className="sticky top-0 z-20 bg-page px-3 py-3 min-w-20 text-center border-b border-r border-line/50">
              KELAS
            </th>
            <th className="sticky top-0 z-20 bg-page px-3 py-3 min-w-28 text-center border-b border-r border-line/50">
              JENIS KELAMIN
            </th>

            {cols.map((col) => (
              <th
                key={col.key}
                className={cn(
                  'sticky top-0 z-20 bg-page px-3 py-3 whitespace-nowrap font-mono text-xs border-b border-r border-line/50',
                  isNonAkademik ? 'text-left min-w-36 max-w-48' : 'text-right min-w-24'
                )}
              >
                {col.label}
              </th>
            ))}

            {/* Sticky Right Headers: STATUS & KETERANGAN */}
            <th className="sticky top-0 right-44 z-30 bg-page px-3 py-3 w-32 min-w-32 text-center border-b border-l border-line shadow-[-4px_0_8px_-2px_rgba(0,0,0,0.15)]">
              STATUS
            </th>
            <th className="sticky top-0 right-0 z-30 bg-page px-4 py-3 w-44 min-w-44 border-b border-l border-line/50">
              KETERANGAN
            </th>
          </tr>
        </thead>
        <tbody className="divide-y divide-line text-ink">
          {paginatedRows.length > 0 ? (
            paginatedRows.map((row, idx) => {
              const rowNum = (previewPage - 1) * pageSize + idx + 1;
              const originalRowNumber = row.row;
              const rowStatus = row.status || 'Valid';
              const isMissingRow = rowStatus === 'Missing';
              const isErrorRow = rowStatus === 'Error';

              const jk = row.jenis_kelamin;
              const jkLabel =
                jk === 'L' || jk === 'Laki-laki'
                  ? 'Laki-laki'
                  : jk === 'P' || jk === 'Perempuan'
                  ? 'Perempuan'
                  : '-';

              const values = row.values || {};

              // Opaque background style for sticky cells & rows (prevents bleed-through)
              const rowBgStyle = isErrorRow
                ? { backgroundColor: 'color-mix(in srgb, var(--color-danger) 10%, var(--color-card))' }
                : isMissingRow
                ? { backgroundColor: 'color-mix(in srgb, var(--color-warning) 10%, var(--color-card))' }
                : { backgroundColor: 'var(--color-card)' };

              return (
                <tr key={idx} style={rowBgStyle} className="transition-colors">
                  {/* Sticky Left Cell: NO */}
                  <td
                    style={rowBgStyle}
                    className="sticky left-0 z-10 px-3 py-2.5 font-mono text-center text-muted border-b border-r border-line shadow-[4px_0_8px_-2px_rgba(0,0,0,0.15)]"
                  >
                    {rowNum}
                  </td>

                  {/* Scrollable Middle Cells */}
                  <td className="px-4 py-2.5 font-mono font-semibold border-b border-r border-line/50">
                    {row.nis || '-'}
                  </td>
                  <td
                    className="px-4 py-2.5 font-medium truncate max-w-52 border-b border-r border-line/50"
                    title={row.nama || ''}
                  >
                    {row.nama || '-'}
                  </td>
                  <td className="px-3 py-2.5 font-mono text-center border-b border-r border-line/50">
                    {row.kelas || '-'}
                  </td>
                  <td className="px-3 py-2.5 text-center text-muted border-b border-r border-line/50">
                    {jkLabel}
                  </td>

                  {/* Middle Values Cells */}
                  {cols.map((col) => {
                    const rawVal = values[col.key];
                    const isCellNull = rawVal === null || rawVal === undefined || rawVal === '';

                    const isCellError = activeErrors.some(
                      (err) => err.row === originalRowNumber && err.field === col.key
                    );

                    let cellStyle = '';
                    if (isCellError) {
                      cellStyle = 'bg-danger-tint/60 text-danger-text font-semibold';
                    } else if (isCellNull) {
                      cellStyle = 'bg-warning-tint/25 text-warning font-semibold';
                    }

                    if (isNonAkademik) {
                      const displayVal = isCellNull ? '-' : String(rawVal);
                      return (
                        <td
                          key={col.key}
                          className={cn(
                            'px-3 py-2.5 text-xs truncate max-w-48 border-b border-r border-line/40',
                            cellStyle
                          )}
                          title={displayVal}
                        >
                          {displayVal}
                        </td>
                      );
                    }

                    const displayVal = isCellNull ? '-' : rawVal;
                    return (
                      <td
                        key={col.key}
                        className={cn(
                          'px-3 py-2.5 text-xs font-mono text-right border-b border-r border-line/40',
                          cellStyle
                        )}
                      >
                        {displayVal}
                      </td>
                    );
                  })}

                  {/* Sticky Right Cells: STATUS & KETERANGAN */}
                  <td
                    style={rowBgStyle}
                    className="sticky right-44 z-10 px-3 py-2.5 w-32 min-w-32 text-center border-b border-l border-line shadow-[-4px_0_8px_-2px_rgba(0,0,0,0.15)]"
                  >
                    <ImportStatusBadge status={rowStatus} />
                  </td>
                  <td
                    style={rowBgStyle}
                    className="sticky right-0 z-10 px-4 py-2.5 w-44 min-w-44 text-muted border-b border-l border-line/50"
                  >
                    {row.keterangan || '-'}
                  </td>
                </tr>
              );
            })
          ) : (
            <tr>
              <td
                colSpan={1 + 4 + numCols + 2}
                className="px-4 py-8 text-center text-muted bg-card"
              >
                Tidak ada data baris pada sheet ini.
              </td>
            </tr>
          )}
        </tbody>
      </table>
    </div>
  );
}
