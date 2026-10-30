import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { getLatestKMeansRun, runKMeans } from '../api/kmeans';

export function useLatestKMeansRun(periodeId, options = {}) {
  return useQuery({
    queryKey: ['kmeans-latest', periodeId ?? 'active'],
    queryFn: async () => {
      try {
        const data = await getLatestKMeansRun(periodeId);
        return data ?? null;
      } catch (err) {
        if (err.response?.status === 404) {
          return null;
        }
        throw err;
      }
    },
    staleTime: 10_000,
    ...options,
  });
}

export function useRunKMeans() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: (periodeId) => runKMeans(periodeId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['kmeans-latest'] });
      queryClient.invalidateQueries({ queryKey: ['preprocessing-status'] });
      queryClient.invalidateQueries({ queryKey: ['dashboard-summary'] });
    },
  });
}
