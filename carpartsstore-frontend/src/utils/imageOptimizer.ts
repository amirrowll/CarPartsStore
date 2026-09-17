// Image optimization utilities for Pinpart Store
const SITE_URL = 'https://pinparts.ir';

export interface ImageOptimizationOptions {
  width?: number;
  height?: number;
  quality?: number;
  format?: 'webp' | 'jpg' | 'auto';
  lazy?: boolean;
}

/**
 * Optimize image URL for better performance
 */
export const optimizeImageUrl = (
  url: string | undefined,
  options: ImageOptimizationOptions = {}
): string => {
  if (!url) return '';
  
  const {
    width,
    height,
    quality = 85,
    format = 'auto',
    lazy = true
  } = options;
  
  // If it's already an external URL, return as is
  if (url.startsWith('http') || url.startsWith('//')) {
    return url;
  }
  
  // If it's a local upload, ensure correct base URL
  if (url.startsWith('/uploads/')) {
    const apiBase = import.meta.env.VITE_API_URL?.replace('/api', '') || 'http://127.0.0.1:5000';
    return `${apiBase}${url}`;
  }
  
  // For local images, use optimized versions
  if (url.startsWith('/') && !url.startsWith('/uploads/')) {
    const filename = url.split('/').pop();
    const nameWithoutExt = filename?.replace(/\.[^/.]+$/, '');
    const ext = filename?.split('.').pop()?.toLowerCase();
    
    // Use WebP for supported formats
    if (format === 'webp' || (format === 'auto' && supportsWebP())) {
      return `/optimized/${nameWithoutExt}.webp`;
    }
    
    // Fallback to compressed JPEG
    return `/optimized/${nameWithoutExt}-compressed.jpg`;
  }
  
  return url;
};

/**
 * Check if browser supports WebP
 */
export const supportsWebP = (): boolean => {
  if (typeof window === 'undefined') return false;
  
  const elem = document.createElement('canvas');
  if (elem.getContext && elem.getContext('2d')) {
    return elem.toDataURL('image/webp').indexOf('data:image/webp') === 0;
  }
  return false;
};

/**
 * Generate responsive image srcset
 */
export const generateSrcSet = (
  baseUrl: string,
  sizes: number[] = [320, 640, 960, 1280, 1920]
): string => {
  const nameWithoutExt = baseUrl.split('/').pop()?.replace(/\.[^/.]+$/, '');
  if (!nameWithoutExt) return '';
  
  return sizes
    .map(size => `/optimized/${nameWithoutExt}-${size}w.webp ${size}w`)
    .join(', ');
};

/**
 * Generate picture element with WebP fallback
 */
export const generatePictureElement = (
  imageUrl: string,
  alt: string,
  options: ImageOptimizationOptions = {}
): string => {
  const { width, height, lazy = true } = options;
  const nameWithoutExt = imageUrl.split('/').pop()?.replace(/\.[^/.]+$/, '');
  
  if (!nameWithoutExt) {
    return `<img src="${imageUrl}" alt="${alt}" ${width ? `width="${width}"` : ''} ${height ? `height="${height}"` : ''} ${lazy ? 'loading="lazy"' : ''}>`;
  }
  
  return `
    <picture>
      <source srcset="/optimized/${nameWithoutExt}.webp" type="image/webp">
      <source srcset="/optimized/${nameWithoutExt}-compressed.jpg" type="image/jpeg">
      <img 
        src="/optimized/${nameWithoutExt}-compressed.jpg" 
        alt="${alt}"
        ${width ? `width="${width}"` : ''}
        ${height ? `height="${height}"` : ''}
        ${lazy ? 'loading="lazy"' : ''}
      >
    </picture>
  `.trim();
};

/**
 * Lazy load image with intersection observer
 */
export const lazyLoadImage = (
  imgElement: HTMLImageElement,
  callback?: () => void
): void => {
  if ('IntersectionObserver' in window) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          const img = entry.target as HTMLImageElement;
          const src = img.getAttribute('data-src');
          if (src) {
            img.src = src;
            img.removeAttribute('data-src');
          }
          observer.unobserve(img);
          callback?.();
        }
      });
    }, {
      rootMargin: '50px 0px',
      threshold: 0.1
    });
    
    observer.observe(imgElement);
  } else {
    // Fallback for older browsers
    const src = imgElement.getAttribute('data-src');
    if (src) {
      imgElement.src = src;
      imgElement.removeAttribute('data-src');
    }
    callback?.();
  }
};

/**
 * Preload critical images
 */
export const preloadCriticalImages = (imageUrls: string[]): void => {
  if (typeof document === 'undefined') return;
  
  imageUrls.forEach(url => {
    const link = document.createElement('link');
    link.rel = 'preload';
    link.as = 'image';
    link.href = url;
    
    // Add type for WebP images
    if (url.endsWith('.webp')) {
      link.setAttribute('type', 'image/webp');
    } else if (url.endsWith('.jpg') || url.endsWith('.jpeg')) {
      link.setAttribute('type', 'image/jpeg');
    }
    
    document.head.appendChild(link);
  });
};

/**
 * Get image dimensions from URL
 */
export const getImageDimensions = async (url: string): Promise<{ width: number; height: number }> => {
  return new Promise((resolve) => {
    const img = new Image();
    img.onload = () => {
      resolve({ width: img.width, height: img.height });
    };
    img.onerror = () => {
      resolve({ width: 1200, height: 630 }); // Default dimensions
    };
    img.src = url;
  });
};