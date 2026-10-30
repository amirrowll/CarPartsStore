-- ============================================================
-- PINPARTS FINAL DATABASE SEED SCRIPT (UTF-8 Without BOM)
-- Categories: 10 (خارجات), 11 (پیچ و مهره), 12 (آرم و علائم)
-- NO Sockets, NO Duplicate Categories, NO Prices (Inquiry Only)
-- Total Catalog Products: 787
-- Total Emblems: 168
-- ============================================================

SET client_encoding = 'UTF8';

-- Ensure ImageUrl allows empty or null for items without images
ALTER TABLE "Products" ALTER COLUMN "ImageUrl" DROP NOT NULL;
ALTER TABLE "Products" ALTER COLUMN "ImageUrl" SET DEFAULT '';

-- 1. Clean up & Ensure Exactly 3 Categories
DELETE FROM "Products" WHERE "CategoryId" = 13 OR "Name" LIKE '%سوکت%';
DELETE FROM "Categories" WHERE "Id" IN (1, 13);

INSERT INTO "Categories" ("Id", "Name", "Description", "ImageUrl", "DisplayOrder", "IsActive", "CreatedAt")
VALUES 
    (10, 'خارجات', 'خار، بست و پین‌های پلیمری و فلزی خودرو', '/uploads/products/pinpart-1001.jpg', 1, true, NOW()),
    (11, 'پیچ و مهره', 'پیچ، مهره، خار مهره و واشرجات استاندارد', '/uploads/products/pinpart-1211.jpg', 2, true, NOW()),
    (12, 'آرم و علائم', 'آرم، نوشته و علائم فابریک خودرو', '/uploads/products/pinpart-1445.jpg', 3, true, NOW())
ON CONFLICT ("Id") DO UPDATE SET 
    "Name" = EXCLUDED."Name",
    "Description" = EXCLUDED."Description",
    "ImageUrl" = EXCLUDED."ImageUrl",
    "DisplayOrder" = EXCLUDED."DisplayOrder",
    "IsActive" = true;

SELECT setval(pg_get_serial_sequence('"Categories"', 'Id'), GREATEST(COALESCE(MAX("Id"), 1), 20)) FROM "Categories";

-- 2. Clear old products to allow fresh clean seed
DELETE FROM "Products";
SELECT setval(pg_get_serial_sequence('"Products"', 'Id'), 1, false);

-- ============================================================
-- 3. Insert 787 Authentic Catalog Products
-- ============================================================

INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کیت شیلنگ شیشه شور پژو ۴۰۵', 'کیت شیلنگ شیشه شور پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1043.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1043', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1043, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کیت شیلنگ شیشه شور پژو ۲۰۶', 'کیت شیلنگ شیشه شور پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1044.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1044', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1044, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چشم شیشه شور پژو ۲۰۶', 'چشم شیشه شور پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1045.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1045', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1045, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چشم شیشه شور L90', 'چشم شیشه شور L90 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1046.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1046', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1046, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چشم شیشه شور سمند قدیم', 'چشم شیشه شور سمند قدیم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1047.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1047', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1047, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چشم شیشه شور سمند جدید', 'چشم شیشه شور سمند جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1048.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1048', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1048, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چشم شیشه شور پیکان', 'چشم شیشه شور پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1049.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1049', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1049, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب بارویی برف پاک کن پژو ۴۰۵', 'قاب بارویی برف پاک کن پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1050.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1050', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1050, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار مکانیزم برف پاک کن پژو ۴۰۵', 'خار مکانیزم برف پاک کن پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1051.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1051', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1051, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زانویی شیشه شور', 'زانویی شیشه شور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1052.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1052', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1052, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آبپاش', 'سه راهی آبپاش فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1053.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1053', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1053, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی شیشه شور پژو ۲۰۶', 'سه راهی شیشه شور پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1054.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1054', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1054, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پایه رادیاتور پژو ۲۰۶', 'پایه رادیاتور پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1055.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1055', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1055, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دستگیره کاپوت کش پژو ۴۰۵ و پرشیا', 'خار دستگیره کاپوت کش پژو ۴۰۵ و پرشیا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1056.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1056', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1056, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دستگیره کاپوت کش سمند', 'خار دستگیره کاپوت کش سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1057.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1057', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1057, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره کاپوت کش پژو ۴۰۵', 'دستگیره کاپوت کش پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1058.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1058', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1058, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره کاپوت کش سمند', 'دستگیره کاپوت کش سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1059.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1059', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1059, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره کاپوت کش پرشیا', 'دستگیره کاپوت کش پرشیا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1060.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1060', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1060, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار چهارگوش شیشه بالابر پژو ۴۰۵', 'خار چهارگوش شیشه بالابر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1061.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1061', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1061, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کانوجوی ریل شیشه بالابر پژو ۴۰۵', 'کانوجوی ریل شیشه بالابر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1062.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1062', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1062, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار قفل سوئیچی پژو ۴۰۵', 'خار قفل سوئیچی پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1063.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1063', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1063, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دستگیره سقف پژو ۴۰۵', 'خار دستگیره سقف پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1064.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1064', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1064, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قرقره گلگیر پژو ۲۰۶', 'قرقره گلگیر پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1065.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1065', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1065, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کانوجو راهنما برگردان پژو ۴۰۵', 'کانوجو راهنما برگردان پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1066.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1066', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1066, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لولای درب باک پژو ۴۰۵', 'لولای درب باک پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1067.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1067', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1067, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لولای درب باک سمند', 'لولای درب باک سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1068.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1068', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1068, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست شیلنگ بخاری (هیدرولیک)', 'بست شیلنگ بخاری (هیدرولیک) فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1069.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1069', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1069, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست لولای صندوق', 'بست لولای صندوق فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1070.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1070', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1070, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست شیلنگ بنزین', 'بست شیلنگ بنزین فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1071.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1071', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1071, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست روی رام', 'بست روی رام فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1072.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1072', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1072, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست شیلنگ بنزین روی قاب تسمه تایم', 'بست شیلنگ بنزین روی قاب تسمه تایم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1073.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1073', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1073, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کانوجو سیم کلاچ پژو ۴۰۵', 'کانوجو سیم کلاچ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1074.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1074', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1074, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار سیم کلاچ فلزی', 'خار سیم کلاچ فلزی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1075.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1075', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1075, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کانوجو سیم کلاچ پژو جدید', 'کانوجو سیم کلاچ پژو جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1076.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1076', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1076, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دوشاخه استارت پژو ۴۰۵', 'دوشاخه استارت پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1077.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1077', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1077, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چشمی راهنما پژو ۴۰۵', 'چشمی راهنما پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1078.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1078', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1078, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گوشواره سپر عقب پژو ۴۰۵', 'گوشواره سپر عقب پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1079.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1079', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1079, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'موشکی سپر سمند', 'موشکی سپر سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1080.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1080', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1080, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دکمه روی کمربند', 'دکمه روی کمربند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1081.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1081', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1081, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره درجه باک پژو ۴۰۵', 'مهره درجه باک پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1082.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1082', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1082, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره درجه باک پژو SLX', 'مهره درجه باک پژو SLX فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1083.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1083', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1083, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره درجه باک پژو ۲۰۶', 'مهره درجه باک پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1084.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1084', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1084, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش شانه ای جعبه فرمان پژو ۴۰۵', 'بوش شانه ای جعبه فرمان پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1085.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1085', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1085, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش هلالی جعبه فرمان پژو ۴۰۵', 'بوش هلالی جعبه فرمان پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1086.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1086', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1086, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش دو شاخ کلاچ پژو ۴۰۵', 'بوش دو شاخ کلاچ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1087.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1087', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1087, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش دو شاخ کلاچ پژو ۲۰۶', 'بوش دو شاخ کلاچ پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1088.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1088', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1088, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش دو شاخ کلاچ TU5', 'بوش دو شاخ کلاچ TU5 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1089.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1089', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1089, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش لق گیر دست دنده', 'بوش لق گیر دست دنده فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1090.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1090', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1090, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش ژامبون پژو ۴۰۵', 'بوش ژامبون پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1091.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1091', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1091, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش ژامبون پژو ۲۰۶', 'بوش ژامبون پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1092.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1092', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1092, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش کمک فرمان پژو ۴۰۵ فلزی', 'بوش کمک فرمان پژو ۴۰۵ فلزی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1093.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1093', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1093, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش کمک فرمان پژو ۴۰۵ پلیمری', 'بوش کمک فرمان پژو ۴۰۵ پلیمری فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1094.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1094', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1094, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چرخ دنده بزرگ داخل گیربکس پژو ۴۰۵', 'چرخ دنده بزرگ داخل گیربکس پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1095.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1095', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1095, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چرخ دنده کوچک سنسور کیلومتر پژو ۴۰۵', 'چرخ دنده کوچک سنسور کیلومتر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1096.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1096', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1096, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش سرسیلندر پژو ۴۰۵', 'بوش سرسیلندر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1097.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1097', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1097, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سوپاپ گیربکس پژو ۴۰۵', 'سوپاپ گیربکس پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1098.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1098', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1098, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سوپاپ گیربکس پژو ۲۰۶', 'سوپاپ گیربکس پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1099.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1099', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1099, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب روغن هیدرولیک پژو ۴۰۵', 'درب روغن هیدرولیک پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1100.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1100', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1100, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب روغن هیدرولیک پژو ۲۰۶', 'درب روغن هیدرولیک پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1101.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1101', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1101, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب روغن هیدرولیک RD', 'درب روغن هیدرولیک RD فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1102.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1102', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1102, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب داخلی باک بنزین', 'درب داخلی باک بنزین فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1103.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1103', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1103, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب باک یورو ۴', 'درب باک یورو ۴ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1104.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1104', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1104, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب CNG پیچی', 'درب CNG پیچی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1105.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1105', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1105, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب CNG بنددار', 'درب CNG بنددار فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1106.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1106', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1106, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب CNG فشاری', 'درب CNG فشاری فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1107.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1107', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1107, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع روغن ترمز', 'درب منبع روغن ترمز فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1108.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1108', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1108, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب روغن موتور ۱۸۰۰', 'درب روغن موتور ۱۸۰۰ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1109.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1109', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1109, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب روغن موتور EF7', 'درب روغن موتور EF7 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1110.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1110', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1110, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب روغن موتور پژو ۲۰۶', 'درب روغن موتور پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1111.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1111', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1111, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب روغن موتور پیکان', 'درب روغن موتور پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1112.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1112', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1112, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع انبساط پژو ۲۰۶', 'درب منبع انبساط پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1113.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1113', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1113, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع شیشه شور', 'درب منبع شیشه شور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1114.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1114', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1114, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب رادیاتور پژو ۴۰۵', 'درب رادیاتور پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1115.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1115', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1115, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب رادیاتور ROA و آریسان', 'درب رادیاتور ROA و آریسان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1116.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1116', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1116, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب بیرونی باک پژو ۴۰۵', 'درب بیرونی باک پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1117.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1117', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1117, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب بیرونی باک سمند', 'درب بیرونی باک سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1118.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1118', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1118, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شیر تخلیه رادیاتور', 'شیر تخلیه رادیاتور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1119.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1119', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1119, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شیر تخلیه رادیاتور جدید', 'شیر تخلیه رادیاتور جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1120.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1120', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1120, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شیر تخلیه دوپایه بزرگ رادیاتور', 'شیر تخلیه دوپایه بزرگ رادیاتور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1121.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1121', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1121, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کلید پنل ضبط', 'کلید پنل ضبط فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1122.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1122', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1122, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کلید پنل جا سیگاری', 'کلید پنل جا سیگاری فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1123.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1123', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1123, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کلید تنظیم سرعت فن', 'کلید تنظیم سرعت فن فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1124.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1124', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1124, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کلید تهویه', 'کلید تهویه فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1125.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1125', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1125, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کلید AC کولر', 'کلید AC کولر فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1126.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1126', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1126, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درجه باک پژو ۴۰۵', 'اورینگ درجه باک پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1127.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1127', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1127, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درجه باک موتور ملی', 'اورینگ درجه باک موتور ملی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1128.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1128', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1128, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درجه باک پژو ۲۰۶', 'اورینگ درجه باک پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1129.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1129', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1129, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درجه باک پیکان', 'اورینگ درجه باک پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1130.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1130', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1130, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درجه باک باردو', 'اورینگ درجه باک باردو فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1131.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1131', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1131, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ دوراهی آب پشت سیلندر پژو ۴۰۵', 'اورینگ دوراهی آب پشت سیلندر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1132.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1132', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1132, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ دوراهی آب پشت سیلندر پژو ۲۰۶ تیپ ۲', 'اورینگ دوراهی آب پشت سیلندر پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1133.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1133', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1133, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ دوراهی آب پشت سیلندر پژو ۲۰۶ تیپ ۵', 'اورینگ دوراهی آب پشت سیلندر پژو ۲۰۶ تیپ ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1134.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1134', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1134, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ هوزینگ آلومینیومی دوراهی آب پژو ۲۰۶', 'اورینگ هوزینگ آلومینیومی دوراهی آب پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1135.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1135', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1135, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درب روغن موتور', 'اورینگ درب روغن موتور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1136.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1136', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1136, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ بخاری پژو ۴۰۵', 'اورینگ بخاری پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1137.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1137', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1137, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ بخاری پژو ۲۰۶', 'اورینگ بخاری پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1138.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1138', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1138, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ سوزن انژکتور پژو ۴۰۵', 'اورینگ سوزن انژکتور پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1139.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1139', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1139, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ سوزن انژکتور پژو ۲۰۶', 'اورینگ سوزن انژکتور پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1140.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1140', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1140, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ سوزن انژکتور موتور ملی', 'اورینگ سوزن انژکتور موتور ملی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1141.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1141', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1141, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ دور بوش پژو ۴۰۵', 'اورینگ دور بوش پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1142.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1142', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1142, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ دور بوش پژو ۲۰۶', 'اورینگ دور بوش پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1143.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1143', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1143, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ پایه فیلتر پژو ۲۰۶', 'اورینگ پایه فیلتر پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1144.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1144', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1144, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درپوش فیلتر روغن پژو ۲۰۶', 'اورینگ درپوش فیلتر روغن پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1145.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1145', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1145, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درب ترموستات پژو ۲۰۶', 'اورینگ درب ترموستات پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1146.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1146', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1146, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درب ترموستات پژو ۴۰۵', 'اورینگ درب ترموستات پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1147.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1147', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1147, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ هوزینگ ترموستات پژو ۲۰۶ تیپ ۲', 'اورینگ هوزینگ ترموستات پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1148.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1148', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1148, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ هوزینگ ترموستات پژو ۲۰۶ تیپ ۵ ضخیم', 'اورینگ هوزینگ ترموستات پژو ۲۰۶ تیپ ۵ ضخیم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1149.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1149', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1149, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ هوزینگ ترموستات پژو ۲۰۶ تیپ ۵ باریک', 'اورینگ هوزینگ ترموستات پژو ۲۰۶ تیپ ۵ باریک فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1150.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1150', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1150, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ هوزینگ سنسور کیلومتر پژو ۴۰۵', 'اورینگ هوزینگ سنسور کیلومتر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1151.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1151', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1151, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ واتر پمپ پژو ۲۰۶ تیپ ۲', 'اورینگ واتر پمپ پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1152.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1152', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1152, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ واتر پمپ پژو ۲۰۶ تیپ ۵', 'اورینگ واتر پمپ پژو ۲۰۶ تیپ ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1153.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1153', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1153, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ واتر پمپ EF7 باریک', 'اورینگ واتر پمپ EF7 باریک فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1154.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1154', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1154, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ واتر پمپ EF7 ضخیم', 'اورینگ واتر پمپ EF7 ضخیم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1155.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1155', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1155, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ دریچه گاز L90 کوچک و بزرگ', 'اورینگ دریچه گاز L90 کوچک و بزرگ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1156.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1156', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1156, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واسطه لاستیکی لوله هواکش XU7 پژو ۴۰۵', 'واسطه لاستیکی لوله هواکش XU7 پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1157.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1157', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1157, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واسطه لاستیکی لوله هواکش پژو ۲۰۶ تیپ ۲', 'واسطه لاستیکی لوله هواکش پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1158.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1158', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1158, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واسطه لاستیکی لوله هواکش پژو ۲۰۶ تیپ ۵', 'واسطه لاستیکی لوله هواکش پژو ۲۰۶ تیپ ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1159.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1159', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1159, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر منیفولد پژو ۱۸۰۰', 'واشر منیفولد پژو ۱۸۰۰ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1160.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1160', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1160, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر منیفولد پژو ۱۸۰۰ کروز و زیمنس', 'واشر منیفولد پژو ۱۸۰۰ کروز و زیمنس فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1161.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1161', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1161, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر منیفولد پژو ۲۰۶ تیپ ۲', 'واشر منیفولد پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1162.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1162', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1162, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر منیفولد پژو ۲۰۶ تیپ ۵ و SLX', 'واشر منیفولد پژو ۲۰۶ تیپ ۵ و SLX فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1163.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1163', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1163, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر منیفولد EF7', 'واشر منیفولد EF7 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1164.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1164', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1164, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر منیفولد L90', 'واشر منیفولد L90 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1165.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1165', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1165, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر اویل ماژول EF7', 'واشر اویل ماژول EF7 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1166.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1166', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1166, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر دور کفی گیربکس پژو ۲۰۶', 'واشر دور کفی گیربکس پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1167.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1167', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1167, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر کاتالیزور پژو ۲۰۶', 'واشر کاتالیزور پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1168.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1168', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1168, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب ترموستات ۱۸۰۰', 'درب ترموستات ۱۸۰۰ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1169.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1169', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1169, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب ترموستات L90', 'درب ترموستات L90 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1170.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1170', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1170, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب ترموستات پیکان', 'درب ترموستات پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1171.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1171', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1171, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دوراهی آب پشت سرسیلندر پژو ۴۰۵', 'دوراهی آب پشت سرسیلندر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1172.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1172', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1172, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دوراهی آب پشت سرسیلندر پژو ۲۰۶ تیپ ۲', 'دوراهی آب پشت سرسیلندر پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1173.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1173', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1173, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دوراهی آب پشت سرسیلندر پژو ۲۰۶ تیپ ۵', 'دوراهی آب پشت سرسیلندر پژو ۲۰۶ تیپ ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1174.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1174', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1174, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شیلنگ منبع انبساط پژو ۲۰۶ تیپ ۲', 'شیلنگ منبع انبساط پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1175.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1175', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1175, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شیلنگ منبع انبساط پژو ۲۰۶ تیپ ۵', 'شیلنگ منبع انبساط پژو ۲۰۶ تیپ ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1176.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1176', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1176, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شیلنگ داخل باک کوتاه', 'شیلنگ داخل باک کوتاه فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1177.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1177', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1177, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شیلنگ داخل باک بلند', 'شیلنگ داخل باک بلند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1178.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1178', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1178, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گز روغن پژو ۴۰۵ پیچی', 'گز روغن پژو ۴۰۵ پیچی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1179.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1179', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1179, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گز روغن پژو ۴۰۵ صاف', 'گز روغن پژو ۴۰۵ صاف فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1180.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1180', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1180, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گز روغن پژو ۲۰۶ تیپ ۲', 'گز روغن پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1181.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1181', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1181, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گز روغن پژو ۲۰۶ تیپ ۵', 'گز روغن پژو ۲۰۶ تیپ ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1182.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1182', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1182, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گز روغن EF7', 'گز روغن EF7 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1183.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1183', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1183, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گز روغن L90', 'گز روغن L90 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1184.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1184', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1184, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گز روغن RD', 'گز روغن RD فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1185.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1185', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1185, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گز روغن پیکان', 'گز روغن پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1186.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1186', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1186, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوله روغن ریز فلزی', 'لوله روغن ریز فلزی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1187.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1187', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1187, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوله روغن ریز پلیمری', 'لوله روغن ریز پلیمری فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1188.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1188', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1188, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فولی هرزگرد پژو ۴۰۵', 'فولی هرزگرد پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1189.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1189', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1189, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'میکرو سوئیچ با سیم', 'میکرو سوئیچ با سیم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1190.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1190', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1190, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'میکرو سوئیچ بی سیم', 'میکرو سوئیچ بی سیم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1191.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1191', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1191, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سوئیچ صندوق', 'سوئیچ صندوق فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1192.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1192', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1192, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سوئیچ لای درب سمند', 'سوئیچ لای درب سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1193.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1193', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1193, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سوئیچ درب موتور', 'سوئیچ درب موتور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1194.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1194', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1194, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سلکتور دسته راهنما', 'سلکتور دسته راهنما فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1195.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1195', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1195, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره استپ ترمز پژو ۴۰۵', 'مهره استپ ترمز پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1196.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1196', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1196, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوله هوزینگ آب سرسیلندر پژو ۴۰۵', 'لوله هوزینگ آب سرسیلندر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1197.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1197', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1197, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوله هوزینگ آب سرسیلندر پیکان', 'لوله هوزینگ آب سرسیلندر پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1198.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1198', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1198, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آب گازسوز CNG', 'سه راهی آب گازسوز CNG فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1199.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1199', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1199, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آب گازسوز LPG', 'سه راهی آب گازسوز LPG فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1200.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1200', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1200, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آب گازسوز سفید', 'سه راهی آب گازسوز سفید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1201.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1201', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1201, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آب گازسوز پژو ۴۰۵ فلزی', 'سه راهی آب گازسوز پژو ۴۰۵ فلزی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1202.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1202', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1202, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آب گازسوز EF7', 'سه راهی آب گازسوز EF7 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1203.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1203', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1203, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آب گازسوز EF7 فلزی', 'سه راهی آب گازسوز EF7 فلزی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1204.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1204', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1204, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آب RD با پیچ برنجی', 'سه راهی آب RD با پیچ برنجی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1205.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1205', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1205, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره هواگیری پلاستیکی درب ترموستات', 'مهره هواگیری پلاستیکی درب ترموستات فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1206.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1206', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1206, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره هواگیری برنجی درب ترموستات', 'مهره هواگیری برنجی درب ترموستات فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1207.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1207', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1207, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ آلنی هواگیری سرسیلندر', 'پیچ آلنی هواگیری سرسیلندر فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1208.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1208', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1208, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پایه پیچ هواگیری سرسیلندر', 'پایه پیچ هواگیری سرسیلندر فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1209.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1209', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1209, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ برنجی سه راهی آب RD و پژو ۲۰۶', 'پیچ برنجی سه راهی آب RD و پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1210.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1210', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1210, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ درب موتور پژو ۴۰۵', 'پیچ درب موتور پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1211.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1211', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1211, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ فن چپگرد', 'پیچ فن چپگرد فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1212.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1212', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1212, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ سرسیلندر تمام رزوه پژو ۴۰۵', 'پیچ سرسیلندر تمام رزوه پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1213.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1213', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1213, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ سرسیلندر نیم رزوه پژو ۴۰۵', 'پیچ سرسیلندر نیم رزوه پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1214.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1214', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1214, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ سرسیلندر پژو ۲۰۶ تیپ ۲ و ۵', 'پیچ سرسیلندر پژو ۲۰۶ تیپ ۲ و ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1215.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1215', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1215, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ شلگیر پژو ۲۰۶ و ۴۰۵', 'پیچ شلگیر پژو ۲۰۶ و ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1216.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1216', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1216, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دستگیره مچی', 'پیچ دستگیره مچی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1217.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1217', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1217, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ چرخ پژو ۴۰۵', 'پیچ چرخ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1218.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1218', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1218, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ چرخ LX', 'پیچ چرخ LX فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1219.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1219', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1219, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ چرخ سورن', 'پیچ چرخ سورن فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1220.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1220', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1220, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره درب سوپاپ پژو ۴۰۵', 'مهره درب سوپاپ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1221.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1221', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1221, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ درب سوپاپ پژو ۴۰۵', 'پیچ درب سوپاپ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1222.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1222', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1222, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ قاب تسمه تایم پژو ۴۰۵ و ۲۰۶ و درب سوپاپ پژو ۲۰۶', 'پیچ قاب تسمه تایم پژو ۴۰۵ و ۲۰۶ و درب سوپاپ پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1223.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1223', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1223, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ کالیپر پژو ۲۰۶ تیپ ۲ و ۵', 'پیچ کالیپر پژو ۲۰۶ تیپ ۲ و ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1224.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1224', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1224, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ کالیپر پژو ۴۰۵', 'پیچ کالیپر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1225.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1225', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1225, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دوسره اگزوز پژو ۴۰۵', 'پیچ دوسره اگزوز پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1226.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1226', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1226, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ طبق پژو ۴۰۵', 'پیچ طبق پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1227.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1227', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1227, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ طبق پژو ۲۰۶', 'پیچ طبق پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1228.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1228', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1228, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ طبق به شاسی پژو ۲۰۶', 'پیچ طبق به شاسی پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1229.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1229', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1229, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ گلگیر', 'پیچ گلگیر فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1230.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1230', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1230, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ پفکی سپر', 'پیچ پفکی سپر فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1231.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1231', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1231, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دیسک و صفحه پژو ۴۰۵', 'پیچ دیسک و صفحه پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1232.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1232', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1232, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ رام بزرگ پژو ۴۰۵', 'پیچ رام بزرگ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1233.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1233', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1233, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ چراغ جلو', 'پیچ چراغ جلو فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1234.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1234', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1234, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ سپر پژو ۲۰۶', 'پیچ سپر پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1235.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1235', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1235, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ سپر پژو ۴۰۵', 'پیچ سپر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1236.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1236', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1236, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دور گیربکس پژو ۴۰۵', 'پیچ دور گیربکس پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1237.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1237', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1237, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ تخلیه کارتل پژو ۴۰۵', 'پیچ تخلیه کارتل پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1238.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1238', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1238, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ تخلیه کارتل پژو ۲۰۶', 'پیچ تخلیه کارتل پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1239.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1239', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1239, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دور کارتل', 'پیچ دور کارتل فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1240.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1240', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1240, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ هواگیری چرخ', 'پیچ هواگیری چرخ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1241.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1241', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1241, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ آینه برقی و استوپر', 'پیچ آینه برقی و استوپر فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1242.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1242', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1242, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ کمک بالا و پایین پژو ۲۰۶ تیپ ۲ و ۵', 'پیچ کمک بالا و پایین پژو ۲۰۶ تیپ ۲ و ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1243.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1243', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1243, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ سینی فن بلند و کوتاه پژو ۴۰۵', 'پیچ سینی فن بلند و کوتاه پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1244.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1244', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1244, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دسته موتور بلند و کوتاه پژو ۲۰۶', 'پیچ دسته موتور بلند و کوتاه پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1245.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1245', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1245, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دوسر دسته موتور', 'پیچ دوسر دسته موتور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1246.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1246', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1246, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ میل موجگیر بلند و کوتاه', 'پیچ میل موجگیر بلند و کوتاه فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1247.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1247', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1247, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ پلاک', 'پیچ پلاک فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1248.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1248', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1248, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره ۶', 'مهره ۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1249.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1249', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1249, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره ۸', 'مهره ۸ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1250.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1250', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1250, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره ۱۰', 'مهره ۱۰ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1251.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1251', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1251, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره ۱۲', 'مهره ۱۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-1252.jpg',
    ARRAY['پیچ و مهره', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1252', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1252, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست اطراف باطری پژو ۲۰۶', 'بست اطراف باطری پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1253.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1253', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1253, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست اطراف باطری پیکان', 'بست اطراف باطری پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1254.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1254', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1254, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست اطراف باطری پژو ۴۰۵', 'بست اطراف باطری پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1255.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1255', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1255, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زبانه درب پژو ۴۰۵', 'زبانه درب پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1256.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1256', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1256, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زبانه درب پژو جدید', 'زبانه درب پژو جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1257.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1257', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1257, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زبانه درب سمند LX', 'زبانه درب سمند LX فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1258.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1258', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1258, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قفل کاپوت پژو ۴۰۵', 'قفل کاپوت پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1259.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1259', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1259, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ضامن فلزی پژو ۴۰۵', 'ضامن فلزی پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1260.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1260', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1260, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زبانه قفل صندوق پژو ۴۰۵', 'زبانه قفل صندوق پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1261.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1261', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1261, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قفل صندوق پژو ۴۰۵', 'قفل صندوق پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1262.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1262', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1262, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زبانه قفل صندوق پژو ۲۰۶', 'زبانه قفل صندوق پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1263.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1263', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1263, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قفل صندوق پژو ۲۰۶', 'قفل صندوق پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1264.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1264', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1264, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ترمز درب پژو جدید', 'ترمز درب پژو جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1265.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1265', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1265, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ترمز درب پژو SLX', 'ترمز درب پژو SLX فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1266.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1266', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1266, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ترمز درب پژو ۴۰۵', 'ترمز درب پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1267.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1267', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1267, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ترمز درب پژو ۲۰۶', 'ترمز درب پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1268.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1268', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1268, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ترمز درب سمند قدیم', 'ترمز درب سمند قدیم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1269.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1269', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1269, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ترمز درب سمند جدید', 'ترمز درب سمند جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1270.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1270', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1270, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فنر نگهدارنده رادیاتور', 'فنر نگهدارنده رادیاتور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1271.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1271', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1271, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فنر راهنما پژو ۴۰۵', 'فنر راهنما پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1272.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1272', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1272, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فنر پلوس پژو ۴۰۵', 'فنر پلوس پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1273.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1273', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1273, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فنر پلوس پژو ۲۰۶', 'فنر پلوس پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1274.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1274', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1274, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فنر صندوق', 'فنر صندوق فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1275.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1275', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1275, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فنر سیم گاز', 'فنر سیم گاز فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1276.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1276', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1276, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه فنر لنت عقب موتور ملی', 'مجموعه فنر لنت عقب موتور ملی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1277.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1277', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1277, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه فنر لنت عقب پژو ۴۰۵', 'مجموعه فنر لنت عقب پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1278.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1278', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1278, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'میخ و پولک پژو ۴۰۵', 'میخ و پولک پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1279.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1279', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1279, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه فنر لنت عقب پژو ۲۰۶ تیپ ۲', 'مجموعه فنر لنت عقب پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1280.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1280', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1280, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه فنر لنت عقب پژو ۲۰۶ تیپ ۵', 'مجموعه فنر لنت عقب پژو ۲۰۶ تیپ ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1281.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1281', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1281, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'میخ و پولک پژو ۲۰۶', 'میخ و پولک پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1282.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1282', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1282, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه فنر لنت عقب L90', 'مجموعه فنر لنت عقب L90 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1283.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1283', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1283, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه فنر لنت عقب پیکان', 'مجموعه فنر لنت عقب پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1284.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1284', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1284, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'میخ و پولک لنت پیکان', 'میخ و پولک لنت پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1285.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1285', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1285, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اشپیل و فنر لنت جلو پیکان', 'اشپیل و فنر لنت جلو پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1286.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1286', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1286, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اشپیل و فنر لنت جلو RD', 'اشپیل و فنر لنت جلو RD فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1287.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1287', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1287, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر باطری', 'سر باطری فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1288.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1288', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1288, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کیت اگزوز پژو ۴۰۵', 'کیت اگزوز پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1289.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1289', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1289, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کیت اگزوز پژو ۲۰۶', 'کیت اگزوز پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1290.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1290', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1290, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'رگلاژ چرخ عقب پژو ۲۰۶', 'رگلاژ چرخ عقب پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1291.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1291', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1291, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'رگلاژ چرخ عقب پژو ۴۰۵', 'رگلاژ چرخ عقب پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1292.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1292', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1292, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'رگلاژ چرخ عقب سمند کار', 'رگلاژ چرخ عقب سمند کار فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1293.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1293', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1293, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'رگلاژ چرخ عقب سمند ملی', 'رگلاژ چرخ عقب سمند ملی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1294.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1294', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1294, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار شلگیر فلزی', 'خار شلگیر فلزی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1295.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1295', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1295, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار زه دور گلگیر', 'خار زه دور گلگیر فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1296.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1296', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1296, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار شیشه چراغ پژو ۴۰۵', 'خار شیشه چراغ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1297.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1297', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1297, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار قاب هواکش', 'خار قاب هواکش فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1298.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1298', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1298, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار بادگیر فن', 'خار بادگیر فن فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1299.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1299', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1299, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار مهره سینی فن', 'خار مهره سینی فن فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1300.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1300', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1300, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار پیچ شلگیر', 'خار پیچ شلگیر فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1301.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1301', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1301, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار مهره سینی فن پژو ۲۰۶', 'خار مهره سینی فن پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1302.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1302', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1302, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار فلزی پشت راهنما', 'خار فلزی پشت راهنما فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1303.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1303', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1303, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار جلو پنجره و توری سپر سمند', 'خار جلو پنجره و توری سپر سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1304.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1304', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1304, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار پروانه فن', 'خار پروانه فن فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1305.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1305', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1305, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار جلو پنجره پیکان', 'خار جلو پنجره پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1306.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1306', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1306, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار نمدی داشبورد', 'خار نمدی داشبورد فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1307.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1307', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1307, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار پلوس', 'خار پلوس فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1308.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1308', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1308, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار میانی پلوس پژو ۴۰۵', 'خار میانی پلوس پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1309.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1309', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1309, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار بلبرینگ چرخ جلو پژو ۴۰۵', 'خار بلبرینگ چرخ جلو پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1310.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1310', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1310, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار بلبرینگ چرخ جلو پژو ۲۰۶', 'خار بلبرینگ چرخ جلو پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1311.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1311', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1311, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار فن پژو ۴۰۵', 'خار فن پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1312.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1312', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1312, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار زه کاپوت پیکان', 'خار زه کاپوت پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1313.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1313', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1313, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار سوپاپ پژو ۴۰۵', 'خار سوپاپ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1314.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1314', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1314, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار سرمیل لنگ پژو ۴۰۵', 'خار سرمیل لنگ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1315.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1315', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1315, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پین پروانه فن', 'پین پروانه فن فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1316.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1316', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1316, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پین ترمز درب پژو ۴۰۵', 'پین ترمز درب پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1317.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1317', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1317, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اشپیل پلوس پژو ۴۰۵', 'اشپیل پلوس پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1318.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1318', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1318, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خورشیدی سر پلوس پژو ۴۰۵', 'خورشیدی سر پلوس پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1319.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1319', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1319, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خورشیدی سر پلوس پیکان', 'خورشیدی سر پلوس پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1320.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1320', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1320, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کاپ چرخ پژو ۴۰۵', 'کاپ چرخ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1321.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1321', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1321, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کاپ چرخ پژو ۲۰۶', 'کاپ چرخ پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1322.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1322', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1322, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کاپ چرخ سمند', 'کاپ چرخ سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1323.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1323', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1323, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کاپ چرخ پیکان', 'کاپ چرخ پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1324.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1324', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1324, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'میل کاپوت سمند', 'میل کاپوت سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1325.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1325', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1325, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'میل کاپوت پژو ۴۰۵', 'میل کاپوت پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1326.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1326', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1326, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آچار چرخ پژو ۴۰۵', 'آچار چرخ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1327.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1327', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1327, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی استیل کوتاه ۳۸', 'بست فلزی استیل کوتاه ۳۸ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1328.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1328', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1328, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی استیل بلند ۶۵', 'بست فلزی استیل بلند ۶۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1329.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1329', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1329, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست کمربندی پلاستیکی', 'بست کمربندی پلاستیکی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1330.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1330', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1330, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی شیلنگ بنزین ۱۰-۱۶', 'بست فلزی شیلنگ بنزین ۱۰-۱۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1331.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1331', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1331, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی شیلنگ بوستر ۱۳-۱۹', 'بست فلزی شیلنگ بوستر ۱۳-۱۹ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1332.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1332', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1332, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی شیلنگ بخاری ۲۰-۳۰', 'بست فلزی شیلنگ بخاری ۲۰-۳۰ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1333.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1333', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1333, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی شیلنگ رادیاتور ۲۵-۴۲', 'بست فلزی شیلنگ رادیاتور ۲۵-۴۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1334.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1334', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1334, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی پلوس کوچک ۲۰-۳۰', 'بست فلزی پلوس کوچک ۲۰-۳۰ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1335.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1335', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1335, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی پلوس بزرگ ۶۵-۸۲', 'بست فلزی پلوس بزرگ ۶۵-۸۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1336.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1336', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1336, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره بخواب صندلی پژو ۲۰۶', 'دستگیره بخواب صندلی پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1337.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1337', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1337, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره بخواب صندلی پژو ۴۰۵', 'دستگیره بخواب صندلی پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1338.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1338', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1338, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره شیشه بالابر پژو ۴۰۵', 'دستگیره شیشه بالابر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1339.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1339', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1339, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره شیشه بالابر پژو ۲۰۶', 'دستگیره شیشه بالابر پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1340.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1340', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1340, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زبانه داشبورد پژو جدید تیره و روشن', 'زبانه داشبورد پژو جدید تیره و روشن فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1341.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1341', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1341, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زبانه داشبورد سمند', 'زبانه داشبورد سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1342.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1342', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1342, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره بیرونی پژو ۴۰۵', 'دستگیره بیرونی پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1343.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1343', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1343, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره بیرونی سمند', 'دستگیره بیرونی سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1344.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1344', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1344, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره داخلی پژو ۴۰۵', 'دستگیره داخلی پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1345.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1345', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1345, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره داخلی سمند', 'دستگیره داخلی سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1346.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1346', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1346, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب دستگیره داخلی پژو ۴۰۵', 'قاب دستگیره داخلی پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1347.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1347', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1347, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب دستگیره داخلی سمند', 'قاب دستگیره داخلی سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1348.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1348', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1348, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شاسی قفل کن خاری پژو ۴۰۵', 'شاسی قفل کن خاری پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1349.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1349', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1349, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شاسی قفل کن پیچی پژو ۴۰۵', 'شاسی قفل کن پیچی پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1350.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1350', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1350, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شاسی قفل کن SLX و پارس', 'شاسی قفل کن SLX و پارس فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1351.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1351', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1351, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دور قفل کن SLX و پارس', 'خار دور قفل کن SLX و پارس فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1352.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1352', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1352, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شاسی قفل کن سمند', 'شاسی قفل کن سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1353.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1353', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1353, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دور قفل کن سمند', 'خار دور قفل کن سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1354.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1354', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1354, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر دنده پژو ۴۰۵ و پارس', 'سر دنده پژو ۴۰۵ و پارس فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1355.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1355', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1355, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر دنده پژو جدید', 'سر دنده پژو جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1356.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1356', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1356, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر دنده سمند', 'سر دنده سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1357.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1357', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1357, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر دنده EF7', 'سر دنده EF7 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1358.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1358', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1358, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر دنده پژو ۲۰۶', 'سر دنده پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1359.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1359', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1359, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر دنده پژو ۲۰۶ SD', 'سر دنده پژو ۲۰۶ SD فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1360.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1360', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1360, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر دنده L90', 'سر دنده L90 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1361.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1361', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1361, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر دنده پیکان', 'سر دنده پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1362.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1362', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1362, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چرم دست دنده پژو ۴۰۵', 'چرم دست دنده پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1363.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1363', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1363, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چرم دست دنده سمند', 'چرم دست دنده سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1364.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1364', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1364, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چرم دست دنده پژو ۲۰۶', 'چرم دست دنده پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1365.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1365', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1365, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چرم دست دنده پیکان', 'چرم دست دنده پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1366.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1366', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1366, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کاور کامپیوتر پژو ۴۰۵', 'کاور کامپیوتر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1367.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1367', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1367, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ضربه گیر رادیاتور پژو ۲۰۶', 'ضربه گیر رادیاتور پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1368.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1368', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1368, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ضربه گیر رادیاتور پژو ۴۰۵', 'ضربه گیر رادیاتور پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1369.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1369', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1369, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ضربه گیر کاپوت پژو ۲۰۶', 'ضربه گیر کاپوت پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1370.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1370', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1370, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ضربه گیر کاپوت پژو ۴۰۵', 'ضربه گیر کاپوت پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1371.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1371', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1371, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ضربه گیر کاپوت سمند', 'ضربه گیر کاپوت سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1372.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1372', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1372, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ضربه گیر رگلاژی کاپوت', 'ضربه گیر رگلاژی کاپوت فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1373.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1373', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1373, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار میل کاپوت گردشی لاستیکی', 'خار میل کاپوت گردشی لاستیکی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1374.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1374', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1374, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک دیاق فن پژو ۲۰۶', 'لاستیک دیاق فن پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1375.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1375', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1375, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک قیچی سینی فن پژو ۲۰۶', 'لاستیک قیچی سینی فن پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1376.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1376', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1376, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک قرقره شیشه بالابر', 'لاستیک قرقره شیشه بالابر فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1377.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1377', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1377, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کورکن کف اتاق پژو ۴۰۵', 'کورکن کف اتاق پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1378.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1378', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1378, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منجید اگزوز پژو ۲۰۶', 'منجید اگزوز پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1379.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1379', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1379, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منجید اگزوز پژو ۴۰۵', 'منجید اگزوز پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1380.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1380', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1380, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک پدال پژو ۴۰۵', 'لاستیک پدال پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1381.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1381', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1381, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک پدال پژو ۲۰۶', 'لاستیک پدال پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1382.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1382', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1382, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک پدال پیکان', 'لاستیک پدال پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1383.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1383', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1383, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک چاکدار پژو جدید', 'لاستیک چاکدار پژو جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1384.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1384', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1384, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک منبع روغن ترمز پژو ۴۰۵', 'لاستیک منبع روغن ترمز پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1385.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1385', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1385, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک منبع شیشه شور پژو ۴۰۵', 'لاستیک منبع شیشه شور پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1386.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1386', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1386, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ضربه گیر صندوق پژو ۴۰۵', 'ضربه گیر صندوق پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1387.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1387', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1387, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کش منبع انبساط پژو ۲۰۶', 'کش منبع انبساط پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1388.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1388', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1388, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کش هواکش L90', 'کش هواکش L90 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1389.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1389', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1389, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ عقب پژو ۲۰۰۰', 'لوازم چرخ عقب پژو ۲۰۰۰ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1390.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1390', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1390, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ عقب پژو ۱۸۰۰', 'لوازم چرخ عقب پژو ۱۸۰۰ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1391.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1391', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1391, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ عقب پژو ۴۰۵ ABS', 'لوازم چرخ عقب پژو ۴۰۵ ABS فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1392.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1392', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1392, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ عقب پژو ۲۰۶', 'لوازم چرخ عقب پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1393.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1393', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1393, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ عقب پیکان ۵۴۷', 'لوازم چرخ عقب پیکان ۵۴۷ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1394.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1394', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1394, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ عقب پیکان ۵۵۰', 'لوازم چرخ عقب پیکان ۵۵۰ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1395.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1395', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1395, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ عقب پیکان ABS', 'لوازم چرخ عقب پیکان ABS فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1396.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1396', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1396, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ جلو پژو ۴۰۵', 'لوازم چرخ جلو پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1397.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1397', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1397, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ جلو پژو ۴۰۵ ABS', 'لوازم چرخ جلو پژو ۴۰۵ ABS فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1398.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1398', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1398, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ جلو پیکان ۲۶۱۵', 'لوازم چرخ جلو پیکان ۲۶۱۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1399.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1399', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1399, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم پمپ ترمز پژو ۴۰۵', 'لوازم پمپ ترمز پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1400.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1400', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1400, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم پمپ کلاچ پیکان ۶۱۵', 'لوازم پمپ کلاچ پیکان ۶۱۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1401.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1401', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1401, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم دو مداره پیکان', 'لوازم دو مداره پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1402.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1402', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1402, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر پلوس ۳ خار پژو ۴۰۵', 'گردگیر پلوس ۳ خار پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1403.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1403', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1403, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر پلوس ۲۴ خار پژو ۴۰۵', 'گردگیر پلوس ۲۴ خار پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1404.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1404', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1404, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر پلوس سمت چرخ پژو ۴۰۵', 'گردگیر پلوس سمت چرخ پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1405.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1405', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1405, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر پلوس سمت گیربکس پژو ۴۰۵', 'گردگیر پلوس سمت گیربکس پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1406.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1406', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1406, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر پلوس سمت چرخ پژو ۲۰۶ تیپ ۲', 'گردگیر پلوس سمت چرخ پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1407.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1407', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1407, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر پلوس سمت چرخ پژو ۲۰۶ تیپ ۵', 'گردگیر پلوس سمت چرخ پژو ۲۰۶ تیپ ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1408.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1408', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1408, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر پلوس ۳ خار پژو ۲۰۶ تیپ ۲', 'گردگیر پلوس ۳ خار پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1409.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1409', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1409, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر پلوس ۳ خار پژو ۲۰۶ تیپ ۵', 'گردگیر پلوس ۳ خار پژو ۲۰۶ تیپ ۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1410.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1410', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1410, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر کمک پژو ۴۰۵', 'گردگیر کمک پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1411.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1411', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1411, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر کمک پژو ۲۰۶', 'گردگیر کمک پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1412.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1412', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1412, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر کمک جلو L90', 'گردگیر کمک جلو L90 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1413.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1413', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1413, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر کمک عقب L90', 'گردگیر کمک عقب L90 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1414.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1414', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1414, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر جعبه فرمان پژو ۴۰۵ راست', 'گردگیر جعبه فرمان پژو ۴۰۵ راست فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1415.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1415', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1415, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر جعبه فرمان پژو ۴۰۵ چپ', 'گردگیر جعبه فرمان پژو ۴۰۵ چپ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1416.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1416', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1416, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر جعبه فرمان پژو ۴۰۵ هیدرولیک', 'گردگیر جعبه فرمان پژو ۴۰۵ هیدرولیک فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1417.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1417', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1417, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر جعبه فرمان پژو ۲۰۶ و SLX', 'گردگیر جعبه فرمان پژو ۲۰۶ و SLX فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1418.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1418', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1418, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر جعبه فرمان L90', 'گردگیر جعبه فرمان L90 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1419.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1419', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1419, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر قرقری فرمان پژو ۴۰۵', 'گردگیر قرقری فرمان پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1420.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1420', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1420, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'راهنما روی گلگیر پژو ۴۰۵', 'راهنما روی گلگیر پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1421.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1421', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1421, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'راهنما روی گلگیر سمند', 'راهنما روی گلگیر سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1422.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1422', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1422, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'راهنما روی گلگیر پژو ۲۰۶', 'راهنما روی گلگیر پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1423.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1423', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1423, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'راهنما روی گلگیر پژو ۲۰۷', 'راهنما روی گلگیر پژو ۲۰۷ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1424.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1424', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1424, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'راهنما روی گلگیر L90', 'راهنما روی گلگیر L90 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1425.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1425', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1425, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چراغ لای درب سمند', 'چراغ لای درب سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1426.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1426', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1426, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چراغ سقف پژو ۴۰۵', 'چراغ سقف پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1427.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1427', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1427, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چراغ سقف سمند', 'چراغ سقف سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1428.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1428', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1428, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چراغ سقف پژو ۲۰۶', 'چراغ سقف پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1429.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1429', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1429, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چراغ نمره پژو ۴۰۵', 'چراغ نمره پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1430.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1430', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1430, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چراغ نمره سمند', 'چراغ نمره سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1431.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1431', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1431, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چراغ نمره پژو ۲۰۶ و پارس', 'چراغ نمره پژو ۲۰۶ و پارس فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1432.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1432', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1432, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چراغ صندوق پژو ۴۰۵', 'چراغ صندوق پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1433.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1433', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1433, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چراغ نقشه خوان', 'چراغ نقشه خوان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1434.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1434', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1434, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب دور قفل صندوق پژو ۴۰۵', 'قاب دور قفل صندوق پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1435.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1435', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1435, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب دور قفل صندوق سمند', 'قاب دور قفل صندوق سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1436.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1436', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1436, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پایه آنتن', 'پایه آنتن فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1437.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1437', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1437, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'برچسب سینی فن پژو ۴۰۵', 'برچسب سینی فن پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1438.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1438', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1438, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آنتن اسپرتی بلند', 'آنتن اسپرتی بلند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1439.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1439', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1439, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آنتن اسپرتی کوتاه', 'آنتن اسپرتی کوتاه فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1440.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1440', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1440, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آنتن سمند', 'آنتن سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1441.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1441', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1441, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آنتن فابریکی بلند', 'آنتن فابریکی بلند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1442.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1442', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1442, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آنتن فابریکی کوتاه', 'آنتن فابریکی کوتاه فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1443.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1443', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1443, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آنتن نیمه فلزی', 'آنتن نیمه فلزی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1444.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1444', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1444, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم جلو پنجره پژو ۴۰۵', 'آرم جلو پنجره پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1445.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1445', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1445, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم جلو پنجره پارس', 'آرم جلو پنجره پارس فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1446.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1446', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1446, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم جلو پنجره پژو ۲۰۶', 'آرم جلو پنجره پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1447.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1447', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1447, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم جلو پنجره EF7', 'آرم جلو پنجره EF7 فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1448.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1448', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1448, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم جلو پنجره سمند LX', 'آرم جلو پنجره سمند LX فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1449.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1449', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1449, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم جلو پنجره سمند', 'آرم جلو پنجره سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1450.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1450', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1450, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم تورینگی سمند', 'آرم تورینگی سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1451.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1451', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1451, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم تورینگی پژو ۴۰۵', 'آرم تورینگی پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1452.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1452', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1452, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم تورینگی خرچنگی پژو ۴۰۵', 'آرم تورینگی خرچنگی پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1453.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1453', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1453, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم شیر پارس', 'آرم شیر پارس فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1454.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1454', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1454, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم شیر پژو ۲۰۶', 'آرم شیر پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1455.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1455', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1455, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم شیر پژو SLX', 'آرم شیر پژو SLX فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-1456.jpg',
    ARRAY['آرم', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1456', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1456, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع شیشه شور پژو ۴۰۵', 'منبع شیشه شور پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1463.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1463', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1463, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع شیشه شور سمند', 'منبع شیشه شور سمند فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1464.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1464', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1464, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع شیشه شور پژو ۲۰۶', 'منبع شیشه شور پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1465.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1465', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1465, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع روغن ترمز پژو ۴۰۵', 'منبع روغن ترمز پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1466.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1466', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1466, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع روغن ترمز پژو ۲۰۶ و رانا', 'منبع روغن ترمز پژو ۲۰۶ و رانا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1467.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1467', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1467, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع روغن ترمز پیکان', 'منبع روغن ترمز پیکان فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1468.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1468', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1468, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع انبساط پژو ۲۰۶ تیپ ۲', 'منبع انبساط پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1469.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1469', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1469, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع انبساط پژو ۲۰۶ تیپ ۵ و پژو ۲۰۷', 'منبع انبساط پژو ۲۰۶ تیپ ۵ و پژو ۲۰۷ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1470.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1470', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1470, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع هیدرولیک پژو ۴۰۵', 'منبع هیدرولیک پژو ۴۰۵ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1471.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1471', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1471, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع هیدرولیک پژو ۲۰۶ تیپ ۲', 'منبع هیدرولیک پژو ۲۰۶ تیپ ۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1472.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1472', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1472, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع هیدرولیک پژو ۲۰۶ تیپ ۵ پایینی', 'منبع هیدرولیک پژو ۲۰۶ تیپ ۵ پایینی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1473.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1473', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1473, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع هیدرولیک RD', 'منبع هیدرولیک RD فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1474.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1474', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1474, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پایه فیلتر پژو ۲۰۶', 'پایه فیلتر پژو ۲۰۶ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1475.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1475', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1475, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب تسمه تایم پژو ۴۰۵ بالایی', 'قاب تسمه تایم پژو ۴۰۵ بالایی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1476.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1476', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1476, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب تسمه تایم پژو ۴۰۵ میانی', 'قاب تسمه تایم پژو ۴۰۵ میانی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1477.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1477', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1477, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب تسمه تایم پژو ۴۰۵ پایینی', 'قاب تسمه تایم پژو ۴۰۵ پایینی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1478.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1478', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1478, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب تسمه تایم پژو ۲۰۶ تیپ ۲ پایینی', 'قاب تسمه تایم پژو ۲۰۶ تیپ ۲ پایینی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1479.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1479', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1479, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب تسمه تایم پژو ۲۰۶ تیپ ۲ بالایی', 'قاب تسمه تایم پژو ۲۰۶ تیپ ۲ بالایی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1480.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1480', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1480, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب تسمه تایم پژو ۲۰۶ تیپ ۵ بالایی', 'قاب تسمه تایم پژو ۲۰۶ تیپ ۵ بالایی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1481.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1481', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1481, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب تسمه تایم پژو ۲۰۶ تیپ ۵ میانی', 'قاب تسمه تایم پژو ۲۰۶ تیپ ۵ میانی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1482.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1482', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1482, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب تسمه تایم پژو ۲۰۶ تیپ ۵ پایینی', 'قاب تسمه تایم پژو ۲۰۶ تیپ ۵ پایینی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-1483.jpg',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1483', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶', 'IranKhodro', 'پژو ۴۰۵، پژو پارس، سمند، ۲۰۶',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 1483, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار تودری پراید', 'خار تودری پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2001.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2001', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2001, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار تودری پراید ۱۳۱ و ۱۳۲', 'خار تودری پراید ۱۳۱ و ۱۳۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2002.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2002', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2002, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار سقف طوسی و کرم و مشکی پراید', 'خار سقف طوسی و کرم و مشکی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2003.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2003', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2003, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار شلگیر پراید', 'خار شلگیر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2004.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2004', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2004, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار موکت طوسی و مشکی پراید', 'خار موکت طوسی و مشکی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2005.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2005', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2005, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار طاقچه عقب چهار درب پراید', 'خار طاقچه عقب چهار درب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2006.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2006', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2006, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار سپر بزرگ و کوچک پراید', 'خار سپر بزرگ و کوچک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2007.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2007', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2007, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار آبگیر بیرونی پراید', 'خار آبگیر بیرونی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2008.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2008', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2008, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار آبگیر داخلی پراید', 'خار آبگیر داخلی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2009.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2009', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2009, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دستگیره مچی پراید', 'خار دستگیره مچی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2010.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2010', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2010, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار ابرویی پراید', 'خار ابرویی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2011.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2011', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2011, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار بلوری پراید', 'خار بلوری پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2012.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2012', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2012, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار جلو پنجره پراید', 'خار جلو پنجره پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2013.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2013', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2013, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار وسط جلو پنجره پراید', 'خار وسط جلو پنجره پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2014.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2014', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2014, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار راهنما پارک پراید', 'خار راهنما پارک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2015.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2015', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2015, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار گوشه سپر پراید', 'خار گوشه سپر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2016.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2016', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2016, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دستگیره داخلی پراید', 'خار دستگیره داخلی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2017.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2017', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2017, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دستگیره بیرونی پراید', 'خار دستگیره بیرونی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2018.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2018', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2018, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دور شاسی قفل کن پراید', 'خار دور شاسی قفل کن پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2019.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2019', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2019, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار پارکابی پراید', 'خار پارکابی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2020.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2020', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2020, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار ثابت میل کاپوت پراید', 'خار ثابت میل کاپوت پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2021.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2021', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2021, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار چرخشی میل کاپوت پراید', 'خار چرخشی میل کاپوت پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2022.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2022', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2022, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار پایه چراغ پراید ۱۳۲', 'خار پایه چراغ پراید ۱۳۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2023.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2023', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2023, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار پایه چراغ پراید ۱۳۱', 'خار پایه چراغ پراید ۱۳۱ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2024.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2024', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2024, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دسته جک پراید', 'خار دسته جک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2025.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2025', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2025, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار ریل شیشه پراید', 'خار ریل شیشه پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2026.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2026', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2026, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار مهره گل پخش کن پراید', 'خار مهره گل پخش کن پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2027.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2027', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2027, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار مکانیزم قفل صندوق پراید', 'خار مکانیزم قفل صندوق پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2028.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2028', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2028, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار مکانیزم قفل درب پراید', 'خار مکانیزم قفل درب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2029.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2029', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2029, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار خورشیدی قفل درب پراید', 'خار خورشیدی قفل درب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2030.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2030', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2030, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار چراغ خطر تیبا', 'خار چراغ خطر تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2031.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2031', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2031, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار سپر تیبا بزرگ و کوچک', 'خار سپر تیبا بزرگ و کوچک فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2032.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2032', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2032, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه خار سپر عقب پراید', 'مجموعه خار سپر عقب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2033.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2033', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2033, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه خار سپر جلو پراید', 'مجموعه خار سپر جلو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2034.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2034', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2034, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه خار سپر عقب ۱۳۲', 'مجموعه خار سپر عقب ۱۳۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2035.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2035', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2035, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه خار سپر جلو ۱۳۲', 'مجموعه خار سپر جلو ۱۳۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2036.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2036', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2036, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه خار سپر عقب تیبا', 'مجموعه خار سپر عقب تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2037.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2037', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2037, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه خار سپر جلو تیبا', 'مجموعه خار سپر جلو تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2038.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2038', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2038, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه خار گل پخش کن عقب پراید', 'مجموعه خار گل پخش کن عقب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2039.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2039', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2039, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه خار گل پخش کن جلو پراید', 'مجموعه خار گل پخش کن جلو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2040.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2040', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2040, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه خار جلو پنجره پراید', 'مجموعه خار جلو پنجره پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2041.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2041', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2041, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه خار تودری پراید', 'مجموعه خار تودری پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2042.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2042', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2042, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش دو شاخ کلاچ پراید', 'بوش دو شاخ کلاچ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2043.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2043', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2043, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش دو شاخ کلاچ پراید جدید', 'بوش دو شاخ کلاچ پراید جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2044.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2044', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2044, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش دست دنده پراید', 'بوش دست دنده پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2045.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2045', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2045, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش جعبه فرمان پراید', 'بوش جعبه فرمان پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2046.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2046', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2046, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش هلالی جعبه فرمان پراید', 'بوش هلالی جعبه فرمان پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2047.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2047', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2047, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'محافظ بوش طبق پراید', 'محافظ بوش طبق پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2048.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2048', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2048, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش رام پراید', 'بوش رام پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2049.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2049', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2049, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش ته میل لنگ پراید', 'بوش ته میل لنگ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2050.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2050', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2050, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش سر سیلندر پراید', 'بوش سر سیلندر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2051.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2051', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2051, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چرخ دنده داخل گیربکس پراید', 'چرخ دنده داخل گیربکس پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2052.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2052', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2052, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کالئوچی سر کمک پراید', 'کالئوچی سر کمک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2053.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2053', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2053, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'نعلبکی سر کمک پراید', 'نعلبکی سر کمک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2054.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2054', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2054, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چپقی درب سوپاپ پراید', 'چپقی درب سوپاپ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2055.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2055', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2055, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چپقی درب سوپاپ یورو ۴ پراید', 'چپقی درب سوپاپ یورو ۴ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2056.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2056', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2056, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پایه جلو پنجره پراید ۱۳۲', 'پایه جلو پنجره پراید ۱۳۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2057.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2057', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2057, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ریل صندلی پراید', 'ریل صندلی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2058.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2058', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2058, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پایه آفتابگیر پراید', 'پایه آفتابگیر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2059.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2059', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2059, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب برف پاک کن پراید', 'قاب برف پاک کن پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2060.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2060', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2060, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره کولر پراید', 'مهره کولر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2061.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2061', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2061, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دوراهی شیشه شور پراید', 'دوراهی شیشه شور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2062.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2062', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2062, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی شیشه شور پراید', 'سه راهی شیشه شور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2063.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2063', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2063, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع شیشه شور کاربراتور پراید', 'درب منبع شیشه شور کاربراتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2064.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2064', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2064, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع شیشه شور انژکتور پراید', 'درب منبع شیشه شور انژکتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2065.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2065', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2065, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع آب اضافه پراید جدید', 'درب منبع آب اضافه پراید جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2066.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2066', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2066, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع آب اضافه پراید', 'درب منبع آب اضافه پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2067.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2067', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2067, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع آب اضافه تیبا', 'درب منبع آب اضافه تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2068.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2068', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2068, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب رادیاتور فلزی پراید', 'درب رادیاتور فلزی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2069.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2069', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2069, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب رادیاتور پلیمری پراید', 'درب رادیاتور پلیمری پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2070.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2070', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2070, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب روغن موتور پراید', 'درب روغن موتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2071.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2071', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2071, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع روغن موتور یورو ۴ پراید', 'درب منبع روغن موتور یورو ۴ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2072.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2072', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2072, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب باک پراید', 'درب باک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2073.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2073', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2073, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب باک یورو ۲ پراید', 'درب باک یورو ۲ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2074.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2074', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2074, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب باک یورو ۴ پراید', 'درب باک یورو ۴ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2075.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2075', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2075, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب CNG پیچی پراید', 'درب CNG پیچی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2076.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2076', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2076, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب CNG بنددار پراید', 'درب CNG بنددار پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2077.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2077', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2077, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب CNG فشاری پراید', 'درب CNG فشاری پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2078.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2078', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2078, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع روغن هیدرولیک پراید', 'درب منبع روغن هیدرولیک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2079.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2079', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2079, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع روغن ترمز پراید', 'درب منبع روغن ترمز پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2080.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2080', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2080, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب منبع روغن ترمز ABS پراید', 'درب منبع روغن ترمز ABS پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2081.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2081', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2081, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب ترموستات یورو ۴ پراید', 'درب ترموستات یورو ۴ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2082.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2082', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2082, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب ترموستات کاربراتور پراید', 'درب ترموستات کاربراتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2083.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2083', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2083, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درب ترموستات انژکتور پراید', 'درب ترموستات انژکتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2084.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2084', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2084, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چشم شیشه شور پراید', 'چشم شیشه شور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2085.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2085', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2085, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کلید لای صندوق پراید', 'کلید لای صندوق پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2086.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2086', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2086, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سوئیچ درب موتور پراید', 'سوئیچ درب موتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2087.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2087', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2087, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سیم فیوز پراید', 'سیم فیوز پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2088.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2088', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2088, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فیوز ضربه ای پراید', 'فیوز ضربه ای پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2089.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2089', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2089, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'جعبه فیوز کامل پراید', 'جعبه فیوز کامل پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2090.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2090', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2090, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کلید لای درب پراید', 'کلید لای درب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2091.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2091', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2091, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کلید لای درب تیبا', 'کلید لای درب تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2092.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2092', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2092, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دو شاخه استارت پراید', 'دو شاخه استارت پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2093.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2093', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2093, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دو شاخه استارت قدیم پراید', 'دو شاخه استارت قدیم پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2094.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2094', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2094, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ولوم بخاری قدیم پراید', 'ولوم بخاری قدیم پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2095.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2095', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2095, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ولوم بخاری جدید پراید', 'ولوم بخاری جدید پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2096.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2096', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2096, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کورکن دلکو پراید', 'کورکن دلکو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2097.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2097', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2097, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوله اصلی پراید', 'لوله اصلی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2098.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2098', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2098, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوله فرعی پراید', 'لوله فرعی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2099.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2099', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2099, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوله فرعی یورو ۴ پراید', 'لوله فرعی یورو ۴ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2100.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2100', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2100, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گز روغن پراید', 'گز روغن پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2101.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2101', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2101, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گز روغن تیبا و یورو ۴', 'گز روغن تیبا و یورو ۴ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2102.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2102', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2102, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر ترموستات پراید', 'واشر ترموستات پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2103.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2103', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2103, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر گلویی ۲ پیچ پراید', 'واشر گلویی ۲ پیچ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2104.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2104', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2104, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر گلویی ۳ پیچ پراید', 'واشر گلویی ۳ پیچ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2105.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2105', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2105, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر گلویی گرد پراید', 'واشر گلویی گرد پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2106.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2106', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2106, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کاپ چرخ پراید', 'کاپ چرخ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2107.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2107', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2107, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کاپ چرخ تیبا', 'کاپ چرخ تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2108.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2108', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2108, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'حامل شیشه بالابر پراید', 'حامل شیشه بالابر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2109.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2109', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2109, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست اطراف باطری پراید', 'بست اطراف باطری پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2110.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2110', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2110, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست اطراف باطری جدید پراید', 'بست اطراف باطری جدید پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2111.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2111', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2111, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قفل باطری پراید', 'قفل باطری پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2112.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2112', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2112, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر باطری پراید', 'سر باطری پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2113.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2113', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2113, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی شیلنگ بنزین ۱۰-۱۶ پراید', 'بست فلزی شیلنگ بنزین ۱۰-۱۶ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2114.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2114', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2114, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی شیلنگ بوستر ۱۳-۱۹ پراید', 'بست فلزی شیلنگ بوستر ۱۳-۱۹ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2115.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2115', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2115, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی شیلنگ بخاری ۲۰-۳۰ پراید', 'بست فلزی شیلنگ بخاری ۲۰-۳۰ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2116.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2116', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2116, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی شیلنگ رادیاتور ۲۵-۴۲ پراید', 'بست فلزی شیلنگ رادیاتور ۲۵-۴۲ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2117.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2117', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2117, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی پلوس کوچک پراید', 'بست فلزی پلوس کوچک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2118.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2118', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2118, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی پلوس بزرگ پراید', 'بست فلزی پلوس بزرگ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2119.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2119', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2119, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی استیل کوتاه ۳۸ پراید', 'بست فلزی استیل کوتاه ۳۸ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2120.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2120', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2120, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست فلزی استیل بلند ۶۵ پراید', 'بست فلزی استیل بلند ۶۵ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2121.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2121', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2121, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست کمربندی ۳۰x۳.۶ پراید', 'بست کمربندی ۳۰x۳.۶ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2122.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2122', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2122, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست کمربندی ۳۷x۳.۶ پراید', 'بست کمربندی ۳۷x۳.۶ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2123.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2123', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2123, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست کمربندی ۳۰x۴.۸ پراید', 'بست کمربندی ۳۰x۴.۸ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2124.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2124', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2124, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست کمربندی ۳۷x۴.۸ پراید', 'بست کمربندی ۳۷x۴.۸ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2125.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2125', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2125, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بست کمربندی ۳۷x۷.۶ پراید', 'بست کمربندی ۳۷x۷.۶ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2126.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2126', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2126, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار سگدست پراید', 'خار سگدست پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2127.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2127', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2127, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار میانی پلوس پراید', 'خار میانی پلوس پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2128.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2128', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2128, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار سماوری گیربکس پراید', 'خار سماوری گیربکس پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2129.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2129', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2129, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار پلوس ضخیم و نازک پراید', 'خار پلوس ضخیم و نازک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2130.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2130', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2130, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار پلوس شاخدار پراید', 'خار پلوس شاخدار پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2131.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2131', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2131, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'رینگ اولیه و ثانویه پراید', 'رینگ اولیه و ثانویه پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2132.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2132', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2132, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر تنظیم گیربکس پراید', 'واشر تنظیم گیربکس پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2133.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2133', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2133, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر دیسپلی پراید', 'واشر دیسپلی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2134.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2134', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2134, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شاخص میل سوپاپ پراید', 'شاخص میل سوپاپ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2135.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2135', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2135, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آهنربای گیربکس پراید', 'آهنربای گیربکس پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2136.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2136', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2136, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'نیم خار سوپاپ پراید', 'نیم خار سوپاپ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2137.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2137', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2137, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دمپر سیم کلاچ پراید', 'دمپر سیم کلاچ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2138.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2138', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2138, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار سر میل لنگ پراید', 'خار سر میل لنگ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2139.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2139', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2139, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار موشکی گیربکس پراید', 'خار موشکی گیربکس پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2140.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2140', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2140, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ساچمه ماهک پراید', 'ساچمه ماهک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2141.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2141', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2141, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پین دیسپلی پراید', 'پین دیسپلی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2142.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2142', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2142, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پین ماهک گیربکس پراید', 'پین ماهک گیربکس پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2143.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2143', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2143, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره تنظیم ترمز دستی پراید', 'مهره تنظیم ترمز دستی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2144.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2144', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2144, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ساچمه لوبیایی پراید', 'ساچمه لوبیایی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2145.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2145', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2145, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فنر ساچمه گیربکس پراید', 'فنر ساچمه گیربکس پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2146.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2146', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2146, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار فلزی لبه سپر پراید', 'خار فلزی لبه سپر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2147.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2147', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2147, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار قاب ضبط پراید', 'خار قاب ضبط پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2148.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2148', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2148, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار قاب ضبط پراید ۱۳۲', 'خار قاب ضبط پراید ۱۳۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2149.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2149', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2149, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار قاب ستون فلزی پراید', 'خار قاب ستون فلزی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2150.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2150', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2150, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار سوزن انژکتور پراید', 'خار سوزن انژکتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2151.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2151', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2151, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دوشاخه سیم کلاچ پراید', 'خار دوشاخه سیم کلاچ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2152.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2152', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2152, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دوشاخه شیلنگ ترمز پراید', 'خار دوشاخه شیلنگ ترمز پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2153.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2153', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2153, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دوشاخه قفل صندوق پراید', 'خار دوشاخه قفل صندوق پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2154.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2154', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2154, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار دوشاخه قفل درب پراید', 'خار دوشاخه قفل درب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2155.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2155', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2155, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار زه شیشه جلو فلزی پراید', 'خار زه شیشه جلو فلزی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2156.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2156', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2156, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار شیشه چراغ پراید', 'خار شیشه چراغ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2157.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2157', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2157, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار ناخنی لنت پراید', 'خار ناخنی لنت پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2158.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2158', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2158, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'صفحه پشت لنت پراید', 'صفحه پشت لنت پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2159.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2159', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2159, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خورشیدی سر پلوس پراید', 'خورشیدی سر پلوس پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2160.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2160', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2160, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پین لنت جلو پراید', 'پین لنت جلو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2161.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2161', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2161, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اشپیل سگدست پراید', 'اشپیل سگدست پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2162.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2162', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2162, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه فنر لنت عقب پراید', 'مجموعه فنر لنت عقب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2163.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2163', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2163, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه فنر لنت عقب تیبا', 'مجموعه فنر لنت عقب تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2164.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2164', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2164, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فنر عنکبوتی لنت جلو پراید', 'فنر عنکبوتی لنت جلو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2165.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2165', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2165, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فنر پدال گاز پراید', 'فنر پدال گاز پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2166.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2166', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2166, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فنر پدال کلاچ پراید', 'فنر پدال کلاچ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2167.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2167', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2167, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'فنر دوشاخ کلاچ پراید', 'فنر دوشاخ کلاچ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2168.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2168', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2168, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ چرخ پراید', 'پیچ چرخ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2169.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2169', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2169, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ و مهره چرخ تیبا', 'پیچ و مهره چرخ تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2170.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2170', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2170, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ گل پخش کن عقب پراید', 'پیچ گل پخش کن عقب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2171.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2171', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2171, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ گوشه سپر پراید', 'پیچ گوشه سپر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2172.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2172', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2172, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ شلگیر و ابرویی پراید', 'پیچ شلگیر و ابرویی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2173.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2173', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2173, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ قاب ضبط و پارکابی پراید', 'پیچ قاب ضبط و پارکابی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2174.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2174', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2174, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دستگیره مچی پراید', 'پیچ دستگیره مچی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2175.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2175', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2175, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ گلگیر پراید', 'پیچ گلگیر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2176.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2176', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2176, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ قاب تسمه تایم پراید', 'پیچ قاب تسمه تایم پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2177.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2177', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2177, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ سیلندر ترمز کوتاه پراید', 'پیچ سیلندر ترمز کوتاه پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2178.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2178', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2178, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ سیلندر ترمز بلند پراید', 'پیچ سیلندر ترمز بلند پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2179.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2179', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2179, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ کمک جلو پراید', 'پیچ کمک جلو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2180.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2180', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2180, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ کمک عقب پراید', 'پیچ کمک عقب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2181.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2181', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2181, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ درب سوپاپ پراید قدیم', 'پیچ درب سوپاپ پراید قدیم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2182.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2182', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2182, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ درب سوپاپ پراید جدید', 'پیچ درب سوپاپ پراید جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2183.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2183', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2183, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ طبق به سگدست پراید', 'پیچ طبق به سگدست پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2184.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2184', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2184, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ طبق به شاسی پراید', 'پیچ طبق به شاسی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2185.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2185', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2185, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ انگشتی درب سوپاپ پراید', 'پیچ انگشتی درب سوپاپ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2186.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2186', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2186, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ جلو رام پراید', 'پیچ جلو رام پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2187.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2187', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2187, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ عقب رام پراید', 'پیچ عقب رام پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2188.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2188', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2188, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دوسره اگزوز پراید', 'پیچ دوسره اگزوز پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2189.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2189', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2189, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دور کارتل پراید', 'پیچ دور کارتل پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2190.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2190', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2190, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ هواکش انژکتور پراید', 'پیچ هواکش انژکتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2191.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2191', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2191, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ درب ترموستات پراید', 'پیچ درب ترموستات پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2192.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2192', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2192, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دور گیربکس پراید', 'پیچ دور گیربکس پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2193.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2193', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2193, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ هواگیری چرخ جلو پراید', 'پیچ هواگیری چرخ جلو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2194.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2194', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2194, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ هواگیری چرخ عقب پراید', 'پیچ هواگیری چرخ عقب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2195.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2195', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2195, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ کارتل پراید جدید', 'پیچ کارتل پراید جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2196.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2196', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2196, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ کارتل پراید قدیم', 'پیچ کارتل پراید قدیم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2197.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2197', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2197, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ سرسیلندر پراید', 'پیچ سرسیلندر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2198.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2198', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2198, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ گلویی اگزوز پراید', 'پیچ گلویی اگزوز پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2199.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2199', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2199, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ میل سوپاپ پراید', 'پیچ میل سوپاپ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2200.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2200', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2200, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دسته موتور پراید', 'پیچ دسته موتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2201.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2201', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2201, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دیسک و صفحه پراید', 'پیچ دیسک و صفحه پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2202.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2202', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2202, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ زبانه درب پراید', 'پیچ زبانه درب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2203.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2203', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2203, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ دو شاخ کلاچ پراید', 'پیچ دو شاخ کلاچ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2204.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2204', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2204, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ سر میل لنگ پراید', 'پیچ سر میل لنگ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2205.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2205', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2205, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره ۶ پراید', 'مهره ۶ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2206.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2206', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2206, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره ۸ پراید', 'مهره ۸ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2207.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2207', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2207, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره ۱۰ پراید', 'مهره ۱۰ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2208.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2208', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2208, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مهره ۱۲ پراید', 'مهره ۱۲ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2209.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2209', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2209, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پیچ پلاک پراید', 'پیچ پلاک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 11, '/uploads/products/pinpart-2210.jpg',
    ARRAY['پیچ و مهره', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2210', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2210, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قفل کاپوت پراید', 'قفل کاپوت پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2211.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2211', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2211, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قفل صندوق پراید', 'قفل صندوق پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2212.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2212', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2212, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ترمز درب پراید', 'ترمز درب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2213.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2213', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2213, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زبانه صندوق پراید', 'زبانه صندوق پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2214.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2214', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2214, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زبانه قفل درب پراید', 'زبانه قفل درب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2215.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2215', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2215, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر خاردار پراید', 'واشر خاردار پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2216.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2216', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2216, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوله گز پراید', 'لوله گز پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2217.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2217', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2217, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوله برگشت سر سیلندر پراید', 'لوله برگشت سر سیلندر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2218.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2218', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2218, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دوراهی آب سیلندر پراید', 'دوراهی آب سیلندر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2219.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2219', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2219, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دوراهی منیفولد پلیمری پراید', 'دوراهی منیفولد پلیمری پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2220.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2220', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2220, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دوراهی منیفولد رزوه دار پراید', 'دوراهی منیفولد رزوه دار پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2221.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2221', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2221, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دوراهی منیفولد بدون رزوه پراید', 'دوراهی منیفولد بدون رزوه پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2222.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2222', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2222, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پوکه سیلندر ترمز بلند پراید', 'پوکه سیلندر ترمز بلند پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2223.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2223', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2223, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پوکه سیلندر ترمز کوتاه پراید', 'پوکه سیلندر ترمز کوتاه پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2224.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2224', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2224, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آب گازسوز CNG پراید', 'سه راهی آب گازسوز CNG پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2225.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2225', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2225, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آب گازسوز LPG پراید', 'سه راهی آب گازسوز LPG پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2226.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2226', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2226, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آب گازسوز سفید پراید', 'سه راهی آب گازسوز سفید پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2227.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2227', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2227, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سه راهی آب گازسوز فلزی پراید', 'سه راهی آب گازسوز فلزی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2228.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2228', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2228, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'میل کاپوت پراید', 'میل کاپوت پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2229.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2229', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2229, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'میل جک پراید', 'میل جک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2230.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2230', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2230, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آچار چرخ پراید', 'آچار چرخ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2231.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2231', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2231, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دیاق گوشه سپر جلو پراید', 'دیاق گوشه سپر جلو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2232.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2232', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2232, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دیاق گوشه سپر عقب پراید', 'دیاق گوشه سپر عقب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2233.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2233', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2233, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لولایی سپر پراید', 'لولایی سپر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2234.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2234', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2234, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زیر باطری پراید', 'زیر باطری پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2235.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2235', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2235, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پولکی سیلندر پراید', 'پولکی سیلندر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2236.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2236', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2236, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دیاق بالای رادیاتور فلزی پراید', 'دیاق بالای رادیاتور فلزی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2237.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2237', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2237, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دیاق بالای رادیاتور پلیمری پراید', 'دیاق بالای رادیاتور پلیمری پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2238.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2238', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2238, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لرزه گیر کولر پراید', 'لرزه گیر کولر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2239.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2239', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2239, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ سوزن انژکتور پراید', 'اورینگ سوزن انژکتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2240.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2240', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2240, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ دلکو پراید کاربراتور', 'اورینگ دلکو پراید کاربراتور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2241.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2241', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2241, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ دلکو پراید انژکتور', 'اورینگ دلکو پراید انژکتور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2242.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2242', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2242, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درجه باک پراید', 'اورینگ درجه باک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2243.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2243', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2243, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درجه باک یورو ۴ و تیبا فلزی', 'اورینگ درجه باک یورو ۴ و تیبا فلزی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2244.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2244', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2244, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ درجه باک یورو ۴ و تیبا پلاستیکی', 'اورینگ درجه باک یورو ۴ و تیبا پلاستیکی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2245.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2245', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2245, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ لوله فرعی پراید', 'اورینگ لوله فرعی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2246.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2246', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2246, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ گیج کیلومتر پراید', 'اورینگ گیج کیلومتر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2247.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2247', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2247, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ فشار شکن پراید', 'اورینگ فشار شکن پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2248.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2248', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2248, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ میل سوپاپ پراید زیمنس', 'اورینگ میل سوپاپ پراید زیمنس فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2249.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2249', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2249, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'اورینگ میل سوپاپ پراید ساژم', 'اورینگ میل سوپاپ پراید ساژم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2250.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2250', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2250, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر هلالی پراید', 'واشر هلالی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2251.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2251', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2251, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'واشر درب سوپاپ پراید', 'واشر درب سوپاپ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2252.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2252', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2252, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک بالای کمک پراید', 'لاستیک بالای کمک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2253.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2253', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2253, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک پایین کمک پراید', 'لاستیک پایین کمک پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2254.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2254', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2254, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک خورشیدی رام پراید', 'لاستیک خورشیدی رام پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2255.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2255', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2255, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک تحت رام پراید', 'لاستیک تحت رام پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2256.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2256', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2256, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک پایین رادیاتور پراید', 'لاستیک پایین رادیاتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2257.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2257', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2257, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک بالای رادیاتور پراید', 'لاستیک بالای رادیاتور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2258.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2258', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2258, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک فنر لول جلو پراید', 'لاستیک فنر لول جلو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2259.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2259', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2259, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک فنر لول عقب پراید', 'لاستیک فنر لول عقب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2260.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2260', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2260, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک فنر لول مزدایی پراید', 'لاستیک فنر لول مزدایی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2261.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2261', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2261, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک منبع روغن ترمز پراید', 'لاستیک منبع روغن ترمز پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2262.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2262', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2262, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک منبع شیشه شور پراید', 'لاستیک منبع شیشه شور پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2263.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2263', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2263, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک چپقی درب سوپاپ پراید', 'لاستیک چپقی درب سوپاپ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2264.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2264', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2264, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک تعادل پراید', 'لاستیک تعادل پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2265.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2265', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2265, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک چاکدار پراید', 'لاستیک چاکدار پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2266.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2266', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2266, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش اکسل لاستیکی پراید', 'بوش اکسل لاستیکی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2267.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2267', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2267, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش پایه کمک تمام لاستیکی پراید', 'بوش پایه کمک تمام لاستیکی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2268.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2268', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2268, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'بوش طبق لاستیکی پراید', 'بوش طبق لاستیکی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2269.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2269', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2269, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر لیور دنده پراید', 'گردگیر لیور دنده پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2270.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2270', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2270, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منجید اگزوز پراید', 'منجید اگزوز پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2271.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2271', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2271, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منجید اگزوز گرد پراید', 'منجید اگزوز گرد پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2272.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2272', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2272, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ضربه گیر صندوق پراید', 'ضربه گیر صندوق پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2273.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2273', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2273, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'ضربه گیر کاپوت بلند پراید', 'ضربه گیر کاپوت بلند پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2274.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2274', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2274, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شیلنگ بو پراید', 'شیلنگ بو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2275.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2275', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2275, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک پدال پراید', 'لاستیک پدال پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2276.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2276', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2276, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک آبگیر کف پراید بزرگ', 'لاستیک آبگیر کف پراید بزرگ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2277.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2277', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2277, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک آبگیر کف پراید متوسط', 'لاستیک آبگیر کف پراید متوسط فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2278.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2278', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2278, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لاستیک آبگیر کف پراید کوچک', 'لاستیک آبگیر کف پراید کوچک فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2279.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2279', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2279, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر کلید لای درب پراید', 'گردگیر کلید لای درب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2280.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2280', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2280, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر سیبک فرمان پراید', 'گردگیر سیبک فرمان پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2281.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2281', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2281, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر جعبه فرمان پراید', 'گردگیر جعبه فرمان پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2282.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2282', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2282, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر جعبه فرمان پراید هیدرولیک', 'گردگیر جعبه فرمان پراید هیدرولیک فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2283.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2283', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2283, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر کمک عقب پراید', 'گردگیر کمک عقب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2284.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2284', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2284, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر کمک جلو پراید', 'گردگیر کمک جلو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2285.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2285', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2285, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر پلوس ۳ خار پراید', 'گردگیر پلوس ۳ خار پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2286.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2286', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2286, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گردگیر پلوس سمت چرخ پراید', 'گردگیر پلوس سمت چرخ پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2287.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2287', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2287, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم نیم ست چرخ جلو پراید', 'لوازم نیم ست چرخ جلو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2288.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2288', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2288, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ جلو پراید', 'لوازم چرخ جلو پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2289.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2289', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2289, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ جلو تیبا', 'لوازم چرخ جلو تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2290.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2290', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2290, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ عقب پراید', 'لوازم چرخ عقب پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2291.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2291', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2291, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم چرخ عقب تیبا', 'لوازم چرخ عقب تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2292.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2292', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2292, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم پمپ ترمز پراید', 'لوازم پمپ ترمز پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2293.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2293', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2293, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوازم پمپ ترمز پراید ABS', 'لوازم پمپ ترمز پراید ABS فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2294.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2294', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2294, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره داخلی صبا پراید', 'دستگیره داخلی صبا پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2295.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2295', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2295, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره داخلی پراید ۱۳۱ طوسی', 'دستگیره داخلی پراید ۱۳۱ طوسی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2296.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2296', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2296, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره داخلی پراید ۱۳۱ مشکی', 'دستگیره داخلی پراید ۱۳۱ مشکی فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2297.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2297', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2297, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره داخلی پراید ۱۴۱', 'دستگیره داخلی پراید ۱۴۱ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2298.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2298', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2298, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره بیرونی پراید', 'دستگیره بیرونی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2299.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2299', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2299, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره بخواب صندلی پراید', 'دستگیره بخواب صندلی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2300.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2300', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2300, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره داخلی تیبا', 'دستگیره داخلی تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2301.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2301', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2301, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره بیرونی تیبا', 'دستگیره بیرونی تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2302.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2302', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2302, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره شیشه بالابر پراید', 'دستگیره شیشه بالابر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2303.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2303', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2303, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'دستگیره شیشه بالابر پراید ۱۴۱', 'دستگیره شیشه بالابر پراید ۱۴۱ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2304.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2304', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2304, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زبانه داشبورد پراید ۱۳۱', 'زبانه داشبورد پراید ۱۳۱ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2305.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2305', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2305, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زبانه داشبورد پراید', 'زبانه داشبورد پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2306.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2306', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2306, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'راهنما روی گلگیر پراید', 'راهنما روی گلگیر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2307.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2307', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2307, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'راهنما روی گلگیر تیبا', 'راهنما روی گلگیر تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2308.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2308', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2308, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'راهنما روی گلگیر ساینا', 'راهنما روی گلگیر ساینا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2309.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2309', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2309, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چراغ سقف پراید', 'چراغ سقف پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2310.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2310', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2310, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چراغ نمره پراید', 'چراغ نمره پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2311.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2311', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2311, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'طلق داخل سپر پراید', 'طلق داخل سپر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2312.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2312', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2312, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'پایه آنتن پراید', 'پایه آنتن پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2313.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2313', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2313, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آنتن اسپرتی کوتاه پراید', 'آنتن اسپرتی کوتاه پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2314.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2314', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2314, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آنتن اسپرتی بلند پراید', 'آنتن اسپرتی بلند پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2315.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2315', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2315, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آنتن فابریکی کوتاه پراید', 'آنتن فابریکی کوتاه پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2316.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2316', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2316, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آنتن فابریکی بلند پراید', 'آنتن فابریکی بلند پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2317.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2317', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2317, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آنتن نیمه فلزی پراید', 'آنتن نیمه فلزی پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2318.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2318', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2318, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع آب اضافه پراید قدیم', 'منبع آب اضافه پراید قدیم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2319.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2319', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2319, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع آب اضافه پراید جدید', 'منبع آب اضافه پراید جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2320.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2320', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2320, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع آب اضافه تیبا قدیم', 'منبع آب اضافه تیبا قدیم فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2321.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2321', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2321, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع آب اضافه تیبا جدید', 'منبع آب اضافه تیبا جدید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2322.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2322', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2322, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع روغن ترمز پراید', 'منبع روغن ترمز پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2323.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2323', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2323, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع روغن ترمز پراید ABS', 'منبع روغن ترمز پراید ABS فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2324.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2324', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2324, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع شیشه شور پراید کاربراتور', 'منبع شیشه شور پراید کاربراتور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2325.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2325', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2325, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع شیشه شور پراید انژکتور', 'منبع شیشه شور پراید انژکتور فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2326.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2326', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2326, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع شیشه شور پراید دو تکه', 'منبع شیشه شور پراید دو تکه فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2327.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2327', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2327, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'منبع آرامش پراید', 'منبع آرامش پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2328.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2328', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2328, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب تسمه تایم پراید', 'قاب تسمه تایم پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2329.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2329', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2329, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قاب دور ضبط پراید', 'قاب دور ضبط پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2330.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2330', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2330, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'شاسی قفل کن پراید', 'شاسی قفل کن پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2331.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2331', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2331, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر دنده پراید', 'سر دنده پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2332.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2332', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2332, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر دنده پراید ۱۴۱', 'سر دنده پراید ۱۴۱ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2333.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2333', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2333, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'سر دنده تیبا', 'سر دنده تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2334.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2334', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2334, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'چرم دست دنده پراید', 'چرم دست دنده پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2335.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2335', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2335, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'کاور کامپیوتر پراید', 'کاور کامپیوتر پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2336.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2336', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2336, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم تک تک سایپا', 'آرم تک تک سایپا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2337.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2337', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2337, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم تک تک پراید ۱۳۱', 'آرم تک تک پراید ۱۳۱ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2338.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2338', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2338, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم تک تک پراید ۱۳۲', 'آرم تک تک پراید ۱۳۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2339.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2339', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2339, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم تک تک پراید ۱۱۱', 'آرم تک تک پراید ۱۱۱ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2340.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2340', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2340, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم تک تک پراید ۱۴۱', 'آرم تک تک پراید ۱۴۱ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2341.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2341', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2341, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته تیبا', 'آرم نوشته تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2342.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2342', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2342, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قالپاق ۱۴۱ کوچک', 'قالپاق ۱۴۱ کوچک فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2343.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2343', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2343, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم تورینگی تیبا', 'آرم تورینگی تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2344.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2344', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2344, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قالپاق ۱۴۱ بزرگ', 'قالپاق ۱۴۱ بزرگ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2345.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2345', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2345, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم جلو پنجره تیبا', 'آرم جلو پنجره تیبا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2346.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2346', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2346, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم جلو پنجره سایپا', 'آرم جلو پنجره سایپا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2347.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2347', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2347, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم جلو پنجره کیا', 'آرم جلو پنجره کیا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2348.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2348', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2348, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم جلو پنجره ۱۳۲', 'آرم جلو پنجره ۱۳۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2349.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2349', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2349, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم صندوق ۱۳۲', 'آرم صندوق ۱۳۲ فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2350.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2350', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2350, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم صبا و سایپا', 'آرم صبا و سایپا فابریک با کیفیت درجه یک بازار چراغ برق تهران', 12, '/uploads/products/pinpart-2351.jpg',
    ARRAY['آرم', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2351', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2351, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'برچسب سینی فن پراید', 'برچسب سینی فن پراید فابریک با کیفیت درجه یک بازار چراغ برق تهران', 10, '/uploads/products/pinpart-2352.jpg',
    ARRAY['خار', 'سایپا', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '2352', 'پراید، تیبا، ساینا، کوییک', 'Saipa', 'پراید، تیبا، ساینا، کوییک',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', 2352, false, true,
    NOW(), NOW()
);

-- ============================================================
-- 4. Insert 168 Emblem Products from Price Lists
-- ============================================================

INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم مجموعه ۱۱۱-۱۴۱-۱۳۲-۱۳۱ سایپا', 'آرم مجموعه ۱۱۱-۱۴۱-۱۳۲-۱۳۱ سایپا با کد فنی MAJMOEH مناسب پراید ۱۱۱, ۱۳۲, ۱۳۱, ۱۴۱', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'MAJMOEH', 'پراید ۱۱۱, ۱۳۲, ۱۳۱, ۱۴۱', 'سایپا', 'پراید ۱۱۱, ۱۳۲, ۱۳۱, ۱۴۱',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3000, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم ۱۵۱ وانت پراید', 'آرم ۱۵۱ وانت پراید با کد فنی DP13051767 مناسب پراید ۱۵۱', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DP13051767', 'پراید ۱۵۱', 'سایپا', 'پراید ۱۵۱',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3001, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته تیبا ۱', 'آرم نوشته تیبا ۱ با کد فنی DN03099358A مناسب تیبا ۱', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN03099358A', 'تیبا ۱', 'سایپا', 'تیبا ۱',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3002, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته تیبا ۲', 'آرم نوشته تیبا ۲ با کد فنی DH16099358B مناسب تیبا ۲', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH16099358B', 'تیبا ۲', 'سایپا', 'تیبا ۲',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3003, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو جلو پنجره تیبا ۱ و ۲', 'آرم لوگو جلو پنجره تیبا ۱ و ۲ با کد فنی DN03099311A مناسب تیبا ۱, تیبا ۲', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN03099311A', 'تیبا ۱, تیبا ۲', 'سایپا', 'تیبا ۱, تیبا ۲',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3004, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'جلو پنجره تیبا مشکی خام', 'جلو پنجره تیبا مشکی خام با کد فنی DN03062300B مناسب تیبا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN03062300B', 'تیبا', 'سایپا', 'تیبا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3005, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'جلو پنجره تیبا مشکی دورکرم', 'جلو پنجره تیبا مشکی دورکرم با کد فنی DN030623008 مناسب تیبا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN030623008', 'تیبا', 'سایپا', 'تیبا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3006, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو درب صندوق عقب تیبا ۲', 'آرم لوگو درب صندوق عقب تیبا ۲ با کد فنی DH16099322D مناسب تیبا ۲', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH16099322D', 'تیبا ۲', 'سایپا', 'تیبا ۲',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3007, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو درب صندوق عقب تیبا S81', 'آرم لوگو درب صندوق عقب تیبا S81 با کد فنی SN03099322 مناسب تیبا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SN03099322', 'تیبا', 'سایپا', 'تیبا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3008, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو ۲۳۲ بزرگ ساینا - کوییک', 'آرم لوگو ۲۳۲ بزرگ ساینا - کوییک با کد فنی DN21099311A مناسب ساینا, کوییک', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN21099311A', 'ساینا, کوییک', 'سایپا', 'ساینا, کوییک',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3009, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو ۲۳۲ کوچک ساینا - کوییک', 'آرم لوگو ۲۳۲ کوچک ساینا - کوییک با کد فنی DN21899322A مناسب ساینا, کوییک', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN21899322A', 'ساینا, کوییک', 'سایپا', 'ساینا, کوییک',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3010, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو جلو پنجره پراید ۱۱۱-۱۳۲', 'آرم لوگو جلو پنجره پراید ۱۱۱-۱۳۲ با کد فنی DN08051775B مناسب پراید ۱۱۱, ۱۳۲', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN08051775B', 'پراید ۱۱۱, ۱۳۲', 'سایپا', 'پراید ۱۱۱, ۱۳۲',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3011, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو درب صندوق عقب پراید ۱۱۱-۱۳۲', 'آرم لوگو درب صندوق عقب پراید ۱۱۱-۱۳۲ با کد فنی SH10051725 مناسب پراید ۱۱۱, ۱۳۲', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SH10051725', 'پراید ۱۱۱, ۱۳۲', 'سایپا', 'پراید ۱۱۱, ۱۳۲',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3012, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم سایپا بیضی قرمز جلو پنجره پراید', 'آرم سایپا بیضی قرمز جلو پنجره پراید با کد فنی SK28T51775 مناسب پراید', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SK28T51775', 'پراید', 'سایپا', 'پراید',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3013, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم آهو بیضی جلو پنجره پراید مشکی', 'آرم آهو بیضی جلو پنجره پراید مشکی با کد فنی BEYZI AHOO مناسب پراید', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'BEYZI AHOO', 'پراید', 'سایپا', 'پراید',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3014, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم آهو جلو پنجره تیبا بزرگ عراقی', 'آرم آهو جلو پنجره تیبا بزرگ عراقی با کد فنی AHOO ARAGHI مناسب تیبا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'AHOO ARAGHI', 'تیبا', 'سایپا', 'تیبا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3015, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم آهو عقب تیبا کوچک عراقی', 'آرم آهو عقب تیبا کوچک عراقی با کد فنی DN03099347 مناسب تیبا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN03099347', 'تیبا', 'سایپا', 'تیبا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3016, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم طیبه تیبا فارسی عراقی', 'آرم طیبه تیبا فارسی عراقی با کد فنی DN03099342 مناسب تیبا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN03099342', 'تیبا', 'سایپا', 'تیبا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3017, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته ساینا لاتین', 'آرم نوشته ساینا لاتین با کد فنی DN21099358A مناسب ساینا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN21099358A', 'ساینا', 'سایپا', 'ساینا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3018, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته ساینا لاتین S', 'آرم نوشته ساینا لاتین S با کد فنی DN21899358A مناسب ساینا S', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN21899358A', 'ساینا S', 'سایپا', 'ساینا S',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3019, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته ساینا فارسی', 'آرم نوشته ساینا فارسی با کد فنی DN21899359 مناسب ساینا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN21899359', 'ساینا', 'سایپا', 'ساینا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3020, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم CNG ساینا', 'آرم CNG ساینا با کد فنی DN21799322 مناسب ساینا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN21799322', 'ساینا', 'سایپا', 'ساینا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3021, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم CVT بغل گلگیر کوییک - ساینا', 'آرم CVT بغل گلگیر کوییک - ساینا با کد فنی DN21899356 مناسب کوییک, ساینا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN21899356', 'کوییک, ساینا', 'سایپا', 'کوییک, ساینا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3022, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم R بغل گلگیر کوییک - ساینا', 'آرم R بغل گلگیر کوییک - ساینا با کد فنی DN21899405 مناسب کوییک, ساینا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN21899405', 'کوییک, ساینا', 'سایپا', 'کوییک, ساینا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3023, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم S بغل گلگیر کوییک - ساینا', 'آرم S بغل گلگیر کوییک - ساینا با کد فنی DN21899401 مناسب کوییک, ساینا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN21899401', 'کوییک, ساینا', 'سایپا', 'کوییک, ساینا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3024, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم G بغل گلگیر کوییک - ساینا', 'آرم G بغل گلگیر کوییک - ساینا با کد فنی DN21899402 مناسب کوییک, ساینا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN21899402', 'کوییک, ساینا', 'سایپا', 'کوییک, ساینا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3025, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم GX بغل گلگیر ساینا', 'آرم GX بغل گلگیر ساینا با کد فنی DN22099407 مناسب ساینا GX', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN22099407', 'ساینا GX', 'سایپا', 'ساینا GX',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3026, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم کوییک فارسی', 'آرم کوییک فارسی با کد فنی DH21099358A مناسب کوییک', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH21099358A', 'کوییک', 'سایپا', 'کوییک',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3027, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته کوئیک لاتین (بزرگ)', 'آرم نوشته کوئیک لاتین (بزرگ) با کد فنی DH21099359A مناسب کوییک', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH21099359A', 'کوییک', 'سایپا', 'کوییک',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3028, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته کوئیک لاتین (کوچک)', 'آرم نوشته کوئیک لاتین (کوچک) با کد فنی DH25599358 مناسب کوییک', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH25599358', 'کوییک', 'سایپا', 'کوییک',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3029, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم کوئیک CVT', 'آرم کوئیک CVT با کد فنی DH21199361 مناسب کوییک', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH21199361', 'کوییک', 'سایپا', 'کوییک',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3030, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم بغل گلگیر کوئیک GXR', 'آرم بغل گلگیر کوئیک GXR با کد فنی DH22099408 مناسب کوییک GXR', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH22099408', 'کوییک GXR', 'سایپا', 'کوییک GXR',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3031, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم کوئیک S', 'آرم کوئیک S با کد فنی DH25599358 مناسب کوییک S', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH25599358', 'کوییک S', 'سایپا', 'کوییک S',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3032, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم کوئیک R', 'آرم کوئیک R با کد فنی DH21099361 مناسب کوییک R', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH21099361', 'کوییک R', 'سایپا', 'کوییک R',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3033, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم کوئیک G', 'آرم کوئیک G با کد فنی DH22099358 مناسب کوییک G', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH22099358', 'کوییک G', 'سایپا', 'کوییک G',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3034, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'نوشته قرمز R کوئیک', 'نوشته قرمز R کوئیک با کد فنی DHR مناسب کوییک R', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DHR', 'کوییک R', 'سایپا', 'کوییک R',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3035, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو روی فرمان کوئیک', 'آرم لوگو روی فرمان کوئیک با کد فنی QUIK GHARBILAK مناسب کوییک', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'QUIK GHARBILAK', 'کوییک', 'سایپا', 'کوییک',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3036, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زه جانبی بغل گلگیر اطلس چپ', 'زه جانبی بغل گلگیر اطلس چپ با کد فنی DH32026625C مناسب اطلس', 10, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH32026625C', 'اطلس', 'سایپا', 'اطلس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3037, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زه جانبی بغل گلگیر اطلس راست', 'زه جانبی بغل گلگیر اطلس راست با کد فنی DH32026615C مناسب اطلس', 10, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH32026615C', 'اطلس', 'سایپا', 'اطلس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3038, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم سایپا سیتروئن فارسی', 'آرم سایپا سیتروئن فارسی با کد فنی SVOTLO0000 مناسب سیتروئن', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SVOTLO0000', 'سیتروئن', 'سایپا', 'سیتروئن',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3039, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته سیتروئن لاتین', 'آرم نوشته سیتروئن لاتین با کد فنی CITROEN LATIN مناسب سیتروئن', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'CITROEN LATIN', 'سیتروئن', 'سایپا', 'سیتروئن',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3040, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته شاهین فارسی', 'آرم نوشته شاهین فارسی با کد فنی DN28999357A مناسب شاهین', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN28999357A', 'شاهین', 'سایپا', 'شاهین',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3041, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته شاهین لاتین', 'آرم نوشته شاهین لاتین با کد فنی DN28999358A مناسب شاهین', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN28999358A', 'شاهین', 'سایپا', 'شاهین',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3042, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته شاهین پلاس فارسی', 'آرم نوشته شاهین پلاس فارسی با کد فنی SN28799357 مناسب شاهین پلاس', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SN28799357', 'شاهین پلاس', 'سایپا', 'شاهین پلاس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3043, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو قالپاق SP100 شاهین', 'آرم لوگو قالپاق SP100 شاهین با کد فنی TN28040324A مناسب شاهین SP100', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'TN28040324A', 'شاهین SP100', 'سایپا', 'شاهین SP100',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3044, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو روی فرمان شاهین', 'آرم لوگو روی فرمان شاهین با کد فنی GHARBILAK مناسب شاهین', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'GHARBILAK', 'شاهین', 'سایپا', 'شاهین',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3045, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو صندوق عقب شاهین', 'آرم لوگو صندوق عقب شاهین با کد فنی DN28099337 مناسب شاهین', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN28099337', 'شاهین', 'سایپا', 'شاهین',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3046, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم CVT بغل گلگیر شاهین', 'آرم CVT بغل گلگیر شاهین با کد فنی DN28299356 مناسب شاهین', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN28299356', 'شاهین', 'سایپا', 'شاهین',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3047, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم شاهین AT', 'آرم شاهین AT با کد فنی DN28799356 مناسب شاهین AT', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN28799356', 'شاهین AT', 'سایپا', 'شاهین AT',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3048, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم فارسی عقب چانگان', 'آرم فارسی عقب چانگان با کد فنی SF553921018441P مناسب چانگان', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SF553921018441P', 'چانگان', 'سایپا', 'چانگان',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3049, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نام خودرو چانگان', 'آرم نام خودرو چانگان با کد فنی SF353921018421P مناسب چانگان', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SF353921018421P', 'چانگان', 'سایپا', 'چانگان',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3050, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوگوی رو ستونی چانگان', 'لوگوی رو ستونی چانگان با کد فنی S0990101058 مناسب چانگان', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'S0990101058', 'چانگان', 'سایپا', 'چانگان',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3051, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قالپاق چانگان', 'قالپاق چانگان با کد فنی SF553102020 مناسب چانگان', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SF553102020', 'چانگان', 'سایپا', 'چانگان',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3052, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوگو عقب چانگان', 'لوگو عقب چانگان با کد فنی S0990101047 مناسب چانگان', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'S0990101047', 'چانگان', 'سایپا', 'چانگان',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3053, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوگو جلو چانگان', 'لوگو جلو چانگان با کد فنی S0990101038 مناسب چانگان', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'S0990101038', 'چانگان', 'سایپا', 'چانگان',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3054, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوگو جلو و عقب چانگان سایپا', 'لوگو جلو و عقب چانگان سایپا با کد فنی S0990101048 مناسب چانگان', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'S0990101048', 'چانگان', 'سایپا', 'چانگان',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3055, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم سایپا طلاکوب قدیم', 'آرم سایپا طلاکوب قدیم با کد فنی SAIPA TALAKOB مناسب پراید, سایپا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SAIPA TALAKOB', 'پراید, سایپا', 'سایپا', 'پراید, سایپا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3056, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم صبا طلاکوب قدیم', 'آرم صبا طلاکوب قدیم با کد فنی SABA TALAKOB مناسب پراید صبا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SABA TALAKOB', 'پراید صبا', 'سایپا', 'پراید صبا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3057, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گارنیش قاب نمره عقب تیبا خام', 'گارنیش قاب نمره عقب تیبا خام با کد فنی DN03084711A مناسب تیبا', 10, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN03084711A', 'تیبا', 'سایپا', 'تیبا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3058, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'گارنیش قاب نمره عقب تیبا کرم', 'گارنیش قاب نمره عقب تیبا کرم با کد فنی DN03084712 مناسب تیبا', 10, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN03084712', 'تیبا', 'سایپا', 'تیبا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3059, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم اطلس فارسی', 'آرم اطلس فارسی با کد فنی DH32599357 مناسب اطلس', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH32599357', 'اطلس', 'سایپا', 'اطلس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3060, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم اطلس پلاس فارسی', 'آرم اطلس پلاس فارسی با کد فنی SH32799357 مناسب اطلس پلاس', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SH32799357', 'اطلس پلاس', 'سایپا', 'اطلس پلاس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3061, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو جلو پنجره اطلس (بزرگ)', 'آرم لوگو جلو پنجره اطلس (بزرگ) با کد فنی DH32099311D مناسب اطلس', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH32099311D', 'اطلس', 'سایپا', 'اطلس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3062, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو صندوق عقب اطلس (کوچک)', 'آرم لوگو صندوق عقب اطلس (کوچک) با کد فنی DH32099322A مناسب اطلس', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DH32099322A', 'اطلس', 'سایپا', 'اطلس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3063, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم سهند فارسی', 'آرم سهند فارسی با کد فنی DN32099358 مناسب سهند', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN32099358', 'سهند', 'سایپا', 'سهند',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3064, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو جلو پنجره سهند (بزرگ)', 'آرم لوگو جلو پنجره سهند (بزرگ) با کد فنی DN322099311A مناسب سهند', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN322099311A', 'سهند', 'سایپا', 'سهند',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3065, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو صندوق عقب سهند (کوچک)', 'آرم لوگو صندوق عقب سهند (کوچک) با کد فنی DN32099322 مناسب سهند', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN32099322', 'سهند', 'سایپا', 'سهند',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3066, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم CNG سهند', 'آرم CNG سهند با کد فنی DN32399358 مناسب سهند', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'DN32399358', 'سهند', 'سایپا', 'سهند',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3067, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار بست تاشو 013A', 'خار بست تاشو 013A با کد فنی MB09267013A مناسب سایپا', 10, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'MB09267013A', 'سایپا', 'سایپا', 'سایپا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3068, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار بست سیم گیر داخل 803', 'خار بست سیم گیر داخل 803 با کد فنی K992790803 مناسب سایپا', 10, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'K992790803', 'سایپا', 'سایپا', 'سایپا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3069, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار بست کمربندی زیپی بلند', 'خار بست کمربندی زیپی بلند با کد فنی K997093250 مناسب سایپا', 10, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'K997093250', 'سایپا', 'سایپا', 'سایپا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3070, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'خار بست کمربندی زیپی کوتاه خاردار', 'خار بست کمربندی زیپی کوتاه خاردار با کد فنی K992891053 مناسب سایپا', 10, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'K992891053', 'سایپا', 'سایپا', 'سایپا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3071, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم ARIO', 'آرم ARIO با کد فنی 3903018S01 مناسب آریو S300', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '3903018S01', 'آریو S300', 'سایپا', 'آریو S300',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3072, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قالپاق آریا', 'قالپاق آریا با کد فنی TN28140313A مناسب آریا', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'TN28140313A', 'آریا', 'سایپا', 'آریا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3073, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'زه صندوق عقب شاهین', 'زه صندوق عقب شاهین با کد فنی SHAHIN مناسب شاهین', 10, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', 'SHAHIN', 'شاهین', 'سایپا', 'شاهین',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3074, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لگو سیتروئن ^', 'لگو سیتروئن ^ با کد فنی 97H98321883VD مناسب سیتروئن C3', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '97H98321883VD', 'سیتروئن C3', 'سایپا', 'سیتروئن C3',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3075, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم C3-XR', 'آرم C3-XR با کد فنی 97H98321884VD مناسب سیتروئن C3-XR', 12, '',
    ARRAY['آرم', 'سایپا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سایپا', '97H98321884VD', 'سیتروئن C3-XR', 'سایپا', 'سیتروئن C3-XR',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3076, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته پارس صندوق پژو پارس', 'آرم نوشته پارس صندوق پژو پارس با کد فنی 9420213466 مناسب پژو پارس', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '9420213466', 'پژو پارس', 'ایران خودرو', 'پژو پارس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3077, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته پژو صندوق پژو پارس', 'آرم نوشته پژو صندوق پژو پارس با کد فنی 9420213463 مناسب پژو پارس', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '9420213463', 'پژو پارس', 'ایران خودرو', 'پژو پارس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3078, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم شیر درب صندوق عقب پژو پارس', 'آرم شیر درب صندوق عقب پژو پارس با کد فنی 9420213457 مناسب پژو پارس', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '9420213457', 'پژو پارس', 'ایران خودرو', 'پژو پارس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3079, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم شیر درب صندوق عقب پژو ۲۰۶', 'آرم شیر درب صندوق عقب پژو ۲۰۶ با کد فنی 9648299780 مناسب پژو ۲۰۶', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '9648299780', 'پژو ۲۰۶', 'ایران خودرو', 'پژو ۲۰۶',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3080, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته پژو پیوسته', 'آرم نوشته پژو پیوسته با کد فنی 96341591VD مناسب پژو ۲۰۶, ۴۰۵, پارس', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '96341591VD', 'پژو ۲۰۶, ۴۰۵, پارس', 'ایران خودرو', 'پژو ۲۰۶, ۴۰۵, پارس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3081, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته عددی ۲۰۶', 'آرم نوشته عددی ۲۰۶ با کد فنی 96341592VD مناسب پژو ۲۰۶', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '96341592VD', 'پژو ۲۰۶', 'ایران خودرو', 'پژو ۲۰۶',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3082, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم پژو پیوسته طلاکوب', 'آرم پژو پیوسته طلاکوب با کد فنی 9250658680 مناسب پژو', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '9250658680', 'پژو', 'ایران خودرو', 'پژو',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3083, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته ۴۰۵ پیوسته طلاکوب', 'آرم نوشته ۴۰۵ پیوسته طلاکوب با کد فنی 9601438080 مناسب پژو ۴۰۵', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '9601438080', 'پژو ۴۰۵', 'ایران خودرو', 'پژو ۴۰۵',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3084, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته GLX پیوسته طلاکوب', 'آرم نوشته GLX پیوسته طلاکوب با کد فنی 9601163180 مناسب پژو ۴۰۵ GLX', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '9601163180', 'پژو ۴۰۵ GLX', 'ایران خودرو', 'پژو ۴۰۵ GLX',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3085, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته رانا لاتین', 'آرم نوشته رانا لاتین با کد فنی IK00032380 مناسب رانا', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK00032380', 'رانا', 'ایران خودرو', 'رانا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3086, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته رانا فارسی', 'آرم نوشته رانا فارسی با کد فنی YG22215935 مناسب رانا', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG22215935', 'رانا', 'ایران خودرو', 'رانا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3087, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته رانا پلاس فارسی', 'آرم نوشته رانا پلاس فارسی با کد فنی YG22215939 مناسب رانا پلاس', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG22215939', 'رانا پلاس', 'ایران خودرو', 'رانا پلاس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3088, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم 6AMT رانا', 'آرم 6AMT رانا با کد فنی IK01786080 مناسب رانا 6AMT', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK01786080', 'رانا 6AMT', 'ایران خودرو', 'رانا 6AMT',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3089, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم کله اسب صندوق عقب رانا', 'آرم کله اسب صندوق عقب رانا با کد فنی IK00032480 مناسب رانا', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK00032480', 'رانا', 'ایران خودرو', 'رانا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3090, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته دنا لاتین', 'آرم نوشته دنا لاتین با کد فنی IK00306780 مناسب دنا', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK00306780', 'دنا', 'ایران خودرو', 'دنا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3091, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته دنا فارسی', 'آرم نوشته دنا فارسی با کد فنی YG22215934 مناسب دنا', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG22215934', 'دنا', 'ایران خودرو', 'دنا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3092, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته دنا پلاس لاتین', 'آرم نوشته دنا پلاس لاتین با کد فنی IK008013780 مناسب دنا پلاس', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK008013780', 'دنا پلاس', 'ایران خودرو', 'دنا پلاس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3093, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته دنا پلاس فارسی', 'آرم نوشته دنا پلاس فارسی با کد فنی YG20224804 مناسب دنا پلاس', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG20224804', 'دنا پلاس', 'ایران خودرو', 'دنا پلاس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3094, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم کله اسب صندوق عقب دنا', 'آرم کله اسب صندوق عقب دنا با کد فنی IK00183580 مناسب دنا, دنا پلاس', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK00183580', 'دنا, دنا پلاس', 'ایران خودرو', 'دنا, دنا پلاس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3095, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته تارا لاتین', 'آرم نوشته تارا لاتین با کد فنی IK01578380 مناسب تارا', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK01578380', 'تارا', 'ایران خودرو', 'تارا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3096, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته تارا فارسی', 'آرم نوشته تارا فارسی با کد فنی IK01382680 مناسب تارا', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK01382680', 'تارا', 'ایران خودرو', 'تارا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3097, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم کله اسب جلو پنجره تارا', 'آرم کله اسب جلو پنجره تارا با کد فنی IK01380680 مناسب تارا', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK01380680', 'تارا', 'ایران خودرو', 'تارا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3098, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم کله اسب صندوق عقب تارا', 'آرم کله اسب صندوق عقب تارا با کد فنی IK01422580 مناسب تارا', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK01422580', 'تارا', 'ایران خودرو', 'تارا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3099, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته آریسان لاتین', 'آرم نوشته آریسان لاتین با کد فنی 72345191 مناسب آریسان', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '72345191', 'آریسان', 'ایران خودرو', 'آریسان',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3100, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته آریسان فارسی', 'آرم نوشته آریسان فارسی با کد فنی YG22215938 مناسب آریسان', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG22215938', 'آریسان', 'ایران خودرو', 'آریسان',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3101, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته آریسان ۲ فارسی', 'آرم نوشته آریسان ۲ فارسی با کد فنی YG20212907 مناسب آریسان ۲', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG20212907', 'آریسان ۲', 'ایران خودرو', 'آریسان ۲',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3102, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم کله اسب صندوق عقب آریسان', 'آرم کله اسب صندوق عقب آریسان با کد فنی 72351186 مناسب آریسان', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '72351186', 'آریسان', 'ایران خودرو', 'آریسان',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3103, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم 6AT دو رنگ پژو ۲۰۷ - دنا', 'آرم 6AT دو رنگ پژو ۲۰۷ - دنا با کد فنی IK01345780 مناسب پژو ۲۰۷, دنا', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK01345780', 'پژو ۲۰۷, دنا', 'ایران خودرو', 'پژو ۲۰۷, دنا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3104, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم 6AT معمولی پژو ۲۰۷', 'آرم 6AT معمولی پژو ۲۰۷ با کد فنی IK01444880 مناسب پژو ۲۰۷', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK01444880', 'پژو ۲۰۷', 'ایران خودرو', 'پژو ۲۰۷',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3105, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم 207 mc', 'آرم 207 mc با کد فنی IK01630080 مناسب پژو ۲۰۷ MC', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK01630080', 'پژو ۲۰۷ MC', 'ایران خودرو', 'پژو ۲۰۷ MC',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3106, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته توربو ۱.۷ لاتین', 'آرم نوشته توربو ۱.۷ لاتین با کد فنی IK00647680 مناسب دنا پلاس توربو, سورن توربو', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK00647680', 'دنا پلاس توربو, سورن توربو', 'ایران خودرو', 'دنا پلاس توربو, سورن توربو',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3107, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم توربو بدون ۱.۷', 'آرم توربو بدون ۱.۷ با کد فنی T1.7 مناسب دنا, سورن توربو', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'T1.7', 'دنا, سورن توربو', 'ایران خودرو', 'دنا, سورن توربو',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3108, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته توربو فارسی', 'آرم نوشته توربو فارسی با کد فنی YG20224803 مناسب دنا, سورن توربو', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG20224803', 'دنا, سورن توربو', 'ایران خودرو', 'دنا, سورن توربو',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3109, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته سمند لاتین', 'آرم نوشته سمند لاتین با کد فنی 7901201 مناسب سمند', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '7901201', 'سمند', 'ایران خودرو', 'سمند',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3110, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته سمند فارسی', 'آرم نوشته سمند فارسی با کد فنی YG22215932 مناسب سمند', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG22215932', 'سمند', 'ایران خودرو', 'سمند',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3111, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته سورن پلاس فارسی', 'آرم نوشته سورن پلاس فارسی با کد فنی IK01417080 مناسب سورن پلاس', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'IK01417080', 'سورن پلاس', 'ایران خودرو', 'سورن پلاس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3112, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته سورن فارسی', 'آرم نوشته سورن فارسی با کد فنی YG22215936 مناسب سورن', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG22215936', 'سورن', 'ایران خودرو', 'سورن',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3113, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته IKCO', 'آرم نوشته IKCO با کد فنی 7901251 مناسب کلیه محصولات ایران خودرو', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '7901251', 'کلیه محصولات ایران خودرو', 'ایران خودرو', 'کلیه محصولات ایران خودرو',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3114, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم کله اسب روی فرمان سمند', 'آرم کله اسب روی فرمان سمند با کد فنی KALEASB مناسب سمند, سورن', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'KALEASB', 'سمند, سورن', 'ایران خودرو', 'سمند, سورن',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3115, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم LX سمند بغل گلگیر', 'آرم LX سمند بغل گلگیر با کد فنی YG20212147 مناسب سمند LX', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG20212147', 'سمند LX', 'ایران خودرو', 'سمند LX',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3116, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم ۱.۸ بزرگ پژو بغل گلگیر', 'آرم ۱.۸ بزرگ پژو بغل گلگیر با کد فنی YG20281011 مناسب پژو ۴۰۵, پارس', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG20281011', 'پژو ۴۰۵, پارس', 'ایران خودرو', 'پژو ۴۰۵, پارس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3117, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم 1.6i بزرگ بغل گلگیر', 'آرم 1.6i بزرگ بغل گلگیر با کد فنی 7901141 مناسب پژو ۲۰۶', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '7901141', 'پژو ۲۰۶', 'ایران خودرو', 'پژو ۲۰۶',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3118, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم ۱.۶ پژو ۲۰۶', 'آرم ۱.۶ پژو ۲۰۶ با کد فنی 1.6 مناسب پژو ۲۰۶', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '1.6', 'پژو ۲۰۶', 'ایران خودرو', 'پژو ۲۰۶',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3119, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم ۲.۰ پژو', 'آرم ۲.۰ پژو با کد فنی YG20249938 مناسب پژو ۲۰۶, ۴۰۵', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG20249938', 'پژو ۲۰۶, ۴۰۵', 'ایران خودرو', 'پژو ۲۰۶, ۴۰۵',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3120, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم LX1.6', 'آرم LX1.6 با کد فنی YG00033777 مناسب پژو ۲۰۶', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG00033777', 'پژو ۲۰۶', 'ایران خودرو', 'پژو ۲۰۶',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3121, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم 2.7i پژو', 'آرم 2.7i پژو با کد فنی YG20216057 مناسب پژو', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'YG20216057', 'پژو', 'ایران خودرو', 'پژو',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3122, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم پلاس تکی +', 'آرم پلاس تکی + با کد فنی PELAS مناسب دنا پلاس, سورن پلاس, رانا پلاس', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', 'PELAS', 'دنا پلاس, سورن پلاس, رانا پلاس', 'ایران خودرو', 'دنا پلاس, سورن پلاس, رانا پلاس',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3123, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم 206A', 'آرم 206A با کد فنی 206A مناسب پژو ۲۰۶', 12, '',
    ARRAY['آرم', 'ایران خودرو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'ایران خودرو', '206A', 'پژو ۲۰۶', 'ایران خودرو', 'پژو ۲۰۶',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3124, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو جلو پنجره دانگ فنگ', 'آرم لوگو جلو پنجره دانگ فنگ با کد فنی R540015J-B مناسب H30 Cross, دانگ فنگ', 12, '',
    ARRAY['آرم', 'دانگ فنگ', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'دانگ فنگ', 'R540015J-B', 'H30 Cross, دانگ فنگ', 'چینی', 'H30 Cross, دانگ فنگ',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3125, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو صندوق عقب دانگ فنگ', 'آرم لوگو صندوق عقب دانگ فنگ با کد فنی R540020-G مناسب H30 Cross, دانگ فنگ', 12, '',
    ARRAY['آرم', 'دانگ فنگ', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'دانگ فنگ', 'R540020-G', 'H30 Cross, دانگ فنگ', 'چینی', 'H30 Cross, دانگ فنگ',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3126, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو DFM عقب چپ دانگ فنگ', 'آرم لوگو DFM عقب چپ دانگ فنگ با کد فنی DFM مناسب H30 Cross, دانگ فنگ', 12, '',
    ARRAY['آرم', 'دانگ فنگ', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'دانگ فنگ', 'DFM', 'H30 Cross, دانگ فنگ', 'چینی', 'H30 Cross, دانگ فنگ',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3127, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو H30 عقب راست دانگ فنگ', 'آرم لوگو H30 عقب راست دانگ فنگ با کد فنی YG22215930 مناسب H30 Cross', 12, '',
    ARRAY['آرم', 'دانگ فنگ', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'دانگ فنگ', 'YG22215930', 'H30 Cross', 'چینی', 'H30 Cross',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3128, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو صندوق عقب هایما', 'آرم لوگو صندوق عقب هایما با کد فنی SA11-51-740 مناسب هایما S7, S5', 12, '',
    ARRAY['آرم', 'هایما', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'هایما', 'SA11-51-740', 'هایما S7, S5', 'چینی', 'هایما S7, S5',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3129, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم S7 هایما', 'آرم S7 هایما با کد فنی SA11-51-724 مناسب هایما S7', 12, '',
    ARRAY['آرم', 'هایما', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'هایما', 'SA11-51-724', 'هایما S7', 'چینی', 'هایما S7',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3130, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم 1.8T هایما', 'آرم 1.8T هایما با کد فنی EA2151750A مناسب هایما S7 توربو', 12, '',
    ARRAY['آرم', 'هایما', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'هایما', 'EA2151750A', 'هایما S7 توربو', 'چینی', 'هایما S7 توربو',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3131, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم S.5 هایما', 'آرم S.5 هایما با کد فنی SA12-51-724 مناسب هایما S5', 12, '',
    ARRAY['آرم', 'هایما', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'هایما', 'SA12-51-724', 'هایما S5', 'چینی', 'هایما S5',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3132, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو جلو پنجره جک S3 (بزرگ)', 'آرم لوگو جلو پنجره جک S3 (بزرگ) با کد فنی 3904120V9010 مناسب جک S3', 12, '',
    ARRAY['آرم', 'جک', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'جک', '3904120V9010', 'جک S3', 'چینی', 'جک S3',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3133, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو جلو پنجره جک S5 (متوسط)', 'آرم لوگو جلو پنجره جک S5 (متوسط) با کد فنی 3904410U1510 مناسب جک S5', 12, '',
    ARRAY['آرم', 'جک', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'جک', '3904410U1510', 'جک S5', 'چینی', 'جک S5',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3134, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو صندوق عقب جک S3-S5 (کوچک)', 'آرم لوگو صندوق عقب جک S3-S5 (کوچک) با کد فنی 3904610U1510 مناسب جک S3, جک S5', 12, '',
    ARRAY['آرم', 'جک', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'جک', '3904610U1510', 'جک S3, جک S5', 'چینی', 'جک S3, جک S5',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3135, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'نوشته S5 جک آبی', 'نوشته S5 جک آبی با کد فنی 3904310U156J مناسب جک S5', 12, '',
    ARRAY['آرم', 'جک', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'جک', '3904310U156J', 'جک S5', 'چینی', 'جک S5',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3136, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'نوشته S5 جک قرمز', 'نوشته S5 جک قرمز با کد فنی 3904310U156 مناسب جک S5', 12, '',
    ARRAY['آرم', 'جک', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'جک', '3904310U156', 'جک S5', 'چینی', 'جک S5',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3137, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'نوشته S3 جک', 'نوشته S3 جک با کد فنی 3904110U221E مناسب جک S3', 12, '',
    ARRAY['آرم', 'جک', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'جک', '3904110U221E', 'جک S3', 'چینی', 'جک S3',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3138, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم J4 جک', 'آرم J4 جک با کد فنی 3904170U8516 مناسب جک J4', 12, '',
    ARRAY['آرم', 'جک', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'جک', '3904170U8516', 'جک J4', 'چینی', 'جک J4',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3139, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'مجموعه لوگو جک کاور موتور 1.5VVT', 'مجموعه لوگو جک کاور موتور 1.5VVT با کد فنی 2802230U8510 مناسب جک J4, S3', 12, '',
    ARRAY['آرم', 'جک', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'جک', '2802230U8510', 'جک J4, S3', 'چینی', 'جک J4, S3',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3140, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوگو روی درب موتور جک J4, S3, S5', 'لوگو روی درب موتور جک J4, S3, S5 با کد فنی 2802240U8510 مناسب جک J4, S3, S5', 12, '',
    ARRAY['آرم', 'جک', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'جک', '2802240U8510', 'جک J4, S3, S5', 'چینی', 'جک J4, S3, S5',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3141, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو وسط قالپاق برلیانس', 'آرم لوگو وسط قالپاق برلیانس با کد فنی 4039007S01 مناسب برلیانس H330, H320, H230', 12, '',
    ARRAY['آرم', 'برلیانس', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'برلیانس', '4039007S01', 'برلیانس H330, H320, H230', 'چینی', 'برلیانس H330, H320, H230',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3142, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم لوگو وسط قالپاق آریو S300', 'آرم لوگو وسط قالپاق آریو S300 با کد فنی 3102120S01 مناسب آریو S300', 12, '',
    ARRAY['آرم', 'آریو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'آریو', '3102120S01', 'آریو S300', 'چینی', 'آریو S300',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3143, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم پارس تندر L90', 'آرم پارس تندر L90 با کد فنی PLSRM00056 مناسب تندر ۹۰, پارس تندر', 12, '',
    ARRAY['آرم', 'رنو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'رنو', 'PLSRM00056', 'تندر ۹۰, پارس تندر', 'ایران خودرو', 'تندر ۹۰, پارس تندر',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3144, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم سایپا رنالت L90', 'آرم سایپا رنالت L90 با کد فنی PLSRM00055 مناسب تندر ۹۰ سایپا', 12, '',
    ARRAY['آرم', 'رنو', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'رنو', 'PLSRM00055', 'تندر ۹۰ سایپا', 'سایپا', 'تندر ۹۰ سایپا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3145, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته درب صندوق عقب لاماری', 'آرم نوشته درب صندوق عقب لاماری با کد فنی A-8111011 مناسب لاماری ایما', 12, '',
    ARRAY['آرم', 'لاماری', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'لاماری', 'A-8111011', 'لاماری ایما', 'چینی', 'لاماری ایما',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3146, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته لاماری جدید', 'آرم نوشته لاماری جدید با کد فنی AL-8111011-B مناسب لاماری ایما', 12, '',
    ARRAY['آرم', 'لاماری', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'لاماری', 'AL-8111011-B', 'لاماری ایما', 'چینی', 'لاماری ایما',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3147, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم درپوش وسط قالپاق لاماری', 'آرم درپوش وسط قالپاق لاماری با کد فنی A-3102010 مناسب لاماری ایما', 12, '',
    ARRAY['آرم', 'لاماری', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'لاماری', 'A-3102010', 'لاماری ایما', 'چینی', 'لاماری ایما',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3148, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم جلو کاپوت لاماری', 'آرم جلو کاپوت لاماری با کد فنی A-8111010 مناسب لاماری ایما', 12, '',
    ARRAY['آرم', 'لاماری', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'لاماری', 'A-8111010', 'لاماری ایما', 'چینی', 'لاماری ایما',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3149, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم EAMA لاماری', 'آرم EAMA لاماری با کد فنی A-8111012 مناسب لاماری ایما', 12, '',
    ARRAY['آرم', 'لاماری', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'لاماری', 'A-8111012', 'لاماری ایما', 'چینی', 'لاماری ایما',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3150, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم GDi لاماری', 'آرم GDi لاماری با کد فنی A-8111014 مناسب لاماری ایما', 12, '',
    ARRAY['آرم', 'لاماری', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'لاماری', 'A-8111014', 'لاماری ایما', 'چینی', 'لاماری ایما',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3151, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم 1.5T لاماری', 'آرم 1.5T لاماری با کد فنی A-8111013 مناسب لاماری ایما', 12, '',
    ARRAY['آرم', 'لاماری', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'لاماری', 'A-8111013', 'لاماری ایما', 'چینی', 'لاماری ایما',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3152, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'نوشته سوبا', 'نوشته سوبا با کد فنی M4-3921616 مناسب سوبا M4', 12, '',
    ARRAY['آرم', 'فردا موتور', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'فردا موتور', 'M4-3921616', 'سوبا M4', 'چینی', 'سوبا M4',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3153, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم M4GDI سوبا', 'آرم M4GDI سوبا با کد فنی M4-3921615 مناسب سوبا M4', 12, '',
    ARRAY['آرم', 'فردا موتور', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'فردا موتور', 'M4-3921615', 'سوبا M4', 'چینی', 'سوبا M4',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3154, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم FMC فردا موتور', 'آرم FMC فردا موتور با کد فنی M4-T-BL-01 مناسب FMC T5, SX5, 511', 12, '',
    ARRAY['آرم', 'فردا موتور', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'فردا موتور', 'M4-T-BL-01', 'FMC T5, SX5, 511', 'چینی', 'FMC T5, SX5, 511',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3155, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم آرتا دیزل', 'آرم آرتا دیزل با کد فنی AA-66712022XX01 مناسب آرتا دیزل', 12, '',
    ARRAY['آرم', 'آرتا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'آرتا', 'AA-66712022XX01', 'آرتا دیزل', 'چینی', 'آرتا دیزل',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3156, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم آرتا ۶', 'آرم آرتا ۶ با کد فنی AA-66712022XX02 مناسب آرتا دیزل ۶', 12, '',
    ARRAY['آرم', 'آرتا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'آرتا', 'AA-66712022XX02', 'آرتا دیزل ۶', 'چینی', 'آرتا دیزل ۶',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3157, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم آرتا ۸', 'آرم آرتا ۸ با کد فنی AA-66712022XX03 مناسب آرتا دیزل ۸', 12, '',
    ARRAY['آرم', 'آرتا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'آرتا', 'AA-66712022XX03', 'آرتا دیزل ۸', 'چینی', 'آرتا دیزل ۸',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3158, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوگو سه حلقه جلو توکا', 'لوگو سه حلقه جلو توکا با کد فنی AK-11712022XX01 مناسب توکا AX8', 12, '',
    ARRAY['آرم', 'توکا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'توکا', 'AK-11712022XX01', 'توکا AX8', 'چینی', 'توکا AX8',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3159, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوگو سه حلقه عقب توکا', 'لوگو سه حلقه عقب توکا با کد فنی AK-11712022XX02 مناسب توکا AX8', 12, '',
    ARRAY['آرم', 'توکا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'توکا', 'AK-11712022XX02', 'توکا AX8', 'چینی', 'توکا AX8',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3160, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم نوشته AMG توکا', 'آرم نوشته AMG توکا با کد فنی AK-11712022XX03 مناسب توکا', 12, '',
    ARRAY['آرم', 'توکا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'توکا', 'AK-11712022XX03', 'توکا', 'چینی', 'توکا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3161, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لگو TOOCA AX8', 'لگو TOOCA AX8 با کد فنی AK-11712022XX04 مناسب توکا AX8', 12, '',
    ARRAY['آرم', 'توکا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'توکا', 'AK-11712022XX04', 'توکا AX8', 'چینی', 'توکا AX8',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3162, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'قالپاق رینگ AMG توکا', 'قالپاق رینگ AMG توکا با کد فنی AK-11712022XX05 مناسب توکا', 12, '',
    ARRAY['آرم', 'توکا', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'توکا', 'AK-11712022XX05', 'توکا', 'چینی', 'توکا',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3163, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوگو جلو SAM', 'لوگو جلو SAM با کد فنی SAM-T-FL-01 مناسب سام', 12, '',
    ARRAY['آرم', 'سام', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سام', 'SAM-T-FL-01', 'سام', 'چینی', 'سام',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3164, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'لوگو عقب SAM', 'لوگو عقب SAM با کد فنی SAM-T-RL-01 مناسب سام', 12, '',
    ARRAY['آرم', 'سام', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'سام', 'SAM-T-RL-01', 'سام', 'چینی', 'سام',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3165, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'آرم CF5', 'آرم CF5 با کد فنی CF5-T-BL-02 مناسب CF5', 12, '',
    ARRAY['آرم', 'چینی', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'چینی', 'CF5-T-BL-02', 'CF5', 'چینی', 'CF5',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3166, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    'درپوش رینگ CF5', 'درپوش رینگ CF5 با کد فنی CF5-RING مناسب CF5', 12, '',
    ARRAY['آرم', 'چینی', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'چینی', 'CF5-RING', 'CF5', 'چینی', 'CF5',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', 3167, false, true,
    NOW(), NOW()
);
