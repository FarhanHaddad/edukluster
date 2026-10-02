import { Navigate, Outlet } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

// Gerbang route terproteksi: tanpa sesi valid -> lempar ke /login.
export default function RequireAuth() {
  const { admin, bootState } = useAuth();

  if (bootState === 'loading') {
    return (
      <div className="flex min-h-screen items-center justify-center bg-page">
        <span className="size-5 animate-spin rounded-full border-2 border-line-strong border-t-brand" />
      </div>
    );
  }

  if (!admin) {
    return <Navigate to="/login" replace />;
  }

  return <Outlet />;
}
