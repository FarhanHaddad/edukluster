import { useRef } from 'react';
import { UploadCloud, FileSpreadsheet, X, Download, AlertCircle } from 'lucide-react';
import Button from '../../../ui/Button';
import { SHEET_NAMES, formatFileSize } from './helpers';

export default function UploadStep({
  selectedFile,
  preCheckError,
  onFileSelect,
  onFileRemove,
  onDownloadTemplate,
  onResetWizard,
  onStartValidation,
}) {
  const fileInputRef = useRef(null);

  const handleDragOver = (e) => {
    e.preventDefault();
    e.stopPropagation();
  };

  const handleDrop = (e) => {
    e.preventDefault();
    e.stopPropagation();
    if (e.dataTransfer.files && e.dataTransfer.files[0]) {
      onFileSelect(e.dataTransfer.files[0]);
    }
  };

  return (
    <div className="space-y-6 max-w-3xl mx-auto">
      {!selectedFile ? (
        /* Dropzone Kosong */
        <div
          onClick={() => fileInputRef.current?.click()}
          onDragOver={handleDragOver}
          onDrop={handleDrop}
          className="flex flex-col items-center justify-center p-8 border-2 border-dashed border-line rounded-xl bg-page/50 hover:bg-page hover:border-brand/50 transition-colors cursor-pointer text-center"
        >
          <input
            ref={fileInputRef}
            type="file"
            accept=".xlsx"
            className="hidden"
            onChange={(e) => {
              onFileSelect(e.target.files?.[0]);
              if (fileInputRef.current) fileInputRef.current.value = '';
            }}
          />
          <div className="h-12 w-12 rounded-full bg-brand-tint flex items-center justify-center text-brand mb-3">
            <UploadCloud className="h-6 w-6" />
          </div>
          <p className="text-base font-semibold text-ink">
            Tarik & letakkan file Excel di sini
          </p>
          <p className="text-xs text-muted mt-1">atau</p>
          <Button variant="outline" size="md" className="mt-3">
            Pilih File
          </Button>
        </div>
      ) : (
        /* X2: File Card */
        <div className="flex items-center justify-between p-4 border border-line rounded-xl bg-card">
          <div className="flex items-center gap-3">
            <div className="h-10 w-10 rounded-lg bg-brand-tint flex items-center justify-center text-brand">
              <FileSpreadsheet className="h-5 w-5" />
            </div>
            <div>
              <p className="text-sm font-semibold text-ink">{selectedFile.name}</p>
              <span className="text-xs font-mono text-muted">
                {formatFileSize(selectedFile.size)}
              </span>
            </div>
          </div>
          <button
            type="button"
            onClick={onFileRemove}
            className="p-1 rounded-lg hover:bg-page text-muted hover:text-ink transition-colors"
            aria-label="Hapus file"
          >
            <X className="h-5 w-5" />
          </button>
        </div>
      )}

      {/* Inline Pre-Check Error Message */}
      {preCheckError && (
        <div className="flex items-center gap-2 p-3 rounded-lg bg-danger-tint text-danger-text text-sm font-medium">
          <AlertCircle className="h-4 w-4 shrink-0" />
          <span>{preCheckError}</span>
        </div>
      )}

      {/* Hint & Template Link */}
      <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 text-xs text-muted border-t border-line pt-4">
        <div>
          Format <span className="font-mono font-semibold text-ink">.xlsx</span> • 4 sheet:{' '}
          <span className="font-mono font-semibold text-ink">
            RAPOR, PTS, PAS, NON-AKADEMIK
          </span>{' '}
          • Maks 5 MB
        </div>
        <button
          type="button"
          onClick={onDownloadTemplate}
          className="flex items-center gap-1.5 font-semibold text-brand hover:underline"
        >
          <Download className="h-3.5 w-3.5" />
          <span>Unduh Template Excel (.xlsx)</span>
        </button>
      </div>

      {/* 4 Info Chips Statis */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        {SHEET_NAMES.map((s) => (
          <div
            key={s}
            className="flex items-center gap-2 p-2.5 rounded-lg border border-line bg-page/50 text-xs text-ink"
          >
            <span className="h-2 w-2 rounded-full bg-faint" />
            <span className="font-mono font-semibold">Sheet {s}</span>
          </div>
        ))}
      </div>

      {/* Footer buttons (X3) */}
      <div className="flex items-center justify-between border-t border-line pt-4">
        <Button variant="outline" onClick={onResetWizard}>
          Batal
        </Button>
        <Button
          variant="solid"
          disabled={!selectedFile}
          onClick={onStartValidation}
        >
          Lanjut
        </Button>
      </div>
    </div>
  );
}
