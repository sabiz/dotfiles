param(
    [Parameter(Position = 0)]
    [string]$Title = "Notification",

    [Parameter(Position = 1)]
    [string]$Message = "Hello from PowerShell.",

    [Parameter(Position = 2)]
    [ValidateRange(1, 60)]
    [int]$DurationSeconds = 5,

    [Parameter(Position = 3)]
    [ValidateSet("None", "Info", "Warning", "Error")]
    [string]$Icon = "Info"
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$notifyIcon = New-Object System.Windows.Forms.NotifyIcon

try {
    $notifyIcon.Visible = $true
    $notifyIcon.BalloonTipTitle = $Title
    $notifyIcon.BalloonTipText = $Message
    $notifyIcon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::$Icon

    switch ($Icon) {
        "None" { $notifyIcon.Icon = [System.Drawing.SystemIcons]::Application }
        "Info" { $notifyIcon.Icon = [System.Drawing.SystemIcons]::Information }
        "Warning" { $notifyIcon.Icon = [System.Drawing.SystemIcons]::Warning }
        "Error" { $notifyIcon.Icon = [System.Drawing.SystemIcons]::Error }
    }

    $notifyIcon.ShowBalloonTip($DurationSeconds * 1000)

    $end = (Get-Date).AddSeconds($DurationSeconds)
    while ((Get-Date) -lt $end) {
        Start-Sleep -Milliseconds 200
        [System.Windows.Forms.Application]::DoEvents()
    }
}
finally {
    $notifyIcon.Visible = $false
    $notifyIcon.Dispose()
}
