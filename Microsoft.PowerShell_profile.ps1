Set-PSReadLineOption -PredictionSource History
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadlineOption -BellStyle None

###################################################################
# Reload the environment variables and paths
###################################################################
function ReloadEnv() {
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

    $pathListFilePath = (Join-Path ([Environment]::GetFolderPath([Environment+SpecialFolder]::MyDocuments)) PowerShell path_list.txt)
    if (Test-Path $pathListFilePath) {
        $pathList = Get-Content $pathListFilePath
        foreach ($path in $pathList) {
            if ($path -and (Test-Path $path)) {
                $Env:Path += ";$path"
            }
        }
    } else {
        Write-Host "Path list file not found: $pathListFilePath"
        New-Item -Path $pathListFilePath -ItemType File -Force | Out-Null
    }
}

###################################################################
# Get the current IP address of the machine
###################################################################
function Get-IPAddress() {
    $IPAddress = (Get-NetIPAddress -AddressFamily IPv4 -AddressState Preferred -SuffixOrigin DHCP) 2>${NULL}
    if ($IPAddress.length -gt 0) {
        $IPAddress = $IPAddress[0].IPAddress
    } else {
        $IPAddress = (Get-NetIPAddress -AddressFamily IPv4 -AddressState Preferred -SuffixOrigin WellKnown)[0].IPAddress
    }
    return $IPAddress
}

#################################################################
#################################################################

ReloadEnv

if (-not (Get-Command starship -ErrorAction SilentlyContinue)) {
    winget install --id Starship.Starship
}

Invoke-Expression (&starship init powershell)
