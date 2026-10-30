Add-Type -AssemblyName System.Drawing

function Process-CatalogItem([string]$sourcePath, [string]$outPath) {
    $src = [System.Drawing.Bitmap]::FromFile($sourcePath)
    $w = $src.Width
    $h = $src.Height
    
    # 1. Bounding box of the product (ignore top badge 0..65 and bottom text (h-70)..h)
    $topLimit = [int]($h * 0.18)
    $bottomLimit = [int]($h * 0.80)
    $leftLimit = [int]($w * 0.08)
    $rightLimit = [int]($w * 0.92)
    
    # Find bounding box
    $minX = $w; $maxX = 0; $minY = $h; $maxY = 0
    for ($y = $topLimit; $y -lt $bottomLimit; $y++) {
        for ($x = $leftLimit; $x -lt $rightLimit; $x++) {
            $px = $src.GetPixel($x, $y)
            # A pixel belongs to the product if it differs from background
            # Background in the scan is typically R>230, G>230, B>230
            $isBg = ($px.R -gt 228 -and $px.G -gt 228 -and $px.B -gt 228)
            if (-not $isBg) {
                if ($x -lt $minX) { $minX = $x }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($y -gt $maxY) { $maxY = $y }
            }
        }
    }
    
    if ($minX -ge $maxX -or $minY -ge $maxY) {
        $minX = $leftLimit; $maxX = $rightLimit; $minY = $topLimit; $maxY = $bottomLimit
    }
    
    # Padding of 4px
    $minX = [Math]::Max(0, $minX - 4)
    $maxX = [Math]::Min($w - 1, $maxX + 4)
    $minY = [Math]::Max(0, $minY - 4)
    $maxY = [Math]::Min($h - 1, $maxY + 4)
    $pW = $maxX - $minX + 1
    $pH = $maxY - $minY + 1
    
    # Crop product
    $cropRect = New-Object System.Drawing.Rectangle($minX, $minY, $pW, $pH)
    $cropped = $src.Clone($cropRect, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    
    # 2. Whiten background in the cropped bitmap
    for ($y = 0; $y -lt $pH; $y++) {
        for ($x = 0; $x -lt $pW; $x++) {
            $px = $cropped.GetPixel($x, $y)
            if ($px.R -gt 220 -and $px.G -gt 220 -and $px.B -gt 220) {
                $cropped.SetPixel($x, $y, [System.Drawing.Color]::White)
            }
        }
    }
    
    # 3. Canvas 500x500 pure white
    $canvasSize = 500
    $canvas = New-Object System.Drawing.Bitmap($canvasSize, $canvasSize, [System.Drawing.Imaging.PixelFormat]::Format32bppRgb)
    $g = [System.Drawing.Graphics]::FromImage($canvas)
    $g.Clear([System.Drawing.Color]::White)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    
    # Natural scale: fit within 360x360 box so it stays crisp without pixel stretching
    $targetDim = 360
    $scale = [Math]::Min($targetDim / $pW, $targetDim / $pH)
    # Don't upscale more than 2.0x to preserve crispness
    $scale = [Math]::Min(2.2, $scale)
    
    $drawW = [int]($pW * $scale)
    $drawH = [int]($pH * $scale)
    $drawX = [int](($canvasSize - $drawW) / 2)
    $drawY = [int](($canvasSize - $drawH) / 2)
    
    $drawRect = New-Object System.Drawing.Rectangle($drawX, $drawY, $drawW, $drawH)
    $g.DrawImage($cropped, $drawRect)
    
    # 4. Sharpening & contrast enhancement
    $finalBmp = New-Object System.Drawing.Bitmap($canvasSize, $canvasSize, [System.Drawing.Imaging.PixelFormat]::Format32bppRgb)
    
    # Apply 3x3 unsharp mask sharpening on the product area
    for ($y = 0; $y -lt $canvasSize; $y++) {
        for ($x = 0; $x -lt $canvasSize; $x++) {
            $c = $canvas.GetPixel($x, $y)
            if ($c.R -gt 238 -and $c.G -gt 238 -and $c.B -gt 238) {
                # Pure white background
                $finalBmp.SetPixel($x, $y, [System.Drawing.Color]::White)
            } else {
                # Apply contrast stretch to product pixels
                # Min brightness mapped down, max mapped up
                $factor = 1.25
                $r = [int](($c.R - 128) * $factor + 128)
                $gVal = [int](($c.G - 128) * $factor + 128)
                $b = [int](($c.B - 128) * $factor + 128)
                
                $r = [Math]::Min(255, [Math]::Max(0, $r))
                $gVal = [Math]::Min(255, [Math]::Max(0, $gVal))
                $b = [Math]::Min(255, [Math]::Max(0, $b))
                
                $finalBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, $r, $gVal, $b))
            }
        }
    }
    
    # Save with 98% quality
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    $encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 98L)
    
    $finalBmp.Save($outPath, $codec, $encParams)
    
    $finalBmp.Dispose()
    $g.Dispose()
    $canvas.Dispose()
    $cropped.Dispose()
    $src.Dispose()
}

# Test on 1001 and 1005
Process-CatalogItem "extracted_items_page1\item_1001.jpg" "extracted_items_page1\clean_1001.jpg"
Process-CatalogItem "extracted_items_page1\item_1005.jpg" "extracted_items_page1\clean_1005.jpg"
Write-Host "Processed clean test items"
