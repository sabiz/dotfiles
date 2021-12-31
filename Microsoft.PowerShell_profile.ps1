Set-PSReadLineOption -PredictionSource History
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadlineOption -BellStyle None

Import-Module posh-git

$ESC = [char]27


$CmdPromptUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$CmdPromptUserStr = "$($CmdPromptUser.Name.split("\")[1])"
try {
    $IPAddress = (Get-NetIPAddress -AddressFamily IPv4 -AddressState Preferred -SuffixOrigin DHCP)[0].IPAddress >${NULL} 2>&1
} catch {
    $IPAddress = (Get-NetIPAddress -AddressFamily IPv4 -AddressState Preferred -SuffixOrigin WellKnown)[0].IPAddress
}

$GitPromptSettings.DefaultPromptPrefix.Text = '$ESC[38;2;102;217;239m$(Get-Date -Format "hh:mm:ss")$ESC[0m - $ESC[38;2;166;226;46m$CmdPromptUserStr@$IPAddress ≫ $pwd$ESC[0m '

$GitPromptSettings.DefaultPromptPath = ""

$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'

$GitPromptSettings.DefaultPromptSuffix = '$ESC[38;2;249;38;114m$(if ($IsAdmin){" # "}else{" $ "})$ESC[48;2;102;217;239m $ESC[0m$ESC[38;2;102;217;239m '


$Env:PATH="C:\Program Files\Vim\vim82;$Env:PATH"