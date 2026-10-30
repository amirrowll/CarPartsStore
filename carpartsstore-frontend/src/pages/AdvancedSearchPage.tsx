import React, { useState, useEffect } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import AdvancedSearch from '../components/AdvancedSearch';
import { productApi, completeImageUrl } from '../services/api';
import type { Product } from '../types';
import { 
  Search, 
  Filter, 
  X, 
  ChevronLeft, 
  Package, 
  Star, 
  Car, 
  Shield, 
  Tag, 
  Sparkles,
  PhoneCall,
  Phone,
  FileText
} from 'lucide-react';
import CallRequestModal from '../components/CallRequestModal';

const AdvancedSearchPage: React.FC = () => {
  const navigate = useNavigate();
  const location = useLocation();

  const [filters, setFilters] = useState<any>({
    search: '',
    brand: '',
    carBrand: '',
    carModel: '',
    partNumber: '',
    compatibleCars: '',
    material: '',
    warranty: '',
    tags: [],
    hashtags: [],
    isFeatured: false,
    sortBy: 'createdAt',
    sortDescending: true,
    page: 1,
    pageSize: 24
  });

  const [products, setProducts] = useState<Product[]>([]);
  const [totalCount, setTotalCount] = useState(0);
  const [loading, setLoading] = useState(false);
  const [searchPerformed, setSearchPerformed] = useState(true);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [inquiryProduct, setInquiryProduct] = useState('');

  // Handle initial filters passed from Hero or elsewhere
  useEffect(() => {
    if (location.state?.initialFilters) {
      setFilters((prev: any) => ({
        ...prev,
        ...location.state.initialFilters
      }));
      setSearchPerformed(true);
    }
  }, [location.state]);

  // Perform search when filters change
  useEffect(() => {
    const performSearch = async () => {
      setLoading(true);
      try {
        const apiFilters: any = {
          search: filters.search || undefined,
          brand: filters.brand || undefined,
          carBrand: filters.carBrand || undefined,
          carModel: filters.carModel || undefined,
          partNumber: filters.partNumber || undefined,
          compatibleCars: filters.compatibleCars || undefined,
          material: filters.material || undefined,
          warranty: filters.warranty || undefined,
          tags: filters.tags?.length > 0 ? filters.tags : undefined,
          hashtags: filters.hashtags?.length > 0 ? filters.hashtags : undefined,
          isFeatured: filters.isFeatured || undefined,
          sortBy: filters.sortBy,
          sortDescending: filters.sortDescending,
          page: filters.page,
          pageSize: filters.pageSize
        };

        const response = await productApi.getAll(apiFilters);
        if (response.products) {
          setProducts(response.products);
          setTotalCount(response.totalCount || response.products.length);
        } else if (Array.isArray(response)) {
          setProducts(response);
          setTotalCount(response.length);
        } else {
          setProducts([]);
          setTotalCount(0);
        }
      } catch (error) {
        console.error('Error searching products:', error);
        setProducts([]);
        setTotalCount(0);
      } finally {
        setLoading(false);
      }
    };

    performSearch();
  }, [filters]);

  const handleSearch = (newFilters: any) => {
    setFilters(newFilters);
    setSearchPerformed(true);
  };

  const handleResetFilters = () => {
    setFilters({
      search: '',
      brand: '',
      carBrand: '',
      carModel: '',
      partNumber: '',
      compatibleCars: '',
      material: '',
      warranty: '',
      tags: [],
      hashtags: [],
      isFeatured: false,
      sortBy: 'createdAt',
      sortDescending: true,
      page: 1,
      pageSize: 24
    });
    setSearchPerformed(true);
  };

  const handlePageChange = (newPage: number) => {
    setFilters((prev: any) => ({ ...prev, page: newPage }));
    window.scrollTo({ top: 400, behavior: 'smooth' });
  };

  const openInquiry = (prodName: string) => {
    setInquiryProduct(prodName);
    setIsModalOpen(true);
  };

  const totalPages = Math.ceil(totalCount / (filters.pageSize || 24)) || 1;

  return (
    <div className="min-h-screen bg-slate-900 text-slate-100 pb-20" dir="rtl">
      <div className="container mx-auto px-4 py-6 sm:py-8 lg:py-10">
        
        {/* Header */}
        <div className="mb-6 sm:mb-8 lg:mb-10">
          <div className="flex items-center gap-3 mb-4 sm:mb-6">
            <button 
              onClick={() => navigate(-1)} 
              className="flex items-center gap-2 text-slate-400 hover:text-white transition-colors text-xs sm:text-sm"
            >
              <ChevronLeft className="h-4 w-4" />
              بازگشت به صفحه قبل
            </button>
          </div>
          
          <div className="relative overflow-hidden rounded-2xl sm:rounded-3xl p-6 sm:p-8 shadow-2xl border border-slate-800 bg-slate-950">
            <div className="flex flex-col md:flex-row md:items-start md:justify-between gap-4">
              <div className="flex-1">
                <div className="inline-flex items-center gap-2 mb-3">
                  <span className="w-2.5 h-2.5 bg-red-500 rounded-full animate-ping"></span>
                  <span className="text-red-400 text-xs font-bold tracking-wide">
                    کاتالوگ جامع عمده‌فروشی پین‌پارت
                  </span>
                </div>
                
                <h1 className="text-2xl sm:text-3xl lg:text-4xl font-black text-white mb-2 sm:mb-3">
                  جستجوی پیشرفته و تخصصی قطعات خودرو
                </h1>
                
                <p className="text-slate-300 text-xs sm:text-sm max-w-2xl leading-relaxed">
                  جستجوی هوشمند در میان تمامی اقلام خار، پیچ و مهره، آرم و سوکت بر اساس کد فنی، نام قطعه، برند و خودروهای سازگار
                </p>
              </div>
              
              <div className="flex items-center gap-3">
                <div className="px-5 py-3 bg-slate-900 rounded-2xl border border-slate-800 flex items-center gap-3 shadow-lg">
                  <div className="w-3 h-3 bg-emerald-400 rounded-full animate-pulse"></div>
                  <div>
                    <div className="text-white font-black text-xl">{totalCount}</div>
                    <div className="text-slate-400 text-[11px]">قلم قطعه موجود</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Advanced Search Filter Component */}
        <div className="mb-8 sm:mb-10">
          <AdvancedSearch onSearch={handleSearch} initialFilters={filters} />
        </div>

        {/* Search Results */}
        <div className="mb-8 sm:mb-10">
          <div className="flex items-center justify-between mb-4 sm:mb-6 pb-3 border-b border-slate-800">
            <h2 className="text-base sm:text-lg font-bold text-white flex items-center gap-2">
              <span>نتایج استعلام:</span>
              <span className="text-red-400 font-mono font-bold bg-slate-950 px-2.5 py-0.5 rounded-lg border border-slate-800">
                {totalCount} قلم
              </span>
            </h2>
            
            <div className="text-xs text-slate-400">
              صفحه {filters.page} از {totalPages}
            </div>
          </div>

          {loading ? (
            <div className="grid gap-4 sm:gap-6 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
              {[1, 2, 3, 4, 5, 6, 7, 8].map((i) => (
                <div key={i} className="animate-pulse rounded-2xl border border-slate-800 bg-slate-950 p-4">
                  <div className="h-40 bg-slate-900 rounded-xl mb-3"></div>
                  <div className="h-4 bg-slate-900 rounded mb-2 w-3/4"></div>
                  <div className="h-4 bg-slate-900 rounded mb-3 w-1/2"></div>
                </div>
              ))}
            </div>
          ) : products.length === 0 ? (
            <div className="bg-slate-950 rounded-2xl p-8 sm:p-12 text-center border border-slate-800 max-w-xl mx-auto">
              <Search className="h-12 w-12 text-slate-600 mx-auto mb-3" />
              <h3 className="text-lg font-bold text-white mb-2">نتیجه‌ای با این مشخصات یافت نشد</h3>
              <p className="text-xs text-slate-400 mb-6 leading-relaxed">
                ممکن است عبارت جستجو دقیق نباشد یا فیلترهای محدودکننده‌ای انتخاب شده باشد. می‌توانید فیلترها را حذف کنید تا تمام قطعات نمایش داده شوند.
              </p>
              <button 
                onClick={handleResetFilters}
                className="inline-flex items-center gap-2 px-6 py-2.5 bg-red-600 hover:bg-red-500 text-white text-xs font-bold rounded-xl transition shadow-md"
              >
                <X className="h-4 w-4" />
                حذف همه فیلترها و نمایش همه قطعات
              </button>
            </div>
          ) : (
            <>
              <div className="grid gap-4 sm:gap-6 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 mb-8">
                {products.map((product) => {
                  const img = completeImageUrl(product.imageUrl);
                  return (
                    <div 
                      key={product.id} 
                      className="bg-slate-950 rounded-2xl border border-slate-800 hover:border-red-500/50 p-4 shadow-sm hover:shadow-xl transition-all duration-300 hover:-translate-y-1 flex flex-col justify-between group"
                    >
                      <div>
                        {/* Product Image */}
                        <div className="relative mb-3 overflow-hidden rounded-xl bg-white aspect-square flex items-center justify-center p-3">
                          <img 
                            src={img || 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png'} 
                            alt={product.name} 
                            className="w-full h-full object-contain group-hover:scale-105 transition-transform duration-300"
                            loading="lazy"
                            onError={(e) => {
                              e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
                            }}
                          />
                          
                          {product.partNumber && (
                            <span className="absolute top-2 left-2 px-2 py-0.5 bg-slate-900 text-slate-400 border border-slate-800 text-[10px] font-mono rounded-md">
                              #{product.partNumber}
                            </span>
                          )}

                          {product.brand && (
                            <span className="absolute top-2 right-2 px-2 py-0.5 bg-red-600 text-white text-[10px] font-bold rounded-md uppercase">
                              {product.brand}
                            </span>
                          )}
                        </div>

                        {/* Product Info */}
                        <div className="space-y-2">
                          <h3 
                            onClick={() => navigate(`/products/${product.id}`)}
                            className="font-bold text-white text-sm line-clamp-2 cursor-pointer group-hover:text-red-400 transition-colors leading-snug"
                          >
                            {product.name}
                          </h3>

                          {product.description && (
                            <p className="text-slate-400 text-xs line-clamp-2 leading-relaxed">
                              {product.description}
                            </p>
                          )}

                          {product.compatibleCars && (
                            <div className="flex flex-wrap items-center gap-1 pt-1">
                              <span className="text-[10px] text-slate-500">سازگار:</span>
                              {product.compatibleCars.split(',').slice(0, 3).map((car, idx) => (
                                <span key={idx} className="px-1.5 py-0.5 bg-slate-900 text-slate-300 text-[10px] rounded border border-slate-800">
                                  {car.trim()}
                                </span>
                              ))}
                            </div>
                          )}
                        </div>
                      </div>

                      {/* Bottom Wholesale Actions */}
                      <div className="pt-4 mt-3 border-t border-slate-800/80">
                        <div className="flex items-center justify-between mb-2 text-[11px]">
                          <span className="text-slate-400">قیمت عمده:</span>
                          <span className="text-amber-400 font-bold">استعلام همکاری</span>
                        </div>

                        <div className="grid grid-cols-2 gap-2">
                          <button
                            onClick={() => openInquiry(product.name)}
                            className="w-full py-2 bg-red-600 hover:bg-red-500 text-white text-xs font-bold rounded-xl transition shadow flex items-center justify-center gap-1.5"
                          >
                            <FileText className="h-3.5 w-3.5" />
                            <span>استعلام</span>
                          </button>
                          <a
                            href="tel:09196408805"
                            className="w-full py-2 bg-slate-900 hover:bg-slate-800 text-slate-300 hover:text-white text-xs font-bold rounded-xl transition border border-slate-800 flex items-center justify-center gap-1.5 font-mono"
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

              {/* Pagination */}
              {totalPages > 1 && (
                <div className="flex items-center justify-center gap-2">
                  <button 
                    onClick={() => handlePageChange(filters.page - 1)} 
                    disabled={filters.page === 1} 
                    className="px-4 py-2 border border-slate-700 bg-slate-950 text-slate-300 text-xs rounded-xl disabled:opacity-50 hover:bg-slate-800 transition"
                  >
                    قبلی
                  </button>
                  
                  {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
                    const pageNum = i + 1;
                    return (
                      <button 
                        key={pageNum} 
                        onClick={() => handlePageChange(pageNum)} 
                        className={`px-3.5 py-1.5 rounded-xl text-xs font-bold transition ${
                          filters.page === pageNum
                            ? 'bg-red-600 text-white'
                            : 'bg-slate-950 text-slate-300 border border-slate-800 hover:bg-slate-800'
                        }`}
                      >
                        {pageNum}
                      </button>
                    );
                  })}
                  
                  <button 
                    onClick={() => handlePageChange(filters.page + 1)} 
                    disabled={filters.page === totalPages} 
                    className="px-4 py-2 border border-slate-700 bg-slate-950 text-slate-300 text-xs rounded-xl disabled:opacity-50 hover:bg-slate-800 transition"
                  >
                    بعدی
                  </button>
                </div>
              )}
            </>
          )}
        </div>

        {/* Quick Tips */}
        <div className="mt-12 bg-slate-950 rounded-2xl p-6 border border-slate-800">
          <h3 className="text-sm font-bold text-white mb-4 flex items-center gap-2">
            <Sparkles className="h-4 w-4 text-amber-400" />
            <span>راهنمای خرید و استعلام عمده قطعات پین‌پارت:</span>
          </h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-xs text-slate-400">
            <div className="bg-slate-900 p-4 rounded-xl border border-slate-800/80">
              <h4 className="font-bold text-slate-200 mb-1">جستجوی ترکیبی کد فنی و نام:</h4>
              <p>می‌توانید بخشی از نام قطعه، نام خودرو یا کد فنی را تایپ کنید تا فوراً نتایج همسان فیلتر شوند.</p>
            </div>
            <div className="bg-slate-900 p-4 rounded-xl border border-slate-800/80">
              <h4 className="font-bold text-slate-200 mb-1">استعلام تیراژ و باربری:</h4>
              <p>کلیه اقلام در بسته‌بندی‌های استاندارد کارتنی آماده بارگیری و ارسال روزانه به تمام باربری‌های کشور می‌باشند.</p>
            </div>
            <div className="bg-slate-900 p-4 rounded-xl border border-slate-800/80">
              <h4 className="font-bold text-slate-200 mb-1">پشتیبانی تلفنی و واتساپ:</h4>
              <p>در صورت نیاز به بررسی لیست قطعات خود، می‌توانید عکس یا فایل سفارش را مستقیماً به شماره ۰۹۱۹۶۴۰۸۸۰۵ ارسال فرمایید.</p>
            </div>
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

export default AdvancedSearchPage;
