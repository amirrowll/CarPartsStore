Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

public class Perfect1005
{
    public static void Enhance(string inputPath, string outputPath)
    {
        using (var src = new Bitmap(inputPath))
        {
            int w = src.Width;
            int h = src.Height;

            // Accurate bounding box for clip 1005: x: 70..250, y: 75..245
            int minX = 75, maxX = 245, minY = 75, maxY = 240;
            int pW = maxX - minX + 1;
            int pH = maxY - minY + 1;

            Rectangle rect = new Rectangle(minX, minY, pW, pH);
            using (var cropped = src.Clone(rect, PixelFormat.Format32bppArgb))
            {
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

                    using (var finalBmp = new Bitmap(canvasSize, canvasSize, PixelFormat.Format32bppRgb))
                    {
                        for (int y = 0; y < canvasSize; y++)
                        {
                            for (int x = 0; x < canvasSize; x++)
                            {
                                Color c = dest.GetPixel(x, y);

                                // Check if outside the product drawing area
                                if (x < drawX - 2 || x > drawX + drawW + 2 || y < drawY - 2 || y > drawY + drawH + 2)
                                {
                                    finalBmp.SetPixel(x, y, Color.White);
                                    continue;
                                }

                                // Pink watermark detection:
                                bool isPink = (c.R > 215 && (c.R - c.G >= 5 || c.R - c.B >= 5) && c.G > 180 && c.B > 180);
                                // Pure background around the clip (outside clip contour)
                                int lum = (int)(0.299 * c.R + 0.587 * c.G + 0.114 * c.B);
                                int sat = Math.Max(c.R, Math.Max(c.G, c.B)) - Math.Min(c.R, Math.Min(c.G, c.B));

                                // Distance from center of drawing
                                float cX = drawX + drawW * 0.48f;
                                float cY = drawY + drawH * 0.52f;
                                float dist = (float)Math.Sqrt((x - cX) * (x - cX) + (y - cY) * (y - cY));

                                if (dist > 210 || isPink || (lum > 248 && sat < 6 && dist > 140))
                                {
                                    finalBmp.SetPixel(x, y, Color.White);
                                }
                                else
                                {
                                    // Enhance nylon contrast
                                    int r = (int)((c.R - 128) * 1.35f + 128);
                                    int gVal = (int)((c.G - 128) * 1.35f + 128);
                                    int b = (int)((c.B - 128) * 1.35f + 128);

                                    r = Math.Min(255, Math.Max(0, r));
                                    gVal = Math.Min(255, Math.Max(0, gVal));
                                    b = Math.Min(255, Math.Max(0, b));

                                    if (r >= 252 && gVal >= 252 && b >= 252 && dist > 130)
                                        finalBmp.SetPixel(x, y, Color.White);
                                    else
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
                        encParams.Param[0] = new EncoderParameter(Encoder.Quality, 99L);

                        finalBmp.Save(outputPath, jpgEncoder, encParams);
                    }
                }
            }
        }
    }
}
"@

Add-Type -TypeDefinition $csharp -ReferencedAssemblies "System.Drawing"

$out1 = "CarPartsStore.API\wwwroot\uploads\products\pinpart-1005.jpg"
$out2 = "carpartsstore-frontend\public\uploads\products\pinpart-1005.jpg"
$out3 = "carpartsstore-frontend\dist\uploads\products\pinpart-1005.jpg"

[Perfect1005]::Enhance("extracted_items_page1\item_1005.jpg", $out1)
Copy-Item $out1 $out2 -Force
Copy-Item $out1 $out3 -Force
Write-Host "Perfected 1005!"
