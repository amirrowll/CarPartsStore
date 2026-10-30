import { useState } from 'react';
import { Search, Filter, X, RotateCcw } from 'lucide-react';

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
  material?: string;
  warranty?: string;
  isFeatured?: boolean;
  sortBy: 'createdAt' | 'displayOrder' | 'name';
  sortDescending: boolean;
  page: number;
  pageSize: number;
}

const BRAND_OPTIONS = [
  { id: '', label: 'همه برندهای خودرو' },
  { id: 'سایپا', label: 'سایپا (Saipa)' },
  { id: 'ایران خودرو', label: 'ایران خودرو (Iran Khodro)' },
  { id: 'چینی', label: 'خودروهای چینی (Chinese Cars)' },
  { id: 'سایر', label: 'سایر برندها و خودروها' },
];

const SUGGESTED_MODELS: Record<string, string[]> = {
  'سایپا': ['پراید', 'تیبا', 'ساینا', 'کوییک', 'شاهین', 'نیسان وانت'],
  'ایران خودرو': ['پژو ۲۰۶', 'پژو ۲۰۷', 'پژو ۴۰۵', 'پژو پارس', 'سمند', 'دنا', 'تارا', 'رانا', 'سورن'],
  'چینی': ['ام‌وی‌ام MVM', 'چری Chery', 'جک JAC', 'هایما Haima', 'فیدلیتی', 'دیگنیتی', 'برلیانس', 'تیگو', 'آریزو'],
};

const AdvancedSearch: React.FC<AdvancedSearchProps> = ({ onSearch, initialFilters = {} }) => {
  const [filters, setFilters] = useState<SearchFilters>({
    search: '',
    brand: '',
    carBrand: '',
    carModel: '',
    partNumber: '',
    compatibleCars: '',
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

    const cleanFilters: SearchFilters = {
      ...filters,
      search: filters.search.trim(),
      brand: filters.brand.trim(),
      carBrand: filters.carBrand.trim(),
      carModel: filters.carModel.trim(),
      partNumber: filters.partNumber.trim(),
      compatibleCars: filters.compatibleCars.trim(),
      page: 1
    };

    onSearch(cleanFilters);
    setTimeout(() => setLoading(false), 300);
  };

  const handleReset = () => {
    const emptyFilters: SearchFilters = {
      search: '',
      brand: '',
      carBrand: '',
      carModel: '',
      partNumber: '',
      compatibleCars: '',
      sortBy: 'createdAt',
      sortDescending: true,
      page: 1,
      pageSize: 24
    };
    setFilters(emptyFilters);
    onSearch(emptyFilters);
  };

  const activeFiltersCount = () => {
    let count = 0;
    if (filters.search) count++;
    if (filters.brand) count++;
    if (filters.carBrand) count++;
    if (filters.carModel) count++;
    if (filters.partNumber) count++;
    if (filters.compatibleCars) count++;
    if (filters.material) count++;
    return count;
  };

  const modelSuggestions = filters.carBrand && SUGGESTED_MODELS[filters.carBrand]
    ? SUGGESTED_MODELS[filters.carBrand]
    : [];

  return (
    <div className="w-full max-w-6xl mx-auto p-2 sm:p-4">
      <form onSubmit={handleSearch} className="bg-slate-900/90 rounded-2xl shadow-2xl border border-slate-800 overflow-hidden backdrop-blur-xl">
        {/* Header */}
        <div className="bg-gradient-to-r from-red-700 via-rose-700 to-slate-900 p-5 md:p-6 text-white border-b border-red-600/40">
          <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div>
              <div className="flex items-center gap-2 mb-1">
                <span className="px-2 py-0.5 bg-white/20 rounded text-[10px] font-bold uppercase tracking-wider">
                  موتور جستجوی عمده
                </span>
                <span className="text-red-200 text-xs">پین‌پارت</span>
              </div>
              <h2 className="text-xl md:text-2xl font-black">جستجوی تخصصی قطعات، خارجات و پیچ و مهره</h2>
              <p className="text-red-100 text-xs mt-1">
                فیلتر دقیق بر اساس برند خودرو (سایپا، ایران خودرو، چینی)، مدل، کد فنی یا نام قطعه
              </p>
            </div>

            <div className="flex items-center gap-2.5">
              <button
                type="button"
                onClick={() => setShowAdvanced(!showAdvanced)}
                className={`flex items-center gap-1.5 px-3.5 py-2 rounded-xl text-xs font-bold transition-all border ${
                  showAdvanced
                    ? 'bg-white text-red-700 border-white shadow-lg'
                    : 'bg-white/10 hover:bg-white/20 text-white border-white/20'
                }`}
              >
                <Filter className="h-3.5 w-3.5" />
                <span>{showAdvanced ? 'بستن فیلترها' : 'فیلترهای پیشرفته'}</span>
              </button>

              {activeFiltersCount() > 0 && (
                <button
                  type="button"
                  onClick={handleReset}
                  className="flex items-center gap-1.5 px-3 py-2 bg-slate-950/80 hover:bg-black text-red-400 rounded-xl text-xs font-bold transition-all border border-red-500/30"
                  title="حذف همه فیلترها و نمایش تمام کالاها"
                >
                  <RotateCcw className="h-3.5 w-3.5" />
                  <span>حذف فیلترها ({activeFiltersCount()})</span>
                </button>
              )}
            </div>
          </div>
        </div>

        {/* Primary Search Bar */}
        <div className="p-4 md:p-6 border-b border-slate-800 bg-slate-950/40">
          <div className="relative flex flex-col sm:flex-row gap-3">
            <div className="relative flex-1">
              <div className="absolute inset-y-0 right-0 pr-3.5 flex items-center pointer-events-none text-slate-500">
                <Search className="h-5 w-5" />
              </div>
              <input
                type="text"
                value={filters.search}
                onChange={(e) => setFilters(prev => ({ ...prev, search: e.target.value }))}
                placeholder="نام قطعه، شماره فنی، مشخصات، نوع خار یا پیچ و مهره..."
                className="w-full pr-11 pl-10 py-3.5 bg-slate-950 border border-slate-700 rounded-xl focus:border-red-500 focus:ring-1 focus:ring-red-500 text-white placeholder-slate-500 text-sm transition-all"
              />
              {filters.search && (
                <button
                  type="button"
                  onClick={() => setFilters(prev => ({ ...prev, search: '' }))}
                  className="absolute inset-y-0 left-0 pl-3 flex items-center text-slate-500 hover:text-white"
                >
                  <X className="h-4 w-4" />
                </button>
              )}
            </div>

            <div className="flex gap-2">
              <button
                type="submit"
                disabled={loading}
                className="px-6 py-3.5 bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white font-bold text-xs rounded-xl shadow-lg shadow-red-950/50 transition-all flex items-center justify-center gap-2 whitespace-nowrap min-w-[120px]"
              >
                {loading ? (
                  <div className="h-4 w-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                ) : (
                  <>
                    <Search className="h-4 w-4" />
                    <span>جستجوی قطعه</span>
                  </>
                )}
              </button>

              <button
                type="button"
                onClick={handleReset}
                className="px-4 py-3.5 bg-slate-800 hover:bg-slate-700 text-slate-300 hover:text-white font-bold text-xs rounded-xl transition-all border border-slate-700 flex items-center justify-center gap-1.5 whitespace-nowrap"
              >
                <RotateCcw className="h-4 w-4" />
                <span>حذف فیلترها</span>
              </button>
            </div>
          </div>
        </div>

        {/* Fast Filter Bar (Brand, Model, Part Number) */}
        <div className="p-4 md:p-6 bg-slate-900/60 border-b border-slate-800">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {/* Car Brand Selector (سایپا / ایران خودرو / چینی / سایر) */}
            <div>
              <label className="block text-xs font-bold text-slate-300 mb-2">
                برند خودرو
              </label>
              <select
                value={filters.carBrand}
                onChange={(e) => setFilters(prev => ({ ...prev, carBrand: e.target.value, carModel: '' }))}
                className="w-full px-3.5 py-2.5 bg-slate-950 border border-slate-700 rounded-xl text-white text-xs focus:border-red-500 focus:outline-none transition-all"
              >
                {BRAND_OPTIONS.map((b) => (
                  <option key={b.id} value={b.id}>
                    {b.label}
                  </option>
                ))}
              </select>
            </div>

            {/* Car Model Input & Quick Suggestions */}
            <div>
              <label className="block text-xs font-bold text-slate-300 mb-2">
                مدل خودرو
              </label>
              <input
                type="text"
                value={filters.carModel}
                onChange={(e) => setFilters(prev => ({ ...prev, carModel: e.target.value }))}
                placeholder="مثلا: پراید، پژو ۲۰۶، دنا، تیگو، هایما..."
                className="w-full px-3.5 py-2.5 bg-slate-950 border border-slate-700 rounded-xl text-white text-xs focus:border-red-500 focus:outline-none transition-all"
              />
              {/* Quick model pills if available */}
              {modelSuggestions.length > 0 && (
                <div className="flex flex-wrap gap-1 mt-2">
                  {modelSuggestions.slice(0, 5).map((m) => (
                    <button
                      key={m}
                      type="button"
                      onClick={() => setFilters(prev => ({ ...prev, carModel: m }))}
                      className={`text-[10px] px-2 py-0.5 rounded transition-all ${
                        filters.carModel === m
                          ? 'bg-red-600 text-white font-bold'
                          : 'bg-slate-800 text-slate-400 hover:text-white hover:bg-slate-700'
                      }`}
                    >
                      {m}
                    </button>
                  ))}
                </div>
              )}
            </div>

            {/* Part Number / Technical Code */}
            <div>
              <label className="block text-xs font-bold text-slate-300 mb-2">
                شماره فنی یا کد قطعه
              </label>
              <input
                type="text"
                value={filters.partNumber}
                onChange={(e) => setFilters(prev => ({ ...prev, partNumber: e.target.value }))}
                placeholder="مثلا: PIN-405, 9632..."
                className="w-full px-3.5 py-2.5 bg-slate-950 border border-slate-700 rounded-xl text-white text-xs focus:border-red-500 focus:outline-none transition-all font-mono"
              />
            </div>
          </div>
        </div>

        {/* Collapsible Advanced Filters */}
        {showAdvanced && (
          <div className="p-4 md:p-6 bg-slate-950/80 border-t border-slate-800 space-y-4">
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
              <div>
                <label className="block text-xs font-bold text-slate-300 mb-2">
                  برند تولیدی یا سازنده قطعه
                </label>
                <input
                  type="text"
                  value={filters.brand}
                  onChange={(e) => setFilters(prev => ({ ...prev, brand: e.target.value }))}
                  placeholder="مثلا: پین‌پارت، ایساکو، سایپایدک..."
                  className="w-full px-3.5 py-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white text-xs focus:border-red-500 focus:outline-none transition-all"
                />
              </div>

              <div>
                <label className="block text-xs font-bold text-slate-300 mb-2">
                  جنس و متریال
                </label>
                <input
                  type="text"
                  value={filters.material || ''}
                  onChange={(e) => setFilters(prev => ({ ...prev, material: e.target.value }))}
                  placeholder="مثلا: پلیمری، پلی‌آمید، فولادی، خشکه..."
                  className="w-full px-3.5 py-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white text-xs focus:border-red-500 focus:outline-none transition-all"
                />
              </div>

              <div>
                <label className="block text-xs font-bold text-slate-300 mb-2">
                  مرتب‌سازی بر اساس
                </label>
                <select
                  value={filters.sortBy}
                  onChange={(e) => setFilters(prev => ({ ...prev, sortBy: e.target.value as any }))}
                  className="w-full px-3.5 py-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white text-xs focus:border-red-500 focus:outline-none transition-all"
                >
                  <option value="createdAt">جدیدترین قطعات</option>
                  <option value="displayOrder">اولویت نمایش</option>
                  <option value="name">نام قطعه (الفبا)</option>
                </select>
              </div>
            </div>
          </div>
        )}
      </form>
    </div>
  );
};

export default AdvancedSearch;