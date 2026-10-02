import { useAuth } from '../context/AuthContext';

// Placeholder sementara route terproteksi "/" (slice login FE saja).
export default function DashboardPage() {
  const { logout } = useAuth();

  return (
    <div className="flex min-h-screen flex-col items-center justify-center gap-4 bg-zinc-100 font-sans dark:bg-zinc-900">
      <div className="rounded-lg border border-zinc-200 bg-white px-6 py-8 text-center shadow-sm dark:border-zinc-700 dark:bg-zinc-800">
        <h1 className="text-xl font-semibold text-zinc-900 dark:text-zinc-50">Dashboard segera</h1>
        <p className="mt-2 text-sm text-zinc-500 dark:text-zinc-400">
          Sesi login aktif. Modul dashboard akan menyusul.
        </p>
        <button
          type="button"
          onClick={logout}
          className="mt-6 h-10 rounded-lg border border-zinc-300 px-4 text-sm font-medium text-zinc-900 transition-colors hover:bg-zinc-100 dark:border-zinc-700 dark:bg-transparent dark:text-zinc-50 dark:hover:bg-zinc-700"
        >
          Keluar
        </button>
      </div>
    </div>
  );
}
