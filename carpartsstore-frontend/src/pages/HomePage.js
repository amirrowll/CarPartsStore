import React from 'react';
import Hero from '../components/Hero';
import CategoriesSectionNew from '../components/CategoriesSectionNew';
import FeaturedProducts from '../components/FeaturedProducts';
import HowItWorks from '../components/HowItWorks';
import Testimonials from '../components/Testimonials';
import StoriesSection from '../components/StoriesSection';
import SEO from '../components/SEO';
const HomePage = () => {
    return (<div className="min-h-screen">
      <SEO title="فروشگاه قطعات خودرو - خرید آنلاین قطعات یدکی" description="فروشگاه تخصصی قطعات یدکی خودرو با بهترین قیمت و کیفیت. قطعات اصلی و اورجینال برای تمامی خودروها" keywords="قطعات خودرو, قطعات یدکی, خرید قطعات خودرو, فروشگاه قطعات خودرو, پراید, تیبا, ساینا, ایران خودرو, سایپا"/>
      
      {/* Stories Section at the top */}
      <StoriesSection position="top"/>
      
      <Hero />
      <CategoriesSectionNew />
      <FeaturedProducts />
      <HowItWorks />
      <Testimonials />
    </div>);
};
export default HomePage;
