$nameExe=@(Get-ChildItem | Where-Object {$_.Name -Like "*.exe"})
for ($i = 1; $i -lt $nameExe.Count; $i++)
{ 
    Start-Process -FilePath $nameExe.Name[$i] -ArgumentList '/silent', '/install' -Wait
    Write-Output "Instalando" $nameExe.Name[$i] "`n"
} 
