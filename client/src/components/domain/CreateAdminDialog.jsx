import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { UserPlus, X } from 'lucide-react';
import Dialog from '../ui/Dialog';
import Button from '../ui/Button';
import AdminFormFields from './AdminFormFields';
import useCreateAdmin from '../../hooks/useCreateAdmin';

const schema = z
  .object({
    username: z
      .string()
      .min(3, 'Username minimal 3 karakter.')
      .max(50, 'Username maksimal 50 karakter.'),
    password: z
      .string()
      .min(6, 'Password minimal 6 karakter.')
      .max(72, 'Password maksimal 72 karakter.'),
    confirmPassword: z.string().min(1, 'Konfirmasi password wajib diisi.'),
  })
  .refine((data) => data.password === data.confirmPassword, {
    message: 'Konfirmasi password tidak cocok.',
    path: ['confirmPassword'],
  });

const DEFAULT_VALUES = { username: '', password: '', confirmPassword: '' };

export default function CreateAdminDialog({ open, onClose }) {
  const mutation = useCreateAdmin();
  const {
    register,
    handleSubmit,
    setError,
    clearErrors,
    reset,
    formState: { errors },
  } = useForm({
    resolver: zodResolver(schema),
    defaultValues: DEFAULT_VALUES,
  });

  useEffect(() => {
    if (open) {
      reset(DEFAULT_VALUES);
      mutation.reset?.();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open]);

  async function onSubmit(values) {
    try {
      await mutation.mutateAsync({
        username: values.username,
        password: values.password,
      });
      onClose();
    } catch (err) {
      const status = err.response?.status;
      const message = err.response?.data?.message ?? 'Gagal menambahkan admin.';
      if (status === 409) {
        setError('username', { message });
      } else if (status === 400) {
        const invalid = err.response?.data?.errors;
        if (Array.isArray(invalid) && invalid.length > 0) {
          invalid.forEach((e) => {
            const key = e.field === 'password' ? 'password' : 'username';
            setError(key, { message: e.message ?? message });
          });
        } else {
          setError('username', { message });
        }
      } else {
        setError('username', { message });
      }
    }
  }

  return (
    <Dialog open={open} onClose={onClose} labelledBy="create-admin-title" className="max-w-md">
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
          <UserPlus size={20} aria-hidden="true" />
        </div>
        <div className="min-w-0">
          <h2 id="create-admin-title" className="text-base font-semibold text-ink">
            Tambah Admin Baru
          </h2>
          <p className="mt-0.5 text-sm leading-5 text-muted">
            Buat akun admin baru untuk akses sistem
          </p>
        </div>
      </div>

      <form className="mt-6 space-y-4" onSubmit={handleSubmit(onSubmit)} noValidate>
        <AdminFormFields
          register={register}
          errors={errors}
          clearErrors={clearErrors}
          isEdit={false}
        />

        <div className="flex items-center justify-end gap-3 pt-2">
          <Button variant="outline" onClick={onClose} type="button">
            Batal
          </Button>
          <Button type="submit" disabled={mutation.isPending}>
            {mutation.isPending ? 'Menyimpan...' : 'Simpan Admin'}
          </Button>
        </div>
      </form>
    </Dialog>
  );
}
