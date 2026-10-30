import React from 'react';
import { Link } from 'react-router-dom';
import { 
  Layers, 
  Wrench, 
  Zap, 
  ShieldCheck, 
  Truck, 
  Tag, 
  CheckCircle2, 
  ChevronLeft, 
  BookOpen, 
  Sparkles,
  Store,
  PhoneCall
} from 'lucide-react';

const KEYWORD_TAGS = [
  { label: 'خارجات ماشین', path: '/products' },
  { label: 'لوازم یدکی خودرو', path: '/products' },
  { label: 'خرید عمده خارجات خودرو', path: '/products' },
  { label: 'پخش عمده لوازم یدکی چراغ برق', path: '/contact-us' },
  { label: 'انواع خار و بست ماشین', path: '/products' },
  { label: 'خار تودری پژو و پراید', path: '/products' },
  { label: 'خار آمپولی و فشاری', path: '/products' },
  { label: 'خار شلگیر و سپر', path: '/products' },
  { label: 'پیچ و مهره خودرویی', path: '/products' },
  { label: 'خار مهره استاندارد', path: '/products' },
  { label: 'سوکت و سیم‌کشی ماشین', path: '/products' },
  { label: 'لوازم یدکی ایران خودرو', path: '/irankhodro-parts' },
  { label: 'خارجات پژو ۲۰۶ و ۴۰۵ و پارس', path: '/irankhodro-parts' },
  { label: 'لوازم یدکی سایپا', path: '/saipa-parts' },
  { label: 'خار و لوازم پراید، تیبا و کوییک', path: '/saipa-parts' },
  { label: 'لوازم یدکی خودروهای چینی', path: '/chinese-parts' },
  { label: 'خار ماشین‌های چینی (MVM و جک)', path: '/chinese-parts' },
  { label: 'استعلام قیمت عمده همکار', path: '/contact-us' },
];

const SeoKnowledgeSection: React.FC = () => {
  return (
    <section className="bg-slate-950 py-16 sm:py-20 border-t border-slate-800/80 text-slate-100" dir="rtl">
      <div className="container mx-auto px-4 max-w-7xl">
        
        {/* Top Header Badge */}
        <div className="text-center max-w-3xl mx-auto mb-12 sm:mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-red-950/70 border border-red-700/60 text-red-400 text-xs sm:text-sm font-bold mb-4 shadow-lg">
            <BookOpen className="h-4 w-4" />
            <span>دانشنامه و راهنمای تخصصی بازار قطعات</span>
          </div>
          <h2 className="text-2xl sm:text-3xl md:text-4xl font-black text-white tracking-tight leading-snug">
            مرجع تخصصی خارجات ماشین و پخش عمده لوازم یدکی خودرو
          </h2>
          <p className="text-xs sm:text-sm md:text-base text-slate-300 mt-3 leading-relaxed">
            تامین دست‌اول انواع خار، بست پلیمری و فلزی، پیچ و مهره استاندارد و سوکت‌های خودرویی در بازار چراغ برق تهران (امیرکبیر) با قیمت کارخانه
          </p>
        </div>

        {/* 4 Pillars Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 lg:gap-8 mb-12">
          
          {/* Card 1: خارجات ماشین */}
          <article className="bg-slate-900/80 border border-slate-800 rounded-2xl p-6 sm:p-8 hover:border-red-500/40 transition-all duration-300 shadow-xl flex flex-col justify-between">
            <div>
              <div className="flex items-center gap-3 mb-4">
                <div className="w-12 h-12 rounded-xl bg-red-600/10 border border-red-500/30 flex items-center justify-center text-red-400">
                  <Layers className="h-6 w-6" />
                </div>
                <div>
                  <h3 className="text-lg sm:text-xl font-bold text-white">
                    خارجات ماشین چیست و چه قطعاتی را شامل می‌شود؟
                  </h3>
                  <span className="text-xs text-red-400 font-medium">اتصالات پلیمری و فنری بدنه و تریم خودرو</span>
                </div>
              </div>
              <p className="text-xs sm:text-sm text-slate-300 leading-relaxed mb-4">
                اصطلاح <strong className="text-white">خارجات ماشین</strong> در بازار چراغ برق و صنعت خودروسازی به کلیه خارها، بست‌ها، پین‌ها، کلیپس‌ها و اتصالات ریز اطلاق می‌شود که برای مهار و نصب قطعات تریم داخلی و بدنه خودرو کاربرد دارند. این قطعات علیرغم ابعاد کوچک، نقش حیاتی در جلوگیری از لرزش، صداگیری کابین و تثبیت قطعات دارند.
              </p>
              <ul className="space-y-2 text-xs sm:text-sm text-slate-300">
                <li className="flex items-start gap-2">
                  <CheckCircle2 className="h-4 w-4 text-red-500 shrink-0 mt-0.5" />
                  <span><strong>خار تودری و رودری:</strong> جهت نصب پنل‌های در، مهار دستگیره و کلید شیشه‌بالابر</span>
                </li>
                <li className="flex items-start gap-2">
                  <CheckCircle2 className="h-4 w-4 text-red-500 shrink-0 mt-0.5" />
                  <span><strong>خار آمپولی و خار فشاری:</strong> پرکاربردترین بست پلاستیکی سپر، جلوپنجره و رکاب</span>
                </li>
                <li className="flex items-start gap-2">
                  <CheckCircle2 className="h-4 w-4 text-red-500 shrink-0 mt-0.5" />
                  <span><strong>خار شلگیر و نمد کاپوت:</strong> خارهای مقاوم در برابر حرارت موتور و رطوبت زیر چرخ‌ها</span>
                </li>
              </ul>
            </div>
            <div className="mt-6 pt-4 border-t border-slate-800 flex items-center justify-between">
              <span className="text-xs text-slate-400">مناسب ایران‌خودرو، سایپا و خودروهای چینی</span>
              <Link to="/products" className="inline-flex items-center gap-1 text-xs font-bold text-red-400 hover:text-red-300">
                <span>مشاهده کاتالوگ خارجات</span>
                <ChevronLeft className="h-4 w-4" />
              </Link>
            </div>
          </article>

          {/* Card 2: پخش عمده لوازم یدکی در چراغ برق */}
          <article className="bg-slate-900/80 border border-slate-800 rounded-2xl p-6 sm:p-8 hover:border-red-500/40 transition-all duration-300 shadow-xl flex flex-col justify-between">
            <div>
              <div className="flex items-center gap-3 mb-4">
                <div className="w-12 h-12 rounded-xl bg-amber-600/10 border border-amber-500/30 flex items-center justify-center text-amber-400">
                  <Store className="h-6 w-6" />
                </div>
                <div>
                  <h3 className="text-lg sm:text-xl font-bold text-white">
                    پخش عمده لوازم یدکی خودرو در بازار چراغ برق تهران
                  </h3>
                  <span className="text-xs text-amber-400 font-medium">تامین دست‌اول فروشگاه‌های یدکی سراسر کشور</span>
                </div>
              </div>
              <p className="text-xs sm:text-sm text-slate-300 leading-relaxed mb-4">
                بازار خیابان امیرکبیر و چراغ برق تهران قطب سنتی و اصلی توزیع <strong className="text-white">لوازم یدکی خودرو</strong> در ایران است. پین‌پارت با حذف کامل واسطه‌ها، امکان خرید عمده کارتنی و مستقیم قطعات یدکی ریز و ملزومات مونتاژ را با قیمت رقابتی برای همکاران شهرستان‌ها فراهم ساخته است.
              </p>
              <ul className="space-y-2 text-xs sm:text-sm text-slate-300">
                <li className="flex items-start gap-2">
                  <CheckCircle2 className="h-4 w-4 text-amber-500 shrink-0 mt-0.5" />
                  <span><strong>قیمت رقابتی دست‌اول:</strong> تامین با کمترین حاشیه سود برای فروشگاه‌های یدکی و صنف صافکاری و نقاشی</span>
                </li>
                <li className="flex items-start gap-2">
                  <CheckCircle2 className="h-4 w-4 text-amber-500 shrink-0 mt-0.5" />
                  <span><strong>بسته‌بندی استاندارد تیراژ:</strong> بسته‌های مشخص با بارکد و لیبل رسمی جهت انبارداری آسان</span>
                </li>
                <li className="flex items-start gap-2">
                  <CheckCircle2 className="h-4 w-4 text-amber-500 shrink-0 mt-0.5" />
                  <span><strong>ارسال سریع باربری:</strong> ارسال سفارش‌های عمده به سراسر کشور در سریع‌ترین زمان کاری</span>
                </li>
              </ul>
            </div>
            <div className="mt-6 pt-4 border-t border-slate-800 flex items-center justify-between">
              <span className="text-xs text-slate-400">فروش ۱۰۰٪ انحصاری عمده و همکاری</span>
              <Link to="/contact-us" className="inline-flex items-center gap-1 text-xs font-bold text-amber-400 hover:text-amber-300">
                <span>استعلام قیمت همکار</span>
                <ChevronLeft className="h-4 w-4" />
              </Link>
            </div>
          </article>

          {/* Card 3: پیچ و مهره خودرویی */}
          <article className="bg-slate-900/80 border border-slate-800 rounded-2xl p-6 sm:p-8 hover:border-red-500/40 transition-all duration-300 shadow-xl flex flex-col justify-between">
            <div>
              <div className="flex items-center gap-3 mb-4">
                <div className="w-12 h-12 rounded-xl bg-blue-600/10 border border-blue-500/30 flex items-center justify-center text-blue-400">
                  <Wrench className="h-6 w-6" />
                </div>
                <div>
                  <h3 className="text-lg sm:text-xl font-bold text-white">
                    پیچ و مهره، خار مهره و واشرجات استاندارد خودرو
                  </h3>
                  <span className="text-xs text-blue-400 font-medium">سخت‌کاری استاندارد و مقاومت در برابر لرزش</span>
                </div>
              </div>
              <p className="text-xs sm:text-sm text-slate-300 leading-relaxed mb-4">
                اتصالات فلزی خودرویی از قبیل انواع پیچ خودکار، پیچ آلن، پیچ‌های اتاقی و شاسی، مهره‌های قفلی، خار مهره‌های فلزی گلگیر و واشرجات استاندارد باید از متریال با کیفیت و آبکاری ضدزنگ تولید شوند تا در طول کارکرد موتور دچار هرزشدگی یا شکست نشوند.
              </p>
              <ul className="space-y-2 text-xs sm:text-sm text-slate-300">
                <li className="flex items-start gap-2">
                  <CheckCircle2 className="h-4 w-4 text-blue-500 shrink-0 mt-0.5" />
                  <span><strong>خار مهره‌های فلزی:</strong> مهره‌های کلیپسی مخصوص اتصال سپرهای جلو و عقب و گلگیر</span>
                </li>
                <li className="flex items-start gap-2">
                  <CheckCircle2 className="h-4 w-4 text-blue-500 shrink-0 mt-0.5" />
                  <span><strong>پیچ‌های مخصوص بدنه:</strong> پیچ‌های سرپهن، واشردار و خودکار فابریک کارخانه‌ای</span>
                </li>
              </ul>
            </div>
            <div className="mt-6 pt-4 border-t border-slate-800 flex items-center justify-between">
              <span className="text-xs text-slate-400">گرید فولادی و آبکاری داکرومات/گالوانیزه</span>
              <Link to="/products" className="inline-flex items-center gap-1 text-xs font-bold text-blue-400 hover:text-blue-300">
                <span>مشاهده پیچ و مهره خودرو</span>
                <ChevronLeft className="h-4 w-4" />
              </Link>
            </div>
          </article>

          {/* Card 4: سوکت و اتصالات برقی */}
          <article className="bg-slate-900/80 border border-slate-800 rounded-2xl p-6 sm:p-8 hover:border-red-500/40 transition-all duration-300 shadow-xl flex flex-col justify-between">
            <div>
              <div className="flex items-center gap-3 mb-4">
                <div className="w-12 h-12 rounded-xl bg-purple-600/10 border border-purple-500/30 flex items-center justify-center text-purple-400">
                  <Zap className="h-6 w-6" />
                </div>
                <div>
                  <h3 className="text-lg sm:text-xl font-bold text-white">
                    سوکت و کانکتورهای سیم‌کشی برق فابریک ماشین
                  </h3>
                  <span className="text-xs text-purple-400 font-medium">سرسیم‌های برنجی درجه یک با مقاومت در برابر حرارت</span>
                </div>
              </div>
              <p className="text-xs sm:text-sm text-slate-300 leading-relaxed mb-4">
                خرابی سوکت‌ها و کانکتورهای برقی یکی از شایع‌ترین علل ایرادات برقی و خطاهای ایسیو در خودروها است. پین‌پارت انواع سوکت‌های چراغ جلو و عقب، سوکت کوئیل، سوکت فن، سنسور اکسیژن و فشنگی را با سیم‌های خودرویی نسوز استاندارد تامین می‌کند.
              </p>
              <ul className="space-y-2 text-xs sm:text-sm text-slate-300">
                <li className="flex items-start gap-2">
                  <CheckCircle2 className="h-4 w-4 text-purple-500 shrink-0 mt-0.5" />
                  <span><strong>عایق‌بندی ضدآب و گردوغبار:</strong> دارای لاستیک‌های آب‌بند و خارهای ضامن قفل‌شونده</span>
                </li>
                <li className="flex items-start gap-2">
                  <CheckCircle2 className="h-4 w-4 text-purple-500 shrink-0 mt-0.5" />
                  <span><strong>تنوع کامل:</strong> پوشش کامل سوکت‌های پژو، پراید، سمند، ۲۰۶، دنا و چینی</span>
                </li>
              </ul>
            </div>
            <div className="mt-6 pt-4 border-t border-slate-800 flex items-center justify-between">
              <span className="text-xs text-slate-400">تضمین اتصال بدون افت ولتاژ</span>
              <Link to="/products" className="inline-flex items-center gap-1 text-xs font-bold text-purple-400 hover:text-purple-300">
                <span>مشاهده سوکت‌های خودرو</span>
                <ChevronLeft className="h-4 w-4" />
              </Link>
            </div>
          </article>

        </div>

        {/* Quick Keyword Navigation Chips (High SEO Impact Internal Links) */}
        <div className="bg-slate-900/50 border border-slate-800 rounded-2xl p-6 sm:p-8">
          <div className="flex items-center gap-2 mb-4 text-slate-200">
            <Tag className="h-4 w-4 text-red-500" />
            <h4 className="text-sm sm:text-base font-bold text-white">
              کلمات کلیدی پرتکرار و دسترسی سریع به قطعات یدکی و خارجات ماشین:
            </h4>
          </div>
          <div className="flex flex-wrap gap-2 sm:gap-2.5">
            {KEYWORD_TAGS.map((tag, idx) => (
              <Link
                key={idx}
                to={tag.path}
                className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-slate-800/80 hover:bg-red-600/20 border border-slate-700/80 hover:border-red-500/50 text-slate-300 hover:text-white text-xs sm:text-sm transition-all duration-200"
              >
                <span>#</span>
                <span>{tag.label}</span>
              </Link>
            ))}
          </div>
        </div>

      </div>
    </section>
  );
};

export default SeoKnowledgeSection;
