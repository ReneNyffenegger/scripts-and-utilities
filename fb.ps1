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
select-object -expandProperty fullName  # use -expandProperty so that output is not truncated, see https://stackoverflow.com/q/70694197/180275
