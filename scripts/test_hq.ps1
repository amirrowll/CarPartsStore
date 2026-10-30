Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Collections.Generic;

public class HighQualityProcessor
{
    public static void ProcessItem(string inputPath, string outputPath)
    {
        using (var src = new Bitmap(inputPath))
        {
            int w = src.Width;
            int h = src.Height;

            // Crop inner product area (exclude top badge and bottom title)
            int topLimit = (int)(h * 0.16);
            int bottomLimit = (int)(h * 0.82);
            int leftLimit = (int)(w * 0.08);
            int rightLimit = (int)(w * 0.92);

            // Find product bounding box
            int minX = w, maxX = 0, minY = h, maxY = 0;
            for (int y = topLimit; y < bottomLimit; y++)
            {
                for (int x = leftLimit; x < rightLimit; x++)
                {
                    Color px = src.GetPixel(x, y);
                    // Detect if pixel has color saturation or is darker than background
                    int maxC = Math.Max(px.R, Math.Max(px.G, px.B));
                    int minC = Math.Min(px.R, Math.Min(px.G, px.B));
                    int sat = maxC - minC;
                    int brightness = (px.R + px.G + px.B) / 3;

                    // If pixel is darker than 235 or has visible color (sat > 8)
                    if (brightness < 235 || sat > 8)
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
                minX = leftLimit; maxX = rightLimit; minY = topLimit; maxY = bottomLimit;
            }

            // Add 4px breathing room
            minX = Math.Max(0, minX - 4);
            maxX = Math.Min(w - 1, maxX + 4);
            minY = Math.Max(0, minY - 4);
            maxY = Math.Min(h - 1, maxY + 4);
            int pW = maxX - minX + 1;
            int pH = maxY - minY + 1;

            Rectangle cropRect = new Rectangle(minX, minY, pW, pH);
            using (var cropped = src.Clone(cropRect, PixelFormat.Format32bppArgb))
            {
                // Clean the background:
                // Scan from outer boundary inward using flood-fill
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

                    Color px = cropped.GetPixel(x, y);
                    int brightness = (px.R + px.G + px.B) / 3;
                    int sat = Math.Max(px.R, Math.Max(px.G, px.B)) - Math.Min(px.R, Math.Min(px.G, px.B));

                    // Background condition: very light and low saturation
                    if (brightness > 228 && sat < 18)
                    {
                        isBg[x, y] = true;
                        q.Enqueue(new Point(x + 1, y));
                        q.Enqueue(new Point(x - 1, y));
                        q.Enqueue(new Point(x, y + 1));
                        q.Enqueue(new Point(x, y - 1));
                    }
                }

                // Apply pure white to background pixels
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

                // Create square 500x500 white canvas
                int canvasSize = 500;
                using (var dest = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                using (var g = Graphics.FromImage(dest))
                {
                    g.Clear(Color.White);
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.SmoothingMode = SmoothingMode.HighQuality;
                    g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    g.CompositingQuality = CompositingQuality.HighQuality;

                    // Fit product inside 380x380
                    float scale = Math.Min(380f / pW, 380f / pH);
                    int drawW = (int)(pW * scale);
                    int drawH = (int)(pH * scale);
                    int drawX = (canvasSize - drawW) / 2;
                    int drawY = (canvasSize - drawH) / 2;

                    g.DrawImage(cropped, new Rectangle(drawX, drawY, drawW, drawH));

                    // Enhance contrast and sharpness on the product
                    using (var finalBmp = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                    {
                        for (int y = 0; y < canvasSize; y++)
                        {
                            for (int x = 0; x < canvasSize; x++)
                            {
                                Color c = dest.GetPixel(x, y);
                                if (c.R > 248 && c.G > 248 && c.B > 248)
                                {
                                    finalBmp.SetPixel(x, y, Color.White);
                                }
                                else
                                {
                                    // Slight gamma & contrast boost
                                    int r = (int)((c.R - 128) * 1.15 + 128);
                                    int gVal = (int)((c.G - 128) * 1.15 + 128);
                                    int b = (int)((c.B - 128) * 1.15 + 128);

                                    r = Math.Min(255, Math.Max(0, r));
                                    gVal = Math.Min(255, Math.Max(0, gVal));
                                    b = Math.Min(255, Math.Max(0, b));

                                    finalBmp.SetPixel(x, y, Color.FromArgb(255, r, gVal, b));
                                }
                            }
                        }

                        // Save JPEG at 98 quality
                        ImageCodecInfo jpgEncoder = null;
                        foreach (var codec in ImageCodecInfo.GetImageEncoders())
                        {
                            if (codec.MimeType == "image/jpeg")
                            {
                                jpgEncoder = codec;
                                break;
                            }
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
"@

Add-Type -TypeDefinition $csharp -ReferencedAssemblies "System.Drawing"

[HighQualityProcessor]::ProcessItem("extracted_items_page1\item_1001.jpg", "extracted_items_page1\hq_1001.jpg")
[HighQualityProcessor]::ProcessItem("extracted_items_page1\item_1005.jpg", "extracted_items_page1\hq_1005.jpg")
Write-Host "Processed hq_1001 and hq_1005"
