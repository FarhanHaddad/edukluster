import { cva } from 'class-variance-authority';
import { cn } from '../../lib/utils';

// Button primitif: solid (CTA utama), outline (sekunder), emphasis (varian brand-tint).
// Geometry terkunci: tinggi 40px, radius 8px, teks 14px semibold (DESIGN.md 8pt grid).
const buttonVariants = cva(
  'inline-flex h-10 items-center justify-center gap-2 rounded-lg px-4 text-sm font-semibold transition-colors ' +
    'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand/40 ' +
    'disabled:pointer-events-none disabled:bg-disabled-bg disabled:text-disabled-text',
  {
    variants: {
      variant: {
        // CTA solid: light #A64DC4/hover #8F39AC/active #793191; dark #BE7DD4/#B266CC, on-brand #18181B.
        solid: 'bg-brand text-on-brand hover:bg-brand-hover active:bg-brand-active',
        // Outline: transparan, border kuat, teks ink (DARK MODE CONTRACT).
        outline: 'border border-line-strong bg-transparent text-ink hover:bg-brand-tint',
        // Emphasis: aksi brand-contextual (mis. Jalankan Preprocessing / Eksekusi K-Means).
        emphasis: 'bg-brand-tint text-brand hover:bg-brand hover:text-on-brand',
        // Destructive: aksi destruktif (mis. Hapus Admin).
        destructive: 'bg-danger text-on-brand hover:brightness-95 active:brightness-90',
        // Alias variant danger untuk kompatibilitas
        danger: 'bg-danger text-on-brand hover:brightness-95 active:brightness-90',
      },
      size: {
        md: 'h-10 px-4',
        icon: 'h-10 w-10 px-0',
      },
    },
    defaultVariants: {
      variant: 'solid',
      size: 'md',
    },
  }
);

export default function Button({ className, variant, size, type = 'button', ...props }) {
  return <button type={type} className={cn(buttonVariants({ variant, size }), className)} {...props} />;
}

export { buttonVariants };
