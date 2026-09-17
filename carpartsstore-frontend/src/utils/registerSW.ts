/**
 * Service Worker registration utility
 * Provides offline support and performance benefits
 */

export function registerServiceWorker() {
  if ('serviceWorker' in navigator && process.env.NODE_ENV === 'production') {
    window.addEventListener('load', () => {
      const swUrl = '/sw.js';
      
      navigator.serviceWorker
        .register(swUrl)
        .then((registration) => {
          
          
          // Check for updates
          registration.addEventListener('updatefound', () => {
            const newWorker = registration.installing;
            if (newWorker) {
              newWorker.addEventListener('statechange', () => {
                if (newWorker.state === 'installed') {
                  if (navigator.serviceWorker.controller) {
                    // New content is available
                    
                    showUpdateNotification();
                  } else {
                    // Content is cached for offline use
                    
                  }
                }
              });
            }
          });
        })
        .catch((error) => {
          console.error('Service Worker registration failed:', error);
        });
    });
  }
}

export function unregisterServiceWorker() {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.ready
      .then((registration) => {
        registration.unregister();
      })
      .catch((error) => {
        console.error('Service Worker unregistration failed:', error);
      });
  }
}

function showUpdateNotification() {
  // Create a notification to inform user about update
  const notification = document.createElement('div');
  notification.className = 'update-notification';
  notification.innerHTML = `
    <div class="fixed bottom-4 right-4 bg-blue-600 text-white p-4 rounded-lg shadow-lg max-w-sm">
      <div class="flex items-center justify-between mb-2">
        <h3 class="font-semibold">بروزرسانی جدید</h3>
        <button class="text-white hover:text-gray-200" onclick="this.parentElement.parentElement.remove()">
          ×
        </button>
      </div>
      <p class="text-sm mb-3">نسخه جدیدی از سایت در دسترس است.</p>
      <div class="flex gap-2">
        <button 
          onclick="window.location.reload()" 
          class="px-3 py-1.5 bg-white text-blue-600 rounded text-sm font-medium hover:bg-gray-100 transition-colors"
        >
          بروزرسانی
        </button>
        <button 
          onclick="this.parentElement.parentElement.remove()" 
          class="px-3 py-1.5 bg-transparent border border-white rounded text-sm font-medium hover:bg-blue-700 transition-colors"
        >
          بعداً
        </button>
      </div>
    </div>
  `;
  
  document.body.appendChild(notification);
  
  // Auto-remove after 30 seconds
  setTimeout(() => {
    if (notification.parentElement) {
      notification.remove();
    }
  }, 30000);
}

export function checkForUpdates() {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.ready
      .then((registration) => {
        registration.update();
      })
      .catch((error) => {
        console.error('Failed to check for updates:', error);
      });
  }
}

export function getServiceWorkerStatus(): Promise<'active' | 'installing' | 'waiting' | 'redundant' | null> {
  if (!('serviceWorker' in navigator)) {
    return Promise.resolve(null);
  }
  
  return navigator.serviceWorker.ready
    .then((registration) => {
      if (registration.active) {
        return 'active';
      }
      if (registration.installing) {
        return 'installing';
      }
      if (registration.waiting) {
        return 'waiting';
      }
      return 'redundant';
    })
    .catch(() => null);
}

export function clearServiceWorkerCache() {
  if ('caches' in window) {
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          return caches.delete(cacheName);
        })
      );
    }).then(() => {
      
    });
  }
}

export function isServiceWorkerSupported(): boolean {
  return 'serviceWorker' in navigator && process.env.NODE_ENV === 'production';
}

export function getCacheStats(): Promise<{ total: number; entries: Array<{ url: string; size: number }> }> {
  if (!('caches' in window)) {
    return Promise.resolve({ total: 0, entries: [] });
  }
  
  return caches.keys().then((cacheNames) => {
    const statsPromises = cacheNames.map((cacheName) => {
      return caches.open(cacheName).then((cache) => {
        return cache.keys().then((requests) => {
          const entryPromises = requests.map((request) => {
            return cache.match(request).then((response) => {
              if (!response) return { url: request.url, size: 0 };
              
              return response.clone().blob().then((blob) => {
                return { url: request.url, size: blob.size };
              });
            });
          });
          
          return Promise.all(entryPromises).then((entries) => {
            const totalSize = entries.reduce((sum, entry) => sum + entry.size, 0);
            return { cacheName, entries, totalSize };
          });
        });
      });
    });
    
    return Promise.all(statsPromises).then((cacheStats) => {
      const total = cacheStats.reduce((sum, stat) => sum + stat.totalSize, 0);
      const allEntries = cacheStats.flatMap(stat => stat.entries);
      
      return { total, entries: allEntries };
    });
  });
}