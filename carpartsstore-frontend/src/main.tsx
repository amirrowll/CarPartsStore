import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import './index.css';
import App from './App.tsx';
import { unregisterServiceWorker } from './utils/registerSW';

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>
);

// Unregister service worker to prevent stale chunk cache issues
unregisterServiceWorker();
