#!/usr/bin/perl
use warnings;
use strict;
use Cwd;

my $verbose = 0;

my $cwd = cwd() . '/';
my $gwd = $ENV{git_work_dir};

$cwd =~ s!\\!/!g;
$gwd =~ s!\\!/!g;

$cwd =~ s!^(.):!lc($1) . ':'!ex;
$gwd =~ s!^(.):!lc($1) . ':'!ex;

print "cwd: $cwd\n" if $verbose;
print "gwd: $gwd\n" if $verbose;

if (length($cwd) < length($gwd) or substr($cwd, 0, length($gwd)) ne $gwd) { # { Pull from github
  print "pull from github\n" if $verbose;
  print (readpipe('git pull')); 
} # }
else { # { pull from harddisk
  my $cmd;
  print "pull from harddisk\n" if $verbose;
  if ($^O eq 'linux') {
    $cmd = "git pull '$ENV{git_local_repo_dir}'";
  }
  else {
    $cmd = "git pull $ENV{git_local_repo_dir}"; 
  }
  print "$cmd\n" if $verbose;
  print (readpipe($cmd)); 
} # }
