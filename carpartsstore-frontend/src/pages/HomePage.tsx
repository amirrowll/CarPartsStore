import React from 'react';
import Hero from '../components/Hero';
import CategoriesSectionNew from '../components/CategoriesSectionNew';
import FeaturedProducts from '../components/FeaturedProducts';
import HowItWorks from '../components/HowItWorks';
import Testimonials from '../components/Testimonials';
import StoriesSection from '../components/StoriesSection';
import SEO from '../components/SEO';
import { SEO_CONFIG } from '../utils/seoConfig';

const HomePage: React.FC = () => {
  const seoConfig = SEO_CONFIG.home;
  
  return (
    <div className="min-h-screen">
      <SEO 
        title={seoConfig.title}
        description={seoConfig.description}
        keywords={seoConfig.keywords}
        structuredData={seoConfig.structuredData()}
      />
      
      {/* Stories Section at the top */}
      <StoriesSection position="top" />
      
      <Hero />
      <CategoriesSectionNew />
      <FeaturedProducts />
      <HowItWorks />
      <Testimonials />
      
      {/* FAQ Section for SEO */}
      <div className="container mx-auto px-4 py-12 max-w-4xl">
        <h2 className="text-2xl font-bold text-gray-900 mb-6 text-center">سوالات متداول</h2>
        <div className="space-y-4">
          <div className="bg-white rounded-xl p-6 shadow-md">
            <h3 className="text-lg font-semibold text-gray-800 mb-2">آیا قطعات شما اورجینال هستند؟</h3>
            <p className="text-gray-600">بله، تمام قطعات ارائه شده در Pinpart Store اورجینال و با کیفیت اصلی میباشند. ما فقط از تامین‌کنندگان معتبر قطعات را تهیه می‌کنیم.</p>
          </div>
          <div className="bg-white rounded-xl p-6 shadow-md">
            <h3 className="text-lg font-semibold text-gray-800 mb-2">چگونه می‌توانم از سازگاری قطعه با خودروی خود مطمئن شوم؟</h3>
            <p className="text-gray-600">در صفحه هر محصول، خودروهای سازگار ذکر شده است. همچنین می‌توانید با کارشناسان ما از طریق واتساپ یا تلفن تماس بگیرید.</p>
          </div>
          <div className="bg-white rounded-xl p-6 shadow-md">
            <h3 className="text-lg font-semibold text-gray-800 mb-2">آیا به شهرستان‌ها هم ارسال دارید؟</h3>
            <p className="text-gray-600">بله، ما به سراسر کشور ارسال داریم. هزینه ارسال بر اساس شهر مقصد محاسبه می‌شود.</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default HomePage;