import { useState } from 'react';
import useDashboardSummary from '../hooks/useDashboardSummary';
import { useSiswaList, useDeleteSiswa, useCreateSiswa } from '../hooks/useSiswa';
import PageHeader from '../components/domain/PageHeader';
import PeriodChip from '../components/domain/PeriodChip';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import SiswaToolbar from '../components/domain/siswa/SiswaToolbar';
import SiswaTable from '../components/domain/siswa/SiswaTable';
import SiswaPagination from '../components/domain/siswa/SiswaPagination';
import SiswaDetailModal from '../components/domain/siswa/SiswaDetailModal';
import DeleteSiswaDialog from '../components/domain/siswa/DeleteSiswaDialog';
import SiswaForm from '../components/domain/siswa/SiswaForm';
import Toast from '../components/domain/siswa/Toast';
import { cn } from '../lib/utils';

export default function SiswaPage() {
  // Active period
  const { data: summary } = useDashboardSummary();
  const activePeriode = summary?.periodeAktif ?? null;
  const periodeNama = activePeriode?.namaPeriode ?? '2025/2026 Ganjil';

  // Active tab: 'daftar' | 'single_input' | 'excel'
  const [activeTab, setActiveTab] = useState('daftar');

  // Filter & Pagination params for tab Daftar Siswa
  const [page, setPage] = useState(1);
  const [search, setSearch] = useState('');
  const [kelas, setKelas] = useState('');
  const [source, setSource] = useState('');

  // Server error on NIS for single_input form
  const [serverNisError, setServerNisError] = useState(null);

  // Query list siswa
  const { data, isLoading } = useSiswaList({
    page,
    limit: 10,
    q: search,
    kelas,
    source,
    periode_id: activePeriode?.id ?? '',
  });

  const total = data?.total ?? 0;
  const items = data?.items ?? [];

  // Modals state
  const [detailStudentId, setDetailStudentId] = useState(null);
  const [deleteTarget, setDeleteTarget] = useState(null);

  // Mutations
  const deleteMutation = useDeleteSiswa();
  const createMutation = useCreateSiswa();

  // Toast state
  const [toast, setToast] = useState({ open: false, message: '', tone: 'danger' });

  const showToast = (message, tone = 'danger') => {
    setToast({ open: true, message, tone });
  };

  const handleSearchChange = (newVal) => {
    setSearch(newVal);
    setPage(1);
  };

  const handleKelasChange = (newVal) => {
    setKelas(newVal);
    setPage(1);
  };

  const handleSourceChange = (newVal) => {
    setSource(newVal);
    setPage(1);
  };

  const handleDeleteConfirm = async (student) => {
    try {
      await deleteMutation.mutateAsync({
        id: student.id,
        periode_id: activePeriode?.id,
      });
      setDeleteTarget(null);
      showToast('Siswa berhasil dihapus dari periode ini.', 'success');
    } catch (err) {
      setDeleteTarget(null);
      const status = err.response?.status;
      if (status === 409) {
        showToast(
          'Siswa tidak bisa dihapus karena sudah memiliki hasil clustering & rekomendasi.',
          'danger'
        );
      } else {
        const msg = err.response?.data?.message || 'Gagal menghapus data siswa.';
        showToast(msg, 'danger');
      }
    }
  };

  const handleCreateSubmit = async (formData) => {
    try {
      setServerNisError(null);
      const payload = {
        ...formData,
        periode_id: activePeriode?.id,
      };
      await createMutation.mutateAsync(payload);
      showToast('Siswa berhasil ditambahkan.', 'success');
      setActiveTab('daftar');
    } catch (err) {
      const status = err.response?.status;
      if (status === 409) {
        setServerNisError('NIS sudah terdaftar.');
      } else {
        const msg = err.response?.data?.message || 'Gagal menyimpan data siswa.';
        showToast(msg, 'danger');
      }
    }
  };

  return (
    <div className="mx-auto max-w-6xl space-y-6">
      {/* ROW 1: HEADER */}
      <PageHeader
        title="Data Siswa"
        description="Kelola data akademik dan non-akademik siswa pada periode aktif."
        periodChip={<PeriodChip namaPeriode={periodeNama} />}
      />

      {/* ROW 2: TAB BAR */}
      <div className="flex border-b border-line gap-6">
        <button
          type="button"
          onClick={() => setActiveTab('daftar')}
          className={cn(
            'flex items-center gap-2 pb-3 pt-1 text-sm font-semibold border-b-2 transition-colors',
            activeTab === 'daftar'
              ? 'border-brand text-brand'
              : 'border-transparent text-muted hover:text-ink'
          )}
        >
          <span>Daftar Siswa</span>
          <Badge tone="brand" className="font-mono px-2 py-0.5 rounded-full text-xs">
            {total}
          </Badge>
        </button>

        <button
          type="button"
          onClick={() => {
            setServerNisError(null);
            setActiveTab('single_input');
          }}
          className={cn(
            'pb-3 pt-1 text-sm font-semibold border-b-2 transition-colors',
            activeTab === 'single_input'
              ? 'border-brand text-brand'
              : 'border-transparent text-muted hover:text-ink'
          )}
        >
          Single Input
        </button>

        <button
          type="button"
          onClick={() => setActiveTab('excel')}
          className={cn(
            'pb-3 pt-1 text-sm font-semibold border-b-2 transition-colors',
            activeTab === 'excel'
              ? 'border-brand text-brand'
              : 'border-transparent text-muted hover:text-ink'
          )}
        >
          Import Excel
        </button>
      </div>

      {/* ROW 3: SATU CONTENT CARD */}
      <Card className="p-0 overflow-hidden">
        {activeTab === 'daftar' ? (
          <>
            <SiswaToolbar
              search={search}
              onSearchChange={handleSearchChange}
              kelas={kelas}
              onKelasChange={handleKelasChange}
              source={source}
              onSourceChange={handleSourceChange}
              total={total}
            />

            <SiswaTable
              items={items}
              isLoading={isLoading}
              onViewDetail={(item) => setDetailStudentId(item.id)}
              onDelete={(item) => setDeleteTarget(item)}
              onSwitchTab={(tab) => setActiveTab(tab)}
            />

            {items.length > 0 && (
              <SiswaPagination
                page={page}
                limit={10}
                total={total}
                onPageChange={(p) => setPage(p)}
              />
            )}
          </>
        ) : activeTab === 'single_input' ? (
          <SiswaForm
            mode="create"
            onSubmit={handleCreateSubmit}
            onCancel={() => setActiveTab('daftar')}
            isSubmitting={createMutation.isPending}
            serverNisError={serverNisError}
            onClearServerNisError={() => setServerNisError(null)}
          />
        ) : (
          <div className="flex min-h-64 flex-col items-center justify-center p-12 text-center">
            <h3 className="text-base font-semibold text-ink">Import Excel Data Siswa</h3>
            <p className="mt-1 text-sm text-muted">Segera hadir</p>
          </div>
        )}
      </Card>

      {/* MODAL & DIALOG & TOAST */}
      <SiswaDetailModal
        studentId={detailStudentId}
        open={Boolean(detailStudentId)}
        onClose={() => setDetailStudentId(null)}
      />

      <DeleteSiswaDialog
        student={deleteTarget}
        open={Boolean(deleteTarget)}
        onClose={() => setDeleteTarget(null)}
        onConfirm={handleDeleteConfirm}
        isDeleting={deleteMutation.isPending}
      />

      <Toast
        open={toast.open}
        message={toast.message}
        tone={toast.tone}
        onClose={() => setToast((prev) => ({ ...prev, open: false }))}
      />
    </div>
  );
}
