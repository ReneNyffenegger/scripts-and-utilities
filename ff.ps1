#
#   V0.2
#
param (
    [parameter(mandatory=$true) ]
    [string                     ] $regex,
    [parameter(mandatory=$false)]
    [string[]                   ] $suffixes = '*',
    [parameter(mandatory=$false)]
    [string                     ] $root     = $pwd
)

set-strictMode -version latest

foreach ($file in (get-childItem -errorAction ignore -path $root -attributes !directory -recurse -include $suffixes |
                   select-string -errorAction ignore -list $regex
         )) {
   $file.path
}
