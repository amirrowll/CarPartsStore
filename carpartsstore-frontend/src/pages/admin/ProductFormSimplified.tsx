import { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import api from '../../services/api';
import { 
  Package, Save, X, Upload, Tag, Building, 
  Star, Check
} from 'lucide-react';

interface Category {
  id: number;
  name: string;
  description: string;
  productCount: number;
}

interface ProductFormData {
  name: string;
  description: string;
  categoryId: number;
  imageUrl: string;
  imageFile?: File | null;
  tags: string[];
  brand: string;
  partNumber: string;
  compatibleCars: string;
  carBrand: string;
  carModel: string;
  material: string;
  warranty: string;
  displayOrder: number;
  isFeatured: boolean;
  isActive: boolean;
}

// برندهای اصلی برای فیلتر محصولات در frontend
const mainBrandOptions = [
  { value: 'Chinese', label: 'خودروهای چینی', color: 'bg-gradient-to-r from-cyan-500 to-sky-600' },
  { value: 'Saipa', label: 'سایپا', color: 'bg-gradient-to-r from-orange-400 to-red-500' },
  { value: 'IranKhodro', label: 'ایران خودرو', color: 'bg-gradient-to-r from-sky-500 to-indigo-700' },
];

const ProductFormSimplified: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const isEditMode = !!id;

  const [formData, setFormData] = useState<ProductFormData>({
    name: '',
    description: '',
    categoryId: 1,
    imageUrl: '',
    imageFile: null,
    tags: [],
    brand: '',
    partNumber: '',
    compatibleCars: '',
    carBrand: '',
    carModel: '',
    material: '',
    warranty: '',
    displayOrder: 0,
    isFeatured: false,
    isActive: true
  });

  const [categories, setCategories] = useState<Category[]>([]);
  const [loading, setLoading] = useState(false);
  const [loadingCategories, setLoadingCategories] = useState(true);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [tagInput, setTagInput] = useState('');

  useEffect(() => {
    fetchCategories();
    if (isEditMode) {
      fetchProduct();
    }
    
    // Cleanup function to revoke object URLs
    return () => {
      if (formData.imageFile) {
        URL.revokeObjectURL(URL.createObjectURL(formData.imageFile));
      }
    };
  }, [id]);

  const fetchCategories = async () => {
    try {
      const response = await api.get('/categories');
      setCategories(response.data);
    } catch (err) {
      setError('خطا در دریافت دسته بندیها');
    } finally {
      setLoadingCategories(false);
    }
  };

  const fetchProduct = async () => {
    try {
      setLoading(true);
      const response = await api.get(`/products/${id}`);
      const product = response.data;
      
      setFormData({
        name: product.name || '',
        description: product.description || '',
        categoryId: product.categoryId || 1,
        imageUrl: product.imageUrl || '',
        imageFile: null,
        tags: product.tags || [],
        brand: product.brand || '',
        partNumber: product.partNumber || '',
        compatibleCars: product.compatibleCars || '',
        carBrand: product.carBrand || '',
        carModel: product.carModel || '',
        material: product.material || '',
        warranty: product.warranty || '',
        displayOrder: product.displayOrder || 0,
        isFeatured: product.isFeatured || false,
        isActive: product.isActive !== undefined ? product.isActive : true
      });
    } catch (err: any) {
      setError('خطا در دریافت اطلاعات محصول');
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    setSuccess('');

    try {
      // Prepare FormData for multipart upload
      const formDataToSend = new FormData();
      
      // Add all form data fields
      formDataToSend.append('name', formData.name);
      formDataToSend.append('description', formData.description);
      formDataToSend.append('categoryId', formData.categoryId.toString());
      formDataToSend.append('tags', formData.tags.length > 0 ? formData.tags.join(',') : '');
      formDataToSend.append('brand', formData.brand);
      formDataToSend.append('partNumber', formData.partNumber);
      formDataToSend.append('compatibleCars', formData.compatibleCars);
      formDataToSend.append('carBrand', formData.carBrand);
      formDataToSend.append('carModel', formData.carModel);
      formDataToSend.append('material', formData.material);
      formDataToSend.append('warranty', formData.warranty);
      formDataToSend.append('displayOrder', formData.displayOrder.toString());
      formDataToSend.append('isFeatured', formData.isFeatured.toString());
      formDataToSend.append('isActive', formData.isActive.toString());
      
      // Add image file if exists
      if (formData.imageFile) {
        formDataToSend.append('imageFile', formData.imageFile);
      } else if (formData.imageUrl) {
        // If no file but has URL, use URL
        formDataToSend.append('imageUrl', formData.imageUrl);
      }

      // Ensure categoryId is valid
      if (formData.categoryId <= 0) {
        if (categories.length > 0) {
          formData.categoryId = categories[0].id;
          formDataToSend.set('categoryId', categories[0].id.toString());
        } else {
          setError('ابتدا باید دسته بندی ایجاد کنید');
          setLoading(false);
          return;
        }
      }

      if (isEditMode) {
        await api.put(`/products/${id}`, formDataToSend, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        });
        setSuccess('محصول با موفقیت ویرایش شد');
      } else {
        const response = await api.post('/products', formDataToSend, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        });
        setSuccess('محصول با موفقیت ایجاد شد');
        setTimeout(() => {
          navigate(`/admin/products/edit/${response.data.id}`);
        }, 1500);
      }
    } catch (err: any) {
      setError(err.response?.data?.message || 'خطا در ذخیره محصول');
    } finally {
      setLoading(false);
    }
  };

  const handleAddTag = () => {
    if (tagInput.trim() && !formData.tags.includes(tagInput.trim())) {
      setFormData({
        ...formData,
        tags: [...formData.tags, tagInput.trim()]
      });
      setTagInput('');
    }
  };

  const handleRemoveTag = (tagToRemove: string) => {
    setFormData({
      ...formData,
      tags: formData.tags.filter(tag => tag !== tagToRemove)
    });
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter') {
      e.preventDefault();
      handleAddTag();
    }
  };

  // Handle image file upload
  const handleImageFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      const file = e.target.files[0];
      // Store file and clear URL (URL will come from backend after upload)
      setFormData(prev => ({ 
        ...prev, 
        imageFile: file, 
        imageUrl: '' // Clear URL, backend will create new one
      }));
    }
  };

  if (loadingCategories) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <div className="inline-block animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-600 mb-4"></div>
          <p className="text-gray-500">در حال بارگذاری...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-6xl mx-auto p-4">
      {/* Header */}
      <div className="rounded-2xl bg-gradient-to-br from-gray-900 to-gray-800 p-6 shadow-2xl text-white mb-6">
        <div className="flex items-center gap-3 mb-2">
          <Package className="h-6 w-6" />
          <h2 className="text-2xl font-bold">
            {isEditMode ? 'ویرایش محصول' : 'ایجاد محصول جدید'}
          </h2>
        </div>
        <p className="text-gray-300">
          {isEditMode 
            ? 'اطلاعات محصول را ویرایش کنید' 
            : 'فرم زیر را برای ایجاد محصول جدید تکمیل کنید'}
        </p>
      </div>

      {/* Messages */}
      {error && (
        <div className="rounded-2xl bg-red-50 border border-red-200 p-4 mb-6">
          <p className="text-red-700 font-medium">{error}</p>
        </div>
      )}

      {success && (
        <div className="rounded-2xl bg-green-50 border border-green-200 p-4 mb-6">
          <p className="text-green-700 font-medium">{success}</p>
        </div>
      )}

      {/* Form */}
      <form onSubmit={handleSubmit} className="space-y-6">
        <div className="grid gap-6 lg:grid-cols-2">
          {/* Left Column - Basic Info */}
          <div className="space-y-6">
            {/* Product Name */}
            <div className="rounded-2xl border border-gray-200 bg-white p-6">
              <label className="block text-sm font-semibold text-gray-800 mb-3">
                نام محصول *
              </label>
              <input
                type="text"
                value={formData.name}
                onChange={(e) => setFormData({...formData, name: e.target.value})}
                required
                className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                placeholder="نام کامل محصول"
              />
            </div>

            {/* Description */}
            <div className="rounded-2xl border border-gray-200 bg-white p-6">
              <label className="block text-sm font-semibold text-gray-800 mb-3">
                توضیحات محصول
              </label>
              <textarea
                value={formData.description}
                onChange={(e) => setFormData({...formData, description: e.target.value})}
                rows={4}
                className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                placeholder="توضیحات کامل درباره محصول"
              />
            </div>

            {/* Category */}
            <div className="rounded-2xl border border-gray-200 bg-white p-6">
              <label className="block text-sm font-semibold text-gray-800 mb-3">
                دسته بندی *
              </label>
              <select
                value={formData.categoryId}
                onChange={(e) => setFormData({...formData, categoryId: parseInt(e.target.value)})}
                required
                className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500 appearance-none bg-white"
              >
                {categories.map((category) => (
                  <option key={category.id} value={category.id}>
                    {category.name} ({category.productCount} محصول)
                  </option>
                ))}
              </select>
            </div>

            {/* Image */}
            <div className="rounded-2xl border border-gray-200 bg-white p-6">
              <label className="block text-sm font-semibold text-gray-800 mb-3">
                عکس محصول *
              </label>
              <div className="flex flex-col gap-3">
                {/* File Upload */}
                <div className="mb-3">
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    آپلود عکس از سیستم:
                  </label>
                  <input
                    type="file"
                    accept="image/*"
                    onChange={handleImageFileChange}
                    className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  />
                  {formData.imageFile && (
                    <p className="text-xs text-green-600 mt-1">
                      ✓ فایل انتخاب شده: {formData.imageFile.name} ({Math.round(formData.imageFile.size / 1024)}KB)
                    </p>
                  )}
                </div>
                
                <div className="mb-3">
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    یا آدرس عکس موجود:
                  </label>
                  <input
                    type="text"
                    value={formData.imageUrl}
                    onChange={(e) => setFormData({...formData, imageUrl: e.target.value})}
                    className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                    placeholder="https://example.com/image.jpg"
                  />
                </div>
              </div>
              
              {/* Image Preview */}
              {(formData.imageUrl || formData.imageFile) && (
                <div className="mt-4">
                  <div className="text-sm text-gray-600 mb-2">پیشنمایش:</div>
                  <div className="h-48 w-full flex items-center justify-center rounded-lg border border-gray-300 bg-gray-50 overflow-hidden">
                    {formData.imageUrl && !formData.imageUrl.startsWith('blob:') ? (
                      <img
                        src={formData.imageUrl}
                        alt="Product preview"
                        className="h-full w-full object-contain"
                        onError={(e) => {
                          e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
                        }}
                      />
                    ) : formData.imageFile ? (
                      <img
                        src={URL.createObjectURL(formData.imageFile)}
                        alt="Product preview"
                        className="h-full w-full object-contain"
                        onError={(e) => {
                          e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
                        }}
                      />
                    ) : null}
                  </div>
                </div>
              )}
            </div>
          </div>

          {/* Right Column - Specifications */}
          <div className="space-y-6">
            {/* Brand & Part Number */}
            <div className="grid gap-4">
              {/* Brand Selection */}
              <div className="rounded-2xl border border-gray-200 bg-white p-6">
                <label className="block text-sm font-semibold text-gray-800 mb-3">
                  <Building className="h-4 w-4 inline-block ml-1" />
                  برند محصول *
                </label>
                <div className="mb-4">
                  <p className="text-sm text-gray-600 mb-3">برای نمایش در صفحات اختصاصی هر برند، یکی از برندهای زیر را انتخاب کنید:</p>
                  <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 mb-4">
                    {mainBrandOptions.map((option) => (
                      <button
                        type="button"
                        key={option.value}
                        onClick={() => setFormData({...formData, brand: option.value})}
                        className={`${option.color} ${formData.brand === option.value ? 'ring-2 ring-offset-2 ring-white scale-105' : ''} p-4 rounded-xl text-white font-medium hover:opacity-90 transition-all transform hover:scale-105 duration-200`}
                      >
                        <div className="flex items-center justify-center gap-2">
                          {formData.brand === option.value && (
                            <Check className="h-5 w-5 text-white" />
                          )}
                          <span className="text-sm font-bold">{option.label}</span>
                        </div>
                      </button>
                    ))}
                  </div>
                </div>
                
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    یا نام برند دلخواه:
                  </label>
                  <input
                    type="text"
                    value={formData.brand}
                    onChange={(e) => setFormData({...formData, brand: e.target.value})}
                    className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                    placeholder="نام برند دلخواه"
                  />
                </div>
              </div>

              <div className="rounded-2xl border border-gray-200 bg-white p-6">
                <label className="block text-sm font-semibold text-gray-800 mb-3">
                  شماره قطعه
                </label>
                <input
                  type="text"
                  value={formData.partNumber}
                  onChange={(e) => setFormData({...formData, partNumber: e.target.value})}
                  className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  placeholder="شماره فنی قطعه"
                />
              </div>
            </div>

            {/* Compatible Cars */}
            <div className="rounded-2xl border border-gray-200 bg-white p-6">
              <label className="block text-sm font-semibold text-gray-800 mb-3">
                خودروهای سازگار
              </label>
              <input
                type="text"
                value={formData.compatibleCars}
                onChange={(e) => setFormData({...formData, compatibleCars: e.target.value})}
                className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                placeholder="خودروهای سازگار (با کاما جدا کنید)"
              />
              <p className="text-xs text-gray-500 mt-1">
                میتوانید چندین خودرو را با کاما جدا کنید، مثال: پراید, تیبا, ساینا
              </p>
            </div>

            {/* Car Brand & Model */}
            <div className="grid gap-4">
              <div className="rounded-2xl border border-gray-200 bg-white p-6">
                <label className="block text-sm font-semibold text-gray-800 mb-3">
                  برند خودرو
                </label>
                <input
                  type="text"
                  value={formData.carBrand}
                  onChange={(e) => setFormData({...formData, carBrand: e.target.value})}
                  className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  placeholder="برند خودرو (مثلا: ایران خودرو, سایپا)"
                />
              </div>

              <div className="rounded-2xl border border-gray-200 bg-white p-6">
                <label className="block text-sm font-semibold text-gray-800 mb-3">
                  مدل خودرو
                </label>
                <input
                  type="text"
                  value={formData.carModel}
                  onChange={(e) => setFormData({...formData, carModel: e.target.value})}
                  className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  placeholder="مدل خودرو (مثلا: پراید, تیبا)"
                />
              </div>
            </div>

            {/* Material & Warranty */}
            <div className="grid gap-4">
              <div className="rounded-2xl border border-gray-200 bg-white p-6">
                <label className="block text-sm font-semibold text-gray-800 mb-3">
                  جنس قطعه
                </label>
                <input
                  type="text"
                  value={formData.material}
                  onChange={(e) => setFormData({...formData, material: e.target.value})}
                  className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  placeholder="جنس قطعه (مثلا: پلاستیک, فلز)"
                />
              </div>

              <div className="rounded-2xl border border-gray-200 bg-white p-6">
                <label className="block text-sm font-semibold text-gray-800 mb-3">
                  گارانتی
                </label>
                <input
                  type="text"
                  value={formData.warranty}
                  onChange={(e) => setFormData({...formData, warranty: e.target.value})}
                  className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  placeholder="گارانتی (مثلا: 6 ماه, 1 سال)"
                />
              </div>
            </div>

            {/* Tags */}
            <div className="rounded-2xl border border-gray-200 bg-white p-6">
              <label className="block text-sm font-semibold text-gray-800 mb-3">
                <Tag className="h-4 w-4 inline-block ml-1" />
                تگها
              </label>
              <div className="flex gap-2 mb-3">
                <input
                  type="text"
                  value={tagInput}
                  onChange={(e) => setTagInput(e.target.value)}
                  onKeyPress={handleKeyPress}
                  className="flex-1 px-4 py-2 border border-gray-300 rounded-lg"
                  placeholder="افزودن تگ جدید"
                />
                <button
                  type="button"
                  onClick={handleAddTag}
                  className="px-4 py-2 bg-blue-100 text-blue-700 rounded-lg hover:bg-blue-200 transition-colors"
                >
                  افزودن
                </button>
              </div>
              <div className="flex flex-wrap gap-2">
                {formData.tags.map((tag, index) => (
                  <span
                    key={index}
                    className="inline-flex items-center gap-1 px-3 py-1 bg-gray-100 text-gray-700 rounded-full text-sm"
                  >
                    {tag}
                    <button
                      type="button"
                      onClick={() => handleRemoveTag(tag)}
                      className="text-gray-500 hover:text-red-500"
                    >
                      <X className="h-3 w-3" />
                    </button>
                  </span>
                ))}
              </div>
            </div>



            {/* Display Order */}
            <div className="rounded-2xl border border-gray-200 bg-white p-6">
              <label className="block text-sm font-semibold text-gray-800 mb-3">
                ترتیب نمایش
              </label>
              <input
                type="number"
                value={formData.displayOrder}
                onChange={(e) => setFormData({...formData, displayOrder: parseInt(e.target.value) || 0})}
                className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                placeholder="عدد کمتر = نمایش اول"
              />
            </div>
          </div>
        </div>

        {/* Status & Actions */}
        <div className="rounded-2xl border border-gray-200 bg-white p-6">
          <div className="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
            {/* Status Toggles */}
            <div className="flex flex-wrap gap-4">
              <label className="inline-flex items-center gap-2 cursor-pointer">
                <div className="relative">
                  <input
                    type="checkbox"
                    checked={formData.isFeatured}
                    onChange={(e) => setFormData({...formData, isFeatured: e.target.checked})}
                    className="sr-only"
                  />
                  <div className={`w-10 h-6 rounded-full transition-colors ${formData.isFeatured ? 'bg-amber-500' : 'bg-gray-300'}`}>
                    <div className={`absolute top-1 w-4 h-4 rounded-full bg-white transition-transform ${formData.isFeatured ? 'left-5' : 'left-1'}`}></div>
                  </div>
                </div>
                <span className="font-medium text-gray-800 flex items-center gap-1">
                  <Star className="h-4 w-4" />
                  محصول ویژه
                </span>
              </label>

              <label className="inline-flex items-center gap-2 cursor-pointer">
                <div className="relative">
                  <input
                    type="checkbox"
                    checked={formData.isActive}
                    onChange={(e) => setFormData({...formData, isActive: e.target.checked})}
                    className="sr-only"
                  />
                  <div className={`w-10 h-6 rounded-full transition-colors ${formData.isActive ? 'bg-green-500' : 'bg-gray-300'}`}>
                    <div className={`absolute top-1 w-4 h-4 rounded-full bg-white transition-transform ${formData.isActive ? 'left-5' : 'left-1'}`}></div>
                  </div>
                </div>
                <span className="font-medium text-gray-800">
                  <Check className="h-4 w-4 inline-block ml-1" />
                  فعال
                </span>
              </label>
            </div>

            {/* Action Buttons */}
            <div className="flex gap-3">
              <button
                type="button"
                onClick={() => navigate('/admin/products')}
                className="px-6 py-3 border border-gray-300 text-gray-700 font-medium rounded-xl hover:bg-gray-50 transition-colors"
              >
                انصراف
              </button>
              <button
                type="submit"
                disabled={loading}
                className="px-6 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-medium rounded-xl hover:from-blue-700 hover:to-blue-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all flex items-center gap-2"
              >
                {loading ? (
                  <>
                    <div className="animate-spin rounded-full h-4 w-4 border-t-2 border-b-2 border-white"></div>
                    در حال ذخیره...
                  </>
                ) : (
                  <>
                    <Save className="h-5 w-5" />
                    {isEditMode ? 'ذخیره تغییرات' : 'ایجاد محصول'}
                  </>
                )}
              </button>
            </div>
          </div>
        </div>
      </form>
    </div>
  );
};

export default ProductFormSimplified;