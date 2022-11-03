param (
  [string] $ssid  = 'oooOOOooo',
  [switch] $speak
)

set-strictMode -version latest

#if ($args.count -lt 1) {
#  $ssid = 'oooOOOooo'
#}
#else {
#  $ssid = $args[0]
#}

if ($speak) {
   $sapi = new-object -comObject sapi.spVoice
   $lastStatus = '?'
}

$host.ui.rawUi.windowTitle = "wlan reconnect $ssid"


while ($true) {
   $now = get-date -format 'HH:mm:ss'

   if (! (test-connection 8.8.8.8 -errorAction continue -count 1 -quiet) ) {
     "$now NOK"
      $null = netsh wlan connect $ssid

      if ($speak -and $lastStatus -ne 'NOK') {
         $null = $sapi.speak('connection down')
         $lastStatus = 'NOK'
      }
      start-sleep 1
   }
   else {
     "$now OK"

      if ($speak -and $lastStatus -ne 'OK') {
         $null = $sapi.speak('connection up')
         $lastStatus = 'OK'
      }
      start-sleep 15
   }

}
