import { Check, X, LoaderCircle } from 'lucide-react';
import { cn } from '../../../../lib/utils';

export default function ImportStepper({ wizardState }) {
  const getStepStatus = (stepNumber) => {
    if (wizardState === 5) return 'complete';

    if (wizardState === '2-FAIL') {
      if (stepNumber === 1) return 'complete';
      if (stepNumber === 2) return 'fail';
      return 'unreached';
    }

    if (wizardState === stepNumber) return 'active';
    if (wizardState > stepNumber) return 'complete';
    return 'unreached';
  };

  const steps = [
    { number: 1, label: 'Upload' },
    { number: 2, label: 'Validasi' },
    { number: 3, label: 'Preview' },
    { number: 4, label: 'Konfirmasi' },
  ];

  return (
    <div className="p-6 border-b border-line bg-card">
      <div className="flex items-center justify-between max-w-3xl mx-auto">
        {steps.map((s, idx) => {
          const status = getStepStatus(s.number);
          return (
            <div key={s.number} className="flex items-center gap-3">
              <div className="flex items-center gap-2">
                <div
                  className={cn(
                    'flex items-center justify-center h-8 w-8 rounded-full text-xs font-semibold transition-colors',
                    status === 'complete' && 'bg-success text-on-brand',
                    status === 'active' && 'bg-brand text-on-brand ring-4 ring-brand-tint',
                    status === 'fail' && 'bg-danger text-on-brand',
                    status === 'unreached' && 'bg-page text-muted border border-line'
                  )}
                >
                  {status === 'complete' ? (
                    <Check className="h-4 w-4" />
                  ) : status === 'fail' ? (
                    <X className="h-4 w-4" />
                  ) : status === 'active' && wizardState === 2 ? (
                    <LoaderCircle className="h-4 w-4 animate-spin" />
                  ) : (
                    <span className="font-mono">{s.number}</span>
                  )}
                </div>
                <span
                  className={cn(
                    'text-sm font-semibold',
                    status === 'active' || status === 'complete'
                      ? 'text-ink'
                      : status === 'fail'
                      ? 'text-danger'
                      : 'text-muted'
                  )}
                >
                  {s.label}
                </span>
              </div>

              {idx < steps.length - 1 && (
                <div className="w-12 sm:w-16 h-0.5 bg-line mx-2" />
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}
