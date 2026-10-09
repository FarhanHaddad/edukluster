import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import RequireAuth from './components/RequireAuth';
import AppLayout from './components/layout/AppLayout';
import LoginPage from './pages/LoginPage';
import DashboardPage from './pages/DashboardPage';
import PeriodePage from './pages/PeriodePage';
import AdminPage from './pages/AdminPage';
import SiswaPage from './pages/SiswaPage';
import PlaceholderPage from './components/domain/PlaceholderPage';

// Menu shell yang belum dibangun — semua protected, render PlaceholderPage.
const PLACEHOLDER_ROUTES = [
  { path: '/preprocessing', title: 'Preprocessing' },
  { path: '/kmeans', title: 'K-Means & Visualisasi' },
  { path: '/profiling', title: 'Profiling & Rekomendasi' },
  { path: '/laporan', title: 'Laporan' },
  { path: '/riwayat', title: 'Riwayat' },
];

export default function App() {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Routes>
          {/* Publik */}
          <Route path="/login" element={<LoginPage />} />

          {/* Terproteksi via RequireAuth — tanpa token => /login */}
          <Route element={<RequireAuth />}>
            <Route element={<AppLayout />}>
              <Route path="/" element={<DashboardPage />} />
              <Route path="/periode" element={<PeriodePage />} />
              <Route path="/admin" element={<AdminPage />} />
              <Route path="/siswa" element={<SiswaPage />} />
              {PLACEHOLDER_ROUTES.map(({ path, title }) => (
                <Route key={path} path={path} element={<PlaceholderPage title={title} />} />
              ))}
            </Route>
          </Route>

          {/* Fallback */}
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </BrowserRouter>
    </AuthProvider>
  );
}
