Write-Host "PROGRAMA PARA ADMINISTRAR USUARIOS LOCALES"

$forOptions=Read-Host -Prompt "
¿Qué acción desea realizar?`n
1) Crear un nuevo usuario
2) Renombrar un usuario existente
3) Cambiar la contraseña
4) Activar un usuario
5) Desactivar un usuario
6) Eliminar un usuario
7) Mostrar los usuarios actuales
Escriba el número"


if ($forOptions -eq 1)
{
    Write-Host "Lista de usuarios actuales"

    $name=Read-Host -prompt "Escriba el nombre de usuario"
    $fullName=Read-Host -Prompt "Escriba el nombre completo"
    $passwd=Read-Host -AsSecureString "Escriba su contraseña. `nSi no escribe contraseña alguna, esta quedará en blanco"      
    $description=Read-Host -Prompt "Escriba una descripción del usuario"
    $accountExpire=Read-Host -Prompt "¿Desea que la cuenta caduque? Sí(s), No(n)"
    if ($accountExpire -eq "s")
    {
        $expireDateDay=Read-Host -Prompt "Escriba el día de caducidad en formato de dos dígitos"
        $expireDateMonth=Read-Host -Prompt "Escriba el mes de caducidad en formato de dos dígitos"
        $expireDateYear=Read-Host -Prompt "Escriba el día de caducidad en formato de cuatro dígitos"
    }
    
        if ($accountExpire -eq "s")
    {
        $expireDateDay=Read-Host -Prompt "Escriba el día de caducidad en formato de dos dígitos"
        $expireDateMonth=Read-Host -Prompt "Escriba el mes de caducidad en formato de dos dígitos"
        $expireDateYear=Read-Host -Prompt "Escriba el día de caducidad en formato de cuatro dígitos"
        New-LocalUser -Name $name -FullName $fullName -Password $passwd -Description $description -AccountExpires $expireDateDay/$expireDateMonth/$expireDateYear -Verbose
    }
        else {
        New-LocalUser -Name $name -FullName $fullName -Password $passwd -Description $description -AccountNeverExpires -Verbose
    }
    }



elseif ($forOptions -eq 2) {
    Get-LocalUser | Select-Object -Property Name 
    $name=Read-Host -prompt "Escriba el nombre de usuario antiguo"
    $newName=Read-Host -prompt "Escriba el nombre de usuario nuevo"
    Rename-LocalUser -Name $name -NewName $newName
}

elseif ($forOptions -eq 3) {
    $name=Read-Host "Escriba el usuario"
    $passwd=Read-Host -AsSecureString "Escriba su contraseña"
    Set-LocalUser -Name $name -Password $passwd
}

elseif ($forOptions -eq 4) {
    $name=Read-Host "Escriba el usuario que quiera activar"
    Disable-LocalUser -Name $name 
}

elseif ($forOptions -eq 5) {
    $name=Read-Host "Escriba el usuario que quiera desactivar"
    Disable-LocalUser -Name $name 
}

elseif ($forOptions -eq 6) {
    Write-Host "Ha elegido eliminar un usuario"
    $deleteUser=Read-Host "¿Qué usuario quiere eliminar?`n"
    Get-LocalUser | Where-Object {$_.Name -eq $deleteUser} | Format-List -Property *
    $Reminder=Read-Host -Prompt "¿Está seguro que quiere eliminar el usuario?`n Sí(s), No(n)"
        if ($Reminder -eq "s")
          {
              Remove-LocalUser -Name $deleteUser -Verbose
          }
        else 
            {
            Write-Host "`nEliminación del usuario $deleteuser cancelada por el usuario"
            }
}
else {
    Get-LocalUser | Select-Object -Property Name
    }

 # el valor 7 tiene que repetirse siempre hasta que se seleccione otra opción
 # Hay que darle el valor 8 para que salga del script.
