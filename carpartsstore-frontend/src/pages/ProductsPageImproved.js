import { Link, useParams } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { categoryApi, productApi } from '../services/api';
import { Star, ChevronLeft } from 'lucide-react';
import SEO from '../components/SEO';
// Helper function to complete image URLs
const completeImageUrl = (url) => {
    if (!url)
        return '';
    // If it's already a full URL (starts with http), don't change
    if (url.startsWith('http'))
        return url;
    // If it's a relative path starting with /uploads/, complete it
    if (url.startsWith('/uploads/')) {
        return `${import.meta.env.VITE_API_URL?.replace('/api', '') || 'http://127.0.0.1:5000'}${url}`;
    }
    if (url.startsWith('blob:'))
        return url;
    return url;
};
const ProductsPageImproved = () => {
    const params = useParams();
    const categoryId = params.categoryId || params.id;
    const [category, setCategory] = useState(null);
    const [products, setProducts] = useState([]);
    const [filteredProducts, setFilteredProducts] = useState([]);
    const [loading, setLoading] = useState(true);
    const [activeBrandFilter, setActiveBrandFilter] = useState('all');
    useEffect(() => {
        const fetchData = async () => {
            setLoading(true);
            try {
                if (categoryId) {
                    const categoryData = await categoryApi.getById(Number(categoryId));
                    setCategory(categoryData);
                    const productsData = await categoryApi.getProducts(Number(categoryId));
                    setProducts(productsData.products || productsData || []);
                    setFilteredProducts(productsData.products || productsData || []);
                }
                else {
                    // If no category specified, show all products
                    const allProducts = await productApi.getAll();
                    setProducts(allProducts.products || allProducts || []);
                    setFilteredProducts(allProducts.products || allProducts || []);
                }
            }
            catch (error) {
                console.error('Error fetching data:', error);
            }
            finally {
                setLoading(false);
            }
        };
        fetchData();
    }, [categoryId]);
    // Filter products based on brand selection
    useEffect(() => {
        if (activeBrandFilter === 'all') {
            setFilteredProducts(products);
        }
        else {
            const filtered = products.filter(product => product.brand?.toLowerCase() === activeBrandFilter.toLowerCase() ||
                product.carBrand?.toLowerCase() === activeBrandFilter.toLowerCase());
            setFilteredProducts(filtered);
        }
    }, [activeBrandFilter, products]);
    if (loading) {
        return (<div className="container mx-auto px-4 py-6 sm:py-8 lg:py-10">
        <div className="rounded-3xl bg-white p-6 sm:p-8 shadow-xl">
          <div className="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
            <div className="animate-pulse">
              <div className="h-7 sm:h-8 bg-gray-200 rounded w-40 sm:w-48 mb-2 sm:mb-3"></div>
              <div className="h-3 sm:h-4 bg-gray-200 rounded w-56 sm:w-64"></div>
            </div>
          </div>
          <div className="mt-8 sm:mt-10 grid gap-4 sm:gap-6 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {[1, 2, 3, 4].map((i) => (<div key={i} className="animate-pulse rounded-2xl sm:rounded-[28px] border border-gray-200 bg-gray-50 p-4 sm:p-6">
                <div className="h-32 sm:h-40 bg-gray-300 rounded-xl sm:rounded-2xl mb-3 sm:mb-4"></div>
                <div className="h-3 sm:h-4 bg-gray-300 rounded mb-1 sm:mb-2"></div>
                <div className="h-4 sm:h-6 bg-gray-300 rounded mb-2 sm:mb-3"></div>
                <div className="h-2 sm:h-3 bg-gray-300 rounded w-24 sm:w-32"></div>
              </div>))}
          </div>
        </div>
      </div>);
    }
    return (<div className="min-h-screen bg-gradient-to-b from-gray-50 to-white">
      <SEO title={category ? `${category.name} - فروشگاه قطعات خودرو` : 'محصولات - فروشگاه قطعات خودرو'} description={category ? category.description : 'مجموعهای از بهترین قطعات لوازم یدکی با دسته بندی های تخصصی'} keywords={category ? `${category.name}, قطعات خودرو, لوازم یدکی, ${category.name} قطعات` : 'قطعات خودرو, لوازم یدکی, خرید قطعات خودرو'}/>
      <div className="container mx-auto px-4 py-6 sm:py-8 lg:py-10">
        {/* Header */}
        <div className="mb-6 sm:mb-8 lg:mb-10">
          <div className="flex items-center gap-3 mb-4 sm:mb-6">
            <Link to="/" className="flex items-center gap-2 text-gray-600 hover:text-blue-600 transition-colors text-sm sm:text-base">
              <ChevronLeft className="h-4 w-4 sm:h-5 sm:w-5"/>
              بازگشت
            </Link>
          </div>
          
          <div className="relative overflow-hidden rounded-2xl sm:rounded-3xl p-6 sm:p-8 shadow-2xl border-0">
            {/* Animated Gradient Background */}
            <div className="absolute inset-0 bg-gradient-to-br from-blue-600 via-blue-500 to-cyan-500 animate-gradient-x"></div>
            
            {/* Floating Particles */}
            <div className="absolute inset-0 overflow-hidden">
              <div className="absolute -top-10 -left-10 w-32 h-32 bg-white/10 rounded-full blur-2xl animate-pulse"></div>
              <div className="absolute top-1/3 right-5 w-24 h-24 bg-cyan-400/20 rounded-full blur-2xl animate-pulse delay-700"></div>
              <div className="absolute bottom-5 left-1/3 w-20 h-20 bg-purple-400/20 rounded-full blur-2xl animate-pulse delay-1000"></div>
            </div>
            
            {/* Glass Morphism Effect */}
            <div className="absolute inset-0 bg-white/5 backdrop-blur-md border border-white/20"></div>
            
            {/* Content */}
            <div className="relative z-10">
              <div className="flex flex-col md:flex-row md:items-start md:justify-between gap-4">
                <div className="flex-1">
                  <div className="inline-flex items-center gap-2 mb-3">
                    <div className="w-3 h-3 bg-green-400 rounded-full animate-ping"></div>
                    <span className="text-white/80 text-xs font-medium tracking-wide">
                      دسته‌بندی فعال
                    </span>
                  </div>
                  
                  <h1 className="text-2xl sm:text-3xl lg:text-4xl font-bold text-white mb-2 sm:mb-3 drop-shadow-lg">
                    {category ? category.name : 'محصولات ما'}
                  </h1>
                  
                  <p className="text-blue-100 text-sm sm:text-base max-w-2xl leading-relaxed">
                    {category ? category.description : 'مجموعهای از بهترین قطعات لوازم یدکی با دسته بندی های تخصصی'}
                  </p>
                </div>
                
                {category && (<div className="flex flex-col sm:flex-row items-start sm:items-center gap-3">
                    {/* Product Count Badge */}
                    <div className="px-4 py-2.5 bg-white/15 backdrop-blur-sm rounded-xl border border-white/25 flex items-center gap-2 shadow-lg">
                      <div className="w-2 h-2 bg-green-400 rounded-full animate-pulse"></div>
                      <div>
                        <div className="text-white font-bold text-lg">{products.length}</div>
                        <div className="text-white/80 text-xs">محصول</div>
                      </div>
                    </div>
                    
                    {/* Category Type Badge */}
                    <div className="px-3 py-1.5 bg-gradient-to-r from-blue-500 to-cyan-500 rounded-lg border border-white/30 shadow-lg">
                      <span className="text-white text-xs font-bold tracking-wider">
                        {category.name?.includes('چینی') ? '🇨🇳 چینی' :
                category.name?.includes('سایپا') ? '🚗 سایپا' :
                    category.name?.includes('ایران') ? '🇮🇷 ایران خودرو' : category.name || 'دسته‌بندی'}
                      </span>
                    </div>
                  </div>)}
              </div>
              
              {/* Progress Indicator */}
              {category && (<div className="mt-6 pt-4 border-t border-white/20">
                  <div className="flex items-center justify-between mb-2">
                    <span className="text-white/80 text-xs font-medium">موجودی دسته‌بندی</span>
                    <span className="text-white text-xs font-bold">{products.length} محصول</span>
                  </div>
                  <div className="h-1.5 bg-white/15 rounded-full overflow-hidden">
                    <div className="h-full bg-gradient-to-r from-green-400 to-cyan-400 rounded-full transition-all duration-1000" style={{ width: `${Math.min(products.length * 10, 100)}%` }}></div>
                  </div>
                </div>)}
            </div>
            
            {/* Decorative Corner Elements */}
            <div className="absolute top-4 right-4">
              <div className="w-8 h-8 border border-white/30 rounded-lg flex items-center justify-center">
                <div className="w-3 h-3 bg-white/40 rounded-sm rotate-45"></div>
              </div>
            </div>
            
            <div className="absolute bottom-4 left-4">
              <div className="flex gap-1">
                {[1, 2, 3].map((i) => (<div key={i} className="w-1 h-1 bg-white/40 rounded-full"></div>))}
              </div>
            </div>
            
            {/* Custom Animation */}
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

        {/* Brand Filter Buttons */}
        <div className="mb-6 sm:mb-8">
          <div className="flex flex-wrap gap-2 sm:gap-3 justify-center">
            <button onClick={() => setActiveBrandFilter('all')} className={`px-4 py-2 sm:px-5 sm:py-2.5 rounded-lg sm:rounded-xl font-medium text-sm sm:text-base transition-all ${activeBrandFilter === 'all' ? 'bg-gradient-to-r from-blue-600 to-cyan-500 text-white shadow-lg' : 'bg-white text-gray-700 border border-gray-300 hover:border-blue-400 hover:shadow-md'}`}>
              همه محصولات
            </button>
            <button onClick={() => setActiveBrandFilter('Saipa')} className={`px-4 py-2 sm:px-5 sm:py-2.5 rounded-lg sm:rounded-xl font-medium text-sm sm:text-base transition-all ${activeBrandFilter === 'Saipa' ? 'bg-gradient-to-r from-orange-500 to-red-500 text-white shadow-lg' : 'bg-white text-gray-700 border border-gray-300 hover:border-orange-400 hover:shadow-md'}`}>
              لوازم سایپا
            </button>
            <button onClick={() => setActiveBrandFilter('IranKhodro')} className={`px-4 py-2 sm:px-5 sm:py-2.5 rounded-lg sm:rounded-xl font-medium text-sm sm:text-base transition-all ${activeBrandFilter === 'IranKhodro' ? 'bg-gradient-to-r from-indigo-500 to-purple-500 text-white shadow-lg' : 'bg-white text-gray-700 border border-gray-300 hover:border-indigo-400 hover:shadow-md'}`}>
              لوازم ایران خودرو
            </button>
            <button onClick={() => setActiveBrandFilter('Chinese')} className={`px-4 py-2 sm:px-5 sm:py-2.5 rounded-lg sm:rounded-xl font-medium text-sm sm:text-base transition-all ${activeBrandFilter === 'Chinese' ? 'bg-gradient-to-r from-cyan-500 to-sky-500 text-white shadow-lg' : 'bg-white text-gray-700 border border-gray-300 hover:border-cyan-400 hover:shadow-md'}`}>
              لوازم چینی
            </button>
          </div>
          
          {/* Active Filter Indicator */}
          {activeBrandFilter !== 'all' && (<div className="mt-3 text-center">
              <span className="inline-flex items-center gap-2 px-3 py-1 bg-gradient-to-r from-blue-50 to-cyan-50 text-blue-700 text-xs sm:text-sm font-medium rounded-full border border-blue-200">
                <span className="w-2 h-2 bg-blue-500 rounded-full animate-pulse"></span>
                فیلتر فعال: {activeBrandFilter === 'Saipa' ? 'لوازم سایپا' : activeBrandFilter === 'IranKhodro' ? 'لوازم ایران خودرو' : 'لوازم چینی'}
                <button onClick={() => setActiveBrandFilter('all')} className="text-blue-500 hover:text-blue-700 text-xs">
                  (حذف فیلتر)
                </button>
              </span>
            </div>)}
        </div>

        {/* Products Grid */}
        {filteredProducts.length === 0 ? (<div className="bg-white rounded-2xl sm:rounded-3xl p-8 sm:p-12 text-center shadow-lg border border-gray-200">
            <div className="text-5xl mb-4">📦</div>
            <h3 className="text-xl sm:text-2xl font-bold text-gray-800 mb-3">محصولی یافت نشد</h3>
            <p className="text-gray-600 max-w-md mx-auto mb-6">
              در این دسته بندی هنوز محصولی اضافه نشده است.
            </p>
            <Link to="/" className="inline-flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-medium rounded-xl hover:from-blue-700 hover:to-cyan-600 transition-all">
              بازگشت به صفحه اصلی
            </Link>
          </div>) : (<div className="grid gap-3 sm:gap-4 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {filteredProducts.map((product) => (<Link key={product.id} to={`/products/${product.id}`} className="bg-white rounded-xl sm:rounded-2xl border border-gray-200 p-3 sm:p-4 shadow-sm hover:shadow-lg transition-all duration-300 hover:-translate-y-1 flex flex-col">
                {/* Product Image */}
                <div className="relative mb-3 overflow-hidden rounded-lg sm:rounded-xl bg-gradient-to-br from-gray-100 to-gray-200 aspect-square flex items-center justify-center">
                  <img src={completeImageUrl(product.imageUrl) || 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png'} alt={product.name} className="w-full h-full object-contain p-3" loading="lazy" onError={(e) => {
                    e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
                }}/>
                  
                  {/* Rating Badge */}
                  <div className="absolute top-2 right-2 flex items-center gap-1 bg-white/90 backdrop-blur-sm px-1.5 py-0.5 rounded-full">
                    <Star className="h-2.5 w-2.5 sm:h-3 sm:w-3 text-yellow-500 fill-current"/>
                    <span className="text-xs font-bold text-gray-900">
                      {product.rating?.toFixed(1) || '5.0'}
                    </span>
                  </div>
                  

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

                  <h3 className="font-bold text-gray-900 text-sm sm:text-base line-clamp-2 min-h-[2.5rem]">
                    {product.name}
                  </h3>

                  <p className="text-gray-600 text-xs line-clamp-2 min-h-[2rem] flex-1">
                    {product.description || 'توضیحات محصول در دسترس نیست'}
                  </p>

                  {/* Tags and Compatibility */}
                  <div className="space-y-2 pt-2 border-t border-gray-100">
                    {/* Tags */}
                    {product.tags && product.tags.length > 0 && (<div className="flex flex-wrap gap-1">
                        <span className="text-xs text-gray-500 font-medium">هشتگها:</span>
                        {product.tags.slice(0, 3).map((tag, index) => (<span key={index} className="px-1.5 py-0.5 bg-gradient-to-r from-blue-50 to-blue-100 text-blue-700 text-xs font-medium rounded-full border border-blue-200">
                            #{tag}
                          </span>))}
                        {product.tags.length > 3 && (<span className="px-1.5 py-0.5 bg-gray-100 text-gray-600 text-xs rounded-full">
                            +{product.tags.length - 3}
                          </span>)}
                      </div>)}
                    
                    {/* Compatible Cars */}
                    {product.compatibleCars && (<div className="flex flex-wrap items-center gap-1">
                        <span className="text-xs text-gray-500 font-medium">سازگار با:</span>
                        <div className="flex flex-wrap gap-1">
                          {product.compatibleCars.split(',').slice(0, 2).map((car, index) => (<span key={index} className="px-1.5 py-0.5 bg-gradient-to-r from-green-50 to-green-100 text-green-700 text-xs font-medium rounded-full border border-green-200">
                              {car.trim()}
                            </span>))}
                          {product.compatibleCars.split(',').length > 2 && (<span className="px-1.5 py-0.5 bg-gray-100 text-gray-600 text-xs rounded-full">
                              +{product.compatibleCars.split(',').length - 2}
                            </span>)}
                        </div>
                      </div>)}
                  </div>
                </div>


              </Link>))}
          </div>)}

        {/* Products Count */}
        {filteredProducts.length > 0 && (<div className="mt-8 sm:mt-10 text-center">
            <div className="inline-flex items-center gap-2 px-4 py-2 bg-gray-100 rounded-full">
              <span className="text-sm sm:text-base text-gray-700">
                نمایش <span className="font-bold text-blue-600">{filteredProducts.length}</span> محصول از <span className="font-bold text-gray-600">{products.length}</span> محصول
              </span>
            </div>
          </div>)}
      </div>
    </div>);
};
export default ProductsPageImproved;
