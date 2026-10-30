Add-Type -AssemblyName System.Drawing

$bmp = [System.Drawing.Bitmap]::FromFile("extracted_pages\page_1.jpg")

# Search for the outer grid bounds
# Let's project vertically (column sums of dark pixels) and horizontally (row sums of dark pixels)
$w = $bmp.Width
$h = $bmp.Height

$vProj = New-Object int[] $w
$hProj = New-Object int[] $h

# Sample every 4th pixel for speed
for ($y = 80; $y -lt $h - 150; $y += 3) {
    for ($x = 80; $x -lt $w - 80; $x += 3) {
        $c = $bmp.GetPixel($x, $y)
        if ($c.R -lt 160 -and $c.G -lt 160 -and $c.B -lt 160) {
            $vProj[$x]++
            $hProj[$y]++
        }
    }
}

# Find column boundaries:
# Output ranges where vProj has sharp peaks (borders)
$colPeaks = @()
for ($x = 100; $x -lt $w - 100; $x++) {
    if ($vProj[$x] -gt 150) {
        $colPeaks += $x
    }
}

# Cluster peaks
function Cluster-Points($points, $threshold) {
    $clusters = @()
    $current = @()
    foreach ($p in $points) {
        if ($current.Count -eq 0 -or ($p - $current[-1]) -le $threshold) {
            $current += $p
        } else {
            $avg = [math]::Round(($current | Measure-Object -Average).Average)
            $clusters += $avg
            $current = @($p)
        }
    }
    if ($current.Count -gt 0) {
        $avg = [math]::Round(($current | Measure-Object -Average).Average)
        $clusters += $avg
    }
    return $clusters
}

$xClusters = Cluster-Points $colPeaks 15

$rowPeaks = @()
for ($y = 100; $y -lt $h - 200; $y++) {
    if ($hProj[$y] -gt 150) {
        $rowPeaks += $y
    }
}
$yClusters = Cluster-Points $rowPeaks 15

Write-Host "X borders ($($xClusters.Count)): $($xClusters -join ', ')"
Write-Host "Y borders ($($yClusters.Count)): $($yClusters -join ', ')"

$bmp.Dispose()
