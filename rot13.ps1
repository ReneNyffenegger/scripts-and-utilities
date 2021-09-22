#
#    http://eddiejackson.net/wp/?p=319
#
#    V1
#

# set-strictMode -version latest

[cmdletBinding()]
param (
   [parameter(valueFromPipeline = $true, mandatory = $true)]
   [string] $text
)

process {
   [string] $r = ''

   foreach ($c in $text.ToCharArray()) {

       [int   ] $n = $c

       if     ( ( $n -ge  97  -and  $n -le 109 ) -or ( $n -ge 65 -and $n -le 77 ) ) { $r += [char] ($n + 13) }
       elseif ( ( $n -ge 110  -and  $n -le 122 ) -or ( $n -ge 78 -and $n -le 90 ) ) { $r += [char] ($n - 13) }
       else                                                                         { $r += $c               }

   }

   return $r
}
