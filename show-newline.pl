#
#   Show line endings of a file (OA and/or 0D).
#
#   Won't probably work with Mac line endings.
#
use warnings;
use strict;


my $file = shift;
die unless -e $file;

open (my $fh, '<', $file) or die;
binmode ($fh);

my $line_no         = 1;
my $nof_chars_shown = 10;
my $cur_line='';
my $c;
my $last_c = '';
while (read($fh, $c, 1)) {

  if ($c eq "\x0d") {
     start_of_new_line_seqence();
     printf (" 0D");
  }
  elsif ($c eq "\x0a") {
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


sub start_of_new_line_seqence {
  printf ("%4d| %-${nof_chars_shown}s", $line_no, $cur_line);
  $cur_line = '';
}
sub end_of_new_line_sequence {
  print "\n";
  $line_no ++;
}
