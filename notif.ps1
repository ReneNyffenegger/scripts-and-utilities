param (
  [System.DateTime] $when,
  [String]          $msg
)

set-strictMode -version latest

$trg = new-ScheduledTaskTrigger   -once -at $when

$trg.endBoundary = $when.addSeconds(1).toString('s')

$set = new-scheduledTaskSettingsSet  `
   -deleteExpiredTaskAfter    00:00:01    `
   -allowStartIfOnBatteries

$act = new-scheduledTaskAction -execute "cmd" -argument "/c msg $env:username $msg"

$tsk = register-scheduledTask                              `
   -force                                                  `
   -taskName "notif_$($when.toString('yyyy-MM-dd_HH-mm'))" `
   -Trigger    $trg                                        `
   -action     $act                                        `
   -settings   $set