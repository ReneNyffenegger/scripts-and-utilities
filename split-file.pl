#!/usr/bin/perl
use warnings;
use strict;

my $filename = shift or die;

open (my $in, '<', $filename) or die;
binmode $in;

my $cnt_out    = 0;
my $cnt_chunks = 0;

open (my $out, '>', sprintf("$filename.%03d", $cnt_out)) or die;
binmode $out;

while (read($in, my $buf, 10000)) {

    $cnt_chunks ++;
    print $out $buf;

    if ($cnt_chunks  == 100) {
       $cnt_out ++;
       $cnt_chunks = 0;
       close $out;

       open ($out, '>', sprintf('zefix.db.%003d', $cnt_out)) or die;
       binmode $out;

    }
}

close $out;
close $in;
