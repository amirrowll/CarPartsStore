import React, { useEffect, useState } from 'react';
import { Search, ShieldCheck, Truck, Headphones, CheckCircle2, ArrowRight, ArrowLeft, Clock, Sparkles } from 'lucide-react';
import { productApi } from '../services/api';

const steps = [
  {
    stepNumber: '۰۱',
    title: 'جستجوی قطعه یا ثبت لیست',
    description: 'قطعه مورد نظر، کد فنی یا مدل خودرو (سایپا، ایران‌خودرو یا چینی) را جستجو کنید یا لیست درخواستی خود را ثبت نمایید.',
    icon: Search,
    glowColor: 'from-blue-600/20 to-cyan-600/20',
    iconColor: 'text-cyan-400',
    borderColor: 'border-cyan-500/30 hover:border-cyan-400/80',
    stepBadge: 'bg-cyan-500/10 text-cyan-400 border border-cyan-500/30'
  },
  {
    stepNumber: '۰۲',
    title: 'تأیید قیمت عمده و پیش‌فاکتور',
    description: 'کارشناسان فروش پین‌پارت در کمتر از ۲۰ دقیقه با شما تماس گرفته و پیش‌فاکتور رسمی همکاری با کف قیمت بازار را صادر می‌کنند.',
    icon: ShieldCheck,
    glowColor: 'from-amber-600/20 to-orange-600/20',
    iconColor: 'text-amber-400',
    borderColor: 'border-amber-500/30 hover:border-amber-400/80',
    stepBadge: 'bg-amber-500/10 text-amber-400 border border-amber-500/30'
  },
  {
    stepNumber: '۰۳',
    title: 'کنترل کیفی و بسته‌بندی کارتنی',
    description: 'تمامی قطعات، خارها، پیچ و مهره‌ها و سوکت‌ها با استانداردهای فابریک تطابق داده شده و با برچسب بارکد تفکیک می‌گردند.',
    icon: Sparkles,
    glowColor: 'from-emerald-600/20 to-teal-600/20',
    iconColor: 'text-emerald-400',
    borderColor: 'border-emerald-500/30 hover:border-emerald-400/80',
    stepBadge: 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/30'
  },
  {
    stepNumber: '۰۴',
    title: 'ارسال فوری با باربری سراسری',
    description: 'سفارش شما در همان روز به باربری‌های معتبر شوش تحویل داده شده و بیجک باربری جهت پیگیری برای شما ارسال می‌شود.',
    icon: Truck,
    glowColor: 'from-red-600/20 to-rose-600/20',
    iconColor: 'text-red-400',
    borderColor: 'border-red-500/30 hover:border-red-400/80',
    stepBadge: 'bg-red-500/10 text-red-400 border border-red-500/30'
  },
];

const HowItWorks: React.FC = () => {
  const [totalProducts, setTotalProducts] = useState(5000);

  useEffect(() => {
    productApi.getAll({ pageSize: 1 })
      .then((res) => setTotalProducts(res.totalCount || 5200))
      .catch(() => setTotalProducts(5200));
  }, []);

  return (
    <section className="py-24 bg-slate-950 text-slate-100 border-t border-slate-800 relative overflow-hidden" dir="rtl">
      
      {/* Background Ambience */}
      <div className="absolute top-0 right-1/3 w-96 h-96 bg-red-600/5 rounded-full blur-3xl pointer-events-none"></div>
      <div className="absolute bottom-0 left-1/3 w-96 h-96 bg-blue-600/5 rounded-full blur-3xl pointer-events-none"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Section Header */}
        <div className="text-center mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-red-950/60 border border-red-800/80 text-red-400 text-xs font-bold mb-4 uppercase tracking-wider">
            <Clock className="h-3.5 w-3.5" />
            <span>فرآیند تأمین و ارسال سریع</span>
          </div>
          <h2 className="text-3xl sm:text-4xl md:text-5xl font-black text-white tracking-tight">
            چگونه <span className="text-transparent bg-clip-text bg-gradient-to-r from-red-500 via-rose-400 to-amber-400">کار می‌کند؟</span>
          </h2>
          <p className="text-xs sm:text-sm text-slate-400 max-w-2xl mx-auto mt-3 leading-relaxed">
            با ۴ گام شفاف و ساده، ملزومات و قطعات مورد نیاز فروشگاه خود را با کف قیمت بازار چراغ برق تأمین کنید
          </p>
        </div>

        {/* 4 Steps Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 relative">
          {steps.map((step, index) => {
            const Icon = step.icon;
            return (
              <div
                key={index}
                className={`relative bg-slate-900/90 rounded-3xl p-6 sm:p-7 border ${step.borderColor} shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-2 flex flex-col justify-between group overflow-hidden`}
              >
                {/* Glow Backdrop */}
                <div className={`absolute top-0 right-0 w-32 h-32 bg-gradient-to-br ${step.glowColor} rounded-full blur-2xl group-hover:scale-150 transition-all pointer-events-none`}></div>

                <div className="relative z-10">
                  {/* Top Bar with Number & Icon */}
                  <div className="flex items-center justify-between mb-6">
                    <div className={`w-14 h-14 rounded-2xl bg-slate-950 border border-slate-800 flex items-center justify-center ${step.iconColor} shadow-inner group-hover:scale-110 transition-transform`}>
                      <Icon className="h-7 w-7" />
                    </div>
                    <span className={`text-base font-black px-3 py-1 rounded-xl font-mono ${step.stepBadge}`}>
                      {step.stepNumber}
                    </span>
                  </div>

                  <h3 className="text-base sm:text-lg font-bold text-white mb-2 group-hover:text-amber-400 transition-colors">
                    {step.title}
                  </h3>

                  <p className="text-xs text-slate-400 leading-relaxed">
                    {step.description}
                  </p>
                </div>

                <div className="relative z-10 mt-8 pt-4 border-t border-slate-800/80 flex items-center justify-between text-[11px] text-slate-500 font-medium">
                  <span>گام {index + 1} از ۴</span>
                  <div className="flex items-center gap-1 text-slate-400 group-hover:text-red-400 transition-colors">
                    <span>مرحله بعدی</span>
                    <ArrowLeft className="h-3 w-3" />
                  </div>
                </div>
              </div>
            );
          })}
        </div>

        {/* Bottom Fast Stats Counter */}
        <div className="mt-16 bg-gradient-to-r from-slate-950 via-slate-900 to-slate-950 rounded-3xl border border-slate-800 p-8 shadow-2xl">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6 text-center">
            
            <div className="space-y-1">
              <div className="text-2xl sm:text-3xl font-black text-amber-400 font-mono">+{totalProducts.toLocaleString()}</div>
              <div className="text-xs text-slate-400 font-medium">تنوع قطعات و خارجات فعال</div>
            </div>

            <div className="space-y-1">
              <div className="text-2xl sm:text-3xl font-black text-emerald-400 font-mono">۹۹.۴٪</div>
              <div className="text-xs text-slate-400 font-medium">رضایت همکاران و خریداران عمده</div>
            </div>

            <div className="space-y-1">
              <div className="text-2xl sm:text-3xl font-black text-sky-400 font-mono">۲۴ ساعت</div>
              <div className="text-xs text-slate-400 font-medium">تحویل روزانه به باربری شوش</div>
            </div>

            <div className="space-y-1">
              <div className="text-2xl sm:text-3xl font-black text-rose-400 font-mono">۱۵ سال</div>
              <div className="text-xs text-slate-400 font-medium">سابقه تخصصی بازار چراغ برق تهران</div>
            </div>

          </div>
        </div>

      </div>
    </section>
  );
};

export default HowItWorks;