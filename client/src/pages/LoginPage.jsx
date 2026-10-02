import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Eye, EyeOff, LoaderCircle } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import ThemeToggle from '../components/ThemeToggle';
import widuri from '../assets/widuri.png';

// Kontrak validasi searah BE (server/src/validations/auth.validation.js).
const loginSchema = z.object({
  username: z
    .string()
    .trim()
    .min(3, 'Nama pengguna minimal 3 karakter')
    .max(50, 'Nama pengguna maksimal 50 karakter'),
  password: z.string().min(6, 'Kata sandi minimal 6 karakter'),
});

// Copy error server yang dibackup oleh kontrak UI (whitelist teks).
const SERVER_ERROR_401 = 'Nama pengguna atau kata sandi salah';
const SERVER_ERROR_403 = 'Akun Anda nonaktif. Hubungi administrator lain.';
const SERVER_ERROR_GENERIC = 'Terjadi kesalahan. Silakan coba lagi.';

// Kelas input terkunci — hanya token semantik (theme via CSS variables, tanpa `dark:`).
const INPUT_CLASSES =
  'h-10 w-full rounded-lg border border-line bg-recessed px-3 text-sm text-content outline-none transition-colors ' +
  'placeholder:text-muted focus:border-brand focus:ring-2 focus:ring-brand/20 ' +
  'aria-[invalid=true]:border-destructive';

const LABEL_CLASSES =
  'mb-2 block text-xs font-semibold uppercase tracking-[0.04em] text-content-secondary';

export default function LoginPage() {
  const navigate = useNavigate();
  const { login } = useAuth();
  const [showPassword, setShowPassword] = useState(false);
  const [serverError, setServerError] = useState(null);

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm({
    resolver: zodResolver(loginSchema),
    defaultValues: { username: '', password: '' },
  });

  async function onSubmit(values) {
    setServerError(null);
    try {
      await login(values);
      // Sukses -> token sudah disimpan -> redirect ke halaman utama.
      navigate('/', { replace: true });
    } catch (err) {
      const status = err.response?.status;
      if (status === 401) setServerError(SERVER_ERROR_401);
      else if (status === 403) setServerError(SERVER_ERROR_403);
      else setServerError(SERVER_ERROR_GENERIC);
    }
  }

  return (
    <div className="flex min-h-screen flex-col bg-page font-sans">
      {/* Baris tema standalone (tanpa shell penuh di halaman login). */}
      <div className="flex items-center justify-end px-6 py-4">
        <ThemeToggle />
      </div>

      <div className="flex flex-1 items-center justify-center px-6 pb-16">
        <div className="w-full max-w-sm">
          {/* Identitas brand (SHELL & IDENTITY LOCK): emblem widuri.png dalam container tint. */}
          <div className="mb-8 flex flex-col items-center gap-4 text-center">
            <div className="flex size-14 items-center justify-center rounded-lg border border-brand-tint-border bg-brand-tint p-2.5">
              <img src={widuri} alt="Lambang SMA Widuri" className="size-full object-contain" />
            </div>
            <div>
              <h1 className="text-xl font-semibold tracking-[-0.015em] text-content">EduCluster</h1>
              <p className="mt-1 text-xs text-muted">SMA Widuri</p>
            </div>
          </div>

          <div className="rounded-lg border border-line bg-surface p-6 shadow-sm">
            <h2 className="text-base font-semibold text-content">Masuk sebagai Admin</h2>

            <form onSubmit={handleSubmit(onSubmit)} className="mt-6 flex flex-col gap-4" noValidate>
              <div>
                <label htmlFor="username" className={LABEL_CLASSES}>
                  Nama Pengguna <span className="text-brand">*</span>
                </label>
                <input
                  id="username"
                  type="text"
                  autoComplete="username"
                  placeholder="Masukkan nama pengguna"
                  aria-invalid={errors.username ? 'true' : undefined}
                  className={INPUT_CLASSES}
                  {...register('username')}
                />
                {errors.username && (
                  <p className="mt-2 text-xs text-destructive">{errors.username.message}</p>
                )}
              </div>

              <div>
                <label htmlFor="password" className={LABEL_CLASSES}>
                  Kata Sandi <span className="text-brand">*</span>
                </label>
                <div className="relative">
                  <input
                    id="password"
                    type={showPassword ? 'text' : 'password'}
                    autoComplete="current-password"
                    placeholder="Masukkan kata sandi"
                    aria-invalid={errors.password ? 'true' : undefined}
                    className={`${INPUT_CLASSES} pr-10`}
                    {...register('password')}
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword((v) => !v)}
                    aria-label={showPassword ? 'Sembunyikan kata sandi' : 'Tampilkan kata sandi'}
                    className="absolute right-2 top-1/2 -translate-y-1/2 p-1 text-muted hover:text-content"
                  >
                    {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                  </button>
                </div>
                {errors.password && (
                  <p className="mt-2 text-xs text-destructive">{errors.password.message}</p>
                )}
              </div>

              {serverError && (
                <p role="alert" className="text-xs text-destructive">
                  {serverError}
                </p>
              )}

              <button
                type="submit"
                disabled={isSubmitting}
                className="mt-2 flex h-10 items-center justify-center gap-2 rounded-lg bg-brand px-4 text-sm font-semibold text-on-brand transition-colors hover:bg-brand-hover active:bg-brand-active disabled:cursor-not-allowed disabled:opacity-60"
              >
                {isSubmitting && <LoaderCircle size={16} className="animate-spin" />}
                Masuk
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
}
