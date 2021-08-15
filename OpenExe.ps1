$nameExe=@(Get-ChildItem | Where-Object -property name -Like "*.exe" | Get-ChildItem -name)
for ($i = 1; $i -lt $nameExe.Count; $i++)
{ 
    Start-Process -filepath $nameExe[$i] -ArgumentList '/silent', '/install' -Wait
    Write-output "instalando" $nameExe[$i]
} 
