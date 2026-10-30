with open('/var/www/CarPartsStore/carpartsstore-frontend/dist/index.html', 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace(
    '<title>خارجات ماشین و لوازم یدکی خودرو | خرید عمده خار و بست چراغ برق | پین پارت</title>',
    '<title>پین پارت (Pinparts) | مرکز خارجات ماشین و پخش عمده لوازم یدکی خودرو</title>'
)
c = c.replace(
    '<meta property="og:title" content="خارجات ماشین و لوازم یدکی خودرو | خرید عمده خار و بست چراغ برق | پین پارت" />',
    '<meta property="og:title" content="پین پارت (Pinparts) | مرکز خارجات ماشین و پخش عمده لوازم یدکی خودرو" />'
)

with open('/var/www/CarPartsStore/carpartsstore-frontend/dist/index.html', 'w', encoding='utf-8') as f:
    f.write(c)

print('Remote index.html updated successfully')
