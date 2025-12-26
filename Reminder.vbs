' Get the folder of this VBS script
Set objFSO = CreateObject("Scripting.FileSystemObject")
scriptFolder = objFSO.GetParentFolderName(WScript.ScriptFullName)

' Build full path to Reminder.ps1 in the same folder
ps1Path = scriptFolder & "\Reminder.ps1"

' Run PowerShell script hidden
Set objShell = CreateObject("Wscript.Shell")
objShell.Run "powershell.exe -STA -ExecutionPolicy Bypass -File """ & ps1Path & """", 0, False
