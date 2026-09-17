# Script to fix ProductForm.tsx
import re

# Read the file
with open('carpartsstore-frontend/src/pages/admin/ProductForm.tsx', 'r', encoding='utf-8') as f:
    content = f.read()

# Find and remove the option with value 0
pattern = r'<option value=\{0\}>[^<]+</option>\s*'
content = re.sub(pattern, '', content)

# Write the fixed content back
with open('carpartsstore-frontend/src/pages/admin/ProductForm.tsx', 'w', encoding='utf-8') as f:
    f.write(content)

print("File fixed successfully!")