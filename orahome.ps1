if ($env:ORACLE_HOME -eq $null) {
   write-host 'Environment variable ORACLE_HOME is not set'
   return
}

cd $env:ORACLE_HOME
