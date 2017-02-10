#!/usr/bin/perl
use warnings;
use strict;

use Getopt::Long;

my $chunk_size = 1024*1024;
my $buf_size   =   10*1024;
my $dest_dir   = '.';
GetOptions (
  'buf-size:i'    => \$buf_size,
  'chunk-size:i'  => \$chunk_size,
  'dest-dir:s'    => \$dest_dir
) or die;

my $filename = shift or die "No filename given";

die unless -d $dest_dir;

open (my $in, '<', $filename) or die "Could not open $filename\n$!";
binmode $in;

my $cnt_chunks = 0;
my $cnt_bufs   = 0;

open (my $out, '>', sprintf("$dest_dir/$filename.%03d", $cnt_chunks)) or die;
binmode $out;

while (read($in, my $buf, ($cnt_bufs+1) * $buf_size < $chunk_size ?  $buf_size : ($cnt_bufs+1)*$buf_size - $chunk_size)) {

    $cnt_bufs ++;
    print $out $buf;

    if ($cnt_bufs * $buf_size > $chunk_size) {
       $cnt_chunks ++;
       $cnt_bufs = 0;
       close $out;

       open ($out, '>', sprintf("$dest_dir/$filename.%003d", $cnt_chunks)) or die;
       binmode $out;

    }
}

close $out;
close $in;
