use warnings;
use strict;
use Win32::Process;
use Win32::Process::List;

my $which = shift; # 'open-office';

unless ($which) {
  usage();
  exit -1;
}
my $reg_ex;
if ($which eq 'open-office') {
  $reg_ex = 'soffice.exe|soffice.bin|swriter.exe';
}
elsif ($which eq 'ID') { # Input Director
  $reg_ex = 'InputDirectorSessionHelper.exe';
}
elsif ($which eq 'show') {
}
else {
  usage();
  exit -1;
}


my $procs = new Win32::Process::List;
my %proc_list = $procs->GetProcesses();
foreach my $pid ( keys %proc_list ) {
  if ($which eq 'show') { 
    printf "%4d %s\n", $pid, $proc_list{$pid};      
    next;
  }
  if ($proc_list{$pid} =~ /$reg_ex/) {
     print "$proc_list{$pid} $pid\n";      
     if (Win32::Process::KillProcess($pid, 0)) {
       print "Killed $proc_list{$pid} ($pid)\n";   
     } else {
       print "For a reason $proc_list{$pid} ($pid) was not killed\n";   
     }
  }
}

sub usage {
  print "
    kill-procs.pl open-office
    kill-procs.pl InputDirectorSessionHelper
";

}
