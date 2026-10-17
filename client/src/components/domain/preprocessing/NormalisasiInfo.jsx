export default function NormalisasiInfo() {
  return (
    <div className="rounded-lg border border-line bg-card p-5 space-y-3">
      <div className="flex flex-col gap-1 sm:flex-row sm:items-center sm:justify-between">
        <h3 className="text-sm font-semibold text-ink">
          Tahap 2 &mdash; Normalisasi (Min-Max Scaling 0-1)
        </h3>
        <span className="text-xs text-muted">
          Diaplikasikan otomatis saat Transformasi dijalankan
        </span>
      </div>

      <div className="grid grid-cols-1 gap-4 rounded-lg border border-line bg-page p-4 sm:grid-cols-3">
        <div>
          <p className="text-xs uppercase tracking-wider text-muted font-medium">
            KOLOM TARGET
          </p>
          <p className="mt-1 font-mono text-sm font-semibold text-ink">
            25 Kolom
          </p>
        </div>
        <div>
          <p className="text-xs uppercase tracking-wider text-muted font-medium">
            RENTANG
          </p>
          <p className="mt-1 font-mono text-sm font-semibold text-ink">
            0 &ndash; 1
          </p>
        </div>
        <div>
          <p className="text-xs uppercase tracking-wider text-muted font-medium">
            METODE
          </p>
          <p className="mt-1 font-mono text-sm font-semibold text-ink">
            Min-Max Scaling
          </p>
        </div>
      </div>
      <p className="text-xs text-muted">
        18 Nilai Akademik + 7 Skor Bidang Non-Akademik dinormalisasi ke rentang [0, 1]. Kolom konstan otomatis bernilai 0.
      </p>
    </div>
  );
}
