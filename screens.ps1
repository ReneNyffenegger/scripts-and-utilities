# V.2
add-type -assemblyName System.Windows.Forms

''
'Monitor       Dimension  Work Area         Offset'
'-------       ---------  ---------    -----------'

foreach ($screen in [System.Windows.Forms.Screen]::AllScreens) {
    $wa = $screen.WorkingArea
   '{0:-18}  {1,4}x{2,4}  {3,4}x{4,4}  @ {5,5},{6,5}' -f $screen.DeviceName, $screen.Bounds.Width, $Screen.Bounds.Height, $wa.Width, $wa.Height, $wa.X, $wa.Y
}
''
