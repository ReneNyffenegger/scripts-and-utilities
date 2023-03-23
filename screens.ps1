add-type -assemblyName System.Windows.Forms

foreach ($screen in [System.Windows.Forms.Screen]::AllScreens) {
    $wa = $screen.WorkingArea
   '{0,-18}  {1,4}x{2,4} @ {3,4},{4,4}' -f $screen.DeviceName, $wa.Width, $wa.Height, $wa.X, $wa.Y
}
