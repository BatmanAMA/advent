$string = "oundnydw"
$used = 0
$disk = New-Object 'Int[,]' 128,128
for ($i = 0; $i -lt 128; $i++) {
    $hex = .\knothash.ps1 -in "$string-$i"
    $disk[$i] = $hex.ToCharArray() | 
        ForEach-Object {
        [Convert]::ToString([Convert]::ToInt32($_, 16), 2).ToCharArray()
    } 
}
