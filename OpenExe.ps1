$nameExe=Get-ChildItem | Where-Object {$_.Name -Like "*.exe"}
foreach ($executable in $nameExe)
{ 
    Start-Process -FilePath $executable -ArgumentList '/silent', '/install' -Wait
    Write-Output "Instalando" $executable "`n"
} 
