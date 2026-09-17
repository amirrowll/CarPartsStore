import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';
import { useAppContext } from '../context/AppContext';
import { productApi, categoryApi } from '../services/api';
import { Plus, Edit, Trash2, Eye, Star, Package, Layers, LogOut } from 'lucide-react';
const AdminPage = () => {
    const { user, logout, isAdmin } = useAuth();
    const { products, categories, fetchProducts, fetchCategories } = useAppContext();
    const [activeTab, setActiveTab] = useState('products');
    const [showAddModal, setShowAddModal] = useState(false);
    const [showEditModal, setShowEditModal] = useState(false);
    const [showDeleteModal, setShowDeleteModal] = useState(false);
    const [selectedItem, setSelectedItem] = useState(null);
    const [loading, setLoading] = useState(false);
    // Product form
    const [productForm, setProductForm] = useState({
        name: '',
        description: '',
        categoryId: '',
        imageUrl: '',
        tags: '',
        manufacturer: '',
        partNumber: '',
        warranty: '',
        compatibleCars: '',
        material: '',
        isFeatured: false,
    });
    // Category form
    const [categoryForm, setCategoryForm] = useState({
        name: '',
        description: '',
        imageUrl: '',
        parentCategoryId: '',
        displayOrder: '0',
    });
    useEffect(() => {
        if (!isAdmin) {
            window.location.href = '/login';
        }
    }, [isAdmin]);
    const handleAddProduct = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
            const tagsArray = productForm.tags.split(',').map(tag => tag.trim()).filter(tag => tag);
            await productApi.create({
                ...productForm,
                categoryId: parseInt(productForm.categoryId),
                tags: tagsArray,
            });
            setShowAddModal(false);
            setProductForm({
                name: '',
                description: '',
                categoryId: '',
                imageUrl: '',
                tags: '',
                manufacturer: '',
                partNumber: '',
                warranty: '',
                compatibleCars: '',
                material: '',
                isFeatured: false,
            });
            fetchProducts();
        }
        catch (error) {
            console.error('Error adding product:', error);
            alert('خطا در ایجاد محصول');
        }
        finally {
            setLoading(false);
        }
    };
    const handleAddCategory = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
            await categoryApi.create({
                ...categoryForm,
                parentCategoryId: categoryForm.parentCategoryId ? parseInt(categoryForm.parentCategoryId) : undefined,
                displayOrder: parseInt(categoryForm.displayOrder),
            });
            setShowAddModal(false);
            setCategoryForm({
                name: '',
                description: '',
                imageUrl: '',
                parentCategoryId: '',
                displayOrder: '0',
            });
            fetchCategories();
        }
        catch (error) {
            console.error('Error adding category:', error);
            alert('خطا در ایجاد دسته بندی');
        }
        finally {
            setLoading(false);
        }
    };
    const handleDelete = async () => {
        if (!selectedItem)
            return;
        setLoading(true);
        try {
            if (activeTab === 'products') {
                await productApi.delete(selectedItem.id);
                fetchProducts();
            }
            else {
                await categoryApi.delete(selectedItem.id);
                fetchCategories();
            }
            setShowDeleteModal(false);
            setSelectedItem(null);
        }
        catch (error) {
            console.error('Error deleting:', error);
            alert('خطا در حذف');
        }
        finally {
            setLoading(false);
        }
    };
    if (!isAdmin) {
        return (<div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">دسترسی محدود</h1>
          <p className="text-gray-600 mb-6">برای دسترسی به پنل مدیریت باید مدیر باشید.</p>
          <a href="/login" className="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
            رفتن به صفحه ورود
          </a>
        </div>
      </div>);
    }
    return (<div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-blue-900 to-indigo-900 text-white">
        <div className="max-w-7xl mx-auto px-4 py-8">
          <div className="flex justify-between items-center">
            <div>
              <h1 className="text-3xl font-bold mb-2">پنل مدیریت</h1>
              <p className="text-blue-200">خوش آمدید، {user?.firstName} {user?.lastName}</p>
            </div>
            <button onClick={logout} className="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 flex items-center gap-2">
              <LogOut className="h-4 w-4"/>
              خروج
            </button>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 py-8">
        {/* Tabs */}
        <div className="bg-white rounded-xl shadow-md mb-8">
          <div className="flex border-b">
            <button onClick={() => setActiveTab('products')} className={`flex-1 py-4 px-6 font-medium text-center transition-colors ${activeTab === 'products'
            ? 'text-blue-600 border-b-2 border-blue-600'
            : 'text-gray-500 hover:text-gray-700'}`}>
              <Package className="h-5 w-5 inline-block ml-2"/>
              محصولات
            </button>
            <button onClick={() => setActiveTab('categories')} className={`flex-1 py-4 px-6 font-medium text-center transition-colors ${activeTab === 'categories'
            ? 'text-blue-600 border-b-2 border-blue-600'
            : 'text-gray-500 hover:text-gray-700'}`}>
              <Layers className="h-5 w-5 inline-block ml-2"/>
              دسته بندیها
            </button>
            <button onClick={() => setActiveTab('analytics')} className={`flex-1 py-4 px-6 font-medium text-center transition-colors ${activeTab === 'analytics'
            ? 'text-blue-600 border-b-2 border-blue-600'
            : 'text-gray-500 hover:text-gray-700'}`}>
              <Eye className="h-5 w-5 inline-block ml-2"/>
              آمار
            </button>
          </div>
        </div>

        {/* Content */}
        <div className="bg-white rounded-xl shadow-md p-6">
          {/* Header with Add Button */}
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-2xl font-bold text-gray-800">
              {activeTab === 'products' ? 'محصولات' :
            activeTab === 'categories' ? 'دسته بندیها' : 'آمار و گزارشات'}
            </h2>
            <button onClick={() => setShowAddModal(true)} className="px-6 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-medium rounded-lg hover:from-blue-700 hover:to-blue-800 transition-all flex items-center gap-2" disabled={loading}>
              <Plus className="h-5 w-5"/>
              {loading ? 'در حال پردازش...' : 'افزودن جدید'}
            </button>
          </div>

          {/* Data Table */}
          {activeTab === 'products' && (<div className="overflow-x-auto">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">تصویر</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">نام محصول</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">دسته بندی</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">بازدید</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">وضعیت</th>
                    <th className="px6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">عملیات</th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {products.map((product) => (<tr key={product.id} className="hover:bg-gray-50">
                      <td className="px-6 py-4">
                        <img src={product.imageUrl || 'https://via.placeholder.com/100'} alt={product.name} className="h-16 w-16 object-cover rounded-lg"/>
                      </td>
                      <td className="px-6 py-4">
                        <div>
                          <div className="text-sm font-medium text-gray-900">{product.name}</div>
                          <div className="text-sm text-gray-500 truncate max-w-xs">{product.description}</div>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <span className="px-3 py-1 bg-blue-100 text-blue-800 text-xs rounded-full">
                          {product.categoryName || 'بدون دسته'}
                        </span>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-2">
                          <Eye className="h-4 w-4 text-gray-500"/>
                          <span className="text-sm font-medium">{product.viewCount || 0}</span>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-2">
                          {product.isFeatured && (<Star className="h-4 w-4 text-yellow-500 fill-current"/>)}
                          <span className={`px-3 py-1 text-xs rounded-full ${product.isActive
                    ? 'bg-green-100 text-green-800'
                    : 'bg-red-100 text-red-800'}`}>
                            {product.isActive ? 'فعال' : 'غیرفعال'}
                          </span>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-2">
                          <button onClick={() => {
                    setSelectedItem(product);
                    setShowEditModal(true);
                }} className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors">
                            <Edit className="h-4 w-4"/>
                          </button>
                          <button onClick={() => {
                    setSelectedItem(product);
                    setShowDeleteModal(true);
                }} className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors">
                            <Trash2 className="h-4 w-4"/>
                          </button>
                        </div>
                      </td>
                    </tr>))}
                  
                  {products.length === 0 && (<tr>
                      <td colSpan={6} className="px-6 py-8 text-center text-gray-500">
                        هنوز محصولی اضافه نشده است. اولین محصول را ایجاد کنید.
                      </td>
                    </tr>)}
                </tbody>
              </table>
            </div>)}

          {activeTab === 'categories' && (<div className="overflow-x-auto">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">نام دسته</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">توضیحات</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">تعداد محصولات</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">ترتیب نمایش</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">عملیات</th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {categories.map((category) => (<tr key={category.id} className="hover:bg-gray-50">
                      <td className="px-6 py-4">
                        <div className="text-sm font-medium text-gray-900">{category.name}</div>
                      </td>
                      <td className="px-6 py-4">
                        <div className="text-sm text-gray-500 truncate max-w-md">{category.description}</div>
                      </td>
                      <td className="px-6 py-4">
                        <span className="px-3 py-1 bg-gray-100 text-gray-800 text-xs rounded-full">
                          {category.productCount || 0} محصول
                        </span>
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm font-medium">{category.displayOrder || 0}</span>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-2">
                          <button onClick={() => {
                    setSelectedItem(category);
                    setShowEditModal(true);
                }} className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors">
                            <Edit className="h-4 w-4"/>
                          </button>
                          <button onClick={() => {
                    setSelectedItem(category);
                    setShowDeleteModal(true);
                }} className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors">
                            <Trash2 className="h-4 w-4"/>
                          </button>
                        </div>
                      </td>
                    </tr>))}
                  
                  {categories.length === 0 && (<tr>
                      <td colSpan={5} className="px-6 py-8 text-center text-gray-500">
                        هنوز دسته بندی ایجاد نشده است. اولین دسته بندی را ایجاد کنید.
                      </td>
                    </tr>)}
                </tbody>
              </table>
            </div>)}

          {activeTab === 'analytics' && (<div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="bg-gradient-to-br from-blue-500 to-blue-600 text-white rounded-xl p-6">
                <div className="text-4xl font-bold mb-2">{products.length}</div>
                <div className="text-lg">تعداد محصولات</div>
              </div>
              <div className="bg-gradient-to-br from-green-500 to-green-600 text-white rounded-xl p-6">
                <div className="text-4xl font-bold mb-2">{categories.length}</div>
                <div className="text-lg">تعداد دسته بندیها</div>
              </div>
              <div className="bg-gradient-to-br from-purple-500 to-purple-600 text-white rounded-xl p-6">
                <div className="text-4xl font-bold mb-2">
                  {products.reduce((sum, product) => sum + (product.viewCount || 0), 0)}
                </div>
                <div className="text-lg">مجموع بازدیدها</div>
              </div>
            </div>)}
        </div>
      </div>

      {/* Add Modal */}
      {showAddModal && (<div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-2xl w-full max-w-2xl max-h-[90vh] overflow-y-auto">
            <div className="p-6">
              <div className="flex justify-between items-center mb-6">
                <h3 className="text-xl font-bold text-gray-900">
                  {activeTab === 'products' ? 'افزودن محصول جدید' : 'افزودن دسته بندی جدید'}
                </h3>
                <button onClick={() => setShowAddModal(false)} className="text-gray-400 hover:text-gray-600" disabled={loading}>
                  ✕
                </button>
              </div>

              <form onSubmit={activeTab === 'products' ? handleAddProduct : handleAddCategory}>
                {activeTab === 'products' ? (<div className="space-y-4">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-2">نام محصول *</label>
                      <input type="text" required className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" value={productForm.name} onChange={(e) => setProductForm({ ...productForm, name: e.target.value })} disabled={loading}/>
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-2">توضیحات</label>
                      <textarea rows={3} className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" value={productForm.description} onChange={(e) => setProductForm({ ...productForm, description: e.target.value })} disabled={loading}/>
                    </div>
                    
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <div>
                        <label className="block text-sm font-medium text-gray-700 mb-2">دسته بندی *</label>
                        <select required className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" value={productForm.categoryId} onChange={(e) => setProductForm({ ...productForm, categoryId: e.target.value })} disabled={loading}>
                          <option value="">انتخاب کنید</option>
                          {categories.map(category => (<option key={category.id} value={category.id}>
                              {category.name}
                            </option>))}
                        </select>
                      </div>
                      
                      <div>
                        <label className="block text-sm font-medium text-gray-700 mb-2">آدرس تصویر</label>
                        <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" value={productForm.imageUrl} onChange={(e) => setProductForm({ ...productForm, imageUrl: e.target.value })} placeholder="https://example.com/image.jpg" disabled={loading}/>
                      </div>
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-2">تگها (با کاما جدا کنید)</label>
                      <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" value={productForm.tags} onChange={(e) => setProductForm({ ...productForm, tags: e.target.value })} placeholder="موتور, پراید, گیربکس" disabled={loading}/>
                    </div>
                    
                    <div className="flex items-center">
                      <input type="checkbox" id="isFeatured" className="ml-2 h-4 w-4 text-blue-600 rounded" checked={productForm.isFeatured} onChange={(e) => setProductForm({ ...productForm, isFeatured: e.target.checked })} disabled={loading}/>
                      <label htmlFor="isFeatured" className="text-sm font-medium text-gray-700">
                        محصول ویژه
                      </label>
                    </div>
                  </div>) : (<div className="space-y-4">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-2">نام دسته *</label>
                      <input type="text" required className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" value={categoryForm.name} onChange={(e) => setCategoryForm({ ...categoryForm, name: e.target.value })} disabled={loading}/>
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-2">توضیحات</label>
                      <textarea rows={3} className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" value={categoryForm.description} onChange={(e) => setCategoryForm({ ...categoryForm, description: e.target.value })} disabled={loading}/>
                    </div>
                    
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <div>
                        <label className="block text-sm font-medium text-gray-700 mb-2">دسته والد</label>
                        <select className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" value={categoryForm.parentCategoryId} onChange={(e) => setCategoryForm({ ...categoryForm, parentCategoryId: e.target.value })} disabled={loading}>
                          <option value="">بدون والد (دسته اصلی)</option>
                          {categories.map(category => (<option key={category.id} value={category.id}>
                              {category.name}
                            </option>))}
                        </select>
                      </div>
                      
                      <div>
                        <label className="block text-sm font-medium text-gray-700 mb-2">ترتیب نمایش</label>
                        <input type="number" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" value={categoryForm.displayOrder} onChange={(e) => setCategoryForm({ ...categoryForm, displayOrder: e.target.value })} disabled={loading}/>
                      </div>
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-2">آدرس تصویر</label>
                      <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" value={categoryForm.imageUrl} onChange={(e) => setCategoryForm({ ...categoryForm, imageUrl: e.target.value })} placeholder="https://example.com/image.jpg" disabled={loading}/>
                    </div>
                  </div>)}
                
                <div className="mt-8 flex justify-end gap-4">
                  <button type="button" onClick={() => setShowAddModal(false)} className="px-6 py-3 border border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition-colors" disabled={loading}>
                    انصراف
                  </button>
                  <button type="submit" className="px-6 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-medium rounded-lg hover:from-blue-700 hover:to-blue-800 transition-all" disabled={loading}>
                    {loading ? 'در حال ذخیره...' : 'ذخیره'}
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>)}

      {/* Delete Confirmation Modal */}
      {showDeleteModal && (<div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-2xl p-6 max-w-md w-full">
            <h3 className="text-xl font-bold text-gray-900 mb-4">حذف {selectedItem?.name}</h3>
            <p className="text-gray-600 mb-6">
              آیا از حذف {activeTab === 'products' ? 'محصول' : 'دسته بندی'} "{selectedItem?.name}" مطمئن هستید؟
            </p>
            <div className="flex justify-end gap-4">
              <button onClick={() => setShowDeleteModal(false)} className="px-6 py-3 border border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition-colors" disabled={loading}>
                انصراف
              </button>
              <button onClick={handleDelete} className="px-6 py-3 bg-gradient-to-r from-red-600 to-red-700 text-white font-medium rounded-lg hover:from-red-700 hover:to-red-800 transition-all" disabled={loading}>
                {loading ? 'در حال حذف...' : 'حذف'}
              </button>
            </div>
          </div>
        </div>)}
    </div>);
};
export default AdminPage;
