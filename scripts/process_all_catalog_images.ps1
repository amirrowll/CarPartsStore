Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;

public class FullCatalogProcessor
{
    private static ImageCodecInfo jpegEncoder;
    private static EncoderParameters encParams;

    static FullCatalogProcessor()
    {
        var encoders = ImageCodecInfo.GetImageEncoders();
        foreach (var enc in encoders)
        {
            if (enc.FormatID == ImageFormat.Jpeg.Guid)
            {
                jpegEncoder = enc;
                break;
            }
        }
        encParams = new EncoderParameters(1);
        encParams.Param[0] = new EncoderParameter(Encoder.Quality, 92L);
    }

    public static void ProcessItem(Bitmap pageBmp, int left, int top, int width, int height, string outPath1, string outPath2)
    {
        Rectangle boxRect = new Rectangle(left, top, width, height);
        using (var boxBmp = pageBmp.Clone(boxRect, PixelFormat.Format32bppArgb))
        {
            int pTop = (int)(height * 0.14);
            int pBottom = (int)(height * 0.78);
            int pLeft = (int)(width * 0.05);
            int pRight = (int)(width * 0.95);

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
                for (int y = 0; y < pH; y++)
                {
                    for (int x = 0; x < pW; x++)
                    {
                        Color c = cropped.GetPixel(x, y);
                        bool isPink = (c.R > 210 && (c.R - c.G >= 4 || c.R - c.B >= 4) && c.G > 175 && c.B > 175);
                        bool isLightBg = (c.R > 228 && c.G > 228 && c.B > 228);
                        bool isGreyWm = ((c.R + c.G + c.B) / 3 > 218 && Math.Abs(c.R - c.G) < 9 && Math.Abs(c.G - c.B) < 9);

                        if (isPink || isLightBg || isGreyWm)
                        {
                            cropped.SetPixel(x, y, Color.White);
                        }
                    }
                }

                int canvasSize = 500;
                using (var dest = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                using (var g = Graphics.FromImage(dest))
                {
                    g.Clear(Color.White);
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.SmoothingMode = SmoothingMode.HighQuality;
                    g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    g.CompositingQuality = CompositingQuality.HighQuality;

                    float scale = Math.Min(390f / pW, 390f / pH);
                    int drawW = (int)(pW * scale);
                    int drawH = (int)(pH * scale);
                    int drawX = (canvasSize - drawW) / 2;
                    int drawY = (canvasSize - drawH) / 2;

                    g.DrawImage(cropped, new Rectangle(drawX, drawY, drawW, drawH));

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

                                    int r = (int)(c.R * 2.1f - (cUp.R + cDown.R + cLeft.R + cRight.R) * 0.275f);
                                    int gVal = (int)(c.G * 2.1f - (cUp.G + cDown.G + cLeft.G + cRight.G) * 0.275f);
                                    int b = (int)(c.B * 2.1f - (cUp.B + cDown.B + cLeft.B + cRight.B) * 0.275f);

                                    r = (int)((r - 128) * 1.20f + 128);
                                    gVal = (int)((gVal - 128) * 1.20f + 128);
                                    b = (int)((b - 128) * 1.20f + 128);

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

                        sharp.Save(outPath1, jpegEncoder, encParams);
                        if (!string.IsNullOrEmpty(outPath2))
                        {
                            sharp.Save(outPath2, jpegEncoder, encParams);
                        }
                    }
                }
            }
        }
    }
}
"@

Add-Type -TypeDefinition $csharp -ReferencedAssemblies "System.Drawing"

$itemsJson = Get-Content "$PSScriptRoot\full_catalog_items.json" -Raw -Encoding utf8 | ConvertFrom-Json
$destDir1 = "$PSScriptRoot\..\carpartsstore-frontend\public\uploads\products"
$destDir2 = "$PSScriptRoot\..\CarPartsStore.API\wwwroot\uploads\products"

if (-not (Test-Path $destDir1)) { New-Item -ItemType Directory -Path $destDir1 -Force | Out-Null }
if (-not (Test-Path $destDir2)) { New-Item -ItemType Directory -Path $destDir2 -Force | Out-Null }

$cols = @(85, 278, 470, 663, 856, 1049)
$rows = @(59, 281, 502, 723, 945, 1166, 1387)

Write-Host "Total items to process: $($itemsJson.Count)"

# Group by page to avoid reopening bitmaps
$grouped = $itemsJson | Group-Object -Property page

foreach ($grp in $grouped) {
    $pageNum = $grp.Name
    $pagePath = "$PSScriptRoot\..\extracted_pages\page_${pageNum}.jpg"
    if (-not (Test-Path $pagePath)) {
        Write-Warning "Page $pagePath not found!"
        continue
    }

    $pageBmp = [System.Drawing.Bitmap]::FromFile($pagePath)
    Write-Host "Processing page $pageNum ($($grp.Group.Count) items)..."

    foreach ($item in $grp.Group) {
        $outPath1 = Join-Path $destDir1 "pinpart-$($item.id).jpg"
        $outPath2 = Join-Path $destDir2 "pinpart-$($item.id).jpg"

        $colX = $cols[$item.col]
        $rowY = $rows[$item.row]

        [FullCatalogProcessor]::ProcessItem($pageBmp, $colX, $rowY, 175, 204, $outPath1, $outPath2)
    }

    $pageBmp.Dispose()
}

Write-Host "All catalog images processed and enhanced successfully!"
