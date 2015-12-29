use warnings;
use strict;
use Win32::Process;
use Win32::Process::List;

my $which = 'open-office';

my $reg_ex;
if ($which eq 'open-office') {
  $reg_ex = 'soffice.exe|soffice.bin|swriter.exe';
}


my $procs = new Win32::Process::List;
my %proc_list = $procs->GetProcesses();
foreach my $pid ( keys %proc_list ) {
   if ($proc_list{$pid} =~ /$reg_ex/) {
#     print "$proc_list{$pid}\n";      
      Win32::Process::KillProcess($pid, 0) and print "Killed $proc_list{$pid} ($pid)\n";
   }
}
