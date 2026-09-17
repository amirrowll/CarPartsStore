/**
 * Image optimization utilities for better performance
 */

// Image quality presets
export const IMAGE_QUALITY = {
  THUMBNAIL: 60,
  SMALL: 70,
  MEDIUM: 80,
  LARGE: 85,
  ORIGINAL: 90,
} as const;

// Image size presets (in pixels)
export const IMAGE_SIZES = {
  THUMBNAIL: { width: 150, height: 150 },
  SMALL: { width: 300, height: 300 },
  MEDIUM: { width: 600, height: 400 },
  LARGE: { width: 1200, height: 800 },
  HERO: { width: 1920, height: 1080 },
} as const;

/**
 * Generate optimized image URL
 * @param src Original image URL
 * @param width Desired width
 * @param height Desired height
 * @param quality Image quality (1-100)
 * @returns Optimized image URL
 */
export function getOptimizedImageUrl(
  src: string,
  width?: number,
  height?: number,
  quality: number = IMAGE_QUALITY.MEDIUM,
  format: 'webp' | 'jpg' | 'png' = 'webp'
): string {
  if (!src) return '';
  
  // For external URLs (like CDN), return as-is
  if (src.startsWith('http')) {
    return src;
  }
  
  // For local images, we can add optimization parameters
  // In production, this would be handled by a CDN or image optimization service
  const params = new URLSearchParams();
  
  if (width) params.set('w', width.toString());
  if (height) params.set('h', height.toString());
  if (quality) params.set('q', quality.toString());
  if (format) params.set('fm', format);
  
  // Add optimization parameters
  params.set('fit', 'cover');
  params.set('auto', 'format');
  
  return `${src}${params.toString() ? '?' + params.toString() : ''}`;
}

/**
 * Preload critical images
 * @param urls Array of image URLs to preload
 */
export function preloadImages(urls: string[]): void {
  if (typeof window === 'undefined') return;
  
  urls.forEach(url => {
    const link = document.createElement('link');
    link.rel = 'preload';
    link.as = 'image';
    link.href = url;
    link.crossOrigin = 'anonymous';
    document.head.appendChild(link);
  });
}

/**
 * Lazy load images with Intersection Observer
 * @param selector CSS selector for images to lazy load
 */
export function lazyLoadImages(selector: string = 'img[data-src]'): void {
  if (typeof window === 'undefined' || !('IntersectionObserver' in window)) return;
  
  const images = document.querySelectorAll<HTMLImageElement>(selector);
  
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const img = entry.target as HTMLImageElement;
        const src = img.dataset.src;
        
        if (src) {
          img.src = src;
          img.removeAttribute('data-src');
        }
        
        observer.unobserve(img);
      }
    });
  }, {
    rootMargin: '50px 0px',
    threshold: 0.1,
  });
  
  images.forEach(img => observer.observe(img));
}

/**
 * Calculate image aspect ratio
 * @param width Image width
 * @param height Image height
 * @returns Aspect ratio string (e.g., "16/9")
 */
export function getAspectRatio(width: number, height: number): string {
  const gcd = (a: number, b: number): number => {
    return b === 0 ? a : gcd(b, a % b);
  };
  
  const divisor = gcd(width, height);
  return `${width / divisor}/${height / divisor}`;
}

/**
 * Generate responsive image srcset
 * @param baseUrl Base image URL
 * @param sizes Array of widths for srcset
 * @returns srcset string
 */
export function generateSrcSet(
  baseUrl: string,
  sizes: number[] = [320, 480, 640, 768, 1024, 1280, 1536]
): string {
  return sizes
    .map(size => `${getOptimizedImageUrl(baseUrl, size)} ${size}w`)
    .join(', ');
}

/**
 * Generate sizes attribute for responsive images
 * @param breakpoints Breakpoints for responsive design
 * @returns sizes attribute string
 */
export function generateSizes(
  breakpoints: { [key: string]: string } = {
    '(max-width: 640px)': '100vw',
    '(max-width: 768px)': '90vw',
    '(max-width: 1024px)': '80vw',
    '(max-width: 1280px)': '70vw',
  }
): string {
  return Object.entries(breakpoints)
    .map(([query, size]) => `${query} ${size}`)
    .join(', ') + ', 100vw';
}
// Check if external images should be disabled
export function shouldDisableExternalImages(): boolean {
  return import.meta.env.VITE_DISABLE_EXTERNAL_IMAGES === 'true';
}

// Get placeholder image
export function getPlaceholderImage(width = 800, height = 600): string {
  return `data:image/svg+xml;base64,${btoa(`
    <svg width="${width}" height="${height}" viewBox="0 0 ${width} ${height}" fill="none" xmlns="http://www.w3.org/2000/svg">
      <rect width="${width}" height="${height}" fill="#F0F0F0"/>
      <path d="M0 0H${width}V${height}H0Z" fill="url(#gradient)"/>
      <defs>
        <linearGradient id="gradient" x1="${width/2}" y1="0" x2="${width/2}" y2="${height}" gradientUnits="userSpaceOnUse">
          <stop stop-color="#EEEEEE"/>
          <stop offset="1" stop-color="#F0F0F0"/>
        </linearGradient>
      </defs>
    </svg>
  `)}`;
}
