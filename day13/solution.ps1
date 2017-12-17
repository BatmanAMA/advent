$in = Get-Content .\input.txt
$severity = 0
foreach ($l in $in) {
    $fwRule = $l -split ': '
    $depth = [int]$fwRule[0]
    $range = [int]$fwRule[1]
    if (($depth % (($range - 2) * 2 + 2) -eq 0)) {
        $severity += $range * $depth
    }
}
$severity

$iterator = 0
do {
    $safe = $true
    $iterator++
    foreach ($l in $in) {
        $fwRule = $l -split ': '
        $depth = ([int]$fwRule[0]) + $iterator
        $range = [int]$fwRule[1]
        if (($depth % (($range - 2) * 2 + 2) -eq 0)) {
            $safe = $false
            break;
        }
    }
} until ($safe)
$iterator