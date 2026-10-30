import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { 
  Phone, 
  MapPin, 
  Clock, 
  Send, 
  CheckCircle2, 
  AlertCircle, 
  Building2, 
  Headphones, 
  FileText, 
  Home, 
  ShieldCheck
} from 'lucide-react';
import { WhatsApp, Telegram, Instagram } from '@mui/icons-material';
import api from '../services/api';

const ContactUsPage: React.FC = () => {
  const [formData, setFormData] = useState({
    name: '',
    phoneNumber: '',
    category: '',
    note: ''
  });
  const [submitting, setSubmitting] = useState(false);
  const [submitSuccess, setSubmitSuccess] = useState(false);
  const [submitError, setSubmitError] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitError('');

    const cleanPhone = formData.phoneNumber.trim();
    if (!cleanPhone.match(/^09\d{9}$/)) {
      setSubmitError('لطفاً یک شماره موبایل معتبر ۱۱ رقمی وارد نمایید (مثال: 09123456789)');
      return;
    }

    setSubmitting(true);
    try {
      await api.post('/contact/call-request', {
        name: formData.name.trim() || undefined,
        phoneNumber: cleanPhone,
        category: formData.category || undefined,
        note: formData.note.trim() || undefined
      });

      setSubmitSuccess(true);
      setFormData({ name: '', phoneNumber: '', category: '', note: '' });
      setTimeout(() => setSubmitSuccess(false), 5000);
    } catch (err: any) {
      setSubmitError(
        err.response?.data?.message || 
        'خطا در ثبت اطلاعات. لطفاً مستقیماً با واحد فروش به شماره ۰۹۱۹۶۴۰۸۸۰۵ تماس بگیرید.'
      );
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="min-h-screen bg-slate-900 text-slate-100 pb-20" dir="rtl">
      
      {/* Top Breadcrumb & Header */}
      <div className="bg-slate-950 border-b border-slate-800">
        <div className="container mx-auto px-4 py-8">
          <div className="flex items-center gap-2 text-xs text-slate-400 mb-6">
            <Link to="/" className="hover:text-red-400 transition-colors flex items-center gap-1.5">
              <Home className="h-3.5 w-3.5" />
              <span>صفحه اصلی</span>
            </Link>
            <span className="text-slate-600">/</span>
            <span className="text-red-400 font-semibold">تماس با پین‌پارت و استعلام قیمت</span>
          </div>

          <div className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-red-950/60 border border-red-800/80 text-red-400 text-xs font-bold mb-3">
              <ShieldCheck className="h-3.5 w-3.5" />
              <span>مرکز پخش عمده ملزومات خودرویی چراغ برق تهران</span>
            </div>
            <h1 className="text-3xl md:text-4xl font-black text-white tracking-tight">
              ارتباط مستقیم با دفتر پخش <span className="text-red-500">پین‌پارت</span>
            </h1>
            <p className="text-sm md:text-base text-slate-300 mt-2 leading-relaxed">
              جهت استعلام موجودی عمده، دریافت کاتالوگ و ثبت پیش‌فاکتور ملزومات، پیچ و مهره، خار، آرم و سوکت با ما در تماس باشید.
            </p>
          </div>
        </div>
      </div>

      <div className="container mx-auto px-4 mt-10">
        
        {/* Direct Contacts Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-12">
          
          {/* Card 1: Sales Department */}
          <div className="bg-slate-950 rounded-2xl border border-slate-800 p-6 sm:p-8 hover:border-red-500/50 transition-all duration-300 relative overflow-hidden group shadow-xl">
            <div className="flex items-start gap-4">
              <div className="w-14 h-14 rounded-2xl bg-red-500/10 border border-red-500/30 flex items-center justify-center text-red-500 shrink-0">
                <Headphones className="h-7 w-7" />
              </div>
              <div className="flex-1">
                <div className="flex items-center justify-between">
                  <span className="text-[11px] font-bold text-red-400 uppercase tracking-wider px-2 py-0.5 bg-red-950/80 border border-red-900 rounded-md">
                    پاسخگویی سریع
                  </span>
                  <span className="w-2.5 h-2.5 rounded-full bg-emerald-500 animate-ping"></span>
                </div>
                <h2 className="text-xl font-bold text-white mt-1">واحد فروش و استعلام قیمت عمده</h2>
                <p className="text-xs text-slate-400 mt-1 leading-relaxed">
                  مشاوره فنی، صدور پیش‌فاکتور، استعلام فوری موجودی خار، پیچ و مهره و سوکت
                </p>
              </div>
            </div>

            <div className="mt-6 pt-6 border-t border-slate-800/80 space-y-4">
              <div className="flex items-center justify-between bg-slate-900 p-4 rounded-xl border border-slate-800">
                <div className="text-xs text-slate-400">
                  <span>تلفن مستقیم سفارشات:</span>
                  <div className="text-lg font-black text-white font-mono tracking-wider mt-0.5">۰۹۱۹۶۴۰۸۸۰۵</div>
                </div>
                <a
                  href="tel:09196408805"
                  className="px-5 py-2.5 bg-red-600 hover:bg-red-500 text-white rounded-xl text-xs font-bold transition-all shadow-md flex items-center gap-1.5"
                >
                  <Phone className="h-4 w-4" />
                  <span>تماس فوری</span>
                </a>
              </div>

              <div className="flex flex-wrap gap-2 text-xs">
                <a
                  href="https://t.me/Pinparts1"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex-1 min-w-[120px] py-2 px-3 bg-slate-900 hover:bg-slate-800 text-sky-400 border border-slate-800 hover:border-sky-500/50 rounded-xl transition-all flex items-center justify-center gap-1.5 font-bold"
                >
                  <Telegram className="text-base" />
                  <span>کانال تلگرام</span>
                </a>
                <a
                  href="https://instagram.com/direct/t/pinparts"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex-1 min-w-[120px] py-2 px-3 bg-slate-900 hover:bg-slate-800 text-pink-400 border border-slate-800 hover:border-pink-500/50 rounded-xl transition-all flex items-center justify-center gap-1.5 font-bold"
                >
                  <Instagram className="text-base" />
                  <span>دایرکت اینستاگرام</span>
                </a>
              </div>
            </div>
          </div>

          {/* Card 2: Management */}
          <div className="bg-slate-950 rounded-2xl border border-slate-800 p-6 sm:p-8 hover:border-emerald-500/50 transition-all duration-300 relative overflow-hidden group shadow-xl">
            <div className="flex items-start gap-4">
              <div className="w-14 h-14 rounded-2xl bg-emerald-500/10 border border-emerald-500/30 flex items-center justify-center text-emerald-400 shrink-0">
                <Building2 className="h-7 w-7" />
              </div>
              <div className="flex-1">
                <div className="flex items-center justify-between">
                  <span className="text-[11px] font-bold text-emerald-400 uppercase tracking-wider px-2 py-0.5 bg-emerald-950/80 border border-emerald-900 rounded-md">
                    امور قراردادها
                  </span>
                  <span className="text-xs text-slate-500 font-mono">مدیریت بازرگانی</span>
                </div>
                <h2 className="text-xl font-bold text-white mt-1">مدیریت فروشگاه و امور نمایندگی‌ها</h2>
                <p className="text-xs text-slate-400 mt-1 leading-relaxed">
                  قراردادهای توزیع عمده، همکاری تیراژ بالا، هماهنگی‌های بازرگانی و سازمانی
                </p>
              </div>
            </div>

            <div className="mt-6 pt-6 border-t border-slate-800/80 space-y-4">
              <div className="flex items-center justify-between bg-slate-900 p-4 rounded-xl border border-slate-800">
                <div className="text-xs text-slate-400">
                  <span>تلفن تماس مدیریت:</span>
                  <div className="text-lg font-black text-white font-mono tracking-wider mt-0.5">۰۹۳۰۸۳۶۸۰۸۹</div>
                </div>
                <a
                  href="tel:09308368089"
                  className="px-5 py-2.5 bg-slate-800 hover:bg-slate-700 text-white rounded-xl text-xs font-bold transition-all border border-slate-700 flex items-center gap-1.5"
                >
                  <Phone className="h-4 w-4" />
                  <span>تماس با مدیریت</span>
                </a>
              </div>

              <div className="flex flex-wrap gap-2 text-xs">
                <a
                  href="https://wa.me/989308368089?text=%D8%B3%D9%84%D8%A7%D9%85%D8%8C%20%D8%AC%D9%87%D8%AA%20%D9%87%D9%85%DA%A9%D8%A7%D8%B1%DB%8C%20%D8%B9%D9%85%D8%AF%D9%87%20%D9%88%20%D8%A7%D9%85%D9%88%D8%B1%20%D9%85%D8%AF%DB%8C%D8%B1%DB%8C%D8%AA%DB%8C%20%D9%BE%DB%8C%D9%86%E2%80%8C%D9%BE%D8%A7%D8%B1%D8%AA%20%D9%BE%DB%8C%D8%A7%D9%85%20%D9%85%DB%8C%E2%80%8C%D8%AF%D9%87%D9%85."
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-full py-2.5 px-4 bg-emerald-600/20 hover:bg-emerald-600/30 text-emerald-400 border border-emerald-500/40 rounded-xl transition-all flex items-center justify-center gap-2 font-bold"
                >
                  <WhatsApp className="text-lg" />
                  <span>ارتباط مستقیم در واتساپ مدیریت (۰۹۳۰۸۳۶۸۰۸۹)</span>
                </a>
              </div>
            </div>
          </div>
        </div>

        {/* Lead Capture Form & Physical Store Info */}
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 mb-16">
          
          {/* Form: 7 cols */}
          <div className="lg:col-span-7 bg-slate-950 rounded-2xl border border-slate-800 p-6 sm:p-8 shadow-xl">
            <div className="flex items-center gap-2.5 mb-2">
              <FileText className="h-5 w-5 text-red-500" />
              <h3 className="text-lg font-bold text-white">فرم ثبت درخواست استعلام عمده و پیش‌فاکتور</h3>
            </div>
            <p className="text-xs text-slate-400 mb-6 leading-relaxed">
              مشخصات و لیست اقلام مورد نیاز خود را ثبت کنید؛ همکاران ما در کمتر از ۲۰ دقیقه با شما تماس خواهند گرفت.
            </p>

            {submitSuccess && (
              <div className="mb-6 p-4 rounded-xl bg-emerald-950/80 border border-emerald-800 text-emerald-300 text-xs flex items-center gap-3">
                <CheckCircle2 className="h-5 w-5 shrink-0 text-emerald-400" />
                <div>
                  <span className="font-bold block">درخواست شما با موفقیت ثبت گردید.</span>
                  <span>کارشناسان واحد فروش پین‌پارت به زودی با شماره اعلامی تماس خواهند گرفت.</span>
                </div>
              </div>
            )}

            {submitError && (
              <div className="mb-6 p-4 rounded-xl bg-rose-950/80 border border-rose-800 text-rose-300 text-xs flex items-center gap-3">
                <AlertCircle className="h-5 w-5 shrink-0 text-rose-400" />
                <span>{submitError}</span>
              </div>
            )}

            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-medium text-slate-300 mb-1.5">
                    نام و نام خانوادگی / نام فروشگاه:
                  </label>
                  <input
                    type="text"
                    value={formData.name}
                    onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                    placeholder="مثال: فروشگاه یدک برادران"
                    className="w-full bg-slate-900 border border-slate-700 rounded-xl px-4 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-red-500 transition-all"
                  />
                </div>

                <div>
                  <label className="block text-xs font-medium text-slate-300 mb-1.5">
                    شماره موبایل جهت هماهنگی <span className="text-red-400">*</span>:
                  </label>
                  <input
                    type="tel"
                    required
                    value={formData.phoneNumber}
                    onChange={(e) => setFormData({ ...formData, phoneNumber: e.target.value })}
                    placeholder="09123456789"
                    dir="ltr"
                    className="w-full bg-slate-900 border border-slate-700 rounded-xl px-4 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-red-500 transition-all font-mono text-right"
                  />
                </div>
              </div>

              <div>
                <label className="block text-xs font-medium text-slate-300 mb-1.5">
                  دسته‌بندی یا خانواده خودرو:
                </label>
                <select
                  value={formData.category}
                  onChange={(e) => setFormData({ ...formData, category: e.target.value })}
                  className="w-full bg-slate-900 border border-slate-700 rounded-xl px-4 py-2.5 text-xs text-white focus:outline-none focus:border-red-500 transition-all"
                >
                  <option value="">انتخاب دسته‌بندی قطعه (اختیاری)</option>
                  <option value="خارجات فلزی و پلیمری">خارجات فلزی و پلیمری (خار و بست)</option>
                  <option value="پیچ و مهره خودرویی">پیچ و مهره و واشر خودرویی</option>
                  <option value="آرم و علائم">آرم، مارک و نوشته خودرو</option>
                  <option value="سوکت و سیم‌کشی">سوکت و اتصالات برقی</option>
                  <option value="لوازم سایپا">ملزومات خودروهای سایپا</option>
                  <option value="لوازم ایران‌خودرو">ملزومات خودروهای ایران‌خودرو</option>
                  <option value="لوازم چینی">ملزومات خودروهای چینی</option>
                </select>
              </div>

              <div>
                <label className="block text-xs font-medium text-slate-300 mb-1.5">
                  لیست اقلام یا توضیحات استعلام:
                </label>
                <textarea
                  rows={4}
                  value={formData.note}
                  onChange={(e) => setFormData({ ...formData, note: e.target.value })}
                  placeholder="لطفاً نام قطعه، تعداد حدودی کارتن/بسته یا مدل خودروی مدنظرتان را بنویسید..."
                  className="w-full bg-slate-900 border border-slate-700 rounded-xl px-4 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-red-500 transition-all resize-none"
                ></textarea>
              </div>

              <button
                type="submit"
                disabled={submitting}
                className="w-full py-3 bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white rounded-xl text-xs font-bold transition-all shadow-lg flex items-center justify-center gap-2 disabled:opacity-50"
              >
                {submitting ? (
                  <>
                    <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"></div>
                    <span>در حال ارسال استعلام...</span>
                  </>
                ) : (
                  <>
                    <Send className="h-4 w-4" />
                    <span>ارسال فرم استعلام همکاری و دریافت قیمت</span>
                  </>
                )}
              </button>
            </form>
          </div>

          {/* Physical Address & Details: 5 cols */}
          <div className="lg:col-span-5 space-y-6">
            
            {/* Address Card */}
            <div className="bg-slate-950 rounded-2xl border border-slate-800 p-6 shadow-xl">
              <div className="flex items-center gap-2.5 mb-4 text-amber-400">
                <MapPin className="h-5 w-5" />
                <h3 className="text-base font-bold text-white">آدرس فروشگاه و انبار مرکزی</h3>
              </div>

              <div className="space-y-4 text-xs">
                <div className="bg-slate-900 p-4 rounded-xl border border-slate-800/80 leading-relaxed text-slate-200">
                  <p className="font-bold text-white mb-1">تهران، بازار بزرگ لوازم یدکی (چراغ برق):</p>
                  <p className="text-slate-300">
                    خیابان امیرکبیر، نرسیده به خیابان ملت، پاساژ کوشانپور، طبقه دوم، پلاک ۶۹، پخش پین‌پارت
                  </p>
                </div>

                <div className="flex items-start gap-3 bg-slate-900 p-4 rounded-xl border border-slate-800/80">
                  <Clock className="h-5 w-5 text-slate-400 shrink-0 mt-0.5" />
                  <div className="space-y-1">
                    <p className="font-bold text-white">ساعات کاری و پاسخگویی تلفنی:</p>
                    <p className="text-slate-400">شنبه تا چهارشنبه: ۹:۰۰ صبح الی ۱۸:۰۰ عصر</p>
                    <p className="text-slate-400">پنج‌شنبه‌ها: ۹:۰۰ صبح الی ۱۴:۰۰ ظهر</p>
                    <p className="text-red-400 text-[11px] font-medium pt-1">جمعه‌ها و تعطیلات رسمی: تعطیل</p>
                  </div>
                </div>
              </div>
            </div>

            {/* Shipping & Delivery Badge */}
            <div className="bg-slate-950 rounded-2xl border border-slate-800 p-6 shadow-xl">
              <h4 className="text-xs font-bold text-slate-300 mb-3 flex items-center gap-2">
                <ShieldCheck className="h-4 w-4 text-emerald-400" />
                <span>فرآیند ارسال سفارشات عمده</span>
              </h4>
              <ul className="space-y-2 text-xs text-slate-400">
                <li className="flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-emerald-400"></span>
                  <span>ارسال روزانه از طریق باربری‌های معتبر شوش به سراسر کشور</span>
                </li>
                <li className="flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-emerald-400"></span>
                  <span>امکان ارسال پیک سریع شهری برای همکاران و فروشگاه‌های تهران</span>
                </li>
                <li className="flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-emerald-400"></span>
                  <span>بسته‌بندی مقاوم، تفکیک شده با برچسب مشخصات و بارکد</span>
                </li>
              </ul>
            </div>
          </div>
        </div>

      </div>
    </div>
  );
};

export default ContactUsPage;
