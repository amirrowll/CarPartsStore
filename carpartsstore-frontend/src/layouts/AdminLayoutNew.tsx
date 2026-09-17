import React, { useState } from 'react';
import { Link, Outlet, useLocation } from 'react-router-dom';
import {
  Dashboard,
  Inventory,
  Category,
  People,
  Receipt,
  Settings,
  Menu,
  ChevronLeft,
  ChevronRight,
  AddPhotoAlternate,
  Logout,
  Notifications,
  AccountCircle,
  TrendingUp,
  Store,
  LocalShipping,
  Payment,
  Security,
  Help,
  Brightness4,
  Language
} from '@mui/icons-material';

const AdminLayoutNew: React.FC = () => {
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [activeMenu, setActiveMenu] = useState('');
  const location = useLocation();

  const menuItems = [
    {
      title: 'داشبورد',
      icon: <Dashboard />,
      path: '/admin/dashboard',
      color: 'from-blue-500 to-blue-600'
    },
    {
      title: 'محصولات',
      icon: <Inventory />,
      path: '/admin/products',
      color: 'from-emerald-500 to-emerald-600',
      subItems: [
        { title: 'همه محصولات', path: '/admin/products' },
        { title: 'افزودن محصول', path: '/admin/products/create' },
        { title: 'دسته‌بندی‌ها', path: '/admin/categories' },
        { title: 'برچسب‌ها', path: '/admin/tags' }
      ]
    },
    {
      title: 'دسته‌بندی‌ها',
      icon: <Category />,
      path: '/admin/categories',
      color: 'from-purple-500 to-purple-600'
    },
    {
      title: 'استوری‌ها',
      icon: <AddPhotoAlternate />,
      path: '/admin/stories',
      color: 'from-pink-500 to-pink-600'
    },
    {
      title: 'کاربران',
      icon: <People />,
      path: '/admin/users',
      color: 'from-amber-500 to-amber-600'
    },
    {
      title: 'سفارشات',
      icon: <Receipt />,
      path: '/admin/orders',
      color: 'from-red-500 to-red-600',
      subItems: [
        { title: 'همه سفارشات', path: '/admin/orders' },
        { title: 'سفارشات جدید', path: '/admin/orders/new' },
        { title: 'در حال ارسال', path: '/admin/orders/shipping' }
      ]
    },
    {
      title: 'آمار و گزارشات',
      icon: <TrendingUp />,
      path: '/admin/analytics',
      color: 'from-indigo-500 to-indigo-600'
    },
    {
      title: 'فروشگاه',
      icon: <Store />,
      path: '/admin/store',
      color: 'from-cyan-500 to-cyan-600',
      subItems: [
        { title: 'تنظیمات فروشگاه', path: '/admin/store/settings' },
        { title: 'شبکه‌های اجتماعی', path: '/admin/store/social' },
        { title: 'صفحات', path: '/admin/store/pages' }
      ]
    },
    {
      title: 'تنظیمات',
      icon: <Settings />,
      path: '/admin/settings',
      color: 'from-gray-500 to-gray-600',
      subItems: [
        { title: 'عمومی', path: '/admin/settings/general' },
        { title: 'پرداخت', path: '/admin/settings/payment' },
        { title: 'ارسال', path: '/admin/settings/shipping' },
        { title: 'امنیت', path: '/admin/settings/security' }
      ]
    }
  ];

  const quickActions = [
    { title: 'افزودن محصول', icon: <Inventory />, color: 'bg-emerald-500' },
    { title: 'ایجاد استوری', icon: <AddPhotoAlternate />, color: 'bg-pink-500' },
    { title: 'مشاهده گزارش', icon: <TrendingUp />, color: 'bg-indigo-500' },
    { title: 'تنظیمات', icon: <Settings />, color: 'bg-gray-500' }
  ];

  const isActive = (path: string) => {
    return location.pathname === path || location.pathname.startsWith(path + '/');
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100">
      {/* Top Navigation Bar */}
      <nav className="fixed top-0 right-0 left-0 h-16 bg-white border-b border-gray-200 z-40 shadow-sm">
        <div className="h-full px-6 flex items-center justify-between">
          {/* Left side */}
          <div className="flex items-center gap-4">
            <button
              onClick={() => setSidebarOpen(!sidebarOpen)}
              className="p-2 rounded-lg hover:bg-gray-100 transition-colors"
            >
              {sidebarOpen ? <ChevronRight /> : <Menu />}
            </button>
            
            <div className="flex items-center gap-3">
              <div className="p-2 bg-gradient-to-r from-blue-500 to-blue-600 rounded-xl">
                <Store className="text-white" />
              </div>
              <div>
                <h1 className="font-bold text-gray-800">پنل مدیریت Pinpart</h1>
                <p className="text-xs text-gray-500">مدیریت کامل فروشگاه قطعات خودرو</p>
              </div>
            </div>
          </div>

          {/* Right side */}
          <div className="flex items-center gap-4">
            {/* Quick actions */}
            <div className="hidden md:flex items-center gap-2">
              {quickActions.slice(0, 2).map((action, index) => (
                <button
                  key={index}
                  className={`flex items-center gap-2 ${action.color} text-white px-4 py-2 rounded-xl hover:opacity-90 transition-opacity`}
                >
                  {action.icon}
                  <span className="text-sm font-medium">{action.title}</span>
                </button>
              ))}
            </div>

            {/* Icons */}
            <button className="p-2 rounded-full hover:bg-gray-100 transition-colors relative">
              <Notifications />
              <span className="absolute -top-1 -right-1 w-5 h-5 bg-red-500 text-white text-xs rounded-full flex items-center justify-center">
                3
              </span>
            </button>

            <button className="p-2 rounded-full hover:bg-gray-100 transition-colors">
              <Brightness4 />
            </button>

            <button className="p-2 rounded-full hover:bg-gray-100 transition-colors">
              <Language />
            </button>

            {/* User profile */}
            <div className="flex items-center gap-3">
              <div className="text-right">
                <p className="font-medium text-gray-800">مدیر سیستم</p>
                <p className="text-xs text-gray-500">admin@Pinpart.com</p>
              </div>
              <div className="w-10 h-10 rounded-full bg-gradient-to-r from-blue-500 to-purple-600 flex items-center justify-center text-white font-bold">
                M
              </div>
            </div>
          </div>
        </div>
      </nav>

      {/* Sidebar */}
      <aside className={`
        fixed top-16 bottom-0 right-0 
        bg-white border-l border-gray-200 
        transition-all duration-300 z-30
        ${sidebarOpen ? 'w-64' : 'w-20'}
        shadow-lg
      `}>
        <div className="h-full flex flex-col">
          {/* Menu items */}
          <div className="flex-1 overflow-y-auto py-6">
            <div className="space-y-1 px-3">
              {menuItems.map((item, index) => {
                const active = isActive(item.path);
                return (
                  <div key={index}>
                    <Link
                      to={item.path}
                      onClick={() => setActiveMenu(activeMenu === item.title ? '' : item.title)}
                      className={`
                        flex items-center gap-3 px-4 py-3 rounded-xl
                        transition-all duration-200
                        ${active 
                          ? `bg-gradient-to-r ${item.color} text-white shadow-md` 
                          : 'text-gray-700 hover:bg-gray-100 hover:text-gray-900'
                        }
                      `}
                    >
                      <div className={`${active ? 'text-white' : 'text-gray-500'}`}>
                        {item.icon}
                      </div>
                      {sidebarOpen && (
                        <>
                          <span className="flex-1 font-medium">{item.title}</span>
                          {item.subItems && (
                            <ChevronLeft className={`text-sm transition-transform ${activeMenu === item.title ? 'rotate-90' : ''}`} />
                          )}
                        </>
                      )}
                    </Link>

                    {/* Sub items */}
                    {sidebarOpen && item.subItems && activeMenu === item.title && (
                      <div className="mt-1 ml-8 space-y-1">
                        {item.subItems.map((subItem, subIndex) => (
                          <Link
                            key={subIndex}
                            to={subItem.path}
                            className={`
                              block px-4 py-2 rounded-lg text-sm
                              transition-colors
                              ${isActive(subItem.path)
                                ? 'text-blue-600 bg-blue-50 font-medium'
                                : 'text-gray-600 hover:text-gray-900 hover:bg-gray-100'
                              }
                            `}
                          >
                            {subItem.title}
                          </Link>
                        ))}
                      </div>
                    )}
                  </div>
                );
              })}
            </div>
          </div>

          {/* Bottom section */}
          <div className="border-t border-gray-200 p-4">
            {sidebarOpen ? (
              <div className="space-y-3">
                <div className="px-4 py-3 bg-gradient-to-r from-gray-50 to-gray-100 rounded-xl">
                  <p className="text-sm font-medium text-gray-800">کاربر: مدیر سیستم</p>
                  <p className="text-xs text-gray-500 mt-1">دسترسی کامل</p>
                </div>
                
                <button className="flex items-center gap-3 w-full px-4 py-3 text-red-600 hover:bg-red-50 rounded-xl transition-colors">
                  <Logout />
                  <span className="font-medium">خروج از سیستم</span>
                </button>

                <div className="text-center text-xs text-gray-500 mt-4">
                  <p>Pinpart Store v2.0</p>
                  <p className="mt-1">© 2024 تمامی حقوق محفوظ است</p>
                </div>
              </div>
            ) : (
              <div className="flex flex-col items-center space-y-4">
                <button className="p-3 text-red-600 hover:bg-red-50 rounded-full transition-colors">
                  <Logout />
                </button>
                <div className="text-[10px] text-gray-500 text-center">
                  <p>v2.0</p>
                  <p>© 2024</p>
                </div>
              </div>
            )}
          </div>
        </div>
      </aside>

      {/* Main content */}
      <main className={`
        pt-16 transition-all duration-300
        ${sidebarOpen ? 'pr-64' : 'pr-20'}
      `}>
        <div className="p-6">
          <Outlet />
        </div>
      </main>

      {/* Floating action button for mobile */}
      <button className="md:hidden fixed bottom-6 left-6 w-14 h-14 bg-gradient-to-r from-blue-600 to-blue-700 text-white rounded-full shadow-lg flex items-center justify-center hover:shadow-xl transition-all z-50">
        <AddPhotoAlternate />
      </button>
    </div>
  );
};

export default AdminLayoutNew;