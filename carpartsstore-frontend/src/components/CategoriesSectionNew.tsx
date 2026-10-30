import React from 'react';
import { Link } from 'react-router-dom';
import { Layers, Wrench, Shield, ArrowLeft, PackageCheck, Truck, FileSpreadsheet } from 'lucide-react';

interface OfficialCategory {
  id: number;
  name: string;
  subtitle: string;
  badge: string;
  icon: React.ReactNode;
  features: string[];
  image: string;
}

const OFFICIAL_CATEGORIES: OfficialCategory[] = [
  {
    id: 10,
    name: 'خارجات',
    subtitle: 'انواع خار، بست، پین، قطعات پلیمری و فلزی فابریک بدنه، درب و موتور',
    badge: 'تولید و تأمین دست‌اول',
    icon: <Layers className="h-5 w-5 text-red-500" />,
    features: ['خار آمپولی، کاپوت، رودری و رکاب', 'بست‌های شلنگ، لوله سوخت و سیم‌کشی', 'پلیمر مهندسی مقاوم در برابر حرارت و شکستگی'],
    image: '/uploads/products/pinpart-1001.jpg',
  },
  {
    id: 11,
    name: 'پیچ و مهره',
    subtitle: 'پیچ، مهره، واشر و اقلام اتصال گرید خودرویی با استاندارد DIN و ISO',
    badge: 'گرید 8.8 و 10.9 فولادی',
    icon: <Wrench className="h-5 w-5 text-amber-500" />,
    features: ['پیچ سرسیلندر، طبق، چرخ و اکسل', 'مهره کاسه‌نمدی، واشر فنری و خورشیدی', 'پوشش گالوانیزه گرم و داکرومات ضدسایش'],
    image: '/uploads/products/pinpart-1211.jpg',
  },
  {
    id: 12,
    name: 'آرم و علائم',
    subtitle: 'انواع آرم، مارک، نوشته و علائم جلوپنجره، صندوق و رینگ چرخ خودرو',
    badge: 'آبکاری کروم متالیک فابریک',
    icon: <Shield className="h-5 w-5 text-blue-500" />,
    features: ['آرم جلوپنجره، صندوق و رینگ چرخ', 'نوشته‌های فابریک برجسته خودروها', 'مقاوم در برابر شستشو، آفتاب و کدرشدگی'],
    image: '/uploads/products/pinpart-1445.jpg',
  },
];

const CategoriesSectionNew: React.FC = () => {
  return (
    <section id="categories-section" className="py-16 md:py-24 bg-slate-900 text-slate-100 relative overflow-hidden border-t border-slate-800">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Section Header */}
        <div className="flex flex-col items-center text-center mb-14">
          <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-red-950/80 border border-red-800/60 text-red-400 text-xs font-bold mb-3 uppercase tracking-wider">
            <span className="w-2 h-2 rounded-full bg-red-500"></span>
            تولید و تأمین عمده ملزومات خودرویی
          </div>

          <h2 className="text-2xl sm:text-3xl md:text-4xl font-black text-white tracking-tight mb-3">
            دسته‌بندی‌های تخصصی <span className="text-transparent bg-clip-text bg-gradient-to-r from-red-500 to-rose-400">پین‌پارت</span>
          </h2>
          <p className="text-xs sm:text-sm md:text-base text-slate-300 max-w-2xl leading-relaxed">
            فروش منحصراً عمده ۳ رسته اصلی قطعات خودرویی به قیمت همکاری، بدون واسطه و ارسال فوری به سراسر کشور
          </p>
        </div>

        {/* 3 Cards Grid - Bright, Clean & High Definition */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {OFFICIAL_CATEGORIES.map((cat) => (
            <div
              key={cat.id}
              className="group relative bg-slate-950/90 rounded-2xl border border-slate-800 hover:border-red-500/60 transition-all duration-300 hover:shadow-2xl hover:shadow-red-950/40 flex flex-col justify-between overflow-hidden"
            >
              {/* Visual Header with Clear Bright Image */}
              <div className="relative h-48 overflow-hidden bg-white flex items-center justify-center p-2">
                <img
                  src={cat.image}
                  alt={cat.name}
                  className="w-full h-full object-contain group-hover:scale-105 transition-transform duration-500"
                  loading="lazy"
                  onError={(e) => {
                    // Fallback to placeholder if upload not cached yet
                    e.currentTarget.src = cat.id === 10 ? '/uploads/categories/kharejat.jpg' : cat.id === 11 ? '/uploads/categories/pich-mohre.jpg' : '/uploads/categories/arm.jpg';
                  }}
                />

                {/* Top Badge */}
                <div className="absolute top-3 right-3 flex items-center gap-1.5 px-2.5 py-1 bg-slate-950/90 backdrop-blur-md border border-slate-700 rounded-lg text-[11px] font-bold text-slate-200 shadow-md">
                  {cat.icon}
                  <span>{cat.badge}</span>
                </div>
              </div>

              {/* Body Content */}
              <div className="p-5 flex-1 flex flex-col justify-between space-y-4 bg-slate-900/90">
                <div>
                  <Link
                    to={`/category/${cat.id}/${encodeURIComponent(cat.name)}`}
                    className="group/title block"
                  >
                    <h3 className="text-xl font-black text-white group-hover/title:text-red-400 transition-colors flex items-center justify-between">
                      <span>{cat.name}</span>
                      <ArrowLeft className="h-4 w-4 text-slate-500 group-hover/title:translate-x-[-4px] transition-transform" />
                    </h3>
                  </Link>
                  <p className="text-xs text-slate-300 mt-2 leading-relaxed">
                    {cat.subtitle}
                  </p>

                  {/* Features List */}
                  <div className="mt-4 pt-3 border-t border-slate-800 space-y-2">
                    {cat.features.map((feat, i) => (
                      <div key={i} className="flex items-start gap-2 text-[11px] text-slate-300">
                        <span className="w-1.5 h-1.5 rounded-full bg-red-500 mt-1 shrink-0"></span>
                        <span className="line-clamp-1">{feat}</span>
                      </div>
                    ))}
                  </div>
                </div>

                {/* Car Brand Filter Direct Links */}
                <div className="pt-3 border-t border-slate-800">
                  <div className="text-[10px] text-slate-400 font-bold mb-2">فیلتر برند خودرو:</div>
                  <div className="grid grid-cols-3 gap-1.5">
                    <Link
                      to={`/category/${cat.id}/${encodeURIComponent(cat.name)}?brand=saipa`}
                      className="py-1.5 px-1 bg-slate-950 hover:bg-red-600/20 text-slate-300 hover:text-white border border-slate-800 hover:border-red-500/50 rounded-lg text-[10px] font-bold text-center transition-all"
                    >
                      سایپا
                    </Link>
                    <Link
                      to={`/category/${cat.id}/${encodeURIComponent(cat.name)}?brand=irankhodro`}
                      className="py-1.5 px-1 bg-slate-950 hover:bg-red-600/20 text-slate-300 hover:text-white border border-slate-800 hover:border-red-500/50 rounded-lg text-[10px] font-bold text-center transition-all"
                    >
                      ایران‌خودرو
                    </Link>
                    <Link
                      to={`/category/${cat.id}/${encodeURIComponent(cat.name)}?brand=chinese`}
                      className="py-1.5 px-1 bg-slate-950 hover:bg-red-600/20 text-slate-300 hover:text-white border border-slate-800 hover:border-red-500/50 rounded-lg text-[10px] font-bold text-center transition-all"
                    >
                      چینی
                    </Link>
                  </div>

                  {/* Main Category Action */}
                  <Link
                    to={`/category/${cat.id}/${encodeURIComponent(cat.name)}`}
                    className="mt-3.5 w-full py-2.5 bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white rounded-xl text-xs font-bold transition-all shadow-md shadow-red-950/50 flex items-center justify-center gap-1.5"
                  >
                    <span>مشاهده کاتالوگ عمده {cat.name}</span>
                    <ArrowLeft className="h-3.5 w-3.5" />
                  </Link>
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* 3 Service Highlights with SVG Icons */}
        <div className="mt-16 grid grid-cols-1 sm:grid-cols-3 gap-6 pt-10 border-t border-slate-800 text-center">
          <div className="p-5 rounded-2xl bg-slate-950/60 border border-slate-800 flex flex-col items-center">
            <div className="w-12 h-12 rounded-xl bg-red-500/10 text-red-400 flex items-center justify-center mb-3">
              <PackageCheck className="h-6 w-6" />
            </div>
            <h4 className="text-sm font-bold text-white mb-1">بسته‌بندی استاندارد صادراتی</h4>
            <p className="text-xs text-slate-400">بسته‌بندی کارتنی و سلفونی مقاوم مناسب قفسه‌بندی فروشگاهی</p>
          </div>

          <div className="p-5 rounded-2xl bg-slate-950/60 border border-slate-800 flex flex-col items-center">
            <div className="w-12 h-12 rounded-xl bg-amber-500/10 text-amber-400 flex items-center justify-center mb-3">
              <Truck className="h-6 w-6" />
            </div>
            <h4 className="text-sm font-bold text-white mb-1">توزیع سراسری روزانه</h4>
            <p className="text-xs text-slate-400">ارسال بار به تمامی پایانه‌های باربری و دفاتر پستی تهران و شهرستان‌ها</p>
          </div>

          <div className="p-5 rounded-2xl bg-slate-950/60 border border-slate-800 flex flex-col items-center">
            <div className="w-12 h-12 rounded-xl bg-blue-500/10 text-blue-400 flex items-center justify-center mb-3">
              <FileSpreadsheet className="h-6 w-6" />
            </div>
            <h4 className="text-sm font-bold text-white mb-1">صدور پیش‌فاکتور رسمی</h4>
            <p className="text-xs text-slate-400">امکان ثبت فاکتور شرکتی و همکاری برای فروشگاه‌ها و تعمیرگاه‌ها</p>
          </div>
        </div>
      </div>
    </section>
  );
};

export default CategoriesSectionNew;