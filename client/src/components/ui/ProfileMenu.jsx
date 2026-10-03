import { useState } from 'react';
import { Settings, LogOut, MoreVertical } from 'lucide-react';
import Menu, { MenuItem } from './Menu';
import LogoutDialog from './LogoutDialog';
import { cn } from '../../lib/utils';
import widuri from '../../assets/widuri.png';

// ProfileMenu (SHELL-POLISH #3): SATU komponen, DUA anchor —
// - avatar topbar (trigger='avatar', panel ke bawah, align right),
// - kebab footer sidebar (trigger='kebab', panel membuka KE ATAS).
// Isi: header identitas (widuri 32px + 'satnaing') -> divider -> Pengaturan Akun
// (no-op, TODO Sprint berikutnya) -> Logout => BUKA LogoutDialog (BUKAN logout langsung).
export default function ProfileMenu({ trigger = 'avatar', align = 'right' }) {
  const [logoutOpen, setLogoutOpen] = useState(false);
  const placement = trigger === 'kebab' ? 'up' : 'down';

  return (
    <>
      <Menu align={align} placement={placement} className="w-52">
        {({ open, toggle, close }) => [
          trigger === 'kebab' ? (
            <button
              key="trigger"
              type="button"
              onClick={toggle}
              aria-label="Menu akun"
              aria-haspopup="menu"
              aria-expanded={open}
              title="Menu akun"
              className="flex size-8 shrink-0 items-center justify-center rounded-lg text-muted transition-colors hover:bg-line hover:text-ink"
            >
              <MoreVertical size={16} />
            </button>
          ) : (
            <button
              key="trigger"
              type="button"
              onClick={toggle}
              aria-label="Menu profil akun"
              aria-haspopup="menu"
              aria-expanded={open}
              title="Menu profil akun"
              className="shrink-0 rounded-full focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand/40"
            >
              <img
                src={widuri}
                alt="Avatar satnaing"
                className={cn('size-8 rounded-full object-cover')}
              />
            </button>
          ),
          <div key="header" className="flex items-center gap-2 px-3 py-2">
            <img
              src={widuri}
              alt=""
              aria-hidden="true"
              className="size-8 shrink-0 rounded-full object-cover"
            />
            <p className="truncate text-sm font-semibold text-ink">satnaing</p>
          </div>,
          <div key="divider" className="my-1 h-px bg-line" role="separator" />,
          <MenuItem
            key="settings"
            icon={Settings}
            onClick={() => {
              // TODO (Sprint berikutnya): navigasi/panel Pengaturan Akun. No-op disengaja.
              close();
            }}
          >
            Pengaturan Akun
          </MenuItem>,
          <MenuItem
            key="logout"
            icon={LogOut}
            danger
            onClick={() => {
              close();
              setLogoutOpen(true);
            }}
          >
            Logout
          </MenuItem>,
        ]}
      </Menu>
      <LogoutDialog open={logoutOpen} onClose={() => setLogoutOpen(false)} />
    </>
  );
}
