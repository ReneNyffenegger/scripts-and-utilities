use warnings;
use strict;

my $out = readpipe ('..\find_large_directories.pl directories');

die "Difference found in first test:
$out
"   unless $out eq '
Total size: 352

+--- 352
|   +---a 162
|   |   +---a1 5
|   |   +---a2 64
|   |   |   +---a2a 45
|   |   |   +---a2b 10
|   |   |   +---a2c 6
|   |   |   |   +---a2c1 2
|   |   |   |   +---a2c2 2
|   |   |   |   +---a2c3 1
|   |   +---a3 93
|   |   |   +---a3a 60
|   |   |   |   +---a3a1 40
|   |   |   |   |   +---a3a1a 9
|   |   |   |   |   +---a3a1b 10
|   |   |   +---a3b 26
|   +---b 122
|   |   +---b1 122
|   |   |   +---b1a 122
|   |   |   |   +---b1a1 122
|   |   |   |   |   +---b1a1a 122
|   |   |   |   |   |   +---b1a1a1 122
|   |   |   |   |   |   |   +---b1a1a1a 122
|   |   |   |   |   |   |   |   +---b1a1a1a1 122
|   |   |   |   |   |   |   |   |   +---b1a1a1a1a 122
|   +---c 68
|   |   +---c1 39
|   |   +---c2 29
|   |   |   +---c2a 9
|   |   |   +---c2b 20
';




$out = readpipe ('..\find_large_directories.pl -l 2 directories');
die "Difference found in second test:
$out
" unless $out eq '
Total size: 352

+--- 352
|   +---a 162
|   |   +---a3 93
|   |   |   +---a3a 60
|   |   |   |   +---a3a1 40
|   |   |   |   |   +---a3a1b 10
|   |   |   |   |   +---a3a1a 9
|   |   |   +---a3b 26
|   |   +---a2 64
|   |   |   +---a2a 45
|   |   |   +---a2b 10
|   +---b 122
|   |   +---b1 122
|   |   |   +---b1a 122
|   |   |   |   +---b1a1 122
|   |   |   |   |   +---b1a1a 122
|   |   |   |   |   |   +---b1a1a1 122
|   |   |   |   |   |   |   +---b1a1a1a 122
|   |   |   |   |   |   |   |   +---b1a1a1a1 122
|   |   |   |   |   |   |   |   |   +---b1a1a1a1a 122
';

$out = readpipe ('..\find_large_directories.pl -l 2 -pct directories');
die "Difference found in third test:
$out
" unless $out eq '
Total size: 352

+--- 100.00
|   +---a 46.02
|   |   +---a3 26.42
|   |   |   +---a3a 17.05
|   |   |   |   +---a3a1 11.36
|   |   |   |   |   +---a3a1b 2.84
|   |   |   |   |   +---a3a1a 2.56
|   |   |   +---a3b 7.39
|   |   +---a2 18.18
|   |   |   +---a2a 12.78
|   |   |   +---a2b 2.84
|   +---b 34.66
|   |   +---b1 34.66
|   |   |   +---b1a 34.66
|   |   |   |   +---b1a1 34.66
|   |   |   |   |   +---b1a1a 34.66
|   |   |   |   |   |   +---b1a1a1 34.66
|   |   |   |   |   |   |   +---b1a1a1a 34.66
|   |   |   |   |   |   |   |   +---b1a1a1a1 34.66
|   |   |   |   |   |   |   |   |   +---b1a1a1a1a 34.66
';

$out = readpipe ('..\find_large_directories.pl -depth 3 directories');
die "Difference found in fourth test:
$out
" unless $out eq '
Total size: 352

+--- 352
|   +---a 162
|   |   +---a1 5
|   |   +---a2 64
|   |   +---a3 93
|   +---b 122
|   |   +---b1 122
|   +---c 68
|   |   +---c1 39
|   |   +---c2 29
';

$out = readpipe ('..\find_large_directories.pl -depth 5 -largest 3 -curly directories');

die "Difference found in fifth test:
$out
" unless $out eq '
Total size: 352

{  352
  { a 162
    { a3 93
      { a3a 60
        { a3a1 40
        }
      }
      { a3b 26
      }
    }
    { a2 64
      { a2a 45
      }
      { a2b 10
      }
      { a2c 6
        { a2c1 2
        }
        { a2c2 2
        }
        { a2c3 1
        }
      }
    }
    { a1 5
    }
  }
  { b 122
    { b1 122
      { b1a 122
        { b1a1 122
        }
      }
    }
  }
  { c 68
    { c1 39
    }
    { c2 29
      { c2b 20
      }
      { c2a 9
      }
    }
  }
}
';
