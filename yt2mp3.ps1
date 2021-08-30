param (
   [parameter()] [switch] $noJob,
   [parameter()] [switch] $noUrlCheck,
   [parameter()] [string] $outFileName
)

set-strictMode -version latest

if ( $outFileName -eq '') {
   $outFileNameModified = '%(title)s-%(id)s.%(ext)s' # Use the default value
}
else {
   $outFileNameMOdified = "$($outFileName)_%(id)s.%(ext)s"
}

<#

    2020-03-18: this check was removed because on Windows 6.1 (Windows 7)
       $psEdition evaluated to 'Core',  and
       get-clipbaordText was not easily installable.

if ($psEdition -eq 'Desktop') {
  $url = get-clipboard
}
else {
# clipboardText needs to be installed:
#    install-module -name ClipboardText
  $url = get-clipboardText
}
#>

#
# 2020-03-18: new check if cmdLet get-clibboard is available
#
if (get-command get-clipboard -errorAction silentlyContinue) {
    $url = get-clipboard
}
else {
  # Maybe, clipboardText needs to be installed:
  #    install-module -name ClipboardText
    $url = get-clipboardText
}


if ($noUrlCheck) {
   $id                 = $outFileName
   $download_with_ytdl = $true
}
elseif (
         ( $url -match '^https://www\.youtube\.com/watch\?v=(.{11})' )   -or
         ( $url -match '^https://youtu\.be/(.{11})'                  )   -or
         ( $url -match '^https://www.bitchute.com/video/(.{12})'     )   -or
         ( $url -match '^https://lbry.tv/@(.+)'                      ) # -or
#        ( $url -match '^https://rumble.com/.*?mref=(.{13})'         ) # Unsupported URL: rumble
       )
{
   $id = $matches[1]
   $id = $id -replace '[:/]', '_' # lbry.tv

   $download_with_ytdl = $true
}
#q elseif ( $url -match '^(https://media2.kgov.com/audio/(\d{8}-BEL\d{3}).mp3)' ) {
#q
#q   $url        = $matches[1]
#q   $id         = $matches[2]
#q   $download_with_ytdl = $false
#q
#q   if (! $outFileName) {
#q      $outFileName = "$id.mp3"
#q   }
#q
#q }
elseif ( $url -match '^(https://.*/([^/]+)\.mp3)' ) {

  $url        = $matches[1]
  $id         = $matches[2]
  $download_with_ytdl = $false

  if (! $outFileName) {
     $outFileName = "$id.mp3"
  }
  else {
     if (! $outFileName -notmatch '\.mp3$') {
        $outFileName = "$outFileName.mp3"
     }
  }
}
else {
   write-host -foreGroundColor red "$url is not recognized"
   return
}

# Using fullName because of shortname (aka 8.3) problem (is it the ~?)
$mp3Dir = (get-item "$env:temp/mp3").fullName
if (-not (test-path $mp3Dir)) {
   write-error "mp3Dir $mp3Dir does not exist"
}

if (get-childItem $mp3Dir "*$id*") {
   write-output "$id already present"
   return
}


# 2020-03-18: allow to download without job
#
#
if ($noJob) {
   set-location $mp3Dir

   if ($download_with_ytdl) {
     youtube-dl --extract-audio --audio-format mp3 $url -o $outFileNameModified
   }
   else {
     invoke-webRequest $url -outfile $outFileName
   }
}
else {
   $j = start-job {
       set-location $using:mp3Dir

       if ($using:download_with_ytdl) {
          youtube-dl --extract-audio --audio-format mp3 $using:url -o $using:outFileNameModified
       }
       else {
          invoke-webRequest $url -outfile $using:outFileNameModified
       }
   }

   if ($outFileName) {
      $j.name = $outFileName
   }
   else {
      $j.name = $id
   }
}
