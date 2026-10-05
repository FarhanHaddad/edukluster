import { useMutation, useQueryClient } from '@tanstack/react-query';
import api from '../lib/api';

// PATCH /periodes/:id/activate — path identik dengan server/http/periode.rest blok 6
// (SYNC RULE). Transaksi BE: AKTIF lama -> SELESAI, target -> AKTIF. 409 bila sudah aktif.
export default function useActivatePeriode() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (id) => {
      const res = await api.patch(`/periodes/${id}/activate`);
      return res.data?.data ?? null;
    },
    onSuccess: () => {
      // Sinkron list + summary dashboard (chip periode aktif ikut berubah).
      queryClient.invalidateQueries({ queryKey: ['periodes'] });
      queryClient.invalidateQueries({ queryKey: ['dashboard-summary'] });
    },
  });
}
