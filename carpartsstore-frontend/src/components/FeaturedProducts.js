import React from 'react';
import { Link } from 'react-router-dom';
import { Star } from 'lucide-react';
import { useAppContext } from '../context/AppContext';
const API_BASE = import.meta.env.VITE_API_URL?.replace('/api', '') || 'http://127.0.0.1:5000';
const completeImageUrl = (url) => {
    if (!url)
        return '';
    if (url.startsWith('http'))
        return url;
    if (url.startsWith('/uploads/'))
        return `${API_BASE}${url}`;
    if (url.startsWith('blob:'))
        return url;
    return url;
};
const FeaturedProducts = () => {
    const { featuredProducts, mostViewedProducts, loading } = useAppContext();
    if (loading) {
        return (<section className="py-16 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <div className="animate-pulse text-gray-500">در حال بارگذاری محصولات...</div>
        </div>
      </section>);
    }
    const productsToDisplay = featuredProducts?.length > 0 ? featuredProducts : mostViewedProducts;
    if (productsToDisplay.length === 0) {
        return (<section className="py-16 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
            محصولات <span className="text-blue-600">پیشنهادی</span>
          </h2>
          <p className="text-lg text-gray-600 mb-8">هنوز محصولی اضافه نشده است.</p>
        </div>
      </section>);
    }
    const displayedProducts = productsToDisplay.slice(0, 4);
    return (<section className="bg-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center mb-12">
          <div>
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              محصولات <span className="text-blue-600">
                {featuredProducts?.length > 0 ? 'ویژه' : 'پیشنهادی'}
              </span>
            </h2>
            <p className="text-lg text-gray-600">
              {featuredProducts?.length > 0 ? 'برترین محصولات ویژه' : 'برترین قطعات با بیشترین بازدید'}
            </p>
          </div>
          <Link to="/featured-products" className="px-6 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-medium rounded-xl hover:from-blue-700 hover:to-blue-800 transition-all shadow-lg hover:shadow-xl">
            مشاهده همه محصولات
          </Link>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
          {displayedProducts.map((product) => (<Link key={product.id} to={`/products/${product.id}`} className="bg-white rounded-2xl shadow-lg hover:shadow-2xl transition-all duration-300 overflow-hidden group border border-gray-100 flex flex-col">
              <div className="relative overflow-hidden">
                <img src={completeImageUrl(product.imageUrl) || 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png'} alt={product.name} loading="lazy" width="400" height="192" className="w-full h-48 object-cover group-hover:scale-105 transition-transform duration-300 bg-gray-100" onError={(e) => {
                e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
            }}/>
                <div className="absolute top-4 left-4">
                  <span className="px-3 py-1 bg-blue-600 text-white text-xs font-medium rounded-full">
                    {product.categoryName || 'قطعات خودرو'}
                  </span>
                </div>
              </div>

              <div className="p-6 flex flex-col flex-1">
                <div className="flex items-center mb-3">
                  <Star className="h-4 w-4 text-yellow-500 fill-current"/>
                  <span className="text-sm font-medium text-gray-900 mr-1">{product.rating?.toFixed(1) || '5.0'}</span>
                </div>

                <h3 className="text-lg font-bold text-gray-900 mb-2 line-clamp-1">{product.name}</h3>
                <p className="text-gray-600 text-sm mb-4 line-clamp-2 flex-1">
                  {product.description || 'توضیحات محصول'}
                </p>

                {product.tags && product.tags.length > 0 && (<div className="flex flex-wrap gap-1 mb-2">
                    {product.tags.slice(0, 4).map((tag, index) => (<span key={index} className="px-2 py-1 bg-blue-50 text-blue-700 text-xs font-medium rounded-full border border-blue-200">
                        #{tag}
                      </span>))}
                    {product.tags.length > 4 && (<span className="px-2 py-1 bg-gray-100 text-gray-600 text-xs rounded-full">+{product.tags.length - 4}</span>)}
                  </div>)}

                {product.compatibleCars && (<div className="flex flex-wrap gap-1">
                    {product.compatibleCars.split(',').slice(0, 3).map((car, index) => (<span key={index} className="px-2 py-1 bg-green-50 text-green-700 text-xs font-medium rounded-full border border-green-200">
                        {car.trim()}
                      </span>))}
                    {product.compatibleCars.split(',').length > 3 && (<span className="px-2 py-1 bg-gray-100 text-gray-600 text-xs rounded-full">
                        +{product.compatibleCars.split(',').length - 3}
                      </span>)}
                  </div>)}
              </div>
            </Link>))}
        </div>
      </div>
    </section>);
};
export default FeaturedProducts;
