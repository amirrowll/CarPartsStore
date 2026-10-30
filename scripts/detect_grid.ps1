Add-Type -AssemblyName System.Drawing

$bmp = [System.Drawing.Bitmap]::FromFile("extracted_pages\page_1.jpg")

# Find bounding boxes of each cell by scanning for dark border pixels.
# Let's inspect column positions and row positions.
Write-Host "Image size: $($bmp.Width) x $($bmp.Height)"

# Sample horizontal slice around y = 300 to find column lines
$row = 300
$darkPixelsX = @()
for ($x = 100; $x -lt $bmp.Width - 100; $x++) {
    $c = $bmp.GetPixel($x, $row)
    if ($c.R -lt 180 -and $c.G -lt 180 -and $c.B -lt 180) {
        $darkPixelsX += $x
    }
}
Write-Host "Sample dark X at y=$row : $($darkPixelsX.Count) pixels found"

# Let's sample down the middle around x = 200 to find row lines
$col = 200
$darkPixelsY = @()
for ($y = 100; $y -lt $bmp.Height - 100; $y++) {
    $c = $bmp.GetPixel($col, $y)
    if ($c.R -lt 180 -and $c.G -lt 180 -and $c.B -lt 180) {
        $darkPixelsY += $y
    }
}
Write-Host "Sample dark Y at x=$col : $($darkPixelsY.Count) pixels found"

$bmp.Dispose()
