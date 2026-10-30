import React, { useEffect, useState, useMemo } from 'react';
import { Link } from 'react-router-dom';
import { productApi, completeImageUrl } from '../services/api';
import type { Product } from '../types';
import { 
  Car, 
  Search, 
  PhoneCall, 
  Phone, 
  FileText, 
  Package, 
  Home, 
  Layers, 
  Wrench, 
  ShieldAlert, 
  Zap,
  Filter,
  X
} from 'lucide-react';
import CallRequestModal from '../components/CallRequestModal';
import SEO from '../components/SEO';
import { SEO_CONFIG } from '../utils/seoConfig';

const SAIPA_MODELS = ['همه مدل‌ها', 'پراید', 'تیبا', 'ساینا', 'کوییک', 'شاهین', 'وانت نیسان زامیاد'];

const CATEGORY_TABS = [
  { id: 'all', label: 'همه قطعات سایپا', icon: Package },
  { id: 'خارجات', label: 'خارجات فلزی و پلیمری', icon: Layers },
  { id: 'پیچ و مهره', label: 'پیچ و مهره خودرویی', icon: Wrench },
  { id: 'آرم', label: 'آرم و علائم فابریک', icon: ShieldAlert },
];

const SaipaPartsPage: React.FC = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [selectedModel, setSelectedModel] = useState('همه مدل‌ها');
  const [searchQuery, setSearchQuery] = useState('');
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [inquiryProduct, setInquiryProduct] = useState<string | undefined>(undefined);

  useEffect(() => {
    const fetchSaipa = async () => {
      setLoading(true);
      try {
        const res = await productApi.getAll({ carBrand: 'سایپا', pageSize: 150, isActive: true });
        const list = res.products || (Array.isArray(res) ? res : []);
        if (list.length > 0) {
          setProducts(list);
        } else {
          const brandRes = await productApi.getProductsByBrand('Saipa', 150);
          setProducts(Array.isArray(brandRes) ? brandRes : brandRes.products || []);
        }
      } catch (err) {
        console.error('Error fetching Saipa parts:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchSaipa();
  }, []);

  const filteredProducts = useMemo(() => {
    return products.filter((p) => {
      // 1. Live Search Query
      if (searchQuery.trim()) {
        const q = searchQuery.toLowerCase().trim();
        const matches = 
          (p.name || '').toLowerCase().includes(q) ||
          (p.partNumber || '').toLowerCase().includes(q) ||
          (p.carModel || '').toLowerCase().includes(q) ||
          (p.description || '').toLowerCase().includes(q) ||
          (p.compatibleCars || '').toLowerCase().includes(q);
        if (!matches) return false;
      }

      // 2. Category Tab Filter (خارجات / پیچ و مهره / آرم / سوکت)
      if (selectedCategory !== 'all') {
        const catName = (p.categoryName || '').toLowerCase();

        if (selectedCategory === 'خارجات') {
          const isKharejat = p.categoryId === 10 || catName.includes('خار') || catName.includes('بست');
          if (!isKharejat) return false;
        } else if (selectedCategory === 'پیچ و مهره') {
          const isPich = p.categoryId === 11 || catName.includes('پیچ') || catName.includes('مهره');
          if (!isPich) return false;
        } else if (selectedCategory === 'آرم') {
          const isArm = p.categoryId === 12 || catName.includes('آرم') || catName.includes('علامت');
          if (!isArm) return false;
        }
      }

      // 3. Model Filter (پراید / تیبا / ساینا / کوییک / شاهین / نیسان)
      if (selectedModel !== 'همه مدل‌ها') {
        const cleanModel = selectedModel.split(' ')[0].toLowerCase();
        const text = `${p.carModel || ''} ${p.name || ''} ${p.compatibleCars || ''} ${p.description || ''}`.toLowerCase();
        if (!text.includes(cleanModel)) return false;
      }

      return true;
    });
  }, [products, selectedCategory, selectedModel, searchQuery]);

  const openInquiry = (productName?: string) => {
    setInquiryProduct(productName || 'استعلام عمده لوازم سایپا');
    setIsModalOpen(true);
  };

  const handleResetFilters = () => {
    setSelectedCategory('all');
    setSelectedModel('همه مدل‌ها');
    setSearchQuery('');
  };

  return (
    <div className="min-h-screen bg-slate-900 text-slate-100 pb-20" dir="rtl">
      <SEO 
        title={SEO_CONFIG.saipaParts.title}
        description={SEO_CONFIG.saipaParts.description}
        keywords={SEO_CONFIG.saipaParts.keywords}
        structuredData={SEO_CONFIG.saipaParts.structuredData()}
      />
      
      {/* Top Breadcrumb & Header */}
      <div className="bg-slate-950 border-b border-slate-800">
        <div className="container mx-auto px-4 py-8">
          
          <div className="flex flex-wrap items-center justify-between gap-4 mb-6">
            <div className="flex items-center gap-2 text-xs text-slate-400">
              <Link to="/" className="hover:text-red-400 transition-colors flex items-center gap-1.5">
                <Home className="h-3.5 w-3.5" />
                <span>صفحه اصلی</span>
              </Link>
              <span className="text-slate-600">/</span>
              <span className="text-amber-400 font-semibold">پخش عمده ملزومات سایپا</span>
            </div>

            <div className="flex items-center gap-3">
              <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-amber-950/80 text-amber-400 border border-amber-800/80 rounded-full text-xs font-bold uppercase tracking-wider">
                <span className="w-2 h-2 rounded-full bg-amber-500 animate-pulse"></span>
                فروش منحصراً عمده
              </span>
              <button
                onClick={() => openInquiry()}
                className="px-4 py-1.5 bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white rounded-lg text-xs font-bold transition-all shadow-md flex items-center gap-1.5"
              >
                <PhoneCall className="h-3.5 w-3.5" />
                <span>دریافت لیست قیمت همکاری</span>
              </button>
            </div>
          </div>

          {/* Banner Title Card */}
          <div className="rounded-2xl bg-slate-900 border border-slate-800 p-6 md:p-8 shadow-xl">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-6">
              <div className="space-y-2 max-w-2xl">
                <div className="flex items-center gap-3">
                  <div className="w-12 h-12 rounded-xl bg-amber-500/10 border border-amber-500/30 flex items-center justify-center text-amber-400 shrink-0">
                    <Car className="h-6 w-6" />
                  </div>
                  <div>
                    <h1 className="text-2xl md:text-3xl font-black text-white tracking-tight">
                      تولید و پخش عمده ملزومات و خارجات <span className="text-amber-400">سایپا</span>
                    </h1>
                    <p className="text-xs md:text-sm text-slate-300 mt-1">
                      تأمین دست‌اول انواع خار، پیچ و مهره و آرم و علائم فابریک پراید، تیبا، کوییک، ساینا، شاهین و وانت زامیاد
                    </p>
                  </div>
                </div>
              </div>

              {/* Fast Stats */}
              <div className="flex flex-wrap md:flex-col items-start md:items-end gap-2 bg-slate-950 p-4 rounded-xl border border-slate-800 text-xs">
                <div className="text-slate-400">
                  تعداد اقلام سایپا: <span className="font-bold text-white">{products.length} قطعه</span>
                </div>
                <div className="text-slate-400">
                  نحوه ارسال: <span className="text-emerald-400 font-bold">باربری روزانه به سراسر کشور</span>
                </div>
                <div className="text-slate-400">
                  پشتیبانی فروش: <span className="text-amber-400 font-bold font-mono">۰۹۱۹۶۴۰۸۸۰۵</span>
                </div>
              </div>
            </div>

            {/* Filter Section: 1. Category Tabs, 2. Model Tabs, 3. Search Bar */}
            <div className="mt-8 pt-6 border-t border-slate-800 space-y-4">
              
              {/* Row 1: Category Filter (خارجات / پیچ و مهره / آرم و علائم) */}
              <div>
                <div className="flex items-center gap-2 overflow-x-auto pb-2 scrollbar-none">
                  <span className="text-xs font-bold text-amber-400 ml-1 whitespace-nowrap flex items-center gap-1">
                    <Filter className="h-3.5 w-3.5" />
                    <span>نوع قطعه:</span>
                  </span>
                  {CATEGORY_TABS.map((tab) => {
                    const Icon = tab.icon;
                    const isActive = selectedCategory === tab.id;
                    return (
                      <button
                        key={tab.id}
                        onClick={() => setSelectedCategory(tab.id)}
                        className={`px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap flex items-center gap-1.5 ${
                          isActive
                            ? 'bg-amber-500 text-slate-950 shadow-md ring-2 ring-amber-400/50'
                            : 'bg-slate-950 text-slate-300 hover:bg-slate-800 hover:text-white border border-slate-700/60'
                        }`}
                      >
                        <Icon className="h-3.5 w-3.5" />
                        <span>{tab.label}</span>
                      </button>
                    );
                  })}
                </div>
              </div>

              {/* Row 2: Model Filter Tabs + Instant Search */}
              <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-4 pt-2 border-t border-slate-800/60">
                <div className="flex items-center gap-2 overflow-x-auto pb-2 sm:pb-0 scrollbar-none">
                  <span className="text-xs font-bold text-slate-400 ml-1 whitespace-nowrap">مدل خودرو:</span>
                  {SAIPA_MODELS.map((model) => (
                    <button
                      key={model}
                      onClick={() => setSelectedModel(model)}
                      className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all whitespace-nowrap ${
                        selectedModel === model
                          ? 'bg-red-600 text-white shadow-md'
                          : 'bg-slate-950 text-slate-400 hover:bg-slate-800 hover:text-white border border-slate-800'
                      }`}
                    >
                      {model}
                    </button>
                  ))}
                </div>

                {/* Instant Search */}
                <div className="relative min-w-[240px]">
                  <input
                    type="text"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    placeholder="جستجوی قطعه سایپا..."
                    className="w-full bg-slate-950 border border-slate-700 rounded-xl pr-9 pl-4 py-2 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-amber-400 transition-all"
                  />
                  <Search className="absolute right-3 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-slate-500" />
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>

      {/* Main Content Area */}
      <div className="container mx-auto px-4 mt-8">
        
        {/* Results Bar */}
        <div className="flex flex-wrap items-center justify-between gap-3 mb-6 pb-3 border-b border-slate-800">
          <div className="flex items-center gap-2 text-xs text-slate-400">
            <span>نمایش:</span>
            <span className="font-bold text-white bg-slate-800 px-2.5 py-0.5 rounded-md">
              {filteredProducts.length} قطعه
            </span>
            {selectedCategory !== 'all' && (
              <span className="text-amber-400 font-bold">
                [{CATEGORY_TABS.find(c => c.id === selectedCategory)?.label}]
              </span>
            )}
            {selectedModel !== 'همه مدل‌ها' && (
              <span className="text-red-400 font-bold">({selectedModel})</span>
            )}
            {(selectedCategory !== 'all' || selectedModel !== 'همه مدل‌ها' || searchQuery) && (
              <button
                onClick={handleResetFilters}
                className="text-[11px] text-slate-400 hover:text-white underline mr-2 flex items-center gap-1"
              >
                <X className="h-3 w-3" />
                حذف فیلترها
              </button>
            )}
          </div>

          <div className="text-xs text-slate-400 flex items-center gap-2">
            <span>واحد فروش سایپا:</span>
            <a href="tel:09196408805" className="text-amber-400 font-bold hover:underline font-mono">
              ۰۹۱۹۶۴۰۸۸۰۵
            </a>
          </div>
        </div>

        {/* Products Grid */}
        {loading ? (
          <div className="min-h-[40vh] flex flex-col items-center justify-center">
            <div className="w-12 h-12 border-4 border-amber-500/20 border-t-amber-500 rounded-full animate-spin mb-4"></div>
            <p className="text-xs text-slate-400">در حال بارگذاری کاتالوگ قطعات سایپا...</p>
          </div>
        ) : filteredProducts.length === 0 ? (
          <div className="bg-slate-950 border border-slate-800 rounded-2xl p-12 text-center max-w-xl mx-auto">
            <Package className="h-12 w-12 text-slate-600 mx-auto mb-3" />
            <h3 className="text-base font-bold text-white mb-2">قطعه‌ای با فیلتر انتخابی یافت نشد</h3>
            <p className="text-xs text-slate-400 mb-6 leading-relaxed">
              تنوع اقلام خار، بست، پیچ و آرم‌های فابریک سایپا در انبار مرکزی پین‌پارت موجود است. جهت استعلام اقلام خاص تماس بگیرید.
            </p>
            <div className="flex items-center justify-center gap-3">
              <button
                onClick={handleResetFilters}
                className="px-4 py-2 bg-slate-800 hover:bg-slate-700 text-white text-xs font-bold rounded-xl transition-all"
              >
                نمایش همه قطعات سایپا
              </button>
              <button
                onClick={() => openInquiry('استعلام تلفنی قطعات سایپا')}
                className="px-5 py-2 bg-amber-500 hover:bg-amber-400 text-slate-950 text-xs font-bold rounded-xl transition-all shadow-md flex items-center gap-1.5"
              >
                <PhoneCall className="h-3.5 w-3.5" />
                <span>استعلام تلفنی موجودی</span>
              </button>
            </div>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            {filteredProducts.map((product) => {
              const imgUrl = completeImageUrl(product.imageUrl);
              return (
                <div
                  key={product.id}
                  className="group relative bg-slate-950 rounded-2xl border border-slate-800 hover:border-amber-500/60 transition-all duration-300 hover:shadow-xl flex flex-col justify-between overflow-hidden"
                >
                  <div>
                    {/* Product Image */}
                    <div className="relative aspect-square bg-white overflow-hidden flex items-center justify-center p-3">
                      <div className="absolute top-3 right-3 z-10 flex flex-col gap-1.5">
                        <span className="px-2 py-0.5 bg-amber-500 text-slate-950 text-[10px] font-black rounded-md shadow uppercase tracking-wider">
                          سایپا عمده
                        </span>
                        {product.carModel && (
                          <span className="px-2 py-0.5 bg-slate-900 text-slate-200 border border-slate-700 text-[10px] font-medium rounded-md">
                            {product.carModel}
                          </span>
                        )}
                      </div>

                      {product.partNumber && (
                        <div className="absolute top-3 left-3 z-10">
                          <span className="px-2 py-0.5 bg-slate-900 text-slate-400 border border-slate-800 text-[10px] font-mono rounded-md">
                            #{product.partNumber}
                          </span>
                        </div>
                      )}

                      <img
                        src={imgUrl || 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png'}
                        alt={product.name}
                        className="w-full h-full object-contain group-hover:scale-105 transition-transform duration-300"
                        loading="lazy"
                        onError={(e) => {
                          e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
                        }}
                      />

                      <div className="absolute inset-0 bg-gradient-to-t from-slate-950 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-3">
                        <Link
                          to={`/products/${product.id}`}
                          className="w-full py-1.5 bg-slate-900 text-white text-[11px] font-bold rounded-lg text-center border border-slate-700 transition-all"
                        >
                          مشاهده جزئیات قطعه ←
                        </Link>
                      </div>
                    </div>

                    {/* Content */}
                    <div className="p-4 space-y-2.5">
                      <Link to={`/products/${product.id}`}>
                        <h3 className="font-bold text-white text-sm line-clamp-2 leading-snug group-hover:text-amber-400 transition-colors">
                          {product.name}
                        </h3>
                      </Link>

                      {product.compatibleCars && (
                        <div className="flex flex-wrap gap-1.5 pt-1 text-[10px]">
                          <span className="px-2 py-0.5 bg-slate-900 text-slate-300 rounded border border-slate-800">
                            سازگار: {product.compatibleCars}
                          </span>
                        </div>
                      )}
                    </div>
                  </div>

                  {/* Wholesale Action Bottom */}
                  <div className="p-4 pt-3 border-t border-slate-800 bg-slate-950/80">
                    <div className="flex items-center justify-between mb-2.5 text-[11px]">
                      <span className="text-slate-400">قیمت عمده:</span>
                      <span className="font-bold text-amber-400 flex items-center gap-1">
                        <PhoneCall className="h-3 w-3" />
                        <span>استعلام همکاری</span>
                      </span>
                    </div>

                    <div className="grid grid-cols-2 gap-2">
                      <button
                        onClick={() => openInquiry(product.name)}
                        className="w-full py-2 bg-red-600 hover:bg-red-500 text-white text-xs font-bold rounded-xl transition-all shadow-md flex items-center justify-center gap-1.5"
                      >
                        <FileText className="h-3.5 w-3.5" />
                        <span>ثبت استعلام</span>
                      </button>
                      <a
                        href="tel:09196408805"
                        className="w-full py-2 bg-slate-900 hover:bg-slate-800 text-slate-200 hover:text-white text-xs font-bold rounded-xl transition-all border border-slate-800 flex items-center justify-center gap-1.5 font-mono"
                      >
                        <Phone className="h-3.5 w-3.5" />
                        <span>تماس فوری</span>
                      </a>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </div>

      <CallRequestModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        defaultPartName={inquiryProduct}
      />
    </div>
  );
};

export default SaipaPartsPage;