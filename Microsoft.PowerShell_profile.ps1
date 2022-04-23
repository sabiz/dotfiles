Set-PSReadLineOption -PredictionSource History
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadlineOption -BellStyle None

Import-Module ~/app/posh-git/src/posh-git.psd1

function ReloadEnv() {
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    $Env:PATH="C:\Program Files\Vim\vim82;$Env:PATH"
}

function Get-IPAddress() {
    $IPAddress = (Get-NetIPAddress -AddressFamily IPv4 -AddressState Preferred -SuffixOrigin DHCP) 2>${NULL}
    if ($IPAddress.length -gt 0) {
        $IPAddress = $IPAddress[0].IPAddress
    } else {
        $IPAddress = (Get-NetIPAddress -AddressFamily IPv4 -AddressState Preferred -SuffixOrigin WellKnown)[0].IPAddress
    }
    return $IPAddress
}

$ESC = [char]27

$CmdPromptUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$CmdPromptUserStr = "$($CmdPromptUser.Name.split("\")[1])"

$GitPromptSettings.DefaultPromptPrefix.Text = '$ESC[38;2;102;217;239m$(Get-Date -Format "hh:mm:ss")$ESC[0m - $ESC[38;2;166;226;46m$CmdPromptUserStr@$(Get-IPAddress) ≫ $pwd$ESC[0m '

$GitPromptSettings.DefaultPromptPath = ""

$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'

$GitPromptSettings.DefaultPromptSuffix = '$ESC[38;2;249;38;114m$(if ($IsAdmin){" # "}else{" $ "})$ESC[48;2;102;217;239m $ESC[0m$ESC[38;2;102;217;239m '

ReloadEnv
