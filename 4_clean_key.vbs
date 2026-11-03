Option Explicit
Dim fso, shell, ps1, f
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")
ps1 = fso.GetSpecialFolder(2) & "\deepseek_step4.ps1"
Set f = fso.CreateTextFile(ps1, True, False)

f.WriteLine "$ErrorActionPreference = 'Continue'"
f.WriteLine "$raw = Get-Clipboard"
f.WriteLine "$key = ($raw -replace '[^a-zA-Z0-9\-]','').Trim()"
f.WriteLine "Write-Host ""Clean length: $($key.Length)"""
f.WriteLine "if ($key.Length -ge 3) { Write-Host ""Clean start: $($key.Substring(0,3))"" }"
f.WriteLine "if ($key.Length -ge 4) { Write-Host ""Clean tail: $($key.Substring($key.Length-4))"" }"
f.WriteLine "if ($key.StartsWith(""sk-"") -and $key.Length -ge 30) {"
f.WriteLine "  Set-Clipboard $key"
f.WriteLine "  Write-Host ""Clean key copied back to clipboard."""
f.WriteLine "} else {"
f.WriteLine "  Write-Host ""Key format looks BAD. Clipboard not changed."""
f.WriteLine "}"
f.WriteLine "Read-Host ""Press Enter to close"""
f.Close

shell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -File """ & ps1 & """", 1, True
On Error Resume Next
fso.DeleteFile ps1