import { forwardRef, useState } from 'react';
import { Eye, EyeOff } from 'lucide-react';
import { cn } from '../../lib/utils';
import { FieldLabel, FieldError } from './Field';

const PasswordField = forwardRef(function PasswordField(
  { label, required, error, className, id, name, placeholder, ...props },
  ref
) {
  const [showPassword, setShowPassword] = useState(false);

  return (
    <div className={className}>
      {label && (
        <FieldLabel htmlFor={id || name}>
          {label} {required && <span className="text-brand">*</span>}
        </FieldLabel>
      )}
      <div className="relative">
        <input
          ref={ref}
          id={id || name}
          name={name}
          type={showPassword ? 'text' : 'password'}
          placeholder={placeholder}
          className={cn(
            'h-10 w-full rounded-lg border bg-input pl-3 pr-10 text-sm text-ink placeholder:text-faint transition-colors focus:outline-none focus:ring-2 focus:ring-brand/30',
            error
              ? 'border-danger-text focus:border-danger-text focus:ring-danger-text/30'
              : 'border-line focus:border-brand'
          )}
          {...props}
        />
        <button
          type="button"
          onClick={() => setShowPassword((prev) => !prev)}
          tabIndex={-1}
          className="absolute right-3 top-1/2 -translate-y-1/2 text-muted hover:text-ink focus:outline-none"
          aria-label={showPassword ? 'Sembunyikan password' : 'Tampilkan password'}
        >
          {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
        </button>
      </div>
      <FieldError>{error}</FieldError>
    </div>
  );
});

export default PasswordField;
