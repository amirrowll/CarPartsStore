Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

public class SuperSharpCleaner
{
    public static void Enhance(string inputPath, string outputPath)
    {
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
                        bool isPink = (c.R > 212 && (c.R - c.G >= 5 || c.R - c.B >= 5) && c.G > 180 && c.B > 180);
                        bool isLightBg = (c.R > 228 && c.G > 228 && c.B > 228);
                        bool isGreyWm = ((c.R + c.G + c.B) / 3 > 220 && Math.Abs(c.R - c.G) < 8 && Math.Abs(c.G - c.B) < 8);

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

                    float scale = Math.Min(360f / pW, 360f / pH);
                    int drawW = (int)(pW * scale);
                    int drawH = (int)(pH * scale);
                    int drawX = (canvasSize - drawW) / 2;
                    int drawY = (canvasSize - drawH) / 2;

                    g.DrawImage(cropped, new Rectangle(drawX, drawY, drawW, drawH));

                    // Multi-pass Laplacian Sharpening:
                    // Enhance edges strongly so the product looks crisp and detailed
                    using (var sharp = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                    {
                        for (int y = 0; y < canvasSize; y++)
                        {
                            for (int x = 0; x < canvasSize; x++)
                            {
                                Color c = dest.GetPixel(x, y);
                                if (c.R >= 248 && c.G >= 248 && c.B >= 248)
                                {
                                    sharp.SetPixel(x, y, Color.White);
                                }
                                else if (x > 1 && x < canvasSize - 2 && y > 1 && y < canvasSize - 2)
                                {
                                    // 3x3 Laplacian edge enhancement
                                    Color cUp = dest.GetPixel(x, y - 1);
                                    Color cDown = dest.GetPixel(x, y + 1);
                                    Color cLeft = dest.GetPixel(x - 1, y);
                                    Color cRight = dest.GetPixel(x + 1, y);

                                    // Kernel: center * 5 - (up + down + left + right)
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

                                    // If pixel was over-sharpened into white background
                                    if (r >= 248 && gVal >= 248 && b >= 248)
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

[SuperSharpCleaner]::Enhance("extracted_items_page1\item_1001.jpg", "extracted_items_page1\sharp_1001.jpg")
[SuperSharpCleaner]::Enhance("extracted_items_page1\item_1033.jpg", "extracted_items_page1\sharp_1033.jpg")
Write-Host "Sharp enhancement complete!"
