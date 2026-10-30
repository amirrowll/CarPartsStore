Add-Type -AssemblyName System.Drawing

$bmp = [System.Drawing.Bitmap]::FromFile("extracted_pages\page_1.jpg")

# Let's find the 6 columns:
# In each row, there are 6 boxes.
# Let's inspect horizontal lines and vertical lines.
# We know the outer bounds: Left approx 120, Right approx 2040 (width ~ 1920)
# Gap between columns is small (~25 px)
# Box width ~ 295 - 300 px
# 6 boxes * 298 = 1788 + 5 gaps * 25 = 1913
# Let's test a slice in the center of row 1 (say y=250) to find exact left/right of each box in column 0..5

$y = 250
$inBox = $false
$boxes = @()
$start = 0

for ($x = 100; $x -lt 2060; $x++) {
    $c = $bmp.GetPixel($x, $y)
    # Check if border (slate/blueish)
    $isBorder = ($c.R -lt 150 -and $c.G -lt 150 -and $c.B -gt 130) -or ($c.R -lt 120 -and $c.G -lt 120 -and $c.B -lt 120)
    if ($isBorder -and -not $inBox) {
        $inBox = $true
        $start = $x
    } elseif ($isBorder -and $inBox -and ($x - $start -gt 250)) {
        # End of this box
        $boxes += [PSCustomObject]@{ Left = $start; Right = $x; Width = ($x - $start) }
        $inBox = $false
    }
}

Write-Host "Found $($boxes.Count) columns at y=${y}:"
$boxes | ForEach-Object { Write-Host "Left: $($_.Left), Right: $($_.Right), Width: $($_.Width)" }

# Now let's test a vertical slice at x = 250 to find the 7 rows
$x = 250
$inBox = $false
$rows = @()
$start = 0

for ($y = 100; $y -lt 2750; $y++) {
    $c = $bmp.GetPixel($x, $y)
    $isBorder = ($c.R -lt 150 -and $c.G -lt 150 -and $c.B -gt 130) -or ($c.R -lt 120 -and $c.G -lt 120 -and $c.B -lt 120)
    if ($isBorder -and -not $inBox) {
        $inBox = $true
        $start = $y
    } elseif ($isBorder -and $inBox -and ($y - $start -gt 300)) {
        $rows += [PSCustomObject]@{ Top = $start; Bottom = $y; Height = ($y - $start) }
        $inBox = $false
    }
}

Write-Host "Found $($rows.Count) rows at x=${x}:"
$rows | ForEach-Object { Write-Host "Top: $($_.Top), Bottom: $($_.Bottom), Height: $($_.Height)" }

$bmp.Dispose()
