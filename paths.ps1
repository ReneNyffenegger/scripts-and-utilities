#
# Show individual path-components of the PATH environment variable, each on its own line:
#
# V0.2
#

set-strictMode -version 3


function showPaths {
   param (
      [System.EnvironmentVariableTarget] $tgt
   )

   write-host $tgt

   foreach ($p in [System.Environment]::GetEnvironmentVariable('PATH', $tgt) -split ';' ) {
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

showPaths machine
showPaths user
