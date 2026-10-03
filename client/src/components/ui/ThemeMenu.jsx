import { Moon, Sun, Monitor, Check } from 'lucide-react';
import Menu from './Menu';
import useTheme from '../../hooks/useTheme';
import { cn } from '../../lib/utils';

// ThemeMenu (SHELL-POLISH #2): tombol ikon -> dropdown 3 opsi Light/Dark/System.
// - Opsi aktif = tint brand + check; persist localStorage 'theme-mode' via useTheme.
// - Ikon trigger mengikuti resolved tema saat ini (system => monitor).
const TRIGGER_ICON = { light: Sun, dark: Moon, system: Monitor };

const OPTIONS = [
  { mode: 'light', label: 'Light', icon: Sun },
  { mode: 'dark', label: 'Dark', icon: Moon },
  { mode: 'system', label: 'System', icon: Monitor },
];

export default function ThemeToggle({ className }) {
  const { mode, setMode } = useTheme();
  const TriggerIcon = TRIGGER_ICON[mode] ?? Monitor;

  return (
    <Menu align="right" placement="down" className="w-40">
      {({ open, toggle, close }) => [
        <button
          key="trigger"
          type="button"
          onClick={toggle}
          aria-label={`Tema: ${mode}. Ubah preferensi tema`}
          aria-haspopup="menu"
          aria-expanded={open}
          title="Preferensi tema"
          className={cn(
            // SHELL TOKEN LOCK: bg chip + border kuat, teks muted (token semantik, nol `dark:`).
            'flex h-10 w-10 shrink-0 items-center justify-center rounded-lg border transition-colors',
            'border-line-strong bg-chip-bg text-muted hover:text-ink',
            className
          )}
        >
          <TriggerIcon size={18} />
        </button>,
        OPTIONS.map(({ mode: m, label, icon: Icon }) => {
          const active = m === mode;
          return (
            <button
              key={m}
              type="button"
              role="menuitemradio"
              aria-checked={active}
              onClick={() => {
                setMode(m);
                close();
              }}
              className={cn(
                'flex h-9 w-full items-center gap-2 rounded-md px-3 text-sm font-medium transition-colors',
                active ? 'bg-brand-tint text-brand' : 'text-ink hover:bg-line'
              )}
            >
              <Icon size={16} shrink-0 aria-hidden="true" />
              <span className="flex-1 text-left">{label}</span>
              {active && <Check size={14} shrink-0 aria-hidden="true" />}
            </button>
          );
        }),
      ]}
    </Menu>
  );
}
