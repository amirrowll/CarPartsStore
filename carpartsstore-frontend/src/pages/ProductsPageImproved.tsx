import React, { useEffect, useState, useMemo } from 'react';
import { Link, useParams, useSearchParams } from 'react-router-dom';
import { categoryApi, productApi, completeImageUrl } from '../services/api';
import type { Product, Category } from '../types';
import CallRequestModal from '../components/CallRequestModal';
import SEO from '../components/SEO';
import { SEO_CONFIG } from '../utils/seoConfig';
import { Home, Phone, PhoneCall, Layers, Car, Search, X, Package, FileText, Factory, ChevronLeft, ShieldCheck, Sparkles } from 'lucide-react';

const BRAND_FILTERS = [
  { id: 'all', label: 'همه برندها', icon: Sparkles },
  { id: 'saipa', label: 'محصولات سایپا', icon: Car, keywords: ['سایپا', 'پراید', 'تیبا', 'کوییک', 'ساینا', 'شاهین'] },
  { id: 'irankhodro', label: 'محصولات ایران خودرو', icon: Car, keywords: ['ایران خودرو', 'ایرانخودرو', 'پژو', '206', '207', '405', 'پارس', 'سمند', 'دنا', 'تارا'] },
  { id: 'chinese', label: 'خودروهای چینی', icon: Car, keywords: ['چینی', 'جک', 'ام وی ام', 'mvm', 'چری', 'chery', 'هایما', 'فیدلیتی', 'دیگنیتی', 'فونیکس', 'لیفان', 'برلیانس', 'تیگو', 'آریزو'] },
];

const ProductsPageImproved: React.FC = () => {
  const params = useParams<{ categoryId?: string; id?: string; name?: string }>();
  const [searchParams, setSearchParams] = useSearchParams();
  const categoryId = params.categoryId || params.id;

  const [category, setCategory] = useState<Category | null>(null);
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedBrand, setSelectedBrand] = useState<string>(searchParams.get('brand') || 'all');
  const [searchQuery, setSearchQuery] = useState<string>('');

  // Call Request Modal state
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [inquiryProduct, setInquiryProduct] = useState<string | undefined>(undefined);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      try {
        if (categoryId) {
          let targetCatId = Number(categoryId);
          if (targetCatId === 1) {
            targetCatId = 10; // Map legacy category 1 to official Category 10 (خارجات)
          }
          let catObj: Category | null = null;
          
          try {
            const allCats = await categoryApi.getAll();
            const catList = Array.isArray(allCats) ? allCats : ((allCats as any).categories || []);
            
            // Match by ID or by Persian Name from route
            const decodedName = params.name ? decodeURIComponent(params.name).trim() : '';
            catObj = catList.find((c: Category) => 
              c.id === targetCatId || 
              (decodedName && (c.name === decodedName || decodedName.includes(c.name) || c.name.includes(decodedName)))
            ) || null;
            
            if (catObj) {
              targetCatId = catObj.id;
              setCategory(catObj);
            }
          } catch (e) {
            console.warn('Could not fetch categories list', e);
          }

          let prodList: Product[] = [];
          try {
            const productsData = await categoryApi.getProducts(targetCatId, { pageSize: 200 });
            prodList = productsData.products || (Array.isArray(productsData) ? productsData : []);
          } catch (e) {
            console.warn('Error fetching category products by id', e);
          }

          // Fallback: If prodList is empty, try by category name or fetch all products and filter
          if (prodList.length === 0) {
            try {
              const allRes = await productApi.getAll({ pageSize: 200, isActive: true });
              const all = allRes.products || (Array.isArray(allRes) ? allRes : []);
              prodList = all.filter((p: Product) => 
                p.categoryId === targetCatId ||
                (catObj && (p.categoryName === catObj.name || (p.tags && p.tags.includes(catObj.name)))) ||
                (params.name && ((p.categoryName || '').includes(params.name) || (p.tags && p.tags.some(t => t.includes(params.name!)))))
              );
            } catch (e) {
              console.warn('Fallback all products error', e);
            }
          }

          setProducts(prodList);
        } else {
          const allProducts = await productApi.getAll({ pageSize: 200, isActive: true });
          setProducts(allProducts.products || allProducts || []);
        }
      } catch (error) {
        console.error('Error fetching data:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [categoryId, params.name]);

  const handleBrandSelect = (brandId: string) => {
    setSelectedBrand(brandId);
    if (brandId === 'all') {
      searchParams.delete('brand');
    } else {
      searchParams.set('brand', brandId);
    }
    setSearchParams(searchParams, { replace: true });
  };

  const filteredProducts = useMemo(() => {
    return products.filter((p) => {
      // 1. Search filter
      if (searchQuery.trim()) {
        const q = searchQuery.toLowerCase().trim();
        const matchesName = p.name?.toLowerCase().includes(q);
        const matchesCode = p.partNumber?.toLowerCase().includes(q);
        const matchesBrand = p.carBrand?.toLowerCase().includes(q);
        const matchesModel = p.carModel?.toLowerCase().includes(q);
        const matchesDesc = p.description?.toLowerCase().includes(q);
        if (!matchesName && !matchesCode && !matchesBrand && !matchesModel && !matchesDesc) {
          return false;
        }
      }

      // 2. Brand filter
      if (selectedBrand === 'all') return true;

      const brandConfig = BRAND_FILTERS.find((b) => b.id === selectedBrand);
      if (!brandConfig || !brandConfig.keywords) return true;

      const fullText = `${p.carBrand || ''} ${p.carModel || ''} ${p.name || ''} ${p.description || ''}`.toLowerCase();
      return brandConfig.keywords.some((kw) => fullText.includes(kw.toLowerCase()));
    });
  }, [products, selectedBrand, searchQuery]);

  const openInquiry = (productName?: string) => {
    setInquiryProduct(productName || (category ? `دسته بندی ${category.name}` : 'استعلام قیمت عمده'));
    setIsModalOpen(true);
  };

  if (loading) {
    return (
      <div className="min-h-[70vh] flex flex-col items-center justify-center bg-slate-900 text-white p-6">
        <div className="w-14 h-14 rounded-full border-4 border-red-500/20 border-t-red-600 animate-spin mb-4"></div>
        <p className="text-slate-400 font-medium text-xs">در حال بارگذاری کاتالوگ قطعات عمده پین‌پارت...</p>
      </div>
    );
  }

  const categoryTitle = category?.name || (params.name ? decodeURIComponent(params.name) : 'کاتالوگ قطعات خودرویی');
  const categoryDescription = category?.description || 'مرکز تخصصی تأمین و توزیع منحصراً عمده قطعات فابریک، خارجات، پیچ و مهره، آرم و سوکت';

  return (
    <div className="min-h-screen bg-slate-900 text-slate-100 selection:bg-red-600 selection:text-white pb-20" dir="rtl">
      <SEO 
        title={category ? SEO_CONFIG.category(category).title : SEO_CONFIG.products.title}
        description={category ? SEO_CONFIG.category(category).description : SEO_CONFIG.products.description}
        keywords={category ? SEO_CONFIG.category(category).keywords : SEO_CONFIG.products.keywords}
        structuredData={category ? SEO_CONFIG.category(category).structuredData() : SEO_CONFIG.products.structuredData(products)}
      />
      
      {/* Top Banner & Header */}
      <div className="bg-slate-950 border-b border-slate-800">
        <div className="container mx-auto px-4 py-8">
          
          {/* Breadcrumb & Top Bar */}
          <div className="flex flex-wrap items-center justify-between gap-4 mb-6">
            <div className="flex items-center gap-2 text-xs text-slate-400">
              <Link to="/" className="hover:text-red-400 transition-colors flex items-center gap-1.5">
                <Home className="h-3.5 w-3.5" />
                <span>صفحه اصلی</span>
              </Link>
              <span className="text-slate-600">/</span>
              <span className="text-red-400 font-semibold">{categoryTitle}</span>
            </div>

            <div className="flex items-center gap-3">
              <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-red-950 text-red-400 border border-red-800/80 rounded-full text-xs font-bold uppercase tracking-wider">
                <span className="w-2 h-2 rounded-full bg-red-500 animate-pulse"></span>
                فروش منحصراً عمده
              </span>
              <button
                onClick={() => openInquiry()}
                className="px-4 py-1.5 bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white rounded-lg text-xs font-bold transition-all shadow-md flex items-center gap-1.5"
              >
                <PhoneCall className="h-3.5 w-3.5" />
                <span>دریافت استعلام قیمت</span>
              </button>
            </div>
          </div>

          {/* Category Banner Title Card */}
          <div className="rounded-2xl bg-slate-900 border border-slate-800 p-6 md:p-8 shadow-xl">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-6">
              <div className="space-y-2 max-w-2xl">
                <div className="flex items-center gap-3">
                  <div className="w-12 h-12 rounded-xl bg-red-600/10 border border-red-500/30 flex items-center justify-center text-red-500 shrink-0">
                    <Layers className="h-6 w-6" />
                  </div>
                  <div>
                    <h1 className="text-2xl md:text-3xl font-black text-white tracking-tight">
                      {categoryTitle}
                    </h1>
                    <p className="text-xs md:text-sm text-slate-400 mt-1">
                      {categoryDescription}
                    </p>
                  </div>
                </div>
              </div>

              {/* Fast Stats */}
              <div className="flex flex-wrap md:flex-col items-start md:items-end gap-2 bg-slate-950 p-4 rounded-xl border border-slate-800 text-xs">
                <div className="text-slate-400">
                  تعداد اقلام ثبت‌شده: <span className="font-bold text-white">{products.length} کالا</span>
                </div>
                <div className="text-slate-400">
                  نحوه ارسال: <span className="text-emerald-400 font-bold">باربری / تیپاکس سراسر کشور</span>
                </div>
                <div className="text-slate-400">
                  حداقل سفارش: <span className="text-amber-400 font-bold">بسته‌ای / کارتنی (ویژه همکاران)</span>
                </div>
              </div>
            </div>

            {/* Car Brand Filter Tabs (سایپا / ایران خودرو / چینی) */}
            <div className="mt-8 pt-6 border-t border-slate-800">
              <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-4">
                <div className="flex items-center gap-2 overflow-x-auto pb-2 sm:pb-0 scrollbar-none">
                  <span className="text-xs font-bold text-slate-400 ml-2 whitespace-nowrap">فیلتر برند خودرو:</span>
                  {BRAND_FILTERS.map((brand) => {
                    const Icon = brand.icon;
                    return (
                      <button
                        key={brand.id}
                        onClick={() => handleBrandSelect(brand.id)}
                        className={`px-3.5 py-2 rounded-xl text-xs font-bold transition-all whitespace-nowrap flex items-center gap-1.5 ${
                          selectedBrand === brand.id
                            ? 'bg-red-600 text-white shadow-lg shadow-red-600/30'
                            : 'bg-slate-950 text-slate-300 hover:bg-slate-800 hover:text-white border border-slate-700/60'
                        }`}
                      >
                        <Icon className="h-3.5 w-3.5" />
                        <span>{brand.label}</span>
                      </button>
                    );
                  })}
                </div>

                {/* Instant Search */}
                <div className="relative min-w-[240px]">
                  <input
                    type="text"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    placeholder="جستجو در این دسته (نام، کد، مدل)..."
                    className="w-full bg-slate-950 border border-slate-700 rounded-xl pr-9 pl-8 py-2 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-red-500 transition-all"
                  />
                  <Search className="absolute right-3 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-slate-500" />
                  {searchQuery && (
                    <button
                      onClick={() => setSearchQuery('')}
                      className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500 hover:text-white"
                    >
                      <X className="h-3.5 w-3.5" />
                    </button>
                  )}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content Area */}
      <div className="container mx-auto px-4 mt-8">
        
        {/* Results Bar */}
        <div className="flex items-center justify-between mb-6 pb-3 border-b border-slate-800">
          <div className="flex items-center gap-2 text-xs text-slate-400">
            <span>نمایش:</span>
            <span className="font-bold text-white bg-slate-800 px-2.5 py-0.5 rounded-md">
              {filteredProducts.length} قطعه
            </span>
            {selectedBrand !== 'all' && (
              <span className="text-red-400">
                (فیلتر: {BRAND_FILTERS.find((b) => b.id === selectedBrand)?.label})
              </span>
            )}
          </div>

          <div className="text-xs text-slate-400 flex items-center gap-3">
            <span className="hidden sm:inline">اصالت متریال و استاندارد گرید خودرویی</span>
            <a href="tel:09196408805" className="text-red-400 font-bold hover:underline flex items-center gap-1 font-mono">
              <Phone className="h-3 w-3" />
              <span>۰۹۱۹۶۴۰۸۸۰۵</span>
            </a>
          </div>
        </div>

        {/* Products Grid */}
        {filteredProducts.length === 0 ? (
          <div className="bg-slate-950 border border-slate-800 rounded-2xl p-12 text-center max-w-xl mx-auto">
            <div className="w-14 h-14 mx-auto mb-3 rounded-2xl bg-slate-900 border border-slate-800 flex items-center justify-center text-slate-500">
              <Package className="h-7 w-7" />
            </div>
            <h3 className="text-base font-bold text-white mb-2">قطعه‌ای با این مشخصات یافت نشد</h3>
            <p className="text-xs text-slate-400 mb-6 leading-relaxed">
              تعداد زیادی از اقلام در انبار موجود می‌باشند که هنوز وارد سایت نشده‌اند. جهت استعلام سریع تلفنی تماس بگیرید.
            </p>
            <div className="flex items-center justify-center gap-3">
              <button
                onClick={() => {
                  setSelectedBrand('all');
                  setSearchQuery('');
                }}
                className="px-4 py-2 bg-slate-800 hover:bg-slate-700 text-white text-xs font-bold rounded-xl transition-all"
              >
                پاک کردن فیلترها
              </button>
              <button
                onClick={() => openInquiry('استعلام کدهای موجودی انبار')}
                className="px-5 py-2 bg-red-600 hover:bg-red-500 text-white text-xs font-bold rounded-xl transition-all shadow-md flex items-center gap-1.5"
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
                  className="group relative bg-slate-950 rounded-2xl border border-slate-800 hover:border-red-500/60 transition-all duration-300 hover:shadow-xl flex flex-col justify-between overflow-hidden"
                >
                  <div>
                    {/* Product Image */}
                    <div className="relative aspect-square bg-white overflow-hidden flex items-center justify-center p-3">
                      <div className="absolute top-3 right-3 z-10 flex flex-col gap-1.5">
                        <span className="px-2 py-0.5 bg-red-600 text-white text-[10px] font-black rounded-md shadow uppercase tracking-wider">
                          عمده
                        </span>
                        {product.carBrand && (
                          <span className="px-2 py-0.5 bg-slate-900 text-slate-200 border border-slate-700 text-[10px] font-medium rounded-md">
                            {product.carBrand}
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
                          مشاهده جزئیات و مشخصات فنی ←
                        </Link>
                      </div>
                    </div>

                    {/* Content */}
                    <div className="p-4 space-y-2.5">
                      <Link to={`/products/${product.id}`}>
                        <h3 className="font-bold text-white text-sm line-clamp-2 leading-snug group-hover:text-red-400 transition-colors">
                          {product.name}
                        </h3>
                      </Link>

                      {product.carModel && (
                        <div className="flex flex-wrap gap-1.5 pt-1 text-[10px]">
                          <span className="px-2 py-0.5 bg-slate-900 text-slate-300 rounded border border-slate-800">
                            مناسب: {product.carModel}
                          </span>
                        </div>
                      )}
                    </div>
                  </div>

                  {/* Wholesale Action Bottom */}
                  <div className="p-4 pt-3 border-t border-slate-800 bg-slate-950/80">
                    <div className="flex items-center justify-between mb-2.5 text-[11px]">
                      <span className="text-slate-400">قیمت همکاری:</span>
                      <span className="font-bold text-amber-400 flex items-center gap-1">
                        <PhoneCall className="h-3 w-3" />
                        <span>استعلام تلفنی / پیش‌فاکتور</span>
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

        {/* Bottom Wholesale Lead Banner */}
        <div className="mt-14 rounded-2xl bg-gradient-to-r from-red-950/60 via-slate-950 to-slate-950 border border-red-900/40 p-6 md:p-8 flex flex-col md:flex-row items-center justify-between gap-6 shadow-xl">
          <div className="space-y-1 text-center md:text-right">
            <h4 className="text-lg md:text-xl font-black text-white flex items-center justify-center md:justify-start gap-2">
              <Factory className="h-5 w-5 text-red-500" />
              خرید عمده، استعلام لیست قطعات و سفارش سازمانی
            </h4>
            <p className="text-xs md:text-sm text-slate-400 max-w-xl">
              تأمین مستقیم انواع خارجات فلزی و پلیمری، پیچ و مهره خودرویی، آرم و سوکت با تیراژ بالا برای همکاران سراسر کشور
            </p>
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <button
              onClick={() => openInquiry('استعلام لیست کامل اقلام')}
              className="px-6 py-3 bg-red-600 hover:bg-red-500 text-white text-xs font-bold rounded-xl transition-all shadow-md"
            >
              ثبت شماره جهت دریافت پیش‌فاکتور
            </button>
            <a
              href="tel:09196408805"
              className="px-6 py-3 bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold rounded-xl border border-slate-800 transition-all font-mono"
            >
              تماس مستقیم: ۰۹۱۹۶۴۰۸۸۰۵
            </a>
          </div>
        </div>
      </div>

      <CallRequestModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        defaultPartName={inquiryProduct}
      />
    </div>
  );
};

export default ProductsPageImproved;