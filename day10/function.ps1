param(
    [array]$array, 
    [int]$pos,
    [int]$value
)
$i = 0
foreach ($n in $array) {
    Write-Host " " -NoNewline
    if ($i -eq $pos) {
        Write-Host "([" -NoNewline
    }
    Write-Host "$n" -NoNewline
    if ($i -eq $pos) {
        Write-Host "]" -NoNewline
    }
    if ($i -eq (($pos + $value) % $array.Length) - 1) {
        Write-Host ")" -NoNewline
    }
    $i++
    Write-Host " " -NoNewline
}
Write-Host ""
