Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Collections.Generic;

public class MorphoCleaner
{
    public static void Clean(string inputPath, string outputPath)
    {
        using (var src = new Bitmap(inputPath))
        {
            int w = src.Width;
            int h = src.Height;

            // Crop inner box (exclude top badge number and bottom Persian text)
            int top = (int)(h * 0.17);
            int bottom = (int)(h * 0.78);
            int left = (int)(w * 0.10);
            int right = (int)(w * 0.90);

            int pW = right - left;
            int pH = bottom - top;

            Rectangle rect = new Rectangle(left, top, pW, pH);
            using (var cropped = src.Clone(rect, PixelFormat.Format32bppArgb))
            {
                // Step 1: Detect product pixels (anything darker than clean paper or with color)
                bool[,] isForeground = new bool[pW, pH];
                for (int y = 0; y < pH; y++)
                {
                    for (int x = 0; x < pW; x++)
                    {
                        Color c = cropped.GetPixel(x, y);
                        int lum = (int)(0.299 * c.R + 0.587 * c.G + 0.114 * c.B);
                        int sat = Math.Max(c.R, Math.Max(c.G, c.B)) - Math.Min(c.R, Math.Min(c.G, c.B));

                        // Pink watermark check
                        bool isPink = (c.R > 215 && (c.R - c.G >= 5 || c.R - c.B >= 5) && c.G > 180 && c.B > 180);

                        if (!isPink && (lum < 236 || sat > 9))
                        {
                            isForeground[x, y] = true;
                        }
                    }
                }

                // Step 2: Morphological Dilation (expand foreground by 3 pixels to close white-edge gaps)
                bool[,] barrier = new bool[pW, pH];
                int radius = 3;
                for (int y = 0; y < pH; y++)
                {
                    for (int x = 0; x < pW; x++)
                    {
                        if (isForeground[x, y])
                        {
                            for (int dy = -radius; dy <= radius; dy++)
                            {
                                for (int dx = -radius; dx <= radius; dx++)
                                {
                                    int nx = x + dx;
                                    int ny = y + dy;
                                    if (nx >= 0 && nx < pW && ny >= 0 && ny < pH)
                                    {
                                        barrier[nx, ny] = true;
                                    }
                                }
                            }
                        }
                    }
                }

                // Step 3: Flood fill background from borders outside barrier
                bool[,] isBg = new bool[pW, pH];
                Queue<Point> q = new Queue<Point>();

                for (int x = 0; x < pW; x++)
                {
                    if (!barrier[x, 0]) q.Enqueue(new Point(x, 0));
                    if (!barrier[x, pH - 1]) q.Enqueue(new Point(x, pH - 1));
                }
                for (int y = 0; y < pH; y++)
                {
                    if (!barrier[0, y]) q.Enqueue(new Point(0, y));
                    if (!barrier[pW - 1, y]) q.Enqueue(new Point(pW - 1, y));
                }

                while (q.Count > 0)
                {
                    Point pt = q.Dequeue();
                    int x = pt.X;
                    int y = pt.Y;

                    if (x < 0 || x >= pW || y < 0 || y >= pH) continue;
                    if (isBg[x, y]) continue;
                    if (barrier[x, y]) continue; // Blocked by product barrier!

                    isBg[x, y] = true;
                    q.Enqueue(new Point(x + 1, y));
                    q.Enqueue(new Point(x - 1, y));
                    q.Enqueue(new Point(x, y + 1));
                    q.Enqueue(new Point(x, y - 1));
                }

                // Also mark any pixel outside foreground with lum > 230 or pink as bg
                for (int y = 0; y < pH; y++)
                {
                    for (int x = 0; x < pW; x++)
                    {
                        Color c = cropped.GetPixel(x, y);
                        bool isPink = (c.R > 215 && (c.R - c.G >= 5 || c.R - c.B >= 5) && c.G > 180 && c.B > 180);
                        if (isBg[x, y] || (!isForeground[x, y] && isPink))
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

                minX = Math.Max(0, minX - 4);
                maxX = Math.Min(pW - 1, maxX + 4);
                minY = Math.Max(0, minY - 4);
                maxY = Math.Min(pH - 1, maxY + 4);

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

                        // Edge sharpen product
                        using (var finalBmp = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                        {
                            for (int y = 0; y < canvasSize; y++)
                            {
                                for (int x = 0; x < canvasSize; x++)
                                {
                                    Color c = canvas.GetPixel(x, y);
                                    if (c.R >= 253 && c.G >= 253 && c.B >= 253)
                                    {
                                        finalBmp.SetPixel(x, y, Color.White);
                                    }
                                    else if (x > 1 && x < canvasSize - 2 && y > 1 && y < canvasSize - 2)
                                    {
                                        Color cU = canvas.GetPixel(x, y - 1);
                                        Color cD = canvas.GetPixel(x, y + 1);
                                        Color cL = canvas.GetPixel(x - 1, y);
                                        Color cR = canvas.GetPixel(x + 1, y);

                                        int r = (int)(c.R * 1.8f - (cU.R + cD.R + cL.R + cR.R) * 0.20f);
                                        int gVal = (int)(c.G * 1.8f - (cU.G + cD.G + cL.G + cR.G) * 0.20f);
                                        int b = (int)(c.B * 1.8f - (cU.B + cD.B + cL.B + cR.B) * 0.20f);

                                        r = (int)((r - 128) * 1.20f + 128);
                                        gVal = (int)((gVal - 128) * 1.20f + 128);
                                        b = (int)((b - 128) * 1.20f + 128);

                                        r = Math.Min(255, Math.Max(0, r));
                                        gVal = Math.Min(255, Math.Max(0, gVal));
                                        b = Math.Min(255, Math.Max(0, b));

                                        finalBmp.SetPixel(x, y, Color.FromArgb(255, r, gVal, b));
                                    }
                                    else
                                    {
                                        finalBmp.SetPixel(x, y, c);
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

[MorphoCleaner]::Clean("extracted_items_page1\item_1005.jpg", "extracted_items_page1\morpho_1005.jpg")
Write-Host "MorphoCleaner 1005 complete!"
