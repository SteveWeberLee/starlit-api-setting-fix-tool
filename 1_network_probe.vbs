Option Explicit
Dim fso, shell, ps1, f
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")
ps1 = fso.GetSpecialFolder(2) & "\deepseek_step1.ps1"
Set f = fso.CreateTextFile(ps1, True, False)

f.WriteLine "$ErrorActionPreference = 'Continue'"
f.WriteLine "Write-Host ""Testing https://api.deepseek.com ..."""
f.WriteLine "try {"
f.WriteLine "  node -e ""fetch('https://api.deepseek.com').then(r=>console.log('HTTP',r.status)).catch(e=>console.error(e.cause))"""
f.WriteLine "} catch {"
f.WriteLine "  Write-Host ""node not found or failed: $_"""
f.WriteLine "}"
f.WriteLine "Read-Host ""Press Enter to close"""
f.Close

shell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -File """ & ps1 & """", 1, True
On Error Resume Next
fso.DeleteFile ps1