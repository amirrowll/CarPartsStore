import { useState } from 'react';
import { Search, Filter, X } from 'lucide-react';

interface AdvancedSearchProps {
  onSearch: (filters: SearchFilters) => void;
  initialFilters?: Partial<SearchFilters>;
}

export interface SearchFilters {
  search: string;
  brand: string;
  carBrand: string;
  carModel: string;
  partNumber: string;
  compatibleCars: string;
  isFeatured: boolean;
  sortBy: 'createdAt' | 'displayOrder' | 'name';
  sortDescending: boolean;
  page: number;
  pageSize: number;
}

const AdvancedSearch: React.FC<AdvancedSearchProps> = ({ onSearch, initialFilters = {} }) => {
  const [filters, setFilters] = useState<SearchFilters>({
    search: '',
    brand: '',
    carBrand: '',
    carModel: '',
    partNumber: '',
    compatibleCars: '',
    isFeatured: false,
    sortBy: 'createdAt',
    sortDescending: true,
    page: 1,
    pageSize: 24,
    ...initialFilters
  });

  const [showAdvanced, setShowAdvanced] = useState(false);
  const [loading, setLoading] = useState(false);

  const handleSearch = (e?: React.FormEvent) => {
    e?.preventDefault();
    setLoading(true);
    
    // Clean up empty filters
    const cleanFilters: SearchFilters = {
      ...filters,
      search: filters.search.trim(),
      brand: filters.brand.trim(),
      carBrand: filters.carBrand.trim(),
      carModel: filters.carModel.trim(),
      partNumber: filters.partNumber.trim(),
      compatibleCars: filters.compatibleCars.trim(),
      page: 1 // Reset to first page on new search
    };

    onSearch(cleanFilters);
    setTimeout(() => setLoading(false), 500);
  };

  const handleReset = () => {
    setFilters({
      search: '',
      brand: '',
      carBrand: '',
      carModel: '',
      partNumber: '',
      compatibleCars: '',
      isFeatured: false,
      sortBy: 'createdAt',
      sortDescending: true,
      page: 1,
      pageSize: 24
    });
    onSearch({
      search: '',
      brand: '',
      carBrand: '',
      carModel: '',
      partNumber: '',
      compatibleCars: '',
      isFeatured: false,
      sortBy: 'createdAt',
      sortDescending: true,
      page: 1,
      pageSize: 24
    });
  };

  const activeFiltersCount = () => {
    let count = 0;
    if (filters.search) count++;
    if (filters.brand) count++;
    if (filters.carBrand) count++;
    if (filters.carModel) count++;
    if (filters.partNumber) count++;
    if (filters.compatibleCars) count++;
    if (filters.isFeatured) count++;
    return count;
  };

  return (
    <div className="w-full max-w-6xl mx-auto p-4">
      <form onSubmit={handleSearch} className="bg-white rounded-2xl shadow-xl border border-gray-100 overflow-hidden">
        {/* Header */}
        <div className="bg-gradient-to-r from-blue-600 to-blue-700 p-6">
          <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div>
              <h2 className="text-2xl font-bold text-white mb-2">جستجوی پیشرفته قطعات خودرو</h2>
              <p className="text-blue-100 text-sm">
                با استفاده از فیلترهای پیشرفته، دقیقترین قطعات مورد نیاز خود را پیدا کنید
              </p>
            </div>
            <div className="flex items-center gap-3">
              <button
                type="button"
                onClick={() => setShowAdvanced(!showAdvanced)}
                className="flex items-center gap-2 px-4 py-2 bg-white/20 hover:bg-white/30 text-white rounded-lg transition-colors"
              >
                <Filter className="h-4 w-4" />
                <span>فیلترهای پیشرفته</span>
              </button>
              {activeFiltersCount() > 0 && (
                <div className="px-3 py-1 bg-white/20 rounded-full">
                  <span className="text-white text-sm font-medium">
                    {activeFiltersCount()} فیلتر فعال
                  </span>
                </div>
              )}
            </div>
          </div>
        </div>

        {/* Main Search Bar */}
        <div className="p-6 border-b border-gray-100">
          <div className="relative">
            <div className="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
              <Search className="h-5 w-5 text-gray-400" />
            </div>
            <input
              type="text"
              value={filters.search}
              onChange={(e) => setFilters(prev => ({ ...prev, search: e.target.value }))}
              placeholder="نام قطعه، شماره فنی، کد OEM، سازگاری، توضیحات..."
              className="w-full pr-12 pl-4 py-4 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none transition duration-200 text-right text-lg"
            />
            <div className="absolute left-0 inset-y-0 pl-4 flex items-center">
              <button
                type="submit"
                disabled={loading}
                className="px-6 py-2 bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-medium rounded-lg shadow-md hover:shadow-lg transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
              >
                {loading ? (
                  <>
                    <div className="h-4 w-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                    <span>در حال جستجو...</span>
                  </>
                ) : (
                  <>
                    <Search className="h-4 w-4" />
                    <span>جستجو</span>
                  </>
                )}
              </button>
            </div>
          </div>
        </div>

        {/* Quick Filters */}
        <div className="p-6 border-b border-gray-100">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                برند قطعه
              </label>
              <input
                type="text"
                value={filters.brand}
                onChange={(e) => setFilters(prev => ({ ...prev, brand: e.target.value }))}
                placeholder="مثلا: Bosch, Valeo, Denso"
                className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none transition duration-200 text-right"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                برند خودرو
              </label>
              <select
                value={filters.carBrand}
                onChange={(e) => setFilters(prev => ({ ...prev, carBrand: e.target.value, carModel: '' }))}
                className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none transition duration-200 appearance-none bg-white text-right"
              >
                <option value="">همه برندها</option>
                <option value="Chinese">خودروهای چینی</option>
                <option value="Saipa">سایپا</option>
                <option value="IranKhodro">ایران خودرو</option>
                <option value="Other">سایر برندها</option>
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                مدل خودرو
              </label>
              <select
                value={filters.carModel}
                onChange={(e) => setFilters(prev => ({ ...prev, carModel: e.target.value }))}
                disabled={!filters.carBrand}
                className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none transition duration-200 appearance-none bg-white text-right disabled:bg-gray-50 disabled:text-gray-500"
              >
                <option value="">همه مدلها</option>
                <option value="Pride">پراید</option>
                <option value="Tiba">تیبا</option>
                <option value="Dena">دنا</option>
                <option value="Saina">ساینا</option>
                <option value="Quick">کوییک</option>
                <option value="206">پژو 206</option>
                <option value="Pars">پژو پارس</option>
                <option value="Samand">سمند</option>
                <option value="Soren">سورن</option>
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                شماره قطعه
              </label>
              <input
                type="text"
                value={filters.partNumber}
                onChange={(e) => setFilters(prev => ({ ...prev, partNumber: e.target.value }))}
                placeholder="مثلا: 123456-7890"
                className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none transition duration-200 text-right"
              />
            </div>
          </div>
        </div>

        {/* Advanced Filters (Collapsible) */}
        {showAdvanced && (
          <div className="p-6 border-b border-gray-100 bg-gray-50">
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {/* Compatible Cars */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  سازگاری با خودروها
                </label>
                <input
                  type="text"
                  value={filters.compatibleCars}
                  onChange={(e) => setFilters(prev => ({ ...prev, compatibleCars: e.target.value }))}
                  placeholder="مثلا: پراید، تیبا، 206"
                  className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none transition duration-200 text-right"
                />
              </div>

              {/* Featured Products */}
              <div className="md:col-span-2 lg:col-span-3">
                <div className="flex items-center gap-3">
                  <input
                    type="checkbox"
                    id="featured"
                    checked={filters.isFeatured}
                    onChange={(e) => setFilters(prev => ({ ...prev, isFeatured: e.target.checked }))}
                    className="h-5 w-5 text-blue-600 rounded focus:ring-blue-500"
                  />
                  <label htmlFor="featured" className="text-sm font-medium text-gray-700">
                    فقط محصولات ویژه
                  </label>
                </div>
              </div>
            </div>

            {/* Sorting Options */}
            <div className="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  مرتبسازی بر اساس
                </label>
                <select
                  value={filters.sortBy}
                  onChange={(e) => setFilters(prev => ({ ...prev, sortBy: e.target.value as any }))}
                  className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none transition duration-200 appearance-none bg-white text-right"
                >
                  <option value="createdAt">تاریخ ایجاد</option>
                  <option value="displayOrder">ترتیب نمایش</option>
                  <option value="name">نام محصول</option>
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  ترتیب
                </label>
                <select
                  value={filters.sortDescending ? 'desc' : 'asc'}
                  onChange={(e) => setFilters(prev => ({ ...prev, sortDescending: e.target.value === 'desc' }))}
                  className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none transition duration-200 appearance-none bg-white text-right"
                >
                  <option value="desc">نزولی (جدیدترین)</option>
                  <option value="asc">صعودی (قدیمیترین)</option>
                </select>
              </div>
            </div>
          </div>
        )}

        {/* Active Filters & Actions */}
        <div className="p-6">
          <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
            {/* Active Filters */}
            <div className="flex-1">
              {(filters.search || filters.brand || filters.carBrand || filters.carModel || 
                filters.partNumber || filters.compatibleCars || filters.isFeatured) && (
                <div className="flex flex-wrap gap-2">
                  <span className="text-sm text-gray-600">فیلترهای فعال:</span>
                  
                  {filters.search && (
                    <div className="inline-flex items-center gap-1 px-3 py-1 bg-blue-50 text-blue-700 rounded-full text-sm">
                      <span>جستجو: {filters.search}</span>
                      <button
                        type="button"
                        onClick={() => setFilters(prev => ({ ...prev, search: '' }))}
                        className="text-blue-500 hover:text-blue-700"
                      >
                        <X className="h-3 w-3" />
                      </button>
                    </div>
                  )}

                  {filters.brand && (
                    <div className="inline-flex items-center gap-1 px-3 py-1 bg-green-50 text-green-700 rounded-full text-sm">
                      <span>برند: {filters.brand}</span>
                      <button
                        type="button"
                        onClick={() => setFilters(prev => ({ ...prev, brand: '' }))}
                        className="text-green-500 hover:text-green-700"
                      >
                        <X className="h-3 w-3" />
                      </button>
                    </div>
                  )}

                  {filters.carBrand && (
                    <div className="inline-flex items-center gap-1 px-3 py-1 bg-purple-50 text-purple-700 rounded-full text-sm">
                      <span>خودرو: {filters.carBrand}</span>
                      <button
                        type="button"
                        onClick={() => setFilters(prev => ({ ...prev, carBrand: '', carModel: '' }))}
                        className="text-purple-500 hover:text-purple-700"
                      >
                        <X className="h-3 w-3" />
                      </button>
                    </div>
                  )}

                  {filters.isFeatured && (
                    <div className="inline-flex items-center gap-1 px-3 py-1 bg-yellow-50 text-yellow-700 rounded-full text-sm">
                      <span>ویژه</span>
                      <button
                        type="button"
                        onClick={() => setFilters(prev => ({ ...prev, isFeatured: false }))}
                        className="text-yellow-500 hover:text-yellow-700"
                      >
                        <X className="h-3 w-3" />
                      </button>
                    </div>
                  )}
                </div>
              )}
            </div>

            {/* Action Buttons */}
            <div className="flex items-center gap-3">
              <button
                type="button"
                onClick={handleReset}
                className="px-5 py-2.5 border border-gray-300 text-gray-700 hover:bg-gray-50 font-medium rounded-lg transition-colors flex items-center gap-2"
              >
                <X className="h-4 w-4" />
                <span>پاک کردن همه</span>
              </button>
              
              <button
                type="submit"
                disabled={loading}
                className="px-6 py-2.5 bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-medium rounded-lg shadow-md hover:shadow-lg transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
              >
                {loading ? (
                  <>
                    <div className="h-4 w-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                    <span>اعمال فیلترها</span>
                  </>
                ) : (
                  <>
                    <Filter className="h-4 w-4" />
                    <span>اعمال فیلترها</span>
                  </>
                )}
              </button>
            </div>
          </div>
        </div>
      </form>

      {/* Search Tips */}
      <div className="mt-6 p-4 bg-blue-50 rounded-xl border border-blue-100">
        <h3 className="text-sm font-medium text-blue-800 mb-2">نکات جستجوی پیشرفته:</h3>
        <ul className="text-sm text-blue-700 space-y-1 list-disc pr-5">
          <li>میتوانید از چندین فیلتر به صورت همزمان استفاده کنید</li>
          <li>برای جستجوی دقیقتر، شماره قطعه یا کد OEM را وارد کنید</li>
          <li>برای جستجوی سازگاری، نام خودروها را با کاما جدا کنید (مثلا: پراید، تیبا)</li>
          <li>محصولات ویژه معمولا پرفروشترین یا جدیدترین محصولات هستند</li>
        </ul>
      </div>
    </div>
  );
};

export default AdvancedSearch;