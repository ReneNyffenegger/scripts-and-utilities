#!/usr/bin/perl
use warnings;
use strict;

#
#  Tells wheater a file is dos or unix
#
#  See also show-newline.pl
#

for my $file (@ARGV) {

  if (-d $file) {
    print "$file is a directory\n";
    next;
  }

  die "$file is not a file" unless -f $file;

  open(my $fh, '<', $file) or die;
  binmode($fh);

  my $last_c = '';
  while (read($fh, my $c, 1)) {

    if ($c eq "\x0a") {
      if ($last_c eq "\x0d") {
        print "$file is dos\n";
      }
      else {
        print "$file is unix\n";
      }
      last;
    }

    if ($c eq "\x0d" and $last_c eq "\x0a") {
       print "$file is mac\n";
       last;
    }


    $last_c = $c;

  }

  close $fh;

}
