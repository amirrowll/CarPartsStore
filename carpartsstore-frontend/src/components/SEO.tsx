import { useEffect } from 'react';
import { useLocation } from 'react-router-dom';

const SITE_URL = 'https://pinparts.ir';
const SITE_NAME = 'پین‌ پارت (Pinparts)';
const DEFAULT_IMAGE = `${SITE_URL}/logo.jpg`;
const DEFAULT_TITLE = 'خارجات ماشین و لوازم یدکی خودرو | خرید عمده خار و بست چراغ برق | پین پارت';
const DEFAULT_DESC = 'بزرگترین مرکز تولید و پخش عمده خارجات ماشین، انواع خار و بست پلیمری و فلزی خودرو، پیچ و مهره استاندارد، سوکت سیم‌کشی و لوازم یدکی ایران خودرو، سایپا و خودروهای چینی در بازار چراغ برق تهران با بهترین قیمت دست‌اول در پین پارت.';
const DEFAULT_KEYWORDS = 'خارجات ماشین, لوازم یدکی خودرو, لوازم یدکی, خارجات خودرو, لوازم یدکی ماشین, خرید عمده لوازم یدکی, خار خودرو, خار و بست, خار تودری, خار آمپولی, خار شلگیر, پیچ و مهره خودرو, پیچ و مهره ماشین, سوکت ماشین, سوکت خودرو, اتصالات خودرو, لوازم یدکی ایران خودرو, لوازم یدکی سایپا, لوازم یدکی چینی, بازار چراغ برق تهران, پین پارت, Pinparts';
const DEFAULT_AUTHOR = 'پین پارت | Pinparts';
const DEFAULT_LOCALE = 'fa_IR';

interface SEOProps {
  title?: string;
  description?: string;
  keywords?: string;
  image?: string;
  type?: 'website' | 'product' | 'article';
  structuredData?: object | object[];
  noindex?: boolean;
}

const setMeta = (selector: string, attr: string, value: string, attrName = 'content') => {
  let el = document.querySelector(selector) as HTMLMetaElement | null;
  if (!el) {
    el = document.createElement('meta');
    // Extract the attribute value from selector like meta[name="description"]
    const match = selector.match(/\[(.*?)="(.*?)"\]/);
    if (match) {
      el.setAttribute(match[1], match[2]);
    }
    document.head.appendChild(el);
  }
  el.setAttribute(attrName, value);
};

const setLink = (rel: string, href: string) => {
  let el = document.querySelector(`link[rel="${rel}"]`) as HTMLLinkElement | null;
  if (!el) {
    el = document.createElement('link');
    el.setAttribute('rel', rel);
    document.head.appendChild(el);
  }
  el.href = href;
};

const SEO: React.FC<SEOProps> = ({
  title,
  description,
  keywords,
  image = DEFAULT_IMAGE,
  type = 'website',
  structuredData,
  noindex = false,
}) => {
  const location = useLocation();
  const canonicalUrl = `${SITE_URL}${location.pathname}`;
  const fullTitle = title 
    ? (title.includes('پین پارت') || title.includes('پین‌ پارت') || title.includes('Pinparts') ? title : `${title} | ${SITE_NAME}`)
    : DEFAULT_TITLE;
  const desc = description || DEFAULT_DESC;
  const kw = keywords || DEFAULT_KEYWORDS;
  const img = image.startsWith('http') ? image : `${SITE_URL}${image}`;

  useEffect(() => {
    // Title
    document.title = fullTitle;

    // Basic
    setMeta('meta[name="description"]', 'name', desc);
    setMeta('meta[name="keywords"]', 'name', kw);
    setMeta('meta[name="author"]', 'name', DEFAULT_AUTHOR);
    setMeta('meta[name="robots"]', 'name', noindex ? 'noindex, nofollow' : 'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1');
    setMeta('meta[name="googlebot"]', 'name', 'index, follow');
    setMeta('meta[name="bingbot"]', 'name', 'index, follow');
    setLink('canonical', canonicalUrl);
    
    // Set hreflang attributes
    const setHreflang = (lang: string, href: string) => {
      let el = document.querySelector(`link[rel="alternate"][hreflang="${lang}"]`) as HTMLLinkElement | null;
      if (!el) {
        el = document.createElement('link');
        el.setAttribute('rel', 'alternate');
        el.setAttribute('hreflang', lang);
        document.head.appendChild(el);
      }
      el.href = href;
    };
    
    setHreflang('fa', canonicalUrl);
    setHreflang('fa-ir', canonicalUrl);
    setHreflang('x-default', canonicalUrl);

    // Open Graph
    setMeta('meta[property="og:title"]', 'property', fullTitle);
    setMeta('meta[property="og:description"]', 'property', desc);
    setMeta('meta[property="og:image"]', 'property', img);
    setMeta('meta[property="og:image:width"]', 'property', '1200');
    setMeta('meta[property="og:image:height"]', 'property', '630');
    setMeta('meta[property="og:image:alt"]', 'property', fullTitle);
    setMeta('meta[property="og:image:type"]', 'property', 'image/jpeg');
    setMeta('meta[property="og:url"]', 'property', canonicalUrl);
    setMeta('meta[property="og:type"]', 'property', type);
    setMeta('meta[property="og:locale"]', 'property', DEFAULT_LOCALE);
    setMeta('meta[property="og:locale:alternate"]', 'property', 'en_US');
    setMeta('meta[property="og:site_name"]', 'property', SITE_NAME);
    setMeta('meta[property="og:price:amount"]', 'property', '0');
    setMeta('meta[property="og:price:currency"]', 'property', 'IRR');

    // Twitter Card
    setMeta('meta[name="twitter:card"]', 'name', 'summary_large_image');
    setMeta('meta[name="twitter:title"]', 'name', fullTitle);
    setMeta('meta[name="twitter:description"]', 'name', desc);
    setMeta('meta[name="twitter:image"]', 'name', img);
    setMeta('meta[name="twitter:image:alt"]', 'name', fullTitle);
    setMeta('meta[name="twitter:site"]', 'name', '@pinpartstore');
    setMeta('meta[name="twitter:creator"]', 'name', '@pinpartstore');

    // Structured Data
    const removeSD = (id: string) => document.getElementById(id)?.remove();
    removeSD('sd-main');
    removeSD('sd-extra');
    removeSD('sd-breadcrumb');

    if (structuredData) {
      const items = Array.isArray(structuredData) ? structuredData : [structuredData];
      items.forEach((sd, i) => {
        const script = document.createElement('script');
        script.id = i === 0 ? 'sd-main' : i === 1 ? 'sd-breadcrumb' : 'sd-extra';
        script.type = 'application/ld+json';
        script.textContent = JSON.stringify(sd);
        document.head.appendChild(script);
      });
    } else {
      // Default BreadcrumbList
      const breadcrumbSchema = {
        '@context': 'https://schema.org',
        '@type': 'BreadcrumbList',
        itemListElement: [
          {
            '@type': 'ListItem',
            position: 1,
            name: 'خانه',
            item: SITE_URL
          }
        ]
      };
      
      const script = document.createElement('script');
      script.id = 'sd-breadcrumb';
      script.type = 'application/ld+json';
      script.textContent = JSON.stringify(breadcrumbSchema);
      document.head.appendChild(script);
    }

    return () => {
      document.title = DEFAULT_TITLE;
    };
  }, [fullTitle, desc, kw, img, type, canonicalUrl, noindex, structuredData]);

  return null;
};

export default SEO;
