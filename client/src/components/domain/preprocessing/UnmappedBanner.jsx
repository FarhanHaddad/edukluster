import { useState } from 'react';
import { AlertTriangle, Plus, Check } from 'lucide-react';
import Button from '../../ui/Button';
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

export default function UnmappedBanner({ fields = [], onCreateOption, onSaveAssignments, isSubmitting = false }) {
  const unmappedFields = fields.filter((f) => (f.unmapped ?? []).length > 0);
  const [selectedItems, setSelectedItems] = useState({});
  const [activeNewForm, setActiveNewForm] = useState(null);
  const [newFormState, setNewFormState] = useState({ name: '', code: '' });
  const [inlineError, setInlineError] = useState(null);

  if (unmappedFields.length === 0) return null;

  const handleToggleSelect = (fieldName, val) => {
    setSelectedItems((prev) => {
      const list = prev[fieldName] ?? [];
      const updated = list.includes(val) ? list.filter((i) => i !== val) : [...list, val];
      return { ...prev, [fieldName]: updated };
    });
  };

  const handleSelectAll = (fieldItem) => {
    const fn = fieldItem.fieldName;
    const allVals = (fieldItem.unmapped ?? []).map((u) => u.standardValue);
    const curr = selectedItems[fn] ?? [];
    setSelectedItems((prev) => ({ ...prev, [fn]: curr.length === allVals.length ? [] : allVals }));
  };

  const handleOpenNewForm = (fieldItem) => {
    const codes = (fieldItem.options ?? []).map((o) => o.code).filter((c) => c != null);
    setActiveNewForm(fieldItem.fieldName);
    setNewFormState({ name: '', code: String(codes.length > 0 ? Math.max(...codes) + 1 : 1) });
    setInlineError(null);
  };

  const handleCloseNewForm = () => {
    setActiveNewForm(null);
    setNewFormState({ name: '', code: '' });
    setInlineError(null);
  };

  const handleSaveNewBidang = async (fieldItem) => {
    setInlineError(null);
    const fn = fieldItem.fieldName;
    const nameTrimmed = newFormState.name.trim();

    if (!nameTrimmed) return setInlineError('Nama bidang tidak boleh kosong.');
    const selectedVals = selectedItems[fn] ?? [];
    if (selectedVals.length === 0) return setInlineError('Pilih setidaknya satu nilai untuk dipetakan.');

    try {
      const newOpt = await onCreateOption?.({
        fieldName: fn,
        name: nameTrimmed,
        code: newFormState.code !== '' ? Number(newFormState.code) : undefined,
      });

      if (newOpt?.id) {
        await onSaveAssignments?.({ fieldName: fn, optionId: newOpt.id, standardValues: selectedVals });
        setSelectedItems((prev) => ({ ...prev, [fn]: [] }));
        handleCloseNewForm();
      }
    } catch (err) {
      setInlineError(err.response?.data?.message || 'Gagal membuat bidang baru.');
    }
  };

  const handleMapToOption = async (fieldName, optionId) => {
    const selectedVals = selectedItems[fieldName] ?? [];
    if (selectedVals.length === 0) return;
    try {
      await onSaveAssignments?.({ fieldName, optionId, standardValues: selectedVals });
      setSelectedItems((prev) => ({ ...prev, [fieldName]: [] }));
    } catch (err) {
      /* handled */
    }
  };

  return (
    <div className="rounded-lg border border-warning/40 bg-warning-tint/30 p-5 space-y-5">
      <div className="flex items-start gap-3">
        <div className="flex size-9 shrink-0 items-center justify-center rounded-full bg-warning-tint text-warning">
          <AlertTriangle size={18} aria-hidden="true" />
        </div>
        <div>
          <h3 className="text-base font-semibold text-ink">Nilai Belum Terpetakan</h3>
          <p className="mt-0.5 text-sm text-muted">
            Beberapa nilai non-akademik hasil cleaning belum terpetakan. Petakan nilai baru di bawah ini sebelum melanjutkan.
          </p>
        </div>
      </div>

      <div className="space-y-6 pt-2">
        {unmappedFields.map((fieldItem) => {
          const fn = fieldItem.fieldName;
          const label = FIELD_LABELS[fn] || fn;
          const unmappedList = fieldItem.unmapped ?? [];
          const options = fieldItem.options ?? [];
          const currentSelected = selectedItems[fn] ?? [];
          const hasSelected = currentSelected.length > 0;
          const isAllSelected = unmappedList.length > 0 && currentSelected.length === unmappedList.length;
          const isFormOpen = activeNewForm === fn;

          return (
            <div key={fn} className="rounded-lg border border-line bg-card p-4 space-y-4 shadow-sm">
              <div className="flex flex-wrap items-center justify-between gap-2 border-b border-line pb-3">
                <div className="flex items-center gap-2">
                  <span className="text-sm font-semibold text-ink">{label}</span>
                  <span className="rounded-full bg-warning-tint px-2 py-0.5 text-xs font-semibold text-warning">
                    {formatAngka(unmappedList.length)} Belum Terpetakan
                  </span>
                </div>
                <Button variant="outline" size="md" onClick={() => handleSelectAll(fieldItem)} className="h-8 px-3 text-xs">
                  {isAllSelected ? 'Batal Centang Semua' : 'Centang Semua'}
                </Button>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-2">
                {unmappedList.map((item) => {
                  const val = item.standardValue;
                  const isChecked = currentSelected.includes(val);
                  return (
                    <label
                      key={val}
                      className={`flex items-center justify-between gap-2 rounded-lg border p-2.5 text-xs cursor-pointer transition-colors ${
                        isChecked ? 'border-brand bg-brand-tint/20 text-ink' : 'border-line bg-page hover:bg-page/80 text-ink'
                      }`}
                    >
                      <div className="flex items-center gap-2 min-w-0">
                        <input
                          type="checkbox"
                          checked={isChecked}
                          onChange={() => handleToggleSelect(fn, val)}
                          className="size-4 rounded border-line text-brand focus:ring-brand"
                        />
                        <span className="truncate font-medium">{item.label ?? val}</span>
                      </div>
                      <span className="font-mono text-muted shrink-0">({formatAngka(item.count)})</span>
                    </label>
                  );
                })}
              </div>

              {hasSelected && (
                <div className="space-y-3 rounded-lg border border-brand/30 bg-brand-tint/10 p-3 pt-3">
                  <div className="flex flex-wrap items-center justify-between gap-2">
                    <span className="text-xs font-semibold text-brand">
                      {currentSelected.length} nilai dipilih &rarr; Petakan ke:
                    </span>
                    {!isFormOpen && (
                      <Button variant="emphasis" size="md" onClick={() => handleOpenNewForm(fieldItem)} className="h-8 px-3 text-xs">
                        <Plus size={14} />
                        <span>Buat Bidang Baru</span>
                      </Button>
                    )}
                  </div>

                  {!isFormOpen && options.length > 0 && (
                    <div className="flex flex-wrap gap-2 pt-1">
                      {options.map((opt) => (
                        <button
                          key={opt.id}
                          type="button"
                          onClick={() => handleMapToOption(fn, opt.id)}
                          disabled={isSubmitting}
                          className="inline-flex items-center gap-1.5 rounded-lg border border-line bg-card px-3 py-1.5 text-xs font-semibold text-ink transition-colors hover:border-brand hover:bg-brand-tint hover:text-brand disabled:opacity-50"
                        >
                          <span>{opt.name}</span>
                          <span className="font-mono text-[10px] text-muted">(Kode {opt.code})</span>
                        </button>
                      ))}
                    </div>
                  )}

                  {isFormOpen && (
                    <div className="mt-2 space-y-3 rounded-lg border border-line bg-card p-4">
                      <h4 className="text-xs font-semibold text-ink uppercase tracking-wider">Form Bidang Baru ({label})</h4>
                      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
                        <div className="sm:col-span-2 space-y-1">
                          <label className="text-xs font-medium text-muted">Nama Bidang <span className="text-danger">*</span></label>
                          <input
                            type="text"
                            placeholder="Mis. Keagamaan"
                            value={newFormState.name}
                            onChange={(e) => setNewFormState((prev) => ({ ...prev, name: e.target.value }))}
                            className="h-9 w-full rounded-lg border border-line bg-card px-3 text-xs text-ink outline-none focus:border-brand"
                          />
                        </div>
                        <div className="space-y-1">
                          <label className="text-xs font-medium text-muted">Kode (Auto-suggest)</label>
                          <input
                            type="number"
                            value={newFormState.code}
                            onChange={(e) => setNewFormState((prev) => ({ ...prev, code: e.target.value }))}
                            className="h-9 w-full font-mono font-medium rounded-lg border border-line bg-card px-3 text-xs text-ink outline-none focus:border-brand"
                          />
                        </div>
                      </div>
                      {inlineError && <p className="text-xs font-medium text-danger">{inlineError}</p>}
                      <div className="flex justify-end gap-2 pt-1">
                        <Button variant="outline" size="md" onClick={handleCloseNewForm} disabled={isSubmitting} className="h-8 px-3 text-xs">
                          Batal
                        </Button>
                        <Button variant="solid" size="md" onClick={() => handleSaveNewBidang(fieldItem)} disabled={isSubmitting} className="h-8 px-3 text-xs">
                          <Check size={14} />
                          <span>Simpan &amp; Petakan</span>
                        </Button>
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}
