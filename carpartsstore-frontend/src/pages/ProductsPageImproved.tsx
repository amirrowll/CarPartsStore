import { Link, useParams } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { categoryApi, productApi } from '../services/api';
import type { Product, Category } from '../types';

const ProductsPageImproved: React.FC = () => {
  const params = useParams<{ categoryId: string; id: string }>();
  const categoryId = params.categoryId || params.id;
  const [category, setCategory] = useState<Category | null>(null);
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      try {
        if (categoryId) {
          const categoryData = await categoryApi.getById(Number(categoryId));
          setCategory(categoryData);
          
          const productsData = await categoryApi.getProducts(Number(categoryId));
          setProducts(productsData.products || productsData || []);
        } else {
          const allProducts = await productApi.getAll();
          setProducts(allProducts.products || allProducts || []);
        }
      } catch (error) {
        console.error('Error fetching data:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [categoryId]);

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="text-center">
          <div className="inline-block w-12 h-12 border-4 border-blue-600 border-t-transparent rounded-full animate-spin mb-4"></div>
          <p className="text-gray-600">در حال بارگذاری محصولات...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <div className="mb-8">
          <div className="flex items-center gap-3 mb-4">
            <Link 
              to="/" 
              className="flex items-center gap-2 text-gray-600 hover:text-blue-600 transition-colors"
            >
              <span className="text-lg">←</span>
              بازگشت
            </Link>
          </div>
          
          <div className="bg-gradient-to-r from-blue-600 to-purple-600 text-white rounded-2xl p-8 mb-8">
            <h1 className="text-3xl font-bold mb-4">
              {category ? category.name : 'محصولات ما'}
            </h1>
            <p className="text-blue-100">
              {category ? category.description : 'مجموعهای از بهترین قطعات لوازم یدکی'}
            </p>
          </div>
        </div>

        {/* Products Grid */}
        {products.length === 0 ? (
          <div className="bg-white rounded-2xl p-8 text-center shadow">
            <div className="text-5xl mb-4">📦</div>
            <h3 className="text-xl font-bold text-gray-800 mb-3">محصولی یافت نشد</h3>
            <p className="text-gray-600 mb-6">
              در این دسته بندی هنوز محصولی اضافه نشده است.
            </p>
            <Link 
              to="/" 
              className="inline-block px-6 py-3 bg-blue-600 text-white font-medium rounded-xl hover:bg-blue-700 transition-colors"
            >
              بازگشت به صفحه اصلی
            </Link>
          </div>
        ) : (
          <div className="grid gap-6 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {products.map((product) => (
              <Link 
                key={product.id}
                to={`/products/${product.id}`}
                className="bg-white rounded-xl border border-gray-200 p-4 shadow-sm hover:shadow-lg transition-all duration-300 hover:-translate-y-1"
              >
                {/* Product Image */}
                <div className="relative mb-4 overflow-hidden rounded-lg bg-gray-100 aspect-square flex items-center justify-center">
                  <img
                    src={product.imageUrl || 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png'}
                    alt={product.name}
                    className="w-full h-full object-contain p-4"
                    loading="lazy"
                    onError={(e) => {
                      e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
                    }}
                  />
                  
                  {/* Rating Badge */}
                  <div className="absolute top-2 right-2 flex items-center gap-1 bg-white/90 px-2 py-1 rounded-full">
                    <span className="text-yellow-500">⭐</span>
                    <span className="text-xs font-bold text-gray-900">
                      {product.rating?.toFixed(1) || '5.0'}
                    </span>
                  </div>
                </div>

                {/* Product Info */}
                <div className="space-y-3">
                  <div className="flex items-center justify-between">
                    <span className="px-2 py-1 bg-blue-100 text-blue-700 text-xs font-medium rounded">
                      {product.brand || product.categoryName || 'بدون برند'}
                    </span>
                    <span className="text-xs text-gray-500">
                      #{product.partNumber || 'نامشخص'}
                    </span>
                  </div>

                  <h3 className="font-bold text-gray-900 line-clamp-2">
                    {product.name}
                  </h3>

                  <p className="text-gray-600 text-sm line-clamp-2">
                    {product.description || 'توضیحات محصول در دسترس نیست'}
                  </p>

                  <div className="pt-3 border-t border-gray-100">
                    <div className="flex justify-between items-center">
                      <span className="text-lg font-bold text-blue-600">
                        {product.price ? `${product.price.toLocaleString()} تومان` : 'قیمت نامشخص'}
                      </span>
                      <button className="px-4 py-2 bg-blue-600 text-white text-sm rounded-lg hover:bg-blue-700 transition-colors">
                        مشاهده جزئیات
                      </button>
                    </div>
                  </div>
                </div>
              </Link>
            ))}
          </div>
        )}

        {/* Products Count */}
        {products.length > 0 && (
          <div className="mt-8 text-center">
            <div className="inline-flex items-center gap-2 px-4 py-2 bg-gray-100 rounded-full">
              <span className="text-gray-700">
                نمایش <span className="font-bold text-blue-600">{products.length}</span> محصول
              </span>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default ProductsPageImproved;