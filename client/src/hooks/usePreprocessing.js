import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import api from '../lib/api';

// GET /preprocessing/pipeline-status
async function fetchPipelineStatus(periodeId) {
  const params = {};
  if (periodeId) params.periodeId = periodeId;
  const res = await api.get('/preprocessing/pipeline-status', { params });
  return res.data?.data ?? null;
}

export function usePreprocessingStatus(periodeId, options = {}) {
  return useQuery({
    queryKey: ['preprocessing-status', periodeId ?? 'active'],
    queryFn: () => fetchPipelineStatus(periodeId),
    staleTime: 10_000,
    ...options,
  });
}

// GET /preprocessing/source-preview
async function fetchSourcePreview({ jenis = 'rapor', page = 1, limit = 100, periodeId }) {
  const params = { jenis, page, limit };
  if (periodeId) params.periodeId = periodeId;
  const res = await api.get('/preprocessing/source-preview', { params });
  const data = res.data?.data ?? {};
  return {
    total: data.total ?? 0,
    page: data.page ?? page,
    limit: data.limit ?? limit,
    rows: data.rows ?? [],
  };
}

export function useSourcePreview({ jenis = 'rapor', page = 1, limit = 100, periodeId }, options = {}) {
  return useQuery({
    queryKey: ['source-preview', { jenis, page, limit, periodeId: periodeId ?? 'active' }],
    queryFn: () => fetchSourcePreview({ jenis, page, limit, periodeId }),
    staleTime: 30_000,
    enabled: Boolean(jenis),
    ...options,
  });
}

// POST /preprocessing/integration
async function runIntegration(periodeId) {
  const params = {};
  if (periodeId) params.periodeId = periodeId;
  const res = await api.post('/preprocessing/integration', {}, { params });
  return res.data?.data ?? res.data;
}

export function useRunIntegration() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: runIntegration,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['preprocessing-status'] });
      queryClient.invalidateQueries({ queryKey: ['source-preview'] });
      queryClient.invalidateQueries({ queryKey: ['dashboard-summary'] });
    },
  });
}
