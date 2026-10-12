import { FileSpreadsheet, AlertCircle, Info, ChevronLeft, ChevronRight } from 'lucide-react';
import Badge from '../../../ui/Badge';
import Button from '../../../ui/Button';
import ImportStatusBadge from './ImportStatusBadge';
import PreviewTable from './PreviewTable';
import { cn } from '../../../../lib/utils';
import { formatFileSize } from './helpers';

export default function PreviewStep({
  previewData,
  selectedFile,
  activeSheetTab,
  previewPage,
  onSheetTabChange,
  onPageChange,
  onResetWizard,
  onNext,
}) {
  const summary = previewData?.summary || {};
  const totalRows = summary.totalRows ?? 0;
  const validRows = summary.validRows ?? 0;
  const missingRows = summary.missingRows ?? 0;
  const errorRows = summary.errorRows ?? 0;
  const importableRows = summary.importableRows ?? 0;

  const currentSheet = previewData?.sheets?.find(
    (s) => s.name.toUpperCase() === activeSheetTab.toUpperCase()
  ) || { name: activeSheetTab, status: 'Valid', rows: [], errors: [] };

  const activeRows = currentSheet.rows || [];
  const activeErrors = currentSheet.errors || [];
  const totalSheetRows = activeRows.length;
  const pageSize = 10;
  const totalPages = Math.ceil(totalSheetRows / pageSize) || 1;
  const paginatedRows = activeRows.slice((previewPage - 1) * pageSize, previewPage * pageSize);

  // Contract check: Verify values & jenis_kelamin fields exist on rows
  if (activeRows.length > 0) {
    const sampleRow = activeRows[0];
    if (!('values' in sampleRow) || !('jenis_kelamin' in sampleRow)) {
      console.error('BE Response Contract Error: missing `values` or `jenis_kelamin` field on rows', sampleRow);
    }
  }

  return (
    <div className="space-y-6">
      {/* Header row: File chip + Summary chips */}
      <div className="flex flex-wrap items-center justify-between gap-3 p-4 border border-line rounded-xl bg-card">
        {/* File chip */}
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-page border border-line">
          <FileSpreadsheet className="h-4 w-4 text-brand shrink-0" />
          <span className="text-xs font-semibold text-ink">
            {previewData?.fileName || selectedFile?.name}
          </span>
          <span className="text-xs font-mono text-muted">
            ({formatFileSize(previewData?.fileSize || selectedFile?.size)})
          </span>
        </div>

        {/* Summary chips */}
        <div className="flex flex-wrap items-center gap-2">
          <Badge tone="neutral" className="font-mono">
            {totalRows} baris terbaca
          </Badge>
          <Badge tone="success" className="font-mono">
            {validRows} valid
          </Badge>
          <Badge tone="warning" className="font-mono">
            {missingRows} missing
          </Badge>
          <Badge tone="danger" className="font-mono">
            {errorRows} error
          </Badge>
          <Badge tone="info" className="font-mono">
            Header: baris 1
          </Badge>
          <Badge tone="info" className="font-mono">
            Kolom: sesuai template
          </Badge>
        </div>
      </div>

      {/* Sheet Tabs */}
      <div className="flex border-b border-line gap-4">
        {previewData?.sheets?.map((sheet) => {
          const sheetNameUpper = sheet.name.toUpperCase();
          const isActive = activeSheetTab.toUpperCase() === sheetNameUpper;
          const sheetStatus = sheet.status || 'Valid';

          return (
            <button
              key={sheet.name}
              type="button"
              onClick={() => onSheetTabChange(sheetNameUpper)}
              className={cn(
                'flex items-center gap-2 pb-3 text-xs font-semibold border-b-2 transition-colors',
                isActive
                  ? 'border-brand text-brand'
                  : 'border-transparent text-muted hover:text-ink'
              )}
            >
              <span className="font-mono">Sheet {sheetNameUpper}</span>
              <ImportStatusBadge status={sheetStatus} className="text-[10px] px-2 py-0" />
            </button>
          );
        })}
      </div>

      {/* Box Error Sheet Aktif (if errors exist or missing exist) */}
      {(activeErrors.length > 0 || missingRows > 0) && (
        <div className="space-y-2">
          {activeErrors.length > 0 && (
            <div className="p-3 border border-danger/30 bg-danger-tint/40 rounded-lg text-xs space-y-1.5 text-danger-text">
              <p className="font-semibold flex items-center gap-1.5">
                <AlertCircle className="h-3.5 w-3.5 shrink-0" />
                <span>
                  Ditemukan {activeErrors.length} error pada sheet {activeSheetTab}:
                </span>
              </p>
              <div className="pl-5 space-y-1">
                {activeErrors.slice(0, 3).map((err, idx) => {
                  const no = err.row ? err.row - 1 : '-';
                  return (
                    <p key={idx}>
                      No <span className="font-mono font-semibold">{no}</span>
                      {err.nis ? (
                        <>
                          {' '}
                          - NIS <span className="font-mono font-semibold">{err.nis}</span>
                        </>
                      ) : null}
                      : {err.message}
                    </p>
                  );
                })}
                {activeErrors.length > 3 && (
                  <p className="italic font-medium text-muted">
                    +{activeErrors.length - 3} error lainnya
                  </p>
                )}
              </div>
            </div>
          )}

          {missingRows > 0 && (
            <div className="p-3 border border-warning/30 bg-warning-tint/40 rounded-lg text-xs text-ink flex items-center gap-2">
              <Info className="h-4 w-4 text-warning shrink-0" />
              <span>
                <strong className="font-mono">{missingRows} baris missing</strong> akan
                diimputasi pada tahap Cleaning.
              </span>
            </div>
          )}
        </div>
      )}

      {/* Table Preview Rows with Sticky Columns */}
      <PreviewTable
        activeSheetTab={activeSheetTab}
        paginatedRows={paginatedRows}
        activeErrors={activeErrors}
        previewPage={previewPage}
        pageSize={pageSize}
      />

      {/* Client-side Pagination */}
      {totalSheetRows > 0 && (
        <div className="flex items-center justify-between px-4 py-3 border border-line rounded-xl bg-card text-xs text-muted">
          <div>
            Menampilkan{' '}
            <span className="font-mono font-semibold text-ink">
              {(previewPage - 1) * pageSize + 1}
            </span>
            -
            <span className="font-mono font-semibold text-ink">
              {Math.min(previewPage * pageSize, totalSheetRows)}
            </span>{' '}
            dari <span className="font-mono font-semibold text-ink">{totalSheetRows}</span>{' '}
            baris
          </div>
          <div className="flex items-center gap-2">
            <Button
              variant="outline"
              size="md"
              className="h-8 px-2 text-xs"
              disabled={previewPage === 1}
              onClick={() => onPageChange(Math.max(1, previewPage - 1))}
            >
              <ChevronLeft className="h-3.5 w-3.5" />
              <span>Sebelumnya</span>
            </Button>
            <span className="font-mono text-ink">
              {previewPage} / {totalPages}
            </span>
            <Button
              variant="outline"
              size="md"
              className="h-8 px-2 text-xs"
              disabled={previewPage >= totalPages}
              onClick={() => onPageChange(Math.min(totalPages, previewPage + 1))}
            >
              <span>Selanjutnya</span>
              <ChevronRight className="h-3.5 w-3.5" />
            </Button>
          </div>
        </div>
      )}

      {/* Footer */}
      <div className="flex items-center justify-between border-t border-line pt-4">
        <Button variant="outline" onClick={onResetWizard}>
          Kembali
        </Button>
        <Button
          variant="solid"
          disabled={importableRows === 0}
          onClick={onNext}
        >
          Lanjut ke Konfirmasi
        </Button>
      </div>
    </div>
  );
}
