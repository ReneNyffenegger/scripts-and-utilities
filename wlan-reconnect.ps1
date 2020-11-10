if ($args.count -lt 1) {
  $ssid = 'oooOOOooo'
}
else {
  $ssid = $args[0]
}

$host.ui.rawUi.windowTitle = "wlan reconnect $ssid"

while ($true) {
   $now = get-date -format 'HH:mm:ss'

   if (! (test-connection 8.8.8.8 -count 1 -quiet) ) {
     "$now NOK"
      $null = netsh wlan connect $ssid
      start-sleep 13
   }
   else {
      "$now OK"
   }

   start-sleep 4
}
