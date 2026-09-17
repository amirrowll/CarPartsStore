/**
 * Performance configuration for Pinpart Store
 * Centralized configuration for all performance optimizations
 */

export interface PerformanceConfig {
  // Image optimization
  images: {
    enabled: boolean;
    formats: ('webp' | 'avif' | 'jpg' | 'png')[];
    quality: {
      thumbnail: number;
      small: number;
      medium: number;
      large: number;
      original: number;
    };
    sizes: {
      thumbnail: { width: number; height: number };
      small: { width: number; height: number };
      medium: { width: number; height: number };
      large: { width: number; height: number };
      hero: { width: number; height: number };
    };
    lazyLoading: boolean;
    placeholder: boolean;
    srcset: boolean;
  };
  
  // JavaScript optimization
  javascript: {
    enabled: boolean;
    codeSplitting: boolean;
    treeShaking: boolean;
    minification: boolean;
    compression: boolean;
    deferNonCritical: boolean;
    chunkSizeLimit: number; // in KB
  };
  
  // CSS optimization
  css: {
    enabled: boolean;
    criticalCSS: boolean;
    purgeUnused: boolean;
    minification: boolean;
    inlineCritical: boolean;
  };
  
  // Caching strategy
  caching: {
    enabled: boolean;
    serviceWorker: boolean;
    staticAssets: {
      maxAge: number; // in seconds
      immutable: boolean;
    };
    apiResponses: {
      maxAge: number; // in seconds
      staleWhileRevalidate: number; // in seconds
    };
    cdn: boolean;
  };
  
  // Network optimization
  network: {
    enabled: boolean;
    http2: boolean;
    compression: boolean;
    preconnect: string[];
    prefetch: string[];
    preload: string[];
    dnsPrefetch: string[];
  };
  
  // Monitoring and analytics
  monitoring: {
    enabled: boolean;
    realUserMonitoring: boolean;
    syntheticMonitoring: boolean;
    errorTracking: boolean;
    performanceMetrics: boolean;
    analyticsIntegration: boolean;
  };
  
  // Development optimizations
  development: {
    enabled: boolean;
    hotModuleReloading: boolean;
    fastRefresh: boolean;
    sourceMaps: boolean;
    bundleAnalyzer: boolean;
  };
}

// Default performance configuration
export const defaultPerformanceConfig: PerformanceConfig = {
  images: {
    enabled: true,
    formats: ['webp', 'jpg'],
    quality: {
      thumbnail: 60,
      small: 70,
      medium: 80,
      large: 85,
      original: 90,
    },
    sizes: {
      thumbnail: { width: 150, height: 150 },
      small: { width: 300, height: 300 },
      medium: { width: 600, height: 400 },
      large: { width: 1200, height: 800 },
      hero: { width: 1920, height: 1080 },
    },
    lazyLoading: true,
    placeholder: true,
    srcset: true,
  },
  
  javascript: {
    enabled: true,
    codeSplitting: true,
    treeShaking: true,
    minification: true,
    compression: true,
    deferNonCritical: true,
    chunkSizeLimit: 500, // 500KB
  },
  
  css: {
    enabled: true,
    criticalCSS: true,
    purgeUnused: true,
    minification: true,
    inlineCritical: true,
  },
  
  caching: {
    enabled: true,
    serviceWorker: true,
    staticAssets: {
      maxAge: 31536000, // 1 year
      immutable: true,
    },
    apiResponses: {
      maxAge: 300, // 5 minutes
      staleWhileRevalidate: 86400, // 1 day
    },
    cdn: true,
  },
  
  network: {
    enabled: true,
    http2: true,
    compression: true,
    preconnect: [
      'https://fonts.googleapis.com',
      'https://fonts.gstatic.com',
      'https://cdn-icons-png.flaticon.com',
    ],
    prefetch: [
      '/products',
      '/chinese-parts',
      '/saipa-parts',
    ],
    preload: [
      '/optimized/PinpartStore.JPEG.webp',
      '/optimized/hero.webp',
      '/src/main.tsx',
    ],
    dnsPrefetch: [
      'https://cdn-icons-png.flaticon.com',
      'https://fonts.googleapis.com',
      'https://fonts.gstatic.com',
    ],
  },
  
  monitoring: {
    enabled: true,
    realUserMonitoring: true,
    syntheticMonitoring: true,
    errorTracking: true,
    performanceMetrics: true,
    analyticsIntegration: true,
  },
  
  development: {
    enabled: process.env.NODE_ENV === 'development',
    hotModuleReloading: true,
    fastRefresh: true,
    sourceMaps: false, // Disabled in production
    bundleAnalyzer: true,
  },
};

// Environment-specific configurations
export const productionConfig: Partial<PerformanceConfig> = {
  javascript: {
    ...defaultPerformanceConfig.javascript,
    minification: true,
    compression: true,
    chunkSizeLimit: 500,
  },
  css: {
    ...defaultPerformanceConfig.css,
    minification: true,
    inlineCritical: true,
  },
  caching: {
    ...defaultPerformanceConfig.caching,
    enabled: true,
    serviceWorker: true,
  },
  development: {
    ...defaultPerformanceConfig.development,
    enabled: false,
    sourceMaps: false,
  },
};

export const developmentConfig: Partial<PerformanceConfig> = {
  javascript: {
    ...defaultPerformanceConfig.javascript,
    minification: false,
    compression: false,
    chunkSizeLimit: 1000,
  },
  css: {
    ...defaultPerformanceConfig.css,
    minification: false,
    inlineCritical: false,
  },
  caching: {
    ...defaultPerformanceConfig.caching,
    enabled: false,
    serviceWorker: false,
  },
  development: {
    ...defaultPerformanceConfig.development,
    enabled: true,
    sourceMaps: true,
  },
};

// Get configuration based on environment
export function getPerformanceConfig(): PerformanceConfig {
  const baseConfig = { ...defaultPerformanceConfig };
  
  if (process.env.NODE_ENV === 'production') {
    return {
      ...baseConfig,
      ...productionConfig,
    };
  }
  
  return {
    ...baseConfig,
    ...developmentConfig,
  };
}

// Performance thresholds
export const PERFORMANCE_THRESHOLDS = {
  // Lighthouse thresholds
  lighthouse: {
    performance: 90,
    accessibility: 90,
    bestPractices: 90,
    seo: 90,
  },
  
  // Core Web Vitals thresholds
  coreWebVitals: {
    fcp: 1800, // First Contentful Paint (ms)
    lcp: 2500, // Largest Contentful Paint (ms)
    fid: 100, // First Input Delay (ms)
    cls: 0.1, // Cumulative Layout Shift
    ttfb: 600, // Time to First Byte (ms)
  },
  
  // Bundle size thresholds
  bundleSize: {
    total: 5000, // Total bundle size in KB
    js: 2000, // JavaScript bundle size in KB
    css: 500, // CSS bundle size in KB
    images: 2000, // Total images size in KB
    fonts: 500, // Total fonts size in KB
  },
  
  // Loading time thresholds
  loadingTime: {
    firstPaint: 1000, // ms
    interactive: 3000, // ms
    fullyLoaded: 5000, // ms
  },
};

// Performance optimization strategies
export const OPTIMIZATION_STRATEGIES = {
  immediate: [
    'Optimize hero images',
    'Add width/height to images',
    'Implement lazy loading',
    'Minify assets',
    'Enable compression',
  ],
  
  shortTerm: [
    'Code splitting',
    'Remove unused code',
    'Critical CSS extraction',
    'Font optimization',
    'Resource hints',
  ],
  
  longTerm: [
    'Service workers',
    'CDN implementation',
    'Image optimization service',
    'Performance monitoring',
    'A/B testing',
  ],
};

// Utility functions
export function isPerformanceThresholdMet(metrics: Record<string, number>): boolean {
  const thresholds = PERFORMANCE_THRESHOLDS.coreWebVitals;
  
  return (
    (!metrics.fcp || metrics.fcp <= thresholds.fcp) &&
    (!metrics.lcp || metrics.lcp <= thresholds.lcp) &&
    (!metrics.fid || metrics.fid <= thresholds.fid) &&
    (!metrics.cls || metrics.cls <= thresholds.cls) &&
    (!metrics.ttfb || metrics.ttfb <= thresholds.ttfb)
  );
}

export function getOptimizationRecommendations(metrics: Record<string, number>): string[] {
  const recommendations: string[] = [];
  const thresholds = PERFORMANCE_THRESHOLDS.coreWebVitals;
  
  if (metrics.fcp && metrics.fcp > thresholds.fcp) {
    recommendations.push('First Contentful Paint is high. Optimize critical rendering path.');
  }
  
  if (metrics.lcp && metrics.lcp > thresholds.lcp) {
    recommendations.push('Largest Contentful Paint is high. Optimize images and fonts.');
  }
  
  if (metrics.fid && metrics.fid > thresholds.fid) {
    recommendations.push('First Input Delay is high. Reduce JavaScript execution time.');
  }
  
  if (metrics.cls && metrics.cls > thresholds.cls) {
    recommendations.push('Cumulative Layout Shift is high. Add dimensions to images and ads.');
  }
  
  if (metrics.ttfb && metrics.ttfb > thresholds.ttfb) {
    recommendations.push('Time to First Byte is high. Optimize server response time.');
  }
  
  return recommendations;
}

// Export configuration
export const performanceConfig = getPerformanceConfig();