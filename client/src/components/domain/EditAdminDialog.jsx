import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { UserCheck, X } from 'lucide-react';
import Dialog from '../ui/Dialog';
import Button from '../ui/Button';
import AdminFormFields from './AdminFormFields';
import useUpdateAdmin from '../../hooks/useUpdateAdmin';

const schema = z
  .object({
    username: z
      .string()
      .min(3, 'Username minimal 3 karakter.')
      .max(50, 'Username maksimal 50 karakter.'),
    password: z.string().optional(),
    confirmPassword: z.string().optional(),
  })
  .refine(
    (data) => {
      if (data.password && data.password.length > 0) {
        return data.password.length >= 6 && data.password.length <= 72;
      }
      return true;
    },
    {
      message: 'Password minimal 6 karakter.',
      path: ['password'],
    }
  )
  .refine(
    (data) => {
      if (data.password && data.password.length > 0) {
        return data.password === data.confirmPassword;
      }
      return true;
    },
    {
      message: 'Konfirmasi password tidak cocok.',
      path: ['confirmPassword'],
    }
  );

export default function EditAdminDialog({ open, admin, onClose }) {
  const mutation = useUpdateAdmin();
  const {
    register,
    handleSubmit,
    setError,
    clearErrors,
    reset,
    formState: { errors },
  } = useForm({
    resolver: zodResolver(schema),
    defaultValues: { username: '', password: '', confirmPassword: '' },
  });

  useEffect(() => {
    if (open && admin) {
      reset({
        username: admin.username ?? '',
        password: '',
        confirmPassword: '',
      });
      mutation.reset?.();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open, admin]);

  async function onSubmit(values) {
    if (!admin?.id) return;
    try {
      const payload = {
        id: admin.id,
        username: values.username,
      };
      if (values.password && values.password.trim() !== '') {
        payload.password = values.password;
      }

      await mutation.mutateAsync(payload);
      onClose();
    } catch (err) {
      const status = err.response?.status;
      const message = err.response?.data?.message ?? 'Gagal memperbarui admin.';
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
    <Dialog open={open} onClose={onClose} labelledBy="edit-admin-title" className="max-w-md">
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
          <UserCheck size={20} aria-hidden="true" />
        </div>
        <div className="min-w-0">
          <h2 id="edit-admin-title" className="text-base font-semibold text-ink">
            Edit Data Admin
          </h2>
          <p className="mt-0.5 text-sm leading-5 text-muted">
            Ubah username atau password akun admin
          </p>
        </div>
      </div>

      <form className="mt-6 space-y-4" onSubmit={handleSubmit(onSubmit)} noValidate>
        <AdminFormFields
          register={register}
          errors={errors}
          clearErrors={clearErrors}
          isEdit={true}
        />

        <div className="flex items-center justify-end gap-3 pt-2">
          <Button variant="outline" onClick={onClose} type="button">
            Batal
          </Button>
          <Button type="submit" disabled={mutation.isPending}>
            {mutation.isPending ? 'Menyimpan...' : 'Simpan Perubahan'}
          </Button>
        </div>
      </form>
    </Dialog>
  );
}
