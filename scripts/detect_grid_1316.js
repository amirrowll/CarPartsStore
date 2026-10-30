const fs = require('fs');

// Simple PPM/BMP parser or check box border color
// In each box:
// The borders are thin rounded rectangles.
// Let's sample a few horizontal lines and vertical lines to detect the borders.
// We have 6 columns and 7 rows.
// Let's compute approximate grid:
// Width = 1316. Margins: left ~ 75, right ~ 1241. Total span ~ 1166.
// 1166 / 6 cols = ~ 194 px per col. Box width ~ 180, gap ~ 14.
// Height = 1799. Margins: top ~ 80, bottom ~ 1720. Total span ~ 1640.
// 1640 / 7 rows = ~ 234 px per row. Box height ~ 220, gap ~ 14.

console.log('Approximate grid calculated:');
for (let c = 0; c < 6; c++) {
  const left = Math.round(75 + c * 194.5);
  console.log(`Col ${c}: Left = ${left}, Width = 180`);
}
for (let r = 0; r < 7; r++) {
  const top = Math.round(80 + r * 234);
  console.log(`Row ${r}: Top = ${top}, Height = 220`);
}
