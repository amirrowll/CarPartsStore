import subprocess

conf_path = '/etc/nginx/sites-enabled/pinparts'
with open(conf_path, 'r', encoding='utf-8') as f:
    content = f.read()

no_cache_block = """
    # Do NOT cache Service Worker or HTML
    location = /sw.js {
        expires -1;
        add_header Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0";
    }

    location = /index.html {
        expires -1;
        add_header Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0";
    }
"""

if 'location = /sw.js' not in content:
    target = '# Cache static assets'
    if target in content:
        content = content.replace(target, no_cache_block + "\n    " + target)
        with open(conf_path, 'w', encoding='utf-8') as f:
            f.write(content)
        print("Updated Nginx config successfully!")
    else:
        print("Could not find target in Nginx config")
else:
    print("Nginx config already contains /sw.js block")

res = subprocess.run("nginx -t && systemctl reload nginx", shell=True, capture_output=True, text=True)
print(res.stdout, res.stderr)
