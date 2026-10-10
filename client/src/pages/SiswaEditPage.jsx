import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { ArrowLeft } from 'lucide-react';
import { useSiswaDetail, useUpdateSiswa } from '../hooks/useSiswa';
import Card from '../components/ui/Card';
import SiswaForm from '../components/domain/siswa/SiswaForm';
import Toast from '../components/domain/siswa/Toast';

export default function SiswaEditPage() {
  const { id } = useParams();
  const navigate = useNavigate();

  const { data: detailData, isLoading, isError } = useSiswaDetail(id);
  const updateMutation = useUpdateSiswa();

  const [serverNisError, setServerNisError] = useState(null);
  const [toast, setToast] = useState({ open: false, message: '', tone: 'danger' });

  const showToast = (message, tone = 'danger') => {
    setToast({ open: true, message, tone });
  };

  const siswa = detailData?.siswa ?? detailData;
  const siswaPeriode = detailData?.siswa_periode ?? detailData;

  const nama = siswa?.nama ?? '';
  const nis = siswa?.nis ?? '';
  const kelas = siswaPeriode?.kelas ?? detailData?.kelas ?? '';
  const sourceType = siswaPeriode?.source_type || detailData?.source_type || detailData?.source;
  const sourceLabel = sourceType === 'excel' ? 'Excel' : 'Manual';

  const handleEditSubmit = async (formData) => {
    try {
      setServerNisError(null);
      await updateMutation.mutateAsync({
        id,
        payload: formData,
      });
      navigate('/siswa');
    } catch (err) {
      const status = err.response?.status;
      if (status === 409) {
        setServerNisError('NIS sudah terdaftar.');
      } else if (status === 404) {
        showToast('Data siswa tidak ditemukan.', 'danger');
      } else {
        const msg = err.response?.data?.message || 'Gagal memperbarui data siswa.';
        showToast(msg, 'danger');
      }
    }
  };

  if (isLoading) {
    return (
      <div className="mx-auto max-w-6xl space-y-6">
        <div className="flex min-h-64 items-center justify-center rounded-lg border border-line bg-card p-12">
          <p className="text-sm font-medium text-muted">Memuat data siswa...</p>
        </div>
      </div>
    );
  }

  if (isError || !detailData) {
    return (
      <div className="mx-auto max-w-6xl space-y-6">
        <div className="flex min-h-64 flex-col items-center justify-center rounded-lg border border-line bg-card p-12 text-center">
          <h3 className="text-base font-semibold text-ink">Gagal Memuat Data Siswa</h3>
          <p className="mt-1 text-sm text-muted">Siswa tidak ditemukan atau terjadi kesalahan.</p>
          <button
            type="button"
            onClick={() => navigate('/siswa')}
            className="mt-4 text-sm font-medium text-brand hover:underline"
          >
            Kembali ke Data Siswa
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-6xl space-y-6">
      {/* SUB-PAGE HEADER (TANPA TAB BAR) */}
      <div className="flex items-start gap-4">
        <button
          type="button"
          onClick={() => navigate('/siswa')}
          className="mt-1 flex size-9 items-center justify-center rounded-lg border border-line bg-card text-ink hover:bg-input transition-colors shrink-0"
          aria-label="Kembali ke Data Siswa"
        >
          <ArrowLeft size={18} aria-hidden="true" />
        </button>

        <div className="min-w-0">
          <h1 className="text-xl font-bold text-ink leading-7 truncate">
            Edit Data Siswa: {nama}
          </h1>
          <p className="mt-1 text-sm text-muted">
            NIS: <span className="font-mono text-ink font-medium">{nis}</span> - Kelas{' '}
            <span className="text-ink font-medium">{kelas}</span> - Source:{' '}
            <span className="text-ink font-medium">{sourceLabel}</span>
          </p>
        </div>
      </div>

      {/* CONTENT CARD */}
      <Card className="p-0 overflow-hidden">
        <SiswaForm
          mode="edit"
          initialData={detailData}
          onSubmit={handleEditSubmit}
          onCancel={() => navigate('/siswa')}
          isSubmitting={updateMutation.isPending}
          serverNisError={serverNisError}
          onClearServerNisError={() => setServerNisError(null)}
        />
      </Card>

      <Toast
        open={toast.open}
        message={toast.message}
        tone={toast.tone}
        onClose={() => setToast((prev) => ({ ...prev, open: false }))}
      />
    </div>
  );
}
