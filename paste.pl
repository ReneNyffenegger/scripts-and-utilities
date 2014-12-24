#
#   Paste content of clipboard to cmd.exe
#
#   Compare with -> cv.pl
#
use strict; use warnings;

use Win32::Clipboard;

print Win32::Clipboard -> Get;
