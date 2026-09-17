import { useEffect, useState } from 'react';
import { orderService } from '../../services/api';
import { sampleOrders } from '../../utils/sampleData';
const AdminOrders = () => {
    const [orders, setOrders] = useState(sampleOrders);
    useEffect(() => {
        orderService.getOrders()
            .then((data) => setOrders(data))
            .catch(() => setOrders(sampleOrders));
    }, []);
    return (<div className="space-y-6">
      <div>
        <h2 className="text-3xl font-semibold">سفارش‌ها</h2>
        <p className="mt-2 text-gray-600">آخرین سفارش‌ها و وضعیت پردازش آن‌ها را اینجا ببینید.</p>
      </div>
      <div className="overflow-x-auto rounded-[32px] bg-white p-6 shadow-xl">
        <table className="min-w-full text-left text-sm text-slate-600">
          <thead className="border-b border-slate-200 text-slate-900">
            <tr>
              <th className="py-4">شماره سفارش</th>
              <th className="py-4">مشتری</th>
              <th className="py-4">مبلغ</th>
              <th className="py-4">وضعیت</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-slate-200">
            {orders.map((order) => (<tr key={order.id} className="hover:bg-slate-50">
                <td className="py-4 font-semibold text-slate-900">#{order.id}</td>
                <td className="py-4">{order.customer}</td>
                <td className="py-4">{order.totalAmount} تومان</td>
                <td className="py-4 text-slate-700">{order.status}</td>
              </tr>))}
          </tbody>
        </table>
      </div>
    </div>);
};
export default AdminOrders;
