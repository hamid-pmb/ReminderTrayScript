Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# NotifyIcon
$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
$notifyIcon.Icon = [System.Drawing.SystemIcons]::Information
$notifyIcon.Visible = $true
$notifyIcon.Text = "Status: Stopped"  # وضعیت اولیه

# Context Menu
$menu = New-Object System.Windows.Forms.ContextMenu
$startItem = New-Object System.Windows.Forms.MenuItem "Start"
$stopItem = New-Object System.Windows.Forms.MenuItem "Stop"
$exitItem = New-Object System.Windows.Forms.MenuItem "Exit"
$menu.MenuItems.AddRange(@($startItem,$stopItem,$exitItem))
$notifyIcon.ContextMenu = $menu

# Variables
$global:running = $false
$interval = 1200
$remaining = $interval

# Timer
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000
$timer.Add_Tick({
    if ($global:running) {
        $remaining--
        if ($remaining -le 0) {
            [System.Windows.Forms.MessageBox]::Show("Take a break!")
            $remaining = $interval
        }
    }
})

# Menu events
$startItem.add_Click({
    $global:running = $true
    $remaining = $interval
    $timer.Start()
    # نمایش ساعت جاری سیستم در Tooltip همراه با وضعیت
    $currentTime = (Get-Date).ToString("HH:mm")
    $notifyIcon.Text = "Status: Started at " + $currentTime
})

$stopItem.add_Click({
    $global:running = $false
    $timer.Stop()
    $notifyIcon.Text = "Status: Stopped"
})

$exitItem.add_Click({
    $notifyIcon.Visible = $false
    $timer.Stop()
    [System.Windows.Forms.Application]::Exit()
})

# Run
[System.Windows.Forms.Application]::Run()