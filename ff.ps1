param (
    [parameter(mandatory=$true) ]
    [string                     ] $regex,
    [parameter(mandatory=$false)]
    [string[]                   ] $suffixes = '*',
    [parameter(mandatory=$false)]
    [string                     ] $root     = $pwd
)

set-strictMode -version latest

foreach ($file in (get-childItem -path $root -recurse -include $suffixes | select-string -list $regex)) {
   $file.path
}
