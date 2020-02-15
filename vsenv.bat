@echo off

rem
rem Uncomment setting VSCMD_DEBUG to enable debugging to output
rem
rem set VSCMD_DEBUG=3

rem
rem   Determine path to VsDevCmd.bat
rem
for /f "usebackq delims=#" %%a in (`"%programfiles(x86)%\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do set VsDevCmd_Path=%%a\Common7\Tools\VsDevCmd.bat
echo Path is %VsDevCmd_Path%


if [%1] equ [64] (

   echo -arch=amd64
  "%VsDevCmd_Path%" -arch=amd64

) else (

  echo Don't use -arch
  "%VsDevCmd_Path%"

)

rem set VSCMD_DEBUG=
set VsDevCmd_Path=
