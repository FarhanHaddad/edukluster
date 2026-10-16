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

// GET /preprocessing/cleaning/config
async function fetchCleaningConfig(periodeId) {
  const params = {};
  if (periodeId) params.periodeId = periodeId;
  const res = await api.get('/preprocessing/cleaning/config', { params });
  return res.data?.data ?? null;
}

export function useCleaningConfig(periodeId, options = {}) {
  return useQuery({
    queryKey: ['cleaning-config', periodeId ?? 'active'],
    queryFn: () => fetchCleaningConfig(periodeId),
    staleTime: 10_000,
    ...options,
  });
}

// POST /preprocessing/cleaning
async function runCleaning({ periodeId, imputationMethod, mappings }) {
  const params = {};
  if (periodeId) params.periodeId = periodeId;
  const payload = { imputationMethod, mappings };
  const res = await api.post('/preprocessing/cleaning', payload, { params });
  return res.data?.data ?? res.data;
}

export function useRunCleaning() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: runCleaning,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['preprocessing-status'] });
      queryClient.invalidateQueries({ queryKey: ['cleaning-config'] });
      queryClient.invalidateQueries({ queryKey: ['source-preview'] });
      queryClient.invalidateQueries({ queryKey: ['dashboard-summary'] });
    },
  });
}

// GET /preprocessing/transform/config
async function fetchTransformConfig(periodeId) {
  const params = {};
  if (periodeId) params.periodeId = periodeId;
  const res = await api.get('/preprocessing/transform/config', { params });
  return res.data?.data ?? null;
}

export function useTransformConfig(periodeId, options = {}) {
  return useQuery({
    queryKey: ['transform-config', periodeId ?? 'active'],
    queryFn: () => fetchTransformConfig(periodeId),
    staleTime: 10_000,
    ...options,
  });
}

// POST /preprocessing/transform/options
async function createTransformOption({ periodeId, fieldName, name, code }) {
  const params = {};
  if (periodeId) params.periodeId = periodeId;
  const payload = { fieldName, name };
  if (code !== undefined && code !== null && code !== '') {
    payload.code = Number(code);
  }
  const res = await api.post('/preprocessing/transform/options', payload, { params });
  return res.data?.data ?? res.data;
}

export function useCreateTransformOption() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: createTransformOption,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['transform-config'] });
    },
  });
}

// DELETE /preprocessing/transform/options/:id
async function deleteTransformOption({ id, periodeId }) {
  const params = {};
  if (periodeId) params.periodeId = periodeId;
  const res = await api.delete(`/preprocessing/transform/options/${id}`, { params });
  return res.data?.data ?? res.data;
}

export function useDeleteTransformOption() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: deleteTransformOption,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['transform-config'] });
      queryClient.invalidateQueries({ queryKey: ['preprocessing-status'] });
    },
  });
}

// POST /preprocessing/transform/assignments
async function saveTransformAssignments({ periodeId, fieldName, optionId, standardValues }) {
  const params = {};
  if (periodeId) params.periodeId = periodeId;
  const payload = { fieldName, optionId, standardValues };
  const res = await api.post('/preprocessing/transform/assignments', payload, { params });
  return res.data?.data ?? res.data;
}

export function useSaveTransformAssignments() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: saveTransformAssignments,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['transform-config'] });
      queryClient.invalidateQueries({ queryKey: ['preprocessing-status'] });
    },
  });
}

// POST /preprocessing/transform/run
async function runTransform(periodeId) {
  const params = {};
  if (periodeId) params.periodeId = periodeId;
  const res = await api.post('/preprocessing/transform/run', {}, { params });
  return res.data?.data ?? res.data;
}

export function useRunTransform() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: runTransform,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['preprocessing-status'] });
      queryClient.invalidateQueries({ queryKey: ['transform-config'] });
      queryClient.invalidateQueries({ queryKey: ['source-preview'] });
      queryClient.invalidateQueries({ queryKey: ['dashboard-summary'] });
    },
  });
}

// GET /preprocessing/reduction/summary
async function fetchReductionSummary(periodeId) {
  const params = {};
  if (periodeId) params.periodeId = periodeId;
  const res = await api.get('/preprocessing/reduction/summary', { params });
  return res.data?.data ?? null;
}

export function useReductionSummary(periodeId, options = {}) {
  return useQuery({
    queryKey: ['reduction-summary', periodeId ?? 'active'],
    queryFn: () => fetchReductionSummary(periodeId),
    staleTime: 10_000,
    ...options,
  });
}

// POST /preprocessing/reduction/run
async function runReduction(periodeId) {
  const params = {};
  if (periodeId) params.periodeId = periodeId;
  const res = await api.post('/preprocessing/reduction/run', {}, { params });
  return res.data?.data ?? res.data;
}

export function useRunReduction() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: runReduction,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['preprocessing-status'] });
      queryClient.invalidateQueries({ queryKey: ['reduction-summary'] });
      queryClient.invalidateQueries({ queryKey: ['dashboard-summary'] });
    },
  });
}
