import { CheckCircle2, X } from 'lucide-react';
import Button from '../../../ui/Button';

export default function ResultStep({
  resultData,
  onResetWizard,
  onSwitchToDaftar,
}) {
  return (
    <div className="space-y-6 max-w-2xl mx-auto py-2">
      {/* Header Success */}
      <div className="flex flex-col items-center justify-center text-center space-y-2">
        <div className="h-14 w-14 rounded-full bg-success-tint flex items-center justify-center text-success">
          <CheckCircle2 className="h-8 w-8" />
        </div>
        <h3 className="text-xl font-bold text-ink">Import Selesai</h3>
        <p className="text-xs text-muted max-w-md">
          <strong className="font-mono">{resultData?.importedCount ?? 0}</strong> baris
          berhasil disimpan,{' '}
          <strong className="font-mono">{resultData?.missingCount ?? 0}</strong> di
          antaranya ditandai missing,{' '}
          <strong className="font-mono">{resultData?.rejectedCount ?? 0}</strong> baris
          gagal diimport.
        </p>
      </div>

      {/* 2 Stat Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div className="p-4 border border-success/30 bg-success-tint/20 rounded-xl space-y-1">
          <p className="text-2xl font-bold font-mono text-success">
            {resultData?.importedCount ?? 0}
          </p>
          <p className="text-xs font-semibold text-ink">Baris Sukses</p>
          <p className="text-[11px] text-muted">
            termasuk {resultData?.missingCount ?? 0} baris missing
          </p>
        </div>

        <div className="p-4 border border-danger/30 bg-danger-tint/20 rounded-xl space-y-1">
          <p className="text-2xl font-bold font-mono text-danger">
            {resultData?.rejectedCount ?? 0}
          </p>
          <p className="text-xs font-semibold text-ink">Baris Gagal</p>
        </div>
      </div>

      {/* Rejected rows table (if any) */}
      {resultData?.rejectedRows && resultData.rejectedRows.length > 0 && (
        <div className="space-y-2">
          <h5 className="text-xs font-semibold text-ink">Daftar Baris Ditolak</h5>
          <div className="border border-line rounded-xl overflow-hidden bg-card">
            <table className="w-full text-left text-xs">
              <thead className="border-b border-line bg-page text-muted font-semibold">
                <tr>
                  <th className="px-4 py-2.5">NO</th>
                  <th className="px-4 py-2.5">NIS</th>
                  <th className="px-4 py-2.5">NAMA SISWA</th>
                  <th className="px-4 py-2.5">ALASAN GAGAL</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-line text-ink">
                {resultData.rejectedRows.slice(0, 4).map((row, idx) => {
                  const no = row.row ? row.row - 1 : idx + 1;
                  return (
                    <tr key={idx}>
                      <td className="px-4 py-2 font-mono text-muted">
                        {no}
                      </td>
                      <td className="px-4 py-2 font-mono font-semibold">
                        {row.nis || '-'}
                      </td>
                      <td className="px-4 py-2 font-medium">
                        {row.nama ? (
                          row.nama
                        ) : (
                          <span className="italic text-faint">[Kosong]</span>
                        )}
                      </td>
                      <td className="px-4 py-2 text-danger-text flex items-center gap-1.5">
                        <X className="h-3.5 w-3.5 shrink-0" />
                        <span>{row.message}</span>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
            {resultData.rejectedRows.length > 4 && (
              <div className="px-4 py-2 bg-page/50 border-t border-line text-xs italic text-muted text-center">
                +{resultData.rejectedRows.length - 4} baris lainnya
              </div>
            )}
          </div>
        </div>
      )}

      {/* Footer Actions */}
      <div className="flex flex-col sm:flex-row items-center justify-between gap-3 border-t border-line pt-4">
        <Button
          variant="outline"
          className="w-full sm:w-auto"
          onClick={onResetWizard}
        >
          Import File Lain
        </Button>
        <Button
          variant="solid"
          className="w-full sm:w-auto"
          onClick={onSwitchToDaftar}
        >
          Lihat Daftar Siswa
        </Button>
      </div>
    </div>
  );
}
