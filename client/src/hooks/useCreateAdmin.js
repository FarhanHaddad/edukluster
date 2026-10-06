import { useMutation, useQueryClient } from '@tanstack/react-query';
import api from '../lib/api';

async function createAdmin(data) {
  const res = await api.post('/admins', data);
  return res.data?.data;
}

export default function useCreateAdmin(options) {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: createAdmin,
    onSuccess: (...args) => {
      queryClient.invalidateQueries({ queryKey: ['admins'] });
      options?.onSuccess?.(...args);
    },
    ...options,
  });
}
