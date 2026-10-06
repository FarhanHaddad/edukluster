import { useState } from 'react';
import { ChevronLeft, ChevronRight, Plus, UserCog } from 'lucide-react';
import useAdmins from '../hooks/useAdmins';
import usePeriodes from '../hooks/usePeriodes';
import { useAuth } from '../context/AuthContext';
import PageHeader from '../components/domain/PageHeader';
import PeriodChip from '../components/domain/PeriodChip';
import AdminTable from '../components/domain/AdminTable';
import CreateAdminDialog from '../components/domain/CreateAdminDialog';
import EditAdminDialog from '../components/domain/EditAdminDialog';
import DeleteAdminDialog from '../components/domain/DeleteAdminDialog';
import EmptyState from '../components/domain/EmptyState';
import Card from '../components/ui/Card';
import Button from '../components/ui/Button';

export default function AdminPage() {
  const { admin: currentAdmin } = useAuth();
  const { data: periodesData } = usePeriodes();
  const { data, isLoading } = useAdmins();

  const items = data?.items ?? [];
  const total = data?.total ?? items.length;

  const activePeriode = periodesData?.items?.find((p) => p.status === 'AKTIF') ?? null;

  const [createOpen, setCreateOpen] = useState(false);
  const [editTarget, setEditTarget] = useState(null);
  const [deleteTarget, setDeleteTarget] = useState(null);

  return (
    <div className="space-y-6">
      <PageHeader
        title="Manajemen Admin"
        description="Kelola akun admin yang memiliki akses ke sistem (FR-A03)."
        periodChip={activePeriode ? <PeriodChip namaPeriode={activePeriode.namaPeriode} /> : null}
      />

      <Card padded={false}>
        <div className="flex flex-wrap items-center justify-between gap-3 border-b border-line px-6 py-4">
          <h2 className="text-sm font-semibold text-ink">Daftar Admin</h2>
          <Button onClick={() => setCreateOpen(true)}>
            <Plus size={16} aria-hidden="true" />
            Tambah Admin
          </Button>
        </div>

        {isLoading ? (
          <div className="px-6 py-10 text-center text-sm text-muted">Memuat data admin...</div>
        ) : items.length === 0 ? (
          <div className="border-t border-line p-6">
            <EmptyState
              icon={UserCog}
              title="Belum Ada Admin"
              description="Tambahkan akun admin pertama untuk memberikan akses ke sistem."
              ctaLabel="Tambah Admin"
              onCtaClick={() => setCreateOpen(true)}
            />
          </div>
        ) : (
          <>
            <AdminTable
              items={items}
              currentAdminId={currentAdmin?.id}
              currentAdminUsername={currentAdmin?.username ?? 'satnaing'}
              onEdit={setEditTarget}
              onDelete={setDeleteTarget}
            />

            <div className="flex flex-wrap items-center justify-between gap-3 border-t border-line px-6 py-4 text-xs text-muted">
              <p>Menampilkan 1-{items.length} dari {total} admin</p>
              <div className="flex items-center gap-1">
                <Button variant="outline" size="sm" disabled className="h-8 w-8 p-0">
                  <ChevronLeft size={16} aria-hidden="true" />
                  <span className="sr-only">Halaman sebelumnya</span>
                </Button>
                <Button variant="outline" size="sm" className="h-8 w-8 bg-brand-tint font-semibold text-brand border-brand-border p-0">
                  1
                </Button>
                <Button variant="outline" size="sm" disabled className="h-8 w-8 p-0">
                  <ChevronRight size={16} aria-hidden="true" />
                  <span className="sr-only">Halaman berikutnya</span>
                </Button>
              </div>
            </div>
          </>
        )}
      </Card>

      <CreateAdminDialog open={createOpen} onClose={() => setCreateOpen(false)} />
      <EditAdminDialog open={!!editTarget} admin={editTarget} onClose={() => setEditTarget(null)} />
      <DeleteAdminDialog open={!!deleteTarget} admin={deleteTarget} onClose={() => setDeleteTarget(null)} />
    </div>
  );
}
