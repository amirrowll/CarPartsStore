import { useEffect, useState } from 'react';
import api from '../../services/api';
import { Folder, Plus, Edit, Trash2, Search } from 'lucide-react';
const Categories = () => {
    const [categories, setCategories] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const [searchTerm, setSearchTerm] = useState('');
    const [showForm, setShowForm] = useState(false);
    const [editingCategory, setEditingCategory] = useState(null);
    const [formData, setFormData] = useState({
        name: '',
        description: '',
        imageUrl: '',
        displayOrder: 0
    });
    const [formLoading, setFormLoading] = useState(false);
    const [deleteModal, setDeleteModal] = useState({
        show: false,
        categoryId: null,
        categoryName: ''
    });
    useEffect(() => {
        fetchCategories();
    }, [searchTerm]);
    const fetchCategories = async () => {
        try {
            setLoading(true);
            const response = await api.get('/categories');
            setCategories(response.data);
        }
        catch (err) {
            setError('خطا در دریافت دسته بندیها');
            console.error('Categories fetch error:', err);
        }
        finally {
            setLoading(false);
        }
    };
    const handleSubmit = async (e) => {
        e.preventDefault();
        setFormLoading(true);
        setError('');
        try {
            if (editingCategory) {
                // Update category
                await api.put(`/categories/${editingCategory.id}`, formData);
            }
            else {
                // Create category
                await api.post('/categories', formData);
            }
            // Reset form and fetch categories
            resetForm();
            fetchCategories();
        }
        catch (err) {
            setError(err.response?.data?.message || 'خطا در ذخیره دسته بندی');
        }
        finally {
            setFormLoading(false);
        }
    };
    const handleEdit = (category) => {
        setEditingCategory(category);
        setFormData({
            name: category.name,
            description: category.description,
            imageUrl: category.imageUrl,
            displayOrder: category.displayOrder
        });
        setShowForm(true);
    };
    const handleDeleteCategory = async (categoryId) => {
        try {
            await api.delete(`/categories/${categoryId}`);
            fetchCategories();
            setDeleteModal({ show: false, categoryId: null, categoryName: '' });
        }
        catch (err) {
            setError('خطا در حذف دسته بندی');
            console.error('Delete category error:', err);
        }
    };
    const resetForm = () => {
        setShowForm(false);
        setEditingCategory(null);
        setFormData({
            name: '',
            description: '',
            imageUrl: '',
            displayOrder: 0
        });
    };
    const filteredCategories = categories.filter(category => category.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        category.description.toLowerCase().includes(searchTerm.toLowerCase()));
    return (<div className="space-y-6">
      {/* Header */}
      <div className="rounded-2xl bg-gradient-to-br from-emerald-900 to-emerald-800 p-6 shadow-2xl text-white">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <h2 className="text-2xl font-bold mb-2">مدیریت دسته بندیها</h2>
            <p className="text-emerald-300">سازماندهی و مدیریت دسته بندی های محصولات ({categories.length} دسته بندی)</p>
          </div>
          <button onClick={() => setShowForm(true)} className="inline-flex items-center gap-2 rounded-xl bg-white text-emerald-900 px-5 py-3 font-medium hover:bg-gray-100 transition-colors">
            <Plus className="h-5 w-5"/>
            افزودن دسته بندی جدید
          </button>
        </div>
      </div>

      {/* Error Message */}
      {error && (<div className="rounded-2xl bg-red-50 border border-red-200 p-4">
          <p className="text-red-700 font-medium">{error}</p>
        </div>)}

      {/* Category Form */}
      {showForm && (<div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
          <div className="flex items-center justify-between mb-6">
            <h3 className="text-lg font-semibold text-gray-800">
              {editingCategory ? 'ویرایش دسته بندی' : 'ایجاد دسته بندی جدید'}
            </h3>
            <button onClick={resetForm} className="p-2 text-gray-500 hover:text-gray-700">
              ✕
            </button>
          </div>

          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="grid gap-4 md:grid-cols-2">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  نام دسته بندی *
                </label>
                <input type="text" value={formData.name} onChange={(e) => setFormData({ ...formData, name: e.target.value })} required className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500" placeholder="نام دسته بندی"/>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  ترتیب نمایش
                </label>
                <input type="number" value={formData.displayOrder} onChange={(e) => setFormData({ ...formData, displayOrder: parseInt(e.target.value) || 0 })} className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500" placeholder="عدد کمتر = نمایش اول"/>
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                توضیحات
              </label>
              <textarea value={formData.description} onChange={(e) => setFormData({ ...formData, description: e.target.value })} rows={3} className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500" placeholder="توضیحات درباره این دسته بندی"/>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                آدرس عکس
              </label>
              <input type="text" value={formData.imageUrl} onChange={(e) => setFormData({ ...formData, imageUrl: e.target.value })} className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500" placeholder="https://example.com/category-image.jpg"/>
              {formData.imageUrl && (<div className="mt-2">
                  <img src={formData.imageUrl} alt="Category preview" className="h-32 object-cover rounded-lg border border-gray-300" onError={(e) => {
                    e.target.style.display = 'none';
                }}/>
                </div>)}
            </div>

            <div className="flex gap-3 pt-4">
              <button type="button" onClick={resetForm} className="px-6 py-3 border border-gray-300 text-gray-700 font-medium rounded-xl hover:bg-gray-50 transition-colors">
                انصراف
              </button>
              <button type="submit" disabled={formLoading} className="px-6 py-3 bg-gradient-to-r from-emerald-600 to-emerald-700 text-white font-medium rounded-xl hover:from-emerald-700 hover:to-emerald-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all flex items-center gap-2">
                {formLoading ? (<>
                    <div className="animate-spin rounded-full h-4 w-4 border-t-2 border-b-2 border-white"></div>
                    در حال ذخیره...
                  </>) : (<>
                    {editingCategory ? 'ذخیره تغییرات' : 'ایجاد دسته بندی'}
                  </>)}
              </button>
            </div>
          </form>
        </div>)}

      {/* Search */}
      <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
        <div className="flex items-center gap-2 mb-6">
          <Search className="h-5 w-5 text-gray-600"/>
          <h3 className="text-lg font-semibold text-gray-800">جستجوی دسته بندیها</h3>
        </div>
        
        <div className="relative">
          <Search className="absolute right-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400"/>
          <input type="text" value={searchTerm} onChange={(e) => setSearchTerm(e.target.value)} placeholder="جستجو در نام یا توضیحات دسته بندیها..." className="w-full pr-10 pl-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500"/>
        </div>
      </div>

      {/* Categories Grid */}
      <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
        {loading ? (<div className="text-center py-12">
            <div className="inline-block animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-emerald-600 mb-4"></div>
            <p className="text-gray-500">در حال بارگذاری دسته بندیها...</p>
          </div>) : filteredCategories.length === 0 ? (<div className="text-center py-12">
            <Folder className="h-16 w-16 text-gray-300 mx-auto mb-4"/>
            <h4 className="text-lg font-medium text-gray-700 mb-2">دسته بندی یافت نشد</h4>
            <p className="text-gray-500">
              {searchTerm ? 'هیچ دسته بندی با عبارت جستجو شده مطابقت ندارد' : 'هنوز دسته بندی ایجاد نشده است'}
            </p>
            {!searchTerm && (<button onClick={() => setShowForm(true)} className="mt-4 px-4 py-2 text-sm font-medium text-emerald-600 bg-emerald-50 rounded-lg hover:bg-emerald-100 transition-colors">
                ایجاد اولین دسته بندی
              </button>)}
          </div>) : (<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {filteredCategories.map((category) => (<div key={category.id} className="rounded-xl border border-gray-200 bg-white overflow-hidden hover:shadow-lg transition-shadow">
                {/* Category Image */}
                <div className="relative h-48 bg-gradient-to-br from-emerald-100 to-emerald-50">
                  {category.imageUrl ? (<img src={category.imageUrl} alt={category.name} className="w-full h-full object-cover"/>) : (<div className="w-full h-full flex items-center justify-center">
                      <Folder className="h-16 w-16 text-emerald-400"/>
                    </div>)}
                  <div className="absolute top-3 right-3">
                    <span className="px-2 py-1 text-xs font-medium bg-emerald-100 text-emerald-800 rounded-full">
                      {category.productCount} محصول
                    </span>
                  </div>
                </div>

                {/* Category Info */}
                <div className="p-4">
                  <h4 className="font-semibold text-gray-800 mb-2">{category.name}</h4>
                  <p className="text-sm text-gray-600 mb-4 line-clamp-2">{category.description || 'بدون توضیحات'}</p>
                  
                  <div className="flex items-center justify-between">
                    <div className="text-xs text-gray-500">
                      ترتیب: {category.displayOrder}
                    </div>
                    <div className="flex gap-2">
                      <button onClick={() => handleEdit(category)} className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors" title="ویرایش">
                        <Edit className="h-4 w-4"/>
                      </button>
                      <button onClick={() => setDeleteModal({
                    show: true,
                    categoryId: category.id,
                    categoryName: category.name
                })} className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors" title="حذف">
                        <Trash2 className="h-4 w-4"/>
                      </button>
                    </div>
                  </div>
                </div>
              </div>))}
          </div>)}
      </div>

      {/* Delete Confirmation Modal */}
      {deleteModal.show && (<div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-2xl p-6 max-w-md w-full">
            <h3 className="text-lg font-semibold text-gray-800 mb-4">تأیید حذف دسته بندی</h3>
            <p className="text-gray-600 mb-6">
              آیا مطمئن هستید که میخواهید دسته بندی "{deleteModal.categoryName}" را حذف کنید؟
              {deleteModal.categoryId && categories.find(c => c.id === deleteModal.categoryId)?.productCount > 0 && (<span className="block mt-2 text-red-600 text-sm">
                  ⚠️ این دسته بندی دارای محصول فعال است و نمیتوان آن را حذف کرد.
                </span>)}
            </p>
            <div className="flex gap-3">
              {categories.find(c => c.id === deleteModal.categoryId)?.productCount === 0 && (<button onClick={() => handleDeleteCategory(deleteModal.categoryId)} className="flex-1 px-4 py-3 bg-red-600 text-white font-medium rounded-xl hover:bg-red-700 transition-colors">
                  بله، حذف شود
                </button>)}
              <button onClick={() => setDeleteModal({ show: false, categoryId: null, categoryName: '' })} className={`flex-1 px-4 py-3 ${categories.find(c => c.id === deleteModal.categoryId)?.productCount === 0 ? 'bg-gray-100 text-gray-700 hover:bg-gray-200' : 'bg-blue-600 text-white hover:bg-blue-700'} font-medium rounded-xl transition-colors`}>
                {categories.find(c => c.id === deleteModal.categoryId)?.productCount === 0 ? 'انصراف' : 'متوجه شدم'}
              </button>
            </div>
          </div>
        </div>)}
    </div>);
};
export default Categories;
