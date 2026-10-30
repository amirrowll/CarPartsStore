with open('/etc/nginx/sites-enabled/pinparts', 'r') as f:
    content = f.read()

# Add map if not present
if 'map $http_upgrade' not in content:
    content = 'map $http_upgrade $connection_upgrade {\n    default upgrade;\n    \'\' close;\n}\n\n' + content

# Replace hardcoded connection upgrade with dynamic
content = content.replace("proxy_set_header Connection 'upgrade';", "proxy_set_header Connection $connection_upgrade;")

with open('/etc/nginx/sites-enabled/pinparts', 'w') as f:
    f.write(content)

print("Nginx config updated successfully")
