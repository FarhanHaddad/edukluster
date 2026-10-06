import { useQuery } from '@tanstack/react-query';
import api from '../lib/api';

async function fetchAdmins() {
  const res = await api.get('/admins');
  return res.data?.data ?? { items: [], total: 0 };
}

export default function useAdmins(options) {
  return useQuery({
    queryKey: ['admins'],
    queryFn: fetchAdmins,
    staleTime: 30_000,
    ...options,
  });
}
