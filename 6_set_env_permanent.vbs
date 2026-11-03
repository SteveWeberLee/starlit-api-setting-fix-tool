Option Explicit
Dim fso, shell, ps1, f
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")
ps1 = fso.GetSpecialFolder(2) & "\deepseek_step6.ps1"
Set f = fso.CreateTextFile(ps1, True, False)

f.WriteLine "$ErrorActionPreference = 'Continue'"
f.WriteLine "$raw = Get-Clipboard"
f.WriteLine "$key = ($raw -replace '[^a-zA-Z0-9\-]','').Trim()"
f.WriteLine "if (-not $key.StartsWith(""sk-"") -or $key.Length -lt 30) {"
f.WriteLine "  Write-Host ""Key format looks BAD. Not set."""
f.WriteLine "  Read-Host ""Press Enter to close"""
f.WriteLine "  exit"
f.WriteLine "}"
f.WriteLine "[Environment]::SetEnvironmentVariable(""DEEPSEEK_API_KEY"", $key, ""User"")"
f.WriteLine "Write-Host ""Permanent DEEPSEEK_API_KEY set for current user."""
f.WriteLine "Write-Host ""Open a NEW PowerShell window before starting DSH."""
f.WriteLine "Read-Host ""Press Enter to close"""
f.Close

shell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -File """ & ps1 & """", 1, True
On Error Resume Next
fso.DeleteFile ps1