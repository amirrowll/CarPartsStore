import React, { useState, useEffect } from 'react';
import { X, Phone, CheckCircle, AlertCircle, Send, ShieldCheck } from 'lucide-react';
import api from '../services/api';

interface CallRequestModalProps {
  isOpen: boolean;
  onClose: () => void;
  defaultCategory?: string;
  defaultPartName?: string;
  productName?: string;
}

const CallRequestModal: React.FC<CallRequestModalProps> = ({
  isOpen,
  onClose,
  defaultCategory = '',
  defaultPartName = '',
  productName = ''
}) => {
  const initialPart = productName || defaultPartName || '';
  const [phoneNumber, setPhoneNumber] = useState('');
  const [name, setName] = useState('');
  const [category, setCategory] = useState(defaultCategory);
  const [note, setNote] = useState(initialPart ? `استعلام قطعه: ${initialPart}` : '');
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    const part = productName || defaultPartName || '';
    if (part) {
      setNote(`استعلام قطعه: ${part}`);
    }
    if (defaultCategory) {
      setCategory(defaultCategory);
    }
  }, [productName, defaultPartName, defaultCategory, isOpen]);

  if (!isOpen) return null;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    const cleanPhone = phoneNumber.trim();
    if (!cleanPhone.match(/^09\d{9}$/)) {
      setError('لطفاً شماره موبایل معتبر ۱۱ رقمی وارد کنید (مثال: 09123456789)');
      return;
    }

    setLoading(true);
    try {
      await api.post('/contact/call-request', {
        phoneNumber: cleanPhone,
        name: name.trim() || undefined,
        category: category || undefined,
        note: note.trim() || undefined
      });

      setSuccess(true);
      setTimeout(() => {
        setSuccess(false);
        setPhoneNumber('');
        setName('');
        setNote('');
        onClose();
      }, 2500);
    } catch (err: any) {
      setError(
        err.response?.data?.message || 
        'خطا در ثبت درخواست. لطفاً مستقیماً با واحد فروش به شماره ۰۹۱۹۶۴۰۸۸۰۵ تماس بگیرید.'
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/70 backdrop-blur-sm animate-fade-in" dir="rtl">
      <div 
        className="relative w-full max-w-lg bg-slate-900 border border-slate-800 rounded-3xl shadow-2xl overflow-hidden p-6 sm:p-8"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Close Button */}
        <button
          onClick={onClose}
          className="absolute top-5 left-5 p-2 text-slate-400 hover:text-white rounded-full bg-slate-800/80 hover:bg-slate-700 transition"
          aria-label="بستن"
        >
          <X className="h-5 w-5" />
        </button>

        {/* Modal Header */}
        <div className="flex items-center gap-3 mb-6">
          <div className="w-12 h-12 rounded-2xl bg-red-500/10 border border-red-500/30 flex items-center justify-center text-red-500 shrink-0">
            <Phone className="h-6 w-6" />
          </div>
          <div>
            <h2 className="text-xl font-black text-white">ثبت استعلام قیمت عمده و پیش‌فاکتور</h2>
            <p className="text-xs text-slate-400 mt-0.5">
              پین‌پارت؛ تولید و پخش عمده ملزومات خودرویی چراغ برق
            </p>
          </div>
        </div>

        {/* Success Alert */}
        {success ? (
          <div className="p-6 text-center bg-emerald-950/80 border border-emerald-800 rounded-2xl space-y-3">
            <CheckCircle className="h-12 w-12 text-emerald-400 mx-auto animate-bounce" />
            <h3 className="text-base font-bold text-white">درخواست شما با موفقیت ثبت شد</h3>
            <p className="text-xs text-emerald-300 leading-relaxed">
              کارشناسان فروش پین‌پارت در کمتر از ۲۰ دقیقه با شما تماس خواهند گرفت.
            </p>
          </div>
        ) : (
          <form onSubmit={handleSubmit} className="space-y-4">
            {error && (
              <div className="p-3 bg-rose-950/80 border border-rose-800 text-rose-300 rounded-xl text-xs flex items-center gap-2">
                <AlertCircle className="h-4 w-4 shrink-0 text-rose-400" />
                <span>{error}</span>
              </div>
            )}

            <div>
              <label className="block text-xs font-medium text-slate-300 mb-1.5">
                شماره موبایل جهت هماهنگی و قیمت <span className="text-red-400">*</span>
              </label>
              <input
                type="tel"
                required
                value={phoneNumber}
                onChange={(e) => setPhoneNumber(e.target.value)}
                placeholder="09123456789"
                dir="ltr"
                className="w-full bg-slate-950 border border-slate-700 rounded-xl px-4 py-3 text-sm text-white placeholder-slate-500 focus:outline-none focus:border-red-500 transition font-mono text-right"
              />
            </div>

            <div>
              <label className="block text-xs font-medium text-slate-300 mb-1.5">
                نام و نام خانوادگی / نام فروشگاه (اختیاری)
              </label>
              <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="مثال: فروشگاه یدک امین"
                className="w-full bg-slate-950 border border-slate-700 rounded-xl px-4 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-red-500 transition"
              />
            </div>

            <div>
              <label className="block text-xs font-medium text-slate-300 mb-1.5">
                توضیحات یا قطعه مدنظر
              </label>
              <textarea
                rows={3}
                value={note}
                onChange={(e) => setNote(e.target.value)}
                placeholder="نام قطعه، تیراژ یا کد فنی مورد نظرتان را بنویسید..."
                className="w-full bg-slate-950 border border-slate-700 rounded-xl px-4 py-2.5 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-red-500 transition resize-none"
              />
            </div>

            <div className="pt-2">
              <button
                type="submit"
                disabled={loading}
                className="w-full py-3 bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white rounded-xl text-xs font-bold transition shadow-lg flex items-center justify-center gap-2 disabled:opacity-50"
              >
                {loading ? (
                  <>
                    <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"></div>
                    <span>در حال ثبت درخواست...</span>
                  </>
                ) : (
                  <>
                    <Send className="h-4 w-4" />
                    <span>ارسال درخواست تماس و پیش‌فاکتور</span>
                  </>
                )}
              </button>
            </div>

            <div className="flex items-center justify-between pt-3 border-t border-slate-800 text-[11px] text-slate-400">
              <span className="flex items-center gap-1">
                <ShieldCheck className="h-3.5 w-3.5 text-emerald-400" />
                تضمین کف قیمت بازار تهران
              </span>
              <a href="tel:09196408805" className="text-red-400 hover:underline font-mono font-bold">
                تماس فوری: ۰۹۱۹۶۴۰۸۸۰۵
              </a>
            </div>
          </form>
        )}
      </div>
    </div>
  );
};

export default CallRequestModal;
