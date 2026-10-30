Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Collections.Generic;

public class PureWhiteCleaner
{
    public static void Clean(string inputPath, string outputPath)
    {
        using (var src = new Bitmap(inputPath))
        {
            int w = src.Width;
            int h = src.Height;

            // Inner product bounds (exclude top badge and bottom text)
            int top = (int)(h * 0.16);
            int bottom = (int)(h * 0.81);
            int left = (int)(w * 0.08);
            int right = (int)(w * 0.92);

            int pW = right - left;
            int pH = bottom - top;

            Rectangle rect = new Rectangle(left, top, pW, pH);
            using (var cropped = src.Clone(rect, PixelFormat.Format32bppArgb))
            {
                // Flood fill from all 4 borders to remove paper, pink watermark, and grey watermark
                bool[,] visited = new bool[pW, pH];
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
                    if (visited[x, y]) continue;
                    visited[x, y] = true;

                    Color c = cropped.GetPixel(x, y);

                    // Watermark / background conditions:
                    // 1. Normal white/grey paper: R>215 && G>215 && B>215
                    // 2. Pink watermark: R>225 && G>200 && B>200
                    // 3. Faint grey watermark: (R+G+B)/3 > 210
                    bool isBackgroundOrWatermark = 
                        (c.R > 212 && c.G > 212 && c.B > 212) ||
                        (c.R > 220 && c.G > 195 && c.B > 195) ||
                        ((c.R + c.G + c.B) / 3 > 215);

                    if (isBackgroundOrWatermark)
                    {
                        cropped.SetPixel(x, y, Color.White);

                        q.Enqueue(new Point(x + 1, y));
                        q.Enqueue(new Point(x - 1, y));
                        q.Enqueue(new Point(x, y + 1));
                        q.Enqueue(new Point(x, y - 1));
                    }
                }

                // Also clean any leftover isolated watermark pixels in the background
                for (int y = 0; y < pH; y++)
                {
                    for (int x = 0; x < pW; x++)
                    {
                        Color c = cropped.GetPixel(x, y);
                        // If it's pink watermark (high R, lower G/B, high overall brightness)
                        if (c.R > 225 && c.G > 200 && c.B > 200 && c.R - Math.Min(c.G, c.B) < 35 && (c.R+c.G+c.B)/3 > 218)
                        {
                            cropped.SetPixel(x, y, Color.White);
                        }
                        else if ((c.R + c.G + c.B) / 3 > 235)
                        {
                            cropped.SetPixel(x, y, Color.White);
                        }
                    }
                }

                // Now find the actual trimmed bounding box of the product
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
                    // Render in 500x500 100% pure white canvas
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

                        // Final pass: ensure EVERY single background pixel is strictly #FFFFFF (255, 255, 255)
                        using (var finalBmp = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                        {
                            for (int y = 0; y < canvasSize; y++)
                            {
                                for (int x = 0; x < canvasSize; x++)
                                {
                                    Color c = canvas.GetPixel(x, y);
                                    if (c.R >= 244 && c.G >= 244 && c.B >= 244)
                                    {
                                        finalBmp.SetPixel(x, y, Color.White);
                                    }
                                    else
                                    {
                                        // Slight contrast enhancement on product
                                        int r = (int)((c.R - 128) * 1.22 + 128);
                                        int gVal = (int)((c.G - 128) * 1.22 + 128);
                                        int b = (int)((c.B - 128) * 1.22 + 128);

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

[PureWhiteCleaner]::Clean("extracted_items_page1\item_1032.jpg", "extracted_items_page1\white_1032.jpg")
[PureWhiteCleaner]::Clean("extracted_items_page1\item_1033.jpg", "extracted_items_page1\white_1033.jpg")
Write-Host "Processed white 1032 and 1033"
