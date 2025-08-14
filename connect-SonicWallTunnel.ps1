[CmdletBinding()]
param (
   [string] $password
)

& "C:\Program Files\SonicWall\Modern Connect Tunnel\SnwlConnect.exe"

while ( ($hwndConnectTunnel = find-window -windowTitle 'Connect Tunnel') -eq 0 ) {
   write-verbose 'no window with title Connect Tunnel found, sleeping for a second'
   start-sleep 1
}
write-verbose "hwndConnectTunnel = $hwndConnectTunnel"

$connectStatus  = ''
$hwndConnect    = 0
$hwndDisconnect = 0

$callback = {

   param (
      [IntPtr] $hWnd,
      [IntPtr] $unused_in_this_example
   )

   $winTxt    = get-windowText      $hWnd

   if     ($winTxt -in 'Connected', 'Disconnected', 'Reconnecting...', 'Disconnecting...', 'Detecting Network...') {$script:ConnectStatus  = $winTxt}
   elseif ($winTxt -eq '&Connect'                                                                                ) {$script:hwndConnect    = $hwnd  }
   elseif ($winTxt -eq '&Disconnect'                                                                             ) {$script:hwndDisconnect = $hwnd  }

   return $true
}

enum-childWindows $callback $hwndConnectTunnel

write-verbose "hwndConnect    = $hwndConnect"
write-verbose "hwndDisconnect = $hwndDisconnect"
write-verbose "connectStatus  = $connectStatus"
write-verbose ""

$BM_CLICK = 0x00F5

if ($connectStatus -eq 'Disconnected') {

   if ($hwndConnect -eq 0) {
      write-host "expected hwndConnect to be non-zero"
      return
   }
   write-verbose "sending BM_CLICK to hwndConnect"
   $null = send-windowMessage $hwndConnect $BM_CLICK 0 0

   write-verbose 'sending password in two seconds'
   start-sleep 2
   $sh = new-object -com "Wscript.Shell"
   $sh.sendkeys($password)
   $sh.sendkeys('{enter}')

   while (is-windowVisible $hwndConnectTunnel ) {
      write-verbose "connect tunnel is visible, sleeping for a second"
      start-sleep 1
   }
}

if ($connectStatus -eq 'Reconnecting...') {

   if ($hwndDisconnect -eq 0) {
      write-host "expected hwndDisconnect to be non-zero"
      return
   }
   write-verbose "sending BM_CLICK to hwndDisconnect"
   $null = send-windowMessage $hwndDisconnect $BM_CLICK 0 0
}
