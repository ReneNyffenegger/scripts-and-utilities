#!/usr/bin/perl
#
#   move newest file from download folder to
#   current directory.
#

use warnings;
use strict;

use File::Copy;

# sort files in download folders by time, last accessed comes last
use File::DirList;

my $download_path;

if ($^O eq 'MSWin32') {
  $download_path = "$ENV{HOMEPATH}\\downloads\\";
}
else {
  $download_path = "$ENV{HOME}/Downloads/";
}

my $files =  File::DirList::list(
   $download_path,
  'M', # sort by access time
   1 , # noLinks,
   1   # hideDotFiles   --- Does it even work?
);   # first file [0] is newest, it's name is at position [13].

my $file;
while (1) {
  $file = (shift @{$files})->[13];
# print "? $file\n";
  next if $file eq '.' or $file eq '..';  # hideDotFiles does NOT SEEM to work!
  last;
}

print "move $file ?  Press character and enter if not so desired\n";
my $x=getc;

exit if $x =~ /\S/;

move ("$download_path/$file", '.');
