import { cn } from '../../lib/utils';

// Primitif form-field (dipakai CreatePeriodeDialog & tiket siswa berikutnya):
// label uppercase 12px semibold muted + control recessed (bg-input border-line,
// tinggi 40px, radius 8px) + slot error inline merah di bawah field.
export const inputClass =
  'h-10 w-full rounded-lg border border-line bg-input px-3 text-sm text-ink ' +
  'placeholder:text-faint transition-colors focus:border-brand focus:outline-none ' +
  'focus:ring-2 focus:ring-brand/30';

export function FieldLabel({ className, ...props }) {
  return (
    <label
      className={cn('mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted', className)}
      {...props}
    />
  );
}

export function FieldError({ children }) {
  if (!children) return null;
  return <p className="mt-1.5 text-sm leading-5 text-danger-text">{children}</p>;
}
