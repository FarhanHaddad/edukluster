import { Navigate, Outlet } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

// Gerbang route terproteksi: tanpa sesi valid -> lempar ke /login.
export default function RequireAuth() {
  const { admin, bootState } = useAuth();

  if (bootState === 'loading') {
    return (
      <div className="flex min-h-screen items-center justify-center bg-zinc-50 dark:bg-zinc-900">
        <span className="size-5 animate-spin rounded-full border-2 border-zinc-300 border-t-brand dark:border-zinc-700 dark:border-t-brand-dark" />
      </div>
    );
  }

  if (!admin) {
    return <Navigate to="/login" replace />;
  }

  return <Outlet />;
}
