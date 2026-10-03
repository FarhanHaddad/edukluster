import { useNavigate } from 'react-router-dom';
import { LogOut } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import Dialog from './Dialog';

// Dialog konfirmasi Logout (frame 13C light+dark): centered di backdrop dim,
// ikon log-out lingkaran tint destructive, footer kanan Batal + Logout solid.
// CTA destruktif = bg danger + teks on-brand (#fff/#FAFAFA via token) — bukan `solid` brand.
export default function LogoutDialog({ open, onClose }) {
  const { logout } = useAuth();
  const navigate = useNavigate();

  function handleLogout() {
    onClose();
    logout(); // hapus token sesi -> RequireAuth redirect /login bila mount ulang
    navigate('/login', { replace: true });
  }

  return (
    <Dialog open={open} onClose={onClose} labelledBy="logout-dialog-title" className="max-w-sm">
      {/* Ikon peringatan: lingkaran tint destructive */}
      <div className="mx-auto flex size-12 items-center justify-center rounded-full bg-danger-tint text-danger-text">
        <LogOut size={22} aria-hidden="true" />
      </div>

      <h2 id="logout-dialog-title" className="mt-4 text-center text-base font-semibold text-ink">
        Logout dari EduCluster?
      </h2>
      <p className="mt-1 text-center text-sm leading-5 text-muted">
        Sesi login Anda akan berakhir.
      </p>

      {/* Footer rata kanan: Batal (outline) lalu Logout (destruktif solid) */}
      <div className="mt-6 flex items-center justify-end gap-3">
        <button
          type="button"
          onClick={onClose}
          className="inline-flex h-10 items-center justify-center rounded-lg border border-line-strong px-4 text-sm font-semibold text-ink transition-colors hover:bg-brand-tint"
        >
          Batal
        </button>
        <button
          type="button"
          onClick={handleLogout}
          className="inline-flex h-10 items-center justify-center rounded-lg bg-danger px-4 text-sm font-semibold text-on-brand transition-colors hover:brightness-95"
        >
          Logout
        </button>
      </div>
    </Dialog>
  );
}
