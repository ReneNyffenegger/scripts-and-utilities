#
#   V0.4
#

param (
   [parameter(
        mandatory                  =$true,
        valueFromRemainingArguments=$true
   )]
   [string[]] $regKeyParts
)

set-strictMode -version 3

$regKey = $regKeyParts -join ' '

if ($regKey -eq 'userenv') {
    $regkeyNoColon = 'hkcu\environment'
}
elseif ($regkey -eq 'machineenv') {
    $regkeyNoColon = 'hklm\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
}
else {

   $regKey = $regKey -replace '^hkey_local_machine\b', 'hklm'
   $regKey = $regKey -replace '^hkey_current_user\b' , 'hkcu'
   $regKey = $regKey -replace '^hkey_classes_root\b' , 'hkcr'

   $regKey = $regKey -replace '\\$', ''
   $regKey = $regKey -replace '/$' , ''

   $regkeyColon   = $regKey        -replace '^hkcu:?'  , 'hkcu:'
   $regKeyColon   = $regKeyColon   -replace '^hklm:?'  , 'hklm:'
   $regKeyColon   = $regKeyColon   -replace '^hkcr:?'  , 'hkcr:'

   $regKeyNoColon = $regKeyColon   -replace '^hkcu:'   , 'hkcu'
   $regKeyNoColon = $regKeyNoColon -replace '^hklm:'   , 'hklm'
   $regKeyNoColon = $regKeyNoColon -replace '^hkcr:'   , 'hkcr'

   if ($regKeyColon -match '^hkcr') {
      $null = new-psDrive -name hkcr -psProvider registry -root HKEY_CLASSES_ROOT
   }

   if (-not (test-path $regkeyColon) ) {
      write-host "Registry key $regKey does not exist"
      return
   }
}

write-host "open registry at $regKeyNoColon"
set-itemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit  LastKey $regKeyNoColon

& regedit -m
