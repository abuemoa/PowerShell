
$nameMsi=@(Get-ChildItem | Where-Object -property name -Like "*.msi" | Get-ChildItem -name)
$numProgramsMsi=$nameMsi | Measure-Object -Line | Select-Object -Expand Lines

for ($i = 0; $i -lt $numProgramsMsi; $i++)
{ 
    Write-Output "Instalando" $nameMsi[$i] "`n...."
    $params = '/i', $nameMsi[$i], '/qb!'
    $p = Start-Process 'msiexec.exe' -ArgumentList $params -NoNewWindow -Wait -PassThru
    $ExitCode = $p.ExitCode
        if ($ExitCode = 1)
            {
            Write-Output $nameMsi[$i] "instalado con éxito`n" 
            }
        else 
            {
            Write-Output $nameMsi[$i] "no se ha instalado`n"
            } 
}

Write-Output "Eliminamos OneDrive, y otros programas"
get-appxpackage *Microsoft.skypeapp* | remove-appxpackage
get-appxpackage *Microsoft.XboxGamingOverlay* | remove-appxpackage
get-appxpackage *Microsoft.Zunemusic* | remove-appxpackage
get-appxpackage *Microsoft.office.onenote* | remove-appxpackage
get-appxpackage *Microsoft.Xbox.TCUI* | remove-appxpackage


