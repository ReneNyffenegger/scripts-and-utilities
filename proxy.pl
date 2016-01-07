use warnings;
use strict;
use Win32::TieRegistry(Delimiter=>"/", ArrayValues=>0);;
use Win32::API;

use Getopt::Long;

GetOptions (

  'on'     => \my $on,
  'off'    => \my $off,
  'host=s' => \my $host,
) or die;

my $regpath = 'HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/Internet Settings/';

evaluate_cmd_line_options();
make_registry_changes_effective();

sub evaluate_cmd_line_options {
  if ($on) {
     print "Enabling proxy\n";
     en_dis_able_proxy(1);
  }
  if ($off) {
     print "Disabling proxy\n";
     en_dis_able_proxy(0);
  }
  if ($host) {
     print "Setting host to $host\n";
     $Registry -> {$regpath . 'ProxyServer'} = $host;
  }
}

sub make_registry_changes_effective {

  my $InternetSetOption = Win32::API->new("wininet", "InternetSetOption", [qw(N N N N)], 'N');

  $InternetSetOption->Call(0, 39, 0, 0) || die "$!\n";
  $InternetSetOption->Call(0, 37, 0, 0) || die "$!\n";

}

sub en_dis_able_proxy {
  my $en_dis = shift;
  $Registry -> {$regpath . 'ProxyEnable'} = [pack ('L', $en_dis), 'REG_DWORD'];
}
