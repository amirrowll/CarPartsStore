import React, { useEffect, useRef } from 'react';
import { Link } from 'react-router-dom';
import { useAppContext } from '../context/AppContext';
import { Swiper, SwiperSlide } from 'swiper/react';
import { Navigation, Pagination, Autoplay, EffectCards } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import 'swiper/css/effect-cards';
import SwiperCore from 'swiper';

// Material UI Icons
import EngineeringIcon from '@mui/icons-material/Engineering';
import BatteryChargingFullIcon from '@mui/icons-material/BatteryChargingFull';
import SpeedIcon from '@mui/icons-material/Speed';
import BuildIcon from '@mui/icons-material/Build';
import DirectionsCarIcon from '@mui/icons-material/DirectionsCar';
import SettingsIcon from '@mui/icons-material/Settings';
import FilterAltIcon from '@mui/icons-material/FilterAlt';
import ElectricCarIcon from '@mui/icons-material/ElectricCar';

const categoryIcons = [
  { icon: DirectionsCarIcon, name: 'خودرو' },
  { icon: EngineeringIcon, name: 'موتور' },
  { icon: BatteryChargingFullIcon, name: 'برق' },
  { icon: SpeedIcon, name: 'تجهیزات' },
  { icon: BuildIcon, name: 'بدنه' },
  { icon: SettingsIcon, name: 'سیستم' },
  { icon: FilterAltIcon, name: 'فیلتر' },
  { icon: ElectricCarIcon, name: 'برقی' }
];

const categoryColors = [
  'bg-gradient-to-br from-cyan-500 to-blue-600',
  'bg-gradient-to-br from-orange-500 to-red-600',
  'bg-gradient-to-br from-green-500 to-emerald-600',
  'bg-gradient-to-br from-purple-500 to-pink-600',
  'bg-gradient-to-br from-yellow-500 to-amber-600',
  'bg-gradient-to-br from-indigo-500 to-violet-600',
  'bg-gradient-to-br from-rose-500 to-pink-600',
  'bg-gradient-to-br from-sky-500 to-cyan-600',
];

const CategoriesSection: React.FC = () => {
  const { categories, loading } = useAppContext();
  const swiperRef = useRef<SwiperCore | null>(null);

  useEffect(() => {
    return () => {
      if (swiperRef.current) {
        swiperRef.current.destroy(true, true);
      }
    };
  }, []);

  if (loading) {
    return (
      <section className="py-20 bg-gradient-to-b from-gray-50 to-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-4xl md:text-5xl font-bold text-gray-900 mb-6">
              دسته‌بندی <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-cyan-500">محصولات</span>
            </h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              در حال بارگذاری دسته‌بندی‌ها...
            </p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
            {[1, 2, 3, 4, 5, 6, 7, 8].map((i) => (
              <div key={i} className="bg-white rounded-3xl shadow-xl p-8 animate-pulse">
                <div className="h-16 w-16 bg-gray-200 rounded-2xl mb-6"></div>
                <div className="h-6 bg-gray-200 rounded-xl mb-3"></div>
                <div className="h-4 bg-gray-200 rounded mb-4"></div>
                <div className="h-8 bg-gray-200 rounded-xl"></div>
              </div>
            ))}
          </div>
        </div>
      </section>
    );
  }

  if (categories.length === 0) {
    return (
      <section className="py-20 bg-gradient-to-b from-gray-50 to-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-4xl md:text-5xl font-bold text-gray-900 mb-6">
              دسته‌بندی <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-cyan-500">محصولات</span>
            </h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto mb-10">
              هنوز دسته‌بندی ایجاد نشده است. از پنل مدیریت دسته‌بندی‌ها را ایجاد کنید.
            </p>
            <a 
              href="/admin" 
              className="inline-flex items-center px-8 py-4 bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-bold text-lg rounded-2xl hover:from-blue-700 hover:to-cyan-600 transition-all shadow-xl hover:shadow-2xl hover:scale-105"
            >
              ایجاد دسته‌بندی جدید
            </a>
          </div>
        </div>
      </section>
    );
  }

  return (
    <section className="py-20 bg-gradient-to-b from-gray-50 to-white overflow-hidden">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-16">
          <h2 className="text-4xl md:text-5xl font-bold text-gray-900 mb-6">
            دسته‌بندی <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-cyan-500">محصولات</span>
          </h2>
          <p className="text-xl text-center text-gray-600 max-w-3xl mx-auto">
            قطعات یدکی خودرو در دسته‌بندی‌های تخصصی و مدرن
          </p>
        </div>

        {/* Swiper Container */}
        <div className="relative">
          <Swiper
            modules={[Navigation, Pagination, Autoplay]}
            spaceBetween={30}
            slidesPerView={1}
            navigation
            pagination={{ clickable: true }}
            autoplay={{
              delay: 3000,
              disableOnInteraction: false,
            }}
            breakpoints={{
              640: {
                slidesPerView: 2,
                spaceBetween: 20,
              },
              768: {
                slidesPerView: 3,
                spaceBetween: 30,
              },
              1024: {
                slidesPerView: 4,
                spaceBetween: 30,
              },
            }}
            onSwiper={(swiper) => {
              swiperRef.current = swiper;
            }}
            className="pb-12"
          >
            {categories.map((category, index) => {
              const Icon = categoryIcons[index % categoryIcons.length]?.icon || DirectionsCarIcon;
              const color = categoryColors[index % categoryColors.length];
              
              return (
                <SwiperSlide key={category.id}>
                  <div className="relative bg-white rounded-3xl shadow-2xl hover:shadow-3xl transition-all duration-500 transform hover:-translate-y-2 overflow-hidden group h-full">
                    {/* Background Gradient */}
                    <div className={`absolute top-0 left-0 w-full h-2 ${color.replace('bg-gradient-to-br', 'bg-gradient-to-r')}`}></div>
                    
                    <div className="p-8">
                      <div className="flex items-start justify-between mb-6">
                        <div className={`${color} p-4 rounded-2xl text-white shadow-lg`}>
                          <Icon className="h-10 w-10" />
                        </div>
                        <span className="text-sm font-bold text-gray-600 bg-gray-100 px-3 py-1 rounded-full">
                          {category.productCount || category.ProductCount || 0} محصول
                        </span>
                      </div>
                      
                      <h3 className="text-2xl font-bold text-gray-900 mb-3">
                        {category.name}
                      </h3>
                      <p className="text-gray-600 mb-6 line-clamp-2">
                        {category.description || 'دسته‌بندی تخصصی قطعات خودرو'}
                      </p>
                      
                      <div className="flex items-center justify-between">
                        <Link 
                          to={`/products/category/${category.id}`}
                          className="text-blue-600 font-bold hover:text-blue-700 flex items-center gap-2 group-hover:gap-3 transition-all"
                        >
                          مشاهده محصولات
                          <svg className="w-5 h-5 rtl:rotate-180 transition-transform group-hover:translate-x-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5l7 7-7 7"></path>
                          </svg>
                        </Link>
                        <span className="text-xs px-4 py-1.5 bg-gradient-to-r from-amber-500 to-orange-500 text-white font-bold rounded-full shadow-md">
                          پرفروش
                        </span>
                      </div>
                    </div>
                  </div>
                </SwiperSlide>
              );
            })}
          </Swiper>

          {/* Custom Navigation Buttons */}
          <style>
            {`
              .swiper-button-next, .swiper-button-prev {
                background: linear-gradient(135deg, #3b82f6, #06b6d4);
                width: 48px;
                height: 48px;
                border-radius: 50%;
                box-shadow: 0 10px 20px rgba(59, 130, 246, 0.3);
                transition: all 0.3s ease;
              }
              
              .swiper-button-next:hover, .swiper-button-prev:hover {
                transform: scale(1.1);
                box-shadow: 0 15px 30px rgba(59, 130, 246, 0.4);
              }
              
              .swiper-button-next:after, .swiper-button-prev:after {
                font-size: 18px;
                color: white;
                font-weight: bold;
              }
              
              .swiper-pagination-bullet {
                width: 12px;
                height: 12px;
                background: #cbd5e1;
                opacity: 0.7;
              }
              
              .swiper-pagination-bullet-active {
                background: linear-gradient(135deg, #3b82f6, #06b6d4);
                opacity: 1;
                transform: scale(1.2);
              }
            `}
          </style>
        </div>
      </div>
    </section>
  );
};

export default CategoriesSection;