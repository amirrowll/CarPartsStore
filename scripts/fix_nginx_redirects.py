import re

with open('/etc/nginx/sites-enabled/pinparts', 'r') as f:
    content = f.read()

# Replace the server_name in the main SSL block from "pinparts.ir www.pinparts.ir" to "pinparts.ir"
content = re.sub(r'server_name\s+pinparts\.ir\s+www\.pinparts\.ir;', 'server_name pinparts.ir;', content)

# Check if www redirect block already exists
if 'server_name www.pinparts.ir;' not in content or 'return 301 https://pinparts.ir$request_uri;' not in content:
    # Add explicit 301 redirect for https://www.pinparts.ir -> https://pinparts.ir
    www_redirect_block = """
# Permanent 301 Redirect www to non-www (Consolidates Google Domain Authority)
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name www.pinparts.ir;

    ssl_certificate /etc/letsencrypt/live/pinparts.ir/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/pinparts.ir/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    return 301 https://pinparts.ir$request_uri;
}
"""
    content = www_redirect_block + content

with open('/etc/nginx/sites-enabled/pinparts', 'w') as f:
    f.write(content)

print("Nginx redirects updated successfully")
