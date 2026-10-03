import { cva } from 'class-variance-authority';
import { cn } from '../../lib/utils';

// Badge primitif: soft tinted badge saja (tint 10-15% + teks solid) — DESIGN.md.
const badgeVariants = cva(
  'inline-flex items-center gap-1.5 rounded-full border px-2.5 py-0.5 text-xs font-semibold leading-4',
  {
    variants: {
      tone: {
        neutral: 'border-line bg-page text-muted',
        brand: 'border-transparent bg-brand-tint text-brand',
        success: 'border-transparent bg-success-tint text-success',
        warning: 'border-transparent bg-warning-tint text-warning',
        danger: 'border-transparent bg-danger-tint text-danger-text',
        info: 'border-transparent bg-info-tint text-info',
      },
    },
    defaultVariants: {
      tone: 'neutral',
    },
  }
);

export default function Badge({ className, tone, ...props }) {
  return <span className={cn(badgeVariants({ tone }), className)} {...props} />;
}

export { badgeVariants };
