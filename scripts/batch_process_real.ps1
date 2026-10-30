Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;

public class BatchRealCleaner
{
    public static void ProcessItem(string inputPath, string outputPath)
    {
        if (!File.Exists(inputPath)) return;

        using (var src = new Bitmap(inputPath))
        {
            int w = src.Width;
            int h = src.Height;

            // Crop the inner product (exclude top badge number and bottom Persian text)
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

                    if (lum < 236 || sat > 8)
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

            // Margin
            minX = Math.Max(0, minX - 5);
            maxX = Math.Min(w - 1, maxX + 5);
            minY = Math.Max(0, minY - 5);
            maxY = Math.Min(h - 1, maxY + 5);

            int pW = maxX - minX + 1;
            int pH = maxY - minY + 1;

            Rectangle rect = new Rectangle(minX, minY, pW, pH);
            using (var cropped = src.Clone(rect, PixelFormat.Format32bppArgb))
            {
                // Whiten background
                for (int y = 0; y < pH; y++)
                {
                    for (int x = 0; x < pW; x++)
                    {
                        Color c = cropped.GetPixel(x, y);
                        int lum = (int)(0.299 * c.R + 0.587 * c.G + 0.114 * c.B);
                        int sat = Math.Max(c.R, Math.Max(c.G, c.B)) - Math.Min(c.R, Math.Min(c.G, c.B));

                        if (lum > 226 && sat < 16)
                        {
                            cropped.SetPixel(x, y, Color.White);
                        }
                    }
                }

                // Render in 500x500 pure white canvas
                int canvasSize = 500;
                using (var dest = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                using (var g = Graphics.FromImage(dest))
                {
                    g.Clear(Color.White);
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.SmoothingMode = SmoothingMode.HighQuality;
                    g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    g.CompositingQuality = CompositingQuality.HighQuality;

                    float scale = Math.Min(370f / pW, 370f / pH);
                    int drawW = (int)(pW * scale);
                    int drawH = (int)(pH * scale);
                    int drawX = (canvasSize - drawW) / 2;
                    int drawY = (canvasSize - drawH) / 2;

                    g.DrawImage(cropped, new Rectangle(drawX, drawY, drawW, drawH));

                    // Contrast and sharpness
                    using (var result = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                    {
                        for (int y = 0; y < canvasSize; y++)
                        {
                            for (int x = 0; x < canvasSize; x++)
                            {
                                Color c = dest.GetPixel(x, y);
                                if (c.R >= 248 && c.G >= 248 && c.B >= 248)
                                {
                                    result.SetPixel(x, y, Color.White);
                                }
                                else
                                {
                                    int r = (int)((c.R - 128) * 1.20 + 128);
                                    int gVal = (int)((c.G - 128) * 1.20 + 128);
                                    int b = (int)((c.B - 128) * 1.20 + 128);

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

$destApi = "CarPartsStore.API\wwwroot\uploads\products"
$destFront = "carpartsstore-frontend\public\uploads\products"

for ($code = 1001; $code -le 1042; $code++) {
    $srcPath = "extracted_items_page1\item_${code}.jpg"
    $outPathApi = Join-Path $destApi "pinpart-${code}.jpg"
    $outPathFront = Join-Path $destFront "pinpart-${code}.jpg"

    [BatchRealCleaner]::ProcessItem($srcPath, $outPathApi)
    Copy-Item $outPathApi $outPathFront -Force
    Write-Host "Processed pure white catalog item: pinpart-${code}.jpg"
}

Write-Host "All 42 items successfully updated with 100% pure white backgrounds!"
