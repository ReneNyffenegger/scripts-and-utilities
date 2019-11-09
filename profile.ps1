#
#  Note to self: create file %userprofile%\psh.bat with following content:
#
#    @powershell -executionpolicy bypass -noExit -file c:\lib\Scripts\profile.ps1
#

# Equivalent of «dir /od» in cmd.exe
function dod { get-childItem | sort-object lastWriteTime }

# Equivalent of «dir /s /b» in cmd.exe  ( http://stackoverflow.com/a/1479683/180275 )
function dsb($pattern) { get-childItem -filter $pattern  -recurse -force | select-object -expandProperty fullName }

function pc() { (get-item .).ToString() | set-clipboard }

# vi editing mode;
set-psReadLineOption -editMode vi
