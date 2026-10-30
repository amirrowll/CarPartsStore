SET client_encoding = 'UTF8';

-- Remove Material and Description from all products
UPDATE "Products" SET "Description" = '', "Material" = '';

-- Verification
SELECT "Id", "Name", "PartNumber", "Description", "Material" FROM "Products" LIMIT 10;
