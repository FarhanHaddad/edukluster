import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { CalendarDays, Info, X } from 'lucide-react';
import Dialog from '../ui/Dialog';
import Button from '../ui/Button';
import { FieldLabel, inputClass } from '../ui/Field';
import useCreatePeriode from '../../hooks/useCreatePeriode';

// Kontrak validasi FE — regex SAMA dengan server/http/periode.rest blok 5
// (tahunAjaran "YYYY/YYYY", semester enum GANJIL|GENAP).
const schema = z.object({
  tahunAjaran: z
    .string()
    .regex(/^\d{4}\/\d{4}$/, 'Format tahun ajaran harus 2026/2027.'),
  semester: z.enum(['GANJIL', 'GENAP'], { message: 'Pilih semester.' }),
});

const DEFAULT_VALUES = { tahunAjaran: '', semester: '' };

// Helper text permanen tiap field (frame 3B rev2) — TETAP kelihatan walau error
// muncul (pengecualian rev2 atas aturan "hide helper on error" DESIGN.md; pesan
// API 409 tampil VERBATIM di bawah helper).
const HELPERS = {
  tahunAjaran: 'Format: tahun awal/tahun akhir, misal 2025/2026.',
  semester: null,
};

// Dialog buat periode baru (frame 3B rev2): ikon kalender + judul + subtitle + X,
// dua field wajib, info note kombinasi unik, footer Batal + Simpan.
export default function CreatePeriodeDialog({ open, onClose }) {
  const mutation = useCreatePeriode();
  const {
    register,
    handleSubmit,
    setError,
    clearErrors,
    reset,
    formState: { errors },
  } = useForm({ resolver: zodResolver(schema), defaultValues: DEFAULT_VALUES });

  // Reset tiap dibuka agar tidak ada sisa nilai/error dari sesi sebelumnya.
  useEffect(() => {
    if (open) {
      reset(DEFAULT_VALUES);
      mutation.reset?.();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open]);

  async function onSubmit(values) {
    try {
      await mutation.mutateAsync(values);
      onClose(); // 201 -> tutup dialog (list & dashboard ter-invalidate di hook)
    } catch (err) {
      const status = err.response?.status;
      const message = err.response?.data?.message ?? 'Gagal menambahkan periode.';
      if (status === 409) {
        // Duplikat: pesan BE dipakai PERSIS, ditempel di field tahun ajaran.
        setError('tahunAjaran', { message });
      } else if (status === 400) {
        // Validasi BE per field (kontrak error.middleware: errors[{field,message}]):
        // pesan ditempel inline di field terkait; fallback ke tahunAjaran.
        const invalid = err.response?.data?.errors;
        if (Array.isArray(invalid) && invalid.length > 0) {
          invalid.forEach((e) => {
            const key = e.field === 'semester' ? 'semester' : 'tahunAjaran';
            setError(key, { message: e.message ?? message });
          });
        } else {
          setError('tahunAjaran', { message });
        }
      } else {
        setError('semester', { message });
      }
    }
  }

  return (
    <Dialog open={open} onClose={onClose} labelledBy="create-periode-title" className="max-w-md">
      {/* Kop: ikon kalender tint brand + judul/subtitle; X penutup di kanan atas. */}
      <button
        type="button"
        onClick={onClose}
        aria-label="Tutup dialog"
        title="Tutup"
        className="absolute right-4 top-4 rounded-md p-1 text-muted transition-colors hover:bg-line hover:text-ink"
      >
        <X size={16} aria-hidden="true" />
      </button>

      <div className="flex items-center gap-3 pr-8">
        <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-brand-tint text-brand">
          <CalendarDays size={20} aria-hidden="true" />
        </div>
        <div className="min-w-0">
          <h2 id="create-periode-title" className="text-base font-semibold text-ink">
            Buat Periode Baru
          </h2>
          <p className="mt-0.5 text-sm leading-5 text-muted">
            Tambahkan tahun ajaran dan semester aktif
          </p>
        </div>
      </div>

      <form className="mt-6 space-y-4" onSubmit={handleSubmit(onSubmit)} noValidate>
        <div>
          <FieldLabel htmlFor="tahunAjaran">
            Tahun Ajaran <span className="text-brand">*</span>
          </FieldLabel>
          <input
            id="tahunAjaran"
            type="text"
            placeholder="contoh: 2025/2026"
            autoComplete="off"
            aria-invalid={errors.tahunAjaran ? 'true' : undefined}
            className={cnInput(errors.tahunAjaran)}
            {...register('tahunAjaran', {
              onChange: () => clearErrors('tahunAjaran'),
            })}
          />
          {HELPERS.tahunAjaran ? (
            <p className="mt-1.5 text-xs leading-4 text-muted">{HELPERS.tahunAjaran}</p>
          ) : null}
          {errors.tahunAjaran ? (
            <p className="mt-1.5 text-sm leading-5 text-danger-text">
              {errors.tahunAjaran.message}
            </p>
          ) : null}
        </div>

        <div>
          <FieldLabel htmlFor="semester">
            Semester <span className="text-brand">*</span>
          </FieldLabel>
          <select
            id="semester"
            aria-invalid={errors.semester ? 'true' : undefined}
            className={cnInput(errors.semester)}
            {...register('semester', { onChange: () => clearErrors('semester') })}
          >
            {/* Placeholder wajib pilih (frame 3B rev2). */}
            <option value="" disabled>
              Pilih semester
            </option>
            <option value="GANJIL">Ganjil</option>
            <option value="GENAP">Genap</option>
          </select>
          {errors.semester ? (
            <p className="mt-1.5 text-sm leading-5 text-danger-text">
              {errors.semester.message}
            </p>
          ) : null}
        </div>

        {/* Info note: keunikan kombinasi + status awal non-aktif (frame 3B rev2). */}
        <div className="flex items-start gap-2 rounded-lg border border-line bg-input px-3 py-2.5">
          <Info size={14} className="mt-0.5 shrink-0 text-info" aria-hidden="true" />
          <p className="text-xs leading-4 text-muted">
            Kombinasi tahun ajaran dan semester harus unik. Periode baru berstatus non-aktif sampai
            diaktifkan.
          </p>
        </div>

        {/* Footer kanan: Batal (outline) + CTA solid brand "Simpan" */}
        <div className="flex items-center justify-end gap-3 pt-2">
          <Button variant="outline" onClick={onClose}>
            Batal
          </Button>
          <Button type="submit" disabled={mutation.isPending}>
            {mutation.isPending ? 'Menyimpan...' : 'Simpan'}
          </Button>
        </div>
      </form>
    </Dialog>
  );
}

// Border merah saat field error (semantic token danger).
function cnInput(hasError) {
  return hasError ? `${inputClass} border-danger` : inputClass;
}
