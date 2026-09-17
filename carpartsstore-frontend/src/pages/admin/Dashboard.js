import { useEffect, useState } from 'react';
import api from '../../services/api';
import { Package, Users, Folder, Star, TrendingUp, Car } from 'lucide-react';
import AdminHeroSlider from '../../components/AdminHeroSlider';
import StoriesSection from '../../components/StoriesSection';
import '../../components/Slider.css';
const Dashboard = () => {
    const [stats, setStats] = useState({
        activeProducts: 0,
        totalCategories: 0,
        totalUsers: 0,
        featuredProducts: 0,
        latestProducts: [],
        productsByCarBrand: []
    });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    useEffect(() => {
        const fetchDashboardStats = async () => {
            try {
                const response = await api.get('/stats/dashboard');
                setStats(response.data);
            }
            catch (err) {
                setError('خطا در دریافت آمار داشبورد');
                console.error('Dashboard stats error:', err);
            }
            finally {
                setLoading(false);
            }
        };
        fetchDashboardStats();
    }, []);
    return (<div className="space-y-8">
      {/* Stories Management */}
      <StoriesSection position="top" showAddButton={true} onAddStory={() => window.location.href = '/admin/stories/create'}/>
      
      {/* Hero Slider Management */}
      <AdminHeroSlider />
      
      {/* Header */}
      <div className="rounded-[32px] bg-gradient-to-br from-gray-900 to-gray-800 p-8 shadow-2xl text-white">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <h2 className="text-3xl font-bold mb-2">داشبورد مدیریت</h2>
            <p className="text-gray-300">آمار داینامیک و زنده از سیستم مدیریت محتوای فروشگاه</p>
          </div>
          <div className="rounded-full bg-white/10 backdrop-blur-sm px-5 py-3 text-sm font-semibold">
            {loading ? 'در حال بارگذاری...' : 'آمار بروزرسانی شده'}
          </div>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid gap-4 md:grid-cols-4">
        {/* Active Products */}
        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-blue-50 to-white p-6 shadow-lg transition-all hover:shadow-xl hover:scale-[1.02]">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-3 bg-blue-100 rounded-xl">
              <Package className="h-6 w-6 text-blue-600"/>
            </div>
            <p className="text-sm font-medium text-gray-700">محصولات فعال</p>
          </div>
          <p className="text-3xl font-bold text-gray-900 mb-2">
            {loading ? '...' : stats.activeProducts.toLocaleString('fa-IR')}
          </p>
          <p className="text-xs text-gray-500">محصولات فعال در سایت</p>
        </div>
        
        {/* Categories */}
        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-emerald-50 to-white p-6 shadow-lg transition-all hover:shadow-xl hover:scale-[1.02]">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-3 bg-emerald-100 rounded-xl">
              <Folder className="h-6 w-6 text-emerald-600"/>
            </div>
            <p className="text-sm font-medium text-gray-700">دسته‌بندی‌ها</p>
          </div>
          <p className="text-3xl font-bold text-gray-900 mb-2">
            {loading ? '...' : stats.totalCategories.toLocaleString('fa-IR')}
          </p>
          <p className="text-xs text-gray-500">دسته‌بندی‌های ایجاد شده</p>
        </div>
        
        {/* Users */}
        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-purple-50 to-white p-6 shadow-lg transition-all hover:shadow-xl hover:scale-[1.02]">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-3 bg-purple-100 rounded-xl">
              <Users className="h-6 w-6 text-purple-600"/>
            </div>
            <p className="text-sm font-medium text-gray-700">کاربران</p>
          </div>
          <p className="text-3xl font-bold text-gray-900 mb-2">
            {loading ? '...' : stats.totalUsers.toLocaleString('fa-IR')}
          </p>
          <p className="text-xs text-gray-500">کاربران ثبت‌نام شده</p>
        </div>
        
        {/* Featured Products */}
        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-amber-50 to-white p-6 shadow-lg transition-all hover:shadow-xl hover:scale-[1.02]">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-3 bg-amber-100 rounded-xl">
              <Star className="h-6 w-6 text-amber-600"/>
            </div>
            <p className="text-sm font-medium text-gray-700">محصولات ویژه</p>
          </div>
          <p className="text-3xl font-bold text-gray-900 mb-2">
            {loading ? '...' : stats.featuredProducts.toLocaleString('fa-IR')}
          </p>
          <p className="text-xs text-gray-500">محصولات منتخب</p>
        </div>
      </div>

      {/* Error Message */}
      {error && (<div className="rounded-2xl bg-red-50 border border-red-200 p-6">
          <p className="text-red-700 font-medium">{error}</p>
        </div>)}

      {/* Two Column Content */}
      <div className="grid gap-4 xl:grid-cols-2">
        {/* Latest Products */}
        <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
          <div className="flex items-center gap-2 mb-6">
            <TrendingUp className="h-5 w-5 text-blue-600"/>
            <h3 className="text-xl font-semibold text-gray-800">آخرین محصولات اضافه شده</h3>
          </div>
          
          <div className="space-y-3">
            {loading ? (<div className="text-center py-8 text-gray-500">در حال بارگذاری...</div>) : stats.latestProducts && stats.latestProducts.length > 0 ? (stats.latestProducts.map((product) => (<div key={product.id} className="rounded-xl border border-gray-200 bg-gray-50 p-4 hover:bg-gray-100 transition-colors">
                  <div className="flex items-center gap-4">
                    {product.imageUrl ? (<img src={product.imageUrl} alt={product.name} className="h-14 w-14 rounded-lg object-cover border border-gray-300"/>) : (<div className="h-14 w-14 rounded-lg bg-gray-200 flex items-center justify-center">
                        <Package className="h-6 w-6 text-gray-400"/>
                      </div>)}
                    <div className="flex-1">
                      <p className="font-medium text-gray-800 truncate">{product.name}</p>
                      <div className="flex items-center gap-2 mt-1">
                        <span className="text-xs text-gray-500 bg-gray-100 px-2 py-1 rounded">
                          {product.categoryName || 'بدون دسته'}
                        </span>
                        <span className="text-xs text-gray-400">•</span>
                        <span className="text-xs text-gray-500">
                          {new Date(product.createdAt).toLocaleDateString('fa-IR')}
                        </span>
                      </div>
                    </div>
                  </div>
                </div>))) : (<div className="text-center py-8 text-gray-500 rounded-xl border border-dashed border-gray-300">
                هنوز محصولی اضافه نشده است
              </div>)}
          </div>
        </div>
        
        {/* Products by Car Brand */}
        <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
          <div className="flex items-center gap-2 mb-6">
            <Car className="h-5 w-5 text-emerald-600"/>
            <h3 className="text-xl font-semibold text-gray-800">توزیع محصولات بر اساس برند ماشین</h3>
          </div>
          
          <div className="space-y-4">
            {loading ? (<div className="text-center py-8 text-gray-500">در حال بارگذاری...</div>) : stats.productsByCarBrand && stats.productsByCarBrand.length > 0 ? (stats.productsByCarBrand.map((item, index) => (<div key={index} className="rounded-xl border border-gray-200 bg-gray-50 p-4">
                  <div className="flex items-center justify-between mb-2">
                    <div className="flex items-center gap-2">
                      <Car className="h-4 w-4 text-gray-500"/>
                      <span className="font-medium text-gray-800">
                        {item.carBrand || 'بدون برند'}
                      </span>
                    </div>
                    <span className="text-sm font-semibold text-blue-600 bg-blue-50 px-3 py-1 rounded-full">
                      {item.count} محصول
                    </span>
                  </div>
                  <div className="h-2 bg-gray-200 rounded-full overflow-hidden">
                    <div className="h-full bg-gradient-to-r from-emerald-500 to-emerald-600 rounded-full" style={{
                width: `${stats.activeProducts > 0 ? Math.min((item.count / stats.activeProducts) * 100, 100) : 0}%`
            }}></div>
                  </div>
                </div>))) : (<div className="text-center py-8 text-gray-500 rounded-xl border border-dashed border-gray-300">
                هیچ محصولی بر اساس برند ماشین ثبت نشده
              </div>)}
          </div>
        </div>
      </div>

      {/* Quick Actions */}
      <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
        <h3 className="text-xl font-semibold text-gray-800 mb-6">عملیات سریع</h3>
        <div className="grid gap-4 md:grid-cols-3">
          <a href="/admin/products/create" className="rounded-xl bg-gradient-to-r from-blue-600 to-blue-700 p-4 text-white text-center font-medium hover:from-blue-700 hover:to-blue-800 transition-all hover:scale-[1.02]">
            افزودن محصول جدید
          </a>
          <a href="/admin/categories" className="rounded-xl bg-gradient-to-r from-emerald-600 to-emerald-700 p-4 text-white text-center font-medium hover:from-emerald-700 hover:to-emerald-800 transition-all hover:scale-[1.02]">
            مدیریت دسته‌بندی‌ها
          </a>
          <a href="/admin/users" className="rounded-xl bg-gradient-to-r from-purple-600 to-purple-700 p-4 text-white text-center font-medium hover:from-purple-700 hover:to-purple-800 transition-all hover:scale-[1.02]">
            مدیریت کاربران
          </a>
        </div>
      </div>
    </div>);
};
export default Dashboard;
