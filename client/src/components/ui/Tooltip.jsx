import { useState } from 'react';
import { cn } from '../../lib/utils';

export default function Tooltip({ children, content, side = 'top', disabled = false }) {
  const [visible, setVisible] = useState(false);

  if (disabled || !content) return children;

  const sideClasses = {
    top: 'bottom-full mb-2 left-1/2 -translate-x-1/2',
    bottom: 'top-full mt-2 left-1/2 -translate-x-1/2',
    left: 'right-full mr-2 top-1/2 -translate-y-1/2',
    right: 'left-full ml-2 top-1/2 -translate-y-1/2',
  };

  return (
    <div
      className="relative inline-flex"
      onMouseEnter={() => setVisible(true)}
      onMouseLeave={() => setVisible(false)}
      onFocus={() => setVisible(true)}
      onBlur={() => setVisible(false)}
    >
      {children}
      {visible && (
        <div
          role="tooltip"
          className={cn(
            'aria-hidden:hidden absolute z-50 whitespace-nowrap rounded-md bg-ink px-2.5 py-1 text-xs font-medium text-page shadow-md transition-opacity duration-150',
            sideClasses[side] ?? sideClasses.top
          )}
        >
          {content}
        </div>
      )}
    </div>
  );
}
