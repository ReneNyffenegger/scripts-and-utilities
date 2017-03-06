#!/usr/bin/perl
#
#   A Script to automatically connect to
#   Cisco AnyConnect Secure Mobility Client
#
use warnings;
use strict;

use Win32::GuiTest qw(WaitWindowLike FindWindowLike SetForegroundWindow SendKeys WaitWindow GetChildWindows GetChildWindows GetClassName GetWindowText GetWindowRect);

my $host      = shift;
die "Indicate a host to connect to" unless $host;

my $password = shift;
die "Indicate a password" unless $password;

my $cisco_txt = "Cisco AnyConnect Secure Mobility Client";

system 'start "" "c:\Program Files\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe"';


        WaitWindowLike(undef, $cisco_txt, '#32770', undef, undef, 1, 1);
my @w = FindWindowLike(undef, $cisco_txt, '#32770', undef, undef, 1);

die if @w > 1;
SetForegroundWindow($w[0]);

print "1\n";
SendKeys('{TAB 2}{ENTER}', 0);

WaitWindow("Cisco AnyConnect \\| $host");

print "2\n";
SendKeys($password, 0);
SendKeys('{TAB}{ENTER}', 0);


my $wnd_connection_status;
for my $c (GetChildWindows($w[0])) { #_{
  if (GetClassName($c) eq 'Static') {
    my ($l_, $t_, $r_, $b_) = GetWindowRect($c);
    if ($l_ == 610 and $t_ == 423 and $r_ == 907 and $b_ == 449) {
      $wnd_connection_status = $c;
      last;
    }
  }
} #_}

while (1) { #_{
  last if (GetWindowText($wnd_connection_status) =~ /^Connected to/);

  sleep (1);
} #_}
