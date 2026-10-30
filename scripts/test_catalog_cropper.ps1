Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;

public class CatalogItemEnhancer
{
    public static void ProcessItem(Bitmap pageBmp, int left, int top, int width, int height, string outputPath)
    {
        // 1. Crop the product box
        Rectangle boxRect = new Rectangle(left, top, width, height);
        using (var boxBmp = pageBmp.Clone(boxRect, PixelFormat.Format32bppArgb))
        {
            // Focus on product area: skip top number (approx 15%) and bottom text (approx 22%)
            int pTop = (int)(height * 0.14);
            int pBottom = (int)(height * 0.78);
            int pLeft = (int)(width * 0.05);
            int pRight = (int)(width * 0.95);

            // Bounding box detection
            int minX = pRight, maxX = pLeft, minY = pBottom, maxY = pTop;
            for (int y = pTop; y < pBottom; y++)
            {
                for (int x = pLeft; x < pRight; x++)
                {
                    Color px = boxBmp.GetPixel(x, y);
                    int lum = (int)(0.299 * px.R + 0.587 * px.G + 0.114 * px.B);
                    int sat = Math.Max(px.R, Math.Max(px.G, px.B)) - Math.Min(px.R, Math.Min(px.G, px.B));
                    if (lum < 232 || sat > 8)
                    {
                        if (x < minX) minX = x;
                        if (x > maxX) maxX = x;
                        if (y < minY) minY = y;
                        if (y > maxY) maxY = y;
                    }
                }
            }

            if (minX >= maxX || minY >= maxY) { minX = pLeft; maxX = pRight; minY = pTop; maxY = pBottom; }
            minX = Math.Max(0, minX - 3);
            maxX = Math.Min(width - 1, maxX + 3);
            minY = Math.Max(0, minY - 3);
            maxY = Math.Min(height - 1, maxY + 3);

            int pW = maxX - minX + 1;
            int pH = maxY - minY + 1;

            Rectangle prodRect = new Rectangle(minX, minY, pW, pH);
            using (var cropped = boxBmp.Clone(prodRect, PixelFormat.Format32bppArgb))
            {
                // Whiten background & clean noise
                for (int y = 0; y < pH; y++)
                {
                    for (int x = 0; x < pW; x++)
                    {
                        Color c = cropped.GetPixel(x, y);
                        bool isPink = (c.R > 210 && (c.R - c.G >= 4 || c.R - c.B >= 4) && c.G > 175 && c.B > 175);
                        bool isLightBg = (c.R > 224 && c.G > 224 && c.B > 224);
                        bool isGreyWm = ((c.R + c.G + c.B) / 3 > 215 && Math.Abs(c.R - c.G) < 10 && Math.Abs(c.G - c.B) < 10);

                        if (isPink || isLightBg || isGreyWm)
                        {
                            cropped.SetPixel(x, y, Color.White);
                        }
                    }
                }

                // Render into square canvas (600x600) with HighQuality Bicubic
                int canvasSize = 600;
                using (var dest = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                using (var g = Graphics.FromImage(dest))
                {
                    g.Clear(Color.White);
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.SmoothingMode = SmoothingMode.HighQuality;
                    g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    g.CompositingQuality = CompositingQuality.HighQuality;

                    float scale = Math.Min(480f / pW, 480f / pH);
                    int drawW = (int)(pW * scale);
                    int drawH = (int)(pH * scale);
                    int drawX = (canvasSize - drawW) / 2;
                    int drawY = (canvasSize - drawH) / 2;

                    g.DrawImage(cropped, new Rectangle(drawX, drawY, drawW, drawH));

                    // Sharpening pass
                    using (var sharp = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                    {
                        for (int y = 0; y < canvasSize; y++)
                        {
                            for (int x = 0; x < canvasSize; x++)
                            {
                                Color c = dest.GetPixel(x, y);
                                if (c.R >= 246 && c.G >= 246 && c.B >= 246)
                                {
                                    sharp.SetPixel(x, y, Color.White);
                                }
                                else if (x > 1 && x < canvasSize - 2 && y > 1 && y < canvasSize - 2)
                                {
                                    Color cUp = dest.GetPixel(x, y - 1);
                                    Color cDown = dest.GetPixel(x, y + 1);
                                    Color cLeft = dest.GetPixel(x - 1, y);
                                    Color cRight = dest.GetPixel(x + 1, y);

                                    int r = (int)(c.R * 2.2f - (cUp.R + cDown.R + cLeft.R + cRight.R) * 0.30f);
                                    int gVal = (int)(c.G * 2.2f - (cUp.G + cDown.G + cLeft.G + cRight.G) * 0.30f);
                                    int b = (int)(c.B * 2.2f - (cUp.B + cDown.B + cLeft.B + cRight.B) * 0.30f);

                                    r = (int)((r - 128) * 1.25f + 128);
                                    gVal = (int)((gVal - 128) * 1.25f + 128);
                                    b = (int)((b - 128) * 1.25f + 128);

                                    r = Math.Min(255, Math.Max(0, r));
                                    gVal = Math.Min(255, Math.Max(0, gVal));
                                    b = Math.Min(255, Math.Max(0, b));

                                    if (r >= 246 && gVal >= 246 && b >= 246)
                                        sharp.SetPixel(x, y, Color.White);
                                    else
                                        sharp.SetPixel(x, y, Color.FromArgb(255, r, gVal, b));
                                }
                                else
                                {
                                    sharp.SetPixel(x, y, c);
                                }
                            }
                        }

                        // Save as JPEG with 95 quality
                        var encoder = ImageCodecInfo.GetImageEncoders()[1]; // JPEG
                        var encParams = new EncoderParameters(1);
                        encParams.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 95L);

                        string dir = Path.GetDirectoryName(outputPath);
                        if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);
                        sharp.Save(outputPath, encoder, encParams);
                    }
                }
            }
        }
    }
}
"@

Add-Type -TypeDefinition $csharp -ReferencedAssemblies "System.Drawing"

$bmp = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\extracted_pages\page_1.jpg")
$outDir = "$PSScriptRoot\..\test_crops"
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }

$cols = @(85, 278, 470, 663, 856, 1049)
$rows = @(59, 281, 502, 723, 945, 1166, 1387)

# Test first 6 items of row 0
for ($c = 0; $c -lt 6; $c++) {
    $itemNum = 1001 + $c
    $outPath = Join-Path $outDir "pinpart-${itemNum}.jpg"
    [CatalogItemEnhancer]::ProcessItem($bmp, $cols[$c], $rows[0], 175, 204, $outPath)
    Write-Host "Processed item $itemNum -> $outPath"
}

$bmp.Dispose()
Write-Host "Batch test completed successfully!"
