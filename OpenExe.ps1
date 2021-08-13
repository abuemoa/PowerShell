$nameExe=@(Get-ChildItem | Where-Object -property name -Like "*.exe" | Get-ChildItem -name)
$numProgramsExe=$nameExe | Measure-Object -Line | Select-Object -Expand Lines

for ($i = 1; $i -lt $numProgramsExe; $i++)
{ 
    Start-Process -filepath $nameExe[$i] -ArgumentList '/silent', '/install' -Wait
    Write-output "instalando" $nameExe[$i]
} 
