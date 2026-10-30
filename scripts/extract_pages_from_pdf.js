const fs = require('fs');
const path = require('path');

const pdfPath = 'C:/Users/Amirhossein/.gemini/antigravity-ide/brain/ac779555-bd05-4f82-9cb5-d3484faf22f2/.user_uploaded/media_1792144097127.pdf';
const outDir = 'extracted_pages';
if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true });

console.log('Reading PDF:', pdfPath);
const buf = fs.readFileSync(pdfPath);
console.log('PDF size:', buf.length, 'bytes');

let pos = 0;
let count = 0;
while (pos < buf.length) {
  // Look for JPEG SOI: 0xFF 0xD8 0xFF
  const start = buf.indexOf(Buffer.from([0xFF, 0xD8, 0xFF]), pos);
  if (start === -1) break;
  
  // Look for JPEG EOI: 0xFF 0xD9
  const end = buf.indexOf(Buffer.from([0xFF, 0xD9]), start + 3);
  if (end === -1) break;
  
  const imgBuf = buf.subarray(start, end + 2);
  // Only save reasonably sized images (> 50KB to avoid thumbnails/icons)
  if (imgBuf.length > 50000) {
    count++;
    const outPath = path.join(outDir, `page_${count}.jpg`);
    fs.writeFileSync(outPath, imgBuf);
    console.log(`Extracted page ${count}: ${imgBuf.length} bytes -> ${outPath}`);
  }
  
  pos = end + 2;
}

console.log(`Total extracted pages: ${count}`);
