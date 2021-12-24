Set-PSReadLineOption -PredictionSource History
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadlineOption -BellStyle None



function prompt {

    #Assign Windows Title Text
    $host.ui.RawUI.WindowTitle = "$pwd"

    #Configure current user and date outputs
    $CmdPromptUser = [Security.Principal.WindowsIdentity]::GetCurrent();
    $Date = Get-Date -Format 'hh:mm:ss'

    $IPAddress = (Get-NetIPAddress -AddressFamily IPv4 -AddressState Preferred -SuffixOrigin DHCP)[0].IPAddress;

    # Test for Admin / Elevated
    $IsAdmin = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)


    $CmdPromptUserStr = "$($CmdPromptUser.Name.split("\")[1])"
    if ($IsAdmin) {
        Write-Host $CmdPromptUserStr  -NoNewline -BackgroundColor DarkRed -ForegroundColor White
        Write-Host "" -NoNewline -BackgroundColor DarkGray -ForegroundColor DarkRed
    } else {
        Write-Host $CmdPromptUserStr  -NoNewline -BackgroundColor DarkBlue -ForegroundColor White
        Write-Host "" -NoNewline -BackgroundColor DarkGray -ForegroundColor DarkBlue
    }

    Write-Host "$IPAddress " -NoNewline -BackgroundColor DarkGray -ForegroundColor White
    Write-Host "" -NoNewline -BackgroundColor Gray -ForegroundColor DarkGray

    Write-Host " $pwd " -NoNewline -ForegroundColor DarkGray -BackgroundColor Gray
    Write-Host "" -NoNewline -ForegroundColor Gray

    Write-Host " "

    Write-Host "$date " -NoNewline -ForegroundColor Black -BackgroundColor White
    Write-Host "" -NoNewline -ForegroundColor White
    # Write-Host "[$elapsedTime] " -NoNewline -ForegroundColor Green
    return " "
} #end prompt function
