#!/usr/bin/perl
#
#   Show line endings of a file (OA and/or 0D).
#
#   Won't probably work with Mac line endings.
#
#   See also dos-or-unix.pl
#
use warnings;
use strict;

use Getopt::Long;

my $nof_chars_shown = 10;

GetOptions (
    'chars-shown=i' => \$nof_chars_shown,
    'nof-lines=i'   => \my $nof_lines);

if (@ARGV != 1) {
  die "Specify file name";
}
my $file = shift;
die "$file does not exist" unless -e $file;

open (my $fh, '<', $file) or die;
binmode ($fh);

my $line_no         = 1;
my $cur_line='';
my $c;
my $last_c = '';
while (read($fh, $c, 1)) {

  last if $nof_lines and $line_no > $nof_lines;

  if ($c eq "\x0d") {
     if ($last_c eq "\x0a") {
        end_of_new_line_sequence();
     }
     start_of_new_line_seqence();
     printf (" 0D");
  }
  elsif ($c eq "\x0a") {
     if ($last_c eq "\x0a") {
        end_of_new_line_sequence();
     }
     if ($last_c ne "\x0d") {
        start_of_new_line_seqence();
     }
     printf (" 0A");
  }
  else {
     if ($last_c eq "\x0a" or $last_c eq "\x0d") {
        end_of_new_line_sequence();
     }
     if (length($cur_line) < $nof_chars_shown) {
       $cur_line .= $c;
     }
  }

  $last_c = $c;
}
close $fh;

if ($last_c eq "\x0a") {
  end_of_new_line_sequence();
}

sub start_of_new_line_seqence {
  printf ("%4d| %-${nof_chars_shown}s", $line_no, $cur_line);
  $cur_line = '';
}
sub end_of_new_line_sequence {
  print "\n";
  $line_no ++;
}
