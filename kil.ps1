#
#   This script is called kil because kill is a default
#   alias for stop-process.
#

param (
  [switch] $restart
)

set-strictMode -version latest

if ( $args.count -lt 1 ) {
   write-host 'kil procName'
   return
}

$procName = $args[0]

# write-host $procName

$procs = get-process $procName -ea silentlyContinue

if ($procs -eq $null) {
   write-host 'no processes found'
   return
}

foreach ($proc in $procs) {
   write-host "Killing $proc"
   $procPath = $proc.path
   stop-process $proc
}

if ($restart) {
   start-process $procPath
}
