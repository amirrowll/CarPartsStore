# راهنمای نصب و راهاندازی سیستم جستجوی پیشرفته

## 📋 پیشنیازها

### Backend (ASP.NET Core)
- [x] .NET 8.0 یا بالاتر
- [x] SQLite یا SQL Server
- [x] Visual Studio 2022 یا VS Code

### Frontend (React + TypeScript)
- [x] Node.js 18.x یا بالاتر
- [x] npm یا yarn
- [x] مرورگر مدرن (Chrome, Firefox, Edge)

## 🚀 راهاندازی سریع

### مرحله ۱: راهاندازی بکاند
```bash
cd CarPartsStore.API
dotnet restore
dotnet build
dotnet run
```

### مرحله ۲: راهاندازی فرانتاند
```bash
cd carpartsstore-frontend
npm install
npm run dev
```

### مرحله ۳: دسترسی به سیستم
- فرانتاند: http://localhost:5173
- بکاند: http://localhost:5000
- Swagger API: http://localhost:5000/swagger

## 🔧 پیکربندی پیشرفته

### ۱. تنظیمات دیتابیس
```json
// appsettings.json
{
  "ConnectionStrings": {
    "DefaultConnection": "Data Source=carpartsstore.db"
  }
}
```

### ۲. تنظیمات CORS
```csharp
// Program.cs
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFrontend",
        policy => policy
            .WithOrigins("http://localhost:5173")
            .AllowAnyMethod()
            .AllowAnyHeader());
});
```

### ۳. تنظیمات آپلود فایل
```json
{
  "FileUpload": {
    "MaxFileSize": 5242880, // 5MB
    "AllowedExtensions": [".jpg", ".jpeg", ".png", ".gif"]
  }
}
```

## 📊 اضافه کردن دادههای تستی

### روش ۱: استفاده از اسکریپت پایتون
```bash
# نصب پایتون (اگر نصب نیست)
# از https://www.python.org/downloads/

# اجرای اسکریپت تولید محصولات
python generate_test_products.py
# یا در ویندوز:
generate_products.bat
```

### روش ۲: اجرای دستی SQL
```sql
-- کپی محتوای فایل test_products.sql
-- و اجرا در دیتابیس SQLite
sqlite3 carpartsstore.db < test_products.sql
```

### روش ۳: استفاده از API
```bash
# درج تک تک محصولات از طریق API
curl -X POST http://localhost:5000/api/products \
  -H "Content-Type: multipart/form-data" \
  -F "name=لنت ترمز جلو" \
  -F "description=لنت ترمز با کیفیت بالا" \
  -F "categoryId=1" \
  -F "brand=Bosch" \
  -F "carBrand=Saipa" \
  -F "carModel=Pride" \
  -F "partNumber=1234-567" \
  -F "compatibleCars=Saipa Pride" \
  -F "material=Metal" \
  -F "warranty=1 year" \
  -F "isFeatured=true" \
  -F "isActive=true"
```

## 🧪 تست سیستم

### تست ۱: بررسی اتصال API
```bash
# تست سلامت API
curl http://localhost:5000/api/products

# تست جستجوی ساده
curl "http://localhost:5000/api/products?search=لنت"

# تست فیلتر پیشرفته
curl "http://localhost:5000/api/products?carBrand=Saipa&carModel=Pride&isFeatured=true"
```

### تست ۲: بررسی فرانتاند
1. به آدرس http://localhost:5173 بروید
2. روی "جستجوی پیشرفته" در نوار منو کلیک کنید
3. فیلترهای مختلف را تست کنید
4. از صفحه تست استفاده کنید: http://localhost:5173/search-test

### تست ۳: تست کامل سیستم
1. به آدرس http://localhost:5173/search-test بروید
2. روی دکمه "اجرای همه تستها" کلیک کنید
3. نتایج تستها را بررسی کنید

## 🔍 عیبیابی

### مشکل ۱: API پاسخ نمیدهد
```bash
# بررسی وضعیت سرویس
netstat -an | findstr :5000

# بررسی لاگها
dotnet run --verbosity detailed
```

### مشکل ۲: فرانتاند به API وصل نمیشود
```javascript
// بررسی آدرس API در فرانتاند
// فایل: carpartsstore-frontend/src/services/api.ts
const API_BASE_URL = 'http://127.0.0.1:5000/api';
```

### مشکل ۳: خطای CORS
```csharp
// در Program.cs مطمئن شوید:
app.UseCors("AllowFrontend");
```

### مشکل ۴: خطای دیتابیس
```bash
# بررسی وجود فایل دیتابیس
dir carpartsstore.db

# ایجاد دیتابیس جدید
dotnet ef database update
```

## 📈 مانیتورینگ و لاگگیری

### لاگهای بکاند
```csharp
// تنظیمات لاگ در appsettings.json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  }
}
```

### مانیتورینگ API
- Swagger UI: http://localhost:5000/swagger
- Health Check: http://localhost:5000/health

### مانیتورینگ فرانتاند
- Developer Tools (F12)
- Console Logs
- Network Requests

## 🔒 امنیت

### ۱. احراز هویت
```csharp
// فعال کردن JWT Authentication
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options => { /* تنظیمات JWT */ });
```

### ۲. اعتبارسنجی ورودی
```csharp
// استفاده از Data Annotations
[Required]
[StringLength(200)]
public string Name { get; set; }
```

### ۳. محدودیت نرخ درخواست
```csharp
// اضافه کردن Rate Limiting
builder.Services.AddRateLimiter(options =>
{
    options.GlobalLimiter = PartitionedRateLimiter.Create<HttpContext, string>(
        context => RateLimitPartition.GetFixedWindowLimiter(
            partitionKey: context.Connection.RemoteIpAddress?.ToString(),
            factory: partition => new FixedWindowRateLimiterOptions
            {
                AutoReplenishment = true,
                PermitLimit = 100,
                QueueLimit = 0,
                Window = TimeSpan.FromMinutes(1)
            }));
});
```

## 📚 منابع و مستندات

### مستندات فنی
- [SEARCH_SYSTEM.md](./carpartsstore-frontend/docs/SEARCH_SYSTEM.md) - مستندات کامل سیستم جستجو
- [API Documentation](./CarPartsStore.API/README.md) - مستندات API

### لینکهای مفید
- [React Documentation](https://react.dev/)
- [ASP.NET Core Documentation](https://learn.microsoft.com/aspnet/core)
- [Tailwind CSS](https://tailwindcss.com/)
- [SQLite](https://www.sqlite.org/)

## 🤝 پشتیبانی

### گزارش مشکل
1. مشکل را در Issues گیتهاب گزارش دهید
2. لاگهای مربوطه را ضمیمه کنید
3. مراحل بازتولید مشکل را شرح دهید

### درخواست ویژگی جدید
1. نیازمندیهای خود را به طور کامل شرح دهید
2. نمونه استفاده را ارائه دهید
3. اولویت را مشخص کنید

### سوالات متداول
**سوال**: چگونه تعداد محصولات در هر صفحه را تغییر دهم؟
**پاسخ**: در کامپوننت AdvancedSearch.tsx، مقدار pageSize را تغییر دهید.

**سوال**: چگونه فیلتر جدید اضافه کنم؟
**پاسخ**: 
1. فیلد جدید به ProductFilterDto اضافه کنید
2. منطق فیلتر را در ProductService اضافه کنید
3. کامپوننت فرانتاند را به روز کنید

**سوال**: چگونه عملکرد جستجو را بهبود دهم؟
**پاسخ**:
1. ایندکس��ای دیتابیس را بهینه کنید
2. از کشگذاری استفاده کنید
3. جستجوی فازی را فعال کنید

---

**آخرین بهروزرسانی**: دی ۱۴۰۳  
**ورژن**: ۱.۰.۰  
**توسعهدهنده**: تیم فنی PinpartStore