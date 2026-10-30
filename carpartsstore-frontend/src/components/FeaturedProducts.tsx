import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { Sparkles, Phone, FileText, ChevronLeft, ShieldCheck, Tag, Car } from 'lucide-react';
import { useAppContext } from '../context/AppContext';
import CallRequestModal from './CallRequestModal';

const API_BASE = import.meta.env.VITE_API_URL?.replace('/api', '') || 'http://127.0.0.1:5000';

const completeImageUrl = (url: string | undefined): string => {
  if (!url) return '';
  if (url.startsWith('http')) return url;
  if (url.startsWith('/uploads/')) return `${API_BASE}${url}`;
  if (url.startsWith('blob:')) return url;
  return url;
};

const FeaturedProducts: React.FC = () => {
  const { featuredProducts, mostViewedProducts, loading } = useAppContext();
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedProduct, setSelectedProduct] = useState<string | undefined>(undefined);

  const openInquiry = (prodName?: string) => {
    setSelectedProduct(prodName || 'استعلام اقلام ویژه');
    setIsModalOpen(true);
  };

  if (loading) {
    return (
      <section className="py-16 bg-slate-900 border-t border-slate-800">
        <div className="max-w-7xl mx-auto px-4 text-center">
          <div className="w-10 h-10 border-4 border-red-500/20 border-t-red-500 rounded-full animate-spin mx-auto mb-3"></div>
          <div className="text-xs text-slate-400">در حال بارگذاری محصولات پیشنهادی...</div>
        </div>
      </section>
    );
  }

  const productsToDisplay = featuredProducts?.length > 0 ? featuredProducts : mostViewedProducts;

  if (!productsToDisplay || productsToDisplay.length === 0) {
    return null;
  }

  const displayedProducts = productsToDisplay.slice(0, 4);

  return (
    <section className="py-20 bg-slate-900 text-slate-100 border-t border-slate-800 relative overflow-hidden" dir="rtl">
      {/* Background Glow */}
      <div className="absolute top-1/2 right-1/4 w-96 h-96 bg-red-600/5 rounded-full blur-3xl pointer-events-none"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Section Header */}
        <div className="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-12 pb-6 border-b border-slate-800">
          <div>
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-red-950/60 border border-red-800/80 text-red-400 text-xs font-bold mb-3 uppercase tracking-wider">
              <Sparkles className="h-3.5 w-3.5" />
              <span>پخش عمده مستقیم | اقلام پرتقاضای بازار چراغ برق</span>
            </div>
            <h2 className="text-2xl sm:text-3xl md:text-4xl font-black text-white tracking-tight">
              محصولات <span className="text-transparent bg-clip-text bg-gradient-to-r from-red-500 via-rose-400 to-amber-400">پیشنهادی و ویژه</span> پین‌پارت
            </h2>
            <p className="text-xs sm:text-sm text-slate-400 mt-2 max-w-2xl leading-relaxed">
              منتخبی از پرفروش‌ترین خارها، پیچ و مهره‌ها، آرم‌ها و سوکت‌های فابریک با تضمین کف قیمت دست‌اول بازار
            </p>
          </div>

          <div className="flex items-center gap-3">
            <Link
              to="/advanced-search"
              className="inline-flex items-center gap-1.5 px-5 py-2.5 bg-slate-950 hover:bg-slate-800 text-slate-200 hover:text-white border border-slate-700 font-bold text-xs rounded-xl transition shadow-md group"
            >
              <span>مشاهده همه محصولات و کاتالوگ</span>
              <ChevronLeft className="h-4 w-4 group-hover:-translate-x-1 transition-transform" />
            </Link>
          </div>
        </div>

        {/* 4 Cards Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          {displayedProducts.map((product) => {
            const img = completeImageUrl(product.imageUrl);
            return (
              <div
                key={product.id}
                className="group bg-slate-950 rounded-2xl border border-slate-800 hover:border-red-500/60 transition-all duration-300 hover:shadow-2xl hover:-translate-y-1.5 flex flex-col justify-between overflow-hidden"
              >
                <div>
                  {/* Image Container */}
                  <div className="relative aspect-square bg-white p-3 flex items-center justify-center overflow-hidden">
                    <img
                      src={img || 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png'}
                      alt={product.name}
                      loading="lazy"
                      className="w-full h-full object-contain group-hover:scale-105 transition-transform duration-300"
                      onError={(e) => {
                        e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
                      }}
                    />

                    {/* Top Badges */}
                    <div className="absolute top-2.5 right-2.5 z-10 flex flex-col gap-1">
                      <span className="px-2 py-0.5 bg-red-600 text-white text-[10px] font-black rounded-md shadow uppercase tracking-wider">
                        عمده ویژه
                      </span>
                      {product.brand && (
                        <span className="px-2 py-0.5 bg-slate-900 text-slate-200 border border-slate-700 text-[10px] font-medium rounded-md">
                          {product.brand}
                        </span>
                      )}
                    </div>

                    {product.partNumber && (
                      <div className="absolute top-2.5 left-2.5 z-10">
                        <span className="px-2 py-0.5 bg-slate-900/90 text-slate-300 border border-slate-700 text-[10px] font-mono rounded-md">
                          #{product.partNumber}
                        </span>
                      </div>
                    )}

                    <div className="absolute inset-0 bg-gradient-to-t from-slate-950 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-3">
                      <Link
                        to={`/products/${product.id}`}
                        className="w-full py-1.5 bg-slate-900 text-white text-[11px] font-bold rounded-lg text-center border border-slate-700 transition"
                      >
                        مشاهده مشخصات فنی قطعه ←
                      </Link>
                    </div>
                  </div>

                  {/* Body Content */}
                  <div className="p-4 space-y-2">
                    <Link to={`/products/${product.id}`}>
                      <h3 className="font-bold text-white text-sm line-clamp-2 leading-snug group-hover:text-red-400 transition-colors">
                        {product.name}
                      </h3>
                    </Link>

                    {product.description && (
                      <p className="text-xs text-slate-400 line-clamp-2 leading-relaxed">
                        {product.description}
                      </p>
                    )}

                    {product.compatibleCars && (
                      <div className="flex flex-wrap items-center gap-1 pt-1 text-[10px]">
                        <span className="text-slate-500 flex items-center gap-0.5">
                          <Car className="h-3 w-3" />
                          سازگار:
                        </span>
                        {product.compatibleCars.split(',').slice(0, 2).map((c, i) => (
                          <span key={i} className="px-1.5 py-0.5 bg-slate-900 text-slate-300 rounded border border-slate-800">
                            {c.trim()}
                          </span>
                        ))}
                      </div>
                    )}
                  </div>
                </div>

                {/* Bottom Wholesale Actions */}
                <div className="p-4 pt-3 border-t border-slate-800 bg-slate-950/90">
                  <div className="flex items-center justify-between mb-2 text-[11px]">
                    <span className="text-slate-400">قیمت عمده:</span>
                    <span className="text-amber-400 font-bold flex items-center gap-1">
                      <ShieldCheck className="h-3 w-3 text-emerald-400" />
                      <span>استعلام همکاری</span>
                    </span>
                  </div>

                  <div className="grid grid-cols-2 gap-2">
                    <button
                      onClick={() => openInquiry(product.name)}
                      className="w-full py-2 bg-red-600 hover:bg-red-500 text-white text-xs font-bold rounded-xl transition shadow flex items-center justify-center gap-1.5"
                    >
                      <FileText className="h-3.5 w-3.5" />
                      <span>ثبت استعلام</span>
                    </button>
                    <a
                      href="tel:09196408805"
                      className="w-full py-2 bg-slate-900 hover:bg-slate-800 text-slate-300 hover:text-white text-xs font-bold rounded-xl transition border border-slate-800 flex items-center justify-center gap-1 font-mono"
                    >
                      <Phone className="h-3.5 w-3.5" />
                      <span>تماس</span>
                    </a>
                  </div>
                </div>
              </div>
            );
          })}
        </div>

      </div>

      <CallRequestModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        defaultPartName={selectedProduct}
      />
    </section>
  );
};

export default FeaturedProducts;
