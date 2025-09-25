param(
    [Parameter(Position = 0)]
    [string]$EventJson = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($EventJson)) {
    if ([Console]::IsInputRedirected) {
        $EventJson = [Console]::In.ReadToEnd()
    }
}

if ([string]::IsNullOrWhiteSpace($EventJson)) {
    Write-Error "Codex notification event (JSON string) was not provided."
    exit 1
}

try {
    $event = $EventJson | ConvertFrom-Json -Depth 32
} catch {
    Write-Error "Failed to parse JSON: $_"
    exit 1
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$showNotification = Join-Path $scriptDir "Show-Notification.ps1"

if (-not (Test-Path -Path $showNotification)) {
    Write-Error "Show-Notification.ps1 not found: $showNotification"
    exit 1
}

$type = if ([string]::IsNullOrWhiteSpace($event.type)) { "unknown" } else { [string]$event.type }
$icon = "Info"
$titlePrefix = "Codex Notification"

if ($type -match "error|fail|exception") {
    $icon = "Error"
    $titlePrefix = "Codex Error"
} elseif ($type -match "cancel|interrupt|stop") {
    $icon = "Warning"
    $titlePrefix = "Codex Interrupted"
} elseif ($type -match "complete|success|done") {
    $icon = "Info"
    $titlePrefix = "Codex Completed"
}

$title = "$titlePrefix ($type)"

$messageLines = New-Object System.Collections.Generic.List[string]
$messageLines.Add("Event type: $type")

$inputMessages = @()
if ($event.'input-messages') {
    foreach ($input in $event.'input-messages') {
        if (-not [string]::IsNullOrWhiteSpace($input)) {
            $inputMessages += $input
        }
    }
}

if ($inputMessages.Count -gt 0) {
    $messageLines.Add("")
    $messageLines.Add("Instructions:")
    $i = 1
    foreach ($inputMessage in $inputMessages) {
        $messageLines.Add("  $i. $inputMessage")
        $i++
    }
}

if ($event.'last-assistant-message') {
    $messageLines.Add("")
    $messageLines.Add("Last response:")
    $messageLines.Add("  $($event.'last-assistant-message')")
}

if ($messageLines.Count -eq 0) {
    $messageLines.Add("A notification was received from Codex. No detailed information is included.")
}

$MessageText = $messageLines -join [Environment]::NewLine

$maxLines = 25
$messageLinesArray = [System.Text.RegularExpressions.Regex]::Split($MessageText, "\r?\n")
if ($messageLinesArray.Length -gt $maxLines) {
    $MessageText = ($messageLinesArray | Select-Object -First $maxLines) -join [Environment]::NewLine
    $MessageText += [Environment]::NewLine + "...(Message was truncated to $maxLines lines)"
}

try {
    & $showNotification -Title $title -Message $MessageText -DurationSeconds 10 -Icon $icon | Out-Null
} catch {
    Write-Error "Failed to display notification: $_"
    exit 1
}
