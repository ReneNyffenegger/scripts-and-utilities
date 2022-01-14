# fb = Find below
#
# V.2
#
# use fullName in output to emulate "dir /b /s"
#
param (
   [string] $wildcard
)

get-childItem -errorAction silentlyContinue -recurse -filter $wildcard |
select-object -expandProperty fullName
