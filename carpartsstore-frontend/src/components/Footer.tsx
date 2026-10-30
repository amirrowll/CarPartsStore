import { Link } from 'react-router-dom';
import { ShieldCheck, Truck, Headphones, Lock, MapPin, Phone, Mail, Clock, ExternalLink } from 'lucide-react';
import { WhatsApp } from '@mui/icons-material';

const brands = [
  'Bosch', 'Valeo', 'Delphi', 'Denso', 'NGK', 'Mann-Filter',
  'Mahle', 'Febi Bilstein', 'Sachs', 'ZF', 'Brembo', 'Continental'
];

const features = [
  {
    icon: ShieldCheck,
    title: 'کیفیت تضمینی',
    description: 'کلیه محصولات با کیفیت تضمینی و استاندارد کارخانه‌ای'
  },
  {
    icon: Truck,
    title: 'ارسال سریع',
    description: 'ارسال فوری باربری و پست به سراسر کشور در کمتر از ۲۴ ساعت'
  },
  {
    icon: Headphones,
    title: 'پشتیبانی فنی',
    description: 'مشاوره فنی تخصصی و استعلام پیش‌فاکتور توسط کارشناسان'
  },
  {
    icon: Lock,
    title: 'امنیت کامل',
    description: 'اطمینان از اصالت کالا و تضمین بازگشت در صورت مغایرت'
  },
];

const Footer = () => {
  return (
    <footer className="bg-slate-950 text-slate-300 border-t border-slate-800" dir="rtl">
      
      {/* 2. Features Grid */}
      <div className="border-b border-slate-800/80 py-10 bg-slate-900/40">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {features.map((feat, index) => {
              const Icon = feat.icon;
              return (
                <div key={index} className="flex items-start gap-4 p-4 rounded-2xl bg-slate-950/60 border border-slate-800/80">
                  <div className="w-12 h-12 rounded-xl bg-red-600/10 border border-red-500/30 flex items-center justify-center text-red-500 shrink-0">
                    <Icon className="h-6 w-6" />
                  </div>
                  <div>
                    <h4 className="font-bold text-sm text-white mb-1">{feat.title}</h4>
                    <p className="text-xs text-slate-400 leading-relaxed">{feat.description}</p>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>

      {/* 3. Main Footer Content */}
      <div className="py-12 lg:py-16">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-8 lg:gap-12">
            
            {/* About Pinpart */}
            <div className="lg:col-span-4 space-y-4">
              <Link to="/" className="inline-flex items-center gap-3 group">
                <div className="bg-white p-2 rounded-2xl shadow-md border border-slate-700/60 flex items-center justify-center overflow-hidden">
                  <img
                    src="/logo.png"
                    alt="Pinpart Logo"
                    className="h-11 w-auto object-contain rounded-xl"
                  />
                </div>
                <div>
                  <div className="text-xl font-black text-white group-hover:text-red-400 transition-colors">پین‌پارت Store</div>
                  <div className="text-[11px] text-red-400 font-bold">تخصصی‌ترین مرکز پخش عمده لوازم یدکی</div>
                </div>
              </Link>

              <p className="text-xs text-slate-400 leading-relaxed text-justify">
                با بیش از ۱۵ سال تجربه در زمینه تأمین و توزیع لوازم یدکی خودرو، مفتخریم که با ارائه محصولات با کیفیت، همراه مطمئنی برای صاحبان خودروهای چینی، سایپا و ایران خودرو باشیم.
              </p>

              <div className="pt-2 flex items-start gap-2.5 text-xs text-slate-300">
                <MapPin className="h-4 w-4 text-red-500 shrink-0 mt-0.5" />
                <span>تهران، بازار (چراغ برق)، خیابان امیرکبیر، نرسیده به خیابان ملت، پاساژ کوشانپور، طبقه دوم، پلاک ۶۹، پین‌پارت</span>
              </div>
            </div>

            {/* Products Column */}
            <div className="lg:col-span-2 space-y-3">
              <h4 className="text-sm font-bold text-white border-r-2 border-red-600 pr-2">محصولات</h4>
              <ul className="space-y-2 text-xs">
                <li>
                  <Link to="/chinese-parts" className="hover:text-red-400 transition-colors">لوازم یدکی چینی</Link>
                </li>
                <li>
                  <Link to="/saipa-parts" className="hover:text-red-400 transition-colors">لوازم یدکی سایپا</Link>
                </li>
                <li>
                  <Link to="/irankhodro-parts" className="hover:text-red-400 transition-colors">لوازم یدکی ایران خودرو</Link>
                </li>
                <li>
                  <Link to="/products" className="hover:text-red-400 transition-colors font-bold text-slate-200">همه محصولات</Link>
                </li>
              </ul>
            </div>

            {/* Quick Access */}
            <div className="lg:col-span-2 space-y-3">
              <h4 className="text-sm font-bold text-white border-r-2 border-red-600 pr-2">دسترسی</h4>
              <ul className="space-y-2 text-xs">
                <li>
                  <Link to="/admin" className="hover:text-red-400 transition-colors">پنل مدیریت</Link>
                </li>
                <li>
                  <Link to="/contact-us" className="hover:text-red-400 transition-colors">تماس با ما</Link>
                </li>
                <li>
                  <Link to="/contact-us#about" className="hover:text-red-400 transition-colors">درباره ما</Link>
                </li>
                <li>
                  <Link to="/#faq" className="hover:text-red-400 transition-colors">سوالات متداول</Link>
                </li>
              </ul>
            </div>

            {/* Support & Contact */}
            <div className="lg:col-span-2 space-y-3">
              <h4 className="text-sm font-bold text-white border-r-2 border-red-600 pr-2">تماس با ما</h4>
              <ul className="space-y-2 text-xs">
                <li>
                  <Link to="/contact-us" className="hover:text-red-400 transition-colors">ارتباط با پشتیبانی</Link>
                </li>
                <li>
                  <span className="text-slate-400">ساعات کاری: شنبه تا چهارشنبه ۹ الی ۱۸</span>
                </li>
                <li>
                  <a href="tel:09196408805" className="text-red-400 font-bold hover:underline font-mono">
                    واحد فروش و پشتیبانی: ۰۹۱۹۶۴۰۸۸۰۵
                  </a>
                </li>
              </ul>
            </div>

            {/* Management Contact */}
            <div className="lg:col-span-2 space-y-3">
              <h4 className="text-sm font-bold text-white border-r-2 border-red-600 pr-2">تماس با مدیریت</h4>
              <div className="space-y-2.5 text-xs">
                <a
                  href="tel:09308368089"
                  className="flex items-center gap-2 text-slate-200 hover:text-white transition-colors"
                >
                  <Phone className="h-3.5 w-3.5 text-red-500" />
                  <span>تماس: ۰۹۳۰۸۳۶۸۰۸۹</span>
                </a>
                <a
                  href="https://wa.me/989308368089"
                  target="_blank"
                  rel="noreferrer"
                  className="flex items-center gap-2 text-emerald-400 hover:text-emerald-300 transition-colors"
                >
                  <WhatsApp className="!w-4 !h-4 text-emerald-400" />
                  <span>واتساپ مدیریت</span>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* 4. Bottom Copyright */}
      <div className="border-t border-slate-900 py-6 bg-black text-xs text-slate-500">
        <div className="container mx-auto px-4 flex flex-col sm:flex-row items-center justify-between gap-3">
          <div>
            © 2026 Pinpart. تمامی حقوق برای فروشگاه پین‌پارت محفوظ است.
          </div>
          <div className="flex items-center gap-4">
            <Link to="/contact-us" className="hover:text-slate-400 transition-colors">حریم خصوصی</Link>
            <span>•</span>
            <Link to="/contact-us" className="hover:text-slate-400 transition-colors">شرایط و قوانین</Link>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;