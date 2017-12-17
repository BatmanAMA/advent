$ErrorActionPreference = "Stop"
$in = gc .\input.txt
$registers = New-Object "System.Collections.Generic.Dictionary[string,int]"($in.Count)
$script:Max = 0
function operate {
    param([int]$value, [string]$operation, [int]$amount)
    switch ($operation) {
        'inc' { 
            if ($script:max -lt ($value + $amount)) {
                $script:max = $value + $amount
            }
            $value + $amount
        }
        'dec' { 
            if ($script:max -lt ($value - $amount)) {
                $script:max = $value - $amount
            }
            $value - $amount 
        }
        default: {
            Write-Error -Message "$operation not recognized"
        }
    }#
}
$in | ForEach-Object {$registers[($_ -split " ")[0]] = 0}

foreach ($line in $in) {
    $tokens = $line -split " "
    switch ($tokens[-2]) {
        ">" {
            if ($registers[$tokens[-3]] -gt $tokens[-1]) {
                $registers[$tokens[0]] = operate $registers[$tokens[0]] $tokens[1] $tokens[2]
                Write-Host "$($tokens[0]) $($tokens[1]) $($tokens[2])"
            }
        } 

        "<" {
            if ($registers[$tokens[-3]] -lt $tokens[-1]) {
                $registers[$tokens[0]] = operate $registers[$tokens[0]] $tokens[1] $tokens[2]
                Write-Host "$($tokens[0]) $($tokens[1]) $($tokens[2])"
            }
        }

        "==" {
            if ($registers[$tokens[-3]] -eq $tokens[-1]) {
                $registers[$tokens[0]] = operate $registers[$tokens[0]] $tokens[1] $tokens[2]
                Write-Host "$($tokens[0]) $($tokens[1]) $($tokens[2])"
            }
        }

        ">=" {
            if ($registers[$tokens[-3]] -ge $tokens[-1]) {
                $registers[$tokens[0]] = operate $registers[$tokens[0]] $tokens[1] $tokens[2]
                Write-Host "$($tokens[0]) $($tokens[1]) $($tokens[2])"
            }
        }

        "<=" {
            if ($registers[$tokens[-3]] -le $tokens[-1]) {
                $registers[$tokens[0]] = operate $registers[$tokens[0]] $tokens[1] $tokens[2]
                Write-Host "$($tokens[0]) $($tokens[1]) $($tokens[2])"
            }
        }
        "!=" {
            if ($registers[$tokens[-3]] -ne $tokens[-1]) {
                $registers[$tokens[0]] = operate $registers[$tokens[0]] $tokens[1] $tokens[2]
                Write-Host "$($tokens[0]) $($tokens[1]) $($tokens[2])"
            }
        }

    }
}

$registers.Values | Measure -Maximum | select -ExpandProperty Maximum

$Script:Max