#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

use File::Slurp;
use Getopt::Long;

my $do_create_test_files = '';


GetOptions (
  "create-testfiles" => \$do_create_test_files
);

if ($do_create_test_files) {

  create_test_files();

  exit;

}


my $file_name = shift; # {{{ Test file_name

if (!$file_name) {
  usage();
  exit;
}

if (! -f $file_name) {
  say "$file_name is not a file";
  exit;
}
# }}}

my @lines = read_file($file_name, binmode => ':raw');

for my $line (@lines) {

  my @characters = split //, $line;

  

  for my $char (@characters) {

    if ($char eq chr(0x0a)) {
      print " 0x0a";
    }
    elsif ($char eq chr(0x0d)) {
      print " 0x0d";
    }
    else {
      print $char;
    }

  }

  print "\n";
  
}



sub usage { # {{{
    say;
    say "  hex_dump.pl file-name";
    say "  hex_dump.pl --create-testfiles";
} # }}}

sub create_test_files { # {{{

    my $test_file_name = "hex_dump_test_end_of_lines.txt";

    open (my $test_file, ">", $test_file_name) or die "could not open $test_file_name";

    binmode $test_file;

    print $test_file "First line has Windows ending  \x0d\x0a";
    print $test_file "Second line has Unix ending    \x0a";
    print $test_file "Third line has neither         ";

    say "Testfile $test_file_name created";

} # }}}
