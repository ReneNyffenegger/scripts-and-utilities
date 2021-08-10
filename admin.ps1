param (
   [alias('?')] [switch] $amI
)

set-strictMode -version 3

if ($amI) {

   $curIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
   $principal   = new-object System.Security.Principal.WindowsPrincipal $curIdentity
   $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

   return
}

# Start same powershell executable as administrator
function admin() {
   $ps_exe = (get-process -pid $pid).path
   start-process $ps_exe -verb runAs
}
