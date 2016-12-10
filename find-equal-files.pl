#!/usr/bin/perl
#
#   Find equal files based on MD5 Hash
#
use warnings;
use strict;

use Digest::MD5;
use File::Find;
use File::Temp;
use Getopt::Long;

my $rm_del_command = 'rm';

my $prio_file ='';
my $report_suffixes_seen = 0;
GetOptions('prio-file=s'   => \$prio_file, # ./find-equal-files.test/prio.file
           'suffixes-seen' => \$report_suffixes_seen);
use Cwd;

die "Priority file $prio_file does not exist" unless -f $prio_file;

my @prios;
read_prios();


#   9.3.2013: Only used temporarly, in order to find
#   out what file suffixes are present
use File::Basename;
my  %suffixes_seen;

#   ---

my  %md5_hex_hashes_seen;
my  %files_seen;

my  @directories_to_search = @ARGV;

my  $equal_files_seen = File::Temp->new();
print "equal_files_seen: $equal_files_seen\n";

open my $seen_files, '>', $equal_files_seen;
find (\&wanted, @directories_to_search);
close $seen_files;

if ($report_suffixes_seen) {
  for my $suffix (keys %suffixes_seen) {
    print "Suffix seen: $suffix\n";
  }
}

print "\n\n";

for my $md5_hex (keys %md5_hex_hashes_seen) { # {  print duplicate files:

    my @files_with_this_md5 = @{$md5_hex_hashes_seen{$md5_hex}};

    if (@files_with_this_md5 > 1) {

    #   print "$md5_hex\n";
    #   print "\n";

        my $after_first = 0;

        for my $file_with_this_md5 (sort sort_path_priority @files_with_this_md5) {
            
            (my $file_with_this_md5_ = $file_with_this_md5) =~ s,\/,\\,g;

            if ($after_first++) {
               print "$rm_del_command '$file_with_this_md5_'\n";
            }
            else {
               print "\n" . (' ' x (length($rm_del_command)+2)) . "$file_with_this_md5_\n";
            }
        }

    }

} # }

sub sort_path_priority { # {

  return path_priority($a) <=>
         path_priority($b);
} # }

sub path_priority { # {

  my $path = shift;

  for my $regexp (@prios) {

    return $regexp->{prio} if $path =~ /$regexp->{re}/;

  }

  return 99;

} # }

sub wanted { # {

    my $file_name = $File::Find::name;

#   print "$file_name   $_\n";

    return unless -f $_;

    unless (-s $_) {  # 11.12.2014: Skip empty files
      print "Warning!!!, $_ is empty\n";
      return;
    }

    my ($name, $path, $suffix) = fileparse ($file_name, qr"\..[^.]*$");

    return if exists $files_seen{"$path$name$suffix"};
    $files_seen {"$path$name$suffix"} = 1;

    $suffixes_seen{$suffix} = 1;

    my $md5_hex = get_md5_hex($_);

    push @{$md5_hex_hashes_seen{$md5_hex}}, $file_name;

#   printf $seen_files "%-30s %-15s %-6s %-30s\n", $path, $name, $suffix, $md5_hex;
    print  $seen_files "$md5_hex  $path$name$suffix\n";
#   print "$path$name$suffix\n";

} # }

sub get_md5_hex { # {

    my $file_name = shift;


    open (my $fh, '<', $file_name) or die;
    binmode $fh;
    
    my $md5 = new Digest::MD5;

    $md5->addfile($fh) or die "$@ $file_name";
    
    my $md5_hex = $md5->hexdigest;
    
    close $fh;

    return $md5_hex;
} # }

sub read_prios { # {

  open my $f, '<', $prio_file or die;

  while (my $line = <$f>) {
    chomp $line;

    if ($line =~ /^ *(\d+):(.+)/) {
       push @prios, {prio=>$1, re=>$2};
    }
  }

  close $f;

} # }
