$ssid = 'oooOOOooo'

while ($true) {
   $now = get-date -format 'HH:mm:ss'

   if (! (test-connection 8.8.8.8 -count 1 -quiet) ) {
     "$now NOK"
      $null = netsh wlan connect oooOOOooo
      start-sleep 13
   }
   else {
      "$now OK"
   }

   start-sleep 4
}
