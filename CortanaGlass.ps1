#Reduce magGlass of Cortana 

$ruta = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
$lupa = "SearchboxTaskbarMode"

$Exist = "Get-ItemProperty -Path $ruta"



if ($Exist)
{
    Set-ItemProperty -Path $ruta -Name $lupa -Value 1

}
Else
{
    New-ItemProperty -Path $ruta -Name $lupa -Value 1
}
