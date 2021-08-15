$nameExe=@(Get-ChildItem | Where-Object -property Name -Like "*.exe")
for ($i = 1; $i -lt $nameExe.Count; $i++)
{ 
    Start-Process -filepath $nameExe.Name[$i] -ArgumentList '/silent', '/install' -Wait
    Write-output "instalando" $nameExe.Name[$i] "`n"
} 
