$string = "oundnydw"
$disk = New-Object 'Int[,]' 129, 129
for ($i = 0; $i -lt 129; $i++) {
    $x = 0
    $hex = .\knothash.ps1 -in "$string-$i"
    $hex.ToCharArray() | 
        ForEach-Object {
        [Convert]::ToString([Convert]::ToInt32($_, 16), 2).PadLeft(4, "0").ToCharArray() } |
        ForEach-Object {
        $disk[$i, $x] = [int]::Parse($_)
        $x++
    }
}
function markStuff {
    param(
        [int] $x,
        [int] $y,
        [int] $count
    )
    #<#
    $disk[$x, $y] = $count
    foreach ($pair in @((($y - 1), $x), (($y + 1), $x), ($y, ($x - 1)), ($y, ($x + 1)))) {
        $newy, $newx = $pair
        if ($disk[$newx, $newy] -eq 1 -and $newx -gt 0 -and $newy -gt 0) {
            markStuff $newy $newx $group
        }
    }
    #>
}
$onecount = 0
$gcount = 1
for ($i = 0; $i -lt 129; $i++) {
    for ($j = 0; $j -lt 129; $j++) {
        if ($disk[$i, $j] -eq 1) {
            $gcount++
            markStuff $i $j $gcount
        }
        if ($disk[$i, $j] -ge 1) {
            $onecount++
        }
        Write-Host "  $($disk[$i, $j])".Substring(2).Padleft(2) -NoNewline
    }
    Write-Host ""
}
$onecount
$gcount - 1