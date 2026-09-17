import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import Navbar from '../../components/Navbar';
const AdminLoginPage = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const { login, user: authUser, isAdmin } = useAuth();
    const navigate = useNavigate();
    useEffect(() => {
        // اگر کاربر لاگین کرده و ادمین است، به داشبورد هدایت کن
        if (authUser && isAdmin) {
            navigate('/admin/dashboard');
        }
    }, [authUser, isAdmin, navigate]);
    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');
        setLoading(true);
        try {
            // Note: We use username as email field, our backend accepts phone number as username
            await login({ email: username, password });
            // Navigation will be handled by the useEffect above
        }
        catch (error) {
            setError(error.response?.data?.message || error.message || 'خطا در ورود. لطفاً دوباره تلاش کنید.');
        }
        finally {
            setLoading(false);
        }
    };
    return (<div className="min-h-screen flex flex-col">
      {/* هدر سایت اصلی */}
      <Navbar />
      
      {/* محتوای صفحه لاگین */}
      <main className="flex-grow bg-gradient-to-br from-gray-900 to-gray-800 flex items-center justify-center p-4">
        <div className="max-w-md w-full">
          <div className="bg-gray-800 rounded-2xl p-8 shadow-2xl border border-gray-700">
            <div className="text-center mb-8">
              <h2 className="text-3xl font-bold text-white mb-2">ورود به پنل مدیریت</h2>
              <p className="text-gray-400">برای دسترسی به بخش مدیریت وارد شوید</p>
            </div>

            {error && (<div className="mb-6 rounded-xl bg-red-900/30 border border-red-700 p-4">
                <p className="text-sm text-red-300">{error}</p>
              </div>)}

            <form onSubmit={handleSubmit} className="space-y-6">
              <div>
                <label className="block text-sm font-medium text-gray-300 mb-2">
                  نام کاربری / شماره تلفن
                </label>
                <input type="text" required value={username} onChange={(e) => setUsername(e.target.value)} placeholder="نام کاربری یا شماره تلفن" className="w-full rounded-xl bg-gray-700 border border-gray-600 text-white px-4 py-3 outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500"/>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-300 mb-2">
                  رمز عبور
                </label>
                <input type="password" required value={password} onChange={(e) => setPassword(e.target.value)} placeholder="••••••••" className="w-full rounded-xl bg-gray-700 border border-gray-600 text-white px-4 py-3 outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500"/>
              </div>

              <button type="submit" disabled={loading} className="w-full rounded-xl bg-gradient-to-r from-blue-600 to-blue-700 py-4 text-sm font-semibold text-white transition hover:from-blue-700 hover:to-blue-800 disabled:cursor-not-allowed disabled:opacity-50 shadow-lg">
                {loading ? 'در حال ورود...' : 'ورود به پنل مدیریت'}
              </button>
            </form>

            {/* بخش پایینی با پیام فراموشی رمز */}
            <div className="mt-8 pt-6 border-t border-gray-700">
              <div className="rounded-xl bg-gray-900/50 p-4 border border-gray-700">
                <p className="text-sm font-semibold text-gray-300 mb-2">توجه:</p>
                <div className="text-sm text-gray-400 space-y-1">
                  <p>این صفحه فقط برای دسترسی ادمینهای مجاز است.</p>
                  <p className="text-xs text-gray-500 mt-2">در صورت فراموشی رمز عبور با مدیر سیستم تماس بگیرید.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
      
      {/* فوتر حذف شده است */}
    </div>);
};
export default AdminLoginPage;
