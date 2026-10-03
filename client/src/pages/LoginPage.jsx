import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Eye, EyeOff, LoaderCircle } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import ThemeToggle from '../components/ui/ThemeMenu';
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

// Kelas input terkunci: recessed #121215 / border #27272A / accent focus brand (DARK MODE CONTRACT).
const INPUT_CLASSES =
  'h-10 w-full rounded-lg border bg-white px-3 text-sm text-zinc-900 outline-none transition-colors ' +
  'placeholder:text-zinc-400 focus:border-brand-hover focus:ring-2 focus:ring-brand/20 ' +
  'border-zinc-200 ' +
  'dark:bg-[#121215] dark:text-zinc-50 dark:placeholder:text-[#71717A] ' +
  'dark:border-zinc-700 dark:focus:border-brand-dark dark:focus:ring-brand-dark/20 ' +
  'aria-[invalid=true]:border-[#DC2626] dark:aria-[invalid=true]:border-[#F87171]';

const LABEL_CLASSES =
  'mb-2 block text-xs font-semibold uppercase tracking-[0.04em] text-zinc-600 dark:text-zinc-400';

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
      // Suksess -> token sudah disimpan -> redirect ke halaman utama.
      navigate('/', { replace: true });
    } catch (err) {
      const status = err.response?.status;
      if (status === 401) {
        setServerError(SERVER_ERROR_401);
      } else if (status === 403) {
        setServerError(SERVER_ERROR_403);
      } else {
        setServerError(SERVER_ERROR_GENERIC);
      }
    }
  }

  return (
    <div className="relative flex min-h-screen items-center justify-center bg-zinc-100 px-4 py-6 font-sans dark:bg-zinc-900">
      {/* Theme toggle kanan-atas */}
      <div className="absolute right-6 top-6">
        <ThemeToggle />
      </div>

      {/* Kartu tengah (elevasi: satu step lebih terang dari background) */}
      <div className="w-full max-w-[400px] rounded-lg border border-zinc-200 bg-white p-6 shadow-sm dark:border-zinc-700 dark:bg-zinc-800 sm:p-8">
        {/* Emblem widuri.png — IDENTITY LOCK: aset brand satu-satunya */}
        <div className="mb-6 flex justify-center">
          <div className="flex size-16 items-center justify-center rounded-lg border border-brand/25 bg-brand/10 dark:border-brand-dark/25 dark:bg-brand-dark/15">
            <img src={widuri} alt="Emblem SMA Keluarga Widuri" className="size-10 object-contain" />
          </div>
        </div>

        <h1 className="text-center text-2xl font-bold leading-8 tracking-[-0.015em] text-zinc-900 dark:text-zinc-50">
          EduCluster SMA Widuri
        </h1>
        <p className="mt-2 text-center text-sm leading-5 text-zinc-500 dark:text-zinc-400">
          Sistem Rekomendasi Jurusan Perguruan Tinggi Berbasis K-Means
        </p>

        {/* Banner error generik (401) / nonaktif (403) */}
        {serverError && (
          <div
            role="alert"
            className="mt-6 rounded-lg border border-[#F87171]/40 bg-[#DC2626]/10 px-3 py-2 text-sm leading-5 text-[#BA1A1A] dark:text-[#F87171]"
          >
            {serverError}
          </div>
        )}

        <form className="mt-6 space-y-4" onSubmit={handleSubmit(onSubmit)} noValidate>
          <div>
            <label htmlFor="username" className={LABEL_CLASSES}>
              Nama Pengguna <span className="text-brand dark:text-brand-dark">*</span>
            </label>
            <input
              id="username"
              name="username"
              type="text"
              autoComplete="username"
              placeholder="Masukkan nama pengguna"
              aria-invalid={Boolean(errors.username)}
              className={INPUT_CLASSES}
              {...register('username')}
            />
            {errors.username && (
              <p className="mt-2 text-xs leading-4 text-[#BA1A1A] dark:text-[#F87171]">
                {errors.username.message}
              </p>
            )}
          </div>

          <div>
            <label htmlFor="password" className={LABEL_CLASSES}>
              Kata Sandi <span className="text-brand dark:text-brand-dark">*</span>
            </label>
            <div className="relative">
              <input
                id="password"
                name="password"
                type={showPassword ? 'text' : 'password'}
                autoComplete="current-password"
                placeholder="Masukkan kata sandi"
                aria-invalid={Boolean(errors.password)}
                className={`${INPUT_CLASSES} pr-10`}
                {...register('password')}
              />
              {/* Eye toggle password */}
              <button
                type="button"
                onClick={() => setShowPassword((prev) => !prev)}
                aria-label={showPassword ? 'Sembunyikan kata sandi' : 'Tampilkan kata sandi'}
                className="absolute right-2 top-1/2 flex size-6 -translate-y-1/2 items-center justify-center rounded-md text-zinc-500 hover:text-zinc-900 dark:text-zinc-400 dark:hover:text-zinc-50"
              >
                {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
              </button>
            </div>
            {errors.password && (
              <p className="mt-2 text-xs leading-4 text-[#BA1A1A] dark:text-[#F87171]">
                {errors.password.message}
              </p>
            )}
          </div>

          {/* CTA solid (DESIGN.md): #A64DC4, hover #8F39AC; dark: #BE7DD4, hover #B266CC, teks #18181B */}
          <button
            type="submit"
            disabled={isSubmitting}
            className="flex h-10 w-full items-center justify-center gap-2 rounded-lg bg-brand text-sm font-semibold text-white transition-colors hover:bg-brand-hover active:bg-brand-active disabled:cursor-not-allowed disabled:bg-zinc-200 disabled:text-zinc-500 dark:bg-brand-dark dark:text-zinc-800 dark:hover:bg-brand-dark-hover dark:disabled:bg-zinc-700 dark:disabled:text-zinc-400"
          >
            {isSubmitting && <LoaderCircle size={16} className="animate-spin" />}
            Masuk
          </button>
        </form>

        <div className="mt-8 border-t border-zinc-200 pt-4 text-center dark:border-zinc-700">
          <p className="text-xs leading-4 text-zinc-500 dark:text-zinc-400">
            Akses terbatas untuk admin SMA Keluarga Widuri
          </p>
          <p className="mt-2 text-xs leading-4 text-zinc-400 dark:text-zinc-500">
            &copy; {new Date().getFullYear()} EduCluster &mdash; SMA Keluarga Widuri
          </p>
        </div>
      </div>
    </div>
  );
}
