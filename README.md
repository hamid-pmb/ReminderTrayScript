# Reminder Tray Script

A PowerShell script that runs in the Windows tray and shows a reminder with Start/Stop status.

## ✨ Features
- Tray icon with context menu (Start, Stop, Exit)
- Shows current system time when started
- Displays status in tooltip (`Status: Started at HH:mm` or `Status: Stopped`)
- Hidden execution via VBS wrapper
- Can be set to run automatically at Windows startup

## 📂 Files
- `Reminder.ps1` → Main PowerShell script
- `Reminder.vbs` → Wrapper to run the script hidden
- `README.md` → Documentation

## 🚀 Usage
1. Run `Reminder.vbs` to start the script hidden (no PowerShell window).
2. Right-click the tray icon to control **Start / Stop / Exit**.
3. Tooltip shows current status:
   - `Status: Started at HH:mm` → when started
   - `Status: Stopped` → when stopped

## 🔄 Auto Start
To run automatically when Windows starts:
- Copy `Reminder.vbs` to: C:\Users<YourUser>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

- - Or create a Task Scheduler entry with trigger **At logon**.

## 📦 Release
Download the latest version from the Releases section.  
Each release includes:
- `Reminder.ps1`
- `Reminder.vbs`
- `README.md`

## 📝 Notes
- Tooltip text must be under 63 characters (Windows limitation).
- Script uses `System.Windows.Forms.NotifyIcon` for tray integration.
