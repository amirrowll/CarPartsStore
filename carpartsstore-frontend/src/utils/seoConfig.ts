// SEO Configuration for Pinpart Store
export const SITE_URL = 'https://pinparts.ir';
export const SITE_NAME = 'پین‌ پارت (Pinparts)';
export const DEFAULT_IMAGE = `${SITE_URL}/logo.jpg`;

// Page-specific SEO configurations
export const SEO_CONFIG = {
  home: {
    title: 'پین پارت (Pinparts) | مرکز خارجات ماشین و پخش عمده لوازم یدکی خودرو',
    description: 'پین پارت (Pinparts) بزرگترین مرکز تولید و پخش عمده خارجات ماشین، انواع خار و بست پلیمری خودرو، پیچ و مهره استاندارد، آرم و علائم و لوازم یدکی ایران خودرو، سایپا و چینی در بازار چراغ برق تهران با قیمت دست‌اول.',
    keywords: 'پین پارت, Pinparts, خارجات ماشین, خارجات خودرو, لوازم یدکی, لوازم یدکی خودرو, لوازم یدکی ماشین, خرید خارجات ماشین, خار خودرو, خار و بست ماشین, خار تودری, خار آمپولی, خار شلگیر, پیچ و مهره خودرو, پیچ و مهره ماشین, آرم و علائم خودرو, آرم ماشین, لوازم یدکی ایران خودرو, لوازم یدکی سایپا, لوازم یدکی چینی, پخش عمده لوازم یدکی, چراغ برق تهران',
    structuredData: () => ({
      '@context': 'https://schema.org',
      '@type': 'AutoPartsStore',
      '@id': `${SITE_URL}/#organization`,
      name: 'پین پارت | مرکز خارجات ماشین و لوازم یدکی خودرو',
      alternateName: ['Pinparts', 'پین پارت', 'Pinpart Store', 'خارجات ماشین پین پارت', 'لوازم یدکی پین پارت'],
      description: 'مرکز تخصصی تولید و توزیع منحصراً عمده خارجات ماشین، انواع خار و بست خودرویی، پیچ و مهره، آرم و علائم فابریک و قطعات یدکی در بازار چراغ برق تهران.',
      url: SITE_URL,
      logo: `${SITE_URL}/logo.jpg`,
      image: `${SITE_URL}/logo.jpg`,
      telephone: '+989196408805',
      priceRange: '$$',
      address: {
        '@type': 'PostalAddress',
        addressLocality: 'تهران',
        addressCountry: 'IR',
        streetAddress: 'بازار چراغ برق، خیابان امیرکبیر، پاساژ کوشانپور، طبقه دوم، پلاک 69'
      },
      areaServed: {
        '@type': 'Country',
        name: 'Iran'
      },
      knowsAbout: [
        'خارجات ماشین',
        'خارجات خودرو',
        'لوازم یدکی خودرو',
        'لوازم یدکی ماشین',
        'انواع خار و بست پلیمری خودرو',
        'خار تودری',
        'خار آمپولی',
        'خار شلگیر',
        'خار سپر',
        'پیچ و مهره خودرو',
        'سوکت و سیم کشی خودرو',
        'لوازم یدکی ایران خودرو',
        'لوازم یدکی سایپا',
        'قطعات خودروهای چینی'
      ],
      potentialAction: {
        '@type': 'SearchAction',
        target: {
          '@type': 'EntryPoint',
          urlTemplate: `${SITE_URL}/advanced-search?search={search_term_string}`
        },
        'query-input': 'required name=search_term_string'
      }
    })
  },

  products: {
    title: 'خارجات ماشین و لوازم یدکی خودرو | کاتالوگ جامع خار، بست و اتصالات | پین پارت',
    description: 'کاتالوگ و لیست کامل خارجات ماشین، انواع خار و بست پلیمری خودرو، پیچ و مهره استاندارد و سوکت‌های فابریک ایران خودرو، سایپا و چینی با بهترین کیفیت و قیمت عمده دست اول بازار چراغ برق در پین پارت.',
    keywords: 'خارجات ماشین, کاتالوگ خارجات خودرو, لوازم یدکی خودرو, لوازم یدکی ماشین, خرید عمده لوازم یدکی, خار خودرو, خار پژو, خار پراید, خار سمند, خار تودری, پیچ و مهره خودرو, سوکت ماشین, پین پارت',
    structuredData: (products: any[] = []) => ({
      '@context': 'https://schema.org',
      '@type': 'ItemList',
      itemListElement: products.slice(0, 10).map((product, index) => ({
        '@type': 'ListItem',
        position: index + 1,
        item: {
          '@type': 'Product',
          url: `${SITE_URL}/products/${product.id}`,
          name: product.name,
          image: product.imageUrl?.startsWith('http') ? product.imageUrl : `${SITE_URL}${product.imageUrl}`,
          description: product.description || `${product.name} - قطعه یدکی با کیفیت`,
          brand: product.brand ? { '@type': 'Brand', name: product.brand } : undefined,
          category: product.categoryName,
          offers: {
            '@type': 'Offer',
            priceCurrency: 'IRR',
            price: '0',
            availability: 'https://schema.org/InStock',
            url: `${SITE_URL}/products/${product.id}`
          }
        }
      }))
    })
  },

  productDetail: (product: any) => ({
    title: `${product.name}${product.partNumber ? ` (${product.partNumber})` : ''} | لوازم یدکی خودرو پین پارت`,
    description: product.description 
      ? `${product.name} - ${product.description.slice(0, 140)} - خرید عمده و خرده لوازم یدکی و قطعات خودرو از پین پارت چراغ برق`
      : `${product.name} - خرید دست اول قطعه و لوازم یدکی خودرو${product.compatibleCars ? ` مناسب ${product.compatibleCars}` : ''} با ضمانت کیفیت از پین پارت بازار چراغ برق.`,
    keywords: [
      product.name,
      'لوازم یدکی خودرو',
      'قطعات یدکی خودرو',
      'خرید عمده قطعات خودرو',
      product.brand,
      product.partNumber,
      product.categoryName,
      product.compatibleCars,
      ...(product.tags || []),
      'پین پارت',
      'Pinparts'
    ].filter(Boolean).join(', '),
    structuredData: (imageUrl: string) => {
      const productUrl = `${SITE_URL}/products/${product.id}`;
      const fullImage = imageUrl || DEFAULT_IMAGE;

      return {
        '@context': 'https://schema.org',
        '@type': 'Product',
        '@id': productUrl,
        name: product.name,
        description: product.description || `${product.name} - قطعه یدکی با کیفیت`,
        image: [fullImage],
        sku: product.partNumber || String(product.id),
        mpn: product.partNumber,
        url: productUrl,
        brand: product.brand ? {
          '@type': 'Brand',
          name: product.brand
        } : {
          '@type': 'Brand',
          name: 'Pinpart Store'
        },
        category: product.categoryName || 'قطعات یدکی خودرو',
        offers: {
          '@type': 'Offer',
          url: productUrl,
          availability: 'https://schema.org/InStock',
          priceCurrency: 'IRR',
          seller: {
            '@type': 'Organization',
            name: 'Pinpart Store',
            url: SITE_URL,
            telephone: '+989196408805'
          },
          itemCondition: 'https://schema.org/NewCondition'
        },
        ...(product.compatibleCars && {
          isCompatibleWith: product.compatibleCars.split(',').map((car: string) => ({
            '@type': 'Car',
            name: car.trim()
          }))
        }),
        ...(product.material && { material: product.material }),
        ...(product.warranty && {
          warranty: {
            '@type': 'WarrantyPromise',
            durationOfWarranty: product.warranty
          }
        }),
        ...(product.tags && product.tags.length > 0 && {
          keywords: product.tags.join(', ')
        })
      };
    }
  }),

  category: (category: any) => ({
    title: `${category.name} | لوازم یدکی و قطعات خودرو - پین پارت`,
    description: `خرید دست اول و عمده ${category.name} خودرو با بالاترین کیفیت و بهترین قیمت بازار چراغ برق از پین پارت.`,
    keywords: `${category.name}, خرید ${category.name}, لوازم یدکی خودرو, پین پارت, قطعات خودرو`,
    structuredData: () => ({
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      '@id': `${SITE_URL}/category/${category.id}`,
      name: `${category.name} خودرو`,
      description: `مجموعه تخصصی ${category.name} خودرو با تضمین کیفیت`,
      url: `${SITE_URL}/category/${category.id}`,
      mainEntity: {
        '@type': 'ItemList',
        itemListElement: []
      }
    })
  }),

  chineseParts: {
    title: 'خارجات ماشین و لوازم یدکی خودروهای چینی (ام‌وی‌ام، جک، چری، لیفان) | پین پارت',
    description: 'تامین دست‌اول و عمده انواع خارجات ماشین، خار و بست، پیچ و مهره و قطعات یدکی خودروهای چینی (MVM، جک، چری، برلیانس، لیفان) با بهترین قیمت بازار چراغ برق از پین پارت.',
    keywords: 'خارجات ماشین چینی, لوازم یدکی چینی, لوازم یدکی خودرو چینی, خار خودرو چینی, خار تودری ام وی ام, خار جک, خار چری, لوازم یدکی mvm, لوازم یدکی جک, لوازم یدکی چری, پین پارت',
    structuredData: () => ({
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      name: 'خارجات ماشین و لوازم یدکی خودروهای چینی',
      description: 'مجموعه تخصصی خارجات و لوازم یدکی خودروهای چینی با بهترین کیفیت بازار چراغ برق',
      url: `${SITE_URL}/chinese-parts`
    })
  },

  saipaParts: {
    title: 'خارجات ماشین و لوازم یدکی سایپا (پراید، تیبا، کوییک، ساینا، شاهین) | پین پارت',
    description: 'تامین و پخش عمده خارجات خودرو، انواع خار تودری، خار شلگیر، پیچ و مهره، سوکت و لوازم یدکی سایپا (پراید، تیبا، ساینا، کوییک، شاهین) با تضمین اصالت کالا و قیمت دست اول چراغ برق.',
    keywords: 'خارجات ماشین سایپا, لوازم یدکی سایپا, لوازم یدکی پراید, لوازم یدکی تیبا, لوازم یدکی کوییک, لوازم یدکی ساینا, خار پراید, خار تیبا, خار کوییک, خار تودری پراید, پین پارت',
    structuredData: () => ({
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      name: 'خارجات ماشین و لوازم یدکی محصولات سایپا',
      description: 'مجموعه تخصصی خارجات و قطعات یدکی سایپا با بهترین کیفیت بازار چراغ برق',
      url: `${SITE_URL}/saipa-parts`
    })
  },

  irankhodroParts: {
    title: 'خارجات ماشین و لوازم یدکی ایران خودرو (پژو، سمند، ۲۰۶، دنا، ۴۰۵، پارس) | پین پارت',
    description: 'مرکز پخش عمده خارجات ماشین، انواع خار و اتصالات پلیمری، پیچ و مهره استاندارد و لوازم یدکی محصولات ایران خودرو شامل پژو ۲۰۶، ۲۰۷، ۴۰۵، پارس، سمند، دنا و تارا با قیمت دست اول بازار چراغ برق در پین پارت.',
    keywords: 'خارجات ماشین ایران خودرو, لوازم یدکی ایران خودرو, لوازم یدکی پژو, لوازم یدکی سمند, لوازم یدکی ۲۰۶, لوازم یدکی ۴۰۵, خار پژو, خار سمند, خار تودری ۲۰۶, خار سپر ۴۰۵, پین پارت',
    structuredData: () => ({
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      name: 'خارجات ماشین و لوازم یدکی محصولات ایران خودرو',
      description: 'مجموعه تخصصی خارجات و قطعات یدکی ایران خودرو با بهترین کیفیت بازار چراغ برق',
      url: `${SITE_URL}/irankhodro-parts`
    })
  },

  contact: {
    title: 'تماس با ما | Pinpart Store',
    description: 'اطلاعات تماس با فروشگاه تخصصی قطعات یدکی خودرو Pinpart Store. آدرس، تلفن و راه‌های ارتباطی.',
    keywords: 'تماس با پین پارت, آدرس فروشگاه قطعات, تلفن قطعات یدکی, ارتباط با Pinpart Store',
    structuredData: () => ({
      '@context': 'https://schema.org',
      '@type': 'ContactPage',
      name: 'تماس با ما',
      description: 'صفحه تماس با فروشگاه Pinpart Store',
      url: `${SITE_URL}/contact-us`
    })
  }
};

// Helper function to generate breadcrumb structured data
export const generateBreadcrumbData = (items: Array<{name: string, url: string}>) => ({
  '@context': 'https://schema.org',
  '@type': 'BreadcrumbList',
  itemListElement: items.map((item, index) => ({
    '@type': 'ListItem',
    position: index + 1,
    name: item.name,
    item: item.url
  }))
});

// Helper function to generate FAQ structured data
export const generateFAQData = (questions: Array<{question: string, answer: string}>) => ({
  '@context': 'https://schema.org',
  '@type': 'FAQPage',
  mainEntity: questions.map(q => ({
    '@type': 'Question',
    name: q.question,
    acceptedAnswer: {
      '@type': 'Answer',
      text: q.answer
    }
  }))
});