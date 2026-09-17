import { useEffect } from 'react';
import { useLocation } from 'react-router-dom';

const SITE_URL = 'https://pinparts.ir';
const SITE_NAME = 'Pinpart Store';
const DEFAULT_IMAGE = `${SITE_URL}/PinpartStore.JPEG`;
const DEFAULT_TITLE = 'Pinpart Store - فروشگاه تخصصی قطعات یدکی خودرو | سایپا، ایران خودرو، چینی';
const DEFAULT_DESC = 'فروشگاه تخصصی قطعات یدکی خودرو - لوازم سایپا، ایران خودرو و چینی با بهترین قیمت و کیفیت. بیش از 15 سال تجربه در تامین قطعات اصلی.';
const DEFAULT_KEYWORDS = 'قطعات یدکی, لوازم سایپا, لوازم ایران خودرو, لوازم چینی, خودرو, قطعات خودرو, فروشگاه قطعات, پین پارت, لنت ترمز, فیلتر هوا, شمع, روغن موتور, پراید, تیبا, پژو, سمند';
const DEFAULT_AUTHOR = 'Pinpart Store';
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
  const fullTitle = title ? `${title} | ${SITE_NAME}` : DEFAULT_TITLE;
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
    
    // Hreflang برای زبان فارسی
    setLink('alternate', canonicalUrl);
    
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
