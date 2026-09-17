import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { AppProvider } from './context/AppContext';
import { AuthProvider } from './context/AuthContext';
import MainLayout from './layouts/MainLayout';
import AdminLayoutNew from './layouts/AdminLayoutNew';
import HomePage from './pages/HomePage';
import AdminLoginPage from './pages/admin/Login';
import AdminDashboard from './pages/admin/Dashboard';
import Products from './pages/admin/Products';
import ProductFormSimplified from './pages/admin/ProductFormSimplified';
import Categories from './pages/admin/Categories';
import AdminOrders from './pages/admin/Orders';
import AdminUsers from './pages/admin/Users';
import AdminStories from './pages/admin/Stories';
import StoryForm from './pages/admin/StoryForm';
import AdminRoute from './components/AdminRoute';
import ProductsPageImproved from './pages/ProductsPageImproved';
import ProductDetailPage from './pages/ProductDetailPage';
import ChinesePartsPage from './pages/ChinesePartsPage';
import SaipaPartsPage from './pages/SaipaPartsPage';
import IranKhodroPartsPage from './pages/IranKhodroPartsPage';
import AllFeaturedProductsPage from './pages/AllFeaturedProductsPage';
import AdvancedSearchPage from './pages/AdvancedSearchPage';
import SearchTestPage from './pages/SearchTestPage';
import TestPage from './pages/TestPage';
import ContactUsPage from './pages/ContactUsPage';
import NotFoundPage from './pages/NotFoundPage';
import './index.css';
function App() {
    return (<AuthProvider>
      <AppProvider>
        <Router>
          <Routes>
            {/* Admin Login Page - بدون لایه اصلی */}
            <Route path="/admin/login" element={<AdminLoginPage />}/>
            
            {/* Main Layout Routes */}
            <Route path="/" element={<MainLayout />}>
              <Route index element={<HomePage />}/>
              <Route path="products" element={<ProductsPageImproved />}/>
              <Route path="products/:id" element={<ProductDetailPage />}/>
              <Route path="products/category/:categoryId" element={<ProductsPageImproved />}/>
              <Route path="category/:id/:name" element={<ProductsPageImproved />}/>
              <Route path="chinese-parts" element={<ChinesePartsPage />}/>
              <Route path="saipa-parts" element={<SaipaPartsPage />}/>
              <Route path="irankhodro-parts" element={<IranKhodroPartsPage />}/>
              <Route path="featured-products" element={<AllFeaturedProductsPage />}/>
              <Route path="advanced-search" element={<AdvancedSearchPage />}/>
              <Route path="search-test" element={<SearchTestPage />}/>
              <Route path="test" element={<TestPage />}/>
              <Route path="contact-us" element={<ContactUsPage />}/>
            </Route>
            
            {/* Admin Routes with New Layout */}
            <Route path="/admin" element={<AdminRoute><AdminLayoutNew /></AdminRoute>}>
              <Route index element={<AdminDashboard />}/>
              <Route path="dashboard" element={<AdminDashboard />}/>
              <Route path="products" element={<Products />}/>
              <Route path="products/create" element={<ProductFormSimplified />}/>
              <Route path="products/edit/:id" element={<ProductFormSimplified />}/>
              <Route path="categories" element={<Categories />}/>
              <Route path="orders" element={<AdminOrders />}/>
              <Route path="users" element={<AdminUsers />}/>
              <Route path="stories" element={<AdminStories />}/>
              <Route path="stories/create" element={<StoryForm />}/>
              <Route path="stories/edit/:id" element={<StoryForm />}/>
            </Route>
            <Route path="*" element={<NotFoundPage />}/>
          </Routes>
        </Router>
      </AppProvider>
    </AuthProvider>);
}
export default App;
