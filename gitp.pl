#!/usr/bin/perl

use warnings;
use strict;

my $remote = readpipe("git config --get remote.origin.url");

my $renes_password=$ENV{TQ84_GITHUB_PW};

die "Set TQ84_GITHUB_PW" unless $renes_password;

$remote =~ s,https://,https://ReneNyffenegger:$renes_password\@,;

print readpipe ("git push $remote");
