import { cn } from '../../lib/utils';

// Card primitif: permukaan satu step lebih terang dari page (light #FFF vs #F4F4F5;
// dark #18181B vs #09090B), border line, radius 8px, shadow minimal, padding 24px.
export default function Card({ as: Tag = 'div', className, padded = true, ...props }) {
  return (
    <Tag
      className={cn(
        'rounded-lg border border-line bg-card shadow-sm',
        padded && 'p-6',
        className
      )}
      {...props}
    />
  );
}
