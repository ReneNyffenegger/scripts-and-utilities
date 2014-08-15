#
#   svnlu.pl  regexp
#
#   The script basically issues an «svn list» and finds the
#   files that match «regexp».
#   Each file can be selected for update by pressing
#  «y» or «j». A «q» prematurly exits the script. Every
#   other key skips the file.
#

use warnings; use strict;

use Term::ReadKey;

my $file_regexp = shift;

$file_regexp = '\w' unless $file_regexp;

print "\nfile_regexp: $file_regexp\n";

open (my $svn_command, '-|', "svn list");
my @file_list = <$svn_command>;
close $svn_command;

chomp(@file_list);

my @file_list_matched = grep { /$file_regexp/ }  @file_list;
my @file_list_to_update;

print "\nThere are " . @file_list_matched . " file(s) that have matched\n\n";
print "Note: you can press q to exit the script\n\n";

ReadMode(4);
for my $file (@file_list_matched) {
  print "update $file? ";
  my $key_pressed = ReadKey(0);

  print "$key_pressed";

  if    ($key_pressed eq 'y' or $key_pressed eq 'j') {
      push @file_list_to_update, $file;
  }
  elsif ($key_pressed eq 'q') {
      @file_list_to_update = ();
      last;
  }

  print "\n";
}

ReadMode(0);

system "svn up " . (join " ", @file_list_to_update) if @file_list_to_update;
