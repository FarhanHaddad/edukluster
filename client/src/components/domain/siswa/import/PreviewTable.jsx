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
      <table className="w-full text-left text-xs border-collapse min-w-max">
        <thead className="border-b border-line bg-page text-muted font-semibold sticky top-0 z-20">
          <tr>
            {/* Sticky Left Headers */}
            <th className="sticky left-0 z-20 bg-page px-3 py-3 w-14 text-center border-r border-line shadow-[2px_0_5px_-2px_rgba(0,0,0,0.1)]">
              NO
            </th>
            <th className="sticky left-14 z-20 bg-page px-4 py-3 w-28 border-r border-line shadow-[2px_0_5px_-2px_rgba(0,0,0,0.1)]">
              NIS
            </th>
            <th className="sticky left-42 z-20 bg-page px-4 py-3 min-w-44 border-r border-line shadow-[2px_0_5px_-2px_rgba(0,0,0,0.1)]">
              NAMA SISWA
            </th>
            <th className="sticky left-86 z-20 bg-page px-3 py-3 w-20 text-center border-r border-line shadow-[2px_0_5px_-2px_rgba(0,0,0,0.1)]">
              KELAS
            </th>
            <th className="sticky left-106 z-20 bg-page px-3 py-3 w-28 text-center border-r border-line shadow-[4px_0_8px_-2px_rgba(0,0,0,0.15)]">
              JENIS KELAMIN
            </th>

            {/* Scrollable Middle Headers */}
            {cols.map((col) => (
              <th
                key={col.key}
                className={cn(
                  'px-3 py-3 whitespace-nowrap font-mono text-xs border-r border-line/50',
                  isNonAkademik ? 'text-left min-w-36 max-w-48' : 'text-right min-w-24'
                )}
              >
                {col.label}
              </th>
            ))}

            {/* Sticky Right Headers */}
            <th className="sticky right-28 z-20 bg-page px-3 py-3 w-28 text-center border-l border-line shadow-[-4px_0_8px_-2px_rgba(0,0,0,0.15)]">
              STATUS
            </th>
            <th className="sticky right-0 z-20 bg-page px-4 py-3 min-w-36 border-l border-line shadow-[-2px_0_5px_-2px_rgba(0,0,0,0.1)]">
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
              const jkLabel = jk === 'L' ? 'Laki-laki' : jk === 'P' ? 'Perempuan' : '-';

              const values = row.values || {};

              const rowBgClass = isErrorRow
                ? 'bg-danger-tint/20'
                : isMissingRow
                ? 'bg-warning-tint/20'
                : 'bg-card';

              return (
                <tr key={idx} className={cn('transition-colors', rowBgClass)}>
                  {/* Sticky Left Cells */}
                  <td
                    className={cn(
                      'sticky left-0 z-10 px-3 py-2.5 font-mono text-center text-muted border-r border-line shadow-[2px_0_5px_-2px_rgba(0,0,0,0.1)]',
                      rowBgClass
                    )}
                  >
                    {rowNum}
                  </td>
                  <td
                    className={cn(
                      'sticky left-14 z-10 px-4 py-2.5 font-mono font-semibold border-r border-line shadow-[2px_0_5px_-2px_rgba(0,0,0,0.1)]',
                      rowBgClass
                    )}
                  >
                    {row.nis || '-'}
                  </td>
                  <td
                    className={cn(
                      'sticky left-42 z-10 px-4 py-2.5 font-medium truncate max-w-52 border-r border-line shadow-[2px_0_5px_-2px_rgba(0,0,0,0.1)]',
                      rowBgClass
                    )}
                    title={row.nama || ''}
                  >
                    {row.nama || '-'}
                  </td>
                  <td
                    className={cn(
                      'sticky left-86 z-10 px-3 py-2.5 font-mono text-center border-r border-line shadow-[2px_0_5px_-2px_rgba(0,0,0,0.1)]',
                      rowBgClass
                    )}
                  >
                    {row.kelas || '-'}
                  </td>
                  <td
                    className={cn(
                      'sticky left-106 z-10 px-3 py-2.5 text-center text-muted border-r border-line shadow-[4px_0_8px_-2px_rgba(0,0,0,0.15)]',
                      rowBgClass
                    )}
                  >
                    {jkLabel}
                  </td>

                  {/* Middle Cells */}
                  {cols.map((col) => {
                    const rawVal = values[col.key];
                    const isCellNull = rawVal === null || rawVal === undefined || rawVal === '';

                    // Check if cell is caused by error
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
                            'px-3 py-2.5 text-xs truncate max-w-48 border-r border-line/40',
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
                          'px-3 py-2.5 text-xs font-mono text-right border-r border-line/40',
                          cellStyle
                        )}
                      >
                        {displayVal}
                      </td>
                    );
                  })}

                  {/* Sticky Right Cells */}
                  <td
                    className={cn(
                      'sticky right-28 z-10 px-3 py-2.5 text-center border-l border-line shadow-[-4px_0_8px_-2px_rgba(0,0,0,0.15)]',
                      rowBgClass
                    )}
                  >
                    <ImportStatusBadge status={rowStatus} />
                  </td>
                  <td
                    className={cn(
                      'sticky right-0 z-10 px-4 py-2.5 text-muted border-l border-line shadow-[-2px_0_5px_-2px_rgba(0,0,0,0.1)]',
                      rowBgClass
                    )}
                  >
                    {row.keterangan || '-'}
                  </td>
                </tr>
              );
            })
          ) : (
            <tr>
              <td
                colSpan={5 + numCols + 2}
                className="px-4 py-8 text-center text-muted"
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
