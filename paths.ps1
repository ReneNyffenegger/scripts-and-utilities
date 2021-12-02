#
# Show individual path-components of the PATH or PSModulePath environment variable, each on its own line:
#
# V0.5
#
param (
   [switch] $psModulePath
)

set-strictMode -version 3

$pathsSeen = @{}

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
      else {

         if (test-path -pathType container $p_) {
             $flagExists = ' '
         }
         else {
             $flagExists = '!'
         }

         if ($pathsSeen[$p_]) {
             $flagSeen = 'x'
         }
         else {
             $flagSeen = ' '
         }
          write-host "  $flagSeen$flagExists $p"
      }

      $pathsSeen[$p_] = $true
   }
}

$envVar = 'PATH'
if ($psModulePath) {
   $envVar = 'PSModulePath'
}

showPaths machine $envVar
showPaths user    $envVar
