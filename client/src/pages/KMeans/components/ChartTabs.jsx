import { BarChart2, ScatterChart, GitFork, History, Award } from 'lucide-react';
import { KMEANS_TABS } from '../../../constants/kmeans';

const TAB_ICONS = {
  distribution: BarChart2,
  scatter: ScatterChart,
  parallel: GitFork,
  iterations: History,
  dbi: Award,
};

export default function ChartTabs({ activeTab, onSelectTab, isRunExecuted, children }) {
  const visibleTabs = KMEANS_TABS.filter((tab) => !tab.isAudit || isRunExecuted);

  return (
    <div className="space-y-6">
      <div className="border-b border-line">
        <nav className="-mb-px flex space-x-8 overflow-x-auto" aria-label="Tabs">
          {visibleTabs.map((tab) => {
            const Icon = TAB_ICONS[tab.id] || BarChart2;
            const isActive = activeTab === tab.id;

            return (
              <button
                key={tab.id}
                onClick={() => onSelectTab(tab.id)}
                className={`flex items-center gap-2 whitespace-nowrap border-b-2 py-4 px-1 text-sm font-medium transition-colors ${
                  isActive
                    ? 'border-brand text-brand'
                    : 'border-transparent text-muted hover:border-line hover:text-main'
                }`}
              >
                <Icon className="size-4" />
                <span>{tab.label}</span>
              </button>
            );
          })}
        </nav>
      </div>

      <div className="min-h-[400px]">
        {children}
      </div>
    </div>
  );
}
