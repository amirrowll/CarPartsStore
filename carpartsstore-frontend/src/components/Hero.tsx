import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { Search, PhoneCall, ShieldCheck, Truck, Layers, Wrench, Shield, Zap, Send, CheckCircle2, ChevronLeft } from 'lucide-react';
import api from '../services/api';
import CallRequestModal from './CallRequestModal';

const Hero: React.FC = () => {
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState('');
  const [leadPhone, setLeadPhone] = useState('');
  const [leadLoading, setLeadLoading] = useState(false);
  const [leadSuccess, setLeadSuccess] = useState(false);
  const [leadError, setLeadError] = useState('');
  const [isModalOpen, setIsModalOpen] = useState(false);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (searchQuery.trim()) {
      navigate('/advanced-search', { 
        state: { initialFilters: { search: searchQuery.trim() } }
      });
    }
  };

  const handleQuickLead = async (e: React.FormEvent) => {
    e.preventDefault();
    setLeadError('');
    const cleanPhone = leadPhone.trim();
    if (!cleanPhone.match(/^09\d{9}$/)) {
      setLeadError('شماره موبایل معتبر ۱۱ رقمی وارد کنید (مثال: 09123456789)');
      return;
    }

    setLeadLoading(true);
    try {
      await api.post('/contact/call-request', {
        phoneNumber: cleanPhone,
        note: 'ثبت سریع از بنر اصلی صفحه اول'
      });
      setLeadSuccess(true);
      setLeadPhone('');
      setTimeout(() => setLeadSuccess(false), 4000);
    } catch (err: any) {
      setLeadError(err.response?.data?.message || 'خطا در ثبت شماره. با پشتیبانی تماس بگیرید.');
    } finally {
      setLeadLoading(false);
    }
  };

  return (
    <section className="relative overflow-hidden bg-slate-950 text-white min-h-[620px] lg:min-h-[680px] flex items-center" dir="rtl">
      {/* Background Hero Image - Bright Hardware Showcase */}
      <div className="absolute inset-0 z-0">
        <img
          src="/hero-banner.jpg"
          alt="تولید و توزیع تمامی خارجات فلزی و پلیمری و پیچ و مهره خودرویی"
          className="w-full h-full object-cover object-center lg:object-right transition-transform duration-700 hover:scale-105"
        />
        {/* Soft elegant gradient: dark on the right for text contrast, clear and bright on the left to show the hardware */}
        <div className="absolute inset-0 bg-gradient-to-l from-slate-950/95 via-slate-950/80 to-slate-950/20"></div>
        <div className="absolute inset-0 bg-gradient-to-t from-slate-950 via-transparent to-slate-950/40"></div>
      </div>

      <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-20 w-full">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-12 items-center">
          
          {/* Right Column: Hero Content & Typography */}
          <div className="lg:col-span-7 space-y-6 text-right">
            
            {/* Top Pill Badge */}
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-slate-900/90 border border-red-500/40 text-red-400 text-xs md:text-sm font-bold shadow-lg backdrop-blur-md">
              <span className="w-2 h-2 rounded-full bg-red-500 animate-ping"></span>
              <span>پین‌پارت | مرجع تخصصی تأمین و پخش عمده ملزومات خودرو</span>
            </div>

            {/* Main Headline with generous line-height and clean distinct hierarchy */}
            <div className="space-y-2 pb-1">
              <h1 className="text-2xl sm:text-3xl md:text-4xl lg:text-4xl xl:text-5xl font-black text-white leading-snug">
                <span className="block text-slate-200 font-extrabold text-lg sm:text-xl md:text-2xl lg:text-3xl mb-1 opacity-90">
                  تولید و پخش عمده
                </span>
                <span className="block text-transparent bg-clip-text bg-gradient-to-r from-red-500 via-rose-400 to-amber-400 py-1 font-black">
                  خارجات ماشین و لوازم یدکی خودرو
                </span>
                <span className="block text-slate-100 text-base sm:text-lg md:text-2xl lg:text-2xl font-bold mt-1 opacity-95">
                  انواع خار و بست، پیچ و مهره، آرم و علائم فابریک چراغ برق
                </span>
              </h1>
            </div>

            {/* Subtitle with breathable spacing */}
            <p className="text-sm sm:text-base md:text-lg text-slate-200 font-normal leading-relaxed max-w-2xl">
              تأمین‌کننده دست‌اول انواع خارجات خودرو، خار و بست پلیمری و فلزی، پیچ و مهره استاندارد و آرم و علائم فابریک برای کلیه محصولات{' '}
              <span className="text-white font-bold underline decoration-amber-400 underline-offset-4">سایپا</span>،{' '}
              <span className="text-white font-bold underline decoration-blue-400 underline-offset-4">ایران خودرو</span> و{' '}
              <span className="text-white font-bold underline decoration-red-400 underline-offset-4">خودروهای چینی</span> در بازار چراغ برق تهران با تضمین کیفیت فابریک و قیمت عمده همکاری
            </p>

            {/* Quick Wholesale Lead Capture Box */}
            <div className="bg-slate-900/90 backdrop-blur-xl border border-slate-700/80 rounded-2xl p-5 shadow-2xl max-w-xl">
              <div className="flex items-center justify-between gap-2 mb-3">
                <div className="flex items-center gap-2">
                  <PhoneCall className="h-4 w-4 text-red-500" />
                  <h3 className="font-bold text-xs sm:text-sm text-white">
                    درخواست سریع تماس و استعلام قیمت عمده
                  </h3>
                </div>
                <span className="text-[11px] text-amber-400 font-medium">پاسخگویی سریع</span>
              </div>
              
              {leadSuccess ? (
                <div className="p-3 bg-emerald-950/80 border border-emerald-500/40 rounded-xl flex items-center gap-2 text-emerald-300 text-xs">
                  <CheckCircle2 className="h-4 w-4 shrink-0 text-emerald-400" />
                  <span>شماره شما با موفقیت ثبت شد! واحد فروش عمده به زودی با شما تماس می‌گیرد.</span>
                </div>
              ) : (
                <form onSubmit={handleQuickLead} className="space-y-2">
                  <div className="flex flex-col sm:flex-row gap-2">
                    <input
                      type="tel"
                      required
                      value={leadPhone}
                      onChange={(e) => setLeadPhone(e.target.value)}
                      placeholder="شماره موبایل شما (مثال: 09123456789)"
                      className="flex-1 px-4 py-3 bg-slate-950/90 border border-slate-700 rounded-xl text-white placeholder-slate-500 text-left dir-ltr font-mono text-xs sm:text-sm focus:outline-none focus:border-red-500 focus:ring-1 focus:ring-red-500 transition-all"
                    />
                    <button
                      type="submit"
                      disabled={leadLoading}
                      className="px-6 py-3 bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white font-bold text-xs sm:text-sm rounded-xl shadow-lg shadow-red-950/60 transition-all flex items-center justify-center gap-2 shrink-0 disabled:opacity-50"
                    >
                      {leadLoading ? (
                        <div className="h-4 w-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                      ) : (
                        <>
                          <Send className="h-4 w-4" />
                          <span>ثبت و استعلام</span>
                        </>
                      )}
                    </button>
                  </div>
                  {leadError && (
                    <p className="text-red-400 text-xs mt-1 text-right">{leadError}</p>
                  )}
                  <p className="text-[11px] text-slate-400 text-right">
                    اطلاعات مستقیماً برای مدیریت واحد پخش عمده ارسال می‌شود.
                  </p>
                </form>
              )}
            </div>

            {/* Live Search Input */}
            <div className="max-w-xl">
              <form onSubmit={handleSearch} className="relative">
                <input
                  type="text"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  placeholder="جستجوی نام یا شماره قطعه (مثلاً: خار پراید، پیچ سرسیلندر، آرم دنا...)"
                  className="w-full pr-11 pl-24 py-3.5 bg-slate-900/80 border border-slate-700/80 rounded-2xl text-xs sm:text-sm text-white placeholder-slate-500 focus:outline-none focus:border-red-500 focus:ring-1 focus:ring-red-500 transition-all backdrop-blur-md"
                />
                <Search className="absolute right-4 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400" />
                <button
                  type="submit"
                  className="absolute left-2 top-1/2 -translate-y-1/2 px-4 py-2 bg-slate-800 hover:bg-slate-700 text-slate-200 hover:text-white text-xs font-bold rounded-xl transition-all border border-slate-600"
                >
                  جستجو
                </button>
              </form>
            </div>
          </div>

          {/* Left Column: Quick Category Access Cards with crisp badges */}
          <div className="lg:col-span-5 flex flex-col justify-center gap-3">
            <Link
              to="/category/10/خارجات"
              className="group p-4 bg-slate-900/80 hover:bg-slate-900 border border-slate-800 hover:border-red-500/60 rounded-2xl transition-all shadow-xl hover:-translate-y-0.5 flex items-center justify-between backdrop-blur-md"
            >
              <div className="flex items-center gap-3.5">
                <div className="w-11 h-11 rounded-xl bg-red-500/10 border border-red-500/30 flex items-center justify-center text-red-400 group-hover:scale-110 transition-transform shrink-0">
                  <Layers className="h-5 w-5" />
                </div>
                <div>
                  <h4 className="font-bold text-white text-sm sm:text-base group-hover:text-red-400 transition-colors">خارجات خودرویی</h4>
                  <p className="text-[11px] text-slate-400 mt-0.5">انواع خار، بست، نگهدارنده و پین‌های پلیمری و فلزی</p>
                </div>
              </div>
              <div className="flex items-center gap-1 text-xs text-red-400 font-bold shrink-0">
                <span>مشاهده</span>
                <ChevronLeft className="h-4 w-4 group-hover:translate-x-[-2px] transition-transform" />
              </div>
            </Link>

            <Link
              to="/category/11/پیچ-و-مهره"
              className="group p-4 bg-slate-900/80 hover:bg-slate-900 border border-slate-800 hover:border-amber-500/60 rounded-2xl transition-all shadow-xl hover:-translate-y-0.5 flex items-center justify-between backdrop-blur-md"
            >
              <div className="flex items-center gap-3.5">
                <div className="w-11 h-11 rounded-xl bg-amber-500/10 border border-amber-500/30 flex items-center justify-center text-amber-400 group-hover:scale-110 transition-transform shrink-0">
                  <Wrench className="h-5 w-5" />
                </div>
                <div>
                  <h4 className="font-bold text-white text-sm sm:text-base group-hover:text-amber-400 transition-colors">پیچ و مهره استاندارد</h4>
                  <p className="text-[11px] text-slate-400 mt-0.5">پیچ‌های سرسیلندر، چرخ، کارتل، مهره و واشرجات فابریک</p>
                </div>
              </div>
              <div className="flex items-center gap-1 text-xs text-amber-400 font-bold shrink-0">
                <span>مشاهده</span>
                <ChevronLeft className="h-4 w-4 group-hover:translate-x-[-2px] transition-transform" />
              </div>
            </Link>

            <Link
              to="/category/12/آرم-و-علائم"
              className="group p-4 bg-slate-900/80 hover:bg-slate-900 border border-slate-800 hover:border-blue-500/60 rounded-2xl transition-all shadow-xl hover:-translate-y-0.5 flex items-center justify-between backdrop-blur-md"
            >
              <div className="flex items-center gap-3.5">
                <div className="w-11 h-11 rounded-xl bg-blue-500/10 border border-blue-500/30 flex items-center justify-center text-blue-400 group-hover:scale-110 transition-transform shrink-0">
                  <Shield className="h-5 w-5" />
                </div>
                <div>
                  <h4 className="font-bold text-white text-sm sm:text-base group-hover:text-blue-400 transition-colors">آرم و علائم فابریک</h4>
                  <p className="text-[11px] text-slate-400 mt-0.5">آرم جلوپنجره، صندوق، نوشته‌های لاتین و فارسی، مارک‌ها</p>
                </div>
              </div>
              <div className="flex items-center gap-1 text-xs text-blue-400 font-bold shrink-0">
                <span>مشاهده</span>
                <ChevronLeft className="h-4 w-4 group-hover:translate-x-[-2px] transition-transform" />
              </div>
            </Link>
          </div>
        </div>

        {/* Bottom Feature Badges Bar - SVG Icons only */}
        <div className="mt-12 pt-8 border-t border-slate-800/80 grid grid-cols-2 md:grid-cols-4 gap-4 text-xs text-slate-300">
          <div className="flex items-center gap-2.5">
            <Truck className="h-4 w-4 text-red-500 shrink-0" />
            <span>ارسال سریع به تمام پایانه‌های باربری کشور</span>
          </div>
          <div className="flex items-center gap-2.5">
            <ShieldCheck className="h-4 w-4 text-emerald-500 shrink-0" />
            <span>تضمین اصالت متریال فلزی و پلیمری</span>
          </div>
          <div className="flex items-center gap-2.5">
            <PhoneCall className="h-4 w-4 text-amber-500 shrink-0" />
            <span>واحد فروش و پشتیبانی: ۰۹۱۹۶۴۰۸۸۰۵</span>
          </div>
          <div className="flex items-center gap-2.5">
            <Layers className="h-4 w-4 text-blue-500 shrink-0" />
            <span>تنوع بیش از ۵,۰۰۰ قلم قطعه فابریک</span>
          </div>
        </div>
      </div>

      <CallRequestModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
      />
    </section>
  );
};

export default Hero;