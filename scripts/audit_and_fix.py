import subprocess
import os

print("=== 1. Cleaning Database Categories ===")
sql = """
SET client_encoding = 'UTF8';
DELETE FROM "Categories" WHERE "Id" NOT IN (10, 11, 12);
SELECT "Id", "Name", "Description", "IsActive" FROM "Categories" ORDER BY "DisplayOrder";
"""
with open('/tmp/clean_cat.sql', 'w', encoding='utf-8') as f:
    f.write(sql)

res = subprocess.run("PGPASSWORD='Pinpart@DB2026!' psql -h localhost -U pinparts_user -d pinpartsdb -f /tmp/clean_cat.sql", shell=True, capture_output=True, text=True)
print("DB OUTPUT:\n", res.stdout)
if res.stderr:
    print("DB ERR:\n", res.stderr)

print("=== 2. Checking Nginx Uploads Location ===")
with open('/etc/nginx/nginx.conf', 'r', encoding='utf-8') as f:
    conf = f.read()

# Let's see if /uploads/ is configured in nginx
if '/uploads' not in conf:
    print("Warning: /uploads not in /etc/nginx/nginx.conf, checking sites-available/enabled")
    res_sites = subprocess.run("grep -rn 'uploads' /etc/nginx/", shell=True, capture_output=True, text=True)
    print("GREP UPLOADS:\n", res_sites.stdout)

print("=== 3. Checking Upload Files on Disk ===")
res_ls1 = subprocess.run("ls -la /var/www/CarPartsStore/CarPartsStore.API/wwwroot/uploads/products | head -n 10", shell=True, capture_output=True, text=True)
print("API UPLOADS:\n", res_ls1.stdout)

res_ls2 = subprocess.run("ls -la /var/www/CarPartsStore/carpartsstore-frontend/dist/uploads/products | head -n 10", shell=True, capture_output=True, text=True)
print("FRONTEND UPLOADS:\n", res_ls2.stdout)

# Ensure nginx can read the files (chmod 755 / 644)
subprocess.run("chmod -R 755 /var/www/CarPartsStore/CarPartsStore.API/wwwroot/uploads", shell=True)
subprocess.run("chmod -R 755 /var/www/CarPartsStore/carpartsstore-frontend/dist/uploads", shell=True)

print("=== 4. Testing Local Curl Image ===")
res_curl1 = subprocess.run("curl -s -I http://localhost:5000/uploads/products/pinpart-1001.jpg", shell=True, capture_output=True, text=True)
print("CURL API PORT 5000:\n", res_curl1.stdout)

res_curl2 = subprocess.run("curl -s -I http://localhost/uploads/products/pinpart-1001.jpg", shell=True, capture_output=True, text=True)
print("CURL NGINX PORT 80:\n", res_curl2.stdout)

print("=== 5. Final Category Verification from API ===")
res_api = subprocess.run("curl -s http://localhost:5000/api/categories", shell=True, capture_output=True, text=True)
print("API CATEGORIES:\n", res_api.stdout)
