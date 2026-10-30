import React, { useEffect, useState } from 'react';
import api from '../../services/api';
import { 
  Phone, 
  Search, 
  RefreshCw, 
  Calendar, 
  User, 
  FileText, 
  Layers, 
  ExternalLink,
  PhoneCall,
  CheckCircle2,
  Clock
} from 'lucide-react';
import { WhatsApp } from '@mui/icons-material';

interface CallRequest {
  phoneNumber: string;
  name?: string;
  category?: string;
  note?: string;
  email?: string;
  createdAt: string;
}

const CallRequests: React.FC = () => {
  const [requests, setRequests] = useState<CallRequest[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');

  const fetchRequests = async () => {
    setLoading(true);
    try {
      const res = await api.get('/contact/call-requests');
      setRequests(Array.isArray(res.data) ? res.data : []);
    } catch (err) {
      console.error('Error fetching call requests:', err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchRequests();
  }, []);

  const filteredRequests = requests.filter((r) => {
    if (!searchQuery.trim()) return true;
    const q = searchQuery.toLowerCase().trim();
    return (
      r.phoneNumber.toLowerCase().includes(q) ||
      (r.name || '').toLowerCase().includes(q) ||
      (r.category || '').toLowerCase().includes(q) ||
      (r.note || '').toLowerCase().includes(q)
    );
  });

  const formatDate = (dateStr: string) => {
    try {
      const d = new Date(dateStr);
      return d.toLocaleString('fa-IR', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
      });
    } catch {
      return dateStr;
    }
  };

  return (
    <div className="space-y-6" dir="rtl">
      
      {/* Header Banner */}
      <div className="rounded-3xl bg-gradient-to-br from-slate-900 via-slate-800 to-red-950 p-6 sm:p-8 text-white shadow-xl border border-slate-700/60 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-red-600/30 border border-red-500/40 text-red-300 text-xs font-bold mb-2">
            <PhoneCall className="h-3.5 w-3.5" />
            <span>مدیریت لیدها و استعلام‌های عمده</span>
          </div>
          <h1 className="text-2xl sm:text-3xl font-black tracking-tight">
            درخواست‌های تماس و استعلام قیمت همکاران
          </h1>
          <p className="text-xs sm:text-sm text-slate-300 mt-1 max-w-xl">
            لیست شماره تماس و پیش‌فاکتورهایی که مشتریان از طریق فرم سایت، بخش هیرو و کاتالوگ ثبت کرده‌اند.
          </p>
        </div>

        <div className="flex items-center gap-3">
          <button
            onClick={fetchRequests}
            disabled={loading}
            className="px-4 py-2.5 bg-slate-800 hover:bg-slate-700 text-white rounded-xl text-xs font-bold transition flex items-center gap-1.5 border border-slate-600 shadow"
          >
            <RefreshCw className={`h-4 w-4 ${loading ? 'animate-spin' : ''}`} />
            <span>بروزرسانی لیست</span>
          </button>
        </div>
      </div>

      {/* Search and Stats Bar */}
      <div className="bg-white rounded-2xl p-4 sm:p-5 border border-slate-200 shadow-sm flex flex-col sm:flex-row items-center justify-between gap-4">
        <div className="relative w-full sm:w-80">
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="جستجوی شماره موبایل، نام یا قطعه..."
            className="w-full pr-10 pl-4 py-2.5 bg-slate-50 border border-slate-300 rounded-xl text-xs text-slate-800 placeholder-slate-400 focus:outline-none focus:border-red-500 transition"
          />
          <Search className="absolute right-3.5 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400" />
        </div>

        <div className="flex items-center gap-4 text-xs font-bold text-slate-600 w-full sm:w-auto justify-between sm:justify-end">
          <div className="flex items-center gap-1.5 bg-slate-100 px-3 py-1.5 rounded-xl border border-slate-200">
            <span>تعداد کل درخواست‌ها:</span>
            <span className="text-red-600 font-mono text-sm">{requests.length}</span>
          </div>
          <div className="flex items-center gap-1.5 bg-emerald-50 px-3 py-1.5 rounded-xl border border-emerald-200 text-emerald-700">
            <Clock className="h-3.5 w-3.5" />
            <span>پاسخگویی سریع زیر ۲۰ دقیقه</span>
          </div>
        </div>
      </div>

      {/* Requests Table */}
      <div className="bg-white rounded-3xl border border-slate-200 shadow-sm overflow-hidden">
        {loading ? (
          <div className="py-20 text-center">
            <div className="w-10 h-10 border-4 border-red-500/20 border-t-red-600 rounded-full animate-spin mx-auto mb-3"></div>
            <p className="text-xs text-slate-500">در حال دریافت لیست درخواست‌های مشتریان...</p>
          </div>
        ) : filteredRequests.length === 0 ? (
          <div className="py-16 text-center text-slate-500">
            <Phone className="h-12 w-12 text-slate-300 mx-auto mb-3" />
            <h3 className="text-base font-bold text-slate-700 mb-1">درخواستی یافت نشد</h3>
            <p className="text-xs text-slate-400">
              هنوز شماره‌ای ثبت نشده است یا با فیلتر جستجو همخوانی ندارد.
            </p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-right text-xs">
              <thead className="bg-slate-50 text-slate-700 font-bold border-b border-slate-200">
                <tr>
                  <th className="py-3.5 px-4">ردیف</th>
                  <th className="py-3.5 px-4">شماره تماس مشتری</th>
                  <th className="py-3.5 px-4">نام / نام فروشگاه</th>
                  <th className="py-3.5 px-4">دسته‌بندی قطعه</th>
                  <th className="py-3.5 px-4">توضیحات و اقلام</th>
                  <th className="py-3.5 px-4">زمان ثبت درخواست</th>
                  <th className="py-3.5 px-4 text-center">اقدام سریع</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-100">
                {filteredRequests.map((req, idx) => (
                  <tr key={idx} className="hover:bg-slate-50/80 transition-colors">
                    <td className="py-4 px-4 font-mono font-medium text-slate-400">
                      {idx + 1}
                    </td>

                    <td className="py-4 px-4 font-bold text-slate-900 font-mono text-sm whitespace-nowrap">
                      <div className="flex items-center gap-1.5" dir="ltr">
                        <span className="w-2 h-2 rounded-full bg-emerald-500"></span>
                        <a 
                          href={`tel:${req.phoneNumber}`}
                          className="hover:text-red-600 hover:underline"
                        >
                          {req.phoneNumber}
                        </a>
                      </div>
                    </td>

                    <td className="py-4 px-4 font-medium text-slate-800">
                      {req.name ? (
                        <div className="flex items-center gap-1.5">
                          <User className="h-3.5 w-3.5 text-slate-400" />
                          <span>{req.name}</span>
                        </div>
                      ) : (
                        <span className="text-slate-400 italic">نامشخص</span>
                      )}
                    </td>

                    <td className="py-4 px-4">
                      {req.category ? (
                        <span className="px-2.5 py-1 bg-slate-100 text-slate-700 rounded-lg font-medium border border-slate-200">
                          {req.category}
                        </span>
                      ) : (
                        <span className="text-slate-400 italic">عمومی</span>
                      )}
                    </td>

                    <td className="py-4 px-4 max-w-xs text-slate-600 leading-relaxed">
                      {req.note ? (
                        <div className="line-clamp-2" title={req.note}>
                          {req.note}
                        </div>
                      ) : (
                        <span className="text-slate-400 italic">بدون یادداشت</span>
                      )}
                    </td>

                    <td className="py-4 px-4 text-slate-500 whitespace-nowrap font-medium">
                      <div className="flex items-center gap-1 text-[11px]">
                        <Calendar className="h-3 w-3 text-slate-400" />
                        <span>{formatDate(req.createdAt)}</span>
                      </div>
                    </td>

                    <td className="py-4 px-4 text-center whitespace-nowrap">
                      <div className="flex items-center justify-center gap-2">
                        <a
                          href={`tel:${req.phoneNumber}`}
                          className="px-3 py-1.5 bg-red-600 hover:bg-red-700 text-white rounded-lg font-bold transition flex items-center gap-1 shadow-sm"
                          title="تماس فوری تلفنی با مشتری"
                        >
                          <Phone className="h-3.5 w-3.5" />
                          <span>تماس</span>
                        </a>

                        <a
                          href={`https://wa.me/98${req.phoneNumber.replace(/^0/, '')}?text=${encodeURIComponent(
                            `سلام، از واحد فروش شرکت پین‌پارت در رابطه با استعلام ثبت‌شده شما (${req.note || 'ملزومات خودرویی'}) پیام می‌دهم.`
                          )}`}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="px-3 py-1.5 bg-emerald-600 hover:bg-emerald-700 text-white rounded-lg font-bold transition flex items-center gap-1 shadow-sm"
                          title="ارسال پیام واتساپ به مشتری"
                        >
                          <WhatsApp className="!w-3.5 !h-3.5" />
                          <span>واتساپ</span>
                        </a>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

    </div>
  );
};

export default CallRequests;
