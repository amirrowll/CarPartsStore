$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Collections.Generic;

public class ImageCleaner
{
    public static void CleanAndEnhance(string inputPath, string outputPath)
    {
        using (var src = new Bitmap(inputPath))
        {
            int w = src.Width;
            int h = src.Height;

            // 1. Crop the product area, ignoring top badge (0..65) and bottom text (h-70..h)
            int topLimit = (int)(h * 0.18);
            int bottomLimit = (int)(h * 0.80);
            int leftLimit = (int)(w * 0.08);
            int rightLimit = (int)(w * 0.92);

            int minX = w, maxX = 0, minY = h, maxY = 0;
            for (int y = topLimit; y < bottomLimit; y++)
            {
                for (int x = leftLimit; x < rightLimit; x++)
                {
                    Color px = src.GetPixel(x, y);
                    // Check if not white background (scan background typically has R,G,B > 225)
                    bool isBg = (px.R > 225 && px.G > 225 && px.B > 225);
                    if (!isBg)
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

            // Margin
            minX = Math.Max(0, minX - 6);
            maxX = Math.Min(w - 1, maxX + 6);
            minY = Math.Max(0, minY - 6);
            maxY = Math.Min(h - 1, maxY + 6);
            int pW = maxX - minX + 1;
            int pH = maxY - minY + 1;

            Rectangle cropRect = new Rectangle(minX, minY, pW, pH);
            using (var cropped = src.Clone(cropRect, PixelFormat.Format32bppArgb))
            {
                // Flood-fill from borders to make outer background 100% pure white (#FFFFFF)
                bool[,] visited = new bool[pW, pH];
                Queue<Point> queue = new Queue<Point>();

                for (int x = 0; x < pW; x++)
                {
                    queue.Enqueue(new Point(x, 0));
                    queue.Enqueue(new Point(x, pH - 1));
                }
                for (int y = 0; y < pH; y++)
                {
                    queue.Enqueue(new Point(0, y));
                    queue.Enqueue(new Point(pW - 1, y));
                }

                while (queue.Count > 0)
                {
                    Point pt = queue.Dequeue();
                    int x = pt.X;
                    int y = pt.Y;

                    if (x < 0 || x >= pW || y < 0 || y >= pH) continue;
                    if (visited[x, y]) continue;
                    visited[x, y] = true;

                    Color c = cropped.GetPixel(x, y);
                    // If it's a light background pixel
                    if (c.R > 215 && c.G > 215 && c.B > 215)
                    {
                        cropped.SetPixel(x, y, Color.White);

                        queue.Enqueue(new Point(x + 1, y));
                        queue.Enqueue(new Point(x - 1, y));
                        queue.Enqueue(new Point(x, y + 1));
                        queue.Enqueue(new Point(x, y - 1));
                    }
                }

                // Create square studio canvas (500x500)
                int canvasSize = 500;
                using (var canvas = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                using (var g = Graphics.FromImage(canvas))
                {
                    g.Clear(Color.White);
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.SmoothingMode = SmoothingMode.HighQuality;
                    g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    g.CompositingQuality = CompositingQuality.HighQuality;

                    int targetDim = 380;
                    float scale = Math.Min((float)targetDim / pW, (float)targetDim / pH);
                    scale = Math.Min(2.0f, scale); // prevent excessive blur

                    int drawW = (int)(pW * scale);
                    int drawH = (int)(pH * scale);
                    int drawX = (canvasSize - drawW) / 2;
                    int drawY = (canvasSize - drawH) / 2;

                    g.DrawImage(cropped, new Rectangle(drawX, drawY, drawW, drawH));

                    // Enhance contrast and sharpness on non-white pixels
                    using (var result = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                    {
                        for (int y = 0; y < canvasSize; y++)
                        {
                            for (int x = 0; x < canvasSize; x++)
                            {
                                Color c = canvas.GetPixel(x, y);
                                if (c.R > 245 && c.G > 245 && c.B > 245)
                                {
                                    result.SetPixel(x, y, Color.White);
                                }
                                else
                                {
                                    // S-curve contrast boost
                                    int r = (int)((c.R - 128) * 1.35 + 128);
                                    int gVal = (int)((c.G - 128) * 1.35 + 128);
                                    int b = (int)((c.B - 128) * 1.35 + 128);

                                    r = Math.Min(255, Math.Max(0, r));
                                    gVal = Math.Min(255, Math.Max(0, gVal));
                                    b = Math.Min(255, Math.Max(0, b));

                                    result.SetPixel(x, y, Color.FromArgb(255, r, gVal, b));
                                }
                            }
                        }

                        // Save as JPEG with 98 quality
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
                        result.Save(outputPath, jpgEncoder, encParams);
                    }
                }
            }
        }
    }
}
"@

Add-Type -TypeDefinition $csharp -ReferencedAssemblies "System.Drawing"

[ImageCleaner]::CleanAndEnhance("extracted_items_page1\item_1001.jpg", "extracted_items_page1\csharp_1001.jpg")
[ImageCleaner]::CleanAndEnhance("extracted_items_page1\item_1005.jpg", "extracted_items_page1\csharp_1005.jpg")
Write-Host "C# ImageCleaner executed successfully!"
