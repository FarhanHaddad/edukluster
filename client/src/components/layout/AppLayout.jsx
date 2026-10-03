import Sidebar from './Sidebar';
import Topbar from './Topbar';
import { Outlet } from 'react-router-dom';

// App shell Screen 2+: Sidebar 240px tetap + Topbar + area konten (Outlet).
// Tree light = dark identik; hanya token semantik yang berganti via .dark.
export default function AppLayout() {
  return (
    <div className="flex min-h-screen bg-page font-sans text-ink">
      <Sidebar />
      <div className="flex min-w-0 flex-1 flex-col">
        <Topbar />
        <main className="flex-1 p-6">
          <Outlet />
        </main>
      </div>
    </div>
  );
}
