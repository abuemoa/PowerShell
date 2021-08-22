[string]$user = Read-Host -Prompt "Introduzca el nombre de pila de los usuarios que desee crear"
[int]$amount = Read-Host -Prompt "Introduzca la cantidad de usuarios que desee crear"
[int]$start = Read-Host -Prompt "Introduzca el número de usuario inicial"
$passwd = Read-Host -Prompt "Introduzca la contraseña de todas las cuentas"

for ($i = $start; $i -le $amount + $start; $i++)
  {
    New-ADUser -Name $user$i -DisplayName $user$i -Enabled $true -AccountPassword $passwd -PasswordNeverExpires $true
  }
  
Write-Host "Se han creado $amount usuarios"
