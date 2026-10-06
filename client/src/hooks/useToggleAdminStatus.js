import { useMutation, useQueryClient } from '@tanstack/react-query';
import api from '../lib/api';

async function toggleAdminStatus(id) {
  const res = await api.patch(`/admins/${id}/status`);
  return res.data?.data;
}

export default function useToggleAdminStatus(options) {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: toggleAdminStatus,
    onSuccess: (...args) => {
      queryClient.invalidateQueries({ queryKey: ['admins'] });
      options?.onSuccess?.(...args);
    },
    ...options,
  });
}
