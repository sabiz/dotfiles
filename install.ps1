###########################################
###########################################

$INSTALLER_VERSION='v0.1.0'
$MY_PATH = Split-Path -Parent $MyInvocation.MyCommand.Path
$SCRIPT_PATH = Join-Path $MY_PATH "scripts"
$ESC = [char]27
$TITLE_COLOR_ESCAPE="$ESC[48;2;52;148;230m$ESC[38;2;255;255;255m"
$HACKGEN_VER="v2.5.3"

##########################################

Write-Host "$ESC[38;2;52;148;230m  ██████╗  ██████╗ ████████╗    ███████╗██╗██╗     ███████╗███████╗     "
Write-Host "$ESC[38;2;68;144;224m  ██╔══██╗██╔═══██╗╚══██╔══╝    ██╔════╝██║██║     ██╔════╝██╔════╝     "
Write-Host "$ESC[38;2;85;141;219m  ██║  ██║██║   ██║   ██║       █████╗  ██║██║     █████╗  ███████╗     "
Write-Host "$ESC[38;2;102;137;214m  ██║  ██║██║   ██║   ██║       ██╔══╝  ██║██║     ██╔══╝  ╚════██║     "
Write-Host "$ESC[38;2;118;134;209m  ██████╔╝╚██████╔╝   ██║       ██║     ██║███████╗███████╗███████║     "
Write-Host "$ESC[38;2;135;130;204m  ╚═════╝  ╚═════╝    ╚═╝       ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝     "
Write-Host ""
Write-Host "$ESC[38;2;152;127;198m  ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗ "
Write-Host "$ESC[38;2;169;123;193m  ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗"
Write-Host "$ESC[38;2;185;120;188m  ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝"
Write-Host "$ESC[38;2;202;116;183m  ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗"
Write-Host "$ESC[38;2;219;113;178m  ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║"
Write-Host "$ESC[38;2;236;110;173m  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝   $ESC[4;213m$INSTALLER_VERSION"
Write-Host "$ESC[m"


# -----------------------------------------------------
. "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   Install fonts ?    $ESC[m"
# -----------------------------------------------------
if ($?) {
    . "$SCRIPT_PATH\install_font.ps1"
}

# -----------------------------------------------------
. "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   Install development tools ?    $ESC[m"
# -----------------------------------------------------
if ($?) {
    winget install vim.vim
    winget install Git.Git
    PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
    winget install Microsoft.VisualStudioCode.Insiders
}

# -----------------------------------------------------
. "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   Install PowerShell Profile ?    $ESC[m"
# -----------------------------------------------------
if ($?) {
    $profilePath = Join-Path $MY_PATH 'Microsoft.PowerShell_profile.ps1'
    Copy-Item -Path $profilePath -Destination $PROFILE
}

# -----------------------------------------------------
. "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   Install Windows Terminal Settings ?    $ESC[m"
# -----------------------------------------------------
if ($?) {
    $settingPath = Join-Path $MY_PATH 'windows_terminal_settings.json'
    Copy-Item -Path $settingPath -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
}

# -----------------------------------------------------
. "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   Install vimrc ?    $ESC[m"
# -----------------------------------------------------
if ($?) {
    $vimrcPath = Join-Path $MY_PATH '.vimrc'
    Copy-Item -Path $vimrcPath -Destination "$env:USERPROFILE\.vimrc"
    $vimPath = Join-Path $MY_PATH '.vim'
    Copy-Item $vimPath -Recurse "$env:USERPROFILE\vimfiles"
    $gvimrcPath = Join-Path $MY_PATH '_gvimrc'
    Copy-Item -Path $gvimrcPath -Destination "$env:USERPROFILE\_gvimrc"
}