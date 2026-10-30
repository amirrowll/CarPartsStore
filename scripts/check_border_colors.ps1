Add-Type -AssemblyName System.Drawing

$bmp = [System.Drawing.Bitmap]::FromFile("extracted_pages\page_1.jpg")

# Let's inspect the 6 column coordinates and 7 row coordinates
# Let's find the exact top-left and bottom-right of each box
# We can find all rounded rectangles by finding where border pixels are
# Let's check color of border pixels around (120, 150)
$c = $bmp.GetPixel(120, 150)
Write-Host "Pixel at 120, 150: R=$($c.R) G=$($c.G) B=$($c.B)"

# Let's test a slice across the width at y=150 to find the exact box borders
$borders = @()
for ($x = 50; $x -lt $bmp.Width - 50; $x++) {
    $px = $bmp.GetPixel($x, 200)
    # Check if this pixel is on a border line
    if ($px.R -lt 150 -and $px.G -lt 150 -and $px.B -gt 150) {
        # Blue border!
        $borders += "Blue at $x"
    } elseif ($px.R -lt 120 -and $px.G -lt 120 -and $px.B -lt 120) {
        # Dark border
    }
}
Write-Host "Found blue border pixels at y=200: $($borders.Count)"

# Let's check colors across different coordinates
for ($x = 100; $x -lt 2100; $x += 100) {
    $px = $bmp.GetPixel($x, 200)
    # Write-Host "$x, 200: R=$($px.R) G=$($px.G) B=$($px.B)"
}

$bmp.Dispose()
