#
# V.2: set-clipboard can be run in PS Core and Desktop, no need for set-clipboardText anymore.
#      Note, PS Desktop would have a `set-clipboard -path .` commant
#
#
param (
   [switch] $forwardSlashes
);

$dir = (get-item .).ToString()

if ($forwardSlashes) {
   $dir = $dir -replace '\\', '/'
}

set-clipboard $dir
