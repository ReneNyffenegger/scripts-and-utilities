#
# Show individual path-components of the PATH or PSModulePath environment variable, each on its own line:
#
# V0.3
#
param (
   [switch] $psModulePath
)

set-strictMode -version 3

function showPaths {
   param (
      [System.EnvironmentVariableTarget] $tgt,
      [string]                           $var
   )

   write-host $tgt

   foreach ($p in [System.Environment]::GetEnvironmentVariable($var, $tgt) -split ';' ) {
      if ($p -eq '') {
         write-host "   ! <empty>"
      }
      elseif (test-path -pathType container $p) {
         write-host "     $p"
      }
      else {
         write-host "   ! $p"
      }
   }
}

$envVar = 'PATH'
if ($psModulePath) {
   $envVar = 'PSModulePath'
}

showPaths machine $envVar
showPaths user    $envVar
