#
#   Print the content of the clipboard.
#
#   Mnemonic: Ctrl-V
#             -    -
#
use strict;
use warnings;

use Win32::Clipboard;

print Win32::Clipboard -> Get;
