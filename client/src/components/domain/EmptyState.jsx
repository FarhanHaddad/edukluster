import { Link } from 'react-router-dom';
import Card from '../ui/Card';
import Button from '../ui/Button';
import { cn } from '../../lib/utils';

// EmptyState Screen 2 State A/C: ikon + heading + deskripsi + CTA solid brand
// (opsional link teks) + slot step cards. Komposisi murni dari primitif ui/.
export default function EmptyState({
  icon: Icon,
  title,
  description,
  ctaLabel,
  ctaTo,
  linkLabel,
  linkTo,
  children,
  className,
}) {
  return (
    <Card className={cn('flex flex-col items-center px-6 py-12 text-center', className)}>
      {Icon ? (
        <div className="mb-4 flex size-12 items-center justify-center rounded-lg bg-brand-tint">
          <Icon size={24} className="text-brand" aria-hidden="true" />
        </div>
      ) : null}
      <h2 className="text-base font-semibold leading-6 text-ink">{title}</h2>
      {description ? (
        <p className="mt-2 max-w-md text-sm leading-5 text-muted">{description}</p>
      ) : null}

      {(ctaLabel || linkLabel) && (
        <div className="mt-6 flex flex-wrap items-center justify-center gap-3">
          {ctaLabel ? (
            <Link to={ctaTo}>
              {/* Link membungkus tombol: isi penuh agar tinggi tetap 40px */}
              <Button variant="solid" className="w-full sm:w-auto">
                {ctaLabel}
              </Button>
            </Link>
          ) : null}
          {linkLabel ? (
            <Link
              to={linkTo}
              className="text-sm font-semibold text-brand underline-offset-4 hover:underline"
            >
              {linkLabel}
            </Link>
          ) : null}
        </div>
      )}

      {children ? <div className="mt-8 w-full">{children}</div> : null}
    </Card>
  );
}
