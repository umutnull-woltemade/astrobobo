'use client';

import { useReportWebVitals } from 'next/web-vitals';

export function WebVitals() {
  useReportWebVitals((metric) => {
    // Send to Plausible as custom event
    if (typeof window !== 'undefined' && (window as any).plausible) {
      (window as any).plausible('Web Vitals', {
        props: {
          metric: metric.name,
          value: Math.round(metric.value),
          rating: metric.rating || 'unknown',
          page: window.location.pathname,
        },
      });
    }
  });

  return null;
}
