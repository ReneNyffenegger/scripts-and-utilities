#!/usr/bin/perl
use warnings;
use strict;

my $red     = chr(27) . '[1;31m';
my $yellow  = chr(27) . '[1;33m';
my $nocolor = chr(27) . '[0m';

while (my $line = <>) {

  $line =~ s/ERROR/${red}$&${nocolor}/g;
  $line =~ s/WARNING/${yellow}$&${nocolor}/g;
  print $line;

}
