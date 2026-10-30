Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Collections.Generic;

public class SmartClipCleaner
{
    public static void Clean(string inputPath, string outputPath)
    {
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
                // Compute gradient magnitude (edges) to prevent leaking into white parts
                float[,] grad = new float[pW, pH];
                for (int y = 1; y < pH - 1; y++)
                {
                    for (int x = 1; x < pW - 1; x++)
                    {
                        Color cL = cropped.GetPixel(x - 1, y);
                        Color cR = cropped.GetPixel(x + 1, y);
                        Color cU = cropped.GetPixel(x, y - 1);
                        Color cD = cropped.GetPixel(x, y + 1);

                        int lumL = (int)(0.299 * cL.R + 0.587 * cL.G + 0.114 * cL.B);
                        int lumR = (int)(0.299 * cR.R + 0.587 * cR.G + 0.114 * cR.B);
                        int lumU = (int)(0.299 * cU.R + 0.587 * cU.G + 0.114 * cU.B);
                        int lumD = (int)(0.299 * cD.R + 0.587 * cD.G + 0.114 * cD.B);

                        grad[x, y] = (float)Math.Sqrt((lumR - lumL) * (lumR - lumL) + (lumD - lumU) * (lumD - lumU));
                    }
                }

                // Flood fill background from all 4 borders
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

                    // Pink watermark:
                    bool isPink = (c.R > 208 && (c.R - c.G >= 4 || c.R - c.B >= 4) && c.G > 170 && c.B > 170);
                    // Light paper background
                    bool isLight = (c.R > 235 && c.G > 235 && c.B > 235);
                    // Subtle grey watermark
                    bool isGreyWm = ((c.R + c.G + c.B) / 3 > 222 && Math.Abs(c.R - c.G) < 8 && Math.Abs(c.G - c.B) < 8);

                    // Stop flood fill if we hit a strong edge (clip contour)
                    if (grad[x, y] > 18.0f && !isPink)
                    {
                        continue;
                    }

                    if (isPink || isLight || isGreyWm)
                    {
                        isBg[x, y] = true;
                        q.Enqueue(new Point(x + 1, y));
                        q.Enqueue(new Point(x - 1, y));
                        q.Enqueue(new Point(x, y + 1));
                        q.Enqueue(new Point(x, y - 1));
                    }
                }

                // Whiten background
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

                        // Edge-sharpening with protection for white product
                        using (var finalBmp = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                        {
                            for (int y = 0; y < canvasSize; y++)
                            {
                                for (int x = 0; x < canvasSize; x++)
                                {
                                    Color c = canvas.GetPixel(x, y);
                                    if (c.R == 255 && c.G == 255 && c.B == 255)
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

                                        r = (int)((r - 128) * 1.22f + 128);
                                        gVal = (int)((gVal - 128) * 1.22f + 128);
                                        b = (int)((b - 128) * 1.22f + 128);

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

[SmartClipCleaner]::Clean("extracted_items_page1\item_1005.jpg", "extracted_items_page1\smart_1005.jpg")
[SmartClipCleaner]::Clean("extracted_items_page1\item_1001.jpg", "extracted_items_page1\smart_1001.jpg")
[SmartClipCleaner]::Clean("extracted_items_page1\item_1033.jpg", "extracted_items_page1\smart_1033.jpg")
Write-Host "SmartClipCleaner test complete!"
