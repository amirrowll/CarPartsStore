import React, { useState } from 'react';
import { WhatsApp, Telegram, Instagram, Phone, Close, OpenInNew, Chat, SupportAgent } from '@mui/icons-material';
import { MessageSquare, PhoneCall, Sparkles } from 'lucide-react';
import CallRequestModal from './CallRequestModal';

const PinpartSocialToolbarFinal: React.FC = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [activeChannel, setActiveChannel] = useState<string | null>(null);

  const socialChannels = [
    {
      id: 'whatsapp1',
      name: 'گروه واتساپ عمده‌فروشی',
      desc: 'عضویت همکاران و اعلام موجودی روزانه',
      icon: <WhatsApp className="!w-5 !h-5" />,
      url: 'https://chat.whatsapp.com/CGCLTGEoouVEfgybJMlWw8?mode=wwc',
      color: 'bg-emerald-600 hover:bg-emerald-500',
      tag: 'پیشنهادی'
    },
    {
      id: 'telegram',
      name: 'کانال تلگرام پین‌پارت',
      desc: 'مشاهده کاتالوگ و اقلام جدید @Pinparts1',
      icon: <Telegram className="!w-5 !h-5" />,
      url: 'https://t.me/Pinparts1',
      color: 'bg-sky-600 hover:bg-sky-500',
      tag: 'کانال رسمی'
    },
    {
      id: 'instagram',
      name: 'صفحه اینستاگرام پین‌پارت',
      desc: 'ویدیوهای معرفی قطعات و تولیدات @pinparts',
      icon: <Instagram className="!w-5 !h-5" />,
      url: 'https://instagram.com/direct/t/pinparts',
      color: 'bg-gradient-to-r from-pink-600 to-purple-600 hover:from-pink-500 hover:to-purple-500',
      tag: 'اینستاگرام'
    },
    {
      id: 'sales_call',
      name: 'تماس مستقیم واحد فروش عمده',
      desc: '۰۹۱۹۶۴۰۸۸۰۵ (مشاوره و استعلام تلفنی)',
      icon: <Phone className="!w-5 !h-5" />,
      url: 'tel:09196408805',
      color: 'bg-red-600 hover:bg-red-500',
      tag: 'تماس فوری'
    },
    {
      id: 'manager_wa',
      name: 'واتساپ مستقیم مدیریت',
      desc: '۰۹۳۰۸۳۶۸۰۸۹ (قراردادها و نمایندگی شهرستان)',
      icon: <WhatsApp className="!w-5 !h-5" />,
      url: 'https://wa.me/989308368089?text=%D8%B3%D9%84%D8%A7%D9%85%D8%8C%20%D8%AC%D9%87%D8%AA%20%D9%87%D9%85%DA%A9%D8%A7%D8%B1%DB%8C%20%D8%B9%D9%85%D8%AF%D9%87%20%D9%BE%DB%8C%D9%86%E2%80%8C%D9%BE%D8%A7%D8%B1%D8%AA%20%D9%BE%DB%8C%D8%A7%D9%85%20%D9%85%DB%8C%E2%80%8C%D8%AF%D9%87%D9%85.',
      color: 'bg-emerald-700 hover:bg-emerald-600',
      tag: 'مدیریت بازرگانی'
    }
  ];

  const handleChannelClick = (channelId: string, url: string) => {
    setActiveChannel(channelId);
    if (url.startsWith('tel:')) {
      window.location.href = url;
    } else {
      window.open(url, '_blank');
    }
  };

  const handleClose = () => {
    setIsOpen(false);
    setActiveChannel(null);
  };

  return (
    <>
      {/* Floating Pill Button - اشاره صریح به کانال‌ها و ارتباطات */}
      <div className="fixed left-4 sm:left-6 bottom-5 z-[9999]" dir="ltr">
        <button
          onClick={() => setIsOpen(!isOpen)}
          className="group flex items-center gap-2.5 p-1.5 pr-4 bg-gradient-to-r from-slate-950 via-slate-900 to-red-950 text-white rounded-full shadow-2xl border-2 border-red-500/80 hover:border-red-400 hover:scale-105 active:scale-95 transition-all duration-300 relative overflow-hidden"
          aria-label="کانال‌ها و راه‌های ارتباطی پین‌پارت"
        >
          {/* Ambient Glow */}
          <div className="absolute inset-0 bg-red-600/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300 blur-sm pointer-events-none"></div>

          {/* Logo / Close Badge */}
          <div className="relative z-10 w-11 h-11 bg-white rounded-full flex items-center justify-center shadow-md shrink-0 overflow-hidden">
            {isOpen ? (
              <Close className="!w-6 !h-6 text-slate-900" />
            ) : (
              <img 
                src="/logo.png" 
                alt="Pinpart Logo" 
                className="w-full h-full object-cover rounded-full"
                onError={(e) => {
                  const target = e.target as HTMLImageElement;
                  target.src = '/PinpartStore.JPEG';
                }}
              />
            )}
          </div>

          {/* Explicit Label & Status - اشاره واضح به کانال‌ها و ارتباط‌ها */}
          <div className="relative z-10 text-right pr-1" dir="rtl">
            <div className="flex items-center gap-1.5">
              <span className="relative flex h-2 w-2">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
              </span>
              <span className="font-black text-white text-xs sm:text-sm tracking-tight whitespace-nowrap">
                کانال‌ها و ارتباط سریع
              </span>
            </div>
            <div className="text-[10px] text-red-300 font-medium whitespace-nowrap">
              واتساپ • تلگرام • استعلام قیمت
            </div>
          </div>
        </button>
      </div>

      {/* Expanded Toolbar Drawer - طراحی تیره لوکس با UX شفاف */}
      {isOpen && (
        <div className="fixed left-4 sm:left-6 bottom-24 z-[9998] animate-fade-in" dir="rtl">
          <div className="bg-slate-950 rounded-3xl shadow-2xl border border-slate-800 overflow-hidden w-84 sm:w-96 max-h-[85vh] overflow-y-auto">
            
            {/* Drawer Header */}
            <div className="bg-gradient-to-r from-slate-950 via-slate-900 to-red-950 p-4 border-b border-slate-800 relative">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className="w-12 h-12 bg-white rounded-2xl flex items-center justify-center shadow-lg border border-slate-700/60 shrink-0 overflow-hidden">
                    <img 
                      src="/logo.png" 
                      alt="Pinpart Logo" 
                      className="w-full h-full object-cover rounded-2xl"
                      onError={(e) => {
                        const target = e.target as HTMLImageElement;
                        target.src = '/PinpartStore.JPEG';
                      }}
                    />
                  </div>
                  <div>
                    <div className="flex items-center gap-1.5">
                      <h3 className="text-white font-black text-base">پین‌پارت</h3>
                      <span className="px-2 py-0.5 bg-red-600 text-white text-[10px] font-bold rounded-md">عمده</span>
                    </div>
                    <p className="text-[11px] text-slate-300 mt-0.5">کانال‌های رسمی و پشتیبانی مستقیم</p>
                  </div>
                </div>

                <button
                  onClick={handleClose}
                  className="p-1.5 text-slate-400 hover:text-white hover:bg-slate-800 rounded-xl transition"
                  aria-label="بستن"
                >
                  <Close className="!w-5 !h-5" />
                </button>
              </div>

              {/* Online Form Action Button inside Drawer */}
              <div className="mt-3 pt-3 border-t border-slate-800/80">
                <button
                  onClick={() => {
                    handleClose();
                    setIsModalOpen(true);
                  }}
                  className="w-full py-2.5 px-3 bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white rounded-xl text-xs font-bold transition shadow-md flex items-center justify-center gap-2"
                >
                  <MessageSquare className="h-4 w-4" />
                  <span>ثبت آنلاین استعلام قیمت و پیش‌فاکتور</span>
                </button>
              </div>
            </div>

            {/* Channels List */}
            <div className="p-3.5 space-y-2.5">
              <div className="text-[11px] font-bold text-slate-400 px-1">
                شبکه‌ها و خطوط ارتباطی چراغ برق:
              </div>

              {socialChannels.map((channel) => (
                <button
                  key={channel.id}
                  onClick={() => handleChannelClick(channel.id, channel.url)}
                  className={`w-full flex items-center gap-3 p-3 rounded-2xl border transition-all duration-200 text-right group ${
                    activeChannel === channel.id
                      ? 'border-red-500/80 bg-slate-900 shadow-md'
                      : 'border-slate-800/80 bg-slate-900/60 hover:bg-slate-900 hover:border-slate-700'
                  }`}
                >
                  <div className={`p-2.5 rounded-xl ${channel.color} text-white shadow-md shrink-0 group-hover:scale-105 transition-transform`}>
                    {channel.icon}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between">
                      <span className="text-xs font-bold text-white group-hover:text-red-400 transition-colors">
                        {channel.name}
                      </span>
                      <span className="text-[10px] px-2 py-0.5 rounded-md bg-slate-800 text-slate-300 border border-slate-700">
                        {channel.tag}
                      </span>
                    </div>
                    <div className="text-[11px] text-slate-400 truncate mt-0.5">
                      {channel.desc}
                    </div>
                  </div>
                </button>
              ))}
            </div>

            {/* Quick Phones Footer */}
            <div className="p-3.5 pt-2 bg-slate-900/40 border-t border-slate-800/80 text-xs">
              <div className="bg-slate-900 p-2.5 rounded-xl border border-slate-800 flex items-center justify-between">
                <div>
                  <span className="text-slate-400 text-[11px] block">واحد فروش و استعلام عمده:</span>
                  <a href="tel:09196408805" className="text-red-400 font-bold font-mono text-sm hover:underline">
                    ۰۹۱۹۶۴۰۸۸۰۵
                  </a>
                </div>
                <a
                  href="tel:09196408805"
                  className="px-3.5 py-1.5 bg-red-600 hover:bg-red-500 text-white rounded-xl text-xs font-bold transition flex items-center gap-1 shadow-md font-mono"
                >
                  <Phone className="!w-3.5 !h-3.5" />
                  <span>تماس</span>
                </a>
              </div>
            </div>

          </div>
        </div>
      )}

      {/* Backdrop */}
      {isOpen && (
        <div
          className="fixed inset-0 bg-black/40 backdrop-blur-sm z-[9997]"
          onClick={handleClose}
          aria-hidden="true"
        />
      )}

      {/* Quote Inquiry Modal */}
      <CallRequestModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        defaultPartName="استعلام از طریق نوار ارتباطی"
      />
    </>
  );
};

export default PinpartSocialToolbarFinal;