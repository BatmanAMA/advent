param(

)
$ErrorActionPreference = "Stop"

$in = (gc .\input.txt) -replace '!.', '' -replace '<[^>]*?>', ''

$current, $score = 0
foreach ($c in $in.ToCharArray()) {
    switch ($c) {
        '{' { $current++ }
        '}' { $score += $current--}
    }
}
$score
#Part two
$in = (gc .\input.txt) -replace '!.', ''
$pattern = "<(?'Named'[^>]*?)>"
$matches = [regex]::Matches($in, $pattern)
$Matches | 
    ForEach-Object {$_.Groups['Named'].Length} |
    Measure-Object -sum |
    Select-Object -ExpandProperty Sum