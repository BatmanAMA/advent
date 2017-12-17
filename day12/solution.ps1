$in = (Get-Content .\input.txt)
$ErrorActionPreference = "Stop"
class prog {
    prog([int]$name) {
        $this.Name = $name
        $this.connected = @()
    }
    [int]$Name
    [array]$connected
    [array]RecursiveConnect() {
        $nodes = @($this.name)
        $c = $this.connected | sort Name -Unique
        While ($c.Count) {
            $nodes += $c | Select-Object -ExpandProperty Name
            $c = $c |
                select -ExpandProperty connected |
                where {$_.Name -notin $nodes} |
                sort Name -Unique
        }
        return $nodes
    }
}
$prog = @{}
$in -replace '^(\d+).*', '$1' | ForEach-Object {
    $prog[$_] = New-Object prog($_)
}
foreach ($p in $in) {
    $p = $p -split " <-> "
    $name = $p[0]
    foreach ($connected in ($p[1].Split(',', [System.StringSplitOptions]::RemoveEmptyEntries))) {
        if ($connected -eq $name) {continue}
        ($prog[$name]).connected += $prog[$connected]
        ($prog[$connected.trim()]).connected += $prog[$name]
    }
}
$nodes = $prog["0"].RecursiveConnect()
#####################part1#######################
$nodes.Count
$groups = 1
####################part2########################
While (($nodes| Select -Unique).Count -lt $prog.Count) {
    $nextProg = $prog.Values | 
        Where-Object Name -NotIn $nodes |
        Select-Object -First 1
    $nodes += $nextProg.RecursiveConnect() |
        Select-Object -Unique |
        Where-Object {$_ -notin $nodes}
    $groups += 1
}
$groups