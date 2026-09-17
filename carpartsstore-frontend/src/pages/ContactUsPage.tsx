import React from 'react';
import { Phone, MessageCircle, Mail, Send, ArrowRight } from 'lucide-react';
import { Phone as PhoneIcon, WhatsApp, Telegram, Instagram } from '@mui/icons-material';

const ContactUsPage: React.FC = () => {
  const contactMethods = [
    {
      id: 1,
      title: 'تماس تلفنی',
      description: 'مستقیماً با پشتیبانی تماس بگیرید',
      icon: <PhoneIcon className="h-8 w-8 text-blue-600" />,
      action: () => window.location.href = 'tel:09196408805',
      color: 'bg-blue-50 hover:bg-blue-100',
      textColor: 'text-blue-700',
      buttonText: 'تماس بگیرید',
      number: '09196408805'
    },
    {
      id: 2,
      title: 'واتساپ',
      description: 'از طریق واتساپ با ما در ارتباط باشید',
      icon: <WhatsApp className="h-8 w-8 text-green-600" />,
      action: () => {
        const message = 'سلام، میخواهم در مورد محصولات شما اطلاعات بیشتری کسب کنم.';
        window.open(`https://wa.me/989196408805?text=${encodeURIComponent(message)}`, '_blank');
      },
      color: 'bg-green-50 hover:bg-green-100',
      textColor: 'text-green-700',
      buttonText: 'پیام در واتساپ',
      number: '09196408805'
    },
    {
      id: 3,
      title: 'تلگرام',
      description: 'از طریق تلگرام با ما در ارتباط باشید',
      icon: <Telegram className="h-8 w-8 text-blue-500" />,
      action: () => window.open('https://t.me/Pinparts1', '_blank'),
      color: 'bg-blue-50 hover:bg-blue-100',
      textColor: 'text-blue-600',
      buttonText: 'پیام در تلگرام',
      username: '@Pinparts1'
    },
    {
      id: 4,
      title: 'اینستاگرام',
      description: 'صفحه اینستاگرام ما را دنبال کنید',
      icon: <Instagram className="h-8 w-8 text-pink-600" />,
      action: () => window.open('https://instagram.com/direct/t/pinparts', '_blank'),
      color: 'bg-pink-50 hover:bg-pink-100',
      textColor: 'text-pink-700',
      buttonText: 'پیام در اینستاگرام',
      username: '@pinparts'
    }
  ];

  const managementContact = [
    {
      id: 1,
      title: 'تماس با مدیریت',
      description: 'مستقیماً با مدیریت تماس بگیرید',
      icon: <PhoneIcon className="h-8 w-8 text-purple-600" />,
      action: () => window.location.href = 'tel:09308368089',
      color: 'bg-purple-50 hover:bg-purple-100',
      textColor: 'text-purple-700',
      buttonText: 'تماس بگیرید',
      number: '09308368089'
    },
    {
      id: 2,
      title: 'واتساپ مدیریت',
      description: 'از طریق واتساپ با مدیریت در ارتباط باشید',
      icon: <WhatsApp className="h-8 w-8 text-green-600" />,
      action: () => {
        const message = 'سلام، میخواهم در مورد همکاری یا امور مدیریتی با شما صحبت کنم.';
        window.open(`https://wa.me/989308368089?text=${encodeURIComponent(message)}`, '_blank');
      },
      color: 'bg-green-50 hover:bg-green-100',
      textColor: 'text-green-700',
      buttonText: 'پیام در واتساپ',
      number: '09308368089'
    }
  ];

  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-50 to-white">
      {/* هدر صفحه */}
      <div className="bg-gradient-to-r from-blue-600 to-blue-800 text-white py-12">
        <div className="container mx-auto px-4">
          <div className="max-w-4xl mx-auto text-center">
            <h1 className="text-4xl font-bold mb-4">ارتباط با ما</h1>
            <p className="text-xl text-blue-100 mb-6 text-center">
              از طریق روشهای مختلف با تیم پشتیبانی و مدیریت در ارتباط باشید
            </p>
            <div className="flex flex-wrap justify-center gap-4">
              <div className="bg-white/20 backdrop-blur-sm rounded-xl px-6 py-3">
                <div className="flex items-center gap-2">
                  <Phone className="h-5 w-5" />
                  <span className="font-medium">پشتیبانی: 09196408805</span>
                </div>
              </div>
              <div className="bg-white/20 backdrop-blur-sm rounded-xl px-6 py-3">
                <div className="flex items-center gap-2">
                  <MessageCircle className="h-5 w-5" />
                  <span className="font-medium">مدیریت: 09308368089</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* بخش اصلی */}
      <div className="container mx-auto px-4 py-12">
        <div className="max-w-6xl mx-auto">
          {/* روشهای ارتباطی پشتیبانی */}
          <div className="mb-16">
            <div className="text-right mb-10">
              <h2 className="text-3xl font-bold text-gray-800 mb-3 text-center">ارتباط با پشتیبانی</h2>
              <p className="text-gray-600 text-lg text-center">
                برای سوالات فنی، مشاوره و پشتیبانی از روشهای زیر استفاده کنید
              </p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              {contactMethods.map((method) => (
                <div
                  key={method.id}
                  className={`${method.color} rounded-2xl border border-gray-200 p-6 shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1`}
                >
                  <div className="flex flex-col h-full">
                    <div className="flex items-center gap-3 mb-4">
                      <div className="p-3 bg-white rounded-xl shadow-sm">
                        {method.icon}
                      </div>
                      <div>
                        <h3 className={`font-bold text-lg ${method.textColor} text-right`}>
                          {method.title}
                        </h3>
                      </div>
                    </div>

                    <p className="text-gray-600 mb-6 flex-grow text-right">
                      {method.description}
                    </p>

                    <div className="mb-4">
                      {method.number && (
                        <div className="bg-white/50 rounded-lg p-3 mb-2 text-right">
                          <p className="text-sm text-gray-500 mb-1">شماره تماس</p>
                          <p className="font-bold text-gray-800 text-lg">{method.number}</p>
                        </div>
                      )}
                      {method.username && (
                        <div className="bg-white/50 rounded-lg p-3 mb-2 text-right">
                          <p className="text-sm text-gray-500 mb-1">آیدی</p>
                          <p className="font-bold text-gray-800 text-lg">{method.username}</p>
                        </div>
                      )}
                    </div>

                    <button
                      onClick={method.action}
                      className={`w-full font-extrabold py-3 px-4 rounded-xl hover:opacity-90 transition-opacity flex items-center justify-center gap-2 shadow-lg hover:shadow-xl border-2 border-white/30 ${method.id === 1 ? 'bg-blue-600 text-white' : method.id === 2 ? 'bg-green-600 text-white' : method.id === 3 ? 'bg-blue-500 text-white' : 'bg-pink-600 text-white'}`}
                    >
                      <span className="text-lg">{method.buttonText}</span>
                      <ArrowRight className="h-5 w-5" />
                    </button>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* روشهای ارتباطی مدیریت */}
          <div className="mb-16">
            <div className="text-right mb-10">
              <h2 className="text-3xl font-bold text-gray-800 mb-3 text-center">ارتباط با مدیریت</h2>
              <p className="text-gray-600 text-lg text-center">
                برای امور مدیریتی، همکاری و پیشنهادات ویژه
              </p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-2xl mx-auto">
              {managementContact.map((method) => (
                <div
                  key={method.id}
                  className={`${method.color} rounded-2xl border border-gray-200 p-6 shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1`}
                >
                  <div className="flex flex-col h-full">
                    <div className="flex items-center gap-3 mb-4">
                      <div className="p-3 bg-white rounded-xl shadow-sm">
                        {method.icon}
                      </div>
                      <div>
                        <h3 className={`font-bold text-lg ${method.textColor} text-right`}>
                          {method.title}
                        </h3>
                      </div>
                    </div>

                    <p className="text-gray-600 mb-6 flex-grow text-right">
                      {method.description}
                    </p>

                    <div className="mb-4">
                      <div className="bg-white/50 rounded-lg p-3 text-right">
                        <p className="text-sm text-gray-500 mb-1">شماره تماس</p>
                        <p className="font-bold text-gray-800 text-lg">{method.number}</p>
                      </div>
                    </div>

                    <button
                      onClick={method.action}
                      className={`w-full font-extrabold py-3 px-4 rounded-xl hover:opacity-90 transition-opacity flex items-center justify-center gap-2 shadow-lg hover:shadow-xl border-2 border-white/30 ${method.id === 1 ? 'bg-purple-600 text-white' : 'bg-green-600 text-white'}`}
                    >
                      <span className="text-lg">{method.buttonText}</span>
                      <ArrowRight className="h-5 w-5" />
                    </button>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* اطلاعات تماس */}
          <div className="bg-gradient-to-r from-gray-50 to-gray-100 rounded-2xl p-8 border border-gray-200">
            <div className="text-right mb-8">
              <h3 className="text-2xl font-bold text-gray-800 mb-3 text-center">اطلاعات تماس</h3>
              <p className="text-gray-600 text-center">آدرس و اطلاعات کامل فروشگاه</p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
              <div className="space-y-4">
                <div className="flex items-start gap-3">
                  <div className="p-2 bg-blue-100 rounded-lg">
                    <Phone className="h-5 w-5 text-blue-600" />
                  </div>
                  <div>
                    <h4 className="font-bold text-gray-800 mb-1 text-right">شماره های تماس</h4>
                    <div className="space-y-2 text-right">
                      <p className="text-gray-700">پشتیبانی: <span className="font-bold">09196408805</span></p>
                      <p className="text-gray-700">مدیریت: <span className="font-bold">09308368089</span></p>
                    </div>
                  </div>
                </div>
              </div>

              <div className="space-y-4">
                <div className="flex items-start gap-3">
                  <div className="p-2 bg-amber-100 rounded-lg">
                    <Send className="h-5 w-5 text-amber-600" />
                  </div>
                  <div>
                    <h4 className="font-bold text-gray-800 mb-1 text-right">آدرس فروشگاه</h4>
                    <p className="text-gray-700 leading-relaxed text-right">
                      تهران بازار(چراغ برق) خیابان امیرکبیر نرسیده به خیابان ملت پاساژ کوشانپور طبقه دوم پلاک 69 پین پارت
                    </p>
                  </div>
                </div>

                <div className="flex items-start gap-3">
                  <div className="p-2 bg-purple-100 rounded-lg">
                    <MessageCircle className="h-5 w-5 text-purple-600" />
                  </div>
                  <div>
                    <h4 className="font-bold text-gray-800 mb-1 text-right">شبکه های اجتماعی</h4>
                    <div className="space-y-1 text-right">
                      <p className="text-gray-700">برای دسترسی سریع به کانالهای ارتباطی، از نوار ابزار سمت چپ صفحه استفاده کنید</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* نکات مهم */}
          <div className="mt-12 bg-gradient-to-r from-blue-50 to-blue-100 rounded-2xl p-8 border border-blue-200">
            <h3 className="text-2xl font-bold text-blue-800 mb-4 text-center">نکات مهم</h3>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="text-center">
                <div className="inline-flex items-center justify-center w-12 h-12 bg-blue-100 rounded-full mb-3 text-center">
                  <Phone className="h-6 w-6 text-blue-600" />
                </div>
                <h4 className="font-bold text-blue-700 mb-2 text-center">ساعات پاسخگویی</h4>
                <p className="text-blue-600 text-center">شنبه تا پنجشنبه: 24 ساعت شبانه روز</p>
              </div>
              <div className="text-center">
                <div className="inline-flex items-center justify-center w-12 h-12 bg-blue-100 rounded-full mb-3 text-center">
                  <MessageCircle className="h-6 w-6 text-blue-600" />
                </div>
                <h4 className="font-bold text-blue-700 mb-2 text-center">پاسخ سریع</h4>
                <p className="text-blue-600 text-center">پاسخگویی در واتساپ و تلگرام در کمترین زمان</p>
              </div>
              <div className="text-center">
                <div className="inline-flex items-center justify-center w-12 h-12 bg-blue-100 rounded-full mb-3">
                  <Send className="h-6 w-6 text-blue-600" />
                </div>
                <h4 className="font-bold text-blue-700 mb-2 text-center">مشاوره رایگان</h4>
                <p className="text-blue-600 text-center">مشاوره فنی تخصصی به صورت رایگان</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ContactUsPage;