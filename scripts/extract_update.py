import zipfile
import os

zip_path = '/tmp/frontend_update.zip'
dest_dir = '/var/www/CarPartsStore/carpartsstore-frontend/dist'

with zipfile.ZipFile(zip_path) as z:
    for member in z.infolist():
        rel_name = member.filename.replace('\\', '/')
        target_path = os.path.join(dest_dir, rel_name)
        if member.is_dir() or rel_name.endswith('/'):
            os.makedirs(target_path, exist_ok=True)
        else:
            os.makedirs(os.path.dirname(target_path), exist_ok=True)
            with z.open(member) as source, open(target_path, 'wb') as target:
                target.write(source.read())

print("ALL FILES EXTRACTED SUCCESSFULLY TO DIST!")
