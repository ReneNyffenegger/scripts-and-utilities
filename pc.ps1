param (
   [switch] $forwardSlashes
);

$dir = (get-item .).ToString()

if ($forwardSlashes) {
   $dir = $dir -replace '\\', '/'
}

if ($psEdition -eq 'Desktop') {

  $dir | set-clipboard

}
else {
# clipboardText needs to be installed:
#    install-module -name ClipboardText
  $dir | set-clipboardText
}
