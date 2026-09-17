import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import api from '../../services/api';
import { 
  Package, Search, Filter, Edit, Trash2, Eye, Plus, 
  ChevronLeft, ChevronRight, Tag, Car, Star 
} from 'lucide-react';

interface Product {
  id: number;
  name: string;
  description: string;
  categoryId: number;
  categoryName: string;
  imageUrl: string;
  tags: string[];
  hashtags: string[];
  additionalImages: string[];
  isFeatured: boolean;
  isActive: boolean;
  brand: string;
  partNumber: string;
  compatibleCars: string;
  carBrand: string;
  carModel: string;
  material: string;
  warranty: string;
  displayOrder: number;
  createdAt: string;
  updatedAt: string;
}

const Products: React.FC = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [searchTerm, setSearchTerm] = useState('');
  const [filterCarBrand, setFilterCarBrand] = useState('');
  const [filterFeatured, setFilterFeatured] = useState<boolean | null>(null);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalCount, setTotalCount] = useState(0);
  const [carBrands, setCarBrands] = useState<string[]>([]);
  const [deleteModal, setDeleteModal] = useState<{ show: boolean; productId: number | null; productName: string }>({
    show: false,
    productId: null,
    productName: ''
  });

  const pageSize = 12;

  useEffect(() => {
    fetchCarBrands();
    fetchProducts();
  }, [page, searchTerm, filterCarBrand, filterFeatured]);

  const fetchCarBrands = async () => {
    try {
      const response = await api.get('/products/car-brands');
      setCarBrands(response.data);
    } catch (err) {
      console.error('Error fetching car brands:', err);
    }
  };

  const fetchProducts = async () => {
    try {
      setLoading(true);
      const params = {
        page,
        pageSize,
        search: searchTerm || undefined,
        carBrand: filterCarBrand || undefined,
        isFeatured: filterFeatured !== null ? filterFeatured : undefined,
        sortBy: 'displayOrder',
        sortDescending: false
      };

      const response = await api.get('/products', { params });
      setProducts(response.data.products);
      setTotalCount(response.data.totalCount);
      setTotalPages(response.data.totalPages);
    } catch (err: any) {
      setError('خطا در دریافت محصولات');
      console.error('Products fetch error:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleDeleteProduct = async (productId: number) => {
    try {
      await api.delete(`/products/${productId}`);
      fetchProducts();
      setDeleteModal({ show: false, productId: null, productName: '' });
    } catch (err: any) {
      setError('خطا در حذف محصول');
      console.error('Delete product error:', err);
    }
  };

  const handleToggleFeatured = async (productId: number, currentStatus: boolean) => {
    try {
      const formData = new FormData();
      formData.append('isFeatured', (!currentStatus).toString());
      
      await api.put(`/products/${productId}`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      });
      fetchProducts();
    } catch (err: any) {
      setError('خطا در تغییر وضعیت محصول ویژه');
      console.error('Toggle featured error:', err);
    }
  };

  const handleToggleActive = async (productId: number, currentStatus: boolean) => {
    try {
      const formData = new FormData();
      formData.append('isActive', (!currentStatus).toString());
      
      await api.put(`/products/${productId}`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      });
      fetchProducts();
    } catch (err: any) {
      setError('خطا در تغییر وضعیت فعال بودن محصول');
      console.error('Toggle active error:', err);
    }
  };

  const clearFilters = () => {
    setSearchTerm('');
    setFilterCarBrand('');
    setFilterFeatured(null);
    setPage(1);
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="rounded-2xl bg-gradient-to-br from-gray-900 to-gray-800 p-6 shadow-2xl text-white">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <h2 className="text-2xl font-bold mb-2">مدیریت محصولات</h2>
            <p className="text-gray-300">مدیریت و سازماندهی محصولات فروشگاه ({totalCount} محصول)</p>
          </div>
          <Link
            to="/admin/products/create"
            className="inline-flex items-center gap-2 rounded-xl bg-white text-gray-900 px-5 py-3 font-medium hover:bg-gray-100 transition-colors"
          >
            <Plus className="h-5 w-5" />
            افزودن محصول جدید
          </Link>
        </div>
      </div>

      {/* Error Message */}
      {error && (
        <div className="rounded-2xl bg-red-50 border border-red-200 p-4">
          <p className="text-red-700 font-medium">{error}</p>
        </div>
      )}

      {/* Filters */}
      <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
        <div className="flex items-center gap-2 mb-6">
          <Filter className="h-5 w-5 text-blue-600" />
          <h3 className="text-lg font-semibold text-gray-800">فیلترها</h3>
        </div>

        <div className="grid gap-4 md:grid-cols-3">
          {/* Search */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              جستجوی محصول
            </label>
            <div className="relative">
              <Search className="absolute right-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400" />
              <input
                type="text"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                placeholder="نام محصول، کد، برند..."
                className="w-full pr-10 pl-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              />
            </div>
          </div>

          {/* Car Brand Filter */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              برند ماشین
            </label>
            <div className="relative">
              <Car className="absolute right-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400" />
              <select
                value={filterCarBrand}
                onChange={(e) => setFilterCarBrand(e.target.value)}
                className="w-full pr-10 pl-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500 appearance-none bg-white"
              >
                <option value="">همه برندها</option>
                {carBrands.map((brand) => (
                  <option key={brand} value={brand}>
                    {brand}
                  </option>
                ))}
              </select>
            </div>
          </div>

          {/* Featured Filter */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              وضعیت ویژه
            </label>
            <div className="relative">
              <Star className="absolute right-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400" />
              <select
                value={filterFeatured === null ? '' : filterFeatured ? 'true' : 'false'}
                onChange={(e) => setFilterFeatured(e.target.value === '' ? null : e.target.value === 'true')}
                className="w-full pr-10 pl-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500 appearance-none bg-white"
              >
                <option value="">همه محصولات</option>
                <option value="true">فقط محصولات ویژه</option>
                <option value="false">محصولات غیر ویژه</option>
              </select>
            </div>
          </div>
        </div>

        {/* Clear Filters */}
        <div className="mt-6 flex justify-end">
          <button
            onClick={clearFilters}
            className="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-lg hover:bg-gray-200 transition-colors"
          >
            پاک کردن فیلترها
          </button>
        </div>
      </div>

      {/* Products Grid */}
      <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
        {loading ? (
          <div className="text-center py-12">
            <div className="inline-block animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-600 mb-4"></div>
            <p className="text-gray-500">در حال بارگذاری محصولات...</p>
          </div>
        ) : products.length === 0 ? (
          <div className="text-center py-12">
            <Package className="h-16 w-16 text-gray-300 mx-auto mb-4" />
            <h4 className="text-lg font-medium text-gray-700 mb-2">محصولی یافت نشد</h4>
            <p className="text-gray-500">هیچ محصولی با فیلترهای انتخابی شما مطابقت ندارد</p>
            <button
              onClick={clearFilters}
              className="mt-4 px-4 py-2 text-sm font-medium text-blue-600 bg-blue-50 rounded-lg hover:bg-blue-100 transition-colors"
            >
              مشاهده همه محصولات
            </button>
          </div>
        ) : (
          <>
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {products.map((product) => (
                <div key={product.id} className="rounded-xl border border-gray-200 bg-white overflow-hidden hover:shadow-lg transition-shadow">
                  {/* Product Image */}
                  <div className="relative h-48 bg-gray-100">
                    {product.imageUrl ? (
                      <img
                        src={product.imageUrl}
                        alt={product.name}
                        className="w-full h-full object-cover"
                      />
                    ) : (
                      <div className="w-full h-full flex items-center justify-center">
                        <Package className="h-12 w-12 text-gray-400" />
                      </div>
                    )}
                    {/* Status Badges */}
                    <div className="absolute top-3 right-3 flex gap-2">
                      {product.isFeatured && (
                        <span className="px-2 py-1 text-xs font-medium bg-amber-100 text-amber-800 rounded-full">
                          <Star className="h-3 w-3 inline-block ml-1" />
                          ویژه
                        </span>
                      )}
                      {!product.isActive && (
                        <span className="px-2 py-1 text-xs font-medium bg-red-100 text-red-800 rounded-full">
                          غیرفعال
                        </span>
                      )}
                    </div>
                  </div>

                  {/* Product Info */}
                  <div className="p-4">
                    <h4 className="font-semibold text-gray-800 mb-2 line-clamp-1">{product.name}</h4>
                    <p className="text-sm text-gray-600 mb-3 line-clamp-2">{product.description}</p>
                    
                    {/* Product Details */}
                    <div className="space-y-2 mb-4">
                      <div className="flex items-center gap-2 text-sm text-gray-500">
                        <Car className="h-4 w-4" />
                        <span>{product.carBrand} {product.carModel && `- ${product.carModel}`}</span>
                      </div>
                      <div className="flex items-center gap-2 text-sm text-gray-500">
                        <Tag className="h-4 w-4" />
                        <span>{product.brand || 'بدون برند'}</span>
                      </div>
                    </div>

                    {/* Tags */}
                    {product.hashtags && product.hashtags.length > 0 && (
                      <div className="flex flex-wrap gap-1 mb-4">
                        {product.hashtags.slice(0, 3).map((hashtag, index) => (
                          <span key={index} className="px-2 py-1 text-xs bg-gray-100 text-gray-700 rounded">
                            #{hashtag}
                          </span>
                        ))}
                        {product.hashtags.length > 3 && (
                          <span className="px-2 py-1 text-xs bg-gray-100 text-gray-700 rounded">
                            +{product.hashtags.length - 3}
                          </span>
                        )}
                      </div>
                    )}

                    {/* Actions */}
                    <div className="flex items-center justify-between">
                      <div className="flex gap-2">
                        <Link
                          to={`/admin/products/edit/${product.id}`}
                          className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                          title="ویرایش"
                        >
                          <Edit className="h-4 w-4" />
                        </Link>
                        <button
                          onClick={() => handleToggleFeatured(product.id, product.isFeatured)}
                          className={`p-2 ${product.isFeatured ? 'text-amber-600 hover:bg-amber-50' : 'text-gray-600 hover:bg-gray-100'} rounded-lg transition-colors`}
                          title={product.isFeatured ? 'حذف از ویژه' : 'افزودن به ویژه'}
                        >
                          <Star className="h-4 w-4" />
                        </button>
                        <button
                          onClick={() => handleToggleActive(product.id, product.isActive)}
                          className={`p-2 ${product.isActive ? 'text-green-600 hover:bg-green-50' : 'text-red-600 hover:bg-red-50'} rounded-lg transition-colors`}
                          title={product.isActive ? 'غیرفعال کردن' : 'فعال کردن'}
                        >
                          <Eye className="h-4 w-4" />
                        </button>
                      </div>
                      <button
                        onClick={() => setDeleteModal({
                          show: true,
                          productId: product.id,
                          productName: product.name
                        })}
                        className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                        title="حذف"
                      >
                        <Trash2 className="h-4 w-4" />
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>

            {/* Pagination */}
            {totalPages > 1 && (
              <div className="mt-8 flex items-center justify-between">
                <div className="text-sm text-gray-600">
                  نمایش {(page - 1) * pageSize + 1} تا {Math.min(page * pageSize, totalCount)} از {totalCount} محصول
                </div>
                <div className="flex gap-2">
                  <button
                    onClick={() => setPage(prev => Math.max(prev - 1, 1))}
                    disabled={page === 1}
                    className="px-3 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-lg hover:bg-gray-200 disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    <ChevronRight className="h-4 w-4" />
                  </button>
                  {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
                    let pageNum;
                    if (totalPages <= 5) {
                      pageNum = i + 1;
                    } else if (page <= 3) {
                      pageNum = i + 1;
                    } else if (page >= totalPages - 2) {
                      pageNum = totalPages - 4 + i;
                    } else {
                      pageNum = page - 2 + i;
                    }
                    return (
                      <button
                        key={pageNum}
                        onClick={() => setPage(pageNum)}
                        className={`px-3 py-2 text-sm font-medium rounded-lg ${page === pageNum ? 'bg-blue-600 text-white' : 'text-gray-700 bg-gray-100 hover:bg-gray-200'}`}
                      >
                        {pageNum}
                      </button>
                    );
                  })}
                  <button
                    onClick={() => setPage(prev => Math.min(prev + 1, totalPages))}
                    disabled={page === totalPages}
                    className="px-3 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-lg hover:bg-gray-200 disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    <ChevronLeft className="h-4 w-4" />
                  </button>
                </div>
              </div>
            )}
          </>
        )}
      </div>

      {/* Delete Confirmation Modal */}
      {deleteModal.show && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-2xl p-6 max-w-md w-full">
            <h3 className="text-lg font-semibold text-gray-800 mb-4">تأیید حذف محصول</h3>
            <p className="text-gray-600 mb-6">
              آیا مطمئن هستید که میخواهید محصول "{deleteModal.productName}" را حذف کنید؟ این عمل قابل بازگشت نیست.
            </p>
            <div className="flex gap-3">
              <button
                onClick={() => handleDeleteProduct(deleteModal.productId!)}
                className="flex-1 px-4 py-3 bg-red-600 text-white font-medium rounded-xl hover:bg-red-700 transition-colors"
              >
                بله، حذف شود
              </button>
              <button
                onClick={() => setDeleteModal({ show: false, productId: null, productName: '' })}
                className="flex-1 px-4 py-3 bg-gray-100 text-gray-700 font-medium rounded-xl hover:bg-gray-200 transition-colors"
              >
                انصراف
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Products;