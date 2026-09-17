import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    port: 5173,
    strictPort: true,
  },
  assetsInclude: ['**/*.pdf'],
  resolve: {
    extensions: ['.tsx', '.ts', '.jsx', '.js'],
  },
  build: {
    target: 'esnext',
    minify: 'oxc',
    cssMinify: true,
    // Brotli compression for better SEO performance
    reportCompressedSize: true,
    // Source maps for debugging
    sourcemap: false,
    rollupOptions: {
      input: 'index.html',
      output: {
        manualChunks(id) {
          if (id.includes('node_modules/react') || id.includes('node_modules/react-dom') || id.includes('node_modules/react-router-dom')) {
            return 'vendor';
          }
          if (id.includes('node_modules/@mui')) {
            return 'mui';
          }
          if (id.includes('node_modules/swiper')) {
            return 'swiper';
          }
          if (id.includes('node_modules/lucide-react')) {
            return 'icons';
          }
          if (id.includes('node_modules/axios')) {
            return 'http';
          }
        },
        // Better chunk naming for caching
        chunkFileNames: 'assets/[name]-[hash].js',
        entryFileNames: 'assets/[name]-[hash].js',
        assetFileNames: 'assets/[name]-[hash].[ext]',
      },
    },
    chunkSizeWarningLimit: 1000,
    // Tree shaking for better bundle size
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true,
      },
    },
  },
  optimizeDeps: {
    include: ['react', 'react-dom', 'react-router-dom', 'axios', 'lucide-react'],
    // Force pre-bundling for better performance
    force: true,
  },
  // Preload critical resources
  preview: {
    port: 4173,
    host: '0.0.0.0',
  },
})