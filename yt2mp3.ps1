if ($psEdition -eq 'Desktop') {
  $url = get-clipboard
}
else {
# clipboardText needs to be installed:
#    install-module -name ClipboardText
  $url = get-clipboardText
}

if ($url -match '^https://www\.youtube\.com/watch\?v=(\w{11})$') {

   $id = $matches[1]

}
else {
   write-output "$url is not a url"
   return
}

$mp3Dir = (get-item "$env:temp/mp3").FullName

if (get-childItem $mp3Dir "*$id*") {
   write-output "$id already present"
   return
}

# Using fullName because of shortname (aka 8.3) problem (is it the ~?)
start-job { set-location $using:mp3Dir ; youtube-dl --extract-audio --audio-format mp3 $using:url }
