@echo off

setlocal

if [%2] equ [] (
   echo dot2 ext dotfile
   exit /b
)

set extension=%1
set dotFile=%2
set dotFile_=%~n2%

if not exist %dotFile% (
  echo %dotFile% does not exist
  exit /b
)

dot -T%extension% -o%dotFile_%.%extension% %dotFile%

if %errorlevel% neq 0 (
  echo ErrorLevel: %errorlevel%
  exit /b
)

start %dotFile_%.%extension%
