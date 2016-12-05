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

my $escape_backslashes   = 0;
my $make_forward_slashes = 0;
if (@ARGV) {

  my $opt = shift @ARGV;
  if ($opt eq '\\') {
      $escape_backslashes = 1;
  }
  elsif ($opt eq '/') {
      $make_forward_slashes = 1;
  }
  elsif (substr($opt, 0, 2) eq '-h') {
      help();
      exit 0;
  }
}

my $path = getcwd;

if (!$make_forward_slashes) {
  $path =~ s/\//\\/g;
}
if ($escape_backslashes) {
  $path =~ s/\\/\\\\/g;
}


Win32::Clipboard -> Set($path);

sub help {
  print '
  
    pc
    pc /     return c:/path/to/file.txt
    pc \     return c:\\\\path\\\\to\\\\file.txt

  ';

}
