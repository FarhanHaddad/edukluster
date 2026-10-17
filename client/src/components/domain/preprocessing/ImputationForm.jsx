import { MAPPEL } from '../../../lib/constants';
import { formatAngka } from '../../../lib/format';
import InfoBanner from '../InfoBanner';

const MAPEL_LABELS = MAPPEL.reduce((acc, item) => {
  acc[item.key] = item.label;
  return acc;
}, {});

const IMPUTATION_OPTIONS = [
  { value: 'mean', label: 'Mean' },
  { value: 'median', label: 'Median' },
  { value: 'mode', label: 'Modus' },
];

export default function ImputationForm({
  academicMissing = [],
  register,
  watch,
  errors = {},
}) {
  const selectedMethod = watch('imputationMethod') || 'mean';

  return (
    <div className="space-y-6">
      <div>
        <h3 className="text-base font-semibold text-ink">
          Imputasi Missing Values (Akademik)
        </h3>
        <p className="mt-1 text-sm text-muted">
          Pilih metode imputasi global untuk mengisi nilai akademik 18 mata pelajaran yang kosong.
        </p>
      </div>

      <InfoBanner>
        Metode ini akan diterapkan secara global (lintas kelas) untuk mengisi nilai akademik yang kosong.
      </InfoBanner>

      {/* Radio Group Global */}
      <div className="space-y-3">
        <div>
          <span className="text-xs font-semibold uppercase tracking-wider text-muted">
            METODE IMPUTASI
          </span>
          <p className="mt-0.5 text-xs text-muted">
            Berlaku global untuk semua kolom nilai mata pelajaran yang kosong.
          </p>
        </div>

        <div className="flex flex-wrap items-center gap-6">
          {IMPUTATION_OPTIONS.map((opt) => {
            const isChecked = selectedMethod === opt.value;
            return (
              <label
                key={opt.value}
                className="flex cursor-pointer items-center gap-2.5 select-none"
              >
                <input
                  type="radio"
                  value={opt.value}
                  {...register('imputationMethod', { required: 'Metode imputasi wajib dipilih' })}
                  className="sr-only peer"
                />
                <div className={`flex size-4 items-center justify-center rounded-full border transition-all ${
                  isChecked
                    ? 'border-brand bg-brand'
                    : 'border-line bg-card'
                }`}>
                  {isChecked && <div className="size-1.5 rounded-full bg-on-brand" />}
                </div>
                <span className={`text-sm font-medium ${
                  isChecked ? 'font-semibold text-ink' : 'text-muted'
                }`}>
                  {opt.label}
                </span>
              </label>
            );
          })}
        </div>
        {errors.imputationMethod && (
          <p className="text-xs text-danger">{errors.imputationMethod.message}</p>
        )}
      </div>

      {/* Tabel Statistik Missing */}
      <div className="space-y-2">
        <h4 className="text-sm font-semibold text-ink">
          Statistik Nilai Kosong (18 Mapel Akademik)
        </h4>

        <div className="max-h-64 overflow-y-auto rounded-lg border border-line bg-card">
          <table className="w-full border-collapse text-left text-sm">
            <thead className="sticky top-0 z-10 bg-page border-b border-line">
              <tr>
                <th className="px-4 py-2.5 text-xs font-semibold uppercase text-muted w-12">
                  NO
                </th>
                <th className="px-4 py-2.5 text-xs font-semibold uppercase text-muted">
                  NAMA MAPEL
                </th>
                <th className="px-4 py-2.5 text-xs font-semibold uppercase text-muted text-right">
                  JUMLAH KOSONG
                </th>
                <th className="px-4 py-2.5 text-xs font-semibold uppercase text-muted text-right">
                  PERSENTASE
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-line text-ink">
              {academicMissing.length === 0 ? (
                <tr>
                  <td colSpan={4} className="px-4 py-6 text-center text-xs text-muted">
                    Tidak ada data statistik nilai kosong.
                  </td>
                </tr>
              ) : (
                academicMissing.map((item, index) => {
                  const label = MAPEL_LABELS[item.fieldName] || item.fieldName;
                  const missing = item.missingCount ?? 0;
                  const total = item.totalCount ?? 0;
                  const percentage = total > 0 ? ((missing / total) * 100).toFixed(1) : '0.0';

                  return (
                    <tr key={item.fieldName || index} className="hover:bg-page/50">
                      <td className="px-4 py-2.5 font-mono text-xs text-muted">
                        {index + 1}
                      </td>
                      <td className="px-4 py-2.5 font-medium text-sm">
                        {label}
                      </td>
                      <td className="px-4 py-2.5 font-mono text-xs text-right text-ink">
                        {formatAngka(missing)} baris
                      </td>
                      <td className="px-4 py-2.5 font-mono text-xs text-right font-medium text-ink">
                        {percentage}%
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
