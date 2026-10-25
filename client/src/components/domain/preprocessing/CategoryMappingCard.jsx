import { useState } from 'react';
import { ChevronDown, ChevronUp } from 'lucide-react';
import { formatAngka } from '../../../lib/format';

const FIELD_LABELS = {
  ekstrakurikuler: 'Ekstrakurikuler',
  prestasi: 'Prestasi',
  kemampuan: 'Kemampuan',
  organisasi: 'Organisasi',
  kursus: 'Kursus',
  jurusan_1: 'Jurusan 1',
  jurusan_2: 'Jurusan 2',
};

export default function CategoryMappingCard({
  fieldData,
  register,
  errors = {},
}) {
  const [isOpen, setIsOpen] = useState(true);

  const fieldName = fieldData?.fieldName ?? '';
  const label = FIELD_LABELS[fieldName] || fieldName;
  const rawDistribution = fieldData?.rawDistribution ?? [];
  const mappings = fieldData?.mappings ?? [];

  const fieldErrors = errors?.mappings?.[fieldName] || {};

  return (
    <div className="rounded-lg border border-line bg-card shadow-sm transition-all">
      {/* Header Accordion */}
      <button
        type="button"
        onClick={() => setIsOpen((prev) => !prev)}
        className="flex w-full items-center justify-between px-5 py-4 text-left font-semibold text-ink hover:bg-page/50 rounded-lg outline-none"
      >
        <div className="flex items-center gap-3">
          <span className="text-base font-semibold text-ink">{label}</span>
          <span className="rounded-full bg-brand-tint px-2.5 py-0.5 text-xs font-semibold text-brand">
            {formatAngka(rawDistribution.length)} Variasi Nilai
          </span>
        </div>
        <div className="text-muted hover:text-ink">
          {isOpen ? <ChevronUp size={18} /> : <ChevronDown size={18} />}
        </div>
      </button>

      {/* Accordion Content */}
      {isOpen && (
        <div className="border-t border-line px-5 py-4 space-y-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {/* Tabel Sebaran Nilai Asli (Read-only) */}
            <div className="space-y-2">
              <h4 className="text-xs font-semibold uppercase tracking-wider text-muted">
                1. Tabel Sebaran Nilai Asli (Read-Only)
              </h4>

              <div className="max-h-60 overflow-y-auto rounded-lg border border-line bg-card">
                <table className="w-full border-collapse text-left text-sm">
                  <thead className="sticky top-0 z-10 bg-page border-b border-line">
                    <tr>
                      <th className="px-3 py-2 text-xs font-semibold uppercase text-muted w-10">
                        NO
                      </th>
                      <th className="px-3 py-2 text-xs font-semibold uppercase text-muted">
                        NILAI ASLI
                      </th>
                      <th className="px-3 py-2 text-xs font-semibold uppercase text-muted text-right">
                        JUMLAH
                      </th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-line text-ink">
                    {rawDistribution.length === 0 ? (
                      <tr>
                        <td colSpan={3} className="px-3 py-4 text-center text-xs text-muted">
                          Tidak ada sebaran data.
                        </td>
                      </tr>
                    ) : (
                      rawDistribution.map((item, index) => (
                        <tr key={item.rawValue || index} className="hover:bg-page/50">
                          <td className="px-3 py-2 font-mono text-xs text-muted">
                            {index + 1}
                          </td>
                          <td className="px-3 py-2">
                            <span className="inline-block rounded bg-page border border-line px-2 py-0.5 font-mono text-xs text-ink">
                              {item.label ?? item.rawValue}
                            </span>
                          </td>
                          <td className="px-3 py-2 font-mono text-xs text-right font-medium text-ink">
                            {formatAngka(item.count)}
                          </td>
                        </tr>
                      ))
                    )}
                  </tbody>
                </table>
              </div>
            </div>

            {/* Tabel Mapping (Editable) */}
            <div className="space-y-2">
              <h4 className="text-xs font-semibold uppercase tracking-wider text-muted">
                2. Tabel Mapping Standardisasi (Editable)
              </h4>

              <div className="max-h-60 overflow-y-auto rounded-lg border border-line bg-card">
                <table className="w-full border-collapse text-left text-sm">
                  <thead className="sticky top-0 z-10 bg-page border-b border-line">
                    <tr>
                      <th className="px-3 py-2 text-xs font-semibold uppercase text-muted w-10">
                        NO
                      </th>
                      <th className="px-3 py-2 text-xs font-semibold uppercase text-muted">
                        NILAI ASLI
                      </th>
                      <th className="px-3 py-2 text-xs font-semibold uppercase text-muted">
                        NILAI STANDAR
                      </th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-line text-ink">
                    {mappings.length === 0 ? (
                      <tr>
                        <td colSpan={3} className="px-3 py-4 text-center text-xs text-muted">
                          Tidak ada data mapping.
                        </td>
                      </tr>
                    ) : (
                      mappings.map((item, index) => {
                        const rawVal = item.rawValue;
                        const inputErr = fieldErrors?.[rawVal];

                        return (
                          <tr key={rawVal || index} className="hover:bg-page/50">
                            <td className="px-3 py-2 font-mono text-xs text-muted">
                              {index + 1}
                            </td>
                            <td className="px-3 py-2">
                              <span className="inline-block rounded bg-page border border-line px-2 py-0.5 font-mono text-xs text-ink">
                                {item.label ?? rawVal}
                              </span>
                            </td>
                            <td className="px-3 py-2">
                              <div className="space-y-1">
                                <input
                                  type="text"
                                  defaultValue={item.standardValue ?? rawVal}
                                  {...register(`mappings.${fieldName}.${rawVal}`, {
                                    required: 'Nilai standar tidak boleh kosong',
                                    validate: (v) =>
                                      (v && v.trim() !== '') || 'Nilai standar tidak boleh berupa spasi saja',
                                  })}
                                  className={`h-9 w-full rounded-lg border bg-card px-3 text-sm text-ink outline-none transition-all focus:border-brand ${
                                    inputErr ? 'border-danger' : 'border-line'
                                  }`}
                                />
                                {inputErr && (
                                  <p className="text-xs text-danger">{inputErr.message}</p>
                                )}
                              </div>
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
          <p className="text-xs text-muted">
            Catatan: Pre-fill &apos;Nilai Standar&apos; diambil dari nilai asli/saran sistem. Silakan sesuaikan bila terdapat variasi penulisan.
          </p>
        </div>
      )}
    </div>
  );
}
