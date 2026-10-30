const fs = require('fs');

const catalogItems = JSON.parse(fs.readFileSync('scripts/full_catalog_items.json', 'utf-8'));
const emblemItems = JSON.parse(fs.readFileSync('scripts/parsed_emblems.json', 'utf-8'));

let sql = `-- ============================================================
-- PINPARTS FINAL DATABASE SEED SCRIPT (UTF-8 Without BOM)
-- Categories: 10 (خارجات), 11 (پیچ و مهره), 12 (آرم و علائم)
-- NO Sockets, NO Duplicate Categories, NO Prices (Inquiry Only)
-- Total Catalog Products: ${catalogItems.length}
-- Total Emblems: ${emblemItems.length}
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

`;

// Insert Catalog Items
sql += `-- ============================================================\n`;
sql += `-- 3. Insert ${catalogItems.length} Authentic Catalog Products\n`;
sql += `-- ============================================================\n\n`;

for (const item of catalogItems) {
  const name = item.name.replace(/'/g, "''");
  const brand = item.brand.replace(/'/g, "''");
  const partNo = String(item.id);
  const cars = item.cars.replace(/'/g, "''");
  const carBrand = item.carBrand;
  const catId = item.cat;
  const img = item.imageUrl;

  sql += `INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    '${name}', '${name} فابریک با کیفیت درجه یک بازار چراغ برق تهران', ${catId}, '${img}',
    ARRAY['${item.cat === 10 ? 'خار' : item.cat === 11 ? 'پیچ و مهره' : 'آرم'}', '${brand}', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    '${brand}', '${partNo}', '${cars}', '${carBrand}', '${cars}',
    'استاندارد شرکتی', 'ضمانت اصالت و سلامت فیزیکی پین‌پارت', ${item.id}, false, true,
    NOW(), NOW()
);\n`;
}

// Insert Emblem Items
sql += `\n-- ============================================================\n`;
sql += `-- 4. Insert ${emblemItems.length} Emblem Products from Price Lists\n`;
sql += `-- ============================================================\n\n`;

for (let i = 0; i < emblemItems.length; i++) {
  const item = emblemItems[i];
  const name = item.name.replace(/'/g, "''");
  const brand = item.brand.replace(/'/g, "''");
  const partNo = (item.partNumber || '').replace(/'/g, "''");
  const cars = (item.compatibleCars || '').replace(/'/g, "''");
  const carBrand = item.carBrand;
  const catId = item.categoryId || 12;
  const order = 3000 + i;

  sql += `INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl",
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel",
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive",
    "CreatedAt", "UpdatedAt"
) VALUES (
    '${name}', '${name} با کد فنی ${partNo} مناسب ${cars}', ${catId}, '',
    ARRAY['آرم', '${brand}', 'علائم']::text[], ARRAY[]::text[], ARRAY[]::text[],
    '${brand}', '${partNo}', '${cars}', '${carBrand}', '${cars}',
    'فابریک شرکتی', 'ضمانت اصالت و کیفیت پین‌پارت', ${order}, false, true,
    NOW(), NOW()
);\n`;
}

fs.writeFileSync('scripts/seed_final_utf8.sql', sql, 'utf-8');
console.log(`Generated SQL script: ${catalogItems.length + emblemItems.length} products total!`);
