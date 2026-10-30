Add-Type -AssemblyName System.Drawing

$pagePath = "extracted_pages\page_1.jpg"
if (-not (Test-Path $pagePath)) {
    Write-Host "Page 1 not found!"
    exit 1
}

$bmp = [System.Drawing.Bitmap]::FromFile($pagePath)

# 6 Columns with exact pixel boundaries
$cols = @(
    @{ Left = 119; Width = 296 },
    @{ Left = 442; Width = 296 },
    @{ Left = 766; Width = 296 },
    @{ Left = 1090; Width = 296 },
    @{ Left = 1414; Width = 296 },
    @{ Left = 1737; Width = 296 }
)

# 7 Rows with exact pixel boundaries
$rows = @(
    @{ Top = 122; Height = 350 },
    @{ Top = 496; Height = 350 },
    @{ Top = 870; Height = 350 },
    @{ Top = 1243; Height = 350 },
    @{ Top = 1616; Height = 350 },
    @{ Top = 1988; Height = 350 },
    @{ Top = 2360; Height = 350 }
)

$destDirApi = "CarPartsStore.API\wwwroot\uploads\products"
$destDirFront = "carpartsstore-frontend\public\uploads\products"
if (-not (Test-Path $destDirApi)) { New-Item -ItemType Directory -Path $destDirApi -Force | Out-Null }
if (-not (Test-Path $destDirFront)) { New-Item -ItemType Directory -Path $destDirFront -Force | Out-Null }

$idx = 1001
for ($r = 0; $r -lt 7; $r++) {
    for ($c = 0; $c -lt 6; $c++) {
        $left = $cols[$c].Left
        $width = $cols[$c].Width
        $top = $rows[$r].Top
        $height = $rows[$r].Height

        $cellRect = New-Object System.Drawing.Rectangle($left, $top, $width, $height)
        $cellBmp = $bmp.Clone($cellRect, $bmp.PixelFormat)

        # 1. Save framed catalog version
        $catalogPathApi = Join-Path $destDirApi "pinpart-${idx}-catalog.jpg"
        $catalogPathFront = Join-Path $destDirFront "pinpart-${idx}-catalog.jpg"
        $cellBmp.Save($catalogPathApi, [System.Drawing.Imaging.ImageFormat]::Jpeg)
        $cellBmp.Save($catalogPathFront, [System.Drawing.Imaging.ImageFormat]::Jpeg)

        # 2. Extract inner product (excluding top badge number and bottom text label)
        # Inner bounding box roughly: X: 30 to width-30, Y: 60 to height-75
        $innerLeft = 30
        $innerTop = 60
        $innerWidth = $width - 60
        $innerHeight = $height - 135

        # Find actual product bounding box within inner region
        $pMinX = $width; $pMaxX = 0; $pMinY = $height; $pMaxY = 0
        for ($y = $innerTop; $y -lt ($innerTop + $innerHeight); $y++) {
            for ($x = $innerLeft; $x -lt ($innerLeft + $innerWidth); $x++) {
                $px = $cellBmp.GetPixel($x, $y)
                # Check if not pure white/light grey background
                if ($px.R -lt 242 -or $px.G -lt 242 -or $px.B -lt 242) {
                    if ($x -lt $pMinX) { $pMinX = $x }
                    if ($x -gt $pMaxX) { $pMaxX = $x }
                    if ($y -lt $pMinY) { $pMinY = $y }
                    if ($y -gt $pMaxY) { $pMaxY = $y }
                }
            }
        }

        # If product found, add 15px margin
        if ($pMinX -lt $pMaxX -and $pMinY -lt $pMaxY) {
            $pMinX = [Math]::Max(5, $pMinX - 15)
            $pMaxX = [Math]::Min($width - 5, $pMaxX + 15)
            $pMinY = [Math]::Max(5, $pMinY - 15)
            $pMaxY = [Math]::Min($height - 5, $pMaxY + 15)
            $pW = $pMaxX - $pMinX
            $pH = $pMaxY - $pMinY
        } else {
            $pMinX = $innerLeft
            $pMinY = $innerTop
            $pW = $innerWidth
            $pH = $innerHeight
        }

        $prodRect = New-Object System.Drawing.Rectangle($pMinX, $pMinY, $pW, $pH)
        $prodBmp = $cellBmp.Clone($prodRect, $cellBmp.PixelFormat)

        # 3. Create high-resolution studio square canvas (600x600) with crisp white studio background
        $studioSize = 600
        $studioBmp = New-Object System.Drawing.Bitmap($studioSize, $studioSize)
        $g = [System.Drawing.Graphics]::FromImage($studioBmp)
        $g.Clear([System.Drawing.Color]::White)
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

        # Calculate scale to fit inside 480x480 box with padding
        $maxTarget = 480
        $scale = [Math]::Min($maxTarget / $pW, $maxTarget / $pH)
        $drawW = [int]($pW * $scale)
        $drawH = [int]($pH * $scale)
        $drawX = [int](($studioSize - $drawW) / 2)
        $drawY = [int](($studioSize - $drawH) / 2)

        $destRect = New-Object System.Drawing.Rectangle($drawX, $drawY, $drawW, $drawH)
        $g.DrawImage($prodBmp, $destRect)

        # Save enhanced studio product image
        $studioPathApi = Join-Path $destDirApi "pinpart-${idx}.jpg"
        $studioPathFront = Join-Path $destDirFront "pinpart-${idx}.jpg"
        $studioBmp.Save($studioPathApi, [System.Drawing.Imaging.ImageFormat]::Jpeg)
        $studioBmp.Save($studioPathFront, [System.Drawing.Imaging.ImageFormat]::Jpeg)

        $g.Dispose()
        $studioBmp.Dispose()
        $prodBmp.Dispose()
        $cellBmp.Dispose()

        Write-Host "Processed Item $idx (pinpart-$idx.jpg)"
        $idx++
    }
}

$bmp.Dispose()
Write-Host "All 42 high-resolution studio images generated successfully!"
