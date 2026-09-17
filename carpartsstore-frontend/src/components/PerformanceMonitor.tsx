import React, { useEffect, useState } from 'react';
import { usePerformance, useResourceTiming, useLongTaskMonitoring } from '../hooks/usePerformance';

interface PerformanceMonitorProps {
  showDebug?: boolean;
  autoSendAnalytics?: boolean;
  onPerformanceCheck?: (result: { passed: boolean; issues: string[] }) => void;
}

const PerformanceMonitor: React.FC<PerformanceMonitorProps> = ({
  showDebug = false,
  autoSendAnalytics = false,
  onPerformanceCheck,
}) => {
  const [metrics, setMetrics] = useState<Record<string, any>>({});
  const [issues, setIssues] = useState<string[]>([]);
  const [isPassing, setIsPassing] = useState<boolean>(true);
  
  const { getMetrics, checkPerformance, sendToAnalytics } = usePerformance();
  
  // Initialize monitoring hooks
  useResourceTiming();
  useLongTaskMonitoring();

  useEffect(() => {
    // Check performance after page load
    const checkPerformanceTimeout = setTimeout(() => {
      const currentMetrics = getMetrics();
      setMetrics(currentMetrics);
      
      const performanceResult = checkPerformance();
      setIssues(performanceResult.issues);
      setIsPassing(performanceResult.passed);
      
      if (onPerformanceCheck) {
        onPerformanceCheck(performanceResult);
      }
      
      if (autoSendAnalytics) {
        sendToAnalytics({
          performanceCheck: performanceResult,
        });
      }
    }, 3000); // Wait 3 seconds for metrics to stabilize

    // Send initial page load metrics
    const sendMetricsTimeout = setTimeout(() => {
      if (autoSendAnalytics) {
        sendToAnalytics({
          event: 'page_load',
        });
      }
    }, 5000);

    return () => {
      clearTimeout(checkPerformanceTimeout);
      clearTimeout(sendMetricsTimeout);
    };
  }, [getMetrics, checkPerformance, sendToAnalytics, autoSendAnalytics, onPerformanceCheck]);

  // Debug mode: show metrics
  if (showDebug) {
    return (
      <div className="fixed bottom-4 right-4 z-50 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-700 rounded-lg shadow-lg p-4 max-w-sm">
        <div className="flex items-center justify-between mb-3">
          <h3 className="font-semibold text-gray-900 dark:text-white">Performance Monitor</h3>
          <div className={`px-2 py-1 rounded text-xs font-medium ${isPassing ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>
            {isPassing ? 'PASSING' : 'ISSUES'}
          </div>
        </div>
        
        <div className="space-y-2">
          {Object.entries(metrics).map(([key, value]) => (
            <div key={key} className="flex justify-between items-center text-sm">
              <span className="text-gray-600 dark:text-gray-400">{key.toUpperCase()}:</span>
              <span className="font-mono">{typeof value === 'number' ? `${value}ms` : value}</span>
            </div>
          ))}
        </div>
        
        {issues.length > 0 && (
          <div className="mt-3 pt-3 border-t border-gray-200 dark:border-gray-700">
            <h4 className="font-medium text-red-600 dark:text-red-400 mb-2">Issues Found:</h4>
            <ul className="space-y-1">
              {issues.map((issue, index) => (
                <li key={index} className="text-xs text-red-600 dark:text-red-400">
                  • {issue}
                </li>
              ))}
            </ul>
          </div>
        )}
        
        <div className="mt-3 pt-3 border-t border-gray-200 dark:border-gray-700">
          <button
            onClick={() => {
              const newMetrics = getMetrics();
              setMetrics(newMetrics);
              const result = checkPerformance();
              setIssues(result.issues);
              setIsPassing(result.passed);
            }}
            className="w-full px-3 py-1.5 bg-blue-600 hover:bg-blue-700 text-white text-sm rounded transition-colors"
          >
            Refresh Metrics
          </button>
        </div>
      </div>
    );
  }

  // Production mode: invisible monitoring
  return null;
};

export default PerformanceMonitor;