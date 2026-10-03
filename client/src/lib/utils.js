import clsx from 'clsx';
import { twMerge } from 'tailwind-merge';

// Gabung className kondisional + resolusi konflik token Tailwind (CONVENTIONS: DRY).
export function cn(...inputs) {
  return twMerge(clsx(inputs));
}
