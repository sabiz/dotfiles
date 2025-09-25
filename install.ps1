###########################################
###########################################

$INSTALLER_VERSION='v0.2.0'
$MY_PATH = Split-Path -Parent $MyInvocation.MyCommand.Path
$SCRIPT_PATH = Join-Path $MY_PATH "scripts"
$ESC = [char]27
$TITLE_COLOR_ESCAPE="$ESC[48;2;52;148;230m$ESC[38;2;255;255;255m"
$HACKGEN_VER="v2.10.0"

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
# Show Install title
# ------------------------------------------------------
function Show-Install-Title {
    param(
        [string]$title,
        [bool]$isInteractive = $true
    )
    if ($isInteractive) {
        . "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   $title ?    $ESC[m"
        return $?
    } else {
        Write-Host "$TITLE_COLOR_ESCAPE   $title.    $ESC[m"
        return $true
    }
}

# ------------------------------------------------------
# Confirm and Install (file or directory)
# ------------------------------------------------------
function Confirm-And-Install {
    param(
        [string]$title,
        [string]$srcPath,
        [string]$destPath,
        [bool]$isDirectory = $false,
        [bool]$isInteractive = $true
    )
    $shouldInstall = $true
    if ($isInteractive) {
        . "$SCRIPT_PATH\interactive.ps1" "$TITLE_COLOR_ESCAPE   $title ?    $ESC[m"
        $shouldInstall = $?
    } else {
        Write-Host "$TITLE_COLOR_ESCAPE   $title.    $ESC[m"
    }
    if ($shouldInstall) {
        if ($isDirectory) {
            if (Test-Path $destPath) {
                Write-Host "\n$TITLE_COLOR_ESCAPE   $title directory already exists at $destPath. Showing diffs for files...    $ESC[m"
                $srcFiles = Get-ChildItem -Path $srcPath -Recurse -File
                foreach ($srcFile in $srcFiles) {
                    $relativePath = $srcFile.FullName.Substring($srcPath.Length)
                    $destFile = "$destPath$relativePath"
                    if (Test-Path $destFile) {
                        if (Get-Command nvim -ErrorAction SilentlyContinue) {
                            nvim -d $destFile $srcFile.FullName
                        } elseif (Get-Command vim -ErrorAction SilentlyContinue) {
                            vim -d $destFile $srcFile.FullName
                        } else {
                            Write-Host "Neither nvim nor vim is installed. Cannot show diff for $destFile."
                        }
                    }
                }
            } else {
                Copy-Item -Path $srcPath -Recurse -Force -Destination $destPath
            }
        } else {
            if (Test-Path $destPath) {
                Write-Host "$TITLE_COLOR_ESCAPE   $title already exists at $destPath. Showing diff...    $ESC[m"
                if (Get-Command nvim -ErrorAction SilentlyContinue) {
                    nvim -d $destPath $srcPath
                } elseif (Get-Command vim -ErrorAction SilentlyContinue) {
                    vim -d $destPath $srcPath
                } else {
                    Write-Host "Neither nvim nor vim is installed. Cannot show diff."
                }
            } else {
                $destDirectory = Split-Path -Parent $destPath
                if ($destDirectory -and -not (Test-Path $destDirectory)) {
                    # Ensure destination directory exists before copying a file
                    New-Item -ItemType Directory -Path $destDirectory -Force | Out-Null
                }
                Copy-Item -Path $srcPath -Destination $destPath
            }
        }
    }
}

# ------------------------------------------------------
# Install Fonts
# ------------------------------------------------------
function Install-Fonts {
    param($isInstaractive = $true)
    if (-not (Show-Install-Title "Install fonts" $isInstaractive)) {
        return
    }
    . "$SCRIPT_PATH\install_font.ps1" $HACKGEN_VER
}

# ------------------------------------------------------
# Install Development Tools
# ------------------------------------------------------
function Install-Development-Tools {
    param($isInstaractive = $true)
    if (-not (Show-Install-Title "Install development tools" $isInstaractive)) {
        return
    }
    winget install vim.vim
    winget install Git.Git
    winget install Microsoft.VisualStudioCode.Insiders
    winget install BurntSushi.ripgrep.MSVC
    winget install zig.zig
    winget install Neovim.Neovim
    winget install Neovide.Neovide

}

# ------------------------------------------------------
# Install PowerShell Profile
# ------------------------------------------------------
function Install-PowerShell-Profile {
    param($isInstaractive = $true)
    $profilePath = Join-Path $MY_PATH 'Microsoft.PowerShell_profile.ps1'
    Confirm-And-Install `
        -title "Install PowerShell Profile" `
        -srcPath $profilePath `
        -destPath $PROFILE `
        -isDirectory $false `
        -isInteractive $isInstaractive

    $configPath = Join-Path $MY_PATH '.config'
    Confirm-And-Install `
        -title "Install .config directory" `
        -srcPath $configPath `
        -destPath "$env:USERPROFILE\.config" `
        -isDirectory $true `
        -isInteractive $isInstaractive

    $notificationScript = Join-Path $SCRIPT_PATH 'Show-Notification.ps1'
    $notificationDestDirectory = Join-Path $env:USERPROFILE 'bin'
    $notificationDest = Join-Path $notificationDestDirectory 'Show-Notification.ps1'
    Confirm-And-Install `
        -title "Install Show-Notification script" `
        -srcPath $notificationScript `
        -destPath $notificationDest `
        -isDirectory $false `
        -isInteractive $isInstaractive

    $notifyCodexScript = Join-Path $SCRIPT_PATH 'Notify-CodexCompletion.ps1'
    $notifyCodexDest = Join-Path $notificationDestDirectory 'Notify-CodexCompletion.ps1'
    Confirm-And-Install `
        -title "Install Notify-CodexCompletion script" `
        -srcPath $notifyCodexScript `
        -destPath $notifyCodexDest `
        -isDirectory $false `
        -isInteractive $isInstaractive
}

# ------------------------------------------------------
# Install Windows Terminal Settings
# ------------------------------------------------------
function Install-Windows-Terminal-Settings {
    param($isInstaractive = $true)
    $settingPath = Join-Path $MY_PATH 'windows_terminal_settings.json'
    $terminalDest = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    Confirm-And-Install `
        -title "Install Windows Terminal Settings" `
        -srcPath $settingPath `
        -destPath $terminalDest `
        -isDirectory $false `
        -isInteractive $isInstaractive
}

# ------------------------------------------------------
# Install vimrc
# ------------------------------------------------------
function Install-Vimrc {
    param($isInstaractive = $true)
    $vimrcPath = Join-Path $MY_PATH '.vimrc'
    Confirm-And-Install `
        -title "Install .vimrc" `
        -srcPath $vimrcPath `
        -destPath "$env:USERPROFILE\.vimrc" `
        -isDirectory $false `
        -isInteractive $isInstaractive

    $vimPath = Join-Path $MY_PATH '.vim'
    Confirm-And-Install `
        -title "Install vimfiles directory" `
        -srcPath $vimPath `
        -destPath "$env:USERPROFILE\vimfiles" `
        -isDirectory $true `
        -isInteractive $isInstaractive

    $gvimrcPath = Join-Path $MY_PATH '_gvimrc'
    Confirm-And-Install `
        -title "Install _gvimrc" `
        -srcPath $gvimrcPath `
        -destPath "$env:USERPROFILE\_gvimrc" `
        -isDirectory $false `
        -isInteractive $isInstaractive
}

# ------------------------------------------------------
# Install Neovim Settings
# ------------------------------------------------------
function Install-Neovim-Settings {
    param($isInstaractive = $true)
    $nvimSource = Join-Path $MY_PATH 'nvim'
    $nvimDest = "$env:USERPROFILE\AppData\Local\nvim"
    Confirm-And-Install `
        -title "Install Neovim settings" `
        -srcPath $nvimSource `
        -destPath $nvimDest `
        -isDirectory $true `
        -isInteractive $isInstaractive
}


if ($args.Count -eq 0) {
    Install-Fonts
    Install-Development-Tools
    Install-PowerShell-Profile
    Install-Windows-Terminal-Settings
    Install-Vimrc
    Install-Neovim-Settings
} else {
    foreach ($arg in $args) {
        switch ($arg) {
            'fonts' { Install-Fonts $false }
            'devtools' { Install-Development-Tools $false }
            'profile' { Install-PowerShell-Profile }
            'terminal' { Install-Windows-Terminal-Settings }
            'vimrc' { Install-Vimrc }
            'nvim' { Install-Neovim-Settings }
            default { Write-Host "Unknown argument: $arg"
                      Write-Host "Usage: install.ps1 {options...}"
                      Write-Host "Available options: fonts, devtools, profile, terminal, vimrc, nvim" }
        }
    }
}
