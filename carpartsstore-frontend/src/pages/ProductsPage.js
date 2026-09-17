import { Link, useParams } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { categoryApi, productApi } from '../services/api';
import { Star } from 'lucide-react';
// Helper function to complete image URLs
const completeImageUrl = (url) => {
    if (!url)
        return '';
    // If it's already a full URL (starts with http), don't change
    if (url.startsWith('http'))
        return url;
    // If it's a relative path starting with /uploads/, complete it
    if (url.startsWith('/uploads/')) {
        return `http://127.0.0.1:5000${url}`;
    }
    // For blob URLs (preview), return as-is
    if (url.startsWith('blob:'))
        return url;
    // Return other URLs as-is
    return url;
};
const ProductsPage = () => {
    const { categoryId } = useParams();
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
        return (<div className="container mx-auto px-4 py-10">
        <div className="rounded-[32px] bg-white p-8 shadow-xl">
          <div className="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
            <div className="animate-pulse">
              <div className="h-8 bg-gray-200 rounded w-48 mb-3"></div>
              <div className="h-4 bg-gray-200 rounded w-64"></div>
            </div>
          </div>
          <div className="mt-10 grid gap-6 md:grid-cols-2 xl:grid-cols-4">
            {[1, 2, 3, 4].map((i) => (<div key={i} className="animate-pulse rounded-[28px] border border-slate-200 bg-slate-50 p-6">
                <div className="h-40 bg-gray-200 rounded-2xl mb-4"></div>
                <div className="h-4 bg-gray-200 rounded mb-2"></div>
                <div className="h-6 bg-gray-200 rounded mb-3"></div>
                <div className="h-3 bg-gray-200 rounded w-32"></div>
              </div>))}
          </div>
        </div>
      </div>);
    }
    return (<div className="container mx-auto px-4 py-10">
      <div className="rounded-[32px] bg-white p-8 shadow-xl">
        <div className="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
          <div>
            <h2 className="text-3xl font-bold text-gray-900">
              {category ? category.name : 'محصولات ما'}
            </h2>
            <p className="mt-3 max-w-2xl text-gray-600">
              {category ? category.description : 'مجموعهای از بهترین قطعات لوازم یدکی با دسته بندی های تخصصی'}
            </p>
          </div>
          <Link to="/" className="inline-flex items-center justify-center rounded-full bg-blue-600 px-6 py-3 text-sm font-semibold text-white transition hover:bg-blue-700">
            بازگشت به خانه
          </Link>
        </div>

        {/* Brand Filter Buttons */}
        <div className="mb-8">
          <div className="flex flex-wrap gap-3 justify-center">
            <button onClick={() => setActiveBrandFilter('all')} className={`px-5 py-2.5 rounded-xl font-medium transition-all ${activeBrandFilter === 'all' ? 'bg-gradient-to-r from-blue-600 to-cyan-500 text-white shadow-lg' : 'bg-white text-gray-700 border border-gray-300 hover:border-blue-400 hover:shadow-md'}`}>
              همه محصولات
            </button>
            <button onClick={() => setActiveBrandFilter('Saipa')} className={`px-5 py-2.5 rounded-xl font-medium transition-all ${activeBrandFilter === 'Saipa' ? 'bg-gradient-to-r from-orange-500 to-red-500 text-white shadow-lg' : 'bg-white text-gray-700 border border-gray-300 hover:border-orange-400 hover:shadow-md'}`}>
              لوازم سایپا
            </button>
            <button onClick={() => setActiveBrandFilter('IranKhodro')} className={`px-5 py-2.5 rounded-xl font-medium transition-all ${activeBrandFilter === 'IranKhodro' ? 'bg-gradient-to-r from-indigo-500 to-purple-500 text-white shadow-lg' : 'bg-white text-gray-700 border border-gray-300 hover:border-indigo-400 hover:shadow-md'}`}>
              لوازم ایران خودرو
            </button>
            <button onClick={() => setActiveBrandFilter('Chinese')} className={`px-5 py-2.5 rounded-xl font-medium transition-all ${activeBrandFilter === 'Chinese' ? 'bg-gradient-to-r from-cyan-500 to-sky-500 text-white shadow-lg' : 'bg-white text-gray-700 border border-gray-300 hover:border-cyan-400 hover:shadow-md'}`}>
              لوازم چینی
            </button>
          </div>
          
          {/* Active Filter Indicator */}
          {activeBrandFilter !== 'all' && (<div className="mt-4 text-center">
              <span className="inline-flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-blue-50 to-cyan-50 text-blue-700 text-sm font-medium rounded-full border border-blue-200">
                <span className="w-2 h-2 bg-blue-500 rounded-full animate-pulse"></span>
                فیلتر فعال: {activeBrandFilter === 'Saipa' ? 'لوازم سایپا' : activeBrandFilter === 'IranKhodro' ? 'لوازم ایران خودرو' : 'لوازم چینی'}
                <button onClick={() => setActiveBrandFilter('all')} className="text-blue-500 hover:text-blue-700 text-sm">
                  (حذف فیلتر)
                </button>
              </span>
            </div>)}
        </div>

        {filteredProducts.length === 0 ? (<div className="mt-10 text-center py-16 bg-gray-50 rounded-2xl">
            <div className="text-4xl mb-4">📦</div>
            <h3 className="text-xl font-bold text-gray-700 mb-2">محصولی یافت نشد</h3>
            <p className="text-gray-500">در این دسته بندی هنوز محصولی اضافه نشده است.</p>
          </div>) : (<div className="mt-10 grid gap-6 md:grid-cols-2 xl:grid-cols-4">
            {filteredProducts.map((product) => (<div key={product.id} className="rounded-[28px] border border-gray-200 bg-white p-6 shadow-sm transition-all hover:-translate-y-2 hover:shadow-xl">
                <div className="relative mb-4 overflow-hidden rounded-2xl bg-gray-100 h-48 flex items-center justify-center">
                  <img src={completeImageUrl(product.imageUrl) || 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png'} alt={product.name} className="h-40 w-40 object-contain" onError={(e) => {
                    e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
                }}/>
                </div>
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-1">
                    <Star className="h-4 w-4 text-yellow-400 fill-current"/>
                    <span className="text-sm font-medium text-gray-900">
                      {product.rating?.toFixed(1) || '5.0'}
                    </span>
                  </div>
                  <span className="px-3 py-1 bg-blue-100 text-blue-700 text-xs font-medium rounded-full">
                    {product.categoryName || product.brand}
                  </span>
                </div>
                <h3 className="text-lg font-bold text-gray-900 mb-2 line-clamp-1">
                  {product.name}
                </h3>
                <p className="text-gray-600 text-sm mb-4 line-clamp-2">
                  {product.description || 'توضیحات محصول'}
                </p>
                
                {/* Tags and Compatibility */}
                <div className="space-y-3 mb-4">
                  {/* Tags */}
                  {product.tags && product.tags.length > 0 && (<div className="flex flex-wrap gap-1">
                      <span className="text-xs text-gray-500 font-medium">هشتگها:</span>
                      {product.tags.slice(0, 4).map((tag, index) => (<span key={index} className="px-2 py-1 bg-gradient-to-r from-blue-50 to-blue-100 text-blue-700 text-xs font-medium rounded-full border border-blue-200">
                          #{tag}
                        </span>))}
                      {product.tags.length > 4 && (<span className="px-2 py-1 bg-gray-100 text-gray-600 text-xs rounded-full">
                          +{product.tags.length - 4}
                        </span>)}
                    </div>)}
                  
                  {/* Compatible Cars */}
                  {product.compatibleCars && (<div className="flex flex-wrap items-center gap-1">
                      <span className="text-xs text-gray-500 font-medium">سازگار با:</span>
                      <div className="flex flex-wrap gap-1">
                        {product.compatibleCars.split(',').slice(0, 3).map((car, index) => (<span key={index} className="px-2 py-1 bg-gradient-to-r from-green-50 to-green-100 text-green-700 text-xs font-medium rounded-full border border-green-200">
                            {car.trim()}
                          </span>))}
                        {product.compatibleCars.split(',').length > 3 && (<span className="px-2 py-1 bg-gray-100 text-gray-600 text-xs rounded-full">
                            +{product.compatibleCars.split(',').length - 3}
                          </span>)}
                      </div>
                    </div>)}
                </div>
                

              </div>))}
          </div>)}
      </div>
    </div>);
};
export default ProductsPage;
