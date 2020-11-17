#
#  Note to self: create file %userprofile%\psh.bat with following content:
#
#    @powershell -executionpolicy bypass -noExit -file c:\lib\Scripts\profile.ps1
#

# Equivalent of «dir /od» in cmd.exe
function dod { get-childItem | sort-object lastWriteTime }

# Equivalent of «dir /s /b» in cmd.exe  ( http://stackoverflow.com/a/1479683/180275 )
function dsb($pattern) { get-childItem -filter $pattern  -recurse -force | select-object -expandProperty fullName }

# Show individual path-components of the PATH environment variable, each on its own line:
function paths() { $env:PATH -split ';' }

if ($psEdition -eq 'Desktop') {
  function pc() { (get-item .).ToString() | set-clipboard }
}
else {
# clipboardText needs to be installed:
#    install-module -name ClipboardText
  function pc() { (get-item .).ToString() | set-clipboardText }
}

# Find below
# use fullName to emulate "dir /b /s"
function fb($wildcard) { get-childItem -recurse -filter $wildcard | select-object fullName }

function cdnot() {
   cd $env:github_top_root/github/notes/notes
}

# Change behaviour of cd {
#
# Introduce  $OLDPWD and the dash option.
# Using cd sets $OLDPWD to the directory
# I came from. 'cd -' goes to $OLDPWD.
#
# Code was found @ https://gist.github.com/naiduv/c975528f02aed8e20232dfb366b41e14

remove-item alias:cd

function cd($newPWD) {

  if (-not $newPWD) {
     return
  }

  if ($newPWD -eq '-') {
      $newPWD = $oldPWD;
  }

  $curPWD = get-location
  set-location $newPWD
  $global:oldPWD = $curPWD
}
# }

# Start same powershell executable as administrator
function admin() {
   $ps_exe = (get-process -pid $pid).path
   start-process $ps_exe -verb runAs
}

# vi editing mode;
set-psReadLineOption -editMode vi
