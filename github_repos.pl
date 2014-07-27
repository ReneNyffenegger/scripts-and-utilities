#!/usr/bin/perl

use warnings;
use strict;

use File::HomeDir;
use Getopt::Long;

my $match = '';

GetOptions(
   'match=s' => \$match
);


my $lib_dir    ;
my $about_dir  ;
my $github_dir ;

if ($^O eq 'MSWin32') { # or MSWin64 ?
  $lib_dir     = 'c:/lib';
  $about_dir   = 'c:/about';
  $github_dir  = 'c:/github';
}
else {
  $lib_dir     = File::HomeDir -> my_home . '/github-lib';
  $about_dir   = File::HomeDir -> my_home . '/about';
  $github_dir  = File::HomeDir -> my_home . '/github';
}


my %repos;

# $repos{'d3-threeD'     } = 'https://github.com/asutherland/d3-threeD';
$repos{'perl-Win32-OLE'              } = {url => 'https://github.com/ReneNyffenegger/perl-Win32-OLE'               , dir => $lib_dir   };
$repos{'js-keyboard-coordinates'     } = {url => 'https://github.com/ReneNyffenegger/js-keyboard-coordinates'      , dir => $lib_dir   };
$repos{'js-vector-matrix'            } = {url => 'https://github.com/ReneNyffenegger/js-vector-matrix'             , dir => $lib_dir   };
$repos{'SendDirectoryWithMail'       } = {url => 'https://github.com/ReneNyffenegger/SendDirectoryWithMail'        , dir => $lib_dir   };
$repos{'scripts'                     } = {url => 'https://github.com/ReneNyffenegger/scripts-and-utilities'        , dir => $lib_dir   };
$repos{'runVBAFilesInOffice'         } = {url => 'https://github.com/ReneNyffenegger/runVBAFilesInOffice'          , dir => $lib_dir   };

#                                      = {url => 'https://github.com/ReneNyffenegger/Windows-Pixel-Ruler'          , dir               };
$repos{'adodb'                       } = {url => 'https://github.com/ReneNyffenegger/about-adodb'                  , dir => $about_dir };
$repos{'Document-Object-Model'       } = {url => 'https://github.com/ReneNyffenegger/about-Document-Object-Model'  , dir => $about_dir };
$repos{'css'                         } = {url => 'https://github.com/ReneNyffenegger/about-css'                    , dir => $about_dir };
$repos{'html'                        } = {url => 'https://github.com/ReneNyffenegger/about-html'                   , dir => $about_dir };
$repos{'javascript'                  } = {url => 'https://github.com/ReneNyffenegger/about-javascript'             , dir => $about_dir };
$repos{'MapReduce'                   } = {url => 'https://github.com/ReneNyffenegger/about-MapReduce'              , dir => $about_dir };
$repos{'perl'                        } = {url => 'https://github.com/ReneNyffenegger/about-perl'                   , dir => $about_dir };
$repos{'php'                         } = {url => 'https://github.com/ReneNyffenegger/about-php'                    , dir => $about_dir };
$repos{'Pig'                         } = {url => 'https://github.com/ReneNyffenegger/about-Pig'                    , dir => $about_dir };
$repos{'powershell'                  } = {url => 'https://github.com/ReneNyffenegger/about-powershell'             , dir => $about_dir };
$repos{'python'                      } = {url => 'https://github.com/ReneNyffenegger/about-python'                 , dir => $about_dir };
$repos{'README.md'                   } = {url => 'https://github.com/ReneNyffenegger/about-README.md'              , dir => $about_dir };
$repos{'Windows-Registry'            } = {url => 'https://github.com/ReneNyffenegger/about-Windows-Registry'       , dir => $about_dir };

$repos{'browser-object-model'        } = {url => 'https://github.com/ReneNyffenegger/Browser-Object-Model'         , dir => $github_dir};
$repos{'data-visualization'          } = {url => 'https://github.com/ReneNyffenegger/data-visualization'           , dir => $github_dir};

mkdir $lib_dir    unless -d $lib_dir;
mkdir $about_dir  unless -d $about_dir;
mkdir $github_dir unless -d $github_dir;

for my $repo (keys %repos) {

  if ($match and $repo !~ /$match/i) {
     next;
  }

  if (-d "$repos{$repo}{dir}/$repo") {
     print "\n\nRepo $repos{$repo}{dir}/$repo exists, updating it\n";
    
     chdir "$repos{$repo}{dir}/$repo";

     my $git_response = readpipe("git pull");
     print $git_response;
  }
  else {
     chdir $repos{$repo}{dir};

     my $command = "git clone $repos{$repo}{url} $repo";

     print "\n\nRepo $repos{$repo}{dir}/$repo does not exist, cloning it [$command]\n";

     my $git_response = readpipe($command);
     print $git_response;

  }
}

