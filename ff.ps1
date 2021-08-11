#
#   V0.3
#
param (
    [parameter(mandatory=$true) ]
    [string                     ] $regex,
    [parameter(mandatory=$false)]
    [string[]                   ] $suffixes = '*',
    [parameter(mandatory=$false)]
    [string                     ] $root     = $pwd,
    [parameter(mandatory=$false)]
    [switch                     ] $selectRegex
)

set-strictMode -version latest

$errorActionPreference = 'continue'

$files = get-childItem -path $root -attributes !directory -recurse -include $suffixes

if ($selectRegex) {
   foreach ($file in $files) {
      $found = $file | get-content | foreach-object { select-regex $regex $_ }
      if ($found) {
         $file.fullName
         foreach ($f in $found) {
            "  $f"
         }
      }
   }
}
else {
   foreach ($file in ($files | select-string -list $regex)) {
      $file.path
   }
}
