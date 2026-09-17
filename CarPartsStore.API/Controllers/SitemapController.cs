using CarPartsStore.API.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Text;

namespace CarPartsStore.API.Controllers
{
    [Route("")]
    [ApiController]
    public class SitemapController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IConfiguration _configuration;

        public SitemapController(ApplicationDbContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }

        [HttpGet("sitemap.xml")]
        [ResponseCache(Duration = 3600)]
        public async Task<IActionResult> GetSitemap()
        {
            var siteUrl = _configuration["SiteUrl"] ?? "https://pinpartstore.com";

            var products = await _context.Products
                .Where(p => p.IsActive)
                .Select(p => new { p.Id, p.UpdatedAt, p.CreatedAt, p.Name, p.ImageUrl, p.CategoryId })
                .ToListAsync();

            var categories = await _context.Categories
                .Where(c => c.IsActive)
                .Select(c => new { c.Id, c.UpdatedAt, c.CreatedAt, c.Name })
                .ToListAsync();

            var sb = new StringBuilder();
            sb.AppendLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            sb.AppendLine("<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\"");
            sb.AppendLine("        xmlns:image=\"http://www.google.com/schemas/sitemap-image/1.1\"");
            sb.AppendLine("        xmlns:video=\"http://www.google.com/schemas/sitemap-video/1.1\"");
            sb.AppendLine("        xmlns:news=\"http://www.google.com/schemas/sitemap-news/0.9\">");

            // Static pages
            var staticPages = new[]
            {
                new { Url = "/", Priority = "1.0", Freq = "daily" },
                new { Url = "/products", Priority = "0.9", Freq = "daily" },
                new { Url = "/chinese-parts", Priority = "0.8", Freq = "weekly" },
                new { Url = "/saipa-parts", Priority = "0.8", Freq = "weekly" },
                new { Url = "/irankhodro-parts", Priority = "0.8", Freq = "weekly" },
                new { Url = "/featured-products", Priority = "0.7", Freq = "weekly" },
                new { Url = "/advanced-search", Priority = "0.6", Freq = "monthly" },
                new { Url = "/contact-us", Priority = "0.5", Freq = "monthly" },
            };

            foreach (var page in staticPages)
            {
                sb.AppendLine("  <url>");
                sb.AppendLine($"    <loc>{siteUrl}{page.Url}</loc>");
                sb.AppendLine($"    <changefreq>{page.Freq}</changefreq>");
                sb.AppendLine($"    <priority>{page.Priority}</priority>");
                sb.AppendLine($"    <lastmod>{DateTime.UtcNow:yyyy-MM-dd}</lastmod>");
                sb.AppendLine("  </url>");
            }

            // Category pages
            foreach (var cat in categories)
            {
                var lastMod = cat.UpdatedAt ?? cat.CreatedAt;
                sb.AppendLine("  <url>");
                sb.AppendLine($"    <loc>{siteUrl}/category/{cat.Id}</loc>");
                sb.AppendLine($"    <changefreq>weekly</changefreq>");
                sb.AppendLine($"    <priority>0.7</priority>");
                sb.AppendLine($"    <lastmod>{lastMod:yyyy-MM-dd}</lastmod>");
                sb.AppendLine("  </url>");
            }

            // Product pages - مهمترین بخش برای ایندکس گوگل
            foreach (var product in products)
            {
                var lastMod = product.UpdatedAt ?? product.CreatedAt;
                sb.AppendLine("  <url>");
                sb.AppendLine($"    <loc>{siteUrl}/products/{product.Id}</loc>");
                sb.AppendLine($"    <changefreq>weekly</changefreq>");
                sb.AppendLine($"    <priority>0.8</priority>");
                sb.AppendLine($"    <lastmod>{lastMod:yyyy-MM-dd}</lastmod>");
                
                // Image sitemap برای محصولات
                if (!string.IsNullOrEmpty(product.ImageUrl))
                {
                    var imageUrl = product.ImageUrl.StartsWith("/") ? $"{siteUrl}{product.ImageUrl}" : product.ImageUrl;
                    sb.AppendLine($"    <image:image>");
                    sb.AppendLine($"      <image:loc>{imageUrl}</image:loc>");
                    sb.AppendLine($"      <image:title>{System.Security.SecurityElement.Escape(product.Name)}</image:title>");
                    sb.AppendLine($"      <image:caption>قطعه یدکی {System.Security.SecurityElement.Escape(product.Name)} - Pinpart Store</image:caption>");
                    sb.AppendLine($"    </image:image>");
                }
                
                sb.AppendLine("  </url>");
            }

            sb.AppendLine("</urlset>");

            return Content(sb.ToString(), "application/xml", Encoding.UTF8);
        }

        [HttpGet("robots.txt")]
        public IActionResult GetRobots()
        {
            var siteUrl = _configuration["SiteUrl"] ?? "https://pinpartstore.com";
            var content = $@"User-agent: *
Allow: /
Disallow: /admin
Disallow: /admin/
Disallow: /api/
Disallow: /search-test
Disallow: /test

# Googlebot
User-agent: Googlebot
Allow: /
Crawl-delay: 0.5

# Bingbot
User-agent: Bingbot
Allow: /
Crawl-delay: 1

# Yandex
User-agent: Yandex
Allow: /
Crawl-delay: 2

# Sitemap داینامیک - هر محصول جدید خودکار اضافه میشه
Sitemap: {siteUrl}/sitemap.xml

# Host directive
Host: {siteUrl.Replace("https://", "").Replace("http://", "")}
";
            return Content(content, "text/plain");
        }

        [HttpGet("google-site-verification")]
        public IActionResult GetGoogleSiteVerification()
        {
            // بعد از ثبت سایت در Google Search Console، این کد رو جایگزین کنید
            var content = "google-site-verification: google1234567890abcdef.html";
            return Content(content, "text/plain");
        }
    }
}
