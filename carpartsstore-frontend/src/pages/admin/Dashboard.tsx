import { useEffect, useState } from 'react';
import api from '../../services/api';
import { 
  Package, 
  Users, 
  Folder, 
  Star, 
  TrendingUp, 
  Car, 
  PhoneCall, 
  Clock, 
  ArrowLeft,
  Phone,
  MessageSquare
} from 'lucide-react';
import { WhatsApp } from '@mui/icons-material';
import AdminHeroSlider from '../../components/AdminHeroSlider';
import StoriesSection from '../../components/StoriesSection';
import '../../components/Slider.css';

interface DashboardStats {
  activeProducts: number;
  totalCategories: number;
  totalUsers: number;
  featuredProducts: number;
  latestProducts: any[];
  productsByCarBrand: any[];
}

interface CallRequest {
  phoneNumber: string;
  name?: string;
  category?: string;
  note?: string;
  createdAt: string;
}

const Dashboard: React.FC = () => {
  const [stats, setStats] = useState<DashboardStats>({
    activeProducts: 0,
    totalCategories: 0,
    totalUsers: 0,
    featuredProducts: 0,
    latestProducts: [],
    productsByCarBrand: []
  });
  const [callRequests, setCallRequests] = useState<CallRequest[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchDashboardStats = async () => {
      try {
        const [statsRes, callsRes] = await Promise.allSettled([
          api.get('/stats/dashboard'),
          api.get('/contact/call-requests')
        ]);

        if (statsRes.status === 'fulfilled') {
          setStats(statsRes.value.data);
        }
        if (callsRes.status === 'fulfilled' && Array.isArray(callsRes.value.data)) {
          setCallRequests(callsRes.value.data);
        }
      } catch (err: any) {
        setError('خطا در دریافت آمار داشبورد');
        console.error('Dashboard stats error:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchDashboardStats();
  }, []);

  const formatDate = (dateStr: string) => {
    try {
      const d = new Date(dateStr);
      return d.toLocaleString('fa-IR', {
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
      });
    } catch {
      return dateStr;
    }
  };

  return (
    <div className="space-y-8" dir="rtl">
      {/* Stories Management */}
      <StoriesSection 
        position="top"
        showAddButton={true}
        onAddStory={() => window.location.href = '/admin/stories/create'}
      />
      
      {/* Hero Slider Management */}
      <AdminHeroSlider />
      
      {/* Header */}
      <div className="rounded-[32px] bg-gradient-to-br from-slate-900 to-slate-800 p-8 shadow-2xl text-white border border-slate-700">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-red-600/30 border border-red-500/40 text-red-300 text-xs font-bold mb-2">
              <span className="w-2 h-2 rounded-full bg-red-400 animate-ping"></span>
              پنل مدیریت پین‌پارت
            </span>
            <h1 className="text-3xl font-black">داشبورد مدیریت و استعلامات</h1>
            <p className="mt-1 text-sm text-slate-300">
              خلاصه وضعیت فروشگاه، سفارشات و شماره‌های ثبت شده مشتریان
            </p>
          </div>
          <div className="flex gap-3">
            <a
              href="/admin/call-requests"
              className="rounded-2xl bg-gradient-to-r from-red-600 to-rose-600 px-5 py-3 text-xs sm:text-sm font-bold text-white transition hover:from-red-500 hover:to-rose-500 shadow-lg flex items-center gap-2"
            >
              <PhoneCall className="h-4 w-4" />
              <span>مشاهده همه استعلام‌ها ({callRequests.length})</span>
            </a>
          </div>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-5">
        {/* Call Requests / Leads */}
        <div className="rounded-2xl border border-red-200 bg-gradient-to-br from-red-50 to-white p-5 shadow-lg transition-all hover:shadow-xl hover:scale-[1.02]">
          <div className="flex items-center gap-3 mb-3">
            <div className="p-2.5 bg-red-100 rounded-xl text-red-600">
              <PhoneCall className="h-5 w-5" />
            </div>
            <p className="text-xs font-bold text-slate-700">استعلام‌های عمده</p>
          </div>
          <p className="text-2xl font-black text-slate-900 mb-1 font-mono">
            {loading ? '...' : callRequests.length.toLocaleString('fa-IR')}
          </p>
          <a href="/admin/call-requests" className="text-[11px] text-red-600 hover:underline font-medium flex items-center gap-1">
            <span>بررسی شماره‌های مشتریان</span>
            <ArrowLeft className="h-3 w-3" />
          </a>
        </div>

        {/* Active Products */}
        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-blue-50 to-white p-5 shadow-lg transition-all hover:shadow-xl hover:scale-[1.02]">
          <div className="flex items-center gap-3 mb-3">
            <div className="p-2.5 bg-blue-100 rounded-xl text-blue-600">
              <Package className="h-5 w-5" />
            </div>
            <p className="text-xs font-bold text-slate-700">محصولات فعال</p>
          </div>
          <p className="text-2xl font-black text-slate-900 mb-1 font-mono">
            {loading ? '...' : stats.activeProducts.toLocaleString('fa-IR')}
          </p>
          <p className="text-[11px] text-slate-500">قطعات موجود در سایت</p>
        </div>
        
        {/* Categories */}
        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-emerald-50 to-white p-5 shadow-lg transition-all hover:shadow-xl hover:scale-[1.02]">
          <div className="flex items-center gap-3 mb-3">
            <div className="p-2.5 bg-emerald-100 rounded-xl text-emerald-600">
              <Folder className="h-5 w-5" />
            </div>
            <p className="text-xs font-bold text-slate-700">دسته‌بندی‌ها</p>
          </div>
          <p className="text-2xl font-black text-slate-900 mb-1 font-mono">
            {loading ? '...' : stats.totalCategories.toLocaleString('fa-IR')}
          </p>
          <p className="text-[11px] text-slate-500">دسته‌های اصلی بازار</p>
        </div>
        
        {/* Users */}
        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-purple-50 to-white p-5 shadow-lg transition-all hover:shadow-xl hover:scale-[1.02]">
          <div className="flex items-center gap-3 mb-3">
            <div className="p-2.5 bg-purple-100 rounded-xl text-purple-600">
              <Users className="h-5 w-5" />
            </div>
            <p className="text-xs font-bold text-slate-700">کاربران ثبت‌نامی</p>
          </div>
          <p className="text-2xl font-black text-slate-900 mb-1 font-mono">
            {loading ? '...' : stats.totalUsers.toLocaleString('fa-IR')}
          </p>
          <p className="text-[11px] text-slate-500">مشتریان عضو</p>
        </div>
        
        {/* Featured Products */}
        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-amber-50 to-white p-5 shadow-lg transition-all hover:shadow-xl hover:scale-[1.02]">
          <div className="flex items-center gap-3 mb-3">
            <div className="p-2.5 bg-amber-100 rounded-xl text-amber-600">
              <Star className="h-5 w-5" />
            </div>
            <p className="text-xs font-bold text-slate-700">محصولات ویژه</p>
          </div>
          <p className="text-2xl font-black text-slate-900 mb-1 font-mono">
            {loading ? '...' : stats.featuredProducts.toLocaleString('fa-IR')}
          </p>
          <p className="text-[11px] text-slate-500">اقلام برگزیده عمده</p>
        </div>
      </div>

      {/* Error Message */}
      {error && (
        <div className="rounded-2xl bg-red-50 border border-red-200 p-4">
          <p className="text-red-700 font-medium text-xs">{error}</p>
        </div>
      )}

      {/* Live Customer Call Requests & Inquiries Widget */}
      <div className="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm overflow-hidden">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-5 pb-4 border-b border-slate-100">
          <div className="flex items-center gap-2.5">
            <div className="p-2 bg-red-100 text-red-600 rounded-xl">
              <PhoneCall className="h-5 w-5" />
            </div>
            <div>
              <h2 className="text-lg font-bold text-slate-900">آخرین استعلام‌ها و درخواست‌های تماس مشتریان</h2>
              <p className="text-xs text-slate-500">شماره‌هایی که مشتریان در فرم استعلام قیمت و هیرو ثبت کرده‌اند</p>
            </div>
          </div>

          <a 
            href="/admin/call-requests"
            className="text-xs font-bold text-red-600 hover:text-red-700 flex items-center gap-1 self-start sm:self-auto"
          >
            <span>مشاهده و مدیریت کامل ({callRequests.length})</span>
            <ArrowLeft className="h-3.5 w-3.5" />
          </a>
        </div>

        {callRequests.length === 0 ? (
          <div className="py-10 text-center text-slate-400">
            <Clock className="h-8 w-8 mx-auto mb-2 text-slate-300" />
            <p className="text-xs">هنوز شماره یا استعلامی ثبت نشده است.</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-right text-xs">
              <thead className="bg-slate-50 text-slate-600 font-bold border-b border-slate-200">
                <tr>
                  <th className="py-3 px-3">شماره تماس مشتری</th>
                  <th className="py-3 px-3">نام / نام فروشگاه</th>
                  <th className="py-3 px-3">دسته‌بندی</th>
                  <th className="py-3 px-3">توضیحات و اقلام</th>
                  <th className="py-3 px-3">زمان ثبت</th>
                  <th className="py-3 px-3 text-center">تماس سریع</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-100">
                {callRequests.slice(0, 5).map((req, i) => (
                  <tr key={i} className="hover:bg-slate-50/80 transition-colors">
                    <td className="py-3 px-3 font-mono font-bold text-slate-900 text-sm whitespace-nowrap">
                      <div className="flex items-center gap-1.5" dir="ltr">
                        <span className="w-2 h-2 rounded-full bg-emerald-500"></span>
                        <a href={`tel:${req.phoneNumber}`} className="hover:text-red-600 hover:underline">
                          {req.phoneNumber}
                        </a>
                      </div>
                    </td>
                    <td className="py-3 px-3 text-slate-800 font-medium whitespace-nowrap">
                      {req.name || <span className="text-slate-400 italic">نامشخص</span>}
                    </td>
                    <td className="py-3 px-3 whitespace-nowrap">
                      <span className="px-2 py-0.5 bg-slate-100 rounded text-slate-700 text-[11px]">
                        {req.category || 'عمومی'}
                      </span>
                    </td>
                    <td className="py-3 px-3 text-slate-600 max-w-xs truncate">
                      {req.note || <span className="text-slate-400 italic">بدون توضیحات</span>}
                    </td>
                    <td className="py-3 px-3 text-slate-500 whitespace-nowrap font-medium text-[11px]">
                      {formatDate(req.createdAt)}
                    </td>
                    <td className="py-3 px-3 text-center whitespace-nowrap">
                      <div className="flex items-center justify-center gap-2">
                        <a
                          href={`tel:${req.phoneNumber}`}
                          className="px-2.5 py-1 bg-red-600 hover:bg-red-700 text-white rounded-lg font-bold transition flex items-center gap-1 text-[11px]"
                        >
                          <Phone className="h-3 w-3" />
                          <span>تماس</span>
                        </a>
                        <a
                          href={`https://wa.me/98${req.phoneNumber.replace(/^0/, '')}?text=${encodeURIComponent(
                            `سلام، از واحد فروش شرکت پین‌پارت در رابطه با استعلام ثبت‌شده شما (${req.note || 'ملزومات خودرویی'}) پیام می‌دهم.`
                          )}`}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="px-2.5 py-1 bg-emerald-600 hover:bg-emerald-700 text-white rounded-lg font-bold transition flex items-center gap-1 text-[11px]"
                        >
                          <WhatsApp className="!w-3 !h-3" />
                          <span>واتساپ</span>
                        </a>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Two Column Content: Latest Products & Brands */}
      <div className="grid gap-6 xl:grid-cols-2">
        {/* Latest Products */}
        <div className="rounded-3xl border border-gray-200 bg-white p-6 shadow-sm">
          <div className="flex items-center gap-2 mb-5">
            <TrendingUp className="h-5 w-5 text-blue-600" />
            <h3 className="text-lg font-bold text-gray-800">آخرین محصولات اضافه شده</h3>
          </div>
          
          <div className="space-y-3">
            {loading ? (
              <div className="text-center py-8 text-gray-500 text-xs">در حال بارگذاری...</div>
            ) : stats.latestProducts && stats.latestProducts.length > 0 ? (
              stats.latestProducts.map((product) => (
                <div key={product.id} className="rounded-xl border border-gray-100 bg-gray-50 p-3 hover:bg-gray-100 transition-colors">
                  <div className="flex items-center gap-3">
                    {product.imageUrl ? (
                      <img 
                        src={product.imageUrl} 
                        alt={product.name}
                        className="h-12 w-12 rounded-lg object-contain bg-white border border-gray-200 p-1"
                      />
                    ) : (
                      <div className="h-12 w-12 rounded-lg bg-gray-200 flex items-center justify-center">
                        <Package className="h-5 w-5 text-gray-400" />
                      </div>
                    )}
                    <div className="flex-1 min-w-0">
                      <p className="font-bold text-xs text-gray-800 truncate">{product.name}</p>
                      <div className="flex items-center gap-2 mt-1">
                        <span className="text-[10px] text-gray-600 bg-white border border-gray-200 px-1.5 py-0.5 rounded">
                          {product.categoryName || 'بدون دسته'}
                        </span>
                        <span className="text-xs text-gray-400">•</span>
                        <span className="text-[10px] text-gray-500">
                          {new Date(product.createdAt).toLocaleDateString('fa-IR')}
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              ))
            ) : (
              <div className="text-center py-8 text-gray-400 rounded-xl border border-dashed border-gray-200 text-xs">
                هنوز محصولی اضافه نشده است
              </div>
            )}
          </div>
        </div>
        
        {/* Products by Car Brand */}
        <div className="rounded-3xl border border-gray-200 bg-white p-6 shadow-sm">
          <div className="flex items-center gap-2 mb-5">
            <Car className="h-5 w-5 text-emerald-600" />
            <h3 className="text-lg font-bold text-gray-800">توزیع محصولات بر اساس برند ماشین</h3>
          </div>
          
          <div className="space-y-3">
            {loading ? (
              <div className="text-center py-8 text-gray-500 text-xs">در حال بارگذاری...</div>
            ) : stats.productsByCarBrand && stats.productsByCarBrand.length > 0 ? (
              stats.productsByCarBrand.map((item, index) => (
                <div key={index} className="rounded-xl border border-gray-100 bg-gray-50 p-3">
                  <div className="flex items-center justify-between mb-1.5">
                    <div className="flex items-center gap-2">
                      <Car className="h-3.5 w-3.5 text-gray-500" />
                      <span className="font-bold text-xs text-gray-800">
                        {item.carBrand || 'بدون برند'}
                      </span>
                    </div>
                    <span className="text-xs font-bold text-blue-600 bg-blue-50 px-2 py-0.5 rounded-full font-mono">
                      {item.count} محصول
                    </span>
                  </div>
                  <div className="h-1.5 bg-gray-200 rounded-full overflow-hidden">
                    <div 
                      className="h-full bg-gradient-to-r from-emerald-500 to-emerald-600 rounded-full"
                      style={{ 
                        width: `${stats.activeProducts > 0 ? Math.min((item.count / stats.activeProducts) * 100, 100) : 0}%` 
                      }}
                    ></div>
                  </div>
                </div>
              ))
            ) : (
              <div className="text-center py-8 text-gray-400 rounded-xl border border-dashed border-gray-200 text-xs">
                هیچ محصولی بر اساس برند ماشین ثبت نشده
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;