import React, { useEffect, useRef } from 'react';
import { Link } from 'react-router-dom';
import { useAppContext } from '../context/AppContext';
import { Swiper, SwiperSlide } from 'swiper/react';
import { Navigation, Pagination, Autoplay } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import type SwiperCore from 'swiper';

// Helper function to complete image URLs
const completeImageUrl = (url: string | undefined): string => {
  if (!url) return '';
  
  // If it's already a full URL (starts with http), don't change
  if (url.startsWith('http')) return url;
  
  // If it's a relative path starting with /uploads/, complete it
  if (url.startsWith('/uploads/')) {
    return `http://127.0.0.1:5000${url}`;
  }
  
  // For blob URLs (preview), return as-is
  if (url.startsWith('blob:')) return url;
  
  // Return other URLs as-is
  return url;
};

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

const CategoriesSectionNew: React.FC = () => {
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
              دسته بندی <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-cyan-500">محصولات</span>
            </h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              در حال بارگذاری دسته بندیها...
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
              دسته بندی <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-cyan-500">محصولات</span>
            </h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto mb-10">
              به زودی دسته بندی محصولات اضافه خواهد شد.
            </p>
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
            دسته بندی <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-cyan-500">محصولات</span>
          </h2>
          <p className="text-center text-xl text-gray-600 max-w-3xl mx-auto">
            قطعات یدکی خودرو در دسته بندی های تخصصی و مدرن
          </p>
        </div>

        {/* Swiper Container */}
        <div className="relative pb-24">
          <Swiper
            modules={[Navigation, Pagination, Autoplay]}
            spaceBetween={30}
            slidesPerView={1}
            navigation={{
              nextEl: '.custom-next',
              prevEl: '.custom-prev',
            }}
            pagination={{
              el: '.custom-pagination',
              clickable: true,
              bulletClass: 'custom-bullet',
              bulletActiveClass: 'custom-bullet-active',
            }}
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
          >
            {categories.map((category: any, index: number) => {
              const color = categoryColors[index % categoryColors.length];
              
              return (
                <SwiperSlide key={category.id}>
                  <div className="relative bg-white rounded-3xl shadow-2xl hover:shadow-3xl transition-all duration-500 transform hover:-translate-y-2 overflow-hidden group h-full">
                    {/* Background Image with Gradient Overlay */}
                    <div className="relative h-48 overflow-hidden rounded-t-3xl">
                      <div 
                        className="absolute inset-0 bg-gradient-to-t from-white/90 via-white/50 to-transparent z-10"
                      />
                      {category.imageUrl ? (
                        <img 
                          src={completeImageUrl(category.imageUrl)} 
                          alt={category.name}
                          className="w-full h-full object-cover"
                          onError={(e) => {
                            (e.target as HTMLImageElement).style.display = 'none';
                          }}
                        />
                      ) : (
                        <div className={`w-full h-full ${color} flex items-center justify-center`}>
                          <span className="text-white text-2xl font-bold">
                            {category.name.substring(0, 2)}
                          </span>
                        </div>
                      )}
                    </div>
                    
                    <div className="p-6">
                      <div className="flex items-center justify-between mb-4">
                        <h3 className="text-xl font-bold text-gray-900 line-clamp-1">
                          {category.name}
                        </h3>
                        <span className="text-sm font-bold text-gray-600 bg-gray-100 px-3 py-1 rounded-full whitespace-nowrap">
                          {category.productCount || category.ProductCount || 0} محصول
                        </span>
                      </div>
                      
                      <p className="text-gray-600 mb-5 line-clamp-2 text-sm h-10">
                        {category.description || 'دسته بندی تخصصی قطعات خودرو'}
                      </p>
                      
                      <div className="flex items-center justify-between pt-3 border-t border-gray-100">
                        <Link 
                          to={`/category/${category.id}/${encodeURIComponent(category.name.replace(/\s+/g, '-'))}`}
                          className="text-blue-600 font-bold hover:text-blue-700 flex items-center gap-2 transition-all text-sm"
                        >
                          مشاهده محصولات
                          <svg className="w-4 h-4 rtl:rotate-180 transition-transform group-hover:translate-x-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5l7 7-7 7"></path>
                          </svg>
                        </Link>
                        <span className="text-xs px-3 py-1 bg-gradient-to-r from-amber-500 to-orange-500 text-white font-bold rounded-full">
                          پرفروش
                        </span>
                      </div>
                    </div>
                  </div>
                </SwiperSlide>
              );
            })}
          </Swiper>

          {/* Custom Navigation - Outside of cards */}
          <div className="absolute bottom-4 left-0 right-0 z-10 flex items-center justify-center gap-8 mt-12">
            {/* Previous Button */}
            <button 
              className="custom-prev w-10 h-10 bg-white rounded-full shadow-lg hover:shadow-xl border border-gray-200 hover:border-blue-500 transition-all flex items-center justify-center"
              aria-label="قبلی"
            >
              <svg className="w-5 h-5 text-gray-700 hover:text-blue-600 rtl:rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5l7 7-7 7" />
              </svg>
            </button>

            {/* Pagination Dots */}
            <div className="custom-pagination flex items-center gap-2">
              {/* Dots will be injected here by Swiper */}
            </div>

            {/* Next Button */}
            <button 
              className="custom-next w-10 h-10 bg-white rounded-full shadow-lg hover:shadow-xl border border-gray-200 hover:border-blue-500 transition-all flex items-center justify-center"
              aria-label="بعدی"
            >
              <svg className="w-5 h-5 text-gray-700 hover:text-blue-600 rtl:rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 19l-7-7 7-7" />
              </svg>
            </button>
          </div>

          {/* Custom CSS */}
          <style>
            {`
              .custom-pagination {
                display: flex;
                gap: 8px;
              }
              
              .custom-bullet {
                width: 10px;
                height: 10px;
                background: #d1d5db;
                border-radius: 50%;
                cursor: pointer;
                transition: all 0.3s ease;
                opacity: 0.7;
              }
              
              .custom-bullet:hover {
                background: #9ca3af;
                opacity: 1;
              }
              
              .custom-bullet-active {
                background: #3b82f6;
                opacity: 1;
                transform: scale(1.2);
              }
              
              .custom-prev:hover, .custom-next:hover {
                transform: scale(1.1);
                box-shadow: 0 8px 20px rgba(37, 99, 235, 0.2);
                border-color: #3b82f6;
              }
              
              .swiper-button-disabled {
                opacity: 0.3;
                cursor: not-allowed;
              }
              
              .swiper-button-disabled:hover {
                transform: none;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                border-color: #e5e7eb;
              }
            `}
          </style>
        </div>
      </div>
    </section>
  );
};

export default CategoriesSectionNew;