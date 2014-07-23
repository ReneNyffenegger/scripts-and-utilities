#!/usr/bin/perl

#
#   In Windows (cmd.exe), the script gitp.bat
#   should be used. This bat file asks for
#   the password of TQ84_GITHUB_PW if it
#   is not already set.
#

use warnings;
use strict;

my $remote = readpipe("git config --get remote.origin.url");

my $renes_password=$ENV{TQ84_GITHUB_PW};

die "Set TQ84_GITHUB_PW" unless $renes_password;

$remote =~ s,https://,https://ReneNyffenegger:$renes_password\@,;

print readpipe ("git push $remote");
