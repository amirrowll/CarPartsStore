import React from 'react';
import { Star, Quote } from 'lucide-react';

const testimonials = [
  {
    id: 1,
    name: 'محمد حسینی',
    role: 'مکانیک خودرو',
    content: 'کیفیت قطعات فوق العادست. به مشتریام همیشه پیشنهاد میدم از این سایت خرید کنن.',
    rating: 5,
    image: '/src/assets/hero.png'
  },
  {
    id: 2,
    name: 'فاطمه رضایی',
    role: 'کاربر پراید',
    content: 'برای اولین بار از این سایت خرید کردم و واقعاً راضی بودم. قطعه اصلی و سالم تحویل گرفتم.',
    rating: 4,
    image: '/src/assets/react.svg'
  },
  {
    id: 3,
    name: 'علیرضا محمودی',
    role: 'تعمیرکار گیربکس',
    content: 'تنها سایتی که همه قطعات رو توی یکجا داره. تحویل سریع و قیمت مناسب.',
    rating: 5,
    image: '/src/assets/vite.svg'
  },
];

const Testimonials: React.FC = () => {
  return (
    <section className="py-16 bg-gray-900 text-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <div className="inline-flex items-center justify-center gap-2 mb-4">
            <Quote className="h-8 w-8 text-blue-400" />
            <h2 className="text-3xl md:text-4xl font-bold">
              نظرات <span className="text-blue-400">مشتریان</span>
            </h2>
          </div>
          <p className="text-lg text-center text-gray-300 max-w-3xl mx-auto">
            تجربه واقعی کاربران از کیفیت خدمات و محصولات ما
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {testimonials.map((testimonial) => (
            <div
              key={testimonial.id}
              className="bg-gray-800 rounded-2xl p-6 hover:bg-gray-700 transition-colors relative"
            >
              <div className="absolute -top-4 right-6">
                <Quote className="h-8 w-8 text-blue-500/20" />
              </div>
              
              <div className="flex items-center gap-4 mb-4">
                <img
                  src={testimonial.image}
                  alt={testimonial.name}
                  className="w-16 h-16 rounded-full border-2 border-blue-500"
                />
                <div>
                  <h3 className="font-bold text-lg">{testimonial.name}</h3>
                  <p className="text-gray-400 text-sm">{testimonial.role}</p>
                </div>
              </div>
              
              <div className="flex items-center gap-1 mb-4">
                {[...Array(5)].map((_, i) => (
                  <Star
                    key={i}
                    className={`h-5 w-5 ${
                      i < testimonial.rating
                        ? 'text-yellow-400 fill-current'
                        : 'text-gray-600'
                    }`}
                  />
                ))}
              </div>
              
              <p className="text-gray-300 mb-6">{testimonial.content}</p>
              
              <div className="border-t border-gray-700 pt-4">
                <div className="text-sm text-gray-400">
                  تجربه خرید موفق
                </div>
              </div>
            </div>
          ))}
        </div>
        
        <div className="mt-12 text-center">
          <div className="inline-flex items-center gap-4 bg-gradient-to-r from-blue-600/20 to-blue-800/20 rounded-2xl p-6">
            <div className="text-4xl font-bold">4.9</div>
            <div>
              <div className="flex items-center gap-1 mb-1">
                {[...Array(5)].map((_, i) => (
                  <Star key={i} className="h-5 w-5 text-yellow-400 fill-current" />
                ))}
              </div>
              <div className="text-sm text-gray-300">میانگین امتیاز از 120+ نظر</div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Testimonials;