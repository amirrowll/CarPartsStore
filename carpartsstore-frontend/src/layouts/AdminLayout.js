import { Link, Outlet } from 'react-router-dom';
const AdminLayout = () => {
    return (<div className="min-h-screen bg-gray-50">
      <div className="grid grid-cols-12">
        <aside className="col-span-2 bg-white border-r p-4 min-h-screen">
          <div className="mb-6">
            <img src="/logo192.png" alt="Logo" className="w-12 h-12 rounded"/>
            <h3 className="mt-2 font-bold">Admin</h3>
          </div>
          <nav className="flex flex-col gap-2">
            <Link to="/admin" className="text-sm p-2 rounded hover:bg-gray-100">داشبورد</Link>
            <Link to="/admin/products" className="text-sm p-2 rounded hover:bg-gray-100">محصولات</Link>
            <Link to="/admin/orders" className="text-sm p-2 rounded hover:bg-gray-100">سفارش‌ها</Link>
            <Link to="/admin/users" className="text-sm p-2 rounded hover:bg-gray-100">کاربران</Link>
          </nav>
        </aside>

        <main className="col-span-10 p-6">
          <Outlet />
        </main>
      </div>
    </div>);
};
export default AdminLayout;
