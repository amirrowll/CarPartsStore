@echo off
echo در حال تولید 200 محصول تستی برای سیستم جستجوی پیشرفته...
echo.

REM بررسی وجود پایتون
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo خطا: پایتون نصب نیست!
    echo لطفا پایتون را از https://www.python.org/downloads/ نصب کنید
    pause
    exit /b 1
)

echo پایتون پیدا شد. شروع تولید محصولات...
echo.

python generate_test_products.py

if %errorlevel% equ 0 (
    echo.
    echo ✅ تولید محصولات تستی با موفقیت انجام شد!
    echo.
    echo 📁 فایلهای تولید شده:
    echo   1. test_products.json - دادههای خام محصولات
    echo   2. test_products.sql - دستورات SQL برای درج در دیتابیس
    echo   3. carpartsstore-frontend\src\utils\testProducts.ts - دادههای TypeScript
    echo.
    echo 📋 برای استفاده از محصولات تستی:
    echo   - فایل SQL را در دیتابیس اجرا کنید
    echo   - یا از فایل TypeScript در توسعه فرانتاند استفاده کنید
) else (
    echo.
    echo ❌ خطا در تولید محصولات تستی!
)

pause