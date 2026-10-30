Add-Type -AssemblyName System.Drawing

$bmp = [System.Drawing.Bitmap]::FromFile("extracted_pages\page_1.jpg")

# 6 Columns:
# Col 0: Left ~ 119, Width ~ 296 -> Right 415
# Col 1: Left ~ 443, Width ~ 296 -> Right 739
# Col 2: Left ~ 767, Width ~ 296 -> Right 1063
# Col 3: Left ~ 1090, Width ~ 296 -> Right 1386
# Col 4: Left ~ 1414, Width ~ 296 -> Right 1710
# Col 5: Left ~ 1737, Width ~ 296 -> Right 2033

$cols = @(
    @{ Left = 119; Width = 296 },
    @{ Left = 442; Width = 296 },
    @{ Left = 766; Width = 296 },
    @{ Left = 1090; Width = 296 },
    @{ Left = 1414; Width = 296 },
    @{ Left = 1737; Width = 296 }
)

# 7 Rows:
# Let's verify top and height for each of the 7 rows
# Row 0: Top ~ 122, Height ~ 304 (or 350)
# Row 1: Top ~ 497, Height ~ 350
# Row 2: Top ~ 872, Height ~ 350
# Row 3: Top ~ 1244, Height ~ 350
# Row 4: Top ~ 1616, Height ~ 350
# Row 5: Top ~ 1988, Height ~ 350
# Row 6: Top ~ 2360, Height ~ 350

$rows = @(
    @{ Top = 122; Height = 350 },
    @{ Top = 496; Height = 350 },
    @{ Top = 870; Height = 350 },
    @{ Top = 1243; Height = 350 },
    @{ Top = 1616; Height = 350 },
    @{ Top = 1988; Height = 350 },
    @{ Top = 2360; Height = 350 }
)

$outDir = "extracted_items_page1"
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }

$idx = 1001
for ($r = 0; $r -lt 7; $r++) {
    for ($c = 0; $c -lt 6; $c++) {
        $left = $cols[$c].Left
        $width = $cols[$c].Width
        $top = $rows[$r].Top
        $height = $rows[$r].Height

        $rect = New-Object System.Drawing.Rectangle($left, $top, $width, $height)
        $cropped = $bmp.Clone($rect, $bmp.PixelFormat)

        # Save cropped box
        $savePath = Join-Path $outDir "item_${idx}.jpg"
        $cropped.Save($savePath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
        $cropped.Dispose()
        $idx++
    }
}

Write-Host "Cropped all 42 items successfully!"
$bmp.Dispose()
