Write-Host "PROGRAMA PARA ADMINISTRAR USUARIOS LOCALES"

$forOptions = Read-Host -Prompt "
¿Qué acción desea realizar?`n
1) Crear un nuevo usuario
2) Renombrar un usuario existente
3) Cambiar la contraseña
4) Activar un usuario
5) Desactivar un usuario
6) Eliminar un usuario
7) Añadir un usuario a un grupo
8) Eliminar un usuario de un grupo
9) Mostrar todos los grupos y sus miembros
Escriba el número`n"

$listUsers = (Get-LocalUser).Name

if ($forOptions -eq 1)
{
    Write-Host "Muestra de usuarios actuales:`n "
    $listUsers
    $name = Read-Host -prompt "`nEscriba el nombre del nuevo usuario"
    $fullName = Read-Host -Prompt "Escriba el nombre completo"
    $passwd = Read-Host -AsSecureString "Escriba su contraseña. `nSi no escribe contraseña alguna, esta quedará en blanco"      
    $description = Read-Host -Prompt "Escriba una descripción del usuario"
    $accountExpire = Read-Host -Prompt "¿Desea que la cuenta caduque? Sí(s), No(n)"
    if ($accountExpire -eq "s")
    {
        $expireDateDay = Read-Host -Prompt "Escriba el día de caducidad en formato de dos dígitos"
        $expireDateMonth = Read-Host -Prompt "Escriba el mes de caducidad en formato de dos dígitos"
        $expireDateYear = Read-Host -Prompt "Escriba el día de caducidad en formato de cuatro dígitos"
    }
    
        if ($accountExpire -eq "s")
    {
        $expireDateDay = Read-Host -Prompt "Escriba el día de caducidad en formato de dos dígitos"
        $expireDateMonth = Read-Host -Prompt "Escriba el mes de caducidad en formato de dos dígitos"
        $expireDateYear = Read-Host -Prompt "Escriba el día de caducidad en formato de cuatro dígitos"
        New-LocalUser -Name $name -FullName $fullName -Password $passwd -Description $description -AccountExpires -PasswordNeverExpires $expireDateDay/$expireDateMonth/$expireDateYear -Verbose
    }
        else {
        New-LocalUser -Name $name -FullName $fullName -Password $passwd -Description $description -AccountNeverExpires -PasswordNeverExpires -Verbose 
    }
    $prompGroup = Read-Host "¿Quiere añadir el usuario a algún grupo? Sí(s), No(n)"
        if ($promptGroup = "s")
        {
            Write-Host "Escriba uno de los siguientes grupos`n"
            (Get-LocalGroup).Name
            $writeGroup = Read-Host 
            Add-LocalGroupMember -Name $writeGroup -Member $name
        }
}



elseif ($forOptions -eq 2) {
    Get-LocalUser | Select-Object -Property Name 
    $name = Read-Host -prompt "Escriba el nombre de usuario antiguo"
    $newName = Read-Host -prompt "Escriba el nombre de usuario nuevo"
    Rename-LocalUser -Name $name -NewName $newName
}

elseif ($forOptions -eq 3) {
    $name = Read-Host "Escriba el usuario"
    $passwd = Read-Host -AsSecureString "Escriba su contraseña"
    Set-LocalUser -Name $name -Password $passwd
}

elseif ($forOptions -eq 4) {
    $name = Read-Host "Escriba el usuario que quiera activar"
    Disable-LocalUser -Name $name 
}

elseif ($forOptions -eq 5) {
    $name = Read-Host "Escriba el usuario que quiera desactivar"
    Disable-LocalUser -Name $name 
}

elseif ($forOptions -eq 6) {
    Write-Host "Ha elegido eliminar un usuario"
    $deleteUser = Read-Host "¿Qué usuario quiere eliminar?`n"
    Get-LocalUser | Where-Object {$_.Name -eq $deleteUser} | Format-List -Property *
    $Reminder = Read-Host -Prompt "¿Está seguro que quiere eliminar el usuario?`n Sí(s), No(n)"
        if ($Reminder -eq "s")
          {
              Remove-LocalUser -Name $deleteUser -Verbose
          }
        else 
            {
            Write-Host "`nEliminación del usuario $deleteuser cancelada por el usuario"
            }
}

#Point buttons 7 and 8 are yet to be polished

elseif ($forOptions -eq 7) {
$arrayGroup = @((Get-LocalGroup).Name)
(Get-LocalGroup).Name
Write-Host "`nEscriba el nombre del grupo`n"
do
    {
    
    $writeGroup = Read-Host 
        if ($arrayGroup -notcontains $writeGroup)
        {
            (Get-LocalGroup).Name
            Write-Host "`nEl grupo $writeGroup no existe. Escriba de nuevo el nombre del grupo`n"
        }
    }
while ($arrayGroup -notcontains $writeGroup)

$arrayUser = @((Get-LocalUser).Name)

(Get-LocalUser).Name
Write-Host "`nEscriba el nombre del usuario`n"
do
    {
    $user = Read-Host 
        if ($arrayUser -notcontains $user)
        {
            (Get-LocalGroup).Name
            Write-Host "`nEl usuario $user no existe. Escriba de nuevo el nombre del usuario`n"
        }
    }
while ($arrayUser -notcontains $user)


$conditionGroup = @((Get-LocalGroupMember -Group $writeGroup).Name | %{ $_.Split('\')[1]; })


if ($conditionGroup -contains $user) {
    Write-Host "El usuario $user no se encuentra en el grupo $writeGroup y por ello no será añadido"

}
else {
    Add-LocalGroupMember -Group $writeGroup -Member $user
    Write-Host "Usuario $user ha sido añadido al grupo $writeGroup"
}
}



elseif ($forOptions -eq 8) {
$arrayGroup = @((Get-LocalGroup).Name)
(Get-LocalGroup).Name
Write-Host "`nEscriba el nombre del grupo`n"
do
    {
    $writeGroup = Read-Host 
        if ($arrayGroup -notcontains $writeGroup)
        {
            (Get-LocalGroup).Name
            Write-Host "`nEl grupo $writeGroup no existe. Escriba de nuevo el nombre del grupo`n"
        }
    }
while ($arrayGroup -notcontains $writeGroup)

$arrayUser = @((Get-LocalUser).Name)

(Get-LocalUser).Name
Write-Host "`nATENCIÓN, ESTÁ A PUNTO DE ELIMINAR UN USUARIO DE UN GRUPO. ESTO PODRÍA AFECTAR AL CORRECTO FUNCIONAMIENTO DEL SISTEMA.`n
`nEscriba el nombre del usuario`n"
do
    {
    $user = Read-Host 
        if ($arrayUser -notcontains $user)
        {
            (Get-LocalGroup).Name
            Write-Host "`nEl usuario $user no existe. Escriba de nuevo el nombre del usuario`n"
        }
    }
while ($arrayUser -notcontains $user)

$conditionGroup = @((Get-LocalGroupMember -Group $writeGroup).Name | %{ $_.Split('\')[1]; })


if ($conditionGroup -contains $user) {
    Remove-LocalGroupMember -Group $writeGroup -Member $user
    Write-Host "Usuario $user eliminado del grupo $writeGroup"
}
else {
    Write-Host "El usuario $user no se encuentra en el grupo $writeGroup y por ello no será eliminado"
}

}


elseif ($forOptions -eq 9) {
   
$arrayGroup = @((Get-LocalGroup).Name)

for ($i = 0; $i -lt $arrayGroup.Count; $i++)
{ 

if ([string]::IsNullOrEmpty((Get-LocalGroupMember -Group $arrayGroup[$i]).Name))
{
 
}
else { 

    Write-host -ForegroundColor Green "`nGrupo" $arrayGroup[$i] 
    (Get-LocalGroupMember -Group $arrayGroup[$i]).Name | %{ $_.Split('\')[1]; }
}
}

}

else {
    Write-Host "Seleccione una de las opciones utilizando los números señalados arriba"
   
}


