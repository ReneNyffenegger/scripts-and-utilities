#!/usr/bin/perl
#
#   A Script to automatically connect to
#   Cisco AnyConnect Secure Mobility Client
#
use warnings;
use strict;

use Win32::GuiTest qw(WaitWindowLike FindWindowLike SetForegroundWindow SendKeys WaitWindow GetChildWindows GetChildWindows GetClassName GetWindowText GetWindowRect);

my $verbose = 1;

my $host      = shift;
die "Indicate a host to connect to" unless $host;

my $password = shift;
die "Indicate a password" unless $password;

my $cisco_txt = "Cisco AnyConnect Secure Mobility Client";

system 'start "" "c:\Program Files\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe"';


        WaitWindowLike(undef, $cisco_txt, '#32770', undef, undef, 1, 1);
my @w = FindWindowLike(undef, $cisco_txt, '#32770', undef, undef, 1);

die unless @w;
print "Found Window with >$cisco_txt<\n" if $verbose;

die if @w > 1;
SetForegroundWindow($w[0]);

SendKeys('{TAB 2}{ENTER}', 0);

WaitWindow("Cisco AnyConnect \\| $host");

print "Window >Cisco AnyConnect<\n" if $verbose;
SendKeys($password, 0);
SendKeys('{TAB}{ENTER}', 0);


my $wnd_connection_status;
for my $c (GetChildWindows($w[0])) { #_{
  printf "Child Window $c, %s\n", GetClassName($c) if $verbose;
  if (GetClassName($c) eq 'Static') {
    my ($l_, $t_, $r_, $b_) = GetWindowRect($c);
    printf ("  %4d %4d %4d %4d\n", $l_, $t_, $r_, $b_) if $verbose;
    if ($l_ == 610 and $t_ == 423 and $r_ == 907 and $b_ == 449) {
      $wnd_connection_status = $c;
      last;
    }
  }
} #_}

print "wnd_connection_status = $wnd_connection_status\n" if $verbose;

while (1) { #_{
  last if (GetWindowText($wnd_connection_status) =~ /^Connected to/);

  sleep (1);
} #_}
