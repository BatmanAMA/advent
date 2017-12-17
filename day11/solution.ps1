$in = (get-content .\input.txt) -split ','

$location = New-Object "int[]" (3)
$location = 0, 0, 0
$max = 0
foreach ($d in $in) {
    switch ($d) {
        'ne' {
            $location[2] += 1
        }
        'sw' {
            $location[2] += -1
        }
        'nw' {
            $location[1] += 1
        }
        'se' {
            $location[1] += -1
        }
        'n' {
            $location[0] += 1
        }
        's' {
            $location[0] += -1
        }
    }
    $max = [Math]::max(
        $max,
        ($location | % {[Math]::abs($_)} | sort | select -last 2 | measure -sum).sum
    )
}
($location | % {[Math]::abs($_)} | sort | select -last 2 | measure -sum).sum
$max