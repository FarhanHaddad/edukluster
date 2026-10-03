import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Plus } from 'lucide-react';
import Dialog from '../ui/Dialog';
import Button from '../ui/Button';
import { FieldLabel, FieldError, inputClass } from '../ui/Field';
import useCreatePeriode from '../../hooks/useCreatePeriode';

// Kontrak validasi FE — regex SAMA dengan server/http/periode.rest blok 5
// (tahunAjaran "YYYY/YYYY", semester enum GANJIL|GENAP).
const schema = z.object({
  tahunAjaran: z
    .string()
    .regex(/^\d{4}\/\d{4}$/, 'Format tahun ajaran harus 2026/2027.'),
  semester: z.enum(['GANJIL', 'GENAP'], { message: 'Pilih semester.' }),
});

const DEFAULT_VALUES = { tahunAjaran: '', semester: 'GANJIL' };

// Dialog buat periode baru (frame 3B): dua field + CTA Batal/Tambah Periode.
// 409 dari BE -> pesan BE dipakai PERSIS sebagai inline error merah di bawah field.
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
      if (status === 409 || status === 400) {
        // Pesan BE dipakai persis; tempel di field paling relevan.
        setError('tahunAjaran', { message });
      } else {
        setError('semester', { message });
      }
    }
  }

  return (
    <Dialog open={open} onClose={onClose} labelledBy="create-periode-title" className="max-w-md">
      <div className="flex items-center gap-3">
        <div className="flex size-10 shrink-0 items-center justify-center rounded-lg bg-brand-tint text-brand">
          <Plus size={20} aria-hidden="true" />
        </div>
        <h2 id="create-periode-title" className="text-base font-semibold text-ink">
          Tambah Periode Baru
        </h2>
      </div>

      <form className="mt-6 space-y-4" onSubmit={handleSubmit(onSubmit)} noValidate>
        <div>
          <FieldLabel htmlFor="tahunAjaran">Tahun Ajaran</FieldLabel>
          <input
            id="tahunAjaran"
            type="text"
            placeholder="2026/2027"
            autoComplete="off"
            aria-invalid={errors.tahunAjaran ? 'true' : undefined}
            className={cnInput(errors.tahunAjaran)}
            {...register('tahunAjaran', {
              onChange: () => clearErrors('tahunAjaran'),
            })}
          />
          <FieldError>{errors.tahunAjaran?.message}</FieldError>
        </div>

        <div>
          <FieldLabel htmlFor="semester">Semester</FieldLabel>
          <select
            id="semester"
            aria-invalid={errors.semester ? 'true' : undefined}
            className={cnInput(errors.semester)}
            {...register('semester')}
          >
            <option value="GANJIL">Ganjil</option>
            <option value="GENAP">Genap</option>
          </select>
          <FieldError>{errors.semester?.message}</FieldError>
        </div>

        {/* Footer kanan: Batal (outline) + CTA solid brand */}
        <div className="flex items-center justify-end gap-3 pt-2">
          <Button variant="outline" onClick={onClose}>
            Batal
          </Button>
          <Button type="submit" disabled={mutation.isPending}>
            {mutation.isPending ? 'Menyimpan...' : 'Tambah Periode'}
          </Button>
        </div>
      </form>
    </Dialog>
  );
}

// Border merah saat field error (token danger, tanpa prefix dark:).
function cnInput(hasError) {
  return hasError ? `${inputClass} border-danger` : inputClass;
}
