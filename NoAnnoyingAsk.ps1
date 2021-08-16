
$path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$property = "ConsentPromptBehaviorAdmin"
$testPath = "Test-Path -Path $path"
$propertyExists = Get-ItemProperty -Path $path -Name $property

if ($testPath -eq $true)
{
    Set-ItemProperty -Path $path -Name $property -Value 0
}

elseif ($propertyExists.ConsentPromptBehaviorAdmin -eq 0)
{
    Write-Output "The system is already configured"    
}

else
{

    New-Item -ItemType Directory -Path $path
    new-ItemProperty -Path $path -Name $property -Value 0
}
