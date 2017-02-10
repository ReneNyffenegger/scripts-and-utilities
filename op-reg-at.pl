use warnings;
use strict;

use Win32::TieRegistry (Delimiter => '/');

my $reg_path = shift or die "Specify registry path";

$Registry -> {'HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/Applets/Regedit/LastKey'} = $reg_path;
system('regedit');
