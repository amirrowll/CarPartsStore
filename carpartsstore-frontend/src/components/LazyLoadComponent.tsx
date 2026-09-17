import React, { Suspense, lazy, ComponentType } from 'react';

interface LazyLoadComponentProps {
  component: () => Promise<{ default: ComponentType<any> }>;
  fallback?: React.ReactNode;
  [key: string]: any;
}

const LazyLoadComponent: React.FC<LazyLoadComponentProps> = ({ 
  component, 
  fallback = <div className="min-h-[200px] flex items-center justify-center bg-gray-100 animate-pulse" />,
  ...props 
}) => {
  const LazyComponent = lazy(component);

  return (
    <Suspense fallback={fallback}>
      <LazyComponent {...props} />
    </Suspense>
  );
};

// Helper function for named exports
export function lazyLoad<T extends ComponentType<any>>(
  factory: () => Promise<{ default: T }>,
  fallback?: React.ReactNode
) {
  return (props: React.ComponentProps<T>) => (
    <LazyLoadComponent 
      component={factory} 
      fallback={fallback} 
      {...props} 
    />
  );
}

export default LazyLoadComponent;