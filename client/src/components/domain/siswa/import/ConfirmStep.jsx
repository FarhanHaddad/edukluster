import { AlertTriangle, LoaderCircle } from 'lucide-react';
import Button from '../../../ui/Button';
import Badge from '../../../ui/Badge';

export default function ConfirmStep({
  previewData,
  selectedFile,
  consentChecked,
  isConfirming,
  onConsentChange,
  onBack,
  onConfirm,
}) {
  const summary = previewData?.summary || {};
  const totalRows = summary.totalRows ?? 0;
  const validRows = summary.validRows ?? 0;
  const missingRows = summary.missingRows ?? 0;
  const errorRows = summary.errorRows ?? 0;
  const importableRows = summary.importableRows ?? 0;

  return (
    <div className="space-y-6 max-w-2xl mx-auto py-2">
      {/* Card Ringkasan */}
      <div className="p-5 border border-line rounded-xl bg-card space-y-4">
        <h4 className="text-base font-semibold text-ink">Ringkasan Import Data</h4>

        <div className="space-y-2.5 text-sm divide-y divide-line">
          <div className="flex justify-between pt-1">
            <span className="text-muted">Nama File</span>
            <span className="font-semibold text-ink">
              {previewData?.fileName || selectedFile?.name}
            </span>
          </div>
          <div className="flex justify-between pt-2">
            <span className="text-muted">Total Baris Terbaca</span>
            <span className="font-mono font-semibold text-ink">{totalRows}</span>
          </div>
          <div className="flex justify-between pt-2">
            <span className="text-muted">Baris Akan Diimport</span>
            <div className="text-right">
              <span className="font-mono font-bold text-success">
                {importableRows}
              </span>{' '}
              <span className="text-xs text-muted">
                ({validRows} valid + {missingRows} missing ditandai)
              </span>
            </div>
          </div>
          <div className="flex justify-between pt-2">
            <span className="text-muted">Baris Ditolak</span>
            <div>
              <span className="font-mono font-bold text-danger">{errorRows}</span>{' '}
              <span className="text-xs text-muted">(error)</span>
            </div>
          </div>
          <div className="flex justify-between pt-2">
            <span className="text-muted">Source Data</span>
            <div className="flex items-center gap-1.5">
              <Badge tone="brand">Excel</Badge>
              <span className="text-xs font-mono text-muted">
                (source_type = excel_import)
              </span>
            </div>
          </div>
        </div>
      </div>

      {/* Banner Amber Warning */}
      <div className="p-4 border border-warning/30 bg-warning-tint/30 rounded-xl flex items-start gap-3 text-xs text-ink">
        <AlertTriangle className="h-5 w-5 text-warning shrink-0 mt-0.5" />
        <div>
          <strong className="font-semibold">Perhatian:</strong> Baris error tidak akan
          diimport. Baris missing akan diimputasi pada tahap Cleaning. Perbaiki file
          lalu ulangi import untuk menambahkan baris error.
        </div>
      </div>

      {/* Checkbox Consent */}
      <label className="flex items-start gap-3 p-4 border border-line rounded-xl bg-page/50 cursor-pointer select-none">
        <input
          type="checkbox"
          checked={consentChecked}
          onChange={(e) => onConsentChange(e.target.checked)}
          className="mt-0.5 h-4 w-4 rounded border-line text-brand focus:ring-brand"
        />
        <span className="text-xs font-medium text-ink leading-relaxed">
          Saya sudah memeriksa preview dan menyetujui import{' '}
          <strong className="font-mono">{importableRows}</strong> baris data siswa.
        </span>
      </label>

      {/* Footer */}
      <div className="flex items-center justify-between border-t border-line pt-4">
        <Button variant="outline" onClick={onBack}>
          Kembali
        </Button>
        <Button
          variant="solid"
          disabled={!consentChecked || isConfirming}
          onClick={onConfirm}
        >
          {isConfirming ? (
            <div className="flex items-center gap-2">
              <LoaderCircle className="h-4 w-4 animate-spin" />
              <span>Mengimport Data...</span>
            </div>
          ) : (
            <span>Import {importableRows} Baris Data</span>
          )}
        </Button>
      </div>
    </div>
  );
}
