#
#   This script is called kil because kill is a default
#   alias for stop-process.
#

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
   stop-process $proc
}
