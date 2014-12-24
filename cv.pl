#
#   Print the content of the clipboard.
#
#   Mnemonic: Ctrl-V
#             -    -
#
#   Compare with -> paste.pl
#
use strict;
use warnings;

use Win32::Clipboard;

print Win32::Clipboard -> Get;
