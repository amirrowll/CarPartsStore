Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

public class RealProductCleaner
{
    public static void Process(string inputPath, string outputPath)
    {
        using (var src = new Bitmap(inputPath))
        {
            int w = src.Width;
            int h = src.Height;

            // Crop the inner product (exclude top badge number and bottom Persian text)
            // Top badge is in y: 0..60, bottom text is in y: (h-70)..h
            int top = (int)(h * 0.17);
            int bottom = (int)(h * 0.81);
            int left = (int)(w * 0.08);
            int right = (int)(w * 0.92);

            // Bounding box of the authentic product inside this area
            int minX = right, maxX = left, minY = bottom, maxY = top;

            for (int y = top; y < bottom; y++)
            {
                for (int x = left; x < right; x++)
                {
                    Color px = src.GetPixel(x, y);
                    int lum = (int)(0.299 * px.R + 0.587 * px.G + 0.114 * px.B);
                    int sat = Math.Max(px.R, Math.Max(px.G, px.B)) - Math.Min(px.R, Math.Min(px.G, px.B));

                    // If pixel is darker than paper background or has color
                    if (lum < 235 || sat > 10)
                    {
                        if (x < minX) minX = x;
                        if (x > maxX) maxX = x;
                        if (y < minY) minY = y;
                        if (y > maxY) maxY = y;
                    }
                }
            }

            if (minX >= maxX || minY >= maxY)
            {
                minX = left; maxX = right; minY = top; maxY = bottom;
            }

            // Add 6px breathing room
            minX = Math.Max(0, minX - 6);
            maxX = Math.Min(w - 1, maxX + 6);
            minY = Math.Max(0, minY - 6);
            maxY = Math.Min(h - 1, maxY + 6);

            int pW = maxX - minX + 1;
            int pH = maxY - minY + 1;

            Rectangle rect = new Rectangle(minX, minY, pW, pH);
            using (var cropped = src.Clone(rect, PixelFormat.Format32bppArgb))
            {
                // Whiten background:
                // Any pixel with high luminance and low saturation becomes pure #FFFFFF
                for (int y = 0; y < pH; y++)
                {
                    for (int x = 0; x < pW; x++)
                    {
                        Color c = cropped.GetPixel(x, y);
                        int lum = (int)(0.299 * c.R + 0.587 * c.G + 0.114 * c.B);
                        int sat = Math.Max(c.R, Math.Max(c.G, c.B)) - Math.Min(c.R, Math.Min(c.G, c.B));

                        // Paper background is very bright with no color
                        if (lum > 228 && sat < 16)
                        {
                            cropped.SetPixel(x, y, Color.White);
                        }
                    }
                }

                // Render into 500x500 pure white canvas
                int canvasSize = 500;
                using (var dest = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                using (var g = Graphics.FromImage(dest))
                {
                    g.Clear(Color.White);
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.SmoothingMode = SmoothingMode.HighQuality;
                    g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    g.CompositingQuality = CompositingQuality.HighQuality;

                    // Fit naturally in 380x380
                    float scale = Math.Min(380f / pW, 380f / pH);
                    int drawW = (int)(pW * scale);
                    int drawH = (int)(pH * scale);
                    int drawX = (canvasSize - drawW) / 2;
                    int drawY = (canvasSize - drawH) / 2;

                    g.DrawImage(cropped, new Rectangle(drawX, drawY, drawW, drawH));

                    // Sharpen and tone enhance the actual product
                    using (var result = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                    {
                        for (int y = 0; y < canvasSize; y++)
                        {
                            for (int x = 0; x < canvasSize; x++)
                            {
                                Color c = dest.GetPixel(x, y);
                                if (c.R >= 250 && c.G >= 250 && c.B >= 250)
                                {
                                    result.SetPixel(x, y, Color.White);
                                }
                                else
                                {
                                    // Slight clarity/contrast boost
                                    int r = (int)((c.R - 128) * 1.18 + 128);
                                    int gVal = (int)((c.G - 128) * 1.18 + 128);
                                    int b = (int)((c.B - 128) * 1.18 + 128);

                                    r = Math.Min(255, Math.Max(0, r));
                                    gVal = Math.Min(255, Math.Max(0, gVal));
                                    b = Math.Min(255, Math.Max(0, b));

                                    result.SetPixel(x, y, Color.FromArgb(255, r, gVal, b));
                                }
                            }
                        }

                        ImageCodecInfo jpgEncoder = null;
                        foreach (var codec in ImageCodecInfo.GetImageEncoders())
                        {
                            if (codec.MimeType == "image/jpeg") { jpgEncoder = codec; break; }
                        }
                        var encParams = new EncoderParameters(1);
                        encParams.Param[0] = new EncoderParameter(Encoder.Quality, 98L);

                        result.Save(outputPath, jpgEncoder, encParams);
                    }
                }
            }
        }
    }
}
"@

Add-Type -TypeDefinition $csharp -ReferencedAssemblies "System.Drawing"

[RealProductCleaner]::Process("extracted_items_page1\item_1001.jpg", "extracted_items_page1\real_1001.jpg")
[RealProductCleaner]::Process("extracted_items_page1\item_1004.jpg", "extracted_items_page1\real_1004.jpg")
Write-Host "Processed real items"
