import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { productApi } from '../services/api';
import { Star, ArrowLeft } from 'lucide-react';
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
const AllFeaturedProductsPage = () => {
    const [products, setProducts] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    useEffect(() => {
        fetchFeaturedProducts();
    }, []);
    const fetchFeaturedProducts = async () => {
        try {
            setLoading(true);
            const response = await productApi.getAll({
                isFeatured: true,
                isActive: true,
                pageSize: 50,
                sortBy: 'displayOrder',
                sortDescending: false
            });
            setProducts(response.products || []);
        }
        catch (err) {
            setError('خطا در دریافت محصولات ویژه');
            console.error('Error fetching featured products:', err);
        }
        finally {
            setLoading(false);
        }
    };
    if (loading) {
        return (<div className="container mx-auto px-4 py-16">
        <div className="rounded-[32px] bg-white p-8 shadow-xl">
          <div className="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
            <div className="animate-pulse">
              <div className="h-8 bg-gray-200 rounded w-48 mb-3"></div>
              <div className="h-4 bg-gray-200 rounded w-64"></div>
            </div>
          </div>
          <div className="mt-10 grid gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {[1, 2, 3, 4, 5, 6, 7, 8].map((i) => (<div key={i} className="animate-pulse rounded-[28px] border border-slate-200 bg-slate-50 p-6">
                <div className="h-40 bg-gray-200 rounded-2xl mb-4"></div>
                <div className="h-4 bg-gray-200 rounded mb-2"></div>
                <div className="h-6 bg-gray-200 rounded mb-3"></div>
                <div className="h-3 bg-gray-200 rounded w-32"></div>
              </div>))}
          </div>
        </div>
      </div>);
    }
    return (<div className="min-h-screen bg-gradient-to-b from-gray-50 to-white">
      <div className="container mx-auto px-4 py-16">
        
        <div className="rounded-[32px] bg-white p-8 shadow-xl mt-10">
        <div className="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
          <div>
            <h2 className="text-3xl font-bold text-gray-900 mb-2">
              <span className="text-amber-600">محصولات ویژه</span>
            </h2>
            <p className="mt-3 max-w-2xl text-gray-600">
              مجموعهای از بهترین محصولات ویژه و پیشنهادی ما
              {products.length > 0 && (<span className="text-amber-600 font-medium mr-2">
                  ({products.length} محصول)
                </span>)}
            </p>
          </div>
          <Link to="/" className="inline-flex items-center gap-2 rounded-full bg-blue-600 px-6 py-3 text-sm font-semibold text-white transition hover:bg-blue-700">
            <ArrowLeft className="h-4 w-4"/>
            بازگشت به خانه
          </Link>
        </div>

        {error && (<div className="mt-6 rounded-2xl bg-red-50 border border-red-200 p-4">
            <p className="text-red-700 font-medium">{error}</p>
          </div>)}

        {products.length === 0 ? (<div className="mt-10 text-center py-16 bg-gray-50 rounded-2xl">
            <div className="text-4xl mb-4">✨</div>
            <h3 className="text-xl font-bold text-gray-700 mb-2">محصول ویژهای یافت نشد</h3>
            <p className="text-gray-500 mb-4">هیچ محصول ویژهای تعریف نشده است.</p>
            <Link to="/admin/products/create" className="px-4 py-2 bg-gradient-to-r from-green-500 to-green-600 text-white font-medium rounded-lg hover:from-green-600 hover:to-green-700 transition-all">
              ایجاد محصول جدید
            </Link>
          </div>) : (<div className="mt-10 grid gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {products.map((product) => (<div key={product.id} className="rounded-[28px] border border-gray-200 bg-white p-6 shadow-sm transition-all hover:-translate-y-2 hover:shadow-xl group">
                {/* Featured Badge */}
                <div className="absolute top-3 right-3">
                  <span className="px-3 py-1 bg-gradient-to-r from-amber-500 to-amber-600 text-white text-xs font-medium rounded-full shadow-md">
                    <Star className="h-3 w-3 inline-block ml-1 fill-current"/>
                    ویژه
                  </span>
                </div>
                
                <div className="relative mb-4 overflow-hidden rounded-2xl bg-gray-100 h-48 flex items-center justify-center">
                  <img src={completeImageUrl(product.imageUrl) || 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png'} alt={product.name} className="h-40 w-40 object-contain group-hover:scale-105 transition-transform duration-300" onError={(e) => {
                    e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
                }}/>
                </div>
                
                <div className="mb-2">
                  <div className="flex items-center justify-between">
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
      </div>
    </div>);
};
export default AllFeaturedProductsPage;
