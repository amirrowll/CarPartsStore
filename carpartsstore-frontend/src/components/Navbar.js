import { useState } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { Menu, X, Car, Home, Search } from 'lucide-react';
import { Phone as PhoneIcon, WhatsApp, Telegram, Instagram } from '@mui/icons-material';
const Navbar = () => {
    const [isMenuOpen, setIsMenuOpen] = useState(false);
    const [mobileSearchOpen, setMobileSearchOpen] = useState(false);
    const [searchQuery, setSearchQuery] = useState('');
    const location = useLocation();
    const navigate = useNavigate();
    const handleMobileSearch = (e) => {
        e.preventDefault();
        if (searchQuery.trim()) {
            navigate('/advanced-search', {
                state: { initialFilters: { search: searchQuery.trim() } }
            });
            setMobileSearchOpen(false);
            setSearchQuery('');
        }
    };
    const navLinks = [
        { name: 'خانه', path: '/', icon: <Home className="h-5 w-5"/> },
        { name: 'جستجوی پیشرفته', path: '/advanced-search', icon: <Search className="h-5 w-5"/> },
        { name: 'لوازم چینی', path: '/chinese-parts', icon: <Car className="h-5 w-5"/> },
        { name: 'لوازم سایپا', path: '/saipa-parts', icon: <Car className="h-5 w-5"/> },
        { name: 'لوازم ایران خودرو', path: '/irankhodro-parts', icon: <Car className="h-5 w-5"/> },
        { name: 'ارتباط با ما', path: '/contact-us', icon: <PhoneIcon className="h-5 w-5"/> },
    ];
    const handleManagementCall = () => {
        window.location.href = 'tel:09308368089';
    };
    return (<nav className="sticky top-0 z-50 bg-white shadow-lg border-b border-gray-200">
      <div className="container mx-auto px-4">
        <div className="flex items-center justify-between h-16">
          {/* لوگو */}
          <Link to="/" className="flex items-center space-x-2 space-x-reverse">
            <div className="rounded-lg">
              <img src="/PinpartStore.JPEG" alt="Pinpart Store Logo" className="h-16 w-16 rounded-full object-cover" onError={(e) => {
            const target = e.target;
            target.src = 'https://via.placeholder.com/100/3B82F6/FFFFFF?text=PinPart';
        }}/>
            </div>
            <div className="hidden md:block">
              <h1 className="text-xl font-bold text-gray-900">
                <span className="text-red-600">P</span>inpart<span className="text-blue-600">Store</span>
              </h1>
              <p className="text-xs text-gray-500">تخصصی ترین فروشگاه لوازم یدکی</p>
            </div>
          </Link>

          {/* ناوبری دسکتاپ */}
          <div className="hidden md:flex items-center space-x-6 space-x-reverse">
            {navLinks.map((link) => (<Link key={link.path} to={link.path} className={`flex items-center space-x-1 space-x-reverse ${location.pathname === link.path ? 'text-blue-600 font-semibold' : 'text-gray-700 hover:text-blue-600'} transition-colors duration-200 px-3 py-2 rounded-lg`}>
                {link.icon}
                <span>{link.name}</span>
              </Link>))}
          </div>

          {/* آیکونهای موبایل */}
          <div className="md:hidden flex items-center space-x-4 space-x-reverse">
            {/* آیکون ارتباط با ما در موبایل */}
            <Link to="/contact-us" className="flex items-center justify-center text-gray-700 hover:text-blue-600 transition-colors p-2" title="ارتباط با ما">
              <PhoneIcon className="h-6 w-6"/>
            </Link>

            {/* آیکون جستجو در موبایل */}
            <button onClick={() => setMobileSearchOpen(true)} className="flex items-center justify-center text-gray-700 hover:text-blue-600 transition-colors p-2" title="جستجو">
              <Search className="h-6 w-6"/>
            </button>

            {/* منوی موبایل */}
            <button onClick={() => setIsMenuOpen(!isMenuOpen)} className="text-gray-700 p-2">
              {isMenuOpen ? <X className="h-6 w-6"/> : <Menu className="h-6 w-6"/>}
            </button>
          </div>
        </div>

        {/* نوار جستجوی موبایل */}
        {mobileSearchOpen && (<div className="md:hidden py-4 border-t border-gray-200 bg-white">
            <div className="px-4">
              <div className="flex items-center justify-between mb-3">
                <h3 className="font-medium text-gray-800">جستجوی قطعات</h3>
                <button onClick={() => {
                setMobileSearchOpen(false);
                setSearchQuery('');
            }} className="text-gray-500 hover:text-gray-700">
                  <X className="h-5 w-5"/>
                </button>
              </div>
              
              <form onSubmit={handleMobileSearch}>
                <div className="relative">
                  <input type="text" value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} placeholder="🔍 نام قطعه، برند یا مدل خودرو..." className="w-full pr-4 pl-10 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none transition duration-200 text-right placeholder:text-gray-400" autoFocus/>
                  <button type="submit" disabled={!searchQuery.trim()} className="absolute right-0 inset-y-0 pr-3 flex items-center text-blue-600 hover:text-blue-700 disabled:text-gray-400 disabled:cursor-not-allowed">
                    <Search className="h-5 w-5"/>
                  </button>
                </div>
                
                <div className="mt-3 flex flex-wrap gap-2">
                  {['لنت ترمز', 'فیلتر هوا', 'روغن موتور', 'شمع'].map((tag) => (<button key={tag} type="button" onClick={() => {
                    navigate('/advanced-search', {
                        state: { initialFilters: { search: tag } }
                    });
                    setMobileSearchOpen(false);
                }} className="px-3 py-1.5 bg-gray-100 hover:bg-gray-200 text-gray-700 text-sm rounded-lg transition-colors">
                      {tag}
                    </button>))}
                </div>
              </form>
            </div>
          </div>)}

        {/* منوی موبایل باز شده */}
        {isMenuOpen && (<div className="md:hidden py-4 border-t border-gray-200">
            <div className="space-y-2">
              {navLinks.map((link) => (<Link key={link.path} to={link.path} className={`flex items-center space-x-2 space-x-reverse px-4 py-3 rounded-lg ${location.pathname === link.path ? 'bg-blue-50 text-blue-600' : 'hover:bg-gray-100 text-gray-700'} transition-colors duration-200`} onClick={() => setIsMenuOpen(false)}>
                  {link.icon}
                  <span className="font-medium">{link.name}</span>
                </Link>))}

              {/* بخش تماس و شبکههای اجتماعی در موبایل */}
              <div className="px-4 py-3">
                <div className="flex items-center justify-between mb-3">
                  <h3 className="font-medium text-gray-800">ارتباط با ما</h3>
                  <button onClick={() => window.location.href = 'tel:09196408805'} className="flex items-center space-x-1 space-x-reverse text-blue-600 hover:text-blue-700 font-medium">
                    <PhoneIcon className="h-5 w-5"/>
                    <span>تماس بگیرید</span>
                  </button>
                </div>
                
                <div className="flex items-center space-x-4 space-x-reverse">
                  <a href="https://wa.me/09196408805" target="_blank" rel="noopener noreferrer" className="flex items-center justify-center p-2 rounded-lg bg-green-50 hover:bg-green-100 transition-colors" title="واتساپ">
                    <WhatsApp className="h-6 w-6 text-green-600"/>
                  </a>
                  
                  <a href="https://t.me/Pinparts1" target="_blank" rel="noopener noreferrer" className="flex items-center justify-center p-2 rounded-lg bg-blue-50 hover:bg-blue-100 transition-colors" title="تلگرام">
                    <Telegram className="h-6 w-6 text-blue-500"/>
                  </a>
                  
                  <a href="https://instagram.com/pinparts" target="_blank" rel="noopener noreferrer" className="flex items-center justify-center p-2 rounded-lg bg-pink-50 hover:bg-pink-100 transition-colors" title="اینستاگرام">
                    <Instagram className="h-6 w-6 text-pink-600"/>
                  </a>
                </div>
              </div>

            </div>
          </div>)}
      </div>
    </nav>);
};
export default Navbar;
