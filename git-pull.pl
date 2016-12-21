#!/usr/bin/perl
use warnings;
use strict;
use Cwd;

my $cwd = cwd() . '/';
my $gwd = $ENV{git_work_dir};

$cwd =~ s!\\!/!g;
$gwd =~ s!\\!/!g;

if (length($cwd) < length($gwd) or substr($cwd, 0, length($gwd)) ne $gwd) { # { Push to github
  print (readpipe('git pull')); 
} # }
else { # { Push to harddisk
  if ($^O eq 'linux') {
    print (readpipe("git pull '$ENV{git_local_repo_dir}'")); 
  }
  else {
    print (readpipe("git pull $ENV{git_local_repo_dir}")); 
  }
} # }
