Add-Type -AssemblyName System.Drawing

$img = [System.Drawing.Bitmap]::FromFile("extracted_items_page1\item_1001.jpg")
Write-Host "Item 1001 dimensions: $($img.Width) x $($img.Height)"

# In 296x350:
# Top has the badge ~ 0..70
# Bottom has text ~ 280..350
# Center product ~ x: 30..266, y: 55..285 (approx 236 x 230)
# Let's inspect non-white pixels in item_1001

$minX = $img.Width; $maxX = 0; $minY = $img.Height; $maxY = 0

for ($y = 60; $y -lt 280; $y++) {
    for ($x = 25; $x -lt ($img.Width - 25); $x++) {
        $c = $img.GetPixel($x, $y)
        # Check if not pure white/near white
        if ($c.R -lt 240 -or $c.G -lt 240 -or $c.B -lt 240) {
            if ($x -lt $minX) { $minX = $x }
            if ($x -gt $maxX) { $maxX = $x }
            if ($y -lt $minY) { $minY = $y }
            if ($y -gt $maxY) { $maxY = $y }
        }
    }
}

Write-Host "Item 1001 product bounding box: X=[$minX, $maxX], Y=[$minY, $maxY], W=$($maxX - $minX), H=$($maxY - $minY)"
$img.Dispose()
