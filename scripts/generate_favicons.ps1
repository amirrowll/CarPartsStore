Add-Type -AssemblyName System.Drawing

$srcPath = (Resolve-Path 'carpartsstore-frontend/public/logo.jpg').Path
$publicDir = (Resolve-Path 'carpartsstore-frontend/public').Path
$srcBmp = [System.Drawing.Image]::FromFile($srcPath)

function Resize-Bmp ($src, [int]$w, [int]$h) {
    $dest = [System.Drawing.Bitmap]::new($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($dest)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $g.Clear([System.Drawing.Color]::White)
    $g.DrawImage($src, 0, 0, $w, $h)
    $g.Dispose()
    return $dest
}

$sizes = @(16, 32, 48, 96, 144, 192, 512)
foreach ($s in $sizes) {
    $resized = Resize-Bmp $srcBmp $s $s
    $outPng = Join-Path $publicDir "favicon-$($s)x$($s).png"
    $resized.Save($outPng, [System.Drawing.Imaging.ImageFormat]::Png)
    $resized.Dispose()
    Write-Host "Generated: favicon-$($s)x$($s).png"
}

# Apple Touch Icon (180x180)
$apple = Resize-Bmp $srcBmp 180 180
$apple.Save((Join-Path $publicDir "apple-touch-icon.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$apple.Dispose()
Write-Host "Generated: apple-touch-icon.png"

# Favicon.ico (using 48x48)
$icoBmp = Resize-Bmp $srcBmp 48 48
$hIcon = $icoBmp.GetHicon()
$ico = [System.Drawing.Icon]::FromHandle($hIcon)
$fs = [System.IO.FileStream]::new((Join-Path $publicDir "favicon.ico"), [System.IO.FileMode]::Create)
$ico.Save($fs)
$fs.Close()
$ico.Dispose()
$icoBmp.Dispose()
Write-Host "Generated: favicon.ico"

$srcBmp.Dispose()
