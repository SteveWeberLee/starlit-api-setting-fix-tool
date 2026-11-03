Option Explicit
Dim fso, shell, ps1, f
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")
ps1 = fso.GetSpecialFolder(2) & "\deepseek_step2.ps1"
Set f = fso.CreateTextFile(ps1, True, False)

f.WriteLine "$ErrorActionPreference = 'Continue'"
f.WriteLine "$procKey = $env:DEEPSEEK_API_KEY"
f.WriteLine "$userKey = [Environment]::GetEnvironmentVariable(""DEEPSEEK_API_KEY"",""User"")"
f.WriteLine "function Show-Key($name, $k) {"
f.WriteLine "  if ([string]::IsNullOrWhiteSpace($k)) {"
f.WriteLine "    Write-Host ""$name : not set"""
f.WriteLine "  } else {"
f.WriteLine "    $clean = ($k -replace '\s','').Trim()"
f.WriteLine "    if ($clean.Length -ge 4) { $tail = $clean.Substring($clean.Length-4) } else { $tail = $clean }"
f.WriteLine "    Write-Host ""$name : length=$($clean.Length), tail=$tail"""
f.WriteLine "  }"
f.WriteLine "}"
f.WriteLine "Show-Key ""Process"" $procKey"
f.WriteLine "Show-Key ""User"" $userKey"
f.WriteLine "Read-Host ""Press Enter to close"""
f.Close

shell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -File """ & ps1 & """", 1, True
On Error Resume Next
fso.DeleteFile ps1