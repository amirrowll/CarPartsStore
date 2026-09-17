/**
 * External image optimization utility
 * Handles optimization for images from external sources
 */

// List of slow external image domains
const SLOW_EXTERNAL_DOMAINS = [
  'upload.wikimedia.org',
  'images.unsplash.com',
  '127.0.0.1:5000',
  'localhost:5000',
];

// Image optimization service URLs
const IMAGE_OPTIMIZATION_SERVICES = {
  // Cloudinary
  cloudinary: (url: string, width: number, height: number) => {
    const cloudinaryUrl = 'https://res.cloudinary.com/demo/image/fetch';
    return `${cloudinaryUrl}/w_${width},h_${height},c_fill,q_80,f_auto/${encodeURIComponent(url)}`;
  },
  
  // Imgix
  imgix: (url: string, width: number, height: number) => {
    const imgixUrl = 'https://your-domain.imgix.net';
    return `${imgixUrl}/${encodeURIComponent(url)}?w=${width}&h=${height}&fit=crop&auto=format,compress`;
  },
  
  // ImageKit
  imagekit: (url: string, width: number, height: number) => {
    const imagekitUrl = 'https://ik.imagekit.io/your-id';
    return `${imagekitUrl}/tr:w-${width},h-${height}/${encodeURIComponent(url)}`;
  },
};

/**
 * Check if image URL is from a slow external domain
 */
export function isSlowExternalImage(url: string): boolean {
  try {
    const urlObj = new URL(url);
    return SLOW_EXTERNAL_DOMAINS.some(domain => urlObj.hostname.includes(domain));
  } catch {
    return false;
  }
}

/**
 * Optimize external image URL
 */
export function optimizeExternalImage(
  url: string, 
  width?: number, 
  height?: number,
  service: keyof typeof IMAGE_OPTIMIZATION_SERVICES = 'cloudinary'
): string {
  if (!isSlowExternalImage(url)) {
    return url;
  }
  
  // Default dimensions if not provided
  const optimizedWidth = width || 800;
  const optimizedHeight = height || 600;
  
  // Use optimization service
  const optimizedUrl = IMAGE_OPTIMIZATION_SERVICES[service](url, optimizedWidth, optimizedHeight);
  
  
  return optimizedUrl;
}

/**
 * Preload critical external images
 */
export function preloadExternalImages(urls: string[]): void {
  if (typeof window === 'undefined') return;
  
  urls.forEach(url => {
    if (isSlowExternalImage(url)) {
      const link = document.createElement('link');
      link.rel = 'preload';
      link.as = 'image';
      link.href = optimizeExternalImage(url);
      link.crossOrigin = 'anonymous';
      document.head.appendChild(link);
    }
  });
}

/**
 * Lazy load external images
 */
export function lazyLoadExternalImages(selector: string = 'img[data-external-src]'): void {
  if (typeof window === 'undefined' || !('IntersectionObserver' in window)) return;
  
  const images = document.querySelectorAll<HTMLImageElement>(selector);
  
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const img = entry.target as HTMLImageElement;
        const src = img.dataset.externalSrc;
        
        if (src && isSlowExternalImage(src)) {
          const optimizedSrc = optimizeExternalImage(src);
          img.src = optimizedSrc;
          img.removeAttribute('data-external-src');
        }
        
        observer.unobserve(img);
      }
    });
  }, {
    rootMargin: '100px 0px',
    threshold: 0.1,
  });
  
  images.forEach(img => observer.observe(img));
}

/**
 * Get image dimensions from URL
 */
export function getImageDimensionsFromUrl(url: string): { width?: number; height?: number } {
  try {
    const urlObj = new URL(url);
    const params = new URLSearchParams(urlObj.search);
    
    const width = params.get('w') || params.get('width');
    const height = params.get('h') || params.get('height');
    
    return {
      width: width ? parseInt(width) : undefined,
      height: height ? parseInt(height) : undefined,
    };
  } catch {
    return {};
  }
}

/**
 * Add dimensions to external images
 */
export function addDimensionsToExternalImages(): void {
  if (typeof window === 'undefined') return;
  
  const images = document.querySelectorAll<HTMLImageElement>('img');
  
  images.forEach(img => {
    const src = img.src;
    if (src && isSlowExternalImage(src) && (!img.width || !img.height)) {
      const dimensions = getImageDimensionsFromUrl(src);
      
      if (dimensions.width && dimensions.height) {
        img.width = dimensions.width;
        img.height = dimensions.height;
        img.style.aspectRatio = `${dimensions.width}/${dimensions.height}`;
      } else {
        // Default dimensions for external images
        img.width = 800;
        img.height = 600;
        img.style.aspectRatio = '4/3';
      }
    }
  });
}

/**
 * Replace external images with placeholders
 */
export function replaceExternalImagesWithPlaceholders(): void {
  if (typeof window === 'undefined') return;
  
  const images = document.querySelectorAll<HTMLImageElement>('img');
  
  images.forEach(img => {
    const src = img.src;
    if (src && isSlowExternalImage(src)) {
      // Store original source
      img.dataset.originalSrc = src;
      
      // Set placeholder
      img.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAwIiBoZWlnaHQ9IjYwMCIgdmlld0JveD0iMCAwIDgwMCA2MDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHJlY3Qgd2lkdGg9IjgwMCIgaGVpZ2h0PSI2MDAiIGZpbGw9IiNGMEYwRjAiLz48cGF0aCBkPSJNMCAwSDgwMFY2MDBIMHoiIGZpbGw9InVybCgjcGFpbnQwX2xpbmVhcl8xXzEpIi8+PGRlZnM+PGxpbmVhckdyYWRpZW50IGlkPSJwYWludDBfbGluZWFyXzFfMSIgeDE9IjQwMCIgeTE9IjAiIHgyPSI0MDAiIHkyPSI2MDAiIGdyYWRpZW50VW5pdHM9InVzZXJTcGFjZU9uVXNlIj48c3RvcCBzdG9wLWNvbG9yPSIjRUVFRUVFIi8+PHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjRjBGMEYwIi8+PC9saW5lYXJHcmFkaWVudD48L2RlZnM+PC9zdmc+';
      img.loading = 'lazy';
      img.decoding = 'async';
      
      // Load optimized image on hover or after delay
      setTimeout(() => {
        if (img.dataset.originalSrc) {
          const optimizedSrc = optimizeExternalImage(img.dataset.originalSrc);
          img.src = optimizedSrc;
          delete img.dataset.originalSrc;
        }
      }, 1000);
    }
  });
}

/**
 * Initialize external image optimization
 */
export function initExternalImageOptimization(): void {
  if (typeof window === 'undefined') return;
  
  // Add dimensions to external images
  addDimensionsToExternalImages();
  
  // Lazy load external images
  lazyLoadExternalImages();
  
  // Replace with placeholders for very slow images
  setTimeout(() => {
    replaceExternalImagesWithPlaceholders();
  }, 500);
}

export default {
  isSlowExternalImage,
  optimizeExternalImage,
  preloadExternalImages,
  lazyLoadExternalImages,
  addDimensionsToExternalImages,
  replaceExternalImagesWithPlaceholders,
  initExternalImageOptimization,
};