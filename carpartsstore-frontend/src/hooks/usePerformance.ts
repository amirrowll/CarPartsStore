import { useEffect, useRef } from 'react';

interface PerformanceMetrics {
  fcp?: number; // First Contentful Paint
  lcp?: number; // Largest Contentful Paint
  fid?: number; // First Input Delay
  cls?: number; // Cumulative Layout Shift
  ttfb?: number; // Time to First Byte
}

interface PerformanceEntryHandler {
  (entry: PerformanceEntry): void;
}

/**
 * Hook for monitoring web performance metrics
 */
export function usePerformance() {
  const metricsRef = useRef<PerformanceMetrics>({});
  const observerRef = useRef<PerformanceObserver | null>(null);

  // Initialize performance monitoring
  useEffect(() => {
    if (typeof window === 'undefined' || !('PerformanceObserver' in window)) {
      return;
    }

    // Track FCP (First Contentful Paint)
    const fcpObserver = new PerformanceObserver((list) => {
      const entries = list.getEntries();
      entries.forEach((entry) => {
        if (entry.name === 'first-contentful-paint') {
          metricsRef.current.fcp = Math.round(entry.startTime);
          
        }
      });
    });

    // Track LCP (Largest Contentful Paint)
    const lcpObserver = new PerformanceObserver((list) => {
      const entries = list.getEntries();
      entries.forEach((entry) => {
        if (entry.entryType === 'largest-contentful-paint') {
          metricsRef.current.lcp = Math.round(entry.startTime);
          
        }
      });
    });

    // Track CLS (Cumulative Layout Shift)
    const clsObserver = new PerformanceObserver((list) => {
      const entries = list.getEntries();
      entries.forEach((entry) => {
        if (entry.entryType === 'layout-shift' && !entry.hadRecentInput) {
          metricsRef.current.cls = (metricsRef.current.cls || 0) + (entry as any).value;
          
        }
      });
    });

    // Track FID (First Input Delay)
    const fidObserver = new PerformanceObserver((list) => {
      const entries = list.getEntries();
      entries.forEach((entry) => {
        if (entry.entryType === 'first-input') {
          metricsRef.current.fid = Math.round((entry as any).processingStart - entry.startTime);
          
        }
      });
    });

    // Start observing
    try {
      fcpObserver.observe({ type: 'paint', buffered: true });
      lcpObserver.observe({ type: 'largest-contentful-paint', buffered: true });
      clsObserver.observe({ type: 'layout-shift', buffered: true });
      fidObserver.observe({ type: 'first-input', buffered: true });
    } catch (e) {
      
    }

    // Track TTFB (Time to First Byte)
    if (performance.timing) {
      const ttfb = performance.timing.responseStart - performance.timing.requestStart;
      metricsRef.current.ttfb = Math.round(ttfb);
      
    }

    // Cleanup
    return () => {
      fcpObserver.disconnect();
      lcpObserver.disconnect();
      clsObserver.disconnect();
      fidObserver.disconnect();
    };
  }, []);

  /**
   * Measure custom performance mark
   */
  const mark = (name: string) => {
    if (typeof window !== 'undefined' && 'performance' in window) {
      performance.mark(name);
    }
  };

  /**
   * Measure time between two marks
   */
  const measure = (name: string, startMark: string, endMark: string) => {
    if (typeof window !== 'undefined' && 'performance' in window) {
      performance.measure(name, startMark, endMark);
      const entries = performance.getEntriesByName(name);
      if (entries.length > 0) {
        return Math.round(entries[0].duration);
      }
    }
    return 0;
  };

  /**
   * Get current performance metrics
   */
  const getMetrics = () => ({ ...metricsRef.current });

  /**
   * Check if metrics meet performance thresholds
   */
  const checkPerformance = (): { passed: boolean; issues: string[] } => {
    const metrics = getMetrics();
    const issues: string[] = [];

    // Lighthouse thresholds
    if (metrics.fcp && metrics.fcp > 1800) {
      issues.push(`FCP is too high: ${metrics.fcp}ms (should be < 1800ms)`);
    }
    if (metrics.lcp && metrics.lcp > 2500) {
      issues.push(`LCP is too high: ${metrics.lcp}ms (should be < 2500ms)`);
    }
    if (metrics.fid && metrics.fid > 100) {
      issues.push(`FID is too high: ${metrics.fid}ms (should be < 100ms)`);
    }
    if (metrics.cls && metrics.cls > 0.1) {
      issues.push(`CLS is too high: ${metrics.cls} (should be < 0.1)`);
    }
    if (metrics.ttfb && metrics.ttfb > 600) {
      issues.push(`TTFB is too high: ${metrics.ttfb}ms (should be < 600ms)`);
    }

    return {
      passed: issues.length === 0,
      issues,
    };
  };

  /**
   * Send performance data to analytics
   */
  const sendToAnalytics = (customData?: Record<string, any>) => {
    const metrics = getMetrics();
    const performanceData = {
      ...metrics,
      ...customData,
      timestamp: new Date().toISOString(),
      userAgent: navigator.userAgent,
      connection: (navigator as any).connection?.effectiveType || 'unknown',
    };

    // Send to your analytics service
    
    
    // Example: Send to Google Analytics
    if ((window as any).gtag) {
      (window as any).gtag('event', 'performance', performanceData);
    }
  };

  return {
    mark,
    measure,
    getMetrics,
    checkPerformance,
    sendToAnalytics,
  };
}

/**
 * Hook for monitoring resource loading performance
 */
export function useResourceTiming() {
  useEffect(() => {
    if (typeof window === 'undefined' || !('PerformanceObserver' in window)) {
      return;
    }

    const resourceObserver = new PerformanceObserver((list) => {
      const entries = list.getEntries();
      
      entries.forEach((entry) => {
        const resourceEntry = entry as PerformanceResourceTiming;
        
        // Log slow resources
        if (resourceEntry.duration > 1000) {
          console.warn('Slow resource loaded:', {
            name: resourceEntry.name,
            duration: Math.round(resourceEntry.duration),
            type: resourceEntry.initiatorType,
            size: resourceEntry.transferSize,
          });
        }
      });
    });

    try {
      resourceObserver.observe({ type: 'resource', buffered: true });
    } catch (e) {
      
    }

    return () => resourceObserver.disconnect();
  }, []);
}

/**
 * Hook for monitoring long tasks (blocking main thread)
 */
export function useLongTaskMonitoring() {
  useEffect(() => {
    if (typeof window === 'undefined' || !('PerformanceObserver' in window)) {
      return;
    }

    const longTaskObserver = new PerformanceObserver((list) => {
      const entries = list.getEntries();
      
      entries.forEach((entry) => {
        const longTaskEntry = entry as PerformanceLongTaskTiming;
        
        // Log long tasks (> 50ms)
        if (longTaskEntry.duration > 50) {
          console.warn('Long task detected:', {
            duration: Math.round(longTaskEntry.duration),
            startTime: Math.round(longTaskEntry.startTime),
            attribution: longTaskEntry.attribution,
          });
        }
      });
    });

    try {
      longTaskObserver.observe({ type: 'longtask', buffered: true });
    } catch (e) {
      
    }

    return () => longTaskObserver.disconnect();
  }, []);
}