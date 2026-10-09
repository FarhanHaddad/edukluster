import { ChevronLeft, ChevronRight } from 'lucide-react';
import { APP_VERSION } from '../../../lib/constants';
import { formatAngka } from '../../../lib/format';
import Button from '../../ui/Button';

export default function SiswaPagination({
  page = 1,
  limit = 10,
  total = 0,
  onPageChange,
}) {
  const totalPages = Math.max(1, Math.ceil(total / limit));
  const from = total === 0 ? 0 : (page - 1) * limit + 1;
  const to = Math.min(page * limit, total);

  // Generates page number buttons list with ellipsis if needed
  const getPageNumbers = () => {
    const pages = [];
    if (totalPages <= 7) {
      for (let i = 1; i <= totalPages; i++) pages.push(i);
    } else {
      pages.push(1);
      if (page > 3) pages.push('...');
      const start = Math.max(2, page - 1);
      const end = Math.min(totalPages - 1, page + 1);
      for (let i = start; i <= end; i++) pages.push(i);
      if (page < totalPages - 2) pages.push('...');
      pages.push(totalPages);
    }
    return pages;
  };

  return (
    <div className="flex flex-wrap items-center justify-between gap-4 border-t border-line px-6 py-4 text-sm">
      {/* Left info */}
      <div className="text-muted">
        Menampilkan{' '}
        <span className="font-mono font-medium text-ink">
          {formatAngka(from)}-{formatAngka(to)}
        </span>{' '}
        dari <span className="font-mono font-medium text-ink">{formatAngka(total)}</span> siswa
      </div>

      {/* Center pagination controls */}
      <div className="flex items-center gap-1.5">
        <Button
          variant="outline"
          size="md"
          disabled={page <= 1}
          onClick={() => onPageChange(page - 1)}
          aria-label="Halaman sebelumnya"
          className="h-9 px-2.5"
        >
          <ChevronLeft size={16} aria-hidden="true" />
          <span className="hidden sm:inline">Sebelumnya</span>
        </Button>

        {getPageNumbers().map((p, idx) => {
          if (p === '...') {
            return (
              <span key={`ellipsis-${idx}`} className="px-2 text-muted select-none">
                ...
              </span>
            );
          }

          const isActive = p === page;
          return (
            <button
              key={p}
              type="button"
              onClick={() => onPageChange(p)}
              className={
                isActive
                  ? 'flex h-9 min-w-[36px] items-center justify-center rounded-lg bg-brand text-on-brand font-semibold text-sm transition-colors'
                  : 'flex h-9 min-w-[36px] items-center justify-center rounded-lg border border-line bg-card text-ink font-medium text-sm hover:bg-line transition-colors'
              }
            >
              {p}
            </button>
          );
        })}

        <Button
          variant="outline"
          size="md"
          disabled={page >= totalPages || total === 0}
          onClick={() => onPageChange(page + 1)}
          aria-label="Halaman selanjutnya"
          className="h-9 px-2.5"
        >
          <span className="hidden sm:inline">Selanjutnya</span>
          <ChevronRight size={16} aria-hidden="true" />
        </Button>
      </div>

      {/* Right app version */}
      <div className="font-mono text-xs text-muted">
        EduCluster <span className="text-ink font-semibold">{APP_VERSION}</span>
      </div>
    </div>
  );
}
