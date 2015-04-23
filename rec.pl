use warnings;
use strict;

use File::Copy;
use File::Find;
use File::Slurp;
use File::Basename;
use File::Spec;
use File::Temp qw/tempfile/;
use Getopt::Long;
use Sys::Hostname;
use Cwd;              # TODO Really used


my $root_dir;

if (hostname() eq 'MOB10088759') {
   $root_dir = 'c:/workarea/work';
}
else {
   $root_dir = 'c:/localgit';
}

my @directories_to_prune;
my @files_to_match;
my $exec              ='';
my $print_help        ='';
my $print_svn_st      ='';
my $grep_pattern      ='';
my $m_flag            ='';  # currently only used for grep
my $newer_than_n_days    ;
my $remove_file       ='';
my $verbose           ='';

GetOptions(
      'd=s'      => \$root_dir,
      'day:1'    => \$newer_than_n_days,
      'exec=s'   => \$exec,
      'f=s'      => \@files_to_match,
      'g=s'      => \$grep_pattern,
      'h'        => \$print_help,
      'm'        => \$m_flag,
      'prune=s'  => \@directories_to_prune,
      'rm'       => \$remove_file,
      'svnst'    => \$print_svn_st,
      'dos2unix' => \my $dos2unix,
      'v'        => \$verbose
);

if ($print_help) {
   help();
   exit;
}

# if ($verbose) {
#   print "TODO: -v without effect\n";
# }

if (@ARGV) {
  die "unknown Arguments:\n  " . (join "\n  ",  @ARGV) . "\n";
}


if (defined $newer_than_n_days) { # {{{

  $newer_than_n_days = 1 if $newer_than_n_days eq '';

  if ($verbose) {
    print "find files newer than $newer_than_n_days days\n";
  }
} # }}}


find(\&wanted, $root_dir);

sub wanted { # {{{

    my $file_name = basename($File::Find::name); # or $file_name = $_;

    if (-d $File::Find::name) {

       print "$File::Find::name is a directory\n" if $verbose;

       $File::Find::prune = 1 if $File::Find::name =~ /\.svn$/;
       $File::Find::prune = 1 if $File::Find::name =~ /\.git$/;

       $File::Find::prune = 1 if map {$File::Find::name =~ /$_/ } @directories_to_prune;

       return;

    }
    elsif (-f $file_name) {
       print "$File::Find::name is a file\n" if $verbose;
    }
    else {
       print "$File::Find::name is neither a directory nor a file [" . cwd . "]\n" if $verbose;
    }

    # # {{{ Get Extension, return if extension = swp

    my ($extension) = $File::Find::name =~ /\.([^.]+)$/;

    $extension = '' unless defined $extension;

    return if $extension eq 'swp';

    # # }}}

    if (@files_to_match) { # {{{
      return unless map { $file_name =~ /$_/ } @files_to_match;
    } # }}}

    if ($grep_pattern) { # {{{
        grep_($file_name) if -f $file_name;
        return;
    } # }}}

    if ($dos2unix) { # {{{
        convertFileFormat($file_name, 'dos2unix') if -f $file_name;
        return;
    } # }}}

    if ($exec) { # {{{

      exec_($exec, $file_name);
      return;

    } # }}}

    if ($print_svn_st) { # {{{
        svn_st($file_name);
        return;
    } # }}}

    if ($newer_than_n_days) { # {{{
       my $file_mtime = (stat($file_name))[9];

       print "$File::Find::dir\\$file_name\n" if $file_mtime > time() - 24*60*60 * $newer_than_n_days;

       return;
    } # }}}

    if ($remove_file) { # {{{

       print "TODO: deleted $File::Find::dir/$file_name\n";
       return;
     # unlink $file_name;

    } # }}}


 #  If no other option matched, print at least the matched file
    print File::Spec->canonpath($File::Find::dir) . "\\$file_name\n";

#   return if $extension eq 'tys' or $extension eq 'sps';

} # }}}

sub grep_ { # {{{

  my $filename = shift;

  if (-B $filename) { # {{{
    print "$filename is binary and won't be grepped\n" if $verbose;
    return;
  } # }}}

  my $pattern_found = 0;

  my $file;
  unless (open $file, '<', $filename) { # {{{

     if ($^E == 0x20) { # http://stackoverflow.com/questions/3220206/determine-whether-a-file-is-in-use-in-perl-on-windows/3220688#322068c
       print STDERR "$filename is used by another process\n";
       return;
     }
     
     print "could not open $filename in $File::Find::dir $^E / $!";
  } # }}}

  while (my $line = <$file>) { # {{{

    if ($line =~ /$grep_pattern/i) {   # TODO: Is case insensitive now

      unless ($pattern_found) {

        print "$File::Find::dir/$filename\n";

        if ($m_flag) {  # If -m is added to -g then only print the filename
          close $file;
          return;
        }

        print (('-' x length("$File::Find::dir/$filename")) . "\n");
        $pattern_found = 1;
      }

      print "  $line";

    }

  } # }}}

  print "\n" if $pattern_found;

  close $file;
} # }}}

sub exec_ { # {{{

   my $cmd      = shift;
   my $filename = shift;

   $cmd =~ s/!/$filename/g;

   print readpipe($cmd);

} # }}}

sub svn_st { # {{{

    my $filename = shift;

    print "\n";

    my $st = readpipe ("svn st $filename");

    if ($st) {
     
      print "$st    in    " . File::Spec->rel2abs('.') . "\n"; 

    }

} # }}}

sub convertFileFormat { # {{{
  my $filename = shift;
  my $direction = shift;

  if ($direction eq 'dos2unix') {

  }
  else {
    die;
  }


  if (-B $filename) { # {{{
    print "$filename is binary, no converstion $direction will take place\n" if $verbose;
    return;
  } # }}}

  my $file;
  unless (open $file, '<', $filename) { # {{{

     if ($^E == 0x20) { # http://stackoverflow.com/questions/3220206/determine-whether-a-file-is-in-use-in-perl-on-windows/3220688#322068c
       print STDERR "$filename is used by another process\n";
       return;
     }
     
     print "could not open $filename in $File::Find::dir $^E / $!";
  } # }}}

  my ($tempfile_fh, $tempfile_name) = tempfile;

  while (my $line = <$file>) { # {{{

    $line =~ s/\x0d\x0a/\x0a/;
    print $tempfile_fh $line;

  } # }}}

  close $tempfile_fh;
  close $file;

  unlink $filename;
  move($tempfile_name, $filename);


  close $file;
    
} # }}}

sub help { # {{{

print <<"E"

  -d          <root dir>
  -f          file_pattern_1 file_pattern_2 .. file_pattern_n
  -g [-m]     grep pattern
  -h          This help

  -day [n]    print files newer than n days (default: 1)
  -exec       program, substitutes ! with \$filename
  -prune      directory_pattern_1 directory_pattern_2 ... directory_pattern_n
  -rm         delete (remove, unlink) file
  -svnst      print svn status of matched files
  -dos2unix   Convert files from dos format to unix format
  -v          verbose (TODO)
  
E

} # }}}
