#
# Show individual path-components of the PATH or PSModulePath environment variable, each on its own line:
#
# V0.4
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

    #
    # Replace environment variables that are enclosed in %...% with their actual value.
    #
      $p_ = [regex]::Replace($p, '%([^%]+)%', {
        param($match)
        invoke-expression "`$env:$($match.Groups[1].Value)"
      })


      if ($p -eq '') {
         write-host "   ! <empty>"
      }
      elseif (test-path -pathType container $p_) {
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
