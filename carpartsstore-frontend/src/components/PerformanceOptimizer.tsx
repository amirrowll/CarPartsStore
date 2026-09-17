import React, { useEffect, useState } from 'react';
import { usePerformance } from '../hooks/usePerformance';

interface PerformanceOptimizerProps {
  children: React.ReactNode;
  optimizationLevel?: 'basic' | 'advanced' | 'aggressive';
}

const PerformanceOptimizer: React.FC<PerformanceOptimizerProps> = ({
  children,
  optimizationLevel = 'advanced',
}) => {
  const [isClient, setIsClient] = useState(false);
  const { mark, measure, getMetrics, checkPerformance } = usePerformance();
  
  useEffect(() => {
    setIsClient(true);
    
    // Mark page load start
    mark('page-load-start');
    
    // Apply optimizations based on level
    applyOptimizations(optimizationLevel);
    
    // Mark page load end after initial render with delay
    setTimeout(() => {
      mark('page-load-end');
      try {
        const pageLoadTime = measure('page-load', 'page-load-start', 'page-load-end');
        
        if (pageLoadTime > 2000) {
          
        }
      } catch (error) {
        
      }
    }, 100);
    
    // Cleanup
    return () => {
      mark('page-unload');
    };
  }, [optimizationLevel]);
  
  const applyOptimizations = (level: string) => {
    if (typeof window === 'undefined') return;
    
    switch (level) {
      case 'aggressive':
        applyAggressiveOptimizations();
        break;
      case 'advanced':
        applyAdvancedOptimizations();
        break;
      case 'basic':
      default:
        applyBasicOptimizations();
        break;
    }
  };
  
  const applyBasicOptimizations = () => {
    // Basic optimizations
    disableSmoothScrolling();
    reduceAnimations();
    optimizeImages();
  };
  
  const applyAdvancedOptimizations = () => {
    applyBasicOptimizations();
    
    // Advanced optimizations
    deferNonCriticalJS();
    optimizeEventListeners();
    implementVirtualScrolling();
  };
  
  const applyAggressiveOptimizations = () => {
    applyAdvancedOptimizations();
    
    // Aggressive optimizations
    disableDevTools();
    limitConsoleLogs();
    implementResourceLimits();
  };
  
  const disableSmoothScrolling = () => {
    document.documentElement.style.scrollBehavior = 'auto';
  };
  
  const reduceAnimations = () => {
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
      document.documentElement.style.setProperty('--animation-duration', '0.01ms');
    }
  };
  
  const optimizeImages = () => {
    const images = document.querySelectorAll('img');
    images.forEach(img => {
      if (!img.hasAttribute('loading')) {
        img.setAttribute('loading', 'lazy');
      }
      if (!img.hasAttribute('decoding')) {
        img.setAttribute('decoding', 'async');
      }
    });
  };
  
  const deferNonCriticalJS = () => {
    const scripts = document.querySelectorAll('script[type="module"]');
    scripts.forEach(script => {
      if (!script.hasAttribute('defer') && !script.hasAttribute('async')) {
        script.setAttribute('defer', '');
      }
    });
  };
  
  const optimizeEventListeners = () => {
    // Use passive event listeners for better scrolling performance
    const events = ['touchstart', 'touchmove', 'wheel'];
    
    events.forEach(eventName => {
      document.addEventListener(eventName, () => {}, { passive: true });
    });
  };
  
  const implementVirtualScrolling = () => {
    // This would be implemented for large lists
    
  };
  
  const disableDevTools = () => {
    // Prevent opening dev tools (for production only)
    if (process.env.NODE_ENV === 'production') {
      document.addEventListener('keydown', (e) => {
        if (e.key === 'F12' || (e.ctrlKey && e.shiftKey && e.key === 'I')) {
          e.preventDefault();
        }
      });
      
      document.addEventListener('contextmenu', (e) => {
        e.preventDefault();
      });
    }
  };
  
  const limitConsoleLogs = () => {
    if (process.env.NODE_ENV === 'production') {
      const originalConsoleLog = console.log;
      console.log = () => {};
      
      // Restore after 5 seconds (for critical logs)
      setTimeout(() => {
        console.log = originalConsoleLog;
      }, 5000);
    }
  };
  
  const implementResourceLimits = () => {
    // Limit number of concurrent requests
    const maxConcurrentRequests = 6;
    let activeRequests = 0;
    const requestQueue: Array<() => void> = [];
    
    const originalFetch = window.fetch;
    
    window.fetch = function(...args) {
      return new Promise((resolve, reject) => {
        const executeRequest = () => {
          activeRequests++;
          originalFetch.apply(this, args)
            .then(resolve)
            .catch(reject)
            .finally(() => {
              activeRequests--;
              if (requestQueue.length > 0) {
                const nextRequest = requestQueue.shift();
                nextRequest?.();
              }
            });
        };
        
        if (activeRequests < maxConcurrentRequests) {
          executeRequest();
        } else {
          requestQueue.push(executeRequest);
        }
      });
    };
  };
  
  if (!isClient) {
    return <>{children}</>;
  }
  
  return (
    <div className="performance-optimizer">
      {children}
      
      {/* Performance monitoring overlay (development only) */}
      {process.env.NODE_ENV === 'development' && (
        <div className="fixed bottom-4 left-4 z-50 bg-gray-900 text-white text-xs p-2 rounded opacity-75">
          <div>Perf: {optimizationLevel}</div>
          <div>FCP: {getMetrics().fcp || '--'}ms</div>
          <div>LCP: {getMetrics().lcp || '--'}ms</div>
        </div>
      )}
    </div>
  );
};

export default PerformanceOptimizer;