#
#   V0.7
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
#   $regkeyNoColon = 'hkcu\environment'
    $regkeyNoColon = 'hkey_current_user\environment'
}
elseif ($regkey -eq 'machineenv') {
    $regkeyNoColon = 'hkey_local_machine\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
}
else {

   $regKey = $regKey -replace '^Computer\\'          , ''

   $regKey = $regKey -replace '^hkey_local_machine\b', 'hklm'
   $regKey = $regKey -replace '^hkey_current_us r\b' , 'hkcu'
   $regKey = $regKey -replace '^hkey_classes_root\b' , 'hkcr'

   $regKey = $regKey -replace '\\$', ''
   $regKey = $regKey -replace '/$' , ''

   $regkeyColon   = $regKey        -replace '^hkcu:?'  , 'hkcu:'
   $regKeyColon   = $regKeyColon   -replace '^hklm:?'  , 'hklm:'
   $regKeyColon   = $regKeyColon   -replace '^hkcr:?'  , 'hkcr:'

   $regKeyNoColon = $regKeyColon   -replace '^hkcu:'   , 'hkey_current_user'  # 'hkcu'
   $regKeyNoColon = $regKeyNoColon -replace '^hklm:'   , 'hkey_local_machine' # 'hklm'
   $regKeyNoColon = $regKeyNoColon -replace '^hkcr:'   , 'hkey_classes_root'  # 'hkcr'

   $regKeyNoColon = $regKeyNoColon -replace '/', '\'

   if ($regKeyColon -match '^hkcr') {
      $null = new-psDrive -name hkcr -psProvider registry -root HKEY_CLASSES_ROOT
   }

   if (-not (test-path $regkeyColon) ) {
      write-host "Registry key $regKeyColon does not exist"
      return
   }
}



write-host "open registry at $regKeyNoColon"
if (! (test-path HKCU:\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit)) {
   write-host "HKCU:\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit does not exit, creating it"
   $null = new-item HKCU:\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit
}
set-itemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit  LastKey $regKeyNoColon

& regedit -m
