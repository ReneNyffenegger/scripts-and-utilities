@echo off

setlocal enableDelayedExpansion

rem
rem By default, we want a new regedit to be opened
rem
set opt_m=/m

@if [%1] == [-m] (
rem
rem However, if -m is specified, the default of opening a new regedit window
rem is overwritten
rem
  set opt_m=
  shift
)

if [%1] == [] (
  echo Provide a registry key or env
  exit /b
)


@if [%1] == [env] (

    set RegistryKey=HKCU\Environment
    goto goOn

)
@if [%1] == [clsid] (

  if [%2] == [] (
    echo expected: GUID for clsid
    exit /b
  )
  set RegistryKey=HKCR\CLSID\%2
  goto goOn

)

:buildRegistryKey
rem
rem Entering a loop to build the registry key
rem from the command line arguments. This loop
rem is necessary because regat.bat might be called
rem with a registry key that contains spaces, such as
rem    regat HKCU\Control Panel\Mouse
rem In such a case, we cannot just assign %1 to !RegistryKey!
rem but must rather iterate over the indivdual
rem arguments and assemble the final registry key.
rem

   if not [%1] == [] (

      if not [!RegistryKey!] == [] (
        echo 1: !RegistryKey!
        set RegistryKey=!RegistryKey! %1
      ) else (
        set RegistryKey=%1
      )
      shift
      goto buildRegistryKey
   )

:goOn


rem
rem Replace HKCU with HKEY_CURRENT_USER etc:
rem
set RegistryKey=!RegistryKey:HKCU=HKEY_CURRENT_USER!
set RegistryKey=!RegistryKey:HKLM=HKEY_LOCAL_MACHINE!
set RegistryKey=!RegistryKey:HKCR=HKEY_CLASSES_ROOT!

if [opt_m] neq [/m] (

rem Kill regedit.exe process if already running.
rem If it's not running, it would write an error message. Redirect
rem the message to nul
    taskkill /f /im regedit.exe 1> nul 2> nul

)

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit /v LastKey /t REG_SZ /d "!RegistryKey!" /f > nul

start regedit %opt_m%

endlocal
