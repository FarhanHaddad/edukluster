import { useQuery } from '@tanstack/react-query';
import api from '../lib/api';

// GET /periodes — path identik dengan server/http/periode.rest blok 1 (SYNC RULE).
// Shape data (server/src/services/periode.service.js toResponseItem):
// { items: [{id, tahunAjaran, semester, namaPeriode, status, totalSiswa, createdAt}], total }
async function fetchPeriodes() {
  const res = await api.get('/periodes');
  return res.data?.data ?? { items: [], total: 0 };
}

export default function usePeriodes(options) {
  return useQuery({
    queryKey: ['periodes'],
    queryFn: fetchPeriodes,
    staleTime: 30_000,
    ...options,
  });
}
