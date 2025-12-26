$interval = 1200
$remaining = $interval
$global:running = $true
$global:exitProgram = $false
$global:startTime = Get-Date  # initial start time

Write-Host "Reminder started. Press Ctrl+C to stop." -ForegroundColor Green

# -------------------------------
# Tray Icon and Context Menu
# -------------------------------
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$notifyIcon = New-Object System.Windows.Forms.NotifyIcon

# -------------------------------
# Set custom icon from current folder
# -------------------------------
$notifyIcon.Icon = New-Object System.Drawing.Icon("$PSScriptRoot\reminder.ico")

$notifyIcon.Visible = $true
$notifyIcon.Text = "Reminder Running since " + $global:startTime.ToString("HH:mm")

$menu = New-Object System.Windows.Forms.ContextMenu
$startItem = New-Object System.Windows.Forms.MenuItem("Start")
$stopItem  = New-Object System.Windows.Forms.MenuItem("Stop")
$exitItem  = New-Object System.Windows.Forms.MenuItem("Exit")
$menu.MenuItems.AddRange(@($startItem, $stopItem, "-", $exitItem))
$notifyIcon.ContextMenu = $menu

# -------------------------------
# Menu event handlers
# -------------------------------
$startItem.add_Click({
    if (-not $global:running) {
        $global:running = $true
        $global:startTime = Get-Date
        $notifyIcon.Text = "Reminder Running since " + $global:startTime.ToString("HH:mm")
        Write-Host "Timer started at $($global:startTime.ToString('HH:mm'))"
    }
})

$stopItem.add_Click({
    if ($global:running) {
        $global:running = $false
        $notifyIcon.Text = "Reminder Paused"
        Write-Host "Timer paused"
    }
})

$exitItem.add_Click({
    $global:exitProgram = $true
    Write-Host "Exiting..."
})

# -------------------------------
# Main timer loop
# -------------------------------
while (-not $global:exitProgram) {
    Start-Sleep -Seconds 1

    if ($global:running) {
        $remaining--
        Write-Host "Remaining: $remaining"

        if ($remaining -le 0) {
            [System.Windows.Forms.MessageBox]::Show("Time to take a break!", "Reminder", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
            $remaining = $interval
        }
    }

    # Process Tray events
    [System.Windows.Forms.Application]::DoEvents()
}

# -------------------------------
# Clean up Tray before exit
# -------------------------------
$notifyIcon.Visible = $false
$notifyIcon.Dispose()
