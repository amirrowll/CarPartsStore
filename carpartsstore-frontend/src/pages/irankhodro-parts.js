import { useEffect, useState } from 'react';
import { productApi } from '../services/api';
import { sampleProducts } from '../utils/sampleData';
import { Star } from 'lucide-react';
import { Bolt, EmojiEvents, Build } from '@mui/icons-material';
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
const IranKhodroPartsPage = () => {
    const [products, setProducts] = useState(sampleProducts.filter((p) => p.brand === 'IranKhodro'));
    useEffect(() => {
        productApi
            .getProductsByBrand('IranKhodro', 24)
            .then((data) => {
            const products = data.products || data;
            setProducts(Array.isArray(products) ? products : []);
        })
            .catch(() => { });
    }, []);
    return (<div className="min-h-screen bg-gradient-to-b from-gray-50 to-white">
      <div className="container mx-auto px-4 py-10">
        <section className="rounded-[32px] bg-gradient-to-r from-sky-500 to-indigo-700 p-8 md:p-10 text-white shadow-2xl mb-10">
          <h1 className="text-3xl md:text-4xl font-extrabold">لوازم ایران خودرو</h1>
          <p className="mt-4 max-w-2xl text-base md:text-lg text-sky-100/90">
            قطعات تخصصی برای ایران خودرو با طراحی شکیل و تجربه خرید هوشمندانه برای حفظ ایمنی و عملکرد خودرو.
          </p>
          <div className="mt-8 flex justify-center gap-4">
            <div className="rounded-2xl md:rounded-3xl bg-white/10 p-4 md:p-5 text-center flex flex-col items-center justify-center">
              <Bolt className="text-2xl mb-2 text-white"/>
              <h3 className="font-bold">تامین سریع</h3>
            </div>
            <div className="rounded-2xl md:rounded-3xl bg-white/10 p-4 md:p-5 text-center flex flex-col items-center justify-center">
              <EmojiEvents className="text-2xl mb-2 text-white"/>
              <h3 className="font-bold">کیفیت بالای قطعات</h3>
            </div>
            <div className="rounded-2xl md:rounded-3xl bg-white/10 p-4 md:p-5 text-center flex flex-col items-center justify-center">
              <Build className="text-2xl mb-2 text-white"/>
              <h3 className="font-bold">پشتیبانی فنی</h3>
            </div>
          </div>
        </section>
        
        <div className="mt-8 grid gap-6 md:grid-cols-2 xl:grid-cols-4">
          {products.map((product) => (<div key={product.id} className="rounded-[28px] border border-slate-200 bg-white p-5 shadow-lg transition hover:-translate-y-1">
              <div className="relative h-48 overflow-hidden rounded-3xl bg-gradient-to-br from-gray-100 to-gray-200 flex items-center justify-center">
                <img src={completeImageUrl(product.imageUrl) || 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png'} alt={product.name} className="h-40 w-40 object-contain p-4" onError={(e) => {
                e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
            }}/>
                {/* Rating Badge */}
                {product.rating && (<div className="absolute top-3 right-3 flex items-center gap-1 bg-white/90 backdrop-blur-sm px-2 py-1 rounded-full">
                    <Star className="h-3 w-3 text-yellow-500 fill-current"/>
                    <span className="text-xs font-bold text-gray-900">
                      {product.rating?.toFixed(1)}
                    </span>
                  </div>)}
              </div>
              <div className="mt-4 space-y-3">
                <div className="flex items-center justify-between">
                  <span className="px-3 py-1 bg-indigo-100 text-indigo-700 text-xs font-medium rounded-full">
                    {product.categoryName || 'قطعات خودرو'}
                  </span>
                  <div className="flex items-center gap-1">
                    <Star className="h-3 w-3 text-yellow-400 fill-current"/>
                    <span className="text-xs font-medium text-gray-900">
                      {product.rating?.toFixed(1) || '5.0'}
                    </span>
                  </div>
                </div>
                
                <h2 className="text-lg font-bold text-gray-900 line-clamp-1">{product.name}</h2>
                <p className="text-sm text-gray-600 line-clamp-2">{product.description || 'توضیحات محصول'}</p>
                
                {/* Tags and Compatibility */}
                <div className="space-y-2">
                  {/* Tags */}
                  {product.tags && product.tags.length > 0 && (<div className="flex flex-wrap gap-1">
                      <span className="text-xs text-gray-500 font-medium">هشتگها:</span>
                      {product.tags.slice(0, 3).map((tag, index) => (<span key={index} className="px-2 py-1 bg-gradient-to-r from-blue-50 to-blue-100 text-blue-700 text-xs font-medium rounded-full border border-blue-200">
                          #{tag}
                        </span>))}
                      {product.tags.length > 3 && (<span className="px-2 py-1 bg-gray-100 text-gray-600 text-xs rounded-full">
                          +{product.tags.length - 3}
                        </span>)}
                    </div>)}
                  
                  {/* Compatible Cars */}
                  {product.compatibleCars && (<div className="flex flex-wrap items-center gap-1">
                      <span className="text-xs text-gray-500 font-medium">سازگار با:</span>
                      <div className="flex flex-wrap gap-1">
                        {product.compatibleCars.split(',').slice(0, 2).map((car, index) => (<span key={index} className="px-2 py-1 bg-gradient-to-r from-green-50 to-green-100 text-green-700 text-xs font-medium rounded-full border border-green-200">
                            {car.trim()}
                          </span>))}
                        {product.compatibleCars.split(',').length > 2 && (<span className="px-2 py-1 bg-gray-100 text-gray-600 text-xs rounded-full">
                            +{product.compatibleCars.split(',').length - 2}
                          </span>)}
                      </div>
                    </div>)}
                </div>
                
                <div className="flex items-center justify-between pt-2 border-t border-gray-100">
                  <span className="text-xs text-gray-500">برند: {product.brand || product.carBrand || 'بدون برند'}</span>
                  <span className="text-xs text-gray-500">کد: {product.partNumber || 'ندارد'}</span>
                </div>
              </div>
            </div>))}
        </div>
      </div>
    </div>);
};
export default IranKhodroPartsPage;
