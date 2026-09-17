import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import AdvancedSearch, { SearchFilters } from '../components/AdvancedSearch';
import { productApi } from '../services/api';
import type { Product } from '../types';
import { Search, Filter, X, ChevronLeft, Package, Star, Car, Shield, Tag } from 'lucide-react';

// Helper function to complete image URLs
const completeImageUrl = (url: string | undefined): string => {
  if (!url) return '';
  
  if (url.startsWith('http')) return url;
  
  if (url.startsWith('/uploads/')) {
    return `http://127.0.0.1:5000${url}`;
  }
  
  if (url.startsWith('blob:')) return url;
  
  return url;
};

const AdvancedSearchPage: React.FC = () => {
  const navigate = useNavigate();
  const [filters, setFilters] = useState<SearchFilters>({
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
  const [searchPerformed, setSearchPerformed] = useState(false);

  // Perform search when filters change
  useEffect(() => {
    const performSearch = async () => {
      if (!searchPerformed) return;
      
      setLoading(true);
      try {
        // Convert filters to API format
        const apiFilters = {
          search: filters.search || undefined,
          brand: filters.brand || undefined,
          carBrand: filters.carBrand || undefined,
          carModel: filters.carModel || undefined,
          partNumber: filters.partNumber || undefined,
          compatibleCars: filters.compatibleCars || undefined,
          material: filters.material || undefined,
          warranty: filters.warranty || undefined,
          tags: filters.tags.length > 0 ? filters.tags : undefined,
          hashtags: filters.hashtags.length > 0 ? filters.hashtags : undefined,
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
        } else {
          setProducts(response);
          setTotalCount(response.length);
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
  }, [filters, searchPerformed]);

  const handleSearch = (newFilters: SearchFilters) => {
    setFilters(newFilters);
    setSearchPerformed(true);
  };

  const handleProductClick = (productId: number) => {
    navigate(`/product/${productId}`);
  };

  const handlePageChange = (newPage: number) => {
    setFilters(prev => ({ ...prev, page: newPage }));
  };

  const totalPages = Math.ceil(totalCount / filters.pageSize);

  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-50 to-white">
      <div className="container mx-auto px-4 py-6 sm:py-8 lg:py-10">
        {/* Header */}
        <div className="mb-6 sm:mb-8 lg:mb-10">
          <div className="flex items-center gap-3 mb-4 sm:mb-6">
            <button
              onClick={() => navigate(-1)}
              className="flex items-center gap-2 text-gray-600 hover:text-blue-600 transition-colors text-sm sm:text-base"
            >
              <ChevronLeft className="h-4 w-4 sm:h-5 sm:w-5" />
              بازگشت
            </button>
          </div>
          
          <div className="relative overflow-hidden rounded-2xl sm:rounded-3xl p-6 sm:p-8 shadow-2xl border-0">
            <div className="absolute inset-0 bg-gradient-to-br from-blue-600 via-blue-500 to-cyan-500 animate-gradient-x"></div>
            
            <div className="absolute inset-0 overflow-hidden">
              <div className="absolute -top-10 -left-10 w-32 h-32 bg-white/10 rounded-full blur-2xl animate-pulse"></div>
              <div className="absolute top-1/3 right-5 w-24 h-24 bg-cyan-400/20 rounded-full blur-2xl animate-pulse delay-700"></div>
              <div className="absolute bottom-5 left-1/3 w-20 h-20 bg-purple-400/20 rounded-full blur-2xl animate-pulse delay-1000"></div>
            </div>
            
            <div className="absolute inset-0 bg-white/5 backdrop-blur-md border border-white/20"></div>
            
            <div className="relative z-10">
              <div className="flex flex-col md:flex-row md:items-start md:justify-between gap-4">
                <div className="flex-1">
                  <div className="inline-flex items-center gap-2 mb-3">
                    <div className="w-3 h-3 bg-green-400 rounded-full animate-ping"></div>
                    <span className="text-white/80 text-xs font-medium tracking-wide">
                      جستجوی پیشرفته
                    </span>
                  </div>
                  
                  <h1 className="text-2xl sm:text-3xl lg:text-4xl font-bold text-white mb-2 sm:mb-3 drop-shadow-lg">
                    جستجوی هوشمند قطعات
                  </h1>
                  
                  <p className="text-blue-100 text-sm sm:text-base max-w-2xl leading-relaxed">
                    با استفاده از فیلترهای پیشرفته، دقیقترین قطعات مورد نیاز خودروی خود را پیدا کنید
                  </p>
                </div>
                
                <div className="flex flex-col sm:flex-row items-start sm:items-center gap-3">
                  <div className="px-4 py-2.5 bg-white/15 backdrop-blur-sm rounded-xl border border-white/25 flex items-center gap-2 shadow-lg">
                    <div className="w-2 h-2 bg-green-400 rounded-full animate-pulse"></div>
                    <div>
                      <div className="text-white font-bold text-lg">{totalCount}</div>
                      <div className="text-white/80 text-xs">نتیجه جستجو</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <style>
              {`
                @keyframes gradient-x {
                  0%, 100% {
                    background-position: 0% 50%;
                  }
                  50% {
                    background-position: 100% 50%;
                  }
                }
                
                .animate-gradient-x {
                  background-size: 200% 200%;
                  animation: gradient-x 15s ease infinite;
                }
              `}
            </style>
          </div>
        </div>

        {/* Advanced Search Component */}
        <div className="mb-8 sm:mb-10">
          <AdvancedSearch onSearch={handleSearch} initialFilters={filters} />
        </div>

        {/* Search Results */}
        <div className="mb-8 sm:mb-10">
          <div className="flex items-center justify-between mb-4 sm:mb-6">
            <h2 className="text-xl sm:text-2xl font-bold text-gray-800">
              نتایج جستجو
              {searchPerformed && (
                <span className="text-blue-600 ml-2">({totalCount} محصول)</span>
              )}
            </h2>
            
            {searchPerformed && (
              <div className="text-sm text-gray-600">
                صفحه {filters.page} از {totalPages}
              </div>
            )}
          </div>

          {loading ? (
            <div className="grid gap-4 sm:gap-6 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
              {[1, 2, 3, 4, 5, 6, 7, 8].map((i) => (
                <div key={i} className="animate-pulse rounded-2xl sm:rounded-[28px] border border-gray-200 bg-gray-50 p-4 sm:p-6">
                  <div className="h-32 sm:h-40 bg-gray-300 rounded-xl sm:rounded-2xl mb-3 sm:mb-4"></div>
                  <div className="h-3 sm:h-4 bg-gray-300 rounded mb-1 sm:mb-2"></div>
                  <div className="h-4 sm:h-6 bg-gray-300 rounded mb-2 sm:mb-3"></div>
                  <div className="h-2 sm:h-3 bg-gray-300 rounded w-24 sm:w-32"></div>
                </div>
              ))}
            </div>
          ) : searchPerformed && products.length === 0 ? (
            <div className="bg-white rounded-2xl sm:rounded-3xl p-8 sm:p-12 text-center shadow-lg border border-gray-200">
              <div className="text-5xl mb-4">🔍</div>
              <h3 className="text-xl sm:text-2xl font-bold text-gray-800 mb-3">نتیجه‌ای یافت نشد</h3>
              <p className="text-gray-600 max-w-md mx-auto mb-6">
                با فیلترهای فعلی هیچ محصولی پیدا نشد. لطفاً فیلترها را تغییر دهید یا جستجوی خود را اصلاح کنید.
              </p>
              <button
                onClick={() => {
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
                  setSearchPerformed(false);
                }}
                className="inline-flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-medium rounded-xl hover:from-blue-700 hover:to-cyan-600 transition-all"
              >
                <X className="h-4 w-4" />
                پاک کردن همه فیلترها
              </button>
            </div>
          ) : searchPerformed ? (
            <>
              <div className="grid gap-3 sm:gap-4 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 mb-6 sm:mb-8">
                {products.map((product) => (
                  <div 
                    key={product.id} 
                    onClick={() => handleProductClick(product.id)}
                    className="bg-white rounded-xl sm:rounded-2xl border border-gray-200 p-3 sm:p-4 shadow-sm hover:shadow-lg transition-all duration-300 hover:-translate-y-1 cursor-pointer flex flex-col group"
                  >
                    {/* Product Image */}
                    <div className="relative mb-3 overflow-hidden rounded-lg sm:rounded-xl bg-gradient-to-br from-gray-100 to-gray-200 aspect-square flex items-center justify-center">
                      <img
                        src={completeImageUrl(product.imageUrl) || 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png'}
                        alt={product.name}
                        className="w-full h-full object-contain p-3 group-hover:scale-105 transition-transform duration-300"
                        onError={(e) => {
                          e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
                        }}
                      />
                      
                      {/* Rating Badge */}
                      <div className="absolute top-2 right-2 flex items-center gap-1 bg-white/90 backdrop-blur-sm px-1.5 py-0.5 rounded-full">
                        <Star className="h-2.5 w-2.5 sm:h-3 sm:w-3 text-yellow-500 fill-current" />
                        <span className="text-xs font-bold text-gray-900">
                          {product.rating?.toFixed(1) || '5.0'}
                        </span>
                      </div>
                      
                      {/* Featured Badge */}
                      {product.isFeatured && (
                        <div className="absolute top-2 left-2 bg-gradient-to-r from-yellow-500 to-orange-500 text-white text-xs font-bold px-2 py-1 rounded-full">
                          ویژه
                        </div>
                      )}
                    </div>

                    {/* Product Info */}
                    <div className="space-y-2 sm:space-y-3 flex-1 flex flex-col">
                      <div className="flex items-center justify-between">
                        <span className="px-2 py-0.5 bg-blue-100 text-blue-700 text-xs font-medium rounded-full line-clamp-1">
                          {product.brand || product.categoryName || 'بدون برند'}
                        </span>
                        <span className="text-xs text-gray-500">
                          #{product.partNumber || 'نامشخص'}
                        </span>
                      </div>

                      <h3 className="font-bold text-gray-900 text-sm sm:text-base line-clamp-2 min-h-[2.5rem] group-hover:text-blue-600 transition-colors">
                        {product.name}
                      </h3>

                      <p className="text-gray-600 text-xs line-clamp-2 min-h-[2rem] flex-1">
                        {product.description || 'توضیحات محصول در دسترس نیست'}
                      </p>

                      {/* Tags and Compatibility */}
                      <div className="space-y-2 pt-2 border-t border-gray-100">
                        {/* Tags */}
                        {product.tags && product.tags.length > 0 && (
                          <div className="flex flex-wrap gap-1">
                            <span className="text-xs text-gray-500 font-medium">تگها:</span>
                            {product.tags.slice(0, 3).map((tag, index) => (
                              <span
                                key={index}
                                className="px-1.5 py-0.5 bg-gradient-to-r from-blue-50 to-blue-100 text-blue-700 text-xs font-medium rounded-full border border-blue-200"
                              >
                                {tag}
                              </span>
                            ))}
                            {product.tags.length > 3 && (
                              <span className="px-1.5 py-0.5 bg-gray-100 text-gray-600 text-xs rounded-full">
                                +{product.tags.length - 3}
                              </span>
                            )}
                          </div>
                        )}
                        
                        {/* Hashtags */}
                        {product.hashtags && product.hashtags.length > 0 && (
                          <div className="flex flex-wrap gap-1">
                            <span className="text-xs text-gray-500 font-medium">هشتگها:</span>
                            {product.hashtags.slice(0, 2).map((hashtag, index) => (
                              <span
                                key={index}
                                className="px-1.5 py-0.5 bg-gradient-to-r from-purple-50 to-purple-100 text-purple-700 text-xs font-medium rounded-full border border-purple-200"
                              >
                                #{hashtag}
                              </span>
                            ))}
                            {product.hashtags.length > 2 && (
                              <span className="px-1.5 py-0.5 bg-gray-100 text-gray-600 text-xs rounded-full">
                                +{product.hashtags.length - 2}
                              </span>
                            )}
                          </div>
                        )}
                        
                        {/* Compatible Cars */}
                        {product.compatibleCars && (
                          <div className="flex flex-wrap items-center gap-1">
                            <span className="text-xs text-gray-500 font-medium">سازگار با:</span>
                            <div className="flex flex-wrap gap-1">
                              {product.compatibleCars.split(',').slice(0, 2).map((car, index) => (
                                <span
                                  key={index}
                                  className="px-1.5 py-0.5 bg-gradient-to-r from-green-50 to-green-100 text-green-700 text-xs font-medium rounded-full border border-green-200"
                                >
                                  {car.trim()}
                                </span>
                              ))}
                              {product.compatibleCars.split(',').length > 2 && (
                                <span className="px-1.5 py-0.5 bg-gray-100 text-gray-600 text-xs rounded-full">
                                  +{product.compatibleCars.split(',').length - 2}
                                </span>
                              )}
                            </div>
                          </div>
                        )}
                        
                        {/* Material & Warranty */}
                        <div className="flex flex-wrap gap-2">
                          {product.material && (
                            <div className="flex items-center gap-1">
                              <Package className="h-3 w-3 text-gray-400" />
                              <span className="text-xs text-gray-600">{product.material}</span>
                            </div>
                          )}
                          
                          {product.warranty && (
                            <div className="flex items-center gap-1">
                              <Shield className="h-3 w-3 text-green-400" />
                              <span className="text-xs text-green-600">{product.warranty}</span>
                            </div>
                          )}
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>

              {/* Pagination */}
              {totalPages > 1 && (
                <div className="flex items-center justify-center gap-2">
                  <button
                    onClick={() => handlePageChange(filters.page - 1)}
                    disabled={filters.page === 1}
                    className="px-4 py-2 border border-gray-300 rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50 transition-colors"
                  >
                    قبلی
                  </button>
                  
                  {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
                    let pageNum;
                    if (totalPages <= 5) {
                      pageNum = i + 1;
                    } else if (filters.page <= 3) {
                      pageNum = i + 1;
                    } else if (filters.page >= totalPages - 2) {
                      pageNum = totalPages - 4 + i;
                    } else {
                      pageNum = filters.page - 2 + i;
                    }
                    
                    return (
                      <button
                        key={pageNum}
                        onClick={() => handlePageChange(pageNum)}
                        className={`px-4 py-2 rounded-lg transition-colors ${
                          filters.page === pageNum
                            ? 'bg-blue-600 text-white'
                            : 'border border-gray-300 hover:bg-gray-50'
                        }`}
                      >
                        {pageNum}
                      </button>
                    );
                  })}
                  
                  <button
                    onClick={() => handlePageChange(filters.page + 1)}
                    disabled={filters.page === totalPages}
                    className="px-4 py-2 border border-gray-300 rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50 transition-colors"
                  >
                    بعدی
                  </button>
                </div>
              )}
            </>
          ) : (
            <div className="bg-white rounded-2xl sm:rounded-3xl p-8 sm:p-12 text-center shadow-lg border border-gray-200">
              <div className="text-5xl mb-4">🔍</div>
              <h3 className="text-xl sm:text-2xl font-bold text-gray-800 mb-3">آماده برای جستجو</h3>
              <p className="text-gray-600 max-w-md mx-auto mb-6">
                فیلترهای مورد نظر خود را تنظیم کرده و دکمه جستجو را بزنید تا نتایج نمایش داده شوند.
              </p>
              <div className="flex flex-wrap justify-center gap-4 mb-8">
                <div className="flex items-center gap-2 text-sm text-gray-700">
                  <Search className="h-4 w-4 text-blue-500" />
                  <span>جستجوی چندکلمه‌ای</span>
                </div>
                <div className="flex items-center gap-2 text-sm text-gray-700">
                  <Filter className="h-4 w-4 text-green-500" />
                  <span>فیلترهای پیشرفته</span>
                </div>
                <div className="flex items-center gap-2 text-sm text-gray-700">
                  <Tag className="h-4 w-4 text-purple-500" />
                  <span>تگ‌بندی هوشمند</span>
                </div>
                <div className="flex items-center gap-2 text-sm text-gray-700">
                  <Car className="h-4 w-4 text-orange-500" />
                  <span>سازگاری خودرو</span>
                </div>
              </div>
            </div>
          )}
        </div>

        {/* Search Tips */}
        <div className="mt-8 sm:mt-10">
          <div className="bg-gradient-to-r from-blue-50 to-cyan-50 rounded-2xl p-6 border border-blue-100">
            <h3 className="text-lg font-bold text-blue-800 mb-4">راهنمای جستجوی پیشرفته:</h3>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
              <div className="bg-white p-4 rounded-xl border border-blue-100">
                <div className="text-blue-600 text-2xl mb-2">🔍</div>
                <h4 className="font-medium text-blue-800 mb-2">جستجوی هوشمند</h4>
                <p className="text-sm text-blue-700">
                  میتوانید در نام، توضیحات، شماره قطعه و سازگاری همزمان جستجو کنید
                </p>
              </div>
              
              <div className="bg-white p-4 rounded-xl border border-green-100">
                <div className="text-green-600 text-2xl mb-2">🏷️</div>
                <h4 className="font-medium text-green-800 mb-2">فیلتر ترکیبی</h4>
                <p className="text-sm text-green-700">
                  از چندین فیلتر به صورت همزمان استفاده کنید برای نتایج دقیق‌تر
                </p>
              </div>
              
              <div className="bg-white p-4 rounded-xl border border-purple-100">
                <div className="text-purple-600 text-2xl mb-2">🚗</div>
                <h4 className="font-medium text-purple-800 mb-2">سازگاری خودرو</h4>
                <p className="text-sm text-purple-700">
                  قطعات سازگار با خودروی خود را بر اساس برند و مدل پیدا کنید
                </p>
              </div>
              
              <div className="bg-white p-4 rounded-xl border border-orange-100">
                <div className="text-orange-600 text-2xl mb-2">⭐</div>
                <h4 className="font-medium text-orange-800 mb-2">محصولات ویژه</h4>
                <p className="text-sm text-orange-700">
                  فقط محصولات ویژه و پرفروش را با یک کلیک مشاهده کنید
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AdvancedSearchPage;