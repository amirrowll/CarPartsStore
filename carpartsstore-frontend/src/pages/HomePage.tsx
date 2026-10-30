import React, { useState } from 'react';
import Hero from '../components/Hero';
import CategoriesSectionNew from '../components/CategoriesSectionNew';
import FeaturedProducts from '../components/FeaturedProducts';
import HowItWorks from '../components/HowItWorks';
import Testimonials from '../components/Testimonials';
import StoriesSection from '../components/StoriesSection';
import SeoKnowledgeSection from '../components/SeoKnowledgeSection';
import SEO from '../components/SEO';
import { SEO_CONFIG } from '../utils/seoConfig';
import { ChevronDown, HelpCircle, PhoneCall, ShieldCheck } from 'lucide-react';
import { WhatsApp } from '@mui/icons-material';

const FAQS = [
  {
    q: '۱) لیست قیمت اجناس شرکت را میخواستم؟',
    a: 'به دلیل نوسانات بازار، تنوع بالای اقلام و محاسبه تخفیفات بر اساس حجم خرید، لیست قیمت ثابت به صورت عمومی درج نمی‌شود. در عوض، بخش اختصاصی استعلام قیمت آنلاین و تلفنی راه‌اندازی شده است تا همکاران گرامی با ثبت فرم استعلام یا تماس مستقیم با کارشناسان فروش (۰۹۱۹۶۴۰۸۸۰۵)، قیمت روز دست‌اول بازار چراغ برق و پیش‌فاکتور همکاری دریافت نمایند.'
  },
  {
    q: '۲) جشنواره‌های فروش و تخفیف‌های شرکت به چه صورت می‌باشد؟',
    a: 'شرکت پین‌پارت در طول سال با ارائه طرح‌های فروش ویژه فصلی و تخفیفات پله‌ای بر اساس حجم سفارش برای فروشگاه‌ها و همکاران عمده، شرایط پرداخت و تخفیف‌های ویژه نقدی و اعتباری در نظر می‌گیرد. برای اطلاع از جشنواره‌ها و شرایط ویژه می‌توانید با واحد فروش در ارتباط باشید.'
  },
  {
    q: '۳) تعداد اجناس در بسته‌بندی‌ها به چه اندازه می‌باشد؟',
    a: 'تعداد قطعات در هر بسته و کارتن متناسب با نوع جنس (انواع خار، بست، پیچ و مهره، آرم یا سوکت) استانداردسازی شده و جهت سهولت انبارداری به بهینه‌ترین تعداد رسانده شده است. برچسب مشخصات، بارکد و تیراژ بر روی تمامی بسته‌ها و کارتن‌ها درج شده است.'
  },
  {
    q: '۴) شرایط گرفتن نمایندگی و عاملیت پخش به چه طریقی می‌باشد؟',
    a: 'جهت دریافت شرایط نمایندگی انحصاری یا عاملیت توزیع عمده در مراکز استان‌ها و شهرستان‌ها، لطفاً مشخصات کامل فروشگاه، سابقه فعالیت و شهر خود را مستقیماً به واتساپ مدیریت بازرگانی ارسال فرمایید: ۰۹۳۰۸۳۶۸۰۸۹'
  },
  {
    q: '۵) فروش شرکت به چه صورت است؛ عمده یا خرده؟',
    a: 'شرکت پین‌پارت منحصراً و ۱۰۰٪ به صورت فروش عمده، کارتنی و تیراژ همکاری فعالیت می‌کند و به فروشگاه‌های لوازم یدکی، نمایندگی‌ها، باطری‌سازان و همکاران پخش در سراسر کشور خدمات می‌دهد. هیچ‌گونه خرده‌فروشی یا فروش تکی در این مجموعه انجام نمی‌شود.'
  },
  {
    q: '۶) تضمین بهترین کیفیت و اصالت قطعات به چه معناست؟',
    a: 'جلب رضایت مشتری از اصلی‌ترین اهداف شرکت پین‌پارت می‌باشد. تمامی اجناس تولیدی و وارداتی با استانداردهای فابریک خط تولید خودرو مطابقت داده شده و با تضمین کیفیت ابعادی و مهلت تست فنی ارائه می‌شوند. در صورت هرگونه مغایرت فنی، تعویض یا عودت بار برای مشتریان گرامی تضمین شده است.'
  }
];

const HomePage: React.FC = () => {
  const seoConfig = SEO_CONFIG.home;
  const [openIndex, setOpenIndex] = useState<number | null>(0);

  const toggleFaq = (index: number) => {
    setOpenIndex(openIndex === index ? null : index);
  };

  // Structured Data for Google FAQPage
  const faqSchema = {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: FAQS.map((faq) => ({
      '@type': 'Question',
      name: faq.q,
      acceptedAnswer: {
        '@type': 'Answer',
        text: faq.a
      }
    }))
  };

  return (
    <div className="min-h-screen">
      <SEO 
        title={seoConfig.title}
        description={seoConfig.description}
        keywords={seoConfig.keywords}
        structuredData={[seoConfig.structuredData(), faqSchema]}
      />
      
      {/* Stories Section at the top */}
      <StoriesSection position="top" />
      
      <Hero />
      <CategoriesSectionNew />
      <FeaturedProducts />
      <HowItWorks />
      <Testimonials />
      
      {/* Comprehensive SEO Knowledge & Wholesale Guide Section */}
      <SeoKnowledgeSection />

      {/* Interactive FAQ Section */}
      <section className="bg-slate-950 py-16 border-t border-slate-800 text-slate-100" dir="rtl">
        <div className="container mx-auto px-4 max-w-4xl">
          <div className="text-center mb-10">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-red-950/60 border border-red-800/80 text-red-400 text-xs font-bold mb-3">
              <HelpCircle className="h-4 w-4" />
              <span>پاسخ به پرسش‌های همکاران و خریداران عمده</span>
            </div>
            <h2 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
              سوالات متداول همکاران
            </h2>
            <p className="text-xs sm:text-sm text-slate-400 mt-2">
              پاسخ به مهم‌ترین پرسش‌های مربوط به قیمت‌گذاری، بسته‌بندی، نحوه سفارش عمده و نمایندگی
            </p>
          </div>

          <div className="space-y-3.5">
            {FAQS.map((faq, index) => {
              const isOpen = openIndex === index;
              return (
                <div
                  key={index}
                  className={`rounded-2xl border transition-all duration-200 overflow-hidden ${
                    isOpen 
                      ? 'bg-slate-900 border-red-500/50 shadow-lg' 
                      : 'bg-slate-900/60 border-slate-800 hover:border-slate-700'
                  }`}
                >
                  <button
                    onClick={() => toggleFaq(index)}
                    className="w-full p-4 sm:p-5 text-right flex items-center justify-between gap-4 font-bold text-sm sm:text-base text-white hover:text-red-400 transition-colors"
                  >
                    <span className="leading-snug">{faq.q}</span>
                    <ChevronDown
                      className={`h-5 w-5 shrink-0 text-slate-400 transition-transform duration-300 ${
                        isOpen ? 'rotate-180 text-red-500' : ''
                      }`}
                    />
                  </button>

                  {isOpen && (
                    <div className="px-4 sm:px-5 pb-5 pt-1 text-xs sm:text-sm text-slate-300 leading-relaxed border-t border-slate-800/80 animate-fade-in">
                      <p>{faq.a}</p>
                      
                      {index === 0 && (
                        <div className="mt-3 pt-3 border-t border-slate-800 flex items-center gap-3">
                          <a
                            href="tel:09196408805"
                            className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-red-600 hover:bg-red-500 text-white rounded-lg text-xs font-bold transition shadow-sm font-mono"
                          >
                            <PhoneCall className="h-3.5 w-3.5" />
                            <span>تماس فوری: ۰۹۱۹۶۴۰۸۸۰۵</span>
                          </a>
                        </div>
                      )}

                      {index === 3 && (
                        <div className="mt-3 pt-3 border-t border-slate-800 flex items-center gap-3">
                          <a
                            href="https://wa.me/989308368089?text=%D8%B3%D9%84%D8%A7%D9%85%D8%8C%20%D8%AC%D9%87%D8%AA%20%D8%AF%D8%B1%DB%8C%D8%A7%D9%81%D8%AA%20%D8%B4%D8%B1%D8%A7%DB%8C%D8%B7%20%D9%86%D9%85%D8%A7%DB%8C%D9%86%D8%AF%DA%AF%DB%8C%20%D9%BE%DB%8C%D9%86%E2%80%8C%D9%BE%D8%A7%D8%B1%D8%AA%20%D9%BE%DB%8C%D8%A7%D9%85%20%D9%85%DB%8C%E2%80%8C%D8%AF%D9%87%D9%85."
                            target="_blank"
                            rel="noopener noreferrer"
                            className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-emerald-600 hover:bg-emerald-500 text-white rounded-lg text-xs font-bold transition shadow-sm"
                          >
                            <WhatsApp className="!w-4 !h-4" />
                            <span>پیام به واتساپ مدیریت (۰۹۳۰۸۳۶۸۰۸۹)</span>
                          </a>
                        </div>
                      )}
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      </section>
    </div>
  );
};

export default HomePage;