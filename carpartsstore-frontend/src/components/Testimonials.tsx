import React from 'react';
import { Star, Quote, CheckCircle2, UserCheck } from 'lucide-react';

const testimonials = [
  {
    id: 1,
    name: 'محمد حسینی',
    role: 'مکانیک خودرو',
    content: 'کیفیت قطعات فوق العادست. به مشتریام همیشه پیشنهاد میدم از این سایت خرید کنن.',
    rating: 5,
    tag: 'تجربه خرید موفق',
  },
  {
    id: 2,
    name: 'فاطمه رضایی',
    role: 'کاربر پراید',
    content: 'برای اولین بار از این سایت خرید کردم و واقعاً راضی بودم. قطعه اصلی و سالم تحویل گرفتم.',
    rating: 5,
    tag: 'تجربه خرید موفق',
  },
  {
    id: 3,
    name: 'علیرضا محمودی',
    role: 'تعمیرکار گیربکس',
    content: 'تنها سایتی که همه قطعات رو توی یکجا داره. تحویل سریع و قیمت مناسب.',
    rating: 5,
    tag: 'تجربه خرید موفق',
  },
];

const Testimonials: React.FC = () => {
  return (
    <section className="py-20 bg-slate-900 text-white border-t border-slate-800" dir="rtl">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        {/* Header */}
        <div className="text-center mb-14">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-red-950/80 border border-red-800/60 text-red-400 text-xs font-bold mb-3">
            <UserCheck className="h-3.5 w-3.5" />
            <span>نظرات همکاران و خریداران عمده</span>
          </div>

          <h2 className="text-2xl sm:text-3xl md:text-4xl font-black text-white tracking-tight mb-3">
            نظرات <span className="text-red-500">مشتریان</span>
          </h2>
          <p className="text-sm md:text-base text-slate-300 max-w-2xl mx-auto leading-relaxed">
            تجربه واقعی کاربران از کیفیت خدمات و محصولات ما
          </p>
        </div>

        {/* Testimonials Cards Grid */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {testimonials.map((t) => (
            <div
              key={t.id}
              className="bg-slate-950/80 rounded-2xl p-6 border border-slate-800 hover:border-slate-700 transition-all duration-300 hover:shadow-xl flex flex-col justify-between"
            >
              <div>
                <div className="flex items-center justify-between mb-4">
                  <div className="flex items-center gap-3">
                    <div className="w-11 h-11 rounded-xl bg-red-600/10 border border-red-500/30 text-red-400 font-black flex items-center justify-center text-sm">
                      {t.name.substring(0, 1)}
                    </div>
                    <div>
                      <h3 className="font-bold text-white text-sm">{t.name}</h3>
                      <p className="text-slate-400 text-xs mt-0.5">{t.role}</p>
                    </div>
                  </div>

                  <Quote className="h-6 w-6 text-slate-700" />
                </div>

                {/* Stars */}
                <div className="flex items-center gap-1 mb-4">
                  {[...Array(t.rating)].map((_, i) => (
                    <Star key={i} className="h-4 w-4 text-amber-400 fill-current" />
                  ))}
                </div>

                <p className="text-xs sm:text-sm text-slate-300 leading-relaxed">
                  "{t.content}"
                </p>
              </div>

              <div className="mt-6 pt-4 border-t border-slate-800/80 flex items-center justify-between text-xs">
                <span className="inline-flex items-center gap-1.5 text-emerald-400 font-medium">
                  <CheckCircle2 className="h-3.5 w-3.5" />
                  <span>{t.tag}</span>
                </span>
                <span className="text-[11px] text-slate-500">خرید تأییدشده</span>
              </div>
            </div>
          ))}
        </div>

        {/* Bottom Overall Rating */}
        <div className="mt-12 text-center">
          <div className="inline-flex items-center gap-4 bg-slate-950/90 border border-slate-800 rounded-2xl px-6 py-4 shadow-xl">
            <div className="text-3xl font-black text-white">۴.۹</div>
            <div className="text-right">
              <div className="flex items-center gap-1 mb-1">
                {[...Array(5)].map((_, i) => (
                  <Star key={i} className="h-4 w-4 text-amber-400 fill-current" />
                ))}
              </div>
              <div className="text-xs text-slate-400">میانگین امتیاز از ۱۲۰+ نظر ثبت‌شده</div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Testimonials;