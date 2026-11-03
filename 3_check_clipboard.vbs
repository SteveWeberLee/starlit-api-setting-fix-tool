Option Explicit
Dim fso, shell, ps1, f
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")
ps1 = fso.GetSpecialFolder(2) & "\deepseek_step3.ps1"
Set f = fso.CreateTextFile(ps1, True, False)

f.WriteLine "$ErrorActionPreference = 'Continue'"
f.WriteLine "$raw = Get-Clipboard"
f.WriteLine "Write-Host ""Raw length: $($raw.Length)"""
f.WriteLine "if ($raw.Length -ge 3) { Write-Host ""Raw start: $($raw.Substring(0,3))"" }"
f.WriteLine "if ($raw.Length -ge 4) { Write-Host ""Raw tail: $($raw.Substring($raw.Length-4))"" }"
f.WriteLine "$clean = ($raw -replace '[^a-zA-Z0-9\-]','').Trim()"
f.WriteLine "Write-Host ""Clean length: $($clean.Length)"""
f.WriteLine "if ($clean.Length -ge 3) { Write-Host ""Clean start: $($clean.Substring(0,3))"" }"
f.WriteLine "if ($clean.Length -ge 4) { Write-Host ""Clean tail: $($clean.Substring($clean.Length-4))"" }"
f.WriteLine "if ($clean.StartsWith(""sk-"") -and $clean.Length -ge 30) { Write-Host ""Format looks OK"" } else { Write-Host ""Format looks BAD"" }"
f.WriteLine "Read-Host ""Press Enter to close"""
f.Close

shell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -File """ & ps1 & """", 1, True
On Error Resume Next
fso.DeleteFile ps1