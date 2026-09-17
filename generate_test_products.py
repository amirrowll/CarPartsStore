#!/usr/bin/env python3
"""
اسکریپت تولید 200 محصول تستی برای سیستم جستجوی پیشرفته
این اسکریپت دادههای تستی برای بررسی کامل سیستم جستجو ایجاد میکند
"""

import json
import random
from datetime import datetime, timedelta

# دادههای پایه
car_brands = ['Chinese', 'Saipa', 'IranKhodro', 'Other']
car_models = {
    'Chinese': ['Chery', 'JAC', 'MG', 'Lifan', 'Changan', 'Geely'],
    'Saipa': ['Pride', 'Tiba', 'Saina', 'Quick', 'Atlas', 'Shahin'],
    'IranKhodro': ['206', 'Pars', 'Samand', 'Dena', 'Soren', 'Runna'],
    'Other': ['Hyundai', 'Kia', 'Toyota', 'Mitsubishi', 'Nissan', 'BMW']
}

product_brands = ['Bosch', 'Valeo', 'Denso', 'NGK', 'Brembo', 'TRW', 'Febi', 'Mahle', 'Mann', 'Hella']
materials = ['Plastic', 'Metal', 'Rubber', 'Ceramic', 'Composite', 'Aluminum', 'Steel', 'Copper']
warranties = ['6 months', '1 year', '2 years', '3 years', 'Lifetime']

# دسته‌بندی‌های محصولات
categories = [
    {'id': 1, 'name': 'سیستم ترمز'},
    {'id': 2, 'name': 'سیستم تعلیق'},
    {'id': 3, 'name': 'سیستم الکتریکی'},
    {'id': 4, 'name': 'موتور و قطعات'},
    {'id': 5, 'name': 'سیستم خنک‌کننده'},
    {'id': 6, 'name': 'سیستم اگزوز'},
    {'id': 7, 'name': 'سیستم سوخت‌رسانی'},
    {'id': 8, 'name': 'سیستم انتقال قدرت'},
]

# تگ‌های محبوب
popular_tags = [
    'لنت ترمز', 'فیلتر هوا', 'روغن موتور', 'شمع', 'باتری', 'کمربند تایم',
    'سنسور اکسیژن', 'کلاچ', 'دیسک ترمز', 'لوله اگزوز', 'رادیاتور', 'پمپ آب',
    'دینام', 'استارت', 'کمپرسور کولر', 'لنت کلاچ', 'سگدست', 'بلبرینگ',
    'سیبک', 'طبق', 'فیلتر روغن', 'فیلتر سوخت', 'شمع وایر', 'کوئل'
]

# هشتگ‌های محبوب
popular_hashtags = [
    'قطعات_اصلی', 'گارانتی_دار', 'ارسال_سریع', 'تضمین_کیفیت',
    'پرفروش', 'جدیدترین', 'تخفیف_ویژه', 'اورجینال', 'سازگار',
    'مقاوم', 'با_کیفیت', 'اقتصادی', 'لوکس', 'پایدار'
]

# نام‌های محصولات
product_names = [
    'لنت ترمز جلو', 'لنت ترمز عقب', 'دیسک ترمز', 'کالیپر ترمز',
    'فیلتر هوا کاغذی', 'فیلتر هوا اسفنجی', 'روغن موتور 10W40',
    'روغن موتور 5W30', 'شمع پلاتینیومی', 'شمع معمولی',
    'باتری 60 آمپر', 'باتری 70 آمپر', 'کمربند تایم تسمه‌ای',
    'سنسور اکسیژن جلو', 'سنسور اکسیژن عقب', 'کیت کلاچ کامل',
    'دیسک کلاچ', 'لنت کلاچ', 'لوله اگزوز اصلی', 'لوله اگزوز فرعی',
    'رادیاتور آلومینیومی', 'رادیاتور مسی', 'پمپ آب الکتریکی',
    'پمپ آب مکانیکی', 'دینام 90 آمپر', 'دینام 120 آمپر',
    'استارت معمولی', 'استارت دنده‌ای', 'کمپرسور کولر',
    'اواپراتور کولر', 'سگدست جلو', 'سگدست عقب', 'بلبرینگ چرخ',
    'بلبرینگ دینام', 'سیبک فرمان', 'طبق بالا', 'طبق پایین',
    'فیلتر روغن کاغذی', 'فیلتر روغن فلزی', 'فیلتر سوخت بنزینی',
    'فیلتر سوخت دیزلی', 'شمع وایر سیلیکونی', 'کوئل احتراق'
]

def generate_product(id):
    """تولید یک محصول تستی"""
    car_brand = random.choice(car_brands)
    car_model = random.choice(car_models[car_brand])
    
    # انتخاب تصادفی تگ‌ها (2-4 تگ)
    tags = random.sample(popular_tags, random.randint(2, 4))
    
    # انتخاب تصادفی هشتگ‌ها (1-3 هشتگ)
    hashtags = random.sample(popular_hashtags, random.randint(1, 3))
    
    # تولید شماره قطعه
    part_number = f"{random.randint(1000, 9999)}-{random.randint(100, 999)}"
    
    # تولید خودروهای سازگار
    compatible_cars = []
    for _ in range(random.randint(1, 3)):
        brand = random.choice(car_brands)
        model = random.choice(car_models[brand][:3])  # فقط 3 مدل اول
        compatible_cars.append(f"{brand} {model}")
    
    # تاریخ ایجاد تصادفی (در 90 روز گذشته)
    days_ago = random.randint(1, 90)
    created_at = datetime.now() - timedelta(days=days_ago)
    
    product = {
        'id': id,
        'name': f"{random.choice(product_names)} {car_brand} {car_model}",
        'description': f"قطعه یدکی با کیفیت بالا برای خودروهای {car_brand} مدل {car_model}. این محصول از جنس {random.choice(materials)} ساخته شده و دارای گارانتی {random.choice(warranties)} می‌باشد.",
        'categoryId': random.choice([c['id'] for c in categories]),
        'categoryName': random.choice(categories)['name'],
        'imageUrl': f"/uploads/products/product_{id}.jpg",
        'tags': tags,
        'hashtags': hashtags,
        'additionalImages': [
            f"/uploads/products/product_{id}_1.jpg",
            f"/uploads/products/product_{id}_2.jpg"
        ],
        'brand': random.choice(product_brands),
        'partNumber': part_number,
        'compatibleCars': ', '.join(compatible_cars),
        'carBrand': car_brand,
        'carModel': car_model,
        'material': random.choice(materials),
        'warranty': random.choice(warranties),
        'displayOrder': random.randint(1, 100),
        'isFeatured': random.choice([True, False, False, False]),  # 25% ویژه
        'isActive': True,
        'rating': round(random.uniform(3.5, 5.0), 1),
        'reviewCount': random.randint(5, 100),
        'createdAt': created_at.isoformat(),
        'updatedAt': (created_at + timedelta(days=random.randint(1, 30))).isoformat() if random.choice([True, False]) else None
    }
    
    return product

def generate_sql_inserts(products):
    """تولید دستورات SQL برای درج محصولات"""
    sql_statements = []
    
    for product in products:
        # تبدیل آرایه‌ها به فرمت JSON برای SQLite
        tags_json = json.dumps(product['tags'], ensure_ascii=False)
        hashtags_json = json.dumps(product['hashtags'], ensure_ascii=False)
        additional_images_json = json.dumps(product['additionalImages'], ensure_ascii=False)
        
        sql = f"""
INSERT INTO Products (
    Name, Description, CategoryId, ImageUrl, Tags, AdditionalImages, 
    Hashtags, Brand, PartNumber, CompatibleCars, CarBrand, CarModel, 
    Material, Warranty, DisplayOrder, IsFeatured, IsActive, 
    CreatedAt, UpdatedAt
) VALUES (
    '{product['name'].replace("'", "''")}',
    '{product['description'].replace("'", "''")}',
    {product['categoryId']},
    '{product['imageUrl']}',
    '{tags_json}',
    '{additional_images_json}',
    '{hashtags_json}',
    '{product['brand']}',
    '{product['partNumber']}',
    '{product['compatibleCars'].replace("'", "''")}',
    '{product['carBrand']}',
    '{product['carModel']}',
    '{product['material']}',
    '{product['warranty']}',
    {product['displayOrder']},
    {1 if product['isFeatured'] else 0},
    {1 if product['isActive'] else 0},
    '{product['createdAt']}',
    {f"'{product['updatedAt']}'" if product['updatedAt'] else 'NULL'}
);
"""
        sql_statements.append(sql)
    
    return sql_statements

def generate_json_file(products, filename='test_products.json'):
    """ذخیره محصولات در فایل JSON"""
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(products, f, ensure_ascii=False, indent=2, default=str)
    
    print(f"✅ فایل {filename} با {len(products)} محصول ایجاد شد.")

def generate_sql_file(products, filename='test_products.sql'):
    """ذخیره دستورات SQL در فایل"""
    sql_statements = generate_sql_inserts(products)
    
    with open(filename, 'w', encoding='utf-8') as f:
        f.write("-- دستورات SQL برای درج 200 محصول تستی\n")
        f.write("-- برای سیستم جستجوی پیشرفته PinpartStore\n\n")
        
        for i, sql in enumerate(sql_statements, 1):
            f.write(f"-- محصول شماره {i}\n")
            f.write(sql)
            f.write("\n")
    
    print(f"✅ فایل {filename} با {len(sql_statements)} دستور SQL ایجاد شد.")

def generate_typescript_file(products, filename='test_products.ts'):
    """تولید فایل TypeScript برای استفاده در فرانت‌اند"""
    ts_code = f"""// فایل داده‌های تستی برای سیستم جستجوی پیشرفته
// تولید شده در {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

import type {{ Product }} from './types';

export const testProducts: Product[] = {json.dumps(products, ensure_ascii=False, indent=2, default=str)};

export const searchTestCases = [
    {{ name: 'لنت ترمز', filters: {{ search: 'لنت ترمز' }} }},
    {{ name: 'فیلتر هوا سایپا', filters: {{ search: 'فیلتر هوا', carBrand: 'Saipa' }} }},
    {{ name: 'روغن موتور چینی', filters: {{ search: 'روغن موتور', carBrand: 'Chinese' }} }},
    {{ name: 'باتری ایران خودرو', filters: {{ search: 'باتری', carBrand: 'IranKhodro' }} }},
    {{ name: 'شمع پلاتینیومی', filters: {{ search: 'شمع', material: 'Metal' }} }},
    {{ name: 'محصولات ویژه', filters: {{ isFeatured: true }} }},
    {{ name: 'گارانتی 1 سال', filters: {{ warranty: '1 year' }} }},
    {{ name: 'برند Bosch', filters: {{ brand: 'Bosch' }} }},
    {{ name: 'پراید', filters: {{ carBrand: 'Saipa', carModel: 'Pride' }} }},
    {{ name: 'پژو 206', filters: {{ carBrand: 'IranKhodro', carModel: '206' }} }},
];

// آمار محصولات
export const productStats = {{
    total: {len(products)},
    byCarBrand: {{
        Chinese: {sum(1 for p in products if p['carBrand'] == 'Chinese')},
        Saipa: {sum(1 for p in products if p['carBrand'] == 'Saipa')},
        IranKhodro: {sum(1 for p in products if p['carBrand'] == 'IranKhodro')},
        Other: {sum(1 for p in products if p['carBrand'] == 'Other')},
    }},
    byMaterial: {{
        Plastic: {sum(1 for p in products if p['material'] == 'Plastic')},
        Metal: {sum(1 for p in products if p['material'] == 'Metal')},
        Rubber: {sum(1 for p in products if p['material'] == 'Rubber')},
        Ceramic: {sum(1 for p in products if p['material'] == 'Ceramic')},
        Composite: {sum(1 for p in products if p['material'] == 'Composite')},
        Aluminum: {sum(1 for p in products if p['material'] == 'Aluminum')},
        Steel: {sum(1 for p in products if p['material'] == 'Steel')},
        Copper: {sum(1 for p in products if p['material'] == 'Copper')},
    }},
    featured: {sum(1 for p in products if p['isFeatured'])},
    active: {sum(1 for p in products if p['isActive'])},
}};
"""
    
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(ts_code)
    
    print(f"✅ فایل {filename} ایجاد شد.")

def main():
    """تابع اصلی"""
    print("🚀 شروع تولید 200 محصول تستی برای سیستم جستجوی پیشرفته...")
    
    # تولید 200 محصول
    products = [generate_product(i + 1) for i in range(200)]
    
    # تولید فایل‌های خروجی
    generate_json_file(products, 'test_products.json')
    generate_sql_file(products, 'test_products.sql')
    
    # تولید فایل TypeScript برای فرانت‌اند
    ts_path = 'carpartsstore-frontend/src/utils/testProducts.ts'
    generate_typescript_file(products, ts_path)
    
    # نمایش آمار
    print("\n📊 آمار محصولات تولید شده:")
    print(f"   کل محصولات: {len(products)}")
    print(f"   محصولات ویژه: {sum(1 for p in products if p['isFeatured'])}")
    print(f"   برندهای خودرو: {', '.join(set(p['carBrand'] for p in products))}")
    print(f"   مواد مختلف: {', '.join(set(p['material'] for p in products))}")
    print(f"   گارانتی‌ها: {', '.join(set(p['warranty'] for p in products))}")
    
    print("\n✅ تولید محصولات تستی با موفقیت انجام شد!")
    print("📁 فایل‌های تولید شده:")
    print("   - test_products.json (داده‌های خام)")
    print("   - test_products.sql (دستورات SQL)")
    print(f"   - {ts_path} (داده‌های TypeScript)")

if __name__ == '__main__':
    main()