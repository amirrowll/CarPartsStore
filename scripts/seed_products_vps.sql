-- ============================================================
-- PINPARTS DATABASE SEED SCRIPT FOR VPS (pinpartsdb)
-- ============================================================

-- 1. Ensure Categories Exist with non-null ImageUrl
INSERT INTO "Categories" ("Id", "Name", "Description", "ImageUrl", "DisplayOrder", "IsActive", "CreatedAt")
VALUES 
    (1, 'Ø®Ø§Ø±Ø¬Ø§Øª', 'Ø§Ù†ÙˆØ§Ø¹ Ø®Ø§Ø± Ùˆ Ù¾ÛŒÙ†â€ŒÙ‡Ø§ÛŒ Ø§ØªÙˆÙ…Ø¨ÛŒÙ„', '/uploads/products/pinpart-1001.jpg', 1, true, NOW()),
    (10, 'Ø®Ø§Ø±Ø¬Ø§Øª', 'Ø§Ù†ÙˆØ§Ø¹ Ø®Ø§Ø± Ùˆ Ù¾ÛŒÙ†â€ŒÙ‡Ø§ÛŒ Ø§ØªÙˆÙ…Ø¨ÛŒÙ„', '/uploads/products/pinpart-1001.jpg', 1, true, NOW()),
    (11, 'Ù¾ÛŒÚ† Ùˆ Ù…Ù‡Ø±Ù‡', 'Ù¾ÛŒÚ† Ùˆ Ù…Ù‡Ø±Ù‡ Ùˆ Ø§ØªØµØ§Ù„Ø§Øª Ø®ÙˆØ¯Ø±ÙˆÛŒÛŒ', '/uploads/products/pinpart-1013.jpg', 2, true, NOW()),
    (12, 'Ø¢Ø±Ù… Ùˆ Ø¹Ù„Ø§Ø¦Ù…', 'Ø¢Ø±Ù… Ùˆ Ù†Ø´Ø§Ù†â€ŒÙ‡Ø§ÛŒ Ø¨Ø¯Ù†Ù‡ Ø®ÙˆØ¯Ø±Ùˆ', '/uploads/products/pinpart-1001.jpg', 3, true, NOW()),
    (13, 'Ø³ÙˆÚ©Øª Ùˆ Ø§ØªØµØ§Ù„Ø§Øª Ø¨Ø±Ù‚ÛŒ', 'Ø§Ù†ÙˆØ§Ø¹ Ú©Ø§Ù†Ú©ØªÙˆØ± Ùˆ Ø³ÙˆÚ©Øª Ø¨Ø±Ù‚', '/uploads/products/pinpart-1033.jpg', 4, true, NOW())
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
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار سقف و ستون E3', '', 10, '/uploads/products/pinpart-1042.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1042', 'پژو 405، سمند، پژو پارس', 'IranKhodro', 'پژو 405، سمند، پژو پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1042, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار سقف و ستون E2', '', 10, '/uploads/products/pinpart-1041.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1041', 'پژو 405، سمند، پارس، 206', 'IranKhodro', 'پژو 405، سمند، پارس، 206',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1041, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار سقف و ستون E1', '', 10, '/uploads/products/pinpart-1040.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1040', 'پژو 405، پژو پارس، سمند', 'IranKhodro', 'پژو 405، پژو پارس، سمند',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1040, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار سقف و ستون E0', '', 10, '/uploads/products/pinpart-1039.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1039', 'پژو 405، سمند، پارس', 'IranKhodro', 'پژو 405، سمند، پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1039, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار سقف و ستون E4', '', 10, '/uploads/products/pinpart-1038.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1038', 'پژو 405، پژو پارس، سمند، دنا', 'IranKhodro', 'پژو 405، پژو پارس، سمند، دنا',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1038, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار آبگیر ستون پژو ۲۰۶', '', 10, '/uploads/products/pinpart-1037.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1037', 'پژو 206، پژو 207، رانا', 'IranKhodro', 'پژو 206، پژو 207، رانا',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1037, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار ریل شیشه پژو ۴۰۵', '', 10, '/uploads/products/pinpart-1036.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1036', 'پژو 405، پژو پارس', 'IranKhodro', 'پژو 405، پژو پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1036, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار ریل شیشه سمند', '', 10, '/uploads/products/pinpart-1035.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1035', 'سمند LX، سورن، دنا', 'IranKhodro', 'سمند LX، سورن، دنا',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1035, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار آبگیر بیرونی سمند', '', 10, '/uploads/products/pinpart-1034.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1034', 'سمند LX، سمند SE، سورن', 'IranKhodro', 'سمند LX، سمند SE، سورن',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1034, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار آبگیر بیرونی پژو ۴۰۵', '', 10, '/uploads/products/pinpart-1033.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1033', 'پژو 405، پژو پارس', 'IranKhodro', 'پژو 405، پژو پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1033, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار رکاب پرشیا بلند', '', 10, '/uploads/products/pinpart-1032.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1032', 'پژو پارس، پارس LX و ELX', 'IranKhodro', 'پژو پارس، پارس LX و ELX',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1032, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار رکاب پرشیا کوتاه', '', 10, '/uploads/products/pinpart-1031.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1031', 'پژو پارس، پارس سال و ELX', 'IranKhodro', 'پژو پارس، پارس سال و ELX',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1031, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار دستگیره مچی کوتاه پژو ۴۰۵', '', 10, '/uploads/products/pinpart-1030.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1030', 'پژو 405، پژو پارس، سمند', 'IranKhodro', 'پژو 405، پژو پارس، سمند',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1030, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار دستگیره مچی بلند پژو ۴۰۵', '', 10, '/uploads/products/pinpart-1029.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1029', 'پژو 405، پژو پارس، سمند', 'IranKhodro', 'پژو 405، پژو پارس، سمند',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1029, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار گردشی میل کاپوت', '', 10, '/uploads/products/pinpart-1028.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1028', 'پژو 405، پژو پارس، سمند', 'IranKhodro', 'پژو 405، پژو پارس، سمند',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1028, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار ثابت میل کاپوت سمند', '', 10, '/uploads/products/pinpart-1027.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1027', 'سمند LX، سورن، دنا', 'IranKhodro', 'سمند LX، سورن، دنا',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1027, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار گردشی میل کاپوت پژو ۲۰۶', '', 10, '/uploads/products/pinpart-1026.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1026', 'پژو 206، پژو 207، رانا', 'IranKhodro', 'پژو 206، پژو 207، رانا',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1026, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار ثابت میل کاپوت پژو ۲۰۶', '', 10, '/uploads/products/pinpart-1025.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1025', 'پژو 206، پژو 207، رانا', 'IranKhodro', 'پژو 206، پژو 207، رانا',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1025, true, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار حرارت گیر پژو ۴۰۵', '', 10, '/uploads/products/pinpart-1024.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1024', 'پژو 405، سمند، پارس', 'IranKhodro', 'پژو 405، سمند، پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1024, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار رله فن پژو ۴۰۵', '', 10, '/uploads/products/pinpart-1023.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1023', 'پژو 405، سمند، پژو پارس', 'IranKhodro', 'پژو 405، سمند، پژو پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1023, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار توری هواکش پژو ۲۰۶', '', 10, '/uploads/products/pinpart-1022.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1022', 'پژو 206، پژو 207', 'IranKhodro', 'پژو 206، پژو 207',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1022, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار قلاب نمره پژو ۲۰۶ و پارس', '', 10, '/uploads/products/pinpart-1021.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1021', 'پژو 206، پژو پارس، سمند', 'IranKhodro', 'پژو 206، پژو پارس، سمند',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1021, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار مادگی کف صندوق پژو ۴۰۵', '', 10, '/uploads/products/pinpart-1020.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1020', 'پژو 405، سمند، پارس', 'IranKhodro', 'پژو 405، سمند، پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1020, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار مادگی شلگیر L90', '', 10, '/uploads/products/pinpart-1019.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1019', 'رنو تندر 90، رنو ساندرو', 'IranKhodro', 'رنو تندر 90، رنو ساندرو',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1019, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار نری شلگیر L90', '', 10, '/uploads/products/pinpart-1018.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1018', 'رنو تندر 90، رنو ساندرو، استپ وی', 'IranKhodro', 'رنو تندر 90، رنو ساندرو، استپ وی',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1018, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار نری کف صندوق پرشیا', '', 10, '/uploads/products/pinpart-1017.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1017', 'پژو پارس، پارس ELX، 405 SLX', 'IranKhodro', 'پژو پارس، پارس ELX، 405 SLX',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1017, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار نری کف صندوق پژو ۲۰۶', '', 10, '/uploads/products/pinpart-1016.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1016', 'پژو 206 هاچبک و صندوقدار SD، پژو 207', 'IranKhodro', 'پژو 206 هاچبک و صندوقدار SD، پژو 207',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1016, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار نری کف صندوق پژو ۴۰۵', '', 10, '/uploads/products/pinpart-1015.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1015', 'پژو 405، سمند، پژو پارس', 'IranKhodro', 'پژو 405، سمند، پژو پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1015, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار نوار لبه کاپوت پژو ۴۰۵', '', 10, '/uploads/products/pinpart-1014.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1014', 'پژو 405، پژو پارس', 'IranKhodro', 'پژو 405، پژو پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1014, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار شلگیر پلاستیکی', '', 10, '/uploads/products/pinpart-1013.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1013', 'پژو 405، پژو پارس، سمند، 206', 'IranKhodro', 'پژو 405، پژو پارس، سمند، 206',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1013, true, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار زه اطراف پژو ۲۰۶', '', 10, '/uploads/products/pinpart-1012.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1012', 'پژو 206، پژو 207', 'IranKhodro', 'پژو 206، پژو 207',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1012, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار جلو پنجره پژو ۲۰۶', '', 10, '/uploads/products/pinpart-1011.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1011', 'پژو 206، پژو 207، رانا', 'IranKhodro', 'پژو 206، پژو 207، رانا',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1011, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار زه ابرویی پژو ۴۰۵', '', 10, '/uploads/products/pinpart-1010.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1010', 'پژو 405، پژو پارس', 'IranKhodro', 'پژو 405، پژو پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1010, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار آمپولی', '', 10, '/uploads/products/pinpart-1009.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1009', 'پژو 405، پارس، سمند، 206 و عمومی', 'IranKhodro', 'پژو 405، پارس، سمند، 206 و عمومی',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1009, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار تودری L90', '', 10, '/uploads/products/pinpart-1008.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1008', 'تندر 90، ساندرو، پارس تندر', 'IranKhodro', 'تندر 90، ساندرو، پارس تندر',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1008, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار تودری سمند', '', 10, '/uploads/products/pinpart-1007.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1007', 'سمند LX، سورن، دنا', 'IranKhodro', 'سمند LX، سورن، دنا',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1007, true, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار تودری پژو ۲۰۶ فوم دار', '', 10, '/uploads/products/pinpart-1006.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1006', 'پژو 206، پژو 207، رانا', 'IranKhodro', 'پژو 206، پژو 207، رانا',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1006, true, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار تودری پژو ۲۰۶', '', 10, '/uploads/products/pinpart-1005.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1005', 'پژو 206، پژو 207، رانا', 'IranKhodro', 'پژو 206، پژو 207، رانا',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1005, true, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار تودری پژو ۴۰۵ سیاه', '', 10, '/uploads/products/pinpart-1004.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1004', 'پژو 405، سمند، پژو پارس', 'IranKhodro', 'پژو 405، سمند، پژو پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1004, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار تودری پژو ۴۰۵ زرد', '', 10, '/uploads/products/pinpart-1003.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1003', 'پژو 405، پژو پارس', 'IranKhodro', 'پژو 405، پژو پارس',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1003, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار تودری پژو ۴۰۵ سفید', '', 10, '/uploads/products/pinpart-1002.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1002', 'پژو 405، پژو پارس، سمند', 'IranKhodro', 'پژو 405، پژو پارس، سمند',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1002, false, true,
    NOW(), NOW()
);
INSERT INTO "Products" (
    "Name", "Description", "CategoryId", "ImageUrl", 
    "Tags", "AdditionalImages", "Hashtags",
    "Brand", "PartNumber", "CompatibleCars", "CarBrand", "CarModel", 
    "Material", "Warranty", "DisplayOrder", "IsFeatured", "IsActive", 
    "CreatedAt", "UpdatedAt"
)
VALUES (
    'خار تودری پژو ۴۰۵ سبز', '', 10, '/uploads/products/pinpart-1001.jpg',
    ARRAY['Ø®Ø§Ø±', 'Ø§ÛŒØ±Ø§Ù† Ø®ÙˆØ¯Ø±Ùˆ', 'Ù„ÙˆØ§Ø²Ù… ÛŒØ¯Ú©ÛŒ']::text[], ARRAY[]::text[], ARRAY[]::text[],
    'پین‌پارت', '1001', 'پژو 405، پژو پارس، سمند', 'IranKhodro', 'پژو 405، پژو پارس، سمند',
    '', 'ضمانت اصالت و کیفیت خط تولید پین‌پارت', 1001, true, true,
    NOW(), NOW()
);
-- 4. Verify count
SELECT COUNT(*) AS total_categories FROM "Categories";
SELECT COUNT(*) AS total_products FROM "Products" WHERE "IsActive" = true;
