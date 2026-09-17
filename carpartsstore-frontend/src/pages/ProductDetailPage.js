import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { ChevronLeft, Tag, Car, Wrench, Shield } from 'lucide-react';
import { productApi } from '../services/api';
import SEO from '../components/SEO';
const API_BASE = import.meta.env.VITE_API_URL?.replace('/api', '') || 'http://127.0.0.1:5000';
const completeImageUrl = (url) => {
    if (!url)
        return '';
    if (url.startsWith('http'))
        return url;
    if (url.startsWith('/uploads/'))
        return `${API_BASE}${url}`;
    return url;
};
const ProductDetailPage = () => {
    const { id } = useParams();
    const [product, setProduct] = useState(null);
    const [loading, setLoading] = useState(true);
    const [imgError, setImgError] = useState(false);
    useEffect(() => {
        if (!id)
            return;
        setLoading(true);
        productApi.getById(Number(id))
            .then(setProduct)
            .catch(console.error)
            .finally(() => setLoading(false));
    }, [id]);
    if (loading) {
        return (<div className="container mx-auto px-4 py-10">
        <div className="animate-pulse rounded-[32px] bg-white p-8 shadow-xl">
          <div className="grid gap-8 lg:grid-cols-[1.2fr_0.8fr]">
            <div className="h-80 rounded-[32px] bg-slate-200"/>
            <div className="space-y-4">
              <div className="h-8 bg-slate-200 rounded w-3/4"/>
              <div className="h-4 bg-slate-200 rounded w-1/2"/>
              <div className="h-24 bg-slate-200 rounded"/>
            </div>
          </div>
        </div>
      </div>);
    }
    if (!product) {
        return (<div className="container mx-auto px-4 py-10 text-center">
        <h2 className="text-2xl font-bold text-gray-800 mb-4">محصول پیدا نشد</h2>
        <Link to="/products" className="text-blue-600 hover:underline">بازگشت به محصولات</Link>
      </div>);
    }
    const imageUrl = completeImageUrl(product.imageUrl);
    const productSchema = {
        '@context': 'https://schema.org',
        '@type': 'Product',
        name: product.name,
        description: product.description,
        image: imageUrl || `${API_BASE}/PinpartStore.JPEG`,
        sku: product.partNumber,
        brand: product.brand ? { '@type': 'Brand', name: product.brand } : undefined,
        offers: {
            '@type': 'Offer',
            availability: 'https://schema.org/InStock',
            priceCurrency: 'IRR',
            seller: { '@type': 'Organization', name: 'Pinpart Store' },
        },
    };
    return (<>
      <SEO title={`${product.name} - فروشگاه قطعات خودرو`} description={product.description || `${product.name} - قطعه یدکی با کیفیت برای ${product.compatibleCars || 'خودروهای مختلف'}`} keywords={`${product.name}, ${product.brand || ''}, ${product.partNumber || ''}, ${product.compatibleCars || ''}, قطعات یدکی`} type="product" structuredData={productSchema}/>
      <div className="container mx-auto px-4 py-10">
        <Link to="/products" className="inline-flex items-center gap-2 text-gray-600 hover:text-blue-600 mb-6 transition-colors">
          <ChevronLeft className="h-4 w-4"/>
          بازگشت به محصولات
        </Link>

        <div className="rounded-[32px] bg-white p-6 sm:p-8 shadow-xl">
          <div className="grid gap-8 lg:grid-cols-[1.2fr_0.8fr]">
            {/* تصویر محصول */}
            <div className="h-72 sm:h-96 rounded-[28px] bg-slate-100 flex items-center justify-center overflow-hidden">
              <img src={imgError || !imageUrl ? 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png' : imageUrl} alt={product.name} className="w-full h-full object-contain p-4" onError={() => setImgError(true)} loading="lazy"/>
            </div>

            {/* اطلاعات محصول */}
            <div className="space-y-5">
              <div className="space-y-2">
                <div className="flex flex-wrap gap-2">
                  {product.categoryName && (<span className="px-3 py-1 bg-blue-100 text-blue-700 text-xs font-medium rounded-full">
                      {product.categoryName}
                    </span>)}
                  {product.brand && (<span className="px-3 py-1 bg-gray-100 text-gray-700 text-xs font-medium rounded-full">
                      {product.brand}
                    </span>)}
                </div>
                <h1 className="text-2xl sm:text-3xl font-bold text-gray-900">{product.name}</h1>
                {product.partNumber && (<p className="text-sm text-gray-500">کد قطعه: <span className="font-mono font-medium">{product.partNumber}</span></p>)}
              </div>

              {product.description && (<p className="text-gray-600 leading-relaxed">{product.description}</p>)}

              {/* مشخصات */}
              <div className="rounded-[24px] border border-slate-200 bg-slate-50 p-5 space-y-3">
                <h2 className="text-base font-semibold text-gray-800">مشخصات فنی</h2>
                {product.compatibleCars && (<div className="flex items-start gap-2 text-sm text-gray-600">
                    <Car className="h-4 w-4 mt-0.5 text-blue-500 shrink-0"/>
                    <span><strong>سازگار با:</strong> {product.compatibleCars}</span>
                  </div>)}
                {product.material && (<div className="flex items-start gap-2 text-sm text-gray-600">
                    <Wrench className="h-4 w-4 mt-0.5 text-blue-500 shrink-0"/>
                    <span><strong>جنس:</strong> {product.material}</span>
                  </div>)}
                {product.warranty && (<div className="flex items-start gap-2 text-sm text-gray-600">
                    <Shield className="h-4 w-4 mt-0.5 text-green-500 shrink-0"/>
                    <span><strong>گارانتی:</strong> {product.warranty}</span>
                  </div>)}
              </div>

              {/* تگ‌ها */}
              {product.tags && product.tags.length > 0 && (<div className="flex flex-wrap items-center gap-2">
                  <Tag className="h-4 w-4 text-gray-400"/>
                  {product.tags.map((tag, i) => (<span key={i} className="px-2 py-1 bg-blue-50 text-blue-700 text-xs rounded-full border border-blue-200">
                      #{tag}
                    </span>))}
                </div>)}

              <div className="flex flex-col gap-3 sm:flex-row pt-2">
                <a href="https://wa.me/989196408805" target="_blank" rel="noopener noreferrer" className="flex-1 text-center rounded-full bg-green-500 px-6 py-3 text-sm font-semibold text-white transition hover:bg-green-600">
                  استعلام قیمت از واتساپ
                </a>
                <a href="tel:09196408805" className="flex-1 text-center rounded-full bg-slate-900 px-6 py-3 text-sm font-semibold text-white transition hover:bg-slate-700">
                  تماس برای خرید
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>);
};
export default ProductDetailPage;
