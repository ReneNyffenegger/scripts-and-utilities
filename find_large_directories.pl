#!/usr/bin/perl
use warnings;
use strict;

use Cwd;
use Getopt::Long;

die unless GetOptions ('largest=i' => \my $largest_dir,
                       'pct'       => \my $percent,
                       'depth=i'   => \my $depth,
                       'curly'     => \my $curly
                      );

my $top_dir = shift;

$top_dir = getcwd unless defined $top_dir;

die "$top_dir is not a directory" unless -d $top_dir;

my $dir = iterate_dir($top_dir, '');

print "\n";
my    $total_size = $dir->{size};
print "Total size: $total_size\n";
print "\n";

print_dir($dir, 0);

sub iterate_dir { # {{{
  my $parent_dir  = shift;
  my $name        = shift;

  my $dir = "$parent_dir/$name";

# print "$dir\n";

  my $size = 0;
  my $dirs = [];

  my $dh;
  unless (opendir ($dh, $dir)) {
    print STDERR "could not open directory $dir\n";
    return {
      size => 0,
      dirs => [],
      name => $name
    };
  }

  while (my $f = readdir($dh)) {

    next if $f eq '.' or $f eq '..';

    if (-f "$dir/$f") {
      $size += -s "$dir/$f";
    }
    elsif (-d "$dir/$f") {
      my $dir_ = iterate_dir($dir, $f);
      $size += $dir_->{size};
      push @$dirs, $dir_;
    }
    else {
      print STDERR "$dir/$f is neither -d nor -f\n";
    }

  }

  closedir($dh);

  return {
    size => $size,
    dirs => $dirs,
    name => $name
  }

} # }}}

sub print_dir { # {{{

  my $dir   = shift;
  my $level = shift;

  return if ($depth and $depth <= $level);

  if ($level) {
    if ($curly) {
      print '  ' x $level;
    }
    else {
      print '|   ' x $level;
    }
  }

  my $size;

  if ($percent) {
    $size = sprintf('%02.2f', 100/$total_size*$dir->{size});
  }
  else {
    $size = $dir->{size};
  }

  if ($curly) {
     print '{ ';
  }
  else {
    print '+---' 
  }
  
  print $dir->{name} . " " . $size,"\n";

  if (defined $largest_dir) { # {{{

    my $i = 0;
    foreach my $dir_ (sort { $b->{size} <=> $a->{size} } @{$dir->{dirs}}) {
      if ($i++ >= $largest_dir) {

        if ($curly) {
          print '  ' x $level;
          print "}\n";
        }

        return;
      }
      print_dir($dir_, $level+1);
    }

  # Also return if there are less than «largest dir» sub directories
  # in a directory:
    if ($curly) {
      print '  ' x $level;
      print "}\n";
    }
    return;
  } # }}}

  foreach my $dir_ (@{$dir->{dirs}}) {
    print_dir($dir_, $level+1);
  }
  if ($curly) {
    print '  ' x $level;
    print "}\n";
  }

} # }}}
