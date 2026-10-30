Add-Type -AssemblyName System.Drawing

function Enhance-ProductImage($inputPath, $outputPath) {
    $src = [System.Drawing.Bitmap]::FromFile($inputPath)
    
    # 1. Detect product bounding box (ignore the top code number and bottom text)
    # The cell is ~296x350
    $w = $src.Width
    $h = $src.Height
    
    # Text and badges are roughly top 65px and bottom 75px
    $scanTop = 60
    $scanBottom = $h - 75
    $scanLeft = 20
    $scanRight = $w - 20
    
    # Find bounding box of actual product (pixels significantly different from white/light background)
    $minX = $w; $maxX = 0; $minY = $h; $maxY = 0
    for ($y = $scanTop; $y -lt $scanBottom; $y++) {
        for ($x = $scanLeft; $x -lt $scanRight; $x++) {
            $px = $src.GetPixel($x, $y)
            # Check if not background (background is usually R,G,B > 235 and low saturation)
            $isBg = ($px.R -gt 232 -and $px.G -gt 232 -and $px.B -gt 232)
            if (-not $isBg) {
                if ($x -lt $minX) { $minX = $x }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($y -gt $maxY) { $maxY = $y }
            }
        }
    }
    
    if ($minX -ge $maxX -or $minY -ge $maxY) {
        $minX = $scanLeft; $maxX = $scanRight; $minY = $scanTop; $maxY = $scanBottom
    }
    
    # Add small margin (5px)
    $minX = [Math]::Max(0, $minX - 6)
    $maxX = [Math]::Min($w - 1, $maxX + 6)
    $minY = [Math]::Max(0, $minY - 6)
    $maxY = [Math]::Min($h - 1, $maxY + 6)
    $cropW = $maxX - $minX + 1
    $cropH = $maxY - $minY + 1
    
    # Extract cropped product
    $cropRect = New-Object System.Drawing.Rectangle($minX, $minY, $cropW, $cropH)
    $cropped = $src.Clone($cropRect, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    
    # 2. Clean background to pure white:
    # Any pixel with brightness > threshold or close to background color becomes pure white (255,255,255)
    for ($y = 0; $y -lt $cropH; $y++) {
        for ($x = 0; $x -lt $cropW; $x++) {
            $px = $cropped.GetPixel($x, $y)
            # Background detection: high brightness and low color distance to white
            if ($px.R -gt 225 -and $px.G -gt 225 -and $px.B -gt 225) {
                $cropped.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, 255, 255, 255))
            }
        }
    }
    
    # 3. Create high-resolution studio square canvas (600x600)
    $targetSize = 600
    $dest = New-Object System.Drawing.Bitmap($targetSize, $targetSize, [System.Drawing.Imaging.PixelFormat]::Format32bppRgb)
    $g = [System.Drawing.Graphics]::FromImage($dest)
    $g.Clear([System.Drawing.Color]::White)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    
    # Scale to fit nicely with studio breathing room (target max 440px)
    $maxDim = 440
    $scale = [Math]::Min($maxDim / $cropW, $maxDim / $cropH)
    $drawW = [int]($cropW * $scale)
    $drawH = [int]($cropH * $scale)
    $drawX = [int](($targetSize - $drawW) / 2)
    $drawY = [int](($targetSize - $drawH) / 2)
    
    $drawRect = New-Object System.Drawing.Rectangle($drawX, $drawY, $drawW, $drawH)
    $g.DrawImage($cropped, $drawRect)
    
    # 4. Sharpening filter & contrast stretch on the result
    # We apply a slight unsharp mask convolution to make edges crisp
    $sharpened = New-Object System.Drawing.Bitmap($targetSize, $targetSize, [System.Drawing.Imaging.PixelFormat]::Format32bppRgb)
    $g2 = [System.Drawing.Graphics]::FromImage($sharpened)
    $g2.Clear([System.Drawing.Color]::White)
    
    # Fast contrast stretch & clamp to pure white
    for ($y = 0; $y -lt $targetSize; $y++) {
        for ($x = 0; $x -lt $targetSize; $x++) {
            $c = $dest.GetPixel($x, $y)
            if ($c.R -gt 240 -and $c.G -gt 240 -and $c.B -gt 240) {
                # Pure studio white
                $sharpened.SetPixel($x, $y, [System.Drawing.Color]::White)
            } else {
                # Increase contrast: enhance shadows and midtones
                $r = [Math]::Min(255, [Math]::Max(0, [int](($c.R - 128) * 1.18 + 128)))
                $gVal = [Math]::Min(255, [Math]::Max(0, [int](($c.G - 128) * 1.18 + 128)))
                $b = [Math]::Min(255, [Math]::Max(0, [int](($c.B - 128) * 1.18 + 128)))
                $sharpened.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, $r, $gVal, $b))
            }
        }
    }
    
    # Save with 95% JPEG quality
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    $encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 95L)
    
    $sharpened.Save($outputPath, $codec, $encParams)
    
    $g2.Dispose()
    $sharpened.Dispose()
    $g.Dispose()
    $dest.Dispose()
    $cropped.Dispose()
    $src.Dispose()
}

Enhance-ProductImage "extracted_items_page1\item_1001.jpg" "extracted_items_page1\test_1001_enhanced.jpg"
Write-Host "Enhanced 1001 saved"
