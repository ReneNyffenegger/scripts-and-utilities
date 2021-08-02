#
#   V0.1
#

param (
   [string] $regKey
)

set-strictMode -version 3

if ($regKey -eq 'userenv') {
    $regkeyNoColon = 'hkcu\environment'
}
elseif ($regkey -eq 'machineenv') {
    $regkeyNoColon = 'hklm\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
}
else {
   $regKey = $regKey -replace '\\$', ''
   $regKey = $regKey -replace '/$' , ''

   $regkeyColon   = $regKey        -replace '^hkcu:?'  , 'hkcu:'
   $regKeyColon   = $regKeyColon   -replace '^hklm:?'  , 'hklm:'

   $regKeyNoColon = $regKeyColon   -replace '^hkcu:'   , 'hkcu'
   $regKeyNoColon = $regKeyNoColon -replace '^hklm:'   , 'hklm'

   if (-not (test-path $regkeyColon) ) {
      write-host "Registry key $regKey does not exist"
      return
   }
}

write-host "open registry at $regKeyNoColon"
set-itemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit  LastKey $regKeyNoColon

& regedit -m
