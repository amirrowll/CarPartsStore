# راهنمای پابلیش پروژه Pinpart Store

## ✅ چک‌لیست قبل از پابلیش

### امنیت (بحرانی)
- [ ] `appsettings.Production.json` → `SecretKey` را با یک کلید قوی تصادفی عوض کن
- [ ] `appsettings.Production.json` → `AllowedOrigins` را با دامنه واقعی تنظیم کن
- [ ] `.env.production` → `VITE_API_URL` را با آدرس API سرور واقعی تنظیم کن

---

## 🖥️ بکاند (ASP.NET Core)

### Build و اجرا
```bash
cd CarPartsStore.API
dotnet publish -c Release -o ./publish
```

### اجرا روی سرور لینوکس
```bash
cd publish
ASPNETCORE_ENVIRONMENT=Production dotnet CarPartsStore.API.dll
```

### با systemd (توصیه شده)
```ini
# /etc/systemd/system/pinpart-api.service
[Unit]
Description=Pinpart Store API
After=network.target

[Service]
WorkingDirectory=/var/www/pinpart-api
ExecStart=/usr/bin/dotnet CarPartsStore.API.dll
Restart=always
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=ASPNETCORE_URLS=http://0.0.0.0:5000

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl enable pinpart-api
sudo systemctl start pinpart-api
```

---

## 🌐 فرانت (React + Vite)

### Build
```bash
cd carpartsstore-frontend
npm install
npm run build
```
فایل‌های build در پوشه `dist/` قرار می‌گیرند.

### آپلود روی سرور
فایل‌های `dist/` را روی سرور وب (Nginx/Apache) آپلود کن.

### تنظیم Nginx برای SPA
```nginx
server {
    listen 80;
    server_name pinpartstore.com www.pinpartstore.com;
    root /var/www/pinpart-frontend;
    index index.html;

    # Gzip compression
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml image/svg+xml;
    gzip_min_length 1000;

    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # SPA fallback
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Proxy API requests to backend
    location /api/ {
        proxy_pass http://127.0.0.1:5000/api/;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

---

## 🔍 SEO - بعد از پابلیش

1. **Google Search Console**: سایت را اضافه کن و `sitemap.xml` را submit کن
   - آدرس sitemap: `https://pinpartstore.com/sitemap.xml`

2. **Google Analytics**: کد GA4 را به `index.html` اضافه کن

3. **تست Lighthouse**: در Chrome DevTools → Lighthouse → Generate report

4. **تست سرعت**: https://pagespeed.web.dev

---

## 📦 فایل‌های مهم

| فایل | توضیح |
|------|-------|
| `.env.production` | تنظیمات فرانت برای پروداکشن |
| `appsettings.Production.json` | تنظیمات بکاند برای پروداکشن |
| `public/robots.txt` | راهنمای گوگل برای ایندکس |
| `public/sitemap.xml` | نقشه سایت برای گوگل |
