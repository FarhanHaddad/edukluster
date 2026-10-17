import { useEffect } from 'react';
import { createPortal } from 'react-dom';
import { AlertTriangle, CheckCircle2, AlertCircle, X } from 'lucide-react';
import { cn } from '../../../lib/utils';

export default function Toast({
  open,
  message,
  title,
  description,
  tone = 'danger',
  onClose,
  autoDismiss = 5000,
}) {
  useEffect(() => {
    if (!open || !autoDismiss) return undefined;
    const timer = setTimeout(() => {
      onClose?.();
    }, autoDismiss);
    return () => clearTimeout(timer);
  }, [open, autoDismiss, onClose]);

  if (!open || (!message && !title && !description)) return null;

  const isSuccess = tone === 'success';

  return createPortal(
    <div
      role="status"
      aria-live="polite"
      className={cn(
        'fixed bottom-4 right-4 z-50 flex max-w-md items-center justify-between gap-3 rounded-lg border p-4 shadow-lg transition-all duration-200',
        isSuccess
          ? 'border-success/30 bg-elevated text-ink'
          : 'border-danger/30 bg-elevated text-ink'
      )}
    >
      <div className="flex items-start gap-3 min-w-0">
        <div
          className={cn(
            'flex size-8 shrink-0 items-center justify-center rounded-full mt-0.5',
            isSuccess ? 'bg-success-tint text-success' : 'bg-danger-tint text-danger-text'
          )}
        >
          {isSuccess ? (
            <CheckCircle2 size={18} aria-hidden="true" />
          ) : tone === 'warning' ? (
            <AlertCircle size={18} aria-hidden="true" />
          ) : (
            <AlertTriangle size={18} aria-hidden="true" />
          )}
        </div>
        <div className="min-w-0 flex-1">
          {title ? (
            <p className="text-sm font-semibold text-ink">{title}</p>
          ) : null}
          {(description || message) ? (
            <p className={cn(title ? 'text-xs text-muted mt-0.5' : 'text-sm font-medium leading-5 text-ink')}>
              {description || message}
            </p>
          ) : null}
        </div>
      </div>
      <button
        type="button"
        onClick={onClose}
        className="shrink-0 rounded-md p-1 text-muted hover:bg-line hover:text-ink transition-colors"
        aria-label="Tutup notifikasi"
      >
        <X size={16} aria-hidden="true" />
      </button>
    </div>,
    document.body
  );
}
