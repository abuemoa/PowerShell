$Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
$valueArray = @("{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}", "{59031a47-3f72-44a7-89c5-5595fe6b30ee}", "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}")
$Exist = "Get-ItemProperty -Path $Path"


if ($Exist)
{
foreach ($element in $valueArray)
{    Set-ItemProperty -Path $Path -Name $element -Value 0}
}

Else
{
foreach ($element in $valueArray)
{    Set-ItemProperty -Path $Path -Name $element -Value 0}
}
