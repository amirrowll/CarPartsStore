import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Suspense, lazy } from 'react';
import { AppProvider } from './context/AppContext';
import { AuthProvider } from './context/AuthContext';
import MainLayout from './layouts/MainLayout';
import AdminLayoutNew from './layouts/AdminLayoutNew';
import AdminRoute from './components/AdminRoute';
import PerformanceMonitor from './components/PerformanceMonitor';
import PerformanceOptimizer from './components/PerformanceOptimizer';
import './index.css';

// Lazy load heavy pages
const HomePage = lazy(() => import('./pages/HomePage'));
const AdminLoginPage = lazy(() => import('./pages/admin/Login'));
const AdminDashboard = lazy(() => import('./pages/admin/Dashboard'));
const Products = lazy(() => import('./pages/admin/Products'));
const ProductFormSimplified = lazy(() => import('./pages/admin/ProductFormSimplified'));
const Categories = lazy(() => import('./pages/admin/Categories'));
const AdminOrders = lazy(() => import('./pages/admin/Orders'));
const AdminUsers = lazy(() => import('./pages/admin/Users'));
const AdminStories = lazy(() => import('./pages/admin/Stories'));
const StoryForm = lazy(() => import('./pages/admin/StoryForm'));
const ProductsPageImproved = lazy(() => import('./pages/ProductsPageImproved'));
const ProductDetailPage = lazy(() => import('./pages/ProductDetailPage'));
const ChinesePartsPage = lazy(() => import('./pages/ChinesePartsPage'));
const SaipaPartsPage = lazy(() => import('./pages/SaipaPartsPage'));
const IranKhodroPartsPage = lazy(() => import('./pages/IranKhodroPartsPage'));
const AllFeaturedProductsPage = lazy(() => import('./pages/AllFeaturedProductsPage'));
const AdvancedSearchPage = lazy(() => import('./pages/AdvancedSearchPage'));
const SearchTestPage = lazy(() => import('./pages/SearchTestPage'));
const TestPage = lazy(() => import('./pages/TestPage'));
const ContactUsPage = lazy(() => import('./pages/ContactUsPage'));
const NotFoundPage = lazy(() => import('./pages/NotFoundPage'));

// Loading fallback
const LoadingFallback = () => (
  <div className="min-h-screen flex items-center justify-center bg-gray-50">
    <div className="text-center">
      <div className="w-16 h-16 border-4 border-blue-600 border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
      <p className="text-gray-600">در حال بارگذاری...</p>
    </div>
  </div>
);

function App() {
  return (
    <AuthProvider>
      <AppProvider>
        <Router>
          <Suspense fallback={<LoadingFallback />}>
            <Routes>
              {/* Admin Login Page - بدون لایه اصلی */}
              <Route path="/admin/login" element={<AdminLoginPage />} />
              
              {/* Main Layout Routes */}
              <Route path="/" element={<MainLayout />}>
                <Route index element={<HomePage />} />
                <Route path="products" element={<ProductsPageImproved />} />
                <Route path="products/:id" element={<ProductDetailPage />} />
                <Route path="products/category/:categoryId" element={<ProductsPageImproved />} />
                <Route path="category/:id/:name" element={<ProductsPageImproved />} />
                <Route path="chinese-parts" element={<ChinesePartsPage />} />
                <Route path="saipa-parts" element={<SaipaPartsPage />} />
                <Route path="irankhodro-parts" element={<IranKhodroPartsPage />} />
                <Route path="featured-products" element={<AllFeaturedProductsPage />} />
                <Route path="advanced-search" element={<AdvancedSearchPage />} />
                <Route path="search-test" element={<SearchTestPage />} />
                <Route path="test" element={<TestPage />} />
                <Route path="contact-us" element={<ContactUsPage />} />
              </Route>
              
              {/* Admin Routes with New Layout */}
              <Route path="/admin" element={<AdminRoute><AdminLayoutNew /></AdminRoute>}>
                <Route index element={<AdminDashboard />} />
                <Route path="dashboard" element={<AdminDashboard />} />
                <Route path="products" element={<Products />} />
                <Route path="products/create" element={<ProductFormSimplified />} />
                <Route path="products/edit/:id" element={<ProductFormSimplified />} />
                <Route path="categories" element={<Categories />} />
                <Route path="orders" element={<AdminOrders />} />
                <Route path="users" element={<AdminUsers />} />
                <Route path="stories" element={<AdminStories />} />
                <Route path="stories/create" element={<StoryForm />} />
                <Route path="stories/edit/:id" element={<StoryForm />} />
              </Route>
              <Route path="*" element={<NotFoundPage />} />
            </Routes>
          </Suspense>
        </Router>
        
        {/* Performance Monitoring (hidden in production) */}
        {process.env.NODE_ENV === 'development' && (
          <PerformanceMonitor 
            showDebug={false}
            autoSendAnalytics={false}
            onPerformanceCheck={(result) => {
              if (!result.passed) {
                
              }
            }}
          />
        )}
      </AppProvider>
    </AuthProvider>
  );
}

export default App;