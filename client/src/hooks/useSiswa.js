import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import api from '../lib/api';

async function fetchSiswaList({ page = 1, limit = 10, q = '', kelas = '', source = '', periode_id = '' }) {
  const params = { page, limit };
  if (q) params.q = q;
  if (kelas) params.kelas = kelas;
  if (source) params.source = source;
  if (periode_id) params.periode_id = periode_id;

  const res = await api.get('/siswa', { params });
  const payload = res.data?.data ?? res.data ?? {};
  return {
    items: payload.items ?? [],
    total: payload.total ?? 0,
    page: payload.page ?? page,
    limit: payload.limit ?? limit,
  };
}

export function useSiswaList(params = {}) {
  const { page = 1, limit = 10, q = '', kelas = '', source = '', periode_id = '' } = params;
  return useQuery({
    queryKey: ['siswa', { page, limit, q, kelas, source, periode_id }],
    queryFn: () => fetchSiswaList({ page, limit, q, kelas, source, periode_id }),
    staleTime: 10_000,
  });
}

async function fetchSiswaDetail(id) {
  if (!id) return null;
  const res = await api.get(`/siswa/${id}`);
  return res.data?.data ?? res.data ?? null;
}

export function useSiswaDetail(id) {
  return useQuery({
    queryKey: ['siswa-detail', id],
    queryFn: () => fetchSiswaDetail(id),
    enabled: Boolean(id),
  });
}

async function deleteSiswa({ id, periode_id }) {
  const params = {};
  if (periode_id) params.periode_id = periode_id;
  const res = await api.delete(`/siswa/${id}`, { params });
  return res.data;
}

export function useDeleteSiswa() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: deleteSiswa,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['siswa'] });
      queryClient.invalidateQueries({ queryKey: ['dashboard-summary'] });
    },
  });
}
