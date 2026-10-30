const { runRemote } = require('./remote_exec');

const deployScript = `
echo "=== 1. Extracting Clean Frontend ==="
tar -xzf /tmp/frontend_deploy_clean.tar.gz -C /var/www/CarPartsStore/carpartsstore-frontend/dist/

echo "=== 2. Cleaning Categories in Database ==="
PGPASSWORD='Pinpart@DB2026!' psql -h localhost -U pinparts_user -d pinpartsdb -c 'DELETE FROM "Categories" WHERE "Id" NOT IN (10, 11, 12);'

echo "=== 3. Compiling Backend API ==="
cd /var/www/CarPartsStore/CarPartsStore.API
dotnet build -c Release

echo "=== 4. Restarting Services ==="
systemctl restart carparts-api
systemctl reload nginx

echo "=== 5. Verification ==="
sleep 2
curl -s http://localhost:5000/api/categories
`;

console.log("Starting remote deployment...");
const output = runRemote(deployScript);
console.log("DEPLOYMENT OUTPUT:\n", output);
