Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;

public class SuperSharpCleaner
{
    public static void Enhance(string inputPath, string outputPath)
    {
        if (!File.Exists(inputPath)) return;

        using (var src = new Bitmap(inputPath))
        {
            int w = src.Width;
            int h = src.Height;

            int top = (int)(h * 0.16);
            int bottom = (int)(h * 0.81);
            int left = (int)(w * 0.08);
            int right = (int)(w * 0.92);

            int minX = right, maxX = left, minY = bottom, maxY = top;
            for (int y = top; y < bottom; y++)
            {
                for (int x = left; x < right; x++)
                {
                    Color px = src.GetPixel(x, y);
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

            if (minX >= maxX || minY >= maxY) { minX = left; maxX = right; minY = top; maxY = bottom; }
            minX = Math.Max(0, minX - 4);
            maxX = Math.Min(w - 1, maxX + 4);
            minY = Math.Max(0, minY - 4);
            maxY = Math.Min(h - 1, maxY + 4);

            int pW = maxX - minX + 1;
            int pH = maxY - minY + 1;

            Rectangle rect = new Rectangle(minX, minY, pW, pH);
            using (var cropped = src.Clone(rect, PixelFormat.Format32bppArgb))
            {
                // Background cleaning (remove pink and grey watermark, whiten background)
                for (int y = 0; y < pH; y++)
                {
                    for (int x = 0; x < pW; x++)
                    {
                        Color c = cropped.GetPixel(x, y);
                        bool isPink = (c.R > 210 && (c.R - c.G >= 4 || c.R - c.B >= 4) && c.G > 175 && c.B > 175);
                        bool isLightBg = (c.R > 225 && c.G > 225 && c.B > 225);
                        bool isGreyWm = ((c.R + c.G + c.B) / 3 > 218 && Math.Abs(c.R - c.G) < 9 && Math.Abs(c.G - c.B) < 9);

                        if (isPink || isLightBg || isGreyWm)
                        {
                            cropped.SetPixel(x, y, Color.White);
                        }
                    }
                }

                // Render into high-density 500x500 canvas
                int canvasSize = 500;
                using (var dest = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                using (var g = Graphics.FromImage(dest))
                {
                    g.Clear(Color.White);
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.SmoothingMode = SmoothingMode.HighQuality;
                    g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    g.CompositingQuality = CompositingQuality.HighQuality;

                    float scale = Math.Min(365f / pW, 365f / pH);
                    int drawW = (int)(pW * scale);
                    int drawH = (int)(pH * scale);
                    int drawX = (canvasSize - drawW) / 2;
                    int drawY = (canvasSize - drawH) / 2;

                    g.DrawImage(cropped, new Rectangle(drawX, drawY, drawW, drawH));

                    // Multi-pass Laplacian Sharpening:
                    // Enhance edges strongly so the authentic mold details and textures pop
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

                                    // Kernel: center * 2.2 - 0.3 * (up + down + left + right)
                                    int r = (int)(c.R * 2.2f - (cUp.R + cDown.R + cLeft.R + cRight.R) * 0.30f);
                                    int gVal = (int)(c.G * 2.2f - (cUp.G + cDown.G + cLeft.G + cRight.G) * 0.30f);
                                    int b = (int)(c.B * 2.2f - (cUp.B + cDown.B + cLeft.B + cRight.B) * 0.30f);

                                    // Contrast expansion
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

                        ImageCodecInfo jpgEncoder = null;
                        foreach (var codec in ImageCodecInfo.GetImageEncoders())
                        {
                            if (codec.MimeType == "image/jpeg") { jpgEncoder = codec; break; }
                        }
                        var encParams = new EncoderParameters(1);
                        encParams.Param[0] = new EncoderParameter(Encoder.Quality, 99L);

                        sharp.Save(outputPath, jpgEncoder, encParams);
                    }
                }
            }
        }
    }
}
"@

Add-Type -TypeDefinition $csharp -ReferencedAssemblies "System.Drawing"

$destApi = "CarPartsStore.API\wwwroot\uploads\products"
$destFront = "carpartsstore-frontend\public\uploads\products"
$destDist = "carpartsstore-frontend\dist\uploads\products"

if (!(Test-Path $destApi)) { New-Item -ItemType Directory -Path $destApi -Force }
if (!(Test-Path $destFront)) { New-Item -ItemType Directory -Path $destFront -Force }
if (!(Test-Path $destDist)) { New-Item -ItemType Directory -Path $destDist -Force }

for ($code = 1001; $code -le 1042; $code++) {
    $srcPath = "extracted_items_page1\item_${code}.jpg"
    $outPathApi = Join-Path $destApi "pinpart-${code}.jpg"
    $outPathFront = Join-Path $destFront "pinpart-${code}.jpg"
    $outPathDist = Join-Path $destDist "pinpart-${code}.jpg"

    [SuperSharpCleaner]::Enhance($srcPath, $outPathApi)
    Copy-Item $outPathApi $outPathFront -Force
    Copy-Item $outPathApi $outPathDist -Force
    Write-Host "Processed pinpart-${code}.jpg"
}

Write-Host "ALL 42 products enhanced with pure white background and super sharp details!"
