#
#   Copies the current path to the clipboard
#
#   Dec 14: On Windows, the same thing can be achieved
#   with a
#     <nul set /p ="%CD%"|clip
#   Yet, the echo also writes 
#

use warnings; use strict;

use Cwd;
use Win32::Clipboard;

my $path = getcwd;
$path =~ s/\//\\/g;

Win32::Clipboard -> Set($path);
