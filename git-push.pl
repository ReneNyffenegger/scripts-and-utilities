#!/usr/bin/perl

#
#   In Windows (cmd.exe), the script gitp.bat
#   should be used. This bat file asks for
#   the password of TQ84_GITHUB_PW if it
#   is not already set.
#

use warnings;
use strict;
use Cwd;

my $verbose = 0;

my $cwd = cwd() . '/';
my $gwd = $ENV{git_work_dir};

if ($^O eq 'MSWin32') {
  $cwd =~ s!\\!/!g;
  $gwd =~ s!\\!/!g;
}

print "$0
  cwd=$cwd
  gwd=$gwd
" if $verbose;


if ( # { Pull from github (TODO Same as in git-pull.pl)
     #     We have to determine if we have to pull from github.
     #     This is (probably) the case if one of the following three conditions
     #     hold true:
     #
     ! defined $gwd or                          # - gwd not defined: most probably we're not in git localgit directory.
      (length($cwd) <  length($gwd) or          # - cur work directory is not within working directory.
       substr($cwd, 0, length($gwd)) ne $gwd)   # - The current working directory path starts differently from the git work dir.
    ) {
  print "  Not within $ENV{git_work_dir}\n" if $verbose;

  my $remote = readpipe("git config --get remote.origin.url");
  
  my $renes_password=$ENV{TQ84_GITHUB_PW};
  
  die "Set TQ84_GITHUB_PW" unless $renes_password;
  
  $remote =~ s,https://,https://ReneNyffenegger:$renes_password\@,;
  
  print readpipe ("git push $remote");

} # }
else { # { Push to harddisk

  print "  Within $ENV{git_work_dir}\n" if $verbose;
  if ($^O eq 'linux') {
    print readpipe ("git push '$ENV{git_local_repo_dir}'");
  }
  else {
    print readpipe ("git push $ENV{git_local_repo_dir}");
  }
} # }
