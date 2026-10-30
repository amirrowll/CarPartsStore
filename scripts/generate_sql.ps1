$json = Get-Content "scripts\local_products.json" -Raw | ConvertFrom-Json

$sql = @"
-- ============================================================
-- PINPARTS DATABASE SEED SCRIPT FOR VPS (pinpartsdb)
-- ============================================================

-- 1. Ensure Categories Exist with non-null ImageUrl
INSERT INTO "Categories" ("Id", "Name", "Description", "ImageUrl", "DisplayOrder", "IsActive", "CreatedAt")
VALUES 
    (1, 'خارجات', 'انواع خار و پین‌های اتومبیل', '/uploads/products/pinpart-1001.jpg', 1, true, NOW()),
    (10, 'خارجات', 'انواع خار و پین‌های اتومبیل', '/uploads/products/pinpart-1001.jpg', 1, true, NOW()),
    (11, 'پیچ و مهره', 'پیچ و مهره و اتصالات خودرویی', '/uploads/products/pinpart-1013.jpg', 2, true, NOW()),
    (12, 'آرم و علائم', 'آرم و نشان‌های بدنه خودرو', '/uploads/products/pinpart-1001.jpg', 3, true, NOW()),
    (13, 'سوکت و اتصالات برقی', 'انواع کانکتور و سوکت برق', '/uploads/products/pinpart-1033.jpg', 4, true, NOW())
ON CONFLICT ("Id") DO UPDATE SET 
    "Name" = EXCLUDED."Name",
    "Description" = EXCLUDED."Description",
    "ImageUrl" = EXCLUDED."ImageUrl",
    "IsActive" = true;

-- Ensure Category sequence is updated
SELECT setval(pg_get_serial_sequence('"Categories"', 'Id'), GREATEST(COALESCE(MAX("Id"), 1), 20)) FROM "Categories";

-- 2. Clear previous invalid test rows in Category 10
DELETE FROM "Products" WHERE "CategoryId" IN (1, 10);

-- 3. Insert All 42 Authentic Products with Full Array Columns & CarBrand
"@

$sb = [System.Text.StringBuilder]::new()
$sb.AppendLine($sql) | Out-Null

foreach ($p in $json.products) {
    $name = ($p.name -replace "'", "''")
    $desc = ""
    $catId = if ($p.categoryId) { $p.categoryId } else { 10 }
    $img = $p.imageUrl
    $brand = ($p.brand -replace "'", "''")
    $partNo = ($p.partNumber -replace "'", "''")
    $cars = ($p.compatibleCars -replace "'", "''")
    $carBrand = if ($p.carBrand) { $p.carBrand } else { "IranKhodro" }
    $mat = ""
    $war = ($p.warranty -replace "'", "''")
    $order = if ($p.displayOrder) { $p.displayOrder } else { 0 }
    $featured = if ($p.isFeatured) { "true" } else { "false" }

    $stmt = @"
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    '$name', '$desc', $catId, '$img',
    ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[], ARRAY[]::text[], ARRAY[]::text[],
    '$brand', '$partNo', '$cars', '$carBrand', '$cars',
    '$mat', '$war', $order, $featured, true,
    NOW(), NOW()
);
"@
    $sb.AppendLine($stmt) | Out-Null
}

$sb.AppendLine(@"
-- 4. Verify count
SELECT COUNT(*) AS total_categories FROM "Categories";
SELECT COUNT(*) AS total_products FROM "Products" WHERE "IsActive" = true;
"@) | Out-Null

[System.IO.File]::WriteAllText("c:\Users\Amirhossein\OneDrive\Desktop\CarPartsStoreNew\scripts\seed_products_vps.sql", $sb.ToString(), [System.Text.Encoding]::UTF8)
Write-Host "Generated seed_products_vps.sql with Category ImageUrl and arrays!"
