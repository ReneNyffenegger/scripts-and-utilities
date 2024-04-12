param (
    [string] $file_1,
    [string] $file_2
)

if (-not (test-path $file_1)) { "$file_1 does not exist"; return }
if (-not (test-path $file_2)) { "$file_2 does not exist"; return }

$file_1 | out-file $env:temp/files-to-compare.txt
$file_2 | out-file $env:temp/files-to-compare.txt -append

& "$(get-msOfficeInstallationRoot)/dcf/spreadsheetcompare.exe" $env:temp/files-to-compare.txt
