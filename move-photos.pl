#!/usr/bin/perl

use warnings;
use strict;

use Getopt::Long;
use File::Basename;
use File::Copy;

my $dry = 0;
GetOptions('dry' => \$dry);

if (@ARGV != 2) {
  usage();
  exit -1;
}

my $in_dir  = shift;
my $out_dir = shift;

die "$in_dir is not a directory"  unless -d $in_dir;
die "$out_dir is not a directory" unless -d $out_dir;

for my $img_in_path (glob "$in_dir/*.jpg $in_dir/*.JPG $in_dir/*.mp4 $in_dir/*.MP4") {

  my $img_name = basename($img_in_path);
  $img_name =~ s/JPG$/jpg/;
  $img_name =~ s/MP4$/mp4/;
  printf "%-23s", $img_name;

  my ($atime, $mtime, $ctime) = (stat($img_in_path))[8, 9, 10];

# if ($mtime != $ctime) {
#   die "mtime (". localtime($mtime) . ") != ctime (" . localtime($ctime) . ")";
# }

  my ($year, $month, $day) = (localtime($mtime))[5, 4, 3];
  $year  += 1900;

  $month = sprintf("%02d", $month+1);
  $day   = sprintf("%02d", $day    );

  printf "   $year $month $day";


  unless (-d "$out_dir/$year") {
    print "  y";
    mkdir "$out_dir/$year" unless $dry;
  }
  else {
    print "   ";
  }

  unless (-d "$out_dir/$year/$month-$day") {
    print "  d";
    mkdir "$out_dir/$year/$month-$day" unless $dry;
  }
  else {
    print "   ";
  }


  if (-e "$out_dir/$year/$month-$day/$img_name") {
    print "  e";
  }
  else {
     print "   ";
     if ($dry) {
       print "mv $img_in_path   $out_dir/$year/$month-$day/$img_name";
     }
     else {
           move  $img_in_path, "$out_dir/$year/$month-$day/$img_name" or die "could not rename $img_in_path to $out_dir/$year/$month-$day/$img_name $!";
     }
  }

  

  print "\n";
}

sub usage {
  print "

  move-photos.pl [-dry] in-dir  out-dir-root

";
}
