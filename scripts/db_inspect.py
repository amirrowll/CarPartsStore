import subprocess

cmd = "PGPASSWORD='Pinpart@DB2026!' psql -h localhost -U pinparts_user -d pinpartsdb -c 'SELECT \"Id\", \"Name\" FROM \"Categories\";'"
res = subprocess.run(cmd, shell=True, capture_output=True, text=True)
print("CATEGORIES:\n", res.stdout)

cmd2 = "PGPASSWORD='Pinpart@DB2026!' psql -h localhost -U pinparts_user -d pinpartsdb -c 'SELECT count(*) FROM \"Products\";'"
res2 = subprocess.run(cmd2, shell=True, capture_output=True, text=True)
print("PRODUCT COUNT:\n", res2.stdout)
