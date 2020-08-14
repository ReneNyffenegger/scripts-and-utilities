set-strictMode -version latest

$sh = new-object -comObject wScript.shell

get-childItem $env:appdata\Microsoft\Windows\Recent -filter *.lnk |
sort-object lastAccessTime                                        |
foreach-object {

   $lnk = $sh.createShortcut( $_.fullName )

   $tgt = $lnk.targetPath

   if ($tgt) { 

     if ( test-path $tgt -pathType leaf ) {
        write-host "$($_.lastAccessTime.toString('yyyy-MM-dd HH:mm:ss'))   $($lnk.targetPath)"
     }

   }
}
