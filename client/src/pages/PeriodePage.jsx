import { useState } from 'react';
import { CalendarDays, Plus } from 'lucide-react';
import usePeriodes from '../hooks/usePeriodes';
import PageHeader from '../components/domain/PageHeader';
import PeriodChip from '../components/domain/PeriodChip';
import PeriodeTable from '../components/domain/PeriodeTable';
import CreatePeriodeDialog from '../components/domain/CreatePeriodeDialog';
import ActivatePeriodeDialog from '../components/domain/ActivatePeriodeDialog';
import EmptyState from '../components/domain/EmptyState';
import Card from '../components/ui/Card';
import Button from '../components/ui/Button';

// Screen 3 Periode (frame 3A-3D) — HANYA komposisi; tabel & dialog di domain/.
export default function PeriodePage() {
  const { data, isLoading } = usePeriodes();
  const items = data?.items ?? [];

  // PeriodChip dari item berstatus AKTIF pada list yang sama — TANPA request tambahan.
  const aktifNow = items.find((p) => p.status === 'AKTIF') ?? null;

  const [createOpen, setCreateOpen] = useState(false);
  const [activateTarget, setActivateTarget] = useState(null);

  return (
    <div className="space-y-6">
      <PageHeader
        title="Periode"
        active={!!aktifNow}
        description="Kelola periode akademik klasterisasi. Satu periode dapat aktif pada satu waktu."
        periodChip={aktifNow ? <PeriodChip namaPeriode={aktifNow.namaPeriode} /> : null}
      />

      <Card padded={false}>
        {/* Header kartu: sub-judul "Daftar Periode" + CTA solid brand */}
        <div className="flex flex-wrap items-center justify-between gap-3 border-b border-line px-6 py-4">
          <h2 className="text-sm font-semibold text-ink">Daftar Periode</h2>
          <Button onClick={() => setCreateOpen(true)}>
            <Plus size={16} aria-hidden="true" />
            Tambah Periode
          </Button>
        </div>

        {isLoading ? (
          <div className="px-6 py-10 text-center text-sm text-muted">Memuat data...</div>
        ) : items.length === 0 ? (
          // List kosong -> EmptyState dengan CTA buka dialog create (bukan link).
          <div className="border-t border-line p-6">
            <EmptyState
              icon={CalendarDays}
              title="Belum Ada Periode"
              description="Buat periode pertama untuk memulai alur klasterisasi siswa."
              ctaLabel="Tambah Periode"
              onCtaClick={() => setCreateOpen(true)}
            />
          </div>
        ) : (
          <PeriodeTable items={items} activeId={aktifNow?.id} onActivate={setActivateTarget} />
        )}
      </Card>

      <CreatePeriodeDialog open={createOpen} onClose={() => setCreateOpen(false)} />
      <ActivatePeriodeDialog
        open={!!activateTarget}
        periode={activateTarget}
        aktifNow={aktifNow}
        onClose={() => setActivateTarget(null)}
      />
    </div>
  );
}
