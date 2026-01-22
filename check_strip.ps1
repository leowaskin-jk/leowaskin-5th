
Add-Type -AssemblyName System.Drawing

$images = Get-ChildItem ./images/award_img_*.jpg
foreach ($imgFile in $images) {
    try {
        $bmp = [System.Drawing.Bitmap]::FromFile($imgFile.FullName)
        # Check top 50 rows at the center column
        $blackRows = 0
        $x = [math]::Floor($bmp.Width / 2)
        
        for ($y = 0; $y -lt 50; $y++) {
            $pixel = $bmp.GetPixel($x, $y)
            # Check if pixel is dark (R, G, B < 30)
            if ($pixel.R -lt 30 -and $pixel.G -lt 30 -and $pixel.B -lt 30) {
                $blackRows++
            } else {
                break
            }
        }
        Write-Host "$($imgFile.Name): Black strip height (approx center) = $blackRows px"
        $bmp.Dispose()
    } catch {
        Write-Host "Error processing $($imgFile.Name): $_"
    }
}
