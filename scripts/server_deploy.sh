#!/bin/bash
set -e

echo "=== 1. Extracting deploy bundle ==="
rm -rf /tmp/deploy
mkdir -p /tmp/deploy
unzip -q -o /tmp/deploy_bundle.zip -d /tmp/deploy/ || true
echo "Extracted successfully."

echo "=== 2. Updating Backend ProductsController & Images ==="
cp /tmp/deploy/ProductsController.cs /var/www/CarPartsStore/CarPartsStore.API/Controllers/ProductsController.cs
mkdir -p /var/www/CarPartsStore/CarPartsStore.API/wwwroot/uploads/products
if [ -d "/tmp/deploy/uploads/products" ]; then
    cp -r /tmp/deploy/uploads/products/* /var/www/CarPartsStore/CarPartsStore.API/wwwroot/uploads/products/
fi

echo "=== 3. Building Backend API (Release) ==="
cd /var/www/CarPartsStore/CarPartsStore.API
dotnet build -c Release
systemctl restart carparts-api
echo "Backend restarted."

echo "=== 4. Seeding Database (pinpartsdb) ==="
PGPASSWORD='Pinpart@DB2026!' psql -h localhost -U pinparts_user -d pinpartsdb -f /tmp/deploy/seed_products_vps.sql
echo "Database seeded."

echo "=== 5. Updating Frontend Static Files ==="
if [ -d "/var/www/CarPartsStore/carpartsstore-frontend/dist" ]; then
    cp -r /var/www/CarPartsStore/carpartsstore-frontend/dist /var/www/CarPartsStore/carpartsstore-frontend/dist_old_backup || true
fi
mkdir -p /var/www/CarPartsStore/carpartsstore-frontend/dist
cp -r /tmp/deploy/* /var/www/CarPartsStore/carpartsstore-frontend/dist/
echo "Frontend updated."

echo "=== 6. Restarting Nginx ==="
systemctl restart nginx
echo "Nginx restarted."

echo "=== 7. Verification Tests ==="
sleep 2
echo "--- Categories ---"
curl -s http://localhost:5000/api/categories | head -c 300
echo ""
echo "--- Products ---"
curl -s "http://localhost:5000/api/products?pageSize=3" | head -c 300
echo ""
echo "=== DEPLOYMENT COMPLETED SUCCESSFULLY ==="
