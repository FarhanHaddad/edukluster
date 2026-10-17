import Badge from '../../ui/Badge';
import { cn } from '../../../lib/utils';

const TAB_CONFIG = [
  { id: 'integrasi', label: 'Integrasi Data' },
  { id: 'cleaning', label: 'Cleaning Data' },
  { id: 'transformasi', label: 'Transformasi Data' },
  { id: 'reduksi', label: 'Reduksi Data' },
];

function getBadgeProps(state) {
  switch (state) {
    case 'SELESAI':
      return { tone: 'success', label: 'Selesai' };
    case 'RESET':
      return { tone: 'warning', label: 'Reset' };
    case 'MENUNGGU':
      return { tone: 'warning', label: 'Menunggu' };
    case 'TERKUNCI':
    default:
      return { tone: 'neutral', label: 'Terkunci' };
  }
}

export default function PreprocessingTabBar({ activeTab, onSelectTab, stages = {} }) {
  return (
    <div className="flex items-center gap-6 border-b border-line overflow-x-auto">
      {TAB_CONFIG.map((tab) => {
        const stageData = stages[tab.id];
        const state = stageData?.state || (tab.id === 'integrasi' ? 'MENUNGGU' : 'TERKUNCI');
        const badge = getBadgeProps(state);
        const isActive = activeTab === tab.id;

        return (
          <button
            key={tab.id}
            type="button"
            onClick={() => onSelectTab(tab.id)}
            className={cn(
              'flex items-center gap-2 pb-3.5 pt-1 text-sm transition-colors border-b-2 whitespace-nowrap outline-none',
              isActive
                ? 'border-brand text-brand font-semibold'
                : 'border-transparent text-muted hover:text-ink font-medium'
            )}
          >
            <span>{tab.label}</span>
            <Badge tone={badge.tone} className="px-2 py-0.5 rounded-full text-xs font-medium">
              {badge.label}
            </Badge>
          </button>
        );
      })}
    </div>
  );
}
