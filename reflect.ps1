#
#        https://renenyffenegger.ch/notes/Microsoft/dot-net/namespaces-classes/System/Reflection/reflect_ps1
#

param (
   $type
)

set-strictMode -version latest


if ($type -is [string]) {

   if ($type -match '^\[(.*)\]$') {
      $typeObj =  ([psObject].Assembly.GetType('System.Management.Automation.TypeAccelerators')::Get)[$matches[1]]
   }
   else {
      $typeObj = [type]::GetType(
         $type,  # typeName
         $false, # throwOnError
         $true   # ignoreCase
      )


      if ($typeObj -eq $null) {
       #
       # TODO:
       #   Use something like
       #     [AppDomain]::CurrentDomain.GetAssemblies()[0].GetTypes().FullName
       #   to search for partial type names
       #
         foreach ($a in [AppDomain]::CurrentDomain.GetAssemblies()) {

           $typeObj = $a.GetType($type);

           if ($typeObj -ne $null) {
              write-host "found type in asssembly $a, $typeObj"
              break
           }
         }
      }
   }

   if ($typeObj -eq $null) {
      write-host "could not find type $type"
      return
   }

}
elseif ($type -is [type]) {
   $typeObj = $type
}
else {
   write-host ($type.GetType())
   $typeObj = $type
   return
}


$baseTypeObj = $typeObj.BaseType
while ( $baseTypeObj -ne $null) {
   write-host "  $($baseTypeObj.FullName)"
   $baseTypeObj = $baseTypeObj.BaseType
}

write-host ''
write-host 'Implemented interfaces'
foreach ($if in $typeObj.ImplementedInterfaces) {
   write-host "  $($if.FullName)"
}

  write-host ''

  write-host "Class             $($typeObj.IsClass              )"
  write-host "Enum              $($typeObj.IsEnum               )"
  write-host "Interface         $($typeObj.IsInterface          )"
  write-host "COMObject         $($typeObj.IsCOMObject          )"
  write-host "Visible           $($typeObj.IsVisible            )"

# write-host "NotPublic         $($typeObj.IsNotPublic          )"
  write-host "Public            $($typeObj.IsPublic             )"

  write-host "NestedPublic      $($typeObj.IsNestedPublic       )"
  write-host "NestedPrivate     $($typeObj.IsNestedPrivate      )"
  write-host "NestedFamily      $($typeObj.IsNestedFamily       )"
  write-host "NestedAssembly    $($typeObj.IsNestedAssembly     )"
  write-host "NestedFamANDAssem $($typeObj.IsNestedFamANDAssem  )"
  write-host "NestedFamORAssem  $($typeObj.IsNestedFamORAssem   )"

  write-host "AutoLayout        $($typeObj.IsAutoLayout         )"
  write-host "LayoutSequential  $($typeObj.IsLayoutSequential   )"
# write-host "ExplicitLayout    $($typeObj.IsExplicitLayout     )"

# write-host "ValueType         $($typeObj.IsValueType          )"
  write-host "Abstract          $($typeObj.IsAbstract           )"
  write-host "Sealed            $($typeObj.IsSealed             )"
# write-host "SpecialName       $($typeObj.IsSpecialName        )"
# write-host "Import            $($typeObj.IsImport             )"
  write-host "Serializable      $($typeObj.IsSerializable       )"
  write-host "AnsiClass         $($typeObj.IsAnsiClass          )"
# write-host "UnicodeClass      $($typeObj.IsUnicodeClass       )"
  write-host "AutoClass         $($typeObj.IsAutoClass          )"
# write-host "Array             $($typeObj.IsArray              )"
  write-host "ByRef             $($typeObj.IsByRef              )"
  write-host "Pointer           $($typeObj.IsPointer            )"
  write-host "Primitive         $($typeObj.IsPrimitive          )"

# write-host "attributes:       $($typeObj.attributes)"


write-host ''
write-host 'Constructors'
foreach ($ctor in $typeObj.DeclaredConstructors) {
   write-host "  -"
   foreach ($param in $ctor.GetParameters()) {
      write-host ('     {0,-40} {1}'  -f  $($param.name), $($param.parameterType))
   }
}


write-host ''
write-host 'Methods'
foreach ($meth in $typeObj.DeclaredMethods) {
   write-host ('   {0,-30} {1}' -f $meth.name, $meth.ReturnType)

   $writeNewLine = $false
   foreach ($param in $meth.GetParameters()) {
      write-host ('     {0,-40} {1}'  -f  $($param.name), $($param.parameterType))
      $writeNewLine = $true
   }
   if ($writeNewLine) {
      write-host ''
   }
}

write-host ''
write-host 'Properties'
foreach ($prop in $typeObj.DeclaredProperties) {
   write-host ('   {2}{3} {0,-39} {1}'  -f  $($prop.name), $($prop.PropertyType), $( if ($prop.CanRead) { 'r' } else { ' '} ), $(if($prop.CanWrite) { 'w'} else { ' ' }))
}

write-host ''
write-host 'Fields'
foreach ($fld in $typeObj.DeclaredFields) {
   write-host ('   {2,-7} {0,-34} {1}'  -f  $($fld.name), $($fld.FieldType), $( if ($fld.IsPublic) { 'public' } else { 'private'} ))
}
