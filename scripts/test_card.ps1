Add-Type -AssemblyName System.Drawing

$csharp = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

public class CardEnhancer
{
    public static void EnhanceCard(string inputPath, string outputPath)
    {
        using (var src = new Bitmap(inputPath))
        {
            int w = src.Width;
            int h = src.Height;

            // Target 600x700 high quality canvas
            int targetW = 600;
            int targetH = (int)((float)h / w * targetW);

            using (var dest = new Bitmap(targetW, targetH, PixelFormat.Format32bppRgb))
            using (var g = Graphics.FromImage(dest))
            {
                g.Clear(Color.White);
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                g.SmoothingMode = SmoothingMode.HighQuality;
                g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                g.CompositingQuality = CompositingQuality.HighQuality;

                g.DrawImage(src, new Rectangle(0, 0, targetW, targetH));

                // Process pixels:
                // 1. Turn all near-white background outside and inside into pure 255,255,255
                // 2. Enhance dark text and colorful product
                using (var result = new Bitmap(targetW, targetH, PixelFormat.Format32bppRgb))
                {
                    for (int y = 0; y < targetH; y++)
                    {
                        for (int x = 0; x < targetW; x++)
                        {
                            Color c = dest.GetPixel(x, y);

                            // Background threshold: if brightness > 232 and saturation < 15, make pure white
                            int max = Math.Max(c.R, Math.Max(c.G, c.B));
                            int min = Math.Min(c.R, Math.Min(c.G, c.B));
                            int sat = max - min;
                            int brightness = (c.R + c.G + c.B) / 3;

                            if (brightness > 230 && sat < 18)
                            {
                                result.SetPixel(x, y, Color.White);
                            }
                            else if (brightness < 100)
                            {
                                // Deepen text and dark parts (enhance sharpness of text 1001 and title)
                                int r = (int)(c.R * 0.7);
                                int gVal = (int)(c.G * 0.7);
                                int b = (int)(c.B * 0.7);
                                result.SetPixel(x, y, Color.FromArgb(255, r, gVal, b));
                            }
                            else
                            {
                                // Contrast boost on the product
                                int r = (int)((c.R - 128) * 1.25 + 128);
                                int gVal = (int)((c.G - 128) * 1.25 + 128);
                                int b = (int)((c.B - 128) * 1.25 + 128);

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
"@

Add-Type -TypeDefinition $csharp -ReferencedAssemblies "System.Drawing"

[CardEnhancer]::EnhanceCard("extracted_items_page1\item_1001.jpg", "extracted_items_page1\card_1001.jpg")
Write-Host "Card 1001 generated"
