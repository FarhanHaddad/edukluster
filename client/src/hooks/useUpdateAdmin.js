import { useMutation, useQueryClient } from '@tanstack/react-query';
import api from '../lib/api';

async function updateAdmin({ id, ...data }) {
  const res = await api.put(`/admins/${id}`, data);
  return res.data?.data;
}

export default function useUpdateAdmin(options) {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: updateAdmin,
    onSuccess: (...args) => {
      queryClient.invalidateQueries({ queryKey: ['admins'] });
      options?.onSuccess?.(...args);
    },
    ...options,
  });
}
