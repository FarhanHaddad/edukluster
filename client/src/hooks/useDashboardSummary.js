import { useQuery } from '@tanstack/react-query';
import api from '../lib/api';

// GET /dashboard (BE main: server/src/routes/dashboard.routes.js -> router.get('/');
// path lama '/dashboard/summary' = 404). Interceptor 401 di lib/api.js tetap berlaku
// -> token hangus otomatis lempar ke /login.
// Shape data (server/src/services/dashboard.service.js):
// { periodeAktif: {id,tahunAjaran,semester,namaPeriode,status}|null,
//   totalSiswa, preprocessingStatus, kmeansStatus, jumlahCluster,
//   recentRuns: [{id,status,startedAt,completedAt}] }
async function fetchDashboardSummary() {
  const res = await api.get('/dashboard');
  return res.data?.data ?? null;
}

export default function useDashboardSummary() {
  return useQuery({
    queryKey: ['dashboard-summary'],
    queryFn: fetchDashboardSummary,
    staleTime: 30_000,
  });
}
