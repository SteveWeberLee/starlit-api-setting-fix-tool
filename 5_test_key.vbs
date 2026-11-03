Option Explicit
Dim fso, shell, ps1, f
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")
ps1 = fso.GetSpecialFolder(2) & "\deepseek_step5.ps1"
Set f = fso.CreateTextFile(ps1, True, False)

f.WriteLine "$ErrorActionPreference = 'Continue'"
f.WriteLine "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12"
f.WriteLine "$raw = Get-Clipboard"
f.WriteLine "$key = ($raw -replace '[^a-zA-Z0-9\-]','').Trim()"
f.WriteLine "if (-not $key.StartsWith(""sk-"") -or $key.Length -lt 30) {"
f.WriteLine "  Write-Host ""Key format looks BAD. length=$($key.Length)"""
f.WriteLine "  Read-Host ""Press Enter to close"""
f.WriteLine "  exit"
f.WriteLine "}"
f.WriteLine "$headers = @{ ""Content-Type"" = ""application/json""; ""Authorization"" = ""Bearer $key"" }"
f.WriteLine "$body = '{""model"":""deepseek-chat"",""messages"":[{""role"":""user"",""content"":""ping""}],""max_tokens"":5}'"
f.WriteLine "try {"
f.WriteLine "  $r = Invoke-RestMethod -Uri ""https://api.deepseek.com/chat/completions"" -Method Post -Headers $headers -Body $body"
f.WriteLine "  Write-Host ""SUCCESS: key is valid."""
f.WriteLine "} catch {"
f.WriteLine "  Write-Host ""FAILED: $($_.Exception.Message)"""
f.WriteLine "}"
f.WriteLine "Read-Host ""Press Enter to close"""
f.Close

shell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -File """ & ps1 & """", 1, True
On Error Resume Next
fso.DeleteFile ps1