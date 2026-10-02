import { useState } from 'react';
import { NavLink, useNavigate } from 'react-router-dom';
import {
  GridView, CalendarDays, Users, SlidersHorizontal, Bubble, Brain,
  FileText, History, ShieldCheck, MoreVertical,
} from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import widuri from '../../assets/widuri.png';

// Ikon menu TERKUNCI (DESIGN.md Shell lock): grid_view, calendar_today, group, tune,
// bubble_chart, psychology, description, history, admin_panel_settings.
const MENU_GROUPS = [
  {
    label: 'GENERAL',
    items: [
      { to: '/', label: 'Dashboard', icon: GridView, end: true },
      { to: '/periode', label: 'Periode', icon: CalendarDays },
      { to: '/data-siswa', label: 'Data Siswa', icon: Users },
    ],
  },
  {
    label: 'PROCESSING',
    items: [
      { to: '/preprocessing', label: 'Preprocessing', icon: SlidersHorizontal },
      { to: '/kmeans', label: 'K-Means & Visualisasi', icon: Bubble },
    ],
  },
  {
    label: 'OUTPUT',
    items: [
      { to: '/profiling', label: 'Profiling & Rekomendasi', icon: Brain },
      { to: '/laporan', label: 'Laporan', icon: FileText },
      { to: '/riwayat', label: 'Riwayat', icon: History },
    ],
  },
  {
    label: 'OTHER',
    items: [{ to: '/manajemen-admin', label: 'Manajemen Admin', icon: ShieldCheck }],
  },
];

// Sidebar 240px — logo row, grup menu GENERAL/PROCESSING/OUTPUT/OTHER, footer identitas.
export default function Sidebar() {
  const { logout } = useAuth();
  const navigate = useNavigate();
  const [menuOpen, setMenuOpen] = useState(false);

  function handleKeluar() {
    setMenuOpen(false);
    logout();
    navigate('/login', { replace: true });
  }

  return (
    <aside className="flex w-60 shrink-0 flex-col border-r border-line bg-surface">
      {/* Logo row (SHELL & IDENTITY LOCK): widuri.png dalam container rounded-lg + brand tint. */}
      <div className="flex items-center gap-3 px-4 py-4">
        <div className="flex size-10 shrink-0 items-center justify-center rounded-lg border border-brand-tint-border bg-brand-tint p-1.5">
          <img src={widuri} alt="Lambang SMA Widuri" className="size-full object-contain" />
        </div>
        <div className="min-w-0">
          <p className="truncate text-sm font-semibold text-content">EduCluster</p>
          <p className="truncate text-xs text-muted">SMA Widuri</p>
        </div>
      </div>

      {/* Grup menu. */}
      <nav className="flex-1 overflow-y-auto px-3 pb-4">
        {MENU_GROUPS.map((group) => (
          <div key={group.label} className="mt-4 first:mt-2">
            <p className="px-3 pb-1 text-xs font-semibold uppercase tracking-[0.04em] text-muted">
              {group.label}
            </p>
            <ul className="flex flex-col gap-0.5">
              {group.items.map(({ to, label, icon: Icon, end }) => (
                <li key={to}>
                  <NavLink
                    to={to}
                    end={end}
                    className={({ isActive }) =>
                      'flex h-10 items-center gap-3 rounded-lg px-3 text-sm transition-colors ' +
                      (isActive
                        ? 'bg-brand-tint font-semibold text-brand'
                        : 'font-medium text-content-secondary hover:bg-elevated hover:text-content')
                    }
                  >
                    <Icon size={18} className="shrink-0" />
                    <span className="truncate">{label}</span>
                  </NavLink>
                </li>
              ))}
            </ul>
          </div>
        ))}
      </nav>

      {/* Footer identitas FIXED: avatar widuri.png 32px + "satnaing" + "Admin SMA Widuri" + kebab. */}
      <div className="relative border-t border-line px-4 py-3">
        <div className="flex items-center gap-3">
          <img src={widuri} alt="" className="size-8 shrink-0 rounded-full object-cover" />
          <div className="min-w-0 flex-1">
            <p className="truncate text-sm font-semibold text-content">satnaing</p>
            <p className="truncate text-xs text-muted">Admin SMA Widuri</p>
          </div>
          <button
            type="button"
            aria-label="Menu pengguna"
            onClick={() => setMenuOpen((v) => !v)}
            className="flex size-8 shrink-0 items-center justify-center rounded-lg text-muted transition-colors hover:bg-elevated hover:text-content"
          >
            <MoreVertical size={18} />
          </button>
        </div>

        {menuOpen && (
          <>
            {/* Klik di luar untuk menutup. */}
            <button
              type="button"
              aria-hidden="true"
              tabIndex={-1}
              onClick={() => setMenuOpen(false)}
              className="fixed inset-0 z-10 cursor-default"
            />
            <div className="absolute bottom-full right-4 z-20 mb-2 w-40 rounded-lg border border-line bg-elevated p-1 shadow-sm">
              <button
                type="button"
                onClick={handleKeluar}
                className="flex h-9 w-full items-center rounded-md px-3 text-sm font-medium text-destructive transition-colors hover:bg-destructive-tint"
              >
                Keluar
              </button>
            </div>
          </>
        )}
      </div>
    </aside>
  );
}
