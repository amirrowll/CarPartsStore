Add-Type -AssemblyName System.Drawing

$bmp = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot\..\extracted_pages\page_1.jpg")
$w = $bmp.Width
$h = $bmp.Height
Write-Host "Image size: $w x $h"

# Find 6 columns along y = 200
$y = 200
$bordersX = @()
for ($x = 40; $x -lt $w - 40; $x++) {
    $c = $bmp.GetPixel($x, $y)
    # Dark border
    if ($c.R -lt 140 -and $c.G -lt 140 -and $c.B -lt 150) {
        $bordersX += $x
    }
}

# Group adjacent borders
$cols = @()
$inGroup = $false
$start = 0
for ($i = 0; $i -lt $bordersX.Count; $i++) {
    if (-not $inGroup) {
        $start = $bordersX[$i]
        $inGroup = $true
    } elseif ($bordersX[$i] - $bordersX[$i-1] -gt 10) {
        $cols += [PSCustomObject]@{ Left = $start; Right = $bordersX[$i-1] }
        $start = $bordersX[$i]
    }
}
if ($inGroup) {
    $cols += [PSCustomObject]@{ Left = $start; Right = $bordersX[-1] }
}

Write-Host "Found $($cols.Count) vertical edges at y=${y}:"
$cols | ForEach-Object { Write-Host "Edge at X: $($_.Left) - $($_.Right)" }

# Find 7 rows along x = 150
$x = 150
$bordersY = @()
for ($y = 40; $y -lt $h - 40; $y++) {
    $c = $bmp.GetPixel($x, $y)
    if ($c.R -lt 140 -and $c.G -lt 140 -and $c.B -lt 150) {
        $bordersY += $y
    }
}

$rows = @()
$inGroup = $false
$start = 0
for ($i = 0; $i -lt $bordersY.Count; $i++) {
    if (-not $inGroup) {
        $start = $bordersY[$i]
        $inGroup = $true
    } elseif ($bordersY[$i] - $bordersY[$i-1] -gt 10) {
        $rows += [PSCustomObject]@{ Top = $start; Bottom = $bordersY[$i-1] }
        $start = $bordersY[$i]
    }
}
if ($inGroup) {
    $rows += [PSCustomObject]@{ Top = $start; Bottom = $bordersY[-1] }
}

Write-Host "Found $($rows.Count) horizontal edges at x=${x}:"
$rows | ForEach-Object { Write-Host "Edge at Y: $($_.Top) - $($_.Bottom)" }

$bmp.Dispose()
