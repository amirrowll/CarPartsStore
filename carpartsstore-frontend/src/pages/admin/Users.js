import { useEffect, useState } from 'react';
import { adminService } from '../../services/api';
import { sampleUsers } from '../../utils/sampleData';
const AdminUsers = () => {
    const [users, setUsers] = useState(sampleUsers);
    useEffect(() => {
        adminService.getAllUsers()
            .then((data) => setUsers(data))
            .catch(() => setUsers(sampleUsers));
    }, []);
    return (<div className="space-y-6">
      <div>
        <h2 className="text-3xl font-semibold">کاربران</h2>
        <p className="mt-2 text-gray-600">لیست کاربران ثبت‌نام شده و وضعیت آن‌ها را مدیریت کنید.</p>
      </div>
      <div className="grid gap-4 md:grid-cols-2">
        {users.map((user) => (<div key={user.id} className="rounded-[28px] border border-slate-200 bg-white p-5 shadow-sm">
            <div className="flex items-center justify-between gap-4">
              <div>
                <h3 className="text-lg font-semibold text-slate-900">{user.firstName} {user.lastName}</h3>
                <p className="mt-1 text-sm text-gray-500">{user.email}</p>
              </div>
              <span className="rounded-full bg-slate-100 px-3 py-1 text-sm text-slate-700">کاربر عادی</span>
            </div>
          </div>))}
      </div>
    </div>);
};
export default AdminUsers;
