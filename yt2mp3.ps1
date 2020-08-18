param (
   [parameter()] [switch] $noJob
)


set-strictMode -version 2

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


if ($url -match '^https://www\.youtube\.com/watch\?v=(.{11})$') {

   $id = $matches[1]

}
else {
   write-output "$url is not a youtbue url"
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
   youtube-dl --extract-audio --audio-format mp3 $url
}
else {
   start-job {
       set-location $using:mp3Dir
       youtube-dl --extract-audio --audio-format mp3 $using:url
   }
}
