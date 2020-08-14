#
#  Inspired by https://stackoverflow.com/a/12802050/180275
#

set-strictMode -version latest

if ( $args.count -lt 1 ) {
   write-host 'goWnd procName'
   return
}

$procName = $args[0]

$procs =  (get-process $procName)

if ($procs -eq $null) {
   write-host 'no processes found'
   return
}


add-type @"

  using System;
  using System.Runtime.InteropServices;

  public class user32_SetForegroundWindow {

     [DllImport("user32.dll")]
     [return: MarshalAs(UnmanagedType.Bool)]
      public static extern bool SetForegroundWindow(IntPtr hWnd);

  }
"@


$hWnd = $procs[0].MainWindowHandle
[user32_SetForegroundWindow]::SetForegroundWindow($hWnd)
