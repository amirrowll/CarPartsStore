import subprocess

sql = """
SET client_encoding = 'UTF8';

-- 1. Remove duplicate category 1
UPDATE "Products" SET "CategoryId" = 10 WHERE "CategoryId" = 1;
DELETE FROM "Categories" WHERE "Id" = 1;

-- 2. Update clean Persian names and descriptions
UPDATE "Categories" SET 
    "Name" = 'خارجات', 
    "Description" = 'انواع خار، بست و پین‌های پلیمری و فلزی خودرو',
    "IsActive" = true,
    "DisplayOrder" = 1
WHERE "Id" = 10;

UPDATE "Categories" SET 
    "Name" = 'پیچ و مهره', 
    "Description" = 'پیچ، مهره، خار مهره و واشرجات استاندارد خودرویی',
    "IsActive" = true,
    "DisplayOrder" = 2
WHERE "Id" = 11;

UPDATE "Categories" SET 
    "Name" = 'آرم و علائم', 
    "Description" = 'انواع آرم، نوشته و علائم فابریک بدنه خودرو',
    "IsActive" = true,
    "DisplayOrder" = 3
WHERE "Id" = 12;

UPDATE "Categories" SET 
    "Name" = 'سوکت و اتصالات برقی', 
    "Description" = 'انواع سوکت، کانکتور و فیش سیم‌کشی خودرو',
    "IsActive" = true,
    "DisplayOrder" = 4
WHERE "Id" = 13;

-- 3. Clear Description and Material from all products
UPDATE "Products" SET "Description" = '', "Material" = '';

-- 4. Verify
SELECT "Id", "Name", "Description", "IsActive" FROM "Categories" ORDER BY "DisplayOrder";
SELECT "Id", "Name", "PartNumber", "Description", "Material" FROM "Products" LIMIT 5;
"""

with open('/tmp/clean_categories.sql', 'w', encoding='utf-8') as f:
    f.write(sql)

cmd = "PGPASSWORD='Pinpart@DB2026!' psql -h localhost -U pinparts_user -d pinpartsdb -f /tmp/clean_categories.sql"
res = subprocess.run(cmd, shell=True, capture_output=True, text=True)
print("=== SQL EXECUTION RESULT ===")
print("STDOUT:\n", res.stdout)
print("STDERR:\n", res.stderr)
