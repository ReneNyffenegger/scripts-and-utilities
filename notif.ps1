#
#  V0.4
#
[cmdletBinding(defaultParameterSetName = 'set')]
param (

   [parameter(
        mandatory = $false,
        parameterSetName = '-g')]
       [switch]                       $g,

   [parameter(
        mandatory        = $true,
        position         =  1,
        parameterSetName = 'set')]
       [string]                       $when,

   [parameter(
        mandatory        = $true,
        position         =  2,
        parameterSetName = 'set')]
       [string]                       $msg
)

set-strictMode -version latest

if ($g) {
   $actions = get-scheduledTask | where-object taskname -match 'notif_\d{4}-\d{2}-\d{2}_\d{2}-\d{2}' # | select-object actions
   foreach ($action in $actions) {
      "$($action.taskName)  $($action.actions[0].arguments)"
   }
   return
}

if ($when.substring(0, 1) -eq '+') {
  [timespan] $span = $when.substring(1)
  [datetime] $dtWhen = (get-date) + $span
}
else {
  [datetime] $dtWhen = $when
}

$trg = new-scheduledTaskTrigger   -once -at $dtWhen

$trg.endBoundary = $dtWhen.addSeconds(1).toString('s')

$set = new-scheduledTaskSettingsSet  `
   -deleteExpiredTaskAfter    00:00:01    `
   -allowStartIfOnBatteries

$act = new-scheduledTaskAction -execute "cmd" -argument "/c msg $env:username $msg"

$null = register-scheduledTask                               `
   -force                                                    `
   -taskName "notif_$($dtWhen.toString('yyyy-MM-dd_HH-mm'))" `
   -Trigger    $trg                                          `
   -action     $act                                          `
   -settings   $set
