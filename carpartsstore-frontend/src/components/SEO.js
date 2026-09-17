import { useEffect } from 'react';
import { useLocation } from 'react-router-dom';
const SITE_URL = 'https://pinparts.ir';
const DEFAULT_IMAGE = `${SITE_URL}/PinpartStore.JPEG`;
const SEO = ({ title, description, keywords, image = DEFAULT_IMAGE, type = 'website', structuredData, }) => {
    const location = useLocation();
    const defaultTitle = 'Pinpart Store - فروشگاه تخصصی قطعات یدکی خودرو';
    const defaultDescription = 'فروشگاه تخصصی قطعات یدکی خودرو - لوازم سایپا، ایران خودرو و چینی با بهترین قیمت و کیفیت';
    const defaultKeywords = 'قطعات یدکی, لوازم سایپا, لوازم ایران خودرو, لوازم چینی, خودرو, قطعات خودرو, فروشگاه قطعات';
    const seoTitle = title ? `${title} | Pinpart Store` : defaultTitle;
    const seoDescription = description || defaultDescription;
    const seoKeywords = keywords || defaultKeywords;
    const canonicalUrl = `${SITE_URL}${location.pathname}`;
    useEffect(() => {
        document.title = seoTitle;
        const setMeta = (name, content, attr = 'name') => {
            let el = document.querySelector(`meta[${attr}="${name}"]`);
            if (!el) {
                el = document.createElement('meta');
                el.setAttribute(attr, name);
                document.head.appendChild(el);
            }
            el.setAttribute('content', content);
        };
        const setLink = (rel, href) => {
            let el = document.querySelector(`link[rel="${rel}"]`);
            if (!el) {
                el = document.createElement('link');
                el.setAttribute('rel', rel);
                document.head.appendChild(el);
            }
            el.setAttribute('href', href);
        };
        // Basic SEO
        setMeta('description', seoDescription);
        setMeta('keywords', seoKeywords);
        setLink('canonical', canonicalUrl);
        // Open Graph
        setMeta('og:title', seoTitle, 'property');
        setMeta('og:description', seoDescription, 'property');
        setMeta('og:image', image, 'property');
        setMeta('og:url', canonicalUrl, 'property');
        setMeta('og:type', type, 'property');
        setMeta('og:locale', 'fa_IR', 'property');
        setMeta('og:site_name', 'Pinpart Store', 'property');
        // Twitter Card
        setMeta('twitter:card', 'summary_large_image');
        setMeta('twitter:title', seoTitle);
        setMeta('twitter:description', seoDescription);
        setMeta('twitter:image', image);
        // Structured Data
        const sdId = 'structured-data-json';
        let sdEl = document.getElementById(sdId);
        if (structuredData) {
            if (!sdEl) {
                sdEl = document.createElement('script');
                sdEl.id = sdId;
                sdEl.setAttribute('type', 'application/ld+json');
                document.head.appendChild(sdEl);
            }
            sdEl.textContent = JSON.stringify(structuredData);
        }
        else if (sdEl) {
            sdEl.remove();
        }
        return () => {
            document.title = defaultTitle;
        };
    }, [seoTitle, seoDescription, seoKeywords, image, type, canonicalUrl, structuredData]);
    return null;
};
export default SEO;
