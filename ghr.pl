#!/usr/bin/perl

use warnings;
use strict;

use File::HomeDir;
use Getopt::Long;

my $match = '';

GetOptions(
   'match=s'        => \$match,
   'show-repos'     => \my $show_repos,
   'help'           => \my $help,
   'todo'           => \my $todo,
   'debug'          => \my $debug,
   'check-status'   => \my $check_status
) or exit -1;


if ($help) {
   usage();
   exit;
}

my $lib_dir    = "$ENV{github_top_root}lib";
my $about_dir  = "$ENV{github_top_root}about";
my $github_dir =  $ENV{github_root};


#if ($^O eq 'MSWin32') { # or MSWin64 ?
#  $lib_dir     = 'c:/lib';
#  $about_dir   = 'c:/about';
#  $github_dir  = 'c:/github';
#}
#else {
#  $lib_dir     = File::HomeDir -> my_home . '/github/lib';
#  $about_dir   = File::HomeDir -> my_home . '/github/about';
#  $github_dir  = File::HomeDir -> my_home . '/github/github';
#}

my $exact = '';
if (@ARGV == 1) {

  if ($match) {

    usage();
    exit;
  
  }

  $exact = shift @ARGV;
}
elsif (@ARGV > 1) {

  usage();
  exit;

}

my %repos;

my $plsql_and_types   = 'Oracle-supplied-PL-SQL-Packages-and-Types';
my $sql_dev_decryptor = 'Oracle-SQL-developer-password-decryptor';

# $repos{'d3-threeD'     } = 'https://github.com/asutherland/d3-threeD';
$repos{'Access.pm'                          } = {url => 'https://github.com/ReneNyffenegger/Access.pm'                        , dir => $lib_dir   };
$repos{'blob_wrapper-Oracle'                } = {url => 'https://github.com/ReneNyffenegger/blob_wrapper-Oracle'              , dir => $lib_dir   };
$repos{'js-keyboard-coordinates'            } = {url => 'https://github.com/ReneNyffenegger/js-keyboard-coordinates'          , dir => $lib_dir   };
$repos{'js-inkscape'                        } = {url => 'https://github.com/ReneNyffenegger/js-inkscape'                      , dir => $lib_dir   };
$repos{'js-line-writer'                     } = {url => 'https://github.com/ReneNyffenegger/js-line-writer'                   , dir => $lib_dir   };
$repos{'js-tablator'                        } = {url => 'https://github.com/ReneNyffenegger/js-tablator'                      , dir => $lib_dir   };
$repos{'js-vector-matrix'                   } = {url => 'https://github.com/ReneNyffenegger/js-vector-matrix'                 , dir => $lib_dir   };
$repos{'MS-Access-bootstrap'                } = {url => 'https://github.com/ReneNyffenegger/MS-Access-bootstrap'              , dir => $lib_dir   };
$repos{'notes2html'                         } = {url => 'https://github.com/ReneNyffenegger/notes2html'                       , dir => $lib_dir   };
$repos{$plsql_and_types                     } = {url => "https://github.com/ReneNyffenegger/$plsql_and_types"                 , dir => $lib_dir   };
$repos{'perl-tcp'                           } = {url => 'https://github.com/ReneNyffenegger/perl-tcp'                         , dir => $lib_dir   };
$repos{'perl-Win32-OLE'                     } = {url => 'https://github.com/ReneNyffenegger/perl-Win32-OLE'                   , dir => $lib_dir   };
$repos{'runVBAFilesInOffice'                } = {url => 'https://github.com/ReneNyffenegger/runVBAFilesInOffice'              , dir => $lib_dir   };
$repos{'SendDirectoryWithMail'              } = {url => 'https://github.com/ReneNyffenegger/SendDirectoryWithMail'            , dir => $lib_dir   };
$repos{'scripts'                            } = {url => 'https://github.com/ReneNyffenegger/scripts-and-utilities'            , dir => $lib_dir   };
$repos{'svg-in-html'                        } = {url => 'https://github.com/ReneNyffenegger/svg-in-html'                      , dir => $lib_dir   };
$repos{'tq84-PerlModules'                   } = {url => 'https://github.com/ReneNyffenegger/tq84-PerlModules'                 , dir => $lib_dir   };
$repos{'VBAModules'                         } = {url => 'https://github.com/ReneNyffenegger/VBAModules'                       , dir => $lib_dir   };
$repos{'xlsx_writer-Oracle'                 } = {url => 'https://github.com/ReneNyffenegger/xlsx_writer-Oracle'               , dir => $lib_dir   };

#                                            = {url => 'https://github.com/ReneNyffenegger/Windows-Pixel-Ruler'               , dir                };
$repos{'Access'                             } = {url => 'https://github.com/ReneNyffenegger/about-Access'                     , dir => $about_dir };
$repos{'adodb'                              } = {url => 'https://github.com/ReneNyffenegger/about-adodb'                      , dir => $about_dir };
$repos{'AutoHotkey'                         } = {url => 'https://github.com/ReneNyffenegger/about-AutoHotkey'                 , dir => $about_dir };
$repos{'awk'                                } = {url => 'https://github.com/ReneNyffenegger/about-awk'                        , dir => $about_dir };
$repos{'Bash'                               } = {url => 'https://github.com/ReneNyffenegger/about-Bash'                       , dir => $about_dir };
$repos{'CGI'                                } = {url => 'https://github.com/ReneNyffenegger/about-cgi'                        , dir => $about_dir };
$repos{'coffeescript'                       } = {url => 'https://github.com/ReneNyffenegger/about-coffeescript'               , dir => $about_dir };
$repos{'css'                                } = {url => 'https://github.com/ReneNyffenegger/about-css'                        , dir => $about_dir };
$repos{'cmd.exe'                            } = {url => 'https://github.com/ReneNyffenegger/about-cmd.exe'                    , dir => $about_dir };
$repos{'dat.GUI'                            } = {url => 'https://github.com/ReneNyffenegger/about-dat.GUI'                    , dir => $about_dir };
$repos{'DFS'                                } = {url => 'https://github.com/ReneNyffenegger/about-DFS'                        , dir => $about_dir };
$repos{'Document-Object-Model'              } = {url => 'https://github.com/ReneNyffenegger/about-Document-Object-Model'      , dir => $about_dir };
$repos{'draw-io'                            } = {url => 'https://github.com/ReneNyffenegger/about-draw-io'                    , dir => $about_dir };
$repos{'d3.js'                              } = {url => 'https://github.com/ReneNyffenegger/about-d3.js'                      , dir => $about_dir };
$repos{'Excel'                              } = {url => 'https://github.com/ReneNyffenegger/about-Excel'                      , dir => $about_dir };
$repos{'FinnOne'                            } = {url => 'https://github.com/ReneNyffenegger/about-FinnOne-Neo'                , dir => $about_dir };
$repos{'git'                                } = {url => 'https://github.com/ReneNyffenegger/about-git'                        , dir => $about_dir };
$repos{'GMT'                                } = {url => 'https://github.com/ReneNyffenegger/about-GMT'                        , dir => $about_dir };
$repos{'GoogleEarth'                        } = {url => 'https://github.com/ReneNyffenegger/about-GoogleEarth'                , dir => $about_dir };
$repos{'Graphviz'                           } = {url => 'https://github.com/ReneNyffenegger/about-Graphviz'                   , dir => $about_dir };
$repos{'hadoop'                             } = {url => 'https://github.com/ReneNyffenegger/about-hadoop'                     , dir => $about_dir };
$repos{'html'                               } = {url => 'https://github.com/ReneNyffenegger/about-html'                       , dir => $about_dir };
$repos{'impress.js'                         } = {url => 'https://github.com/ReneNyffenegger/about-impress.js'                 , dir => $about_dir };
$repos{'jmpress.js'                         } = {url => 'https://github.com/ReneNyffenegger/about-jmpress.js'                 , dir => $about_dir };
$repos{'Java'                               } = {url => 'https://github.com/ReneNyffenegger/about-Java'                       , dir => $about_dir };
$repos{'javascript'                         } = {url => 'https://github.com/ReneNyffenegger/about-javascript'                 , dir => $about_dir };
$repos{'jqGrid'                             } = {url => 'https://github.com/ReneNyffenegger/about-jqGrid'                     , dir => $about_dir };
$repos{'jQuery'                             } = {url => 'https://github.com/ReneNyffenegger/about-jQuery'                     , dir => $about_dir };
$repos{'jQuery-UI'                          } = {url => 'https://github.com/ReneNyffenegger/about-jQuery-UI'                  , dir => $about_dir };
$repos{'jrunscript'                         } = {url => 'https://github.com/ReneNyffenegger/about-jrunscript'                 , dir => $about_dir };
$repos{'libc'                               } = {url => 'https://github.com/ReneNyffenegger/about-libc'                       , dir => $about_dir };
$repos{'Linux'                              } = {url => 'https://github.com/ReneNyffenegger/about-Linux'                      , dir => $about_dir };
$repos{'node.js'                            } = {url => 'https://github.com/ReneNyffenegger/about-node.js'                    , dir => $about_dir };
$repos{'MapReduce'                          } = {url => 'https://github.com/ReneNyffenegger/about-MapReduce'                  , dir => $about_dir };
$repos{'mshta'                              } = {url => 'https://github.com/ReneNyffenegger/about-mshta'                      , dir => $about_dir };
$repos{'MSSQL'                              } = {url => 'https://github.com/ReneNyffenegger/about-MSSQL'                      , dir => $about_dir };
$repos{'Office-Open-XML'                    } = {url => 'https://github.com/ReneNyffenegger/about-Office-Open-XML'            , dir => $about_dir };
$repos{'Open-Street-Map'                    } = {url => 'https://github.com/ReneNyffenegger/about-Open-Street-Map'            , dir => $about_dir };
$repos{'perl'                               } = {url => 'https://github.com/ReneNyffenegger/about-perl'                       , dir => $about_dir };
$repos{'php'                                } = {url => 'https://github.com/ReneNyffenegger/about-php'                        , dir => $about_dir };
$repos{'Protocols'                          } = {url => 'https://github.com/ReneNyffenegger/about-protocols'                  , dir => $about_dir };
$repos{'Pig'                                } = {url => 'https://github.com/ReneNyffenegger/about-Pig'                        , dir => $about_dir };
$repos{'powershell'                         } = {url => 'https://github.com/ReneNyffenegger/about-powershell'                 , dir => $about_dir };
$repos{'python'                             } = {url => 'https://github.com/ReneNyffenegger/about-python'                     , dir => $about_dir };
$repos{'README.md'                          } = {url => 'https://github.com/ReneNyffenegger/about-README.md'                  , dir => $about_dir };
$repos{'r'                                  } = {url => 'https://github.com/ReneNyffenegger/about-r'                          , dir => $about_dir };
$repos{'sed'                                } = {url => 'https://github.com/ReneNyffenegger/about-sed'                        , dir => $about_dir };
$repos{'skychart'                           } = {url => 'https://github.com/ReneNyffenegger/about-skychart'                   , dir => $about_dir };
$repos{'sqlite'                             } = {url => 'https://github.com/ReneNyffenegger/about-sqlite'                     , dir => $about_dir };
$repos{'Stellarium'                         } = {url => 'https://github.com/ReneNyffenegger/about-Stellarium'                 , dir => $about_dir };
$repos{'svg'                                } = {url => 'https://github.com/ReneNyffenegger/about-svg'                        , dir => $about_dir };
$repos{'three.js'                           } = {url => 'https://github.com/ReneNyffenegger/about-three.js'                   , dir => $about_dir };
$repos{'TopoJSON'                           } = {url => 'https://github.com/ReneNyffenegger/about-TopoJSON'                   , dir => $about_dir };
$repos{'Unicode'                            } = {url => 'https://github.com/ReneNyffenegger/about-Unicode'                    , dir => $about_dir };
$repos{'VBA'                                } = {url => 'https://github.com/ReneNyffenegger/about-VBA'                        , dir => $about_dir };
$repos{'VBScript'                           } = {url => 'https://github.com/ReneNyffenegger/about-VBScript'                   , dir => $about_dir };
$repos{'about-vim'                          } = {url => 'https://github.com/ReneNyffenegger/about-vim'                        , dir => $about_dir }; # TODO: should that not be just the direcotry 'vim' instead of 'about-vim'?
$repos{'Windows-Registry'                   } = {url => 'https://github.com/ReneNyffenegger/about-Windows-Registry'           , dir => $about_dir };
$repos{'wsh'                                } = {url => 'https://github.com/ReneNyffenegger/about-wsh'                        , dir => $about_dir };

$repos{'Algorithms'                         } = {url => 'https://github.com/ReneNyffenegger/Algorithms'                       , dir => $github_dir};
$repos{'Amdocs'                             } = {url => 'https://github.com/ReneNyffenegger/Amdocs'                           , dir => $github_dir};
$repos{'Apache-logfile'                     } = {url => 'https://github.com/ReneNyffenegger/Apache-logfile'                   , dir => $github_dir};
$repos{'Arch-Linux-UEFI-Installation'       } = {url => 'https://github.com/ReneNyffenegger/Arch-Linux-UEFI-Installation'     , dir => $github_dir};
$repos{'Astronomie'                         } = {url => 'https://github.com/ReneNyffenegger/Astronomie'                       , dir => $github_dir};
$repos{'Ausfluege-Touren-etc'               } = {url => 'https://github.com/ReneNyffenegger/Ausfluege-Touren-etc'             , dir => $github_dir};
$repos{'Bibelhebraeisch-lernen'             } = {url => 'https://github.com/ReneNyffenegger/Bibelhebraeisch-lernen'           , dir => $github_dir};
$repos{'Bibeluebersetzungen'                } = {url => 'https://github.com/ReneNyffenegger/Bibeluebersetzungen'              , dir => $github_dir};
$repos{'Bibelkommentare'                    } = {url => 'https://github.com/ReneNyffenegger/Bibelkommentare'                  , dir => $github_dir};
$repos{'Bible-Text-Sources'                 } = {url => 'https://github.com/ReneNyffenegger/Bible-Text-Sources'               , dir => $github_dir};
$repos{'Biblisches'                         } = {url => 'https://github.com/ReneNyffenegger/Biblisches'                       , dir => $github_dir};
$repos{'browser-object-model'               } = {url => 'https://github.com/ReneNyffenegger/Browser-Object-Model'             , dir => $github_dir};
$repos{'Chronologie'                        } = {url => 'https://github.com/ReneNyffenegger/Chronologie'                      , dir => $github_dir};
$repos{'Clarify'                            } = {url => 'https://github.com/ReneNyffenegger/Clarify'                          , dir => $github_dir};
$repos{'Configure-Windows'                  } = {url => 'https://github.com/ReneNyffenegger/Configure-Windows'                , dir => $github_dir};
$repos{'Csound'                             } = {url => 'https://github.com/ReneNyffenegger/Csound'                           , dir => $github_dir};
$repos{'data-visualization'                 } = {url => 'https://github.com/ReneNyffenegger/data-visualization'               , dir => $github_dir};
$repos{'development_misc'                   } = {url => 'https://github.com/ReneNyffenegger/development_misc'                 , dir => $github_dir};
$repos{'EGG'                                } = {url => 'https://github.com/ReneNyffenegger/EGG-Explosion-Graphics-Generator' , dir => $github_dir};
$repos{'Fonts'                              } = {url => 'https://github.com/ReneNyffenegger/Fonts'                            , dir => $github_dir};
$repos{'Geschichte-der-Wissenschaft'        } = {url => 'https://github.com/ReneNyffenegger/Geschichte-der-Wissenschaft'      , dir => $github_dir};
$repos{'Global-Relief-Model'                } = {url => 'https://github.com/ReneNyffenegger/Global-Relief-Model'              , dir => $github_dir};
$repos{'git-internals'                      } = {url => 'https://github.com/ReneNyffenegger/git-internals'                    , dir => $github_dir};
$repos{'Graphic-Design-Fonts'               } = {url => 'https://github.com/ReneNyffenegger/Graphic-Design-and-Font'          , dir => $github_dir};
$repos{'Hydroplattentheorie'                } = {url => 'https://github.com/ReneNyffenegger/Hydroplattentheorie'              , dir => $github_dir};
$repos{'JavaClasses'                        } = {url => 'https://github.com/ReneNyffenegger/JavaClasses'                      , dir => $github_dir};
$repos{'kaggle'                             } = {url => 'https://github.com/ReneNyffenegger/kaggle'                           , dir => $github_dir};
$repos{'Karten'                             } = {url => 'https://github.com/ReneNyffenegger/Karten'                           , dir => $github_dir};
$repos{'Kenan-Arbor'                        } = {url => 'https://github.com/ReneNyffenegger/Kenan-Arbor'                      , dir => $github_dir};
$repos{'LinuxFromScratch'                   } = {url => 'https://github.com/ReneNyffenegger/LinuxFromScratch'                 , dir => $github_dir};
$repos{'Meta-Oracle'                        } = {url => 'https://github.com/ReneNyffenegger/Meta-Oracle'                      , dir => $github_dir};
$repos{'netcat'                             } = {url => 'https://github.com/ReneNyffenegger/netcat'                           , dir => $github_dir};
$repos{'notes'                              } = {url => 'https://github.com/ReneNyffenegger/notes'                            , dir => $github_dir};
$repos{'oracle-patterns'                    } = {url => 'https://github.com/ReneNyffenegger/oracle-patterns'                  , dir => $github_dir};
$repos{'Oracle-Performance-Investigations'  } = {url => 'https://github.com/ReneNyffenegger/Oracle-Performance-Investigations', dir => $github_dir};
$repos{'oracle_scriptlets'                  } = {url => 'https://github.com/ReneNyffenegger/oracle_scriptlets'                , dir => $github_dir};
$repos{'OracleTool'                         } = {url => 'https://github.com/ReneNyffenegger/OracleTool'                       , dir => $github_dir};
$repos{'Oracle-Tutorial'                    } = {url => 'https://github.com/ReneNyffenegger/Oracle-Tutorial'                  , dir => $github_dir};
$repos{'PostLinuxInstallation'              } = {url => 'https://github.com/ReneNyffenegger/PostLinuxInstallation'            , dir => $github_dir};
$repos{'PerlModules'                        } = {url => 'https://github.com/ReneNyffenegger/PerlModules'                      , dir => $github_dir};
$repos{'perl-webserver'                     } = {url => 'https://github.com/ReneNyffenegger/perl-webserver'                   , dir => $github_dir};
$repos{'printing'                           } = {url => 'https://github.com/ReneNyffenegger/printing'                         , dir => $github_dir};
$repos{'renenyffenegger.blogspot.com'       } = {url => 'https://github.com/ReneNyffenegger/renenyffenegger.blogspot.com'     , dir => $github_dir};
$repos{'RN'                                 } = {url => 'https://github.com/ReneNyffenegger/RN'                               , dir => $github_dir};
$repos{'shell-commands'                     } = {url => 'https://github.com/ReneNyffenegger/shell-commands'                   , dir => $github_dir};
$repos{'stationary-background'              } = {url => 'https://github.com/ReneNyffenegger/stationary-background'            , dir => $github_dir};
$repos{'Skizzen'                            } = {url => 'https://github.com/ReneNyffenegger/Skizzen'                          , dir => $github_dir};
$repos{'statistics'                         } = {url => 'https://github.com/ReneNyffenegger/statistics'                       , dir => $github_dir};
$repos{'Sprachen'                           } = {url => 'https://github.com/ReneNyffenegger/Sprachen'                         , dir => $github_dir};
$repos{'swap-keys'                          } = {url => 'https://github.com/ReneNyffenegger/swap-keys'                        , dir => $github_dir};
$repos{$sql_dev_decryptor                   } = {url => "https://github.com/ReneNyffenegger/$sql_dev_decryptor"               , dir => $github_dir};
$repos{'tq84.css'                           } = {url => 'https://github.com/ReneNyffenegger/tq84.css'                         , dir => $github_dir};
$repos{'vim'                                } = {url => 'https://github.com/ReneNyffenegger/vim'                              , dir => $github_dir};
$repos{'Vortraege'                          } = {url => 'https://github.com/ReneNyffenegger/Vortraege'                        , dir => $github_dir};
$repos{'WebAutomation'                      } = {url => 'https://github.com/ReneNyffenegger/WebAutomation'                    , dir => $github_dir};
$repos{'Windows-API'                        } = {url => 'https://github.com/ReneNyffenegger/Windows-API'                      , dir => $github_dir};
$repos{'Zefix'                              } = {url => 'https://github.com/ReneNyffenegger/Zefix'                            , dir => $github_dir};

$repos{'.vim'                               } = {url => 'https://github.com/ReneNyffenegger/.vim'                             , dir =>'special .vim'};

mkdir $lib_dir    unless -d $lib_dir;
mkdir $about_dir  unless -d $about_dir;
mkdir $github_dir unless -d $github_dir;

for my $repo (keys %repos) {

  my $repository_path = "$repos{$repo}{dir}/$repo";
  my $repo_parent     =  $repos{$repo}{dir};
  my $repo_directory  =  $repo;

  if ($repos{$repo}{dir} eq 'special .vim') {
    $repo_parent     = File::HomeDir -> my_home;

    if ($^O eq 'MSWin32' or $^O eq 'MSWin64') {
      $repository_path = File::HomeDir -> my_home . '/vimfiles';
      $repo_directory  = 'vimfiles';
    }
    else {
      $repository_path = File::HomeDir -> my_home . '/.vim';
      $repo_directory  = '.vim';
    }
  }

  if ($show_repos) {
      printf ("%-50s", $repo);

      printf "directory does not exist" unless -d $repository_path;
      print "\n";
      next;
  }

  print "repo: $repo\n" if $debug;

  if ($match and $repo !~ /$match/i) {
     next;
  }
  if ($exact and $repo ne $exact) {
     next;
  }



  if (-d $repository_path ) {
      
     chdir "$repository_path";
  
     if ($check_status) {
        my @git_response = readpipe('git status');
        @git_response = grep { !/^On branch master$/ } @git_response;
        @git_response = grep { !/^Your branch is up-to-date with 'origin\/master'\.$/ } @git_response;
        @git_response = grep { !/^Your branch is ahead of 'origin\/master' by \d+ commits?.$/ } @git_response;
        @git_response = grep { !/^nothing to commit, working directory clean$/ } @git_response;
        @git_response = grep { !/^  \(use "git push" to publish your local commits\)$/ } @git_response;

        if (@git_response) {
          print "\n\n\n$repository_path\n";
          print "----------------------------\n";
          print map {"      $_"} @git_response;
        }
     }
     elsif (!$todo) {
       print "\n\nRepo $repository_path exists, updating it\n";
       my $git_response = readpipe("git pull");
       print $git_response;
     }
     else {

       #  Is there something to be pushed?
       my $git_response = readpipe('git log @{u}..');
       if ($git_response) {
         print "\n\nRepo $repository_path should be pushed\n";
       }

       #  New files or uncommited files
       my @git_response = readpipe('git status');
       chomp($git_response[1]);
       if ($git_response[1] ne 'nothing to commit, working directory clean') {
         print "\n\nRepo $repository_path not clean [$git_response[1] ]\n";
       }

     }
  }
  else {

     next if $todo; # In todo-mode, do nothing if the repository does not exist
     next if $check_status;

     chdir $repo_parent;

     my $command = "git clone $repos{$repo}{url} $repo_directory";

     print "\n\nRepo $repository_path does not exist, cloning it [$command]\n";

     my $git_response = readpipe($command);
     print $git_response;

  }
}


sub usage {
  print "\n";
  print "  ghr.pl exact-expression\n";
  print "  ghr.pl --match regular-expression\n";
  print "  ghr.pl --show-tags\n";
  print "  ghr.pl --check-status\n";
  print "  ghr.pl --debug\n";
  print "  ghr.pl --todo\n";
  print "  ghr.pl --help\n";
  print "\n";
}
