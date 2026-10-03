import { useMutation, useQueryClient } from '@tanstack/react-query';
import api from '../lib/api';

// POST /periodes — path identik dengan server/http/periode.rest blok 3 (SYNC RULE).
// Body: { tahunAjaran: "2026/2027", semester: "GANJIL"|"GENAP" } -> 201 item baru.
// Error BE yang relevan di FE: 409 duplikat (pesan spesifik dari service), 400 validasi.
export default function useCreatePeriode() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (payload) => {
      const res = await api.post('/periodes', payload);
      return res.data?.data ?? null;
    },
    onSuccess: () => {
      // Invalidate list periode + summary dashboard: chip periode di Screen 2
      // ikut berubah = bukti sinkronisasi lintas layar.
      queryClient.invalidateQueries({ queryKey: ['periodes'] });
      queryClient.invalidateQueries({ queryKey: ['dashboard-summary'] });
    },
  });
}
