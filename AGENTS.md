# Rules & Guidelines for Antigravity AI Agents (Pinparts Project)

## 1. Strict UTF-8 Encoding & Anti-Mojibake Rule (CRITICAL)
- **Zero Mojibake Policy:** Persian text must NEVER be corrupted into mojibake (e.g. `Ø§Ù†ÙˆØ§Ø¹ Ø®Ø§Ø± Ùˆ Ù¾ÛŒÙ†â€ŒÙ‡Ø§ÛŒ Ø§ØªÙˆÙ…Ø¨ÛŒÙ„`).
- **File Encodings:** All generated or edited files (`.sql`, `.tsx`, `.ts`, `.cs`, `.json`, `.md`) MUST be strictly UTF-8 without BOM.
- **PowerShell Output Warning:** Never use standard PowerShell `>` or `Out-File` without explicitly setting `-Encoding utf8NoBOM` or using `[System.IO.File]::WriteAllText($path, $content, [System.Text.UTF8Encoding]::new($false))`.
- **Database Scripts:** Any SQL script interacting with PostgreSQL or MySQL must explicitly include:
  ```sql
  SET client_encoding = 'UTF8';
  ```
  When executing remote commands via SSH/Python, always ensure strings and files are read/written with `encoding='utf-8'`.

## 2. Category Structure & Filtering Rules
- The store has 4 official primary categories:
  - **Category 10:** خارجات (خار، بست و پین‌های پلیمری و فلزی خودرو)
  - **Category 11:** پیچ و مهره (پیچ، مهره، خار مهره و واشرجات استاندارد)
  - **Category 12:** آرم و علائم (آرم، نوشته و علائم فابریک خودرو)
  - **Category 13:** سوکت و اتصالات برقی (انواع سوکت، کانکتور و فیش برق خودرو)
- **No Duplicate Categories:** Category ID 1 must NOT be created or used as a duplicate of Category 10.
- **Strict Category Filtering:** In car brand pages (`irankhodro-parts.tsx`, `saipa-parts.tsx`, `chinese-parts.tsx`), category filtering must strictly check `p.categoryId === 10/11/12/13` or exact category name. Never use loose text substring matches on `description` (e.g., matching the word "پیچ" or "سیم" inside a clip's description).

## 3. Product Catalog Photos & Quality Standards
- **Real Authentic Parts Only:** Mechanics and wholesale buyers in چراغ برق rely on recognizing the exact physical plastic mold lines, collars, and barbs. Never substitute real products with AI-generated fantasy clips.
- **Pure White Background:** Product photos must be on 100% pure white background (`#FFFFFF`) with all catalog paper noise and watermarks eliminated.
- **Sharp Edge Details:** Always preserve high-contrast edges and authentic textures.

## 4. Full-Stack API & SPA UX Rules
- **Controller Payload Compatibility:** `ProductsController` (and other controllers) must support both `application/json` (sent by frontend admin forms) and `multipart/form-data` (sent with file uploads) to prevent resetting boolean flags like `isActive` or `isFeatured`.
- **Scroll Position on Route Change:** All SPA page navigations must reset the window scroll to top (`window.scrollTo(0, 0)`) via the `<ScrollToTop />` component.
- **Call Requests & Inquiries:** The `/api/contact/call-request` endpoint must always be deployed and functional to receive customer phone numbers and quote inquiries without throwing errors.
