import katex from 'katex';
import 'katex/dist/katex.min.css';
import Badge from '../../../components/ui/Badge';
import { DBI_LATEX, DBI_COPY } from '../../../constants/kmeans';

function Formula({ latex, display = false }) {
  const html = katex.renderToString(latex, { throwOnError: false, displayMode: display });
  return <span dangerouslySetInnerHTML={{ __html: html }} />;
}

export default function DbiEvaluation({ runData }) {
  const dbiScore =
    runData?.dbiScore ?? (runData?.summary?.dbiScore ?? '-');
  const isConverged = Boolean(runData?.converged);

  const formulaRows = [
    { latex: DBI_LATEX.s_i, text: DBI_COPY.components[0] },
    { latex: DBI_LATEX.d_ij, text: DBI_COPY.components[1] },
    { latex: DBI_LATEX.r_ij, text: DBI_COPY.components[2] },
    { latex: DBI_LATEX.dbi_row, text: DBI_COPY.components[3] },
  ];

  const bullets = [
    { symbolLatex: DBI_LATEX.s_i, text: DBI_COPY.howToRead[0] },
    { symbolLatex: DBI_LATEX.d_ij, text: DBI_COPY.howToRead[1] },
    { symbolLatex: DBI_LATEX.r_ij, text: DBI_COPY.howToRead[2] },
  ];

  const paragraphText = DBI_COPY.summaryParagraph.replace('{dbi}', dbiScore);

  return (
    <div className="space-y-6 pt-2">
      {/* 1. Header & Subtitle */}
      <div>
        <h2 className="text-base font-semibold text-main">Evaluasi Davies-Bouldin Index (DBI)</h2>
        <p className="mt-0.5 text-xs text-muted">
          Validasi kualitas cluster dihitung sekali per eksekusi K-Means (FR-E03).
        </p>
      </div>

      {/* 2. Hero Formula Display */}
      <div className="rounded-lg border border-line bg-page p-4 text-center text-main overflow-x-auto">
        <Formula latex={DBI_LATEX.hero} display />
      </div>

      {/* 3. Panel Nilai Dinamis */}
      <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 rounded-lg border border-line bg-page p-4">
        <div className="space-y-1">
          <div className="text-xs font-semibold uppercase tracking-wider text-muted">DBI SCORE</div>
          <div className="flex items-center gap-3">
            <span className="font-mono text-2xl font-semibold leading-none text-main">
              {dbiScore}
            </span>
            {isConverged ? (
              <Badge tone="success">Konvergen &amp; valid</Badge>
            ) : (
              <Badge tone="danger">Tidak Konvergen</Badge>
            )}
          </div>
        </div>
        <div className="text-xs text-muted">Nilai DBI mengikuti perhitungan skripsi.</div>
      </div>

      {/* 4. Komponen Perhitungan */}
      <div className="space-y-3">
        <h3 className="text-sm font-semibold text-main">Komponen Perhitungan</h3>
        <div className="divide-y divide-line rounded-lg border border-line bg-card">
          {formulaRows.map((row, idx) => (
            <div key={idx} className="flex items-center p-3 text-xs">
              <span className="w-28 shrink-0 font-medium text-main">
                <Formula latex={row.latex} />
              </span>
              <span className="text-muted">= {row.text}</span>
            </div>
          ))}
        </div>
      </div>

      {/* 5. Cara Membaca Nilai DBI */}
      <div className="space-y-2">
        <h3 className="text-sm font-semibold text-main">Cara Membaca Nilai DBI</h3>
        <div className="space-y-1.5 text-xs text-muted">
          {bullets.map((b, idx) => (
            <div key={idx} className="flex items-center gap-1.5">
              <span>•</span>
              <span className="font-medium text-main">
                <Formula latex={b.symbolLatex} />
              </span>
              <span>{b.text}</span>
            </div>
          ))}
        </div>
      </div>

      {/* 6. Paragraf Penutup */}
      <p className="text-xs leading-relaxed text-muted">{paragraphText}</p>
    </div>
  );
}
