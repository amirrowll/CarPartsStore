import subprocess

sql = """
SET client_encoding = 'UTF8';
UPDATE "Categories" SET "Name" = 'خارجات' WHERE "Id" IN (1, 10);
UPDATE "Categories" SET "Name" = 'پیچ و مهره' WHERE "Id" = 11;
UPDATE "Categories" SET "Name" = 'آرم و علائم' WHERE "Id" = 12;
UPDATE "Categories" SET "Name" = 'سوکت و اتصالات برقی' WHERE "Id" = 13;
UPDATE "Products" SET "Tags" = ARRAY['خار', 'ایران خودرو', 'لوازم یدکی']::text[];
"""

with open('/tmp/fix.sql', 'w', encoding='utf-8') as f:
    f.write(sql)

cmd = "PGPASSWORD='Pinpart@DB2026!' psql -h localhost -U pinparts_user -d pinpartsdb -f /tmp/fix.sql"
res = subprocess.run(cmd, shell=True, capture_output=True, text=True)
print("STDOUT:", res.stdout)
print("STDERR:", res.stderr)
