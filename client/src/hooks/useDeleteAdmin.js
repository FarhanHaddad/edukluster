import { useMutation, useQueryClient } from '@tanstack/react-query';
import api from '../lib/api';

async function deleteAdmin(id) {
  const res = await api.delete(`/admins/${id}`);
  return res.data?.data;
}

export default function useDeleteAdmin(options) {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: deleteAdmin,
    onSuccess: (...args) => {
      queryClient.invalidateQueries({ queryKey: ['admins'] });
      options?.onSuccess?.(...args);
    },
    ...options,
  });
}
