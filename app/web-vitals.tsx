'use client';

import { useCallback } from 'react';
import { useReportWebVitals } from 'next/web-vitals';

declare global {
  interface Window {
    plausible?: (event: string, opts?: { props?: Record<string, unknown> }) => void;
  }
}

export function WebVitals() {
  const report = useCallback((metric: { name: string; value: number; rating?: string }) => {
    window.plausible?.('Web Vitals', {
      props: {
        metric: metric.name,
        value: Math.round(metric.value),
        rating: metric.rating || 'unknown',
        page: window.location.pathname,
      },
    });
  }, []);

  useReportWebVitals(report);
  return null;
}
