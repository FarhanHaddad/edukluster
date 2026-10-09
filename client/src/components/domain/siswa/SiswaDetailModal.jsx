import { X, ChevronDown } from 'lucide-react';
import Dialog from '../../ui/Dialog';
import Button from '../../ui/Button';
import { MAPPEL } from '../../../lib/constants';
import { useSiswaDetail } from '../../../hooks/useSiswa';

function ReadOnlyField({ label, value, isMono = false }) {
  const displayVal = value !== null && value !== undefined && value !== '' ? value : '-';
  return (
    <div>
      <label className="mb-1 block text-xs font-semibold uppercase tracking-wide text-muted">
        {label}
      </label>
      <div className="flex h-10 w-full items-center rounded-lg border border-line bg-input px-3 text-sm text-ink select-text">
        <span className={isMono ? 'font-mono' : 'font-medium'}>{displayVal}</span>
      </div>
    </div>
  );
}

function ReadOnlyDropdownField({ label, value }) {
  const displayVal = value !== null && value !== undefined && value !== '' ? value : '-';
  return (
    <div>
      <label className="mb-1 block text-xs font-semibold uppercase tracking-wide text-muted">
        {label}
      </label>
      <div className="relative flex h-10 w-full items-center justify-between rounded-lg border border-line bg-input px-3 text-sm text-ink cursor-default select-text">
        <span className="font-medium">{displayVal}</span>
        <ChevronDown size={16} className="text-faint shrink-0" aria-hidden="true" />
      </div>
    </div>
  );
}

export default function SiswaDetailModal({ studentId, open, onClose }) {
  const { data: detailData, isLoading } = useSiswaDetail(open ? studentId : null);

  if (!open) return null;

  const nama = detailData?.nama ?? '...';
  const nis = detailData?.nis ?? '-';
  const kelas = detailData?.kelas ?? '-';
  const sourceType = detailData?.source_type || detailData?.source;
  const sourceLabel = sourceType === 'excel' ? 'Excel' : 'Manual';

  const jkRaw = detailData?.jenis_kelamin;
  const jkLabel = jkRaw === 'L' ? 'Laki-laki' : jkRaw === 'P' ? 'Perempuan' : (jkRaw || '-');

  const nilai = detailData?.nilai ?? {};
  const rapor = nilai.rapor ?? {};
  const pts = nilai.pts ?? {};
  const pas = nilai.pas ?? {};

  const nonAkademik = detailData?.non_akademik ?? detailData?.nonAkademik ?? {};

  return (
    <Dialog
      open={open}
      onClose={onClose}
      className="max-w-2xl p-0 overflow-hidden"
      ariaLabel={`Detail Data Siswa ${nama}`}
    >
      {/* Header */}
      <div className="flex items-start justify-between border-b border-line p-6 bg-card">
        <div className="min-w-0 pr-4">
          <h2 className="text-lg font-semibold text-ink leading-6 truncate">
            Detail Data Siswa: {nama}
          </h2>
          <p className="mt-1 text-sm text-muted">
            NIS: <span className="font-mono text-ink font-medium">{nis}</span> - Kelas{' '}
            <span className="text-ink font-medium">{kelas}</span> - Source:{' '}
            <span className="text-ink font-medium">{sourceLabel}</span>
          </p>
        </div>
        <button
          type="button"
          onClick={onClose}
          className="shrink-0 rounded-lg p-1 text-muted hover:bg-line hover:text-ink transition-colors"
          aria-label="Tutup modal"
        >
          <X size={20} aria-hidden="true" />
        </button>
      </div>

      {/* Body scrollable */}
      <div className="max-h-[65vh] overflow-y-auto p-6 space-y-6 bg-card">
        {isLoading ? (
          <div className="flex min-h-48 items-center justify-center py-12">
            <p className="text-sm font-medium text-muted">Memuat detail siswa...</p>
          </div>
        ) : (
          <>
            {/* SECTION 1: IDENTITAS SISWA */}
            <section className="space-y-3">
              <h3 className="text-xs font-semibold uppercase tracking-wider text-muted">
                IDENTITAS SISWA
              </h3>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <ReadOnlyField label="NIS" value={nis} isMono />
                <ReadOnlyField label="NAMA SISWA" value={nama} />
                <ReadOnlyDropdownField label="KELAS" value={kelas} />
                <ReadOnlyDropdownField label="JENIS KELAMIN" value={jkLabel} />
              </div>
            </section>

            {/* SECTION 2: NILAI AKADEMIK */}
            <section className="space-y-3">
              <div className="flex items-center justify-between">
                <h3 className="text-xs font-semibold uppercase tracking-wider text-muted">
                  NILAI AKADEMIK
                </h3>
                <span className="text-xs font-mono font-semibold text-brand bg-brand-tint px-2 py-0.5 rounded-full">
                  {MAPPEL.length} Mata Pelajaran
                </span>
              </div>

              <div className="overflow-x-auto rounded-lg border border-line">
                <table className="w-full text-left text-sm border-collapse">
                  <thead>
                    <tr className="border-b border-line bg-elevated text-xs font-semibold uppercase tracking-wide text-muted">
                      <th scope="col" className="px-4 py-2.5">MATA PELAJARAN</th>
                      <th scope="col" className="px-4 py-2.5 text-right font-mono">RAPOR</th>
                      <th scope="col" className="px-4 py-2.5 text-right font-mono">PTS</th>
                      <th scope="col" className="px-4 py-2.5 text-right font-mono">PAS</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-line text-ink">
                    {MAPPEL.map((item) => {
                      const valRapor = rapor[item.key] ?? '-';
                      const valPts = pts[item.key] ?? '-';
                      const valPas = pas[item.key] ?? '-';

                      return (
                        <tr key={item.key} className="hover:bg-input/50 transition-colors">
                          <td className="px-4 py-2.5 font-medium">{item.label}</td>
                          <td className="px-4 py-2.5 text-right font-mono">{valRapor}</td>
                          <td className="px-4 py-2.5 text-right font-mono">{valPts}</td>
                          <td className="px-4 py-2.5 text-right font-mono">{valPas}</td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            </section>

            {/* SECTION 3: DATA NON-AKADEMIK */}
            <section className="space-y-3">
              <h3 className="text-xs font-semibold uppercase tracking-wider text-muted">
                DATA NON-AKADEMIK
              </h3>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <ReadOnlyField label="EKSTRAKURIKULER" value={nonAkademik.ekstrakurikuler} />
                <ReadOnlyField label="PRESTASI" value={nonAkademik.prestasi} />
                <ReadOnlyField label="KEMAMPUAN" value={nonAkademik.kemampuan} />
                <ReadOnlyField label="ORGANISASI" value={nonAkademik.organisasi} />
                <ReadOnlyField label="KURSUS" value={nonAkademik.kursus} />
                <div className="hidden sm:block" />
                <ReadOnlyField label="JURUSAN 1" value={nonAkademik.jurusan_1 ?? nonAkademik.jurusan1} />
                <ReadOnlyField label="JURUSAN 2" value={nonAkademik.jurusan_2 ?? nonAkademik.jurusan2} />
              </div>
            </section>
          </>
        )}
      </div>

      {/* Footer */}
      <div className="flex items-center justify-end border-t border-line p-4 bg-card">
        <Button variant="outline" onClick={onClose}>
          Tutup
        </Button>
      </div>
    </Dialog>
  );
}
