import { ShieldAlert, Download } from 'lucide-react';
import Button from '../../../ui/Button';
import Badge from '../../../ui/Badge';
import { getHumanLabel } from './helpers';

export default function TemplateFailPanel({
  fatalErrors,
  fatalMessage,
  onResetWizard,
  onDownloadTemplate,
}) {
  return (
    <div className="space-y-6 max-w-2xl mx-auto py-2">
      {/* Panel Merah */}
      <div className="p-5 border border-danger/30 bg-danger-tint/50 rounded-xl space-y-4">
        <div className="flex items-center gap-3 text-danger-text">
          <ShieldAlert className="h-6 w-6 shrink-0" />
          <h4 className="text-base font-semibold">File tidak sesuai template</h4>
        </div>

        {/* Bullet errors */}
        <div className="space-y-2 text-sm text-ink pl-2">
          {fatalErrors && fatalErrors.length > 0 ? (
            fatalErrors.map((err, idx) => (
              <div key={idx} className="flex items-start gap-2">
                <span className="text-danger-text font-bold">•</span>
                <div className="flex flex-wrap items-center gap-1.5">
                  {err.sheet && (
                    <Badge tone="danger" className="font-mono text-xs">
                      Sheet {String(err.sheet).toUpperCase()}
                    </Badge>
                  )}
                  {err.field && (
                    <Badge tone="neutral" className="font-mono text-xs">
                      {getHumanLabel(err.field)}
                    </Badge>
                  )}
                  <span>{err.message || 'Format data tidak valid.'}</span>
                </div>
              </div>
            ))
          ) : (
            <div className="flex items-start gap-2">
              <span className="text-danger-text font-bold">•</span>
              <span>{fatalMessage}</span>
            </div>
          )}
        </div>

        <p className="text-xs text-muted border-t border-danger/20 pt-3">
          Perbaiki struktur file menggunakan template resmi, lalu unggah kembali.
        </p>
      </div>

      {/* Actions */}
      <div className="flex flex-col sm:flex-row items-center gap-3">
        <Button
          variant="solid"
          className="w-full sm:w-auto"
          onClick={onResetWizard}
        >
          Pilih File Lain
        </Button>
        <Button
          variant="outline"
          className="w-full sm:w-auto"
          onClick={onDownloadTemplate}
        >
          <Download className="h-4 w-4" />
          <span>Unduh Template Excel (.xlsx)</span>
        </Button>
      </div>

      {/* Footer */}
      <div className="flex items-center justify-start border-t border-line pt-4">
        <Button variant="outline" onClick={onResetWizard}>
          Kembali ke Upload
        </Button>
      </div>
    </div>
  );
}
