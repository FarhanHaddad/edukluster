import { FileSpreadsheet, Check, LoaderCircle } from 'lucide-react';
import Button from '../../../ui/Button';
import { cn } from '../../../../lib/utils';
import { formatFileSize } from './helpers';

export default function ValidationProgress({
  selectedFile,
  validationProgress,
  validationStep,
  onCancelValidation,
}) {
  const checklistItems = [
    'Struktur template & nama sheet',
    'Nama kolom setiap sheet',
    'Identitas siswa (NIS) & duplikasi',
    'Tipe nilai numerik (0-100)',
    'Field wajib identitas',
  ];

  return (
    <div className="space-y-6 max-w-2xl mx-auto py-4">
      {/* File Card */}
      <div className="flex items-center gap-3 p-4 border border-line rounded-xl bg-card">
        <div className="h-10 w-10 rounded-lg bg-brand-tint flex items-center justify-center text-brand">
          <FileSpreadsheet className="h-5 w-5" />
        </div>
        <div>
          <p className="text-sm font-semibold text-ink">{selectedFile?.name}</p>
          <span className="text-xs font-mono text-muted">
            {formatFileSize(selectedFile?.size)}
          </span>
        </div>
      </div>

      {/* Progress status & bar */}
      <div className="space-y-2">
        <div className="flex items-center justify-between text-sm">
          <span className="font-medium text-ink">Memvalidasi template & isi data...</span>
          <span className="font-mono font-semibold text-brand">
            {validationProgress}%
          </span>
        </div>
        <div className="h-2 w-full bg-page rounded-full overflow-hidden border border-line">
          <div
            className="h-full bg-brand transition-all duration-300"
            style={{ width: `${validationProgress}%` }}
          />
        </div>
      </div>

      {/* Progressive Checklist 5 Items */}
      <div className="space-y-3 p-4 rounded-xl border border-line bg-page/40">
        {checklistItems.map((item, idx) => {
          const stepNum = idx + 1;
          const isPassed = validationStep >= stepNum;
          const isCurrent = validationStep === stepNum - 1;

          return (
            <div key={item} className="flex items-center gap-3 text-sm">
              <div
                className={cn(
                  'flex h-5 w-5 items-center justify-center rounded-full text-xs font-semibold',
                  isPassed
                    ? 'bg-success text-on-brand'
                    : isCurrent
                    ? 'bg-brand text-on-brand'
                    : 'border border-line bg-card text-muted'
                )}
              >
                {isPassed ? (
                  <Check className="h-3.5 w-3.5" />
                ) : isCurrent ? (
                  <LoaderCircle className="h-3.5 w-3.5 animate-spin" />
                ) : (
                  <span className="font-mono text-[10px]">{stepNum}</span>
                )}
              </div>
              <span
                className={cn(
                  isPassed
                    ? 'font-medium text-ink'
                    : isCurrent
                    ? 'font-semibold text-brand'
                    : 'text-muted'
                )}
              >
                {item}
              </span>
            </div>
          );
        })}
      </div>

      {/* Footer buttons */}
      <div className="flex items-center justify-between border-t border-line pt-4">
        <Button variant="outline" onClick={onCancelValidation}>
          Batal
        </Button>
        <Button variant="solid" disabled>
          Lanjut
        </Button>
      </div>
    </div>
  );
}
