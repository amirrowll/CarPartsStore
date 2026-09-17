// SEO Configuration for Pinpart Store
export const SITE_URL = 'https://pinparts.ir';
export const SITE_NAME = 'Pinpart Store';
export const DEFAULT_IMAGE = `${SITE_URL}/PinpartStore.JPEG`;

// Page-specific SEO configurations
export const SEO_CONFIG = {
  home: {
    title: 'Pinpart Store - فروشگاه تخصصی قطعات یدکی خودرو | سایپا، ایران خودرو، چینی',
    description: 'فروشگاه تخصصی قطعات یدکی خودرو - لوازم سایپا، ایران خودرو و چینی با بهترین قیمت و کیفیت. بیش از 15 سال تجربه در تامین قطعات اصلی.',
    keywords: 'قطعات یدکی, لوازم سایپا, لوازم ایران خودرو, لوازم چینی, خودرو, قطعات خودرو, فروشگاه قطعات, پین پارت, لنت ترمز, فیلتر هوا, شمع, روغن موتور, پراید, تیبا, پژو, سمند',
    structuredData: () => ({
      '@context': 'https://schema.org',
      '@type': 'WebSite',
      '@id': `${SITE_URL}/#website`,
      url: SITE_URL,
      name: SITE_NAME,
      description: 'فروشگاه تخصصی قطعات یدکی خودرو',
      inLanguage: 'fa-IR',
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
    title: 'محصولات قطعات یدکی خودرو | Pinpart Store',
    description: 'لیست کامل محصولات قطعات یدکی خودرو - انواع لوازم سایپا، ایران خودرو و چینی با بهترین کیفیت و قیمت مناسب.',
    keywords: 'لیست محصولات قطعات خودرو, خرید قطعات یدکی, قطعات سایپا, قطعات ایران خودرو, قطعات چینی, لوازم یدکی خودرو',
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
          description: product.description,
          brand: product.brand ? { '@type': 'Brand', name: product.brand } : undefined,
          category: product.categoryName
        }
      }))
    })
  },

  productDetail: (product: any) => ({
    title: `${product.name}${product.partNumber ? ` (${product.partNumber})` : ''}${product.brand ? ` - ${product.brand}` : ''} | Pinpart Store`,
    description: product.description 
      ? product.description.slice(0, 160)
      : `${product.name} - قطعه یدکی با کیفیت${product.compatibleCars ? ` برای ${product.compatibleCars}` : ''}. خرید از Pinpart Store با بهترین قیمت.`,
    keywords: [
      product.name,
      product.brand,
      product.partNumber,
      product.categoryName,
      product.compatibleCars,
      ...(product.tags || []),
      'خرید قطعات خودرو',
      'قطعات یدکی',
      'Pinpart Store'
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
    title: `قطعات ${category.name} | Pinpart Store`,
    description: `خرید قطعات ${category.name} با بهترین کیفیت و قیمت مناسب. انواع لوازم یدکی ${category.name} از برندهای معتبر.`,
    keywords: `قطعات ${category.name}, لوازم ${category.name}, خرید ${category.name}, قطعات یدکی ${category.name}`,
    structuredData: () => ({
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      '@id': `${SITE_URL}/category/${category.id}`,
      name: `قطعات ${category.name}`,
      description: `مجموعه قطعات ${category.name} با بهترین کیفیت`,
      url: `${SITE_URL}/category/${category.id}`,
      mainEntity: {
        '@type': 'ItemList',
        itemListElement: []
      }
    })
  }),

  chineseParts: {
    title: 'قطعات خودروهای چینی | Pinpart Store',
    description: 'خرید قطعات خودروهای چینی با بهترین کیفیت و قیمت مناسب. انواع لوازم یدکی چینی از برندهای معتبر.',
    keywords: 'قطعات چینی, لوازم خودرو چینی, قطعات یدکی چینی, خرید قطعات چینی, خودرو چینی',
    structuredData: () => ({
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      name: 'قطعات خودروهای چینی',
      description: 'مجموعه قطعات خودروهای چینی با بهترین کیفیت',
      url: `${SITE_URL}/chinese-parts`
    })
  },

  saipaParts: {
    title: 'قطعات خودروهای سایپا | Pinpart Store',
    description: 'خرید قطعات خودروهای سایپا با بهترین کیفیت و قیمت مناسب. انواع لوازم یدکی سایپا از برندهای معتبر.',
    keywords: 'قطعات سایپا, لوازم خودرو سایپا, قطعات یدکی سایپا, خرید قطعات سایپا, خودرو سایپا',
    structuredData: () => ({
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      name: 'قطعات خودروهای سایپا',
      description: 'مجموعه قطعات خودروهای سایپا با بهترین کیفیت',
      url: `${SITE_URL}/saipa-parts`
    })
  },

  irankhodroParts: {
    title: 'قطعات خودروهای ایران خودرو | Pinpart Store',
    description: 'خرید قطعات خودروهای ایران خودرو با بهترین کیفیت و قیمت مناسب. انواع لوازم یدکی ایران خودرو از برندهای معتبر.',
    keywords: 'قطعات ایران خودرو, لوازم خودرو ایران خودرو, قطعات یدکی ایران خودرو, خرید قطعات ایران خودرو, خودرو ایران خودرو',
    structuredData: () => ({
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      name: 'قطعات خودروهای ایران خودرو',
      description: 'مجموعه قطعات خودروهای ایران خودرو با بهترین کیفیت',
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