import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { Tag, Car, Wrench, Shield, Phone, Package, CheckCircle } from 'lucide-react';
import { productApi } from '../services/api';
import type { Product } from '../types';
import SEO from '../components/SEO';
import { SEO_CONFIG, generateBreadcrumbData, generateFAQData } from '../utils/seoConfig';

const API_BASE = import.meta.env.VITE_API_URL?.replace('/api', '') || 'http://127.0.0.1:5000';
const SITE_URL = 'https://pinparts.ir';

const completeImageUrl = (url: string | undefined): string => {
  if (!url) return '';
  if (url.startsWith('http')) return url;
  if (url.startsWith('/uploads/')) return `${API_BASE}${url}`;
  return url;
};

const buildStructuredData = (product: Product, imageUrl: string) => {
  const productUrl = `${SITE_URL}/products/${product.id}`;
  const fullImage = imageUrl || `${SITE_URL}/PinpartStore.JPEG`;
  
  // Product Schema از SEO_CONFIG
  const productSchema = SEO_CONFIG.productDetail(product).structuredData(fullImage);
  
  // BreadcrumbList Schema
  const breadcrumbItems = [
    { name: 'خانه', url: SITE_URL },
    { name: 'محصولات', url: `${SITE_URL}/products` },
  ];
  
  if (product.categoryName) {
    breadcrumbItems.push({ 
      name: product.categoryName, 
      url: `${SITE_URL}/products?category=${product.categoryId}` 
    });
  }
  
  breadcrumbItems.push({ name: product.name, url: productUrl });
  
  const breadcrumbSchema = generateBreadcrumbData(breadcrumbItems);
  
  // FAQ Schema برای محصول
  const faqQuestions = [
    {
      question: `آیا قطعه ${product.name} اورجینال است؟`,
      answer: `بله، تمام قطعات ${product.name} ارائه شده در Pinpart Store اورجینال و با کیفیت اصلی میباشند.`
    },
    {
      question: `گارانتی قطعه ${product.name} چقدر است؟`,
      answer: product.warranty 
        ? `این محصول دارای ${product.warranty} گارانتی میباشد.`
        : 'تمامی محصولات ما دارای گارانتی کیفیت و اصالت کالا هستند.'
    },
    {
      question: `آیا قطعه ${product.name} برای خودرو من مناسب است؟`,
      answer: product.compatibleCars
        ? `این قطعه برای خودروهای ${product.compatibleCars} مناسب میباشد.`
        : 'برای اطمینان از سازگاری قطعه با خودروی خود، با کارشناسان ما تماس بگیرید.'
    }
  ];
  
  const faqSchema = generateFAQData(faqQuestions);

  return [productSchema, breadcrumbSchema, faqSchema];
};

const ProductDetailPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const [product, setProduct] = useState<Product | null>(null);
  const [loading, setLoading] = useState(true);
  const [imgError, setImgError] = useState(false);

  useEffect(() => {
    if (!id) return;
    setLoading(true);
    productApi.getById(Number(id))
      .then(setProduct)
      .catch(console.error)
      .finally(() => setLoading(false));
  }, [id]);

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-10">
        <div className="animate-pulse rounded-[32px] bg-white p-8 shadow-xl">
          <div className="grid gap-8 lg:grid-cols-[1.2fr_0.8fr]">
            <div className="h-80 rounded-[32px] bg-slate-200" />
            <div className="space-y-4">
              <div className="h-8 bg-slate-200 rounded w-3/4" />
              <div className="h-4 bg-slate-200 rounded w-1/2" />
              <div className="h-24 bg-slate-200 rounded" />
              <div className="h-4 bg-slate-200 rounded w-2/3" />
            </div>
          </div>
        </div>
      </div>
    );
  }

  if (!product) {
    return (
      <div className="container mx-auto px-4 py-10 text-center">
        <SEO title="محصول پیدا نشد" noindex />
        <h1 className="text-2xl font-bold text-gray-800 mb-4">محصول پیدا نشد</h1>
        <Link to="/products" className="text-blue-600 hover:underline">بازگشت به محصولات</Link>
      </div>
    );
  }

  const imageUrl = completeImageUrl(product.imageUrl);
  const structuredData = buildStructuredData(product, imageUrl);

  // استفاده از SEO_CONFIG برای title و description
  const seoConfig = SEO_CONFIG.productDetail(product);
  const seoTitle = seoConfig.title;
  const seoDesc = seoConfig.description;
  const seoKeywords = seoConfig.keywords;

  return (
    <>
      <SEO
        title={seoTitle}
        description={seoDesc}
        keywords={seoKeywords}
        image={imageUrl || undefined}
        type="product"
        structuredData={structuredData}
      />

      <div className="container mx-auto px-4 py-8">
        {/* Breadcrumb - مهم برای SEO */}
        <nav aria-label="breadcrumb" className="mb-6">
          <ol className="flex items-center gap-2 text-sm text-gray-500 flex-wrap">
            <li><Link to="/" className="hover:text-blue-600 transition-colors">خانه</Link></li>
            <li>/</li>
            <li><Link to="/products" className="hover:text-blue-600 transition-colors">محصولات</Link></li>
            {product.categoryName && (
              <>
                <li>/</li>
                <li className="text-gray-400">{product.categoryName}</li>
              </>
            )}
            <li>/</li>
            <li className="text-gray-800 font-medium line-clamp-1">{product.name}</li>
          </ol>
        </nav>

        <div className="rounded-[32px] bg-white p-6 sm:p-8 shadow-xl">
          <div className="grid gap-8 lg:grid-cols-[1.2fr_0.8fr]">

            {/* تصویر محصول */}
            <div className="rounded-[28px] bg-slate-50 border border-slate-100 flex items-center justify-center overflow-hidden aspect-square max-h-[480px]">
              <img
                src={imgError || !imageUrl ? 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png' : imageUrl}
                alt={`${product.name} - ${product.brand || 'قطعه یدکی'}`}
                title={product.name}
                className="w-full h-full object-contain p-6"
                onError={() => setImgError(true)}
                loading="eager"
                fetchPriority="high"
                width="480"
                height="480"
              />
            </div>

            {/* اطلاعات محصول */}
            <div className="space-y-5">

              {/* دستهبندی و برند */}
              <div className="flex flex-wrap gap-2">
                {product.categoryName && (
                  <span className="px-3 py-1 bg-blue-100 text-blue-700 text-xs font-medium rounded-full">
                    {product.categoryName}
                  </span>
                )}
                {product.brand && (
                  <span className="px-3 py-1 bg-gray-100 text-gray-700 text-xs font-medium rounded-full">
                    {product.brand}
                  </span>
                )}
                {product.isFeatured && (
                  <span className="px-3 py-1 bg-yellow-100 text-yellow-700 text-xs font-medium rounded-full">
                    ⭐ محصول ویژه
                  </span>
                )}
              </div>

              {/* عنوان - h1 مهم برای SEO */}
              <div>
                <h1 className="text-2xl sm:text-3xl font-bold text-gray-900 leading-tight">
                  {product.name}
                </h1>
                {product.partNumber && (
                  <p className="mt-1 text-sm text-gray-500">
                    کد قطعه: <span className="font-mono font-semibold text-gray-700">{product.partNumber}</span>
                  </p>
                )}
              </div>

              {/* توضیحات */}
              {product.description && (
                <p className="text-gray-600 leading-relaxed text-sm sm:text-base">
                  {product.description}
                </p>
              )}

              {/* مشخصات فنی - مهم برای SEO */}
              <div className="rounded-2xl border border-slate-200 bg-slate-50 p-5 space-y-3">
                <h2 className="text-sm font-bold text-gray-700 uppercase tracking-wide">مشخصات فنی</h2>
                
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                  {product.compatibleCars && (
                    <div className="flex items-start gap-3 text-sm text-gray-600">
                      <Car className="h-4 w-4 mt-0.5 text-blue-500 shrink-0" />
                      <div>
                        <span className="font-medium text-gray-700">سازگار با: </span>
                        <span className="text-gray-800">{product.compatibleCars}</span>
                      </div>
                    </div>
                  )}
                  
                  {product.material && (
                    <div className="flex items-start gap-3 text-sm text-gray-600">
                      <Wrench className="h-4 w-4 mt-0.5 text-blue-500 shrink-0" />
                      <div>
                        <span className="font-medium text-gray-700">جنس: </span>
                        <span className="text-gray-800">{product.material}</span>
                      </div>
                    </div>
                  )}
                  
                  {product.warranty && (
                    <div className="flex items-start gap-3 text-sm text-gray-600">
                      <Shield className="h-4 w-4 mt-0.5 text-green-500 shrink-0" />
                      <div>
                        <span className="font-medium text-gray-700">گارانتی: </span>
                        <span className="text-gray-800">{product.warranty}</span>
                      </div>
                    </div>
                  )}
                  
                  {product.brand && (
                    <div className="flex items-start gap-3 text-sm text-gray-600">
                      <Tag className="h-4 w-4 mt-0.5 text-purple-500 shrink-0" />
                      <div>
                        <span className="font-medium text-gray-700">برند: </span>
                        <span className="text-gray-800">{product.brand}</span>
                      </div>
                    </div>
                  )}
                  
                  {product.partNumber && (
                    <div className="flex items-start gap-3 text-sm text-gray-600">
                      <Package className="h-4 w-4 mt-0.5 text-orange-500 shrink-0" />
                      <div>
                        <span className="font-medium text-gray-700">کد قطعه: </span>
                        <span className="text-gray-800 font-mono">{product.partNumber}</span>
                      </div>
                    </div>
                  )}
                  
                  <div className="flex items-start gap-3 text-sm text-gray-600">
                    <CheckCircle className="h-4 w-4 mt-0.5 text-green-500 shrink-0" />
                    <div>
                      <span className="font-medium text-gray-700">وضعیت: </span>
                      <span className="text-gray-800">موجود در انبار</span>
                    </div>
                  </div>
                </div>
              </div>

              {/* تگها - مهم برای SEO */}
              {product.tags && product.tags.length > 0 && (
                <div>
                  <h3 className="text-sm font-bold text-gray-700 mb-2">کلمات کلیدی مرتبط:</h3>
                  <div className="flex flex-wrap gap-1.5">
                    {product.tags.map((tag, i) => (
                      <span key={i} className="px-2 py-1 bg-blue-50 text-blue-700 text-xs rounded-full border border-blue-200 hover:bg-blue-100 transition-colors">
                        #{tag}
                      </span>
                    ))}
                  </div>
                </div>
              )}

              {/* خودروهای سازگار به صورت badge */}
              {product.compatibleCars && (
                <div>
                  <h3 className="text-sm font-bold text-gray-700 mb-2">مناسب برای خودروهای:</h3>
                  <div className="flex flex-wrap gap-1.5">
                    {product.compatibleCars.split(',').map((car, i) => (
                      <span key={i} className="px-2 py-1 bg-green-50 text-green-700 text-xs rounded-full border border-green-200 hover:bg-green-100 transition-colors">
                        🚗 {car.trim()}
                      </span>
                    ))}
                  </div>
                </div>
              )}

              {/* دکمههای تماس */}
              <div className="flex flex-col gap-3 sm:flex-row pt-2">
                <a
                  href="https://wa.me/989196408805"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex-1 flex items-center justify-center gap-2 rounded-full bg-green-500 px-6 py-3 text-sm font-semibold text-white transition hover:bg-green-600 shadow-md"
                >
                  <span>💬</span>
                  استعلام قیمت از واتساپ
                </a>
                <a
                  href="tel:09196408805"
                  className="flex-1 flex items-center justify-center gap-2 rounded-full bg-slate-900 px-6 py-3 text-sm font-semibold text-white transition hover:bg-slate-700 shadow-md"
                >
                  <Phone className="h-4 w-4" />
                  تماس برای خرید
                </a>
              </div>

              <p className="text-xs text-gray-400 text-center">
                📦 ارسال به سراسر کشور | ✅ کیفیت تضمینی
              </p>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default ProductDetailPage;