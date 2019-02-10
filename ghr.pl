#!/usr/bin/perl

use warnings;
use strict;

use File::HomeDir;
use Getopt::Long;

my $match = '';

GetOptions( #_{
   'match=s'        => \   $match,
   'list-repos'     => \my $list_repos,
   'help'           => \my $help,
   'todo'           => \my $todo,
   'start-day'      => \my $start_day,
   'end-day'        => \my $end_day,
   'debug'          => \my $debug,
   'check-status'   => \my $check_status,
   'push'           => \my $push,
) or exit -1; #_}

if ($help) { #_{
   usage();
   exit;
} #_}

my $lib_dir    = "$ENV{github_top_root}lib";
my $about_dir  = "$ENV{github_top_root}about";
my $github_dir =  $ENV{github_root};



my $exact = '';
my $arg1  = '';
if (@ARGV == 1) { #_{

  if ($match) {

    usage();
    exit;
  
  }
  elsif ($list_repos) {
     $arg1 = shift;
  }
  else {
    $exact = shift @ARGV;
  }
} #_}
elsif (@ARGV > 1) { #_{

  usage();
  exit;

} #_}

if (substr($exact, 0, 1) eq '/') {

  $match = substr($exact, 1);
  $exact = undef;

}

my %repos;

my $plsql_and_types   = 'Oracle-supplied-PL-SQL-Packages-and-Types';
my $sql_dev_decryptor = 'Oracle-SQL-developer-password-decryptor';

# $repos{'d3-threeD'     } = 'https://github.com/asutherland/d3-threeD';
$repos{'Access.pm'                                 } = {url => 'https://github.com/ReneNyffenegger/Access.pm'                               , dir => $lib_dir   }; #_{
$repos{'blob_wrapper-Oracle'                       } = {url => 'https://github.com/ReneNyffenegger/blob_wrapper-Oracle'                     , dir => $lib_dir   };
$repos{'cs-AVI-Writer'                             } = {url => 'https://github.com/ReneNyffenegger/cs-AVI-Writer'                           , dir => $lib_dir   };
$repos{'js-aspect-ratio'                           } = {url => 'https://github.com/ReneNyffenegger/js-aspect-ratio'                         , dir => $lib_dir   };
$repos{'js-keyboard-coordinates'                   } = {url => 'https://github.com/ReneNyffenegger/js-keyboard-coordinates'                 , dir => $lib_dir   };
$repos{'js-inkscape'                               } = {url => 'https://github.com/ReneNyffenegger/js-inkscape'                             , dir => $lib_dir   };
$repos{'js-line-writer'                            } = {url => 'https://github.com/ReneNyffenegger/js-line-writer'                          , dir => $lib_dir   };
$repos{'js-tablator'                               } = {url => 'https://github.com/ReneNyffenegger/js-tablator'                             , dir => $lib_dir   };
$repos{'js-vector-matrix'                          } = {url => 'https://github.com/ReneNyffenegger/js-vector-matrix'                        , dir => $lib_dir   };
$repos{'Geo-Coordinates-Converter-LV03'            } = {url => 'https://github.com/ReneNyffenegger/Geo-Coordinates-Converter-LV03'          , dir => $lib_dir   };
$repos{'MS-Access-bootstrap'                       } = {url => 'https://github.com/ReneNyffenegger/MS-Access-bootstrap'                     , dir => $lib_dir   };
$repos{'notes2html'                                } = {url => 'https://github.com/ReneNyffenegger/notes2html'                              , dir => $lib_dir   };
$repos{$plsql_and_types                            } = {url => "https://github.com/ReneNyffenegger/$plsql_and_types"                        , dir => $lib_dir   };
$repos{'perl-Bible-TextualCriticism-API-NTVMR'     } = {url => 'https://github.com/ReneNyffenegger/perl-Bible-TextualCriticism-API-NTVMR'   , dir => $lib_dir   };
$repos{'perl-Csound'                               } = {url => 'https://github.com/ReneNyffenegger/perl-Csound'                             , dir => $lib_dir   };
$repos{'perl-Geo-OSM-API'                          } = {url => 'https://github.com/ReneNyffenegger/perl-Geo-OSM-API'                        , dir => $lib_dir   };
$repos{'perl-Geo-OSM-DBI'                          } = {url => 'https://github.com/ReneNyffenegger/perl-Geo-OSM-DBI'                        , dir => $lib_dir   };
$repos{'perl-Geo-OSM-Primitive'                    } = {url => 'https://github.com/ReneNyffenegger/perl-Geo-OSM-Primitive'                  , dir => $lib_dir   };
$repos{'perl-Geo-OSM-Render'                       } = {url => 'https://github.com/ReneNyffenegger/perl-Geo-OSM-Render'                     , dir => $lib_dir   };
$repos{'perl-Git-Repository-Internal'              } = {url => 'https://github.com/ReneNyffenegger/perl-Git-Repository-Internal'            , dir => $lib_dir   };
$repos{'perl-GraphViz-Diagram-ClassDiagram'        } = {url => 'https://github.com/ReneNyffenegger/perl-GraphViz-Diagram-ClassDiagram'      , dir => $lib_dir   };
$repos{'perl-GraphViz-Diagram-GitRepository'       } = {url => 'https://github.com/ReneNyffenegger/perl-GraphViz-Diagram-GitRepository'     , dir => $lib_dir   };
$repos{'perl-GraphViz-Graph'                       } = {url => 'https://github.com/ReneNyffenegger/perl-GraphViz-Graph'                     , dir => $lib_dir   };
$repos{'perl-Gravitation'                          } = {url => 'https://github.com/ReneNyffenegger/perl-Gravitation'                        , dir => $lib_dir   };
$repos{'perl-Grid-Layout'                          } = {url => 'https://github.com/ReneNyffenegger/perl-Grid-Layout'                        , dir => $lib_dir   };
$repos{'perl-tcp'                                  } = {url => 'https://github.com/ReneNyffenegger/perl-tcp'                                , dir => $lib_dir   };
$repos{'perl-Win32-OLE'                            } = {url => 'https://github.com/ReneNyffenegger/perl-Win32-OLE'                          , dir => $lib_dir   };
$repos{'python-CreateGridBasedSVG'                 } = {url => 'https://github.com/ReneNyffenegger/python-CreateGridBasedSVG'               , dir => $lib_dir   };
$repos{'runVBAFilesInOffice'                       } = {url => 'https://github.com/ReneNyffenegger/runVBAFilesInOffice'                     , dir => $lib_dir   };
$repos{'scripts'                                   } = {url => 'https://github.com/ReneNyffenegger/scripts-and-utilities'                   , dir => $lib_dir   };
$repos{'SendDirectoryWithMail'                     } = {url => 'https://github.com/ReneNyffenegger/SendDirectoryWithMail'                   , dir => $lib_dir   };
$repos{'Socket.cpp'                                } = {url => 'https://github.com/ReneNyffenegger/Socket.cpp'                              , dir => $lib_dir   };
$repos{'svg-in-html'                               } = {url => 'https://github.com/ReneNyffenegger/svg-in-html'                             , dir => $lib_dir   };
$repos{'tq84-c-debug'                              } = {url => 'https://github.com/ReneNyffenegger/tq84-c-debug'                            , dir => $lib_dir   };
$repos{'tq84-cpp-debug'                            } = {url => 'https://github.com/ReneNyffenegger/tq84-cpp-debug'                          , dir => $lib_dir   };
$repos{'tq84-PerlModules'                          } = {url => 'https://github.com/ReneNyffenegger/tq84-PerlModules'                        , dir => $lib_dir   };
$repos{'Tree-Create-DepthFirst'                    } = {url => 'https://github.com/ReneNyffenegger/Tree-Create-DepthFirst'                  , dir => $lib_dir   };
$repos{'VBAModules'                                } = {url => 'https://github.com/ReneNyffenegger/VBAModules'                              , dir => $lib_dir   };
$repos{'xlsx_writer-Oracle'                        } = {url => 'https://github.com/ReneNyffenegger/xlsx_writer-Oracle'                      , dir => $lib_dir   };
$repos{'xml_writer-Oracle'                         } = {url => 'https://github.com/ReneNyffenegger/xml_writer-Oracle'                       , dir => $lib_dir   }; #_}

#                                                    = {url => 'https://github.com/ReneNyffenegger/Windows-Pixel-Ruler'                     , dir               };
$repos{'Access'                                    } = {url => 'https://github.com/ReneNyffenegger/about-Access'                            , dir => $about_dir }; #_{
$repos{'adodb'                                     } = {url => 'https://github.com/ReneNyffenegger/about-adodb'                             , dir => $about_dir };
$repos{'assembler'                                 } = {url => 'https://github.com/ReneNyffenegger/about-assembler'                         , dir => $about_dir };
$repos{'assembler-x86-x64'                         } = {url => 'https://github.com/ReneNyffenegger/about-assembler-x86-x64'                 , dir => $about_dir };
$repos{'AutoHotkey'                                } = {url => 'https://github.com/ReneNyffenegger/about-AutoHotkey'                        , dir => $about_dir };
$repos{'awk'                                       } = {url => 'https://github.com/ReneNyffenegger/about-awk'                               , dir => $about_dir };
$repos{'Bash'                                      } = {url => 'https://github.com/ReneNyffenegger/about-Bash'                              , dir => $about_dir };
$repos{'boost'                                     } = {url => 'https://github.com/ReneNyffenegger/about-boost'                             , dir => $about_dir };
$repos{'CGI'                                       } = {url => 'https://github.com/ReneNyffenegger/about-cgi'                               , dir => $about_dir };
$repos{'coffeescript'                              } = {url => 'https://github.com/ReneNyffenegger/about-coffeescript'                      , dir => $about_dir };
$repos{'c'                                         } = {url => 'https://github.com/ReneNyffenegger/about-c'                                 , dir => $about_dir };
$repos{'cl'                                        } = {url => 'https://github.com/ReneNyffenegger/about-cl'                                , dir => $about_dir };
$repos{'COM'                                       } = {url => 'https://github.com/ReneNyffenegger/about-COM'                               , dir => $about_dir };
$repos{'cpp'                                       } = {url => 'https://github.com/ReneNyffenegger/about-cpp'                               , dir => $about_dir };
$repos{'cpp-standard-library'                      } = {url => 'https://github.com/ReneNyffenegger/about-cpp-standard-library'              , dir => $about_dir };
$repos{'css'                                       } = {url => 'https://github.com/ReneNyffenegger/about-css'                               , dir => $about_dir };
$repos{'cmd.exe'                                   } = {url => 'https://github.com/ReneNyffenegger/about-cmd.exe'                           , dir => $about_dir };
$repos{'dat.GUI'                                   } = {url => 'https://github.com/ReneNyffenegger/about-dat.GUI'                           , dir => $about_dir };
$repos{'DFS'                                       } = {url => 'https://github.com/ReneNyffenegger/about-DFS'                               , dir => $about_dir };
$repos{'Docker'                                    } = {url => 'https://github.com/ReneNyffenegger/about-Docker'                            , dir => $about_dir };
$repos{'Document-Object-Model'                     } = {url => 'https://github.com/ReneNyffenegger/about-Document-Object-Model'             , dir => $about_dir };
$repos{'Doxygen'                                   } = {url => 'https://github.com/ReneNyffenegger/about-Doxygen'                           , dir => $about_dir };
$repos{'draw-io'                                   } = {url => 'https://github.com/ReneNyffenegger/about-draw-io'                           , dir => $about_dir };
$repos{'d3.js'                                     } = {url => 'https://github.com/ReneNyffenegger/about-d3.js'                             , dir => $about_dir };
$repos{'Excel'                                     } = {url => 'https://github.com/ReneNyffenegger/about-Excel'                             , dir => $about_dir };
$repos{'filesystems-and-partitions'                } = {url => 'https://github.com/ReneNyffenegger/about-filesystems-and-partitions'        , dir => $about_dir };
$repos{'FinnOne'                                   } = {url => 'https://github.com/ReneNyffenegger/about-FinnOne-Neo'                       , dir => $about_dir };
$repos{'gcc'                                       } = {url => 'https://github.com/ReneNyffenegger/about-gcc'                               , dir => $about_dir };
$repos{'git'                                       } = {url => 'https://github.com/ReneNyffenegger/about-git'                               , dir => $about_dir };
$repos{'GMT'                                       } = {url => 'https://github.com/ReneNyffenegger/about-GMT'                               , dir => $about_dir };
$repos{'GNU-Binutils'                              } = {url => 'https://github.com/ReneNyffenegger/about-GNU-Binutils'                      , dir => $about_dir };
$repos{'GNU-Build-System'                          } = {url => 'https://github.com/ReneNyffenegger/about-GNU-Build-System'                  , dir => $about_dir };
$repos{'GoogleEarth'                               } = {url => 'https://github.com/ReneNyffenegger/about-GoogleEarth'                       , dir => $about_dir };
$repos{'Graphviz'                                  } = {url => 'https://github.com/ReneNyffenegger/about-Graphviz'                          , dir => $about_dir };
$repos{'groff'                                     } = {url => 'https://github.com/ReneNyffenegger/about-groff'                             , dir => $about_dir };
$repos{'hadoop'                                    } = {url => 'https://github.com/ReneNyffenegger/about-hadoop'                            , dir => $about_dir };
$repos{'html'                                      } = {url => 'https://github.com/ReneNyffenegger/about-html'                              , dir => $about_dir };
$repos{'html-canvas'                               } = {url => 'https://github.com/ReneNyffenegger/about-html-canvas'                       , dir => $about_dir };
$repos{'IEEE-754'                                  } = {url => 'https://github.com/ReneNyffenegger/about-IEEE-754'                          , dir => $about_dir };
$repos{'impress.js'                                } = {url => 'https://github.com/ReneNyffenegger/about-impress.js'                        , dir => $about_dir };
$repos{'indexed-DB'                                } = {url => 'https://github.com/ReneNyffenegger/about-indexed-DB'                        , dir => $about_dir };
$repos{'Java'                                      } = {url => 'https://github.com/ReneNyffenegger/about-Java'                              , dir => $about_dir };
$repos{'javascript'                                } = {url => 'https://github.com/ReneNyffenegger/about-javascript'                        , dir => $about_dir };
$repos{'jmpress.js'                                } = {url => 'https://github.com/ReneNyffenegger/about-jmpress.js'                        , dir => $about_dir };
$repos{'jqGrid'                                    } = {url => 'https://github.com/ReneNyffenegger/about-jqGrid'                            , dir => $about_dir };
$repos{'jQuery'                                    } = {url => 'https://github.com/ReneNyffenegger/about-jQuery'                            , dir => $about_dir };
$repos{'jQuery-UI'                                 } = {url => 'https://github.com/ReneNyffenegger/about-jQuery-UI'                         , dir => $about_dir };
$repos{'jrunscript'                                } = {url => 'https://github.com/ReneNyffenegger/about-jrunscript'                        , dir => $about_dir };
$repos{'libc'                                      } = {url => 'https://github.com/ReneNyffenegger/about-libc'                              , dir => $about_dir };
$repos{'Linux'                                     } = {url => 'https://github.com/ReneNyffenegger/about-Linux'                             , dir => $about_dir };
$repos{'about-man-pages'                           } = {url => 'https://github.com/ReneNyffenegger/about-man-pages'                         , dir => $about_dir }; # Compare with man-pages
$repos{'m4'                                        } = {url => 'https://github.com/ReneNyffenegger/about-m4'                                , dir => $about_dir };
$repos{'node.js'                                   } = {url => 'https://github.com/ReneNyffenegger/about-node.js'                           , dir => $about_dir };
$repos{'Makefile'                                  } = {url => 'https://github.com/ReneNyffenegger/about-Makefile'                          , dir => $about_dir };
$repos{'MapReduce'                                 } = {url => 'https://github.com/ReneNyffenegger/about-MapReduce'                         , dir => $about_dir };
$repos{'Meson'                                     } = {url => 'https://github.com/ReneNyffenegger/about-Meson'                             , dir => $about_dir };
$repos{'MathJax'                                   } = {url => 'https://github.com/ReneNyffenegger/about-MathJax'                           , dir => $about_dir };
$repos{'mshta'                                     } = {url => 'https://github.com/ReneNyffenegger/about-mshta'                             , dir => $about_dir };
$repos{'MS-Office-object-model'                    } = {url => 'https://github.com/ReneNyffenegger/about-MS-Office-object-model'            , dir => $about_dir };
$repos{'MSSQL'                                     } = {url => 'https://github.com/ReneNyffenegger/about-MSSQL'                             , dir => $about_dir };
$repos{'Office-Open-XML'                           } = {url => 'https://github.com/ReneNyffenegger/about-Office-Open-XML'                   , dir => $about_dir };
$repos{'Open-Street-Map'                           } = {url => 'https://github.com/ReneNyffenegger/about-Open-Street-Map'                   , dir => $about_dir };
$repos{'perl'                                      } = {url => 'https://github.com/ReneNyffenegger/about-perl'                              , dir => $about_dir };
$repos{'php'                                       } = {url => 'https://github.com/ReneNyffenegger/about-php'                               , dir => $about_dir };
$repos{'preprocessor'                              } = {url => 'https://github.com/ReneNyffenegger/about-preprocessor'                      , dir => $about_dir };
$repos{'Protocols'                                 } = {url => 'https://github.com/ReneNyffenegger/about-protocols'                         , dir => $about_dir };
$repos{'Pig'                                       } = {url => 'https://github.com/ReneNyffenegger/about-Pig'                               , dir => $about_dir };
$repos{'powershell'                                } = {url => 'https://github.com/ReneNyffenegger/about-powershell'                        , dir => $about_dir };
$repos{'python'                                    } = {url => 'https://github.com/ReneNyffenegger/about-python'                            , dir => $about_dir };
$repos{'README.md'                                 } = {url => 'https://github.com/ReneNyffenegger/about-README.md'                         , dir => $about_dir };
$repos{'r'                                         } = {url => 'https://github.com/ReneNyffenegger/about-r'                                 , dir => $about_dir };
$repos{'SAS'                                       } = {url => 'https://github.com/ReneNyffenegger/about-SAS'                               , dir => $about_dir };
$repos{'sed'                                       } = {url => 'https://github.com/ReneNyffenegger/about-sed'                               , dir => $about_dir };
$repos{'SpiderMonkey-shell'                        } = {url => 'https://github.com/ReneNyffenegger/about-SpiderMonkey-shell'                , dir => $about_dir };
$repos{'skychart'                                  } = {url => 'https://github.com/ReneNyffenegger/about-skychart'                          , dir => $about_dir };
$repos{'sqlite'                                    } = {url => 'https://github.com/ReneNyffenegger/about-sqlite'                            , dir => $about_dir };
$repos{'sqlite-c-interface'                        } = {url => 'https://github.com/ReneNyffenegger/about-sqlite-c-interface'                , dir => $about_dir };
$repos{'Stellarium'                                } = {url => 'https://github.com/ReneNyffenegger/about-Stellarium'                        , dir => $about_dir };
$repos{'STL'                                       } = {url => 'https://github.com/ReneNyffenegger/about-STL'                               , dir => $about_dir };
$repos{'svg'                                       } = {url => 'https://github.com/ReneNyffenegger/about-svg'                               , dir => $about_dir };
$repos{'three.js'                                  } = {url => 'https://github.com/ReneNyffenegger/about-three.js'                          , dir => $about_dir };
$repos{'TopoJSON'                                  } = {url => 'https://github.com/ReneNyffenegger/about-TopoJSON'                          , dir => $about_dir };
$repos{'Unicode'                                   } = {url => 'https://github.com/ReneNyffenegger/about-Unicode'                           , dir => $about_dir };
$repos{'Valgrind'                                  } = {url => 'https://github.com/ReneNyffenegger/about-Valgrind'                          , dir => $about_dir };
$repos{'VBA'                                       } = {url => 'https://github.com/ReneNyffenegger/about-VBA'                               , dir => $about_dir };
$repos{'VBScript'                                  } = {url => 'https://github.com/ReneNyffenegger/about-VBScript'                          , dir => $about_dir };
$repos{'about-vim'                                 } = {url => 'https://github.com/ReneNyffenegger/about-vim'                               , dir => $about_dir }; # TODO: should that not be just the direcotry 'vim' instead of 'about-vim'?
$repos{'Web-Extensions'                            } = {url => 'https://github.com/ReneNyffenegger/about-Web-Extensions'                    , dir => $about_dir };
$repos{'WebGL'                                     } = {url => 'https://github.com/ReneNyffenegger/about-WebGL'                             , dir => $about_dir };
$repos{'Windows-Registry'                          } = {url => 'https://github.com/ReneNyffenegger/about-Windows-Registry'                  , dir => $about_dir };
$repos{'wsh'                                       } = {url => 'https://github.com/ReneNyffenegger/about-wsh'                               , dir => $about_dir }; #_}

$repos{'Algorithms'                                } = {url => 'https://github.com/ReneNyffenegger/Algorithms'                              , dir => $github_dir}; #_{
$repos{'Amdocs'                                    } = {url => 'https://github.com/ReneNyffenegger/Amdocs'                                  , dir => $github_dir};
$repos{'Apache-logfile'                            } = {url => 'https://github.com/ReneNyffenegger/Apache-logfile'                          , dir => $github_dir};
$repos{'Arch-Linux-UEFI-Installation'              } = {url => 'https://github.com/ReneNyffenegger/Arch-Linux-UEFI-Installation'            , dir => $github_dir};
$repos{'Astronomie'                                } = {url => 'https://github.com/ReneNyffenegger/Astronomie'                              , dir => $github_dir};
$repos{'Ausfluege-Touren-etc'                      } = {url => 'https://github.com/ReneNyffenegger/Ausfluege-Touren-etc'                    , dir => $github_dir};
$repos{'Bibelhebraeisch-lernen'                    } = {url => 'https://github.com/ReneNyffenegger/Bibelhebraeisch-lernen'                  , dir => $github_dir};
$repos{'Bibeluebersetzungen'                       } = {url => 'https://github.com/ReneNyffenegger/Bibeluebersetzungen'                     , dir => $github_dir};
$repos{'Bibelkommentare'                           } = {url => 'https://github.com/ReneNyffenegger/Bibelkommentare'                         , dir => $github_dir};
$repos{'Bible-Text-Sources'                        } = {url => 'https://github.com/ReneNyffenegger/Bible-Text-Sources'                      , dir => $github_dir};
$repos{'Bible-Textual-Criticism'                   } = {url => 'https://github.com/ReneNyffenegger/Bible-Textual-Criticism'                 , dir => $github_dir};
$repos{'Biblisches'                                } = {url => 'https://github.com/ReneNyffenegger/Biblisches'                              , dir => $github_dir};
$repos{'bitcoin-notes'                             } = {url => 'https://github.com/ReneNyffenegger/bitcoin-notes'                           , dir => $github_dir};
$repos{'browser-object-model'                      } = {url => 'https://github.com/ReneNyffenegger/Browser-Object-Model'                    , dir => $github_dir};
$repos{'Browser-Helper-Objects'                    } = {url => 'https://github.com/ReneNyffenegger/Browser-Helper-Objects'                  , dir => $github_dir};
$repos{'Chronologie'                               } = {url => 'https://github.com/ReneNyffenegger/Chronologie'                             , dir => $github_dir};
$repos{'Clarify'                                   } = {url => 'https://github.com/ReneNyffenegger/Clarify'                                 , dir => $github_dir};
$repos{'Configure-Windows'                         } = {url => 'https://github.com/ReneNyffenegger/Configure-Windows'                       , dir => $github_dir};
$repos{'COM-in-plain-C'                            } = {url => 'https://github.com/ReneNyffenegger/COM-in-plain-C'                          , dir => $github_dir};
$repos{'compile-dll'                               } = {url => 'https://github.com/ReneNyffenegger/compile-dll'                             , dir => $github_dir};
$repos{'cpp-base64'                                } = {url => 'https://github.com/ReneNyffenegger/cpp-base64'                              , dir => $github_dir};
$repos{'cpp-MSHTML'                                } = {url => 'https://github.com/ReneNyffenegger/cpp-MSHTML'                              , dir => $github_dir};
$repos{'cpp-webserver'                             } = {url => 'https://github.com/ReneNyffenegger/cpp-webserver'                           , dir => $github_dir};
$repos{'crawler'                                   } = {url => 'https://github.com/ReneNyffenegger/crawler'                                 , dir => $github_dir};
$repos{'Csound'                                    } = {url => 'https://github.com/ReneNyffenegger/Csound'                                  , dir => $github_dir};
$repos{'data-stackexchange'                        } = {url => 'https://github.com/ReneNyffenegger/data-stackexchange'                      , dir => $github_dir};
$repos{'data-visualization'                        } = {url => 'https://github.com/ReneNyffenegger/data-visualization'                      , dir => $github_dir};
$repos{'development_misc'                          } = {url => 'https://github.com/ReneNyffenegger/development_misc'                        , dir => $github_dir};
$repos{'Earthquakes'                               } = {url => 'https://github.com/ReneNyffenegger/Earthquakes'                             , dir => $github_dir};
$repos{'EGG'                                       } = {url => 'https://github.com/ReneNyffenegger/EGG-Explosion-Graphics-Generator'        , dir => $github_dir};
$repos{'epson-inkjet-printer-escpr'                } = {url => 'https://github.com/ReneNyffenegger/epson-inkjet-printer-escpr'              , dir => $github_dir};
$repos{'Fonts'                                     } = {url => 'https://github.com/ReneNyffenegger/Fonts'                                   , dir => $github_dir};
$repos{'gcc-create-library'                        } = {url => 'https://github.com/ReneNyffenegger/gcc-create-library'                      , dir => $github_dir};
$repos{'Geschichte-der-Wissenschaft'               } = {url => 'https://github.com/ReneNyffenegger/Geschichte-der-Wissenschaft'             , dir => $github_dir};
$repos{'Global-Relief-Model'                       } = {url => 'https://github.com/ReneNyffenegger/Global-Relief-Model'                     , dir => $github_dir};
$repos{'git-internals'                             } = {url => 'https://github.com/ReneNyffenegger/git-internals'                           , dir => $github_dir};
$repos{'Graphic-Design-Fonts'                      } = {url => 'https://github.com/ReneNyffenegger/Graphic-Design-and-Font'                 , dir => $github_dir};
$repos{'Google-Suchbegriffe'                       } = {url => 'https://github.com/ReneNyffenegger/Google-Suchbegriffe'                     , dir => $github_dir};
$repos{'HTP-2018'                                  } = {url => 'https://github.com/ReneNyffenegger/HTP-2018'                                , dir => $github_dir};
$repos{'Hydroplattentheorie'                       } = {url => 'https://github.com/ReneNyffenegger/Hydroplattentheorie'                     , dir => $github_dir};
$repos{'JavaClasses'                               } = {url => 'https://github.com/ReneNyffenegger/JavaClasses'                             , dir => $github_dir};
$repos{'kaggle'                                    } = {url => 'https://github.com/ReneNyffenegger/kaggle'                                  , dir => $github_dir};
$repos{'Karten'                                    } = {url => 'https://github.com/ReneNyffenegger/Karten'                                  , dir => $github_dir};
$repos{'Kenan-Arbor'                               } = {url => 'https://github.com/ReneNyffenegger/Kenan-Arbor'                             , dir => $github_dir};
$repos{'Linux-From-Scratch'                        } = {url => 'https://github.com/ReneNyffenegger/Linux-From-Scratch'                      , dir => $github_dir};
$repos{'man-pages'                                 } = {url => 'https://github.com/ReneNyffenegger/man-pages'                               , dir => $github_dir}; # Compare with about-man-pages
$repos{'Meta-Oracle'                               } = {url => 'https://github.com/ReneNyffenegger/Meta-Oracle'                             , dir => $github_dir};
$repos{'MS-Dynamics-CRM-ODATA'                     } = {url => 'https://github.com/ReneNyffenegger/MS-Dynamics-CRM-ODATA'                   , dir => $github_dir};
$repos{'netcat'                                    } = {url => 'https://github.com/ReneNyffenegger/netcat'                                  , dir => $github_dir};
$repos{'notes'                                     } = {url => 'https://github.com/ReneNyffenegger/notes'                                   , dir => $github_dir};
$repos{'OCR-tests'                                 } = {url => 'https://github.com/ReneNyffenegger/OCR-tests'                               , dir => $github_dir};
$repos{'OpenStreetMap'                             } = {url => 'https://github.com/ReneNyffenegger/OpenStreetMap'                           , dir => $github_dir};
$repos{'oracle-patterns'                           } = {url => 'https://github.com/ReneNyffenegger/oracle-patterns'                         , dir => $github_dir};
$repos{'Oracle-Performance-Investigations'         } = {url => 'https://github.com/ReneNyffenegger/Oracle-Performance-Investigations'       , dir => $github_dir};
$repos{'oracle_scriptlets'                         } = {url => 'https://github.com/ReneNyffenegger/oracle_scriptlets'                       , dir => $github_dir};
$repos{'Oracle-SQL-clauses'                        } = {url => 'https://github.com/ReneNyffenegger/Oracle-SQL-clauses'                      , dir => $github_dir};
$repos{'OracleTool'                                } = {url => 'https://github.com/ReneNyffenegger/OracleTool'                              , dir => $github_dir};
$repos{'Oracle-Privileges-etc'                     } = {url => 'https://github.com/ReneNyffenegger/Oracle-Privileges-etc'                   , dir => $github_dir};
$repos{'Oracle-Tutorial'                           } = {url => 'https://github.com/ReneNyffenegger/Oracle-Tutorial'                         , dir => $github_dir};
$repos{'Partition-tables-and-file-systems'         } = {url => 'https://github.com/ReneNyffenegger/Partition-tables-and-file-systems'       , dir => $github_dir};
$repos{'PostLinuxInstallation'                     } = {url => 'https://github.com/ReneNyffenegger/PostLinuxInstallation'                   , dir => $github_dir};
$repos{'PerlModules'                               } = {url => 'https://github.com/ReneNyffenegger/PerlModules'                             , dir => $github_dir};
$repos{'perl-webserver'                            } = {url => 'https://github.com/ReneNyffenegger/perl-webserver'                          , dir => $github_dir};
$repos{'printing'                                  } = {url => 'https://github.com/ReneNyffenegger/printing'                                , dir => $github_dir};
$repos{'renenyffenegger.blogspot.com'              } = {url => 'https://github.com/ReneNyffenegger/renenyffenegger.blogspot.com'            , dir => $github_dir};
$repos{'RN'                                        } = {url => 'https://github.com/ReneNyffenegger/RN'                                      , dir => $github_dir};
$repos{'sea-level'                                 } = {url => 'https://github.com/ReneNyffenegger/sea-level'                               , dir => $github_dir};
$repos{'SDLC'                                      } = {url => 'https://github.com/ReneNyffenegger/SDLC'                                    , dir => $github_dir};
$repos{'Skizzen'                                   } = {url => 'https://github.com/ReneNyffenegger/Skizzen'                                 , dir => $github_dir};
$repos{'shell-commands'                            } = {url => 'https://github.com/ReneNyffenegger/shell-commands'                          , dir => $github_dir};
$repos{'stationary-background'                     } = {url => 'https://github.com/ReneNyffenegger/stationary-background'                   , dir => $github_dir};
$repos{'statistics'                                } = {url => 'https://github.com/ReneNyffenegger/statistics'                              , dir => $github_dir};
$repos{'Sprachen'                                  } = {url => 'https://github.com/ReneNyffenegger/Sprachen'                                , dir => $github_dir};
$repos{'SQL-Server-helpers'                        } = {url => 'https://github.com/ReneNyffenegger/SQL-Server-helpers'                      , dir => $github_dir};
$repos{'swap-keys'                                 } = {url => 'https://github.com/ReneNyffenegger/swap-keys'                               , dir => $github_dir};
$repos{$sql_dev_decryptor                          } = {url => "https://github.com/ReneNyffenegger/$sql_dev_decryptor"                      , dir => $github_dir};
$repos{'Tetragrammaton'                            } = {url => 'https://github.com/ReneNyffenegger/Tetragrammaton'                          , dir => $github_dir};
$repos{'tq84.css'                                  } = {url => 'https://github.com/ReneNyffenegger/tq84.css'                                , dir => $github_dir};
$repos{'VBA-calls-DLL'                             } = {url => 'https://github.com/ReneNyffenegger/VBA-calls-DLL'                           , dir => $github_dir};
$repos{'VBA-Task-Automator'                        } = {url => 'https://github.com/ReneNyffenegger/VBA-Task-Automator'                      , dir => $github_dir};
$repos{'vim'                                       } = {url => 'https://github.com/ReneNyffenegger/vim'                                     , dir => $github_dir};
$repos{'Vortraege'                                 } = {url => 'https://github.com/ReneNyffenegger/Vortraege'                               , dir => $github_dir};
$repos{'WebAutomation'                             } = {url => 'https://github.com/ReneNyffenegger/WebAutomation'                           , dir => $github_dir};
$repos{'Windows-API'                               } = {url => 'https://github.com/ReneNyffenegger/Windows-API'                             , dir => $github_dir};
$repos{'WinAPI'                                    } = {url => 'https://github.com/ReneNyffenegger/WinAPI'                                  , dir => $github_dir};
$repos{'WinAPI-4-VBA'                              } = {url => 'https://github.com/ReneNyffenegger/WinAPI-4-VBA'                            , dir => $github_dir};
$repos{'Windows-development'                       } = {url => 'https://github.com/ReneNyffenegger/Windows-development'                     , dir => $github_dir};
$repos{'wfind'                                     } = {url => 'https://github.com/ReneNyffenegger/wfind'                                   , dir => $github_dir};
$repos{'word-db'                                   } = {url => 'https://github.com/ReneNyffenegger/word-db'                                 , dir => $github_dir};
$repos{'wordlists.ch'                              } = {url => 'https://github.com/ReneNyffenegger/wordlists.ch'                            , dir => $github_dir};
$repos{'Y-Combinator'                              } = {url => 'https://github.com/ReneNyffenegger/Y-Combinator'                            , dir => $github_dir};
$repos{'Zahlen'                                    } = {url => 'https://github.com/ReneNyffenegger/Zahlen'                                  , dir => $github_dir};
$repos{'Zefix'                                     } = {url => 'https://github.com/ReneNyffenegger/Zefix'                                   , dir => $github_dir}; #_}

$repos{'.vim'                                      } = {url => 'https://github.com/ReneNyffenegger/.vim'                                    , dir =>'special .vim'};

mkdir $lib_dir    unless -d $lib_dir;
mkdir $about_dir  unless -d $about_dir;
mkdir $github_dir unless -d $github_dir;

for my $repo (keys %repos) { #_{ #_{

  my $repository_path = "$repos{$repo}{dir}/$repo";
  my $repo_parent     =  $repos{$repo}{dir};
  my $repo_directory  =  $repo;

  if ($repos{$repo}{dir} eq 'special .vim') { #_{
    $repo_parent     = File::HomeDir -> my_home;

    if ($^O eq 'MSWin32' or $^O eq 'MSWin64') {
      $repository_path = File::HomeDir -> my_home . '/vimfiles';
      $repo_directory  = 'vimfiles';
    }
    else {
      $repository_path = File::HomeDir -> my_home . '/.vim';
      $repo_directory  = '.vim';
    }
  } #_}

  if ($list_repos) { #_{

      if ($arg1 and $repo =~ /$arg1/i or !$arg1) {

        printf ("%-50s", $repo);

        printf "directory does not exist" unless -d $repository_path;
        print "\n";
      }
      next;
  } #_}

  print "repo: $repo\n" if $debug;


  unless ($start_day or $end_day) { #_{
    if ($match and $repo !~ /$match/i) { #_{
       next;
    } #_}
    if ($exact and $repo ne $exact) { #_{
       next;
    } #_}
  } #_}



  if (-d $repository_path ) { #_{
      
     chdir "$repository_path";

     if ($push  or ( $end_day and is_daily_repo($repo))) {  #_{

       print "--push or (--end-day and is_daily_repo($repo))\n" if $debug;

       if ($^O eq 'MSWin32') {
         system "gitp.bat";
       }
       else {
         system "gitp.sh";
       }

     } #_}
     elsif ($end_day) {
        print "      skip, because --end_day\n" if $debug;
        next;
     }
     elsif ($check_status) { #_{
        my @git_response = readpipe('git status -s');
#       @git_response = grep { !/^(# )?On branch (master|tq84)$/ } @git_response;
#       @git_response = grep { !/^Your branch is up-to-date with 'origin\/master'\.$/ } @git_response;
#       @git_response = grep { !/^Your branch is ahead of 'origin\/master' by \d+ commits?.$/ } @git_response;
#       @git_response = grep { !/^nothing to commit,? \(?working directory clean\)?$/ } @git_response;
#       @git_response = grep { !/^  \(use "git push" to publish your local commits\)$/ } @git_response;

        if (@git_response) {
          print "\n\n\n$repository_path\n";
          print "----------------------------\n";
          print map {"      $_"} @git_response;
        }
     } #_}
     elsif (!$todo) { #_{
       if (($start_day and is_daily_repo($repo)) or !$start_day) { #_{
         print "\n\nRepo $repository_path exists, updating it\n";
         my $git_response = readpipe("git pull");
         print $git_response;
       } #_}
     } #_}
     else { #_{

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
     } #_}

  } #_}
  else { #_{

     if ($end_day) {
       next;
     }

     die "cannot push $repo, directory does not exist!" if $push;

     next if $todo; # In todo-mode, do nothing if the repository does not exist
     next if $check_status;
     next if $start_day and !is_daily_repo($repo);

     chdir $repo_parent;

     my $command = "git clone $repos{$repo}{url} $repo_directory";

     print "\n\nRepo $repository_path does not exist, cloning it [$command]\n";

     my $git_response = readpipe($command);
     print $git_response;

  } #_}
} #_} #_}


sub usage { #_{
  print "\n";
  print "  ghr.pl exact-expression\n";
  print "  ghr.pl --match regular-expression\n";
  print "  ghr.pl /regexp\n";
  print "  ghr.pl --push repo\n";
  print "  ghr.pl --start-day\n";
  print "  ghr.pl --end-day\n";
  print "  ghr.pl --list-repos   [regexp]\n";
  print "  ghr.pl --check-status\n";
  print "  ghr.pl --debug\n";
  print "  ghr.pl --todo\n";
  print "  ghr.pl --help\n";
  print "\n";
} #_}

sub is_daily_repo {
  my $repo = shift;

  return 1 if $repo eq 'Bibelkommentare';
  return 1 if $repo eq 'Bibeluebersetzungen';
  return 1 if $repo eq 'notes';

  return 0;
}
