#
# Show individual path-components of the PATH or PSModulePath environment variable, each on its own line:
#
# V0.7a
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

      if ($tgt -eq 'process' -and $pathsSeen[$p_]) {
        #
        # Special case for paths in process environment because
        # this environment also contains the variables of machine and
        # user.
        # These paths need only be shown if they weren't already
        # shown.
        # Unfortunately, this solution also prevents a path
        # that occurs multiple times in the process environment
        # only from being reported multiple times.
        # 
          continue
      }

      if ($p -eq '') {
         write-host "   ! <empty>"
      }
      else {

         try {
            $err = $null
            if (test-path -pathType container $p_ -ev err) {
                $flagExists = ' '
            }
            else {
                $flagExists = '!'
            }
         }
         catch [System.UnauthorizedAccessException] {
	 #
	 #  TODO: in Powershell 7, this does not work anymore as intended.
	 #  Rather, it pollutes the output with a message like
	 #      Access to the path 'C:\Users\xyz\AppData\Local\Microsoft\WindowsApps' is denied.
	 #
            $flagExists = 'A'
         }
         catch {
            write-host $err
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
showPaths process $envVar
