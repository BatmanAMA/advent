[int[]]$in = (gc .\input.txt) -split ','
$array = @(0..255)
$m = $array.Length
$skip, $pos = 0, 0
foreach ($instruction in $in) {
    $end = $pos + $instruction - 1
    $subArray = $array[$pos..$end] # create a subarray of the lenght of this
    if ($end -ge $m) {
        $end = $end % $m
        $subArray += $array[0..$end]
    }
    [array]::Reverse($subArray)
    $i = $pos
    foreach ($number in $subArray) {
        $array[($i % $m)] = $number
        $i++
    }
    $pos = ($end + $skip + 1) % $m
    $skip++
    #$array[0] * $array[1]
}
$array[0] * $array[1]

#810 is <