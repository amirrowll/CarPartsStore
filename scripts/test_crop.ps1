Add-Type -AssemblyName System.Drawing

$pagePath = Join-Path (Get-Location) "extracted_pages\page_1.jpg"
if (-not (Test-Path $pagePath)) {
    Write-Host "Page 1 not found"
    exit 1
}

$bmp = [System.Drawing.Bitmap]::FromFile($pagePath)
Write-Host "Loaded image: $($bmp.Width) x $($bmp.Height)"

# Page 1 has 7 rows and 6 columns = 42 cells.
# Let's inspect coordinates.
# Total width is 2171, Total height is 3072.
$bmp.Dispose()
