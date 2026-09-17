import React, { useState } from 'react';
import { WhatsApp, Telegram, Instagram, Message, Close, ChevronLeft, OpenInNew } from '@mui/icons-material';

const PinpartSocialToolbarFinal: React.FC = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [activeChannel, setActiveChannel] = useState<string | null>(null);

  const socialChannels = [
    {
      id: 'whatsapp1',
      name: 'کانال اول',
      icon: <WhatsApp fontSize="small" />,
      url: 'https://chat.whatsapp.com/CGCLTGEoouVEfgybJMlWw8?mode=wwc',
      color: 'bg-green-500 hover:bg-green-600',
      textColor: 'text-green-700',
    },
    {
      id: 'whatsapp2',
      name: 'کانال دوم',
      icon: <WhatsApp fontSize="small" />,
      url: 'https://chat.whatsapp.com/KswfWmJSRAsGI5TAHVO1Hi',
      color: 'bg-green-600 hover:bg-green-700',
      textColor: 'text-green-800',
    },
    {
      id: 'telegram',
      name: 'کانال تلگرام',
      icon: <Telegram fontSize="small" />,
      url: 'https://t.me/pinparts',
      color: 'bg-blue-500 hover:bg-blue-600',
      textColor: 'text-blue-700',
    },
    {
      id: 'instagram',
      name: 'صفحه اینستاگرام',
      icon: <Instagram fontSize="small" />,
      url: 'https://instagram.com/pinparts',
      color: 'bg-gradient-to-r from-pink-500 to-purple-500 hover:from-pink-600 hover:to-purple-600',
      textColor: 'text-pink-700',
    }
  ];

  const handleChannelClick = (channelId: string, url: string) => {
    setActiveChannel(channelId);
    window.open(url, '_blank');
  };

  const handleClose = () => {
    setIsOpen(false);
    setActiveChannel(null);
  };

  return (
    <>
      {/* Floating Toolbar Button */}
      <div className="fixed left-4 bottom-4 z-[9999]">
        <button
          onClick={() => setIsOpen(!isOpen)}
          className="group flex items-center justify-center w-16 h-16 bg-gradient-to-r from-blue-600 to-blue-800 text-white rounded-full shadow-2xl hover:shadow-3xl hover:scale-110 transition-all duration-300 relative overflow-hidden"
          aria-label="کانال های ارتباطی پین پارت"
        >
          {/* Background Animation */}
          <div className="absolute inset-0 bg-gradient-to-r from-blue-500 to-blue-700 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
          
          {/* Logo/Icon */}
          <div className="relative z-10">
            {isOpen ? (
              <Close className="!w-7 !h-7" />
            ) : (
              <div className="flex flex-col items-center">
                <Message className="!w-6 !h-6 mb-1 group-hover:rotate-12 transition-transform" />
                <div className="text-[8px] font-bold tracking-wider">PINPART</div>
              </div>
            )}
          </div>

          {/* Pulse Animation */}
          {!isOpen && (
            <div className="absolute inset-0 border-2 border-blue-400 rounded-full animate-ping opacity-20"></div>
          )}
        </button>

        {/* Tooltip when closed */}
        {!isOpen && (
          <div className="absolute left-20 bottom-4 bg-gradient-to-r from-gray-900 to-gray-800 text-white text-sm px-4 py-2 rounded-lg shadow-xl opacity-0 group-hover:opacity-100 transition-opacity duration-300 whitespace-nowrap pointer-events-none">
            <div className="flex items-center gap-2">
              <ChevronLeft className="!w-4 !h-4" />
              <div>
                <div className="font-bold">کانال های پین پارت</div>
                <div className="text-xs text-blue-300">دسترسی سریع</div>
              </div>
            </div>
            <div className="absolute right-full top-1/2 transform -translate-y-1/2 border-8 border-transparent border-r-gray-800"></div>
          </div>
        )}
      </div>

      {/* Expanded Toolbar */}
      {isOpen && (
        <div className="fixed left-4 bottom-24 z-[9998] animate-fade-in">
          <div className="bg-white rounded-2xl shadow-2xl border border-gray-200 overflow-hidden w-80 max-h-[80vh] overflow-y-auto">
            {/* Header with Pinpart Branding */}
            <div className="bg-gradient-to-r from-blue-600 to-blue-800 p-4 relative overflow-hidden">
              {/* Decorative Elements */}
              <div className="absolute top-0 right-0 w-20 h-20 bg-white/10 rounded-full -translate-y-10 translate-x-10"></div>
              <div className="absolute bottom-0 left-0 w-16 h-16 bg-white/10 rounded-full translate-y-8 -translate-x-8"></div>
              
              <div className="relative z-10">
                <div className="flex items-center justify-between mb-3">
                  <div className="flex items-center gap-3">
                    <div className="p-2 bg-white/20 backdrop-blur-sm rounded-xl">
                      <Message className="!w-6 !h-6 text-white" />
                    </div>
                    <div>
                      <h3 className="text-white font-bold text-lg">کانال های پین پارت</h3>
                      <p className="text-blue-100 text-sm">دسترسی سریع به پشتیبانی</p>
                    </div>
                  </div>
                  <button
                    onClick={handleClose}
                    className="p-1.5 text-white/80 hover:text-white hover:bg-white/20 rounded-lg transition-colors"
                    aria-label="بستن"
                  >
                    <Close className="!w-5 !h-5" />
                  </button>
                </div>
                
                {/* Pinpart Brand */}
                <div className="flex items-center gap-2 px-3 py-2 bg-white/15 rounded-lg backdrop-blur-sm">
                  <div className="w-8 h-8 bg-white rounded-full flex items-center justify-center">
                    <span className="text-blue-600 font-bold text-xs">PP</span>
                  </div>
                  <div>
                    <div className="text-white font-bold">Pinpart Store</div>
                    <div className="text-blue-200 text-xs">تخصصی ترین فروشگاه لوازم یدکی</div>
                  </div>
                </div>
              </div>
            </div>

            {/* Channels List */}
            <div className="p-4">
              <div className="space-y-3">
                {socialChannels.map((channel) => (
                  <button
                    key={channel.id}
                    onClick={() => handleChannelClick(channel.id, channel.url)}
                    className={`w-full flex items-center gap-3 p-3 rounded-xl border transition-all duration-300 hover:scale-[1.02] active:scale-[0.98] ${
                      activeChannel === channel.id
                        ? 'border-blue-300 bg-blue-50 shadow-md'
                        : 'border-gray-200 hover:border-gray-300 hover:bg-gray-50'
                    }`}
                  >
                    <div className={`p-3 rounded-lg ${channel.color} text-white transition-colors flex-shrink-0`}>
                      {channel.icon}
                    </div>
                    <div className="flex-1 text-right min-w-0">
                      <div className="flex items-center justify-between">
                        <span className={`text-sm font-bold ${channel.textColor}`}>
                          {channel.name}
                        </span>
                      </div>
                      <div className="mt-1 flex items-center justify-between">
                        <span className="text-xs text-gray-600 truncate max-w-[160px]">
                          {channel.url.replace('https://', '')}
                        </span>
                        <OpenInNew className="!w-3 !h-3 text-gray-400 flex-shrink-0" />
                      </div>
                    </div>
                  </button>
                ))}
              </div>

              {/* Quick Stats */}
              <div className="mt-6 pt-4 border-t border-gray-200">
                <div className="grid grid-cols-2 gap-3">
                  <div className="text-center p-3 bg-gradient-to-r from-green-50 to-green-100 rounded-lg border border-green-200">
                    <div className="text-green-700 font-bold text-lg">۲ گروه</div>
                    <div className="text-green-800 text-xs font-medium">واتساپ فعال</div>
                  </div>
                  <div className="text-center p-3 bg-gradient-to-r from-blue-50 to-blue-100 rounded-lg border border-blue-200">
                    <div className="text-blue-700 font-bold text-lg">۲ کانال</div>
                    <div className="text-blue-800 text-xs font-medium">شبکه اجتماعی</div>
                  </div>
                </div>
              </div>

              {/* Contact Info */}
              <div className="mt-4 pt-4 border-t border-gray-200">
                <div className="text-center">
                  <div className="text-xs text-gray-600 mb-2">پشتیبانی ۲۴ ساعته</div>
                  <div className="flex flex-col gap-2 items-center">
                    <div className="text-xs text-gray-700">
                      <span className="font-bold">پشتیبانی:</span> ۰۹۱۹۶۴۰۸۸۰۵
                    </div>
                    <div className="text-xs text-gray-700">
                      <span className="font-bold">مدیریت:</span> ۰۹۳۰۸۳۶۸۰۸۹
                    </div>
                  </div>
                </div>
              </div>

              {/* Footer */}
              <div className="mt-4 pt-4 border-t border-gray-200">
                <p className="text-xs text-gray-600 text-center">
                  © {new Date().getFullYear()} Pinpart Store - تمامی حقوق محفوظ است
                </p>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Backdrop */}
      {isOpen && (
        <div
          className="fixed inset-0 bg-black/20 z-[9997] backdrop-blur-sm"
          onClick={handleClose}
          aria-hidden="true"
        />
      )}

      {/* Custom Animation */}
      <style>
        {`
          @keyframes fade-in {
            from {
              opacity: 0;
              transform: translateY(10px);
            }
            to {
              opacity: 1;
              transform: translateY(0);
            }
          }
          .animate-fade-in {
            animation: fade-in 0.3s ease-out;
          }
          
          /* Scrollbar styling */
          .overflow-y-auto::-webkit-scrollbar {
            width: 6px;
          }
          .overflow-y-auto::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 3px;
          }
          .overflow-y-auto::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 3px;
          }
          .overflow-y-auto::-webkit-scrollbar-thumb:hover {
            background: #a1a1a1;
          }
          
          /* Cursor pointer for all interactive elements */
          button {
            cursor: pointer;
          }
        `}
      </style>
    </>
  );
};

export default PinpartSocialToolbarFinal;