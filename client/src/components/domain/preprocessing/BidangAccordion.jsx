import { useState } from 'react';
import { ChevronDown, ChevronUp, Trash2, AlertTriangle } from 'lucide-react';
import Button from '../../ui/Button';
import Dialog from '../../ui/Dialog';
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

export default function BidangAccordion({
  fields = [],
  onDeleteOption,
  isDeleting = false,
}) {
  const [openFields, setOpenFields] = useState(() => {
    const initial = {};
    fields.forEach((f) => {
      initial[f.fieldName] = true;
    });
    return initial;
  });

  const [deleteDialog, setDeleteDialog] = useState({
    open: false,
    option: null,
    fieldName: null,
  });

  const toggleField = (fieldName) => {
    setOpenFields((prev) => ({
      ...prev,
      [fieldName]: !prev[fieldName],
    }));
  };

  const handleDeleteClick = (fieldName, option) => {
    setDeleteDialog({
      open: true,
      option,
      fieldName,
    });
  };

  const handleConfirmDelete = async () => {
    if (!deleteDialog.option) return;
    const optionId = deleteDialog.option.id;
    setDeleteDialog({ open: false, option: null, fieldName: null });
    await onDeleteOption?.(optionId);
  };

  return (
    <div className="space-y-4">
      {fields.map((fieldItem) => {
        const fieldName = fieldItem.fieldName;
        const label = FIELD_LABELS[fieldName] || fieldName;
        const options = fieldItem.options ?? [];
        const isOpen = openFields[fieldName] ?? true;

        const codes = options.map((o) => o.code).filter((c) => c != null);
        const minCode = codes.length > 0 ? Math.min(...codes) : 0;
        const maxCode = codes.length > 0 ? Math.max(...codes) : 0;
        const codeRange = codes.length > 0 ? `${minCode} - ${maxCode}` : 'Kosong';

        return (
          <div
            key={fieldName}
            className="rounded-lg border border-line bg-card shadow-sm transition-all"
          >
            <button
              type="button"
              onClick={() => toggleField(fieldName)}
              className="flex w-full items-center justify-between px-5 py-4 text-left font-semibold text-ink hover:bg-page/50 rounded-lg outline-none"
            >
              <div className="flex items-center gap-3">
                <span className="text-base font-semibold text-ink">{label}</span>
                <span className="text-xs text-muted">&bull;</span>
                <span className="text-xs text-muted font-medium">
                  {formatAngka(options.length)} bidang
                </span>
                <span className="rounded-full bg-brand-tint px-2.5 py-0.5 text-xs font-mono font-medium text-brand">
                  Kode: {codeRange}
                </span>
              </div>
              <div className="text-muted hover:text-ink">
                {isOpen ? <ChevronUp size={18} /> : <ChevronDown size={18} />}
              </div>
            </button>

            {isOpen && (
              <div className="border-t border-line px-5 py-4">
                <div className="overflow-x-auto rounded-lg border border-line bg-card">
                  <table className="w-full border-collapse text-left text-sm">
                    <thead className="bg-page border-b border-line">
                      <tr>
                        <th className="px-3 py-2 text-xs font-semibold uppercase text-muted w-12">
                          NO
                        </th>
                        <th className="px-3 py-2 text-xs font-semibold uppercase text-muted">
                          BIDANG
                        </th>
                        <th className="px-3 py-2 text-xs font-semibold uppercase text-muted">
                          CONTOH NILAI ASLI
                        </th>
                        <th className="px-3 py-2 text-xs font-semibold uppercase text-muted w-24">
                          KODE
                        </th>
                        <th className="px-3 py-2 text-xs font-semibold uppercase text-muted text-right w-16">
                          AKSI
                        </th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-line text-ink">
                      {options.length === 0 ? (
                        <tr>
                          <td colSpan={5} className="px-3 py-4 text-center text-xs text-muted">
                            Belum ada bidang tersimpan.
                          </td>
                        </tr>
                      ) : (
                        options.map((opt, idx) => {
                          const assigned = opt.assignedValues ?? [];
                          return (
                            <tr key={opt.id || idx} className="hover:bg-page/50">
                              <td className="px-3 py-2 font-mono text-xs text-muted">
                                {idx + 1}
                              </td>
                              <td className="px-3 py-2 font-medium text-ink">
                                {opt.name}
                              </td>
                              <td className="px-3 py-2">
                                <div className="flex flex-wrap gap-1.5">
                                  {assigned.length === 0 ? (
                                    <span className="text-xs text-muted font-normal italic">
                                      Belum ada nilai terpetakan
                                    </span>
                                  ) : (
                                    assigned.map((a, aIdx) => (
                                      <span
                                        key={aIdx}
                                        className="inline-flex items-center gap-1 rounded bg-page border border-line px-2 py-0.5 text-xs text-ink"
                                      >
                                        <span>{a.standardValue}</span>
                                        <span className="font-mono text-[10px] text-muted">
                                          ({formatAngka(a.count)})
                                        </span>
                                      </span>
                                    ))
                                  )}
                                </div>
                              </td>
                              <td className="px-3 py-2 font-mono text-xs text-ink">
                                {opt.code}
                              </td>
                              <td className="px-3 py-2 text-right">
                                <button
                                  type="button"
                                  onClick={() => handleDeleteClick(fieldName, opt)}
                                  disabled={isDeleting}
                                  title="Hapus bidang"
                                  aria-label={`Hapus bidang ${opt.name}`}
                                  className="inline-flex size-8 items-center justify-center rounded-lg text-muted transition-colors hover:bg-danger-tint hover:text-danger disabled:opacity-50"
                                >
                                  <Trash2 size={16} />
                                </button>
                              </td>
                            </tr>
                          );
                        })
                      )}
                    </tbody>
                  </table>
                </div>
              </div>
            )}
          </div>
        );
      })}

      {/* Dialog Konfirmasi Hapus Bidang */}
      <Dialog
        open={deleteDialog.open}
        onClose={() => setDeleteDialog({ open: false, option: null, fieldName: null })}
        labelledBy="dialog-delete-bidang-title"
      >
        <div className="space-y-4">
          <div className="flex items-center gap-3">
            <div className="flex size-10 items-center justify-center rounded-full bg-danger-tint text-danger">
              <AlertTriangle size={20} aria-hidden="true" />
            </div>
            <h3 id="dialog-delete-bidang-title" className="text-base font-semibold text-ink">
              Hapus Bidang &quot;{deleteDialog.option?.name}&quot;?
            </h3>
          </div>

          <p className="text-sm text-muted leading-relaxed">
            Menghapus bidang akan mengembalikan nilainya ke belum terpetakan dan mereset Transformasi &amp; Reduksi bila sudah dijalankan.
          </p>

          <div className="flex justify-end gap-3 pt-2">
            <Button
              variant="outline"
              onClick={() => setDeleteDialog({ open: false, option: null, fieldName: null })}
              disabled={isDeleting}
            >
              Batal
            </Button>

            <Button
              variant="destructive"
              onClick={handleConfirmDelete}
              disabled={isDeleting}
            >
              {isDeleting ? 'Menghapus...' : 'Hapus Bidang'}
            </Button>
          </div>
        </div>
      </Dialog>
    </div>
  );
}
