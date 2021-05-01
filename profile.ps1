#
#  Note to self: create file %userprofile%\psh.bat with following content:
#
#    @powershell -executionpolicy bypass -noExit -file c:\lib\Scripts\profile.ps1
#

#
#  Update «this» profile script from github
#
function update-profile { invoke-webRequest https://raw.githubusercontent.com/ReneNyffenegger/scripts-and-utilities/master/profile.ps1 -outFile $profile }

function prompt {

   # Get the built-in prompt function (before overriding it)
   # with
   #   (get-command prompt).ScriptBlock
   #
   # It is:
   #   "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) ";

   # @( … ) creates array even if get-history returns 0 or 1 elements.
   $hist = @( get-history )
   $thisId = 0
   if ($hist.count -gt 0) {
      $thisId = $hist[-1].id
   }

#  $curDir = get-location
   $curDir = $executionContext.sessionState.path.currentLocation


 # 2021-02-26: Print current directory with forward slashes instead
 #             of backward slashed:
   $curDir = $curDir -replace '\\', '/'

   $brackets = '>' * ($nestedPromptLevel + 1)

   return "PS: $($thisId+1) $curDir$brackets "
}

# { Set default colors for console
$host.ui.rawUI.backgroundColor = 'black'
$host.ui.rawUI.foregroundColor = 'white'
  # Change error colors etc. via
  #   $host.privateData.…
  # Get a list of possible values
  #   [enum]::GetValues([consoleColor])
clear-host
# }

# Equivalent of «dir /od» in cmd.exe
function dod {
   param (
      [validateScript( { test-path $_ } )]
      [string]                     $dir = '.'
   )

   get-childItem $dir | sort-object lastWriteTime
}

# Equivalent of «dir /s /b» in cmd.exe  ( http://stackoverflow.com/a/1479683/180275 )
function dsb($pattern) { get-childItem -filter $pattern  -recurse -force | select-object -expandProperty fullName }

# Show individual path-components of the PATH environment variable, each on its own line:
function paths() {
   foreach ($p in $env:PATH -split ';' ) {
      if (test-path $p) {
         write-host "  $p"
      }
      else {
         write-host "! $p"
      }
   }
}

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
function fb($wildcard) {
  get-childItem -errorAction silentlyContinue -recurse -filter $wildcard |
  select-object fullName
}

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
      $newPWD = $global:oldPWD;
  }

  if (! (test-path $newPWD)) {
     write-host -foreGroundColor red "directory $newPWD does not exist"
     return
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

$errorActionPreference = 'stop'
