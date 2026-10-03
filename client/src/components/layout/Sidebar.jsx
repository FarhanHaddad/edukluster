import { useState } from 'react';
import { NavLink, useNavigate } from 'react-router-dom';
import {
  LayoutGrid,
  CalendarDays,
  Users,
  SlidersHorizontal,
  CircleDot,
  Brain,
  FileText,
  History,
  UserCog,
  MoreVertical,
  LogOut,
} from 'lucide-react';
import * as Lucide from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { cn } from '../../lib/utils';
import widuri from '../../assets/widuri.png';

// Ikon terkunci (DESIGN.md SHELL LOCK) dengan fallback aman bila nama tidak
// tersedia di versi lucide terpasang — akses dinamis, BUKAN named import.
const KmeansIcon = Lucide.ChartScatter ?? CircleDot;
const AdminIcon = Lucide.ShieldSettings ?? UserCog;

// Grup menu terkunci: GENERAL / PROCESSING / OUTPUT / OTHER.
const MENU_GROUPS = [
  {
    label: 'General',
    items: [
      { to: '/', label: 'Dashboard', icon: LayoutGrid, end: true },
      { to: '/periode', label: 'Periode', icon: CalendarDays },
      { to: '/siswa', label: 'Data Siswa', icon: Users },
    ],
  },
  {
    label: 'Processing',
    items: [
      { to: '/preprocessing', label: 'Preprocessing', icon: SlidersHorizontal },
      { to: '/kmeans', label: 'K-Means & Visualisasi', icon: KmeansIcon },
    ],
  },
  {
    label: 'Output',
    items: [
      { to: '/profiling', label: 'Profiling & Rekomendasi', icon: Brain },
      { to: '/laporan', label: 'Laporan', icon: FileText },
      { to: '/riwayat', label: 'Riwayat', icon: History },
    ],
  },
  {
    label: 'Other',
    items: [{ to: '/admin', label: 'Manajemen Admin', icon: AdminIcon }],
  },
];

// Item nav: aktif = bg brand-tint + text brand + semibold, TANPA border (static class).
function SidebarNavItem({ to, label, icon: Icon, end }) {
  return (
    <NavLink
      to={to}
      end={end}
      className={({ isActive }) =>
        cn(
          'flex h-9 items-center gap-2 rounded-lg px-3 text-sm transition-colors',
          isActive
            ? 'bg-brand-tint font-semibold text-brand'
            : 'font-medium text-muted hover:bg-line hover:text-ink'
        )
      }
    >
      <Icon size={16} shrink-0 aria-hidden="true" />
      <span className="truncate">{label}</span>
    </NavLink>
  );
}

// Sidebar 240px — logo row + grup menu + footer identitas (SHELL & IDENTITY LOCK).
export default function Sidebar() {
  const { logout } = useAuth();
  const navigate = useNavigate();
  const [kebabOpen, setKebabOpen] = useState(false);

  function handleKeluar() {
    setKebabOpen(false);
    logout(); // buang token sesi -> RequireAuth lempar ke /login
    navigate('/login', { replace: true });
  }

  return (
    <aside className="flex w-60 shrink-0 flex-col border-r border-line bg-card">
      {/* Logo row: emblem widuri.png dlm container rounded-lg brand-tint */}
      <div className="flex items-center gap-3 px-4 py-4">
        <div className="flex size-9 shrink-0 items-center justify-center rounded-lg border border-brand-border bg-brand-tint">
          <img src={widuri} alt="Emblem SMA Keluarga Widuri" className="size-6 object-contain" />
        </div>
        <div className="min-w-0">
          <p className="truncate text-sm font-semibold leading-5 text-ink">EduCluster</p>
          <p className="truncate text-xs leading-4 text-muted">SMA Widuri</p>
        </div>
      </div>

      {/* Menu bergrup */}
      <nav className="flex-1 overflow-y-auto px-3 pb-4">
        {MENU_GROUPS.map((group) => (
          <div key={group.label} className="mb-4 last:mb-0">
            <p className="mb-1 px-3 text-xs font-semibold uppercase tracking-[0.04em] text-faint">
              {group.label}
            </p>
            <div className="space-y-1">
              {group.items.map((item) => (
                <SidebarNavItem key={item.to} {...item} />
              ))}
            </div>
          </div>
        ))}
      </nav>

      {/* Footer identitas admin (FIXED): avatar 32px circle + nama/role + kebab */}
      <div className="relative border-t border-line p-3">
        <div className="flex items-center gap-3 rounded-lg px-1 py-1">
          <img
            src={widuri}
            alt="Avatar satnaing"
            className="size-8 shrink-0 rounded-full object-cover"
          />
          <div className="min-w-0 flex-1">
            <p className="truncate text-sm font-semibold leading-5 text-ink">satnaing</p>
            <p className="truncate text-xs leading-4 text-muted">Admin SMA Widuri</p>
          </div>
          <button
            type="button"
            aria-label="Menu akun"
            aria-expanded={kebabOpen}
            onClick={() => setKebabOpen((prev) => !prev)}
            className="flex size-8 shrink-0 items-center justify-center rounded-lg text-muted transition-colors hover:bg-line hover:text-ink"
          >
            <MoreVertical size={16} />
          </button>
        </div>

        {kebabOpen && (
          <>
            {/* Backdrop transparan utk tutup menu lewat klik di luar */}
            <button
              type="button"
              aria-label="Tutup menu"
              className="fixed inset-0 z-10 cursor-default"
              onClick={() => setKebabOpen(false)}
            />
            <div className="absolute bottom-full left-3 z-20 mb-1 w-44 rounded-lg border border-line bg-elevated p-1 shadow-sm">
              <button
                type="button"
                onClick={handleKeluar}
                className="flex h-9 w-full items-center gap-2 rounded-md px-3 text-sm font-medium text-danger-text transition-colors hover:bg-danger-tint"
              >
                <LogOut size={16} aria-hidden="true" />
                Keluar
              </button>
            </div>
          </>
        )}
      </div>
    </aside>
  );
}
