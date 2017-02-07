#!/usr/bin/perl
use warnings;
use strict;

my $filename = shift or die;

die unless -e "$filename.000";

my $cnt_in = 0;
open (my $out, '>', $filename) or die;
binmode $out;

while (-e sprintf("$filename.%03d", $cnt_in)) {

  open (my $in, '<', sprintf("$filename.%03d", $cnt_in)) or die;
  binmode $in;
  print "$cnt_in\n";
  while (read($in, my $buf, 10000)) {
    print $out $buf;
  }
  close $in;

  $cnt_in++;
}
close $out;
