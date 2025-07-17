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


# ------------------------------------------------------
# Install Fonts
# ------------------------------------------------------
function Install-Fonts {
    param($isInstaractive = $true)
    if ($isInstaractive) {
        . "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   Install fonts ?    $ESC[m"
    } else {
        Write-Host "$TITLE_COLOR_ESCAPE   Install fonts.    $ESC[m"
    }
    if ($? -or -not $isInstaractive) {
        . "$SCRIPT_PATH\install_font.ps1" $HACKGEN_VER
    }
}

# ------------------------------------------------------
# Install Development Tools
# ------------------------------------------------------
function Install-Development-Tools {
    param($isInstaractive = $true)
    if ($isInstaractive) {
        . "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   Install development tools ?    $ESC[m"
    } else {
        Write-Host "$TITLE_COLOR_ESCAPE   Install development tools.    $ESC[m"
    }
    if ($? -or -not $isInstaractive) {
        winget install vim.vim
        winget install Git.Git
        winget install Microsoft.VisualStudioCode.Insiders
    }
}

# ------------------------------------------------------
# Install PowerShell Profile
# ------------------------------------------------------
function Install-PowerShell-Profile {
    param($isInstaractive = $true)
    if ($isInstaractive) {
        . "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   Install PowerShell Profile ?    $ESC[m"
    } else {
        Write-Host "$TITLE_COLOR_ESCAPE   Install PowerShell Profile.    $ESC[m"
    }
    if ($? -or -not $isInstaractive) {
        $profilePath = Join-Path $MY_PATH 'Microsoft.PowerShell_profile.ps1'
        Copy-Item -Path $profilePath -Destination $PROFILE
    }
}

# ------------------------------------------------------
# Install Windows Terminal Settings
# ------------------------------------------------------
function Install-Windows-Terminal-Settings {
    param($isInstaractive = $true)
    if ($isInstaractive) {
        . "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   Install Windows Terminal Settings ?    $ESC[m"
    } else {
        Write-Host "$TITLE_COLOR_ESCAPE   Install Windows Terminal Settings.    $ESC[m"
    }
    if ($? -or -not $isInstaractive) {
        $settingPath = Join-Path $MY_PATH 'windows_terminal_settings.json'
        Copy-Item -Path $settingPath -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    }
}

# ------------------------------------------------------
# Install vimrc
# ------------------------------------------------------
function Install-Vimrc {
    param($isInstaractive = $true)
    if ($isInstaractive) {
        . "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   Install vimrc ?    $ESC[m"
    } else {
        Write-Host "$TITLE_COLOR_ESCAPE   Install vimrc.    $ESC[m"
    }
    if ($? -or -not $isInstaractive) {
        $vimrcPath = Join-Path $MY_PATH '.vimrc'
            Copy-Item -Path $vimrcPath -Destination "$env:USERPROFILE\.vimrc"
            $vimPath = Join-Path $MY_PATH '.vim'
            Copy-Item $vimPath -Recurse "$env:USERPROFILE\vimfiles"
            $gvimrcPath = Join-Path $MY_PATH '_gvimrc'
            Copy-Item -Path $gvimrcPath -Destination "$env:USERPROFILE\_gvimrc"
    }
}


if ($args.Count -eq 0) {
    Install-Fonts
    Install-Development-Tools
    Install-PowerShell-Profile
    Install-Windows-Terminal-Settings
    Install-Vimrc
} else {
    foreach ($arg in $args) {
        switch ($arg) {
            'fonts' { Install-Fonts $false }
            'devtools' { Install-Development-Tools $false }
            'profile' { Install-PowerShell-Profile $false }
            'terminal' { Install-Windows-Terminal-Settings $false }
            'vimrc' { Install-Vimrc $false }
            default { Write-Host "Unknown argument: $arg"
                      Write-Host "Usage: install.ps1 {options...}"
                      Write-Host "Available options: fonts, devtools, profile, terminal, vimrc" }
        }
    }
}
