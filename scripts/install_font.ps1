Param($Version)

function Use-TempDir {
    param (
        [ScriptBlock]$script
    )
    $tmp = $env:TEMP | Join-Path -ChildPath $([System.Guid]::NewGuid().Guid)
    New-Item -ItemType Directory -Path $tmp | Push-Location
    $result = Invoke-Command -ScriptBlock $script
    Pop-Location
    $tmp | Remove-Item -Recurse
    return $result
}

$fontSourceFolder = "HackGenNerd_$Version"
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
Use-TempDir {
    curl -OL "https://github.com/yuru7/HackGen/releases/download/$Version/HackGenNerd_$Version.zip"
    Expand-Archive -Path "HackGenNerd_$Version.zip" -DestinationPath ".\"
    foreach($file in Get-ChildItem $fontSourceFolder -Include '*.ttf' -recurse ) {
        
        $fileName = $file.Name
        if (-not(Test-Path -Path "C:\Windows\fonts\$fileName" )) {
            Get-ChildItem $file | %{ $fonts.CopyHere($_.fullname) }
        }
    }
}