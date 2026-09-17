import React, { useState, useEffect } from 'react';
import { getOptimizedImageUrl, generateSrcSet, generateSizes } from '../utils/imageUtils';
import { isSlowExternalImage, optimizeExternalImage } from '../utils/externalImageOptimizer';

interface OptimizedImageProps {
  src: string;
  alt: string;
  width?: number;
  height?: number;
  className?: string;
  loading?: 'lazy' | 'eager';
  priority?: boolean;
  fallbackSrc?: string;
  quality?: number;
  format?: 'webp' | 'jpg' | 'png';
  responsive?: boolean;
  sizes?: string;
}

const OptimizedImage: React.FC<OptimizedImageProps> = ({
  src,
  alt,
  width,
  height,
  className = '',
  loading = 'lazy',
  priority = false,
  fallbackSrc = '/images/placeholder.jpg',
  quality = 80,
  format = 'webp',
  responsive = true,
  sizes,
}) => {
  const [isLoaded, setIsLoaded] = useState(false);
  const [hasError, setHasError] = useState(false);
  const [isInView, setIsInView] = useState(!priority);

  // Generate optimized URLs
  const getOptimizedSrc = () => {
    const imageSrc = hasError ? fallbackSrc : src;
    
    // Check if it's a slow external image
    if (isSlowExternalImage(imageSrc)) {
      return optimizeExternalImage(imageSrc, width, height);
    }
    
    // Use local optimization for other images
    return getOptimizedImageUrl(
      imageSrc,
      width,
      height,
      quality,
      format
    );
  };
  
  const optimizedSrc = (() => {
  const imageSrc = hasError ? fallbackSrc : src;
  
  // Disable external images in development if configured
  if (typeof window !== 'undefined' && 
      import.meta.env.VITE_DISABLE_EXTERNAL_IMAGES === 'true' &&
      imageSrc.startsWith('http') && 
      !imageSrc.includes('localhost') && 
      !imageSrc.includes('127.0.0.1')) {
    
    return getPlaceholderImage(width || 800, height || 600);
  }
  
  return getOptimizedSrc();
})();

  const srcSet = responsive ? generateSrcSet(src) : undefined;
  const imageSizes = sizes || (responsive ? generateSizes() : undefined);

  // Intersection Observer for lazy loading
  useEffect(() => {
    if (priority || !loading || loading === 'eager') {
      setIsInView(true);
      return;
    }

    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setIsInView(true);
          observer.disconnect();
        }
      },
      {
        rootMargin: '50px',
        threshold: 0.1,
      }
    );

    const element = document.querySelector(`[data-image-id="${src}"]`);
    if (element) {
      observer.observe(element);
    }

    return () => observer.disconnect();
  }, [src, priority, loading]);

  // Preload critical images
  useEffect(() => {
    if (priority && typeof window !== 'undefined') {
      const link = document.createElement('link');
      link.rel = 'preload';
      link.as = 'image';
      link.href = optimizedSrc;
      if (srcSet) {
        link.imageSrcset = srcSet;
      }
      if (imageSizes) {
        link.imageSizes = imageSizes;
      }
      document.head.appendChild(link);
    }
  }, [priority, optimizedSrc, srcSet, imageSizes]);

  return (
    <div 
      className={`relative overflow-hidden ${className}`}
      data-image-id={src}
      style={{
        width: width ? `${width}px` : '100%',
        height: height ? `${height}px` : 'auto',
        aspectRatio: width && height ? `${width}/${height}` : undefined,
      }}
    >
      {/* Blur placeholder */}
      {!isLoaded && (
        <div 
          className="absolute inset-0 bg-gradient-to-r from-gray-200 to-gray-300 animate-pulse"
          style={{
            width: '100%',
            height: '100%',
            aspectRatio: width && height ? `${width}/${height}` : undefined,
          }}
        />
      )}
      
      {/* Actual image */}
      {isInView && (
        <img
          src={optimizedSrc}
          alt={alt}
          width={width}
          height={height}
          loading={priority ? 'eager' : loading}
          decoding="async"
          fetchPriority={priority ? 'high' : 'auto'}
          srcSet={srcSet}
          sizes={imageSizes}
          className={`
            transition-opacity duration-300
            ${isLoaded ? 'opacity-100' : 'opacity-0'}
            w-full h-auto
            object-cover
          `}
          onLoad={() => setIsLoaded(true)}
          onError={() => setHasError(true)}
          // Critical for CLS (Cumulative Layout Shift)
          style={{
            aspectRatio: width && height ? `${width}/${height}` : 'auto',
          }}
        />
      )}
      
      {/* SEO: Add structured data for images */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            '@context': 'https://schema.org',
            '@type': 'ImageObject',
            contentUrl: optimizedSrc,
            description: alt,
            ...(width && height && { width, height }),
            ...(srcSet && { thumbnail: srcSet.split(',')[0]?.split(' ')[0] }),
          }),
        }}
      />
    </div>
  );
};

export default OptimizedImage;