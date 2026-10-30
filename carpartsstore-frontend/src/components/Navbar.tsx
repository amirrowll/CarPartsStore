import React, { useState } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { Menu, X, Search, PhoneCall, Layers, Wrench, ShieldAlert, Zap, Car, Home, Download } from 'lucide-react';
import { Phone as PhoneIcon, WhatsApp, Telegram } from '@mui/icons-material';
import CallRequestModal from './CallRequestModal';

const Navbar: React.FC = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [mobileSearchOpen, setMobileSearchOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [isCallModalOpen, setIsCallModalOpen] = useState(false);
  const location = useLocation();
  const navigate = useNavigate();

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (searchQuery.trim()) {
      navigate('/advanced-search', { 
        state: { initialFilters: { search: searchQuery.trim() } }
      });
      setMobileSearchOpen(false);
      setSearchQuery('');
    }
  };

  // 3 Target Categories
  const targetCategories = [
    { name: 'خارجات', path: '/category/10/خارجات', icon: <Layers className="h-4 w-4 text-red-500" /> },
    { name: 'پیچ و مهره', path: '/category/11/پیچ-و-مهره', icon: <Wrench className="h-4 w-4 text-amber-500" /> },
    { name: 'آرم و علائم', path: '/category/12/آرم-و-علائم', icon: <ShieldAlert className="h-4 w-4 text-blue-500" /> },
  ];

  // 3 Target Car Brands
  const targetBrands = [
    { name: 'لوازم سایپا', path: '/saipa-parts', color: 'text-orange-600 hover:bg-orange-50' },
    { name: 'لوازم ایران خودرو', path: '/irankhodro-parts', color: 'text-blue-600 hover:bg-blue-50' },
    { name: 'لوازم چینی', path: '/chinese-parts', color: 'text-cyan-600 hover:bg-cyan-50' },
  ];

  return (
    <>
      <header className="sticky top-0 z-50 bg-white shadow-md border-b border-gray-200" dir="rtl">
        {/* Top Info Bar */}
        <div className="bg-gradient-to-r from-gray-950 via-gray-900 to-black text-white text-xs py-2 px-4 border-b border-red-600/30">
          <div className="container mx-auto flex flex-col sm:flex-row items-center justify-between gap-2">
            <div className="flex items-center gap-2 text-center sm:text-right">
              <span className="inline-block w-2 h-2 rounded-full bg-red-500 animate-ping"></span>
              <span className="font-semibold text-gray-200">
                مرکز تخصصی پخش عمده: تمامی خارجات فلزی و پلیمری / پیچ و مهره خودرویی (فروش منحصراً عمده)
              </span>
            </div>
            
            <div className="flex items-center gap-4 text-gray-300">
              <a 
                href="https://chat.whatsapp.com/CGCLTGEoouVEfgybJMlWw8?mode=wwc" 
                target="_blank" 
                rel="noreferrer"
                className="inline-flex items-center gap-1 hover:text-green-400 transition-colors"
                title="کانال واتساپ"
              >
                <WhatsApp className="!w-4 !h-4 text-green-400" />
                <span className="hidden md:inline">کانال واتساپ</span>
              </a>

              <a 
                href="https://t.me/pinparts" 
                target="_blank" 
                rel="noreferrer"
                className="inline-flex items-center gap-1 hover:text-blue-400 transition-colors"
                title="کانال تلگرام"
              >
                <Telegram className="!w-4 !h-4 text-blue-400" />
                <span className="hidden md:inline">کانال تلگرام</span>
              </a>

              <a 
                href="tel:09196408805" 
                className="inline-flex items-center gap-1 text-red-400 font-bold hover:text-red-300 transition-colors"
                title="واحد فروش و استعلام عمده پین‌پارت"
              >
                <PhoneCall className="h-3.5 w-3.5" />
                <span className="dir-ltr tracking-wider font-mono">09196408805</span>
              </a>
            </div>
          </div>
        </div>

        {/* Main Header */}
        <div className="container mx-auto px-4 py-3">
          <div className="flex items-center justify-between gap-4">
            {/* Logo */}
            <Link to="/" className="flex items-center gap-3 shrink-0 group">
              <div className="relative">
                <img 
                  src="/logo.png" 
                  alt="Pinpart Logo"
                  className="h-12 md:h-14 w-auto object-contain transition-transform duration-300 group-hover:scale-105"
                  onError={(e) => {
                    const target = e.target as HTMLImageElement;
                    target.src = '/PinpartStore.JPEG';
                  }}
                />
              </div>
              <div className="flex flex-col">
                <div className="flex items-center gap-1.5">
                  <span className="text-xl md:text-2xl font-black text-gray-950 tracking-tight">پین‌پارت</span>
                  <span className="text-xs md:text-sm font-bold text-red-600 bg-red-50 border border-red-200 px-2 py-0.5 rounded-md">
                    فروش عمده
                  </span>
                </div>
                <span className="text-[11px] md:text-xs text-gray-500 font-medium">
                  تولید و پخش خارجات، پیچ و مهره، آرم و علائم
                </span>
              </div>
            </Link>

            {/* Desktop Search Bar */}
            <div className="hidden lg:flex flex-1 max-w-xl mx-4">
              <form onSubmit={handleSearch} className="w-full relative">
                <input
                  type="text"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  placeholder="جستجوی قطعه، کد فنی، پیچ، خار، آرم و علائم..."
                  className="w-full pr-11 pl-24 py-2.5 bg-gray-50 border border-gray-300 rounded-2xl text-sm focus:bg-white focus:border-red-500 focus:ring-2 focus:ring-red-100 outline-none transition-all"
                />
                <Search className="absolute right-3.5 top-1/2 -translate-y-1/2 h-5 w-5 text-gray-400" />
                <button
                  type="submit"
                  className="absolute left-1.5 top-1/2 -translate-y-1/2 px-4 py-1.5 bg-red-600 hover:bg-red-700 text-white text-xs font-bold rounded-xl transition-colors shadow-sm"
                >
                  جستجو
                </button>
              </form>
            </div>

            {/* Header Actions */}
            <div className="flex items-center gap-2 sm:gap-3">
              <a
                href="/catalog/pinpart-catalog.pdf"
                download="pinpart-catalog.pdf"
                target="_blank"
                rel="noopener noreferrer"
                className="hidden md:inline-flex items-center gap-1.5 px-3.5 py-2.5 bg-slate-900 hover:bg-slate-800 text-amber-400 hover:text-amber-300 border border-slate-700 font-bold text-xs md:text-sm rounded-2xl shadow-sm transition-all"
                title="دانلود فایل کاتالوگ جامع محصولات پین‌پارت"
              >
                <Download className="h-4 w-4" />
                <span>دانلود کاتالوگ</span>
              </a>

              <button
                onClick={() => setIsCallModalOpen(true)}
                className="hidden sm:inline-flex items-center gap-2 px-4 py-2.5 bg-gradient-to-r from-red-600 to-red-700 hover:from-red-700 hover:to-red-800 text-white font-bold text-xs md:text-sm rounded-2xl shadow-md hover:shadow-lg transition-all"
              >
                <PhoneCall className="h-4 w-4 animate-bounce" />
                <span>درخواست تماس و استعلام قیمت</span>
              </button>

              {/* Mobile Search Button */}
              <button
                onClick={() => setMobileSearchOpen(!mobileSearchOpen)}
                className="lg:hidden p-2 text-gray-700 hover:text-red-600 hover:bg-gray-100 rounded-xl"
                aria-label="جستجو"
              >
                <Search className="h-6 w-6" />
              </button>

              {/* Mobile Menu Button */}
              <button
                onClick={() => setIsMenuOpen(!isMenuOpen)}
                className="lg:hidden p-2 text-gray-700 hover:text-red-600 hover:bg-gray-100 rounded-xl"
                aria-label="منو"
              >
                {isMenuOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
              </button>
            </div>
          </div>
        </div>

        {/* Mobile Search Input Dropdown */}
        {mobileSearchOpen && (
          <div className="lg:hidden p-4 bg-gray-50 border-t border-gray-200 animate-fade-in">
            <form onSubmit={handleSearch} className="relative">
              <input
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                placeholder="نام قطعه، کد فنی، پیچ، خار یا آرم..."
                className="w-full pr-11 pl-20 py-2.5 bg-white border border-gray-300 rounded-xl text-sm focus:border-red-500 focus:ring-2 focus:ring-red-100 outline-none"
                autoFocus
              />
              <Search className="absolute right-3.5 top-1/2 -translate-y-1/2 h-5 w-5 text-gray-400" />
              <button
                type="submit"
                className="absolute left-1.5 top-1/2 -translate-y-1/2 px-3 py-1.5 bg-red-600 text-white text-xs font-bold rounded-lg"
              >
                جستجو
              </button>
            </form>
          </div>
        )}

        {/* Navigation Categories & Brands Bar */}
        <div className="hidden lg:block bg-gray-50 border-t border-gray-200">
          <div className="container mx-auto px-4">
            <div className="flex items-center justify-between">
              {/* Category Links */}
              <div className="flex items-center space-x-1 space-x-reverse py-1">
                <Link
                  to="/"
                  className={`inline-flex items-center gap-1.5 px-3 py-2 rounded-xl text-xs md:text-sm font-bold transition-colors ${
                    location.pathname === '/' ? 'text-red-600 bg-red-50' : 'text-gray-700 hover:text-red-600 hover:bg-gray-100'
                  }`}
                >
                  <Home className="h-4 w-4" />
                  <span>صفحه اصلی</span>
                </Link>

                <div className="h-4 w-px bg-gray-300 mx-1"></div>

                {/* 4 Core Categories */}
                {targetCategories.map((cat) => (
                  <Link
                    key={cat.name}
                    to={cat.path}
                    className={`inline-flex items-center gap-1.5 px-3 py-2 rounded-xl text-xs md:text-sm font-bold transition-all ${
                      location.pathname.includes(cat.name)
                        ? 'text-red-700 bg-red-100 shadow-sm'
                        : 'text-gray-800 hover:text-red-600 hover:bg-white'
                    }`}
                  >
                    {cat.icon}
                    <span>{cat.name}</span>
                  </Link>
                ))}

                <div className="h-4 w-px bg-gray-300 mx-1"></div>

                {/* 3 Core Car Brands */}
                {targetBrands.map((brand) => (
                  <Link
                    key={brand.name}
                    to={brand.path}
                    className={`inline-flex items-center gap-1 px-3 py-2 rounded-xl text-xs md:text-sm font-semibold transition-colors ${
                      location.pathname === brand.path ? 'bg-white shadow-sm font-bold' : ''
                    } ${brand.color}`}
                  >
                    <Car className="h-4 w-4" />
                    <span>{brand.name}</span>
                  </Link>
                ))}
              </div>

              {/* Advanced search & Contact Links */}
              <div className="flex items-center gap-2">
                <Link
                  to="/advanced-search"
                  className="inline-flex items-center gap-1 text-xs font-bold text-gray-700 hover:text-red-600 px-3 py-2 rounded-xl hover:bg-gray-100 transition-colors"
                >
                  <Search className="h-3.5 w-3.5" />
                  <span>جستجوی پیشرفته</span>
                </Link>

                <Link
                  to="/contact-us"
                  className="inline-flex items-center gap-1 text-xs font-bold text-gray-700 hover:text-red-600 px-3 py-2 rounded-xl hover:bg-gray-100 transition-colors"
                >
                  <PhoneIcon className="!w-3.5 !h-3.5" />
                  <span>ارتباط با ما</span>
                </Link>
              </div>
            </div>
          </div>
        </div>

        {/* Mobile Navigation Drawer */}
        {isMenuOpen && (
          <div 
            className="lg:hidden border-t border-gray-200 bg-white p-4 space-y-4 shadow-xl animate-fade-in max-h-[calc(100dvh-70px)] overflow-y-auto overscroll-contain pb-16 touch-pan-y"
            style={{ WebkitOverflowScrolling: 'touch' }}
          >
            <button
              onClick={() => {
                setIsCallModalOpen(true);
                setIsMenuOpen(false);
              }}
              className="w-full py-3 bg-red-600 text-white font-bold text-sm rounded-xl flex items-center justify-center gap-2 shadow-md shrink-0"
            >
              <PhoneCall className="h-4 w-4" />
              <span>درخواست تماس و استعلام قیمت عمده</span>
            </button>

            <div>
              <h4 className="text-xs font-extrabold text-gray-400 uppercase tracking-wider mb-2">دسته‌بندی‌های اصلی</h4>
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-2">
                {targetCategories.map((cat) => (
                  <Link
                    key={cat.name}
                    to={cat.path}
                    onClick={() => setIsMenuOpen(false)}
                    className="flex items-center gap-2 p-2.5 rounded-xl border border-gray-200 hover:border-red-500 font-bold text-sm text-gray-800 hover:text-red-600 transition-colors"
                  >
                    {cat.icon}
                    <span>{cat.name}</span>
                  </Link>
                ))}
              </div>
            </div>

            <div>
              <h4 className="text-xs font-extrabold text-gray-400 uppercase tracking-wider mb-2">برندهای خودرویی</h4>
              <div className="space-y-1">
                {targetBrands.map((brand) => (
                  <Link
                    key={brand.name}
                    to={brand.path}
                    onClick={() => setIsMenuOpen(false)}
                    className="flex items-center gap-2 p-2 rounded-xl font-medium text-sm text-gray-700 hover:bg-gray-50"
                  >
                    <Car className="h-4 w-4 text-gray-400" />
                    <span>{brand.name}</span>
                  </Link>
                ))}
              </div>
            </div>

            <div className="pt-2 border-t border-gray-100 flex flex-col gap-2">
              <a
                href="/catalog/pinpart-catalog.pdf"
                download="pinpart-catalog.pdf"
                target="_blank"
                rel="noopener noreferrer"
                onClick={() => setIsMenuOpen(false)}
                className="flex items-center gap-2 p-2 text-sm text-amber-700 bg-amber-50 hover:bg-amber-100 rounded-xl font-bold"
              >
                <Download className="h-4 w-4 text-amber-600" />
                <span>دانلود کاتالوگ جامع پین‌پارت (PDF)</span>
              </a>
              <Link
                to="/advanced-search"
                onClick={() => setIsMenuOpen(false)}
                className="flex items-center gap-2 p-2 text-sm text-gray-700 hover:text-red-600 font-medium"
              >
                <Search className="h-4 w-4" />
                <span>جستجوی پیشرفته قطعات</span>
              </Link>
              <Link
                to="/contact-us"
                onClick={() => setIsMenuOpen(false)}
                className="flex items-center gap-2 p-2 text-sm text-gray-700 hover:text-red-600 font-medium"
              >
                <PhoneIcon className="!w-4 !h-4" />
                <span>تماس با واحد فروش</span>
              </Link>
            </div>
          </div>
        )}
      </header>

      {/* Call Request Modal */}
      <CallRequestModal
        isOpen={isCallModalOpen}
        onClose={() => setIsCallModalOpen(false)}
      />
    </>
  );
};

export default Navbar;