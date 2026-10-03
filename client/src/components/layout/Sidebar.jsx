import { NavLink } from 'react-router-dom';
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
} from 'lucide-react';
import * as Lucide from 'lucide-react';
import ProfileMenu from '../ui/ProfileMenu';
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

      {/* Footer identitas admin (FIXED): avatar 32px circle + nama/role + kebab.
          Kebab => ProfileMenu (panel membuka KE ATAS; Logout lewat dialog konfirmasi). */}
      <div className="border-t border-line p-3">
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
          <ProfileMenu trigger="kebab" align="right" />
        </div>
      </div>
    </aside>
  );
}
