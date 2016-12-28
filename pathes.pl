#!/usr/bin/perl
use warnings; use strict;

print "\n\n";

my $sep=':';
   $sep=';' if $^O eq 'MSWin32';

my @pathes = split /$sep/, $ENV{PATH};

my $executable_name = shift;

if (defined $executable_name) {
#
#   Search for executable name in pathes if it
#   was defined.
#

  for my $path(@pathes) {

    if (-e "$path/$executable_name") {

      print "file found: $path\\$executable_name\n";

    }

  }

  exit;
}

#  
#     Just print spaces if executable name is
#     not defined:
# 
print join "\n", @pathes;
print "\n";
