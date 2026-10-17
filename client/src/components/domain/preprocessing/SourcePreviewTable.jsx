import { useRef, useEffect } from "react";
import { MAPPEL } from "../../../lib/constants";
import Button from "../../ui/Button";
import InfoBanner from "../InfoBanner";
import { ChevronLeft, ChevronRight } from "lucide-react";

const NON_AKADEMIK_COLS = [
  { key: "ekstrakurikuler", label: "Ekstrakurikuler" },
  { key: "prestasi", label: "Prestasi" },
  { key: "kemampuan", label: "Kemampuan" },
  { key: "organisasi", label: "Organisasi" },
  { key: "kursus", label: "Kursus" },
  { key: "jurusan_1", label: "Jurusan 1" },
  { key: "jurusan_2", label: "Jurusan 2" },
];

export default function SourcePreviewTable({
  jenis,
  rows = [],
  isLoading,
  isError,
  onRetry,
  page = 1,
  onPageChange,
}) {
  const containerRef = useRef(null);

  useEffect(() => {
    if (containerRef.current) {
      containerRef.current.scrollLeft = 0;
    }
  }, [jenis, page]);

  if (isLoading) {
    return (
      <div className="flex h-48 items-center justify-center rounded-lg border border-line bg-card">
        <div className="flex items-center gap-2 text-sm text-muted">
          <div className="size-4 animate-spin rounded-full border-2 border-brand border-t-transparent" />
          <span>Memuat pratinjau data sumber...</span>
        </div>
      </div>
    );
  }

  if (isError) {
    return (
      <div className="space-y-3">
        <InfoBanner>
          Gagal mengambil pratinjau data sumber dari server.
        </InfoBanner>
        <div className="flex justify-start">
          <Button variant="outline" onClick={onRetry}>
            Coba Lagi
          </Button>
        </div>
      </div>
    );
  }

  const columns = jenis === "non_akademik" ? NON_AKADEMIK_COLS : MAPPEL;
  const isAkademik = jenis !== "non_akademik";

  const limit = 10;
  const total = rows.length;
  const totalPages = Math.ceil(total / limit) || 1;
  const currentPage = Math.min(Math.max(1, page), totalPages);
  const startIndex = (currentPage - 1) * limit;
  const endIndex = Math.min(startIndex + limit, total);
  const pageRows = rows.slice(startIndex, endIndex);

  return (
    <div className="space-y-3">
      <div ref={containerRef} className="w-full overflow-x-auto rounded-lg border border-line bg-card shadow-inner">
        <table className="w-full table-fixed border-separate border-spacing-0 text-left text-sm min-w-max">
          <colgroup>
            <col className="w-[110px]" />
            <col className="w-44" />
            {columns.map((col) => (
              <col key={col.key} className="w-[140px]" />
            ))}
          </colgroup>
          <thead>
            <tr className="bg-page text-xs font-semibold uppercase tracking-wider text-muted">
              <th className="sticky left-0 z-30 w-[110px] min-w-[110px] max-w-[110px] bg-page px-4 py-3 border-b border-r border-line">
                NIS
              </th>
              <th className="sticky left-[110px] z-30 w-44 min-w-44 max-w-44 bg-page px-4 py-3 border-b border-r border-line">
                Nama Siswa
              </th>
              {columns.map((col) => (
                <th key={col.key} className="bg-page whitespace-nowrap px-4 py-3 border-b border-r border-line/40">
                  {col.label}
                </th>
              ))}
            </tr>
          </thead>
          <tbody className="divide-y divide-line text-ink">
            {pageRows.length === 0 ? (
              <tr>
                <td
                  colSpan={columns.length + 2}
                  className="px-4 py-8 text-center text-sm text-muted bg-card border-b border-line"
                >
                  Tidak ada data pratinjau sumber.
                </td>
              </tr>
            ) : (
              pageRows.map((row, idx) => (
                <tr
                  key={row.nis || idx}
                >
                  <td className="sticky left-0 z-20 w-[110px] min-w-[110px] max-w-[110px] bg-card whitespace-nowrap px-4 py-3 font-mono text-sm font-medium text-ink border-b border-r border-line">
                    {row.nis || "-"}
                  </td>
                  <td className="sticky left-[110px] z-20 w-44 min-w-44 max-w-44 bg-card whitespace-nowrap px-4 py-3 text-sm font-medium text-ink border-b border-r border-line truncate">
                    {row.nama || "-"}
                  </td>
                  {columns.map((col) => {
                    const rawVal = row.values?.[col.key];
                    const isEmpty =
                      rawVal === null ||
                      rawVal === undefined ||
                      rawVal === "" ||
                      rawVal === "-";

                    let displayVal;
                    if (isEmpty) {
                      displayVal = "-";
                    } else if (isAkademik) {
                      const num = Number(rawVal);
                      displayVal = Number.isNaN(num) ? rawVal : num;
                    } else {
                      displayVal = rawVal;
                    }

                    return (
                      <td
                        key={col.key}
                        className={`bg-card whitespace-nowrap px-4 py-3 text-sm border-b border-r border-line/40 truncate ${
                          isEmpty ? "font-semibold text-warning" : isAkademik ? "font-mono text-ink" : "text-ink"
                        }`}
                      >
                        {displayVal}
                      </td>
                    );
                  })}
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>

      {total > 0 && (
        <div className="flex flex-wrap items-center justify-between gap-3 pt-1 text-xs text-muted">
          <div>
            Menampilkan {total > 0 ? startIndex + 1 : 0}-{endIndex} dari {total} baris
          </div>
          {totalPages > 1 && (
            <div className="flex items-center gap-1">
              <Button
                variant="outline"
                size="icon"
                className="h-8 w-8"
                disabled={currentPage === 1}
                onClick={() => onPageChange?.(currentPage - 1)}
                aria-label="Halaman sebelumnya"
              >
                <ChevronLeft size={16} />
              </Button>
              <span className="px-2 font-medium text-ink">
                {currentPage} / {totalPages}
              </span>
              <Button
                variant="outline"
                size="icon"
                className="h-8 w-8"
                disabled={currentPage === totalPages}
                onClick={() => onPageChange?.(currentPage + 1)}
                aria-label="Halaman berikutnya"
              >
                <ChevronRight size={16} />
              </Button>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
