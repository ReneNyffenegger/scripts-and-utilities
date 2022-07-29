#  V0.21
#
#  Note to self: create file %userprofile%\psh.bat with following content:
#
#    @powershell -executionpolicy bypass -noExit -file c:\lib\Scripts\profile.ps1
#

set-strictMode -version 3

# V.21: use script variable for hostname:
$script:hostname = $(hostname)

#
#  Update «this» profile script from github
#
function update-profile { invoke-webRequest https://raw.githubusercontent.com/ReneNyffenegger/scripts-and-utilities/master/profile.ps1 -outFile $profile }

function prompt {

   #
   # V0.10: Use prompt to write lastExitCode in red if lastExitCode <> 0
   #
   if ( (test-path variable:lastExitCode) -and $global:lastExitCode) {
      $error = "$([char]0x1b)[91mlastExitCode = $global:lastExitCode$([char]0x1b)[0m`n"
      $global:lastExitCode = 0
   }
   else {
      $error = ''
   }

   # Get the built-in prompt function (before overriding it)
   # with
   #   (get-command prompt).ScriptBlock
   #
   # It is:
   #   "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) ";

   # @( … ) creates an array even if get-history returns 0 or 1 elements.
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

   if ((get-wmiObject win32_computersystem).model -eq 'VirtualBox') {
    #
    # V.20: Include computername (hostname) if running in a VirtualBox
    #
      $prompt = "$($thisId+1) $script:hostname $curDir$brackets "
   }
   else {
      $prompt = "PS: $($thisId+1) $curDir$brackets "
   }

  "$error$prompt"
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

function cdnot() {
   cd $env:notes_dir/notes
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


set-psReadLineOption -editMode  vi    # vi editing mode;
set-psReadLineOption -bellStyle none  # no more distracting beeps

Function global:TabExpansion2 {
#
#   V0.11: Modify function TabExpansion2 so that it does not
#          show *.swp files when tab-expanding files.
#
#   Most of the function was copied from
#         (get-command TabExpansion2).ScriptBlock
#
    [CmdletBinding(DefaultParameterSetName = 'ScriptInputSet')]
    Param(
        [Parameter(ParameterSetName = 'ScriptInputSet', Mandatory = $true, Position = 0)]
        [string] $inputScript,

        [Parameter(ParameterSetName = 'ScriptInputSet', Mandatory = $true, Position = 1)]
        [int] $cursorColumn,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 0)]
        [System.Management.Automation.Language.Ast] $ast,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 1)]
        [System.Management.Automation.Language.Token[]] $tokens,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 2)]
        [System.Management.Automation.Language.IScriptPosition] $positionOfCursor,

        [Parameter(ParameterSetName = 'ScriptInputSet', Position = 2)]
        [Parameter(ParameterSetName = 'AstInputSet', Position = 3)]
        [Hashtable] $options = $null
    )

    End
    {
       [System.Management.Automation.CommandCompletion] $cmdCompletion = $null
        if ($psCmdlet.ParameterSetName -eq 'ScriptInputSet')
        {
          #
          # Changed original source here: return -> $cmdCompletion =
          #
            $cmdCompletion = [System.Management.Automation.CommandCompletion]::CompleteInput(
                <#inputScript#>  $inputScript,
                <#cursorColumn#> $cursorColumn,
                <#options#>      $options)
        }
        else
        {
          #
          # Changed original source here: return -> $cmdCompletion =
          #
            $cmdCompletion = [System.Management.Automation.CommandCompletion]::CompleteInput(
                <#ast#>              $ast,
                <#tokens#>           $tokens,
                <#positionOfCursor#> $positionOfCursor,
                <#options#>          $options)
        }

       [System.Management.Automation.CompletionResult[]] $filtered = @( $cmdCompletion.CompletionMatches | where-object {
    #
    #     The type of $_ is System.Management.Automation.CompletionResult.
    #
    #     Only return file names that don't end in *.swp
    #
              $_.CompletionText -notMatch '\.swp$'
          } )

       [System.Collections.ObjectModel.Collection`1[System.Management.Automation.CompletionResult]] $res = $filtered

        $cmdCompletion= new-object System.Management.Automation.CommandCompletion $res, $cmdCompletion.currentmatchIndex, $cmdCompletion.replacementIndex, $cmdCompletion.replacementLength
        return $cmdCompletion
    }
}

$errorActionPreference = 'stop'

$psDefaultParameterValues['*:encoding'] = 'utf8'
