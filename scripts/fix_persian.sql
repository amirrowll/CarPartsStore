SET client_encoding = 'UTF8';

UPDATE "Categories" SET "Name" = 'خارجات' WHERE "Id" IN (1, 10);
UPDATE "Categories" SET "Name" = 'پیچ و مهره' WHERE "Id" = 11;
UPDATE "Categories" SET "Name" = 'آرم و علائم' WHERE "Id" = 12;
UPDATE "Categories" SET "Name" = 'سوکت و اتصالات برقی' WHERE "Id" = 13;

UPDATE "Products" SET "Tags" = ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[];
