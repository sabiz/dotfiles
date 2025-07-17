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


if (-not (Get-Module -ListAvailable -Name posh-git)) {
    Write-Host "posh-git module not found. Installing..."
    Install-Module posh-git -Scope CurrentUser -Force
}

Import-Module posh-git

$ESC = [char]27

$CmdPromptUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$CmdPromptUserStr = "$($CmdPromptUser.Name.split("\")[1])"

$GitPromptSettings.DefaultPromptPrefix.Text = '$ESC[38;2;102;217;239m$(Get-Date -Format "hh:mm:ss")$ESC[0m - $ESC[38;2;166;226;46m$CmdPromptUserStr@$(Get-IPAddress) ≫ $pwd$ESC[0m '

$GitPromptSettings.DefaultPromptPath = ""

$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'

$GitPromptSettings.DefaultPromptSuffix = '$ESC[38;2;249;38;114m$(if ($IsAdmin){" # "}else{" $ "})$ESC[48;2;102;217;239m $ESC[0m$ESC[38;2;102;217;239m '

ReloadEnv
