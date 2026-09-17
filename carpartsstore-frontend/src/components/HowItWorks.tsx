import React, { useEffect, useState } from 'react';
import { Search, CheckCircle, Truck, Headphones } from 'lucide-react';
import { productApi } from '../services/api';

const steps = [
  {
    id: 1,
    title: 'جستجوی قطعه',
    description: 'قطعه مورد نظر خود را بر اساس خودرو، مدل و سال تولید پیدا کنید',
    icon: Search,
    color: 'bg-gradient-to-br from-blue-500 to-blue-700'
  },
  {
    id: 2,
    title: 'تایید کیفیت',
    description: 'همه قطعات با گارانتی کیفیت و تست فنی ارائه میشوند',
    icon: CheckCircle,
    color: 'bg-gradient-to-br from-green-500 to-green-700'
  },
  {
    id: 3,
    title: 'تحویل سریع',
    description: 'ارسال به تمام نقاط کشور در کمتر از 24 ساعت',
    icon: Truck,
    color: 'bg-gradient-to-br from-orange-500 to-orange-700'
  },
  {
    id: 4,
    title: 'پشتیبانی فنی',
    description: 'تیم پشتیبانی 24/7 برای پاسخ به سوالات فنی شما',
    icon: Headphones,
    color: 'bg-gradient-to-br from-purple-500 to-purple-700'
  },
];

const HowItWorks: React.FC = () => {
  const [totalProducts, setTotalProducts] = useState(0);
  
  useEffect(() => {
    const fetchTotalProducts = async () => {
      try {
        const response = await productApi.getAll({ pageSize: 1 });
        setTotalProducts(response.totalCount || 0);
      } catch (error) {
        console.error('Error fetching total products:', error);
      }
    };
    
    fetchTotalProducts();
  }, []);
  
  return (
    <section className="py-16 bg-gradient-to-b from-gray-50 to-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
            چگونه <span className="text-blue-600">کار میکند؟</span>
          </h2>
          <p className="text-lg text-center text-gray-600 max-w-3xl mx-auto">
            با 4 قدم ساده به قطعه مورد نیاز خود دسترسی پیدا کنید
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          {steps.map((step, index) => {
            const Icon = step.icon;
            return (
              <div key={step.id} className="relative">
                <div className="bg-white rounded-2xl shadow-lg p-6 hover:shadow-xl transition-shadow">
                  <div className="flex items-center mb-6">
                    <div className={`${step.color} p-4 rounded-xl text-white`}>
                      <Icon className="h-8 w-8" />
                    </div>
                    <div className="mr-4">
                      <div className="text-sm font-medium text-gray-500">قدم {index + 1}</div>
                      <h3 className="text-xl font-bold text-gray-900">{step.title}</h3>
                    </div>
                  </div>
                  <p className="text-gray-600">{step.description}</p>
                </div>
                
                {index < steps.length - 1 && (
                  <div className="hidden lg:block absolute top-12 -right-4 w-8 h-0.5 bg-gradient-to-r from-blue-500 to-transparent z-10"></div>
                )}
              </div>
            );
          })}
        </div>
        
        <div className="mt-16 text-center">
          <div className="inline-flex items-center justify-center gap-8 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-2xl p-8 shadow-lg">
            <div className="text-center">
              <div className="text-4xl font-bold text-blue-600 mb-2">
                {totalProducts > 0 ? totalProducts.toLocaleString() + '+' : '...'}
              </div>
              <div className="text-gray-600">محصول موجود</div>
            </div>
            <div className="w-px h-12 bg-gray-300"></div>
            <div className="text-center">
              <div className="text-4xl font-bold text-green-600 mb-2">98%</div>
              <div className="text-gray-600">رضایت مشتری</div>
            </div>
            <div className="w-px h-12 bg-gray-300"></div>
            <div className="text-center">
              <div className="text-4xl font-bold text-orange-600 mb-2">24h</div>
              <div className="text-gray-600">تحویل سریع</div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default HowItWorks;