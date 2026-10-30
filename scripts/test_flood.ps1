Add-Type -AssemblyName System.Drawing

function FloodFill-Whiten($bmp, $tolerance) {
    $w = $bmp.Width
    $h = $bmp.Height
    $visited = New-Object 'bool[,]' $w, $h
    $queue = New-Object System.Collections.Generic.Queue[System.Drawing.Point]
    
    # Push 4 corners
    $queue.Enqueue((New-Object System.Drawing.Point(0, 0)))
    $queue.Enqueue((New-Object System.Drawing.Point($w - 1, 0)))
    $queue.Enqueue((New-Object System.Drawing.Point(0, $h - 1)))
    $queue.Enqueue((New-Object System.Drawing.Point($w - 1, $h - 1)))
    
    while ($queue.Count -gt 0) {
        $pt = $queue.Dequeue()
        $x = $pt.X
        $y = $pt.Y
        
        if ($x -lt 0 -or $x -ge $w -or $y -lt 0 -or $y -ge $h) { continue }
        if ($visited[$x, $y]) { continue }
        $visited[$x, $y] = $true
        
        $c = $bmp.GetPixel($x, $y)
        # Background pixel is light: min(R,G,B) > tolerance
        if ($c.R -ge $tolerance -and $c.G -ge $tolerance -and $c.B -ge $tolerance) {
            $bmp.SetPixel($x, $y, [System.Drawing.Color]::White)
            
            $queue.Enqueue((New-Object System.Drawing.Point($x + 1, $y)))
            $queue.Enqueue((New-Object System.Drawing.Point($x - 1, $y)))
            $queue.Enqueue((New-Object System.Drawing.Point($x, $y + 1)))
            $queue.Enqueue((New-Object System.Drawing.Point($x, $y - 1)))
        }
    }
}

# Test on 1005
$src = [System.Drawing.Bitmap]::FromFile("extracted_items_page1\item_1005.jpg")
# Crop just the inner product (x: 40..250, y: 70..270)
$cropRect = New-Object System.Drawing.Rectangle(35, 65, 225, 205)
$cropped = $src.Clone($cropRect, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)

# Flood fill outer background with white
FloodFill-Whiten $cropped 220

# Save
$cropped.Save("extracted_items_page1\flood_1005.png", [System.Drawing.Imaging.ImageFormat]::Png)
$cropped.Dispose()
$src.Dispose()
Write-Host "Flood fill test complete"
