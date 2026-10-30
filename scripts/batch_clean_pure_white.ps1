Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Collections.Generic;

public class PureWhiteBatchProcessor
{
    public static void CleanItem(string inputPath, string outputPath)
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

            int pW = right - left;
            int pH = bottom - top;

            Rectangle rect = new Rectangle(left, top, pW, pH);
            using (var cropped = src.Clone(rect, PixelFormat.Format32bppArgb))
            {
                bool[,] isBg = new bool[pW, pH];
                Queue<Point> q = new Queue<Point>();

                for (int x = 0; x < pW; x++)
                {
                    q.Enqueue(new Point(x, 0));
                    q.Enqueue(new Point(x, pH - 1));
                }
                for (int y = 0; y < pH; y++)
                {
                    q.Enqueue(new Point(0, y));
                    q.Enqueue(new Point(pW - 1, y));
                }

                while (q.Count > 0)
                {
                    Point pt = q.Dequeue();
                    int x = pt.X;
                    int y = pt.Y;

                    if (x < 0 || x >= pW || y < 0 || y >= pH) continue;
                    if (isBg[x, y]) continue;

                    Color c = cropped.GetPixel(x, y);

                    // Background & Watermark detection:
                    // 1. Pink watermark from catalog background: R>215 && (R-G>=5 || R-B>=5) && G>180 && B>180
                    bool isPink = (c.R > 215 && (c.R - c.G >= 5 || c.R - c.B >= 5) && c.G > 180 && c.B > 180);
                    // 2. Light paper background: all channels > 230
                    bool isLightBg = (c.R > 230 && c.G > 230 && c.B > 230);
                    // 3. Grey watermark: high average brightness and low saturation
                    bool isGreyWm = ((c.R + c.G + c.B) / 3 > 224 && Math.Abs(c.R - c.G) < 8 && Math.Abs(c.G - c.B) < 8);

                    if (isPink || isLightBg || isGreyWm)
                    {
                        isBg[x, y] = true;
                        q.Enqueue(new Point(x + 1, y));
                        q.Enqueue(new Point(x - 1, y));
                        q.Enqueue(new Point(x, y + 1));
                        q.Enqueue(new Point(x, y - 1));
                    }
                }

                for (int y = 0; y < pH; y++)
                {
                    for (int x = 0; x < pW; x++)
                    {
                        if (isBg[x, y])
                        {
                            cropped.SetPixel(x, y, Color.White);
                        }
                    }
                }

                // Trim bounds
                int minX = pW, maxX = 0, minY = pH, maxY = 0;
                for (int y = 0; y < pH; y++)
                {
                    for (int x = 0; x < pW; x++)
                    {
                        Color c = cropped.GetPixel(x, y);
                        if (c.R != 255 || c.G != 255 || c.B != 255)
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
                    minX = 0; maxX = pW - 1; minY = 0; maxY = pH - 1;
                }

                int prodW = maxX - minX + 1;
                int prodH = maxY - minY + 1;

                Rectangle prodRect = new Rectangle(minX, minY, prodW, prodH);
                using (var prodBmp = cropped.Clone(prodRect, PixelFormat.Format32bppArgb))
                {
                    int canvasSize = 500;
                    using (var canvas = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                    using (var g = Graphics.FromImage(canvas))
                    {
                        g.Clear(Color.White);
                        g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                        g.SmoothingMode = SmoothingMode.HighQuality;
                        g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                        g.CompositingQuality = CompositingQuality.HighQuality;

                        float scale = Math.Min(370f / prodW, 370f / prodH);
                        int drawW = (int)(prodW * scale);
                        int drawH = (int)(prodH * scale);
                        int drawX = (canvasSize - drawW) / 2;
                        int drawY = (canvasSize - drawH) / 2;

                        g.DrawImage(prodBmp, new Rectangle(drawX, drawY, drawW, drawH));

                        using (var finalBmp = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                        {
                            for (int y = 0; y < canvasSize; y++)
                            {
                                for (int x = 0; x < canvasSize; x++)
                                {
                                    Color c = canvas.GetPixel(x, y);
                                    if (c.R >= 246 && c.G >= 246 && c.B >= 246)
                                    {
                                        finalBmp.SetPixel(x, y, Color.White);
                                    }
                                    else
                                    {
                                        int r = (int)((c.R - 128) * 1.20 + 128);
                                        int gVal = (int)((c.G - 128) * 1.20 + 128);
                                        int b = (int)((c.B - 128) * 1.20 + 128);

                                        r = Math.Min(255, Math.Max(0, r));
                                        gVal = Math.Min(255, Math.Max(0, gVal));
                                        b = Math.Min(255, Math.Max(0, b));

                                        finalBmp.SetPixel(x, y, Color.FromArgb(255, r, gVal, b));
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

                            finalBmp.Save(outputPath, jpgEncoder, encParams);
                        }
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

    [PureWhiteBatchProcessor]::CleanItem($srcPath, $outPathApi)
    Copy-Item $outPathApi $outPathFront -Force
}

Write-Host "Processed all 42 items with pure white background and watermark removal!"
