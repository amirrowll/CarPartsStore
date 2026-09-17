import { Link } from 'react-router-dom';
import { Car, Phone, Mail, MapPin, Shield, Truck, Clock, CreditCard } from 'lucide-react';
import { useEffect, useRef, useState } from 'react';

const FooterFixed = () => {
  const currentYear = new Date().getFullYear();
  const containerRef = useRef<HTMLDivElement>(null);
  const [isMobile, setIsMobile] = useState(false);
  const [isSmallMobile, setIsSmallMobile] = useState(false);

  const footerLinks = {
    محصولات: [
      { name: 'لوازم یدکی چینی', path: '/chinese-parts' },
      { name: 'لوازم یدکی سایپا', path: '/saipa-parts' },
      { name: 'لوازم یدکی ایران خودرو', path: '/irankhodro-parts' },
      { name: 'همه محصولات', path: '/products' },
    ],
    دسترسی: [
      { name: 'پنل مدیریت', path: '/admin' },
      { name: 'تماس با ما', path: '/contact' },
      { name: 'درباره ما', path: '/about' },
      { name: 'سوالات متداول', path: '/faq' },
    ],
    'تماس با ما': [
      { name: 'ارتباط با پشتیبانی', path: '/contact-us' },
      { name: 'ساعات کاری', path: '/contact#hours' },
      { name: 'موقعیت مکانی', path: '/contact#location' },
    ],
    'تماس با مدیریت': [
      { name: 'تماس تلفنی: 09308368089', path: 'tel:09308368089' },
      { name: 'واتساپ مدیریت', path: 'https://wa.me/989308368089' },
    ],
  };

  const features = [
    {
      icon: <Shield className="h-6 w-6" />,
      title: 'کیفیت تضمینی',
      description: 'کلیه محصولات با کیفیت تضمینی'
    },
    {
      icon: <Truck className="h-6 w-6" />,
      title: 'ارسال سریع',
      description: 'ارسال به سراسر کشور'
    },
    {
      icon: <Clock className="h-6 w-6" />,
      title: 'پشتیبانی فنی',
      description: 'مشاوره فنی تخصصی'
    },
    {
      icon: <CreditCard className="h-6 w-6" />,
      title: 'امنیت کامل',
      description: 'اطمینان از کیفیت محصول'
    },
  ];

  // لیست برندهای معتبر
  const brands = [
    { name: 'Bosch', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Bosch-logo.svg/2560px-Bosch-logo.svg.png' },
    { name: 'Valeo', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Valeo_logo.svg/2560px-Valeo_logo.svg.png' },
    { name: 'Delphi', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Delphi_Automotive_logo.svg/2560px-Delphi_Automotive_logo.svg.png' },
    { name: 'Denso', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Denso_logo.svg/2560px-Denso_logo.svg.png' },
    { name: 'NGK', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/NGK_Spark_Plug_Logo.svg/2560px-NGK_Spark_Plug_Logo.svg.png' },
    { name: 'Mann-Filter', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Mann-Filter_logo.svg/2560px-Mann-Filter_logo.svg.png' },
    { name: 'Mahle', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Mahle_Logo.svg/2560px-Mahle_Logo.svg.png' },
    { name: 'Febi Bilstein', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Febi_Bilstein_logo.svg/2560px-Febi_Bilstein_logo.svg.png' },
    { name: 'Sachs', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Sachs_logo.svg/2560px-Sachs_logo.svg.png' },
    { name: 'ZF', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/ZF_logo.svg/2560px-ZF_logo.svg.png' },
    { name: 'Brembo', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Brembo_logo.svg/2560px-Brembo_logo.svg.png' },
    { name: 'Continental', logo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Continental_logo.svg/2560px-Continental_logo.svg.png' },
  ];

  useEffect(() => {
    const handleResize = () => {
      setIsMobile(window.innerWidth <= 768);
      setIsSmallMobile(window.innerWidth <= 425);
    };

    handleResize();
    window.addEventListener('resize', handleResize);

    return () => window.removeEventListener('resize', handleResize);
  }, []);

  useEffect(() => {
    const container = containerRef.current;
    if (!container) return;

    const items = container.querySelectorAll('.brand-item');
    const totalItems = items.length;
    
    // تنظیم سایز بر اساس عرض صفحه
    const isMobileDevice = window.innerWidth <= 768;
    const isSmallMobileDevice = window.innerWidth <= 425;
    const isTablet = window.innerWidth > 768 && window.innerWidth <= 1024;
    
    // تنظیمات داینامیک بر اساس دستگاه
    let itemWidth, spacing, containerHeight;
    
    if (isSmallMobileDevice) {
      itemWidth = 110;
      spacing = 30; // فاصله کمتر در موبایل کوچک
      containerHeight = 160;
    } else if (isMobileDevice) {
      itemWidth = 120;
      spacing = 40; // فاصله کمتر در موبایل
      containerHeight = 170;
    } else if (isTablet) {
      itemWidth = 110;
      spacing = 70;
      containerHeight = 160;
    } else {
      itemWidth = 100;
      spacing = 100; // فاصله بیشتر در دسکتاپ
      containerHeight = 160;
    }
    
    // تنظیم ارتفاع کانتینر
    container.style.height = `${containerHeight}px`;
    
    const totalWidth = totalItems * (itemWidth + spacing);
    const containerWidth = container.clientWidth;
    
    // موقعیتدهی اولیه
    items.forEach((item, index) => {
      const x = index * (itemWidth + spacing);
      (item as HTMLElement).style.width = `${itemWidth}px`;
      (item as HTMLElement).style.height = `${itemWidth}px`;
      (item as HTMLElement).style.marginTop = `-${itemWidth / 2}px`;
      (item as HTMLElement).style.transform = `translateX(${x}px)`;
      (item as HTMLElement).style.opacity = '1';
      
      // تنظیم سایز عکس داخل برند
      const img = (item as HTMLElement).querySelector('img');
      const span = (item as HTMLElement).querySelector('span');
      const div = (item as HTMLElement).querySelector('div');
      
      if (div) {
        div.style.width = `${itemWidth}px`;
        div.style.height = `${itemWidth}px`;
        div.style.padding = isMobileDevice ? '8px' : '12px';
      }
      
      if (img) {
        const maxHeight = isMobileDevice ? 35 : 28;
        img.style.maxHeight = `${maxHeight}px`;
      }
      
      if (span) {
        const fontSize = isMobileDevice ? 11 : 12;
        span.style.fontSize = `${fontSize}px`;
      }
    });

    // انیمیشن حرکت پیوسته به چپ - نسخه بهبود یافته
    let position = 0;
    const speed = isMobileDevice ? 0.3 : 0.5;
    let animationId: number;
    let isAnimating = true;
    
    const animate = () => {
      if (!isAnimating) return;
      
      position -= speed;
      
      // حرکت همه آیتمها
      items.forEach((item, index) => {
        let x = (index * (itemWidth + spacing)) + position;
        
        // لوپ بینهایت - اگر از سمت چپ خارج شد، به انتهای خط ببر
        if (x < -itemWidth) {
          x += totalWidth;
        }
        
        // محاسبه opacity و scale بر اساس موقعیت (برندهای وسط واضحتر و بزرگتر)
        const distanceFromCenter = Math.abs(x - containerWidth / 2);
        const maxDistance = containerWidth / 2;
        const opacity = Math.max(0.3, 1 - (distanceFromCenter / maxDistance) * 0.7);
        
        // اسکیل بیشتر در موبایل برای بزرگتر دیده شدن
        const scale = isMobileDevice 
          ? 0.9 + (0.6 * (1 - (distanceFromCenter / maxDistance)))
          : 0.85 + (0.4 * (1 - (distanceFromCenter / maxDistance)));
        
        (item as HTMLElement).style.transform = `translateX(${x}px) scale(${scale})`;
        (item as HTMLElement).style.opacity = opacity.toString();
        (item as HTMLElement).style.zIndex = Math.round(opacity * 10).toString();
      });
      
      animationId = requestAnimationFrame(animate);
    };

    animate();

    // اضافه کردن event listener برای resize
    const handleResize = () => {
      isAnimating = false;
      if (animationId) {
        cancelAnimationFrame(animationId);
      }
      // دوباره animate را فراخوانی کن
      isAnimating = true;
      animate();
    };

    window.addEventListener('resize', handleResize);

    return () => {
      isAnimating = false;
      if (animationId) {
        cancelAnimationFrame(animationId);
      }
      window.removeEventListener('resize', handleResize);
    };
  }, [isMobile, isSmallMobile]);

  return (
    <footer className="bg-gray-900 text-white">
      <div className="bg-white py-4 overflow-hidden">
        <div className="max-w-7xl mx-auto px-4">
          
          <div 
            ref={containerRef}
            className="relative overflow-hidden flex items-center justify-center"
            style={{ height: '160px' }}
          >
            {/* تعداد بیشتری از برندها برای لوپ بینهایت */}
            {[...brands, ...brands, ...brands, ...brands, ...brands, ...brands, ...brands].map((brand, index) => (
              <div
                key={`${brand.name}-${index}`}
                className="brand-item absolute top-1/2 left-0"
                style={{
                  willChange: 'transform, opacity',
                  width: '100px',
                  height: '100px',
                  marginTop: '-50px',
                  pointerEvents: 'none', // غیرفعال کردن هاور
                }}
              >
                <div 
                  className="w-full h-full bg-white rounded-xl border border-gray-200 flex flex-col items-center justify-center shadow-lg"
                  style={{ padding: '12px' }}
                >
                  <img
                    src={brand.logo}
                    alt={brand.name}
                    className="max-h-7 max-w-full object-contain mb-2"
                    style={{ maxHeight: '28px' }}
                    onError={(e) => {
                      e.currentTarget.src = 'https://cdn-icons-png.flaticon.com/512/2972/2972264.png';
                    }}
                  />
                  <span className="text-xs text-gray-700 font-medium truncate w-full text-center">
                    {brand.name}
                  </span>
                </div>
              </div>
            ))}
            
            {/* Gradient Overlays */}
            <div className="absolute inset-y-0 left-0 w-24 sm:w-32 md:w-48 lg:w-64 bg-gradient-to-r from-white via-white/90 to-transparent z-10 pointer-events-none"></div>
            <div className="absolute inset-y-0 right-0 w-24 sm:w-32 md:w-48 lg:w-64 bg-gradient-to-l from-white via-white/90 to-transparent z-10 pointer-events-none"></div>
            
            {/* استایلها */}
            <style>
              {`
                .brand-item {
                  transition: none !important; /* حذف transition برای حرکت روان */
                  filter: grayscale(10%);
                  will-change: transform, opacity;
                  transform-origin: center;
                }
                
                /* موبایل */
                @media (max-width: 768px) {
                  .brand-item {
                    width: 120px !important;
                    height: 120px !important;
                    margin-top: -60px !important;
                  }
                  
                  .brand-item > div {
                    width: 120px !important;
                    height: 120px !important;
                    padding: 8px !important;
                    border-radius: 12px !important;
                  }
                  
                  .brand-item img {
                    max-height: 35px !important;
                    margin-bottom: 6px !important;
                  }
                  
                  .brand-item span {
                    font-size: 11px !important;
                  }
                }
                
                @media (max-width: 425px) {
                  .brand-item {
                    width: 110px !important;
                    height: 110px !important;
                    margin-top: -55px !important;
                  }
                  
                  .brand-item > div {
                    width: 110px !important;
                    height: 110px !important;
                    padding: 6px !important;
                    border-radius: 10px !important;
                  }
                  
                  .brand-item img {
                    max-height: 32px !important;
                    margin-bottom: 4px !important;
                  }
                  
                  .brand-item span {
                    font-size: 10px !important;
                  }
                }
                
                /* تبلت */
                @media (min-width: 769px) and (max-width: 1024px) {
                  .brand-item {
                    width: 110px !important;
                    height: 110px !important;
                    margin-top: -55px !important;
                  }
                  
                  .brand-item > div {
                    width: 110px !important;
                    height: 110px !important;
                    padding: 10px !important;
                  }
                  
                  .brand-item img {
                    max-height: 30px !important;
                  }
                }
              `}
            </style>
          </div>
        </div>
      </div>

      {/* بخش ویژگیها */}
      <div className="bg-gray-800 py-8">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {features.map((feature, index) => (
              <div key={index} className="flex items-start space-x-4 space-x-reverse">
                <div className="bg-accent-600 p-3 rounded-lg">
                  {feature.icon}
                </div>
                <div>
                  <h3 className="font-heading font-semibold text-lg mb-1">{feature.title}</h3>
                  <p className="text-gray-300 text-sm">{feature.description}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* لینکهای اصلی */}
      <div className="py-12">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-8">
            {/* درباره ما */}
            <div className="lg:col-span-2">
              <div className="flex items-center space-x-3 space-x-reverse mb-6">
                <div className="bg-accent-600 p-2 rounded-lg">
                  <Car className="h-6 w-6" />
                </div>
                <div>
                  <h2 className="text-2xl font-heading font-bold">
                    <span className="text-red-600">P</span>inpart<span className="text-accent-400">Store</span>
                  </h2>
                  <p className="text-gray-400 text-sm">تخصصی ترین فروشگاه لوازم یدکی</p>
                </div>
              </div>
              <p className="text-gray-300 mb-6">
                با بیش از 15 سال تجربه در زمینه تأمین و توزیع لوازم یدکی خودرو، 
                مفتخریم که با ارائه محصولات با کیفیت، همراه مطمئنی برای صاحبان 
                خودروهای چینی، سایپا و ایران خودرو باشیم.
              </p>
              <div className="space-y-3">
                <div className="flex items-center space-x-3 space-x-reverse text-gray-300">
                  <MapPin className="h-5 w-5 text-accent-400" />
                  <span>تهران بازار(چراغ برق) خیابان امیرکبیر نرسیده به خیابان ملت پاساژ کوشانپور طبقه دوم پلاک 69 پین پارت</span>
                </div>
              </div>
            </div>

            {/* لینکهای سریع */}
            {Object.entries(footerLinks).map(([category, links]) => (
              <div key={category}>
                <h3 className="font-heading font-semibold text-xl mb-6 text-white">
                  {category}
                </h3>
                <ul className="space-y-3">
                  {links.map((link) => (
                    <li key={link.path}>
                      {link.path.startsWith('http') || link.path.startsWith('tel') || link.path.startsWith('mailto') ? (
                        <a
                          href={link.path}
                          target={link.path.startsWith('http') ? '_blank' : '_self'}
                          rel={link.path.startsWith('http') ? 'noopener noreferrer' : ''}
                          className="text-gray-300 hover:text-accent-400 transition-colors duration-200 flex items-center space-x-reverse"
                        >
                          <span className="w-2 h-2 bg-accent-400 rounded-full ml-2"></span>
                          {link.name}
                        </a>
                      ) : (
                        <Link
                          to={link.path}
                          className="text-gray-300 hover:text-accent-400 transition-colors duration-200 flex items-center space-x-reverse"
                        >
                          <span className="w-2 h-2 bg-accent-400 rounded-full ml-2"></span>
                          {link.name}
                        </Link>
                      )}
                    </li>
                  ))}
                </ul>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* کپیرایت */}
      <div className="border-t border-gray-800 py-6">
        <div className="container mx-auto px-4">
          <div className="flex flex-col md:flex-row justify-between items-center">
            <div className="text-gray-400 text-sm mb-4 md:mb-0">
              © {currentYear} Pinpart. تمامی حقوق محفوظ است.
            </div>
            <div className="flex items-center space-x-6 space-x-reverse">
              <a href="#" className="text-gray-300 hover:text-white transition-colors text-sm">
                حریم خصوصی
              </a>
              <a href="#" className="text-gray-300 hover:text-white transition-colors text-sm">
                شرایط استفاده
              </a>
              <a href="#" className="text-gray-300 hover:text-white transition-colors text-sm">
                نقشه سایت
              </a>
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default FooterFixed;