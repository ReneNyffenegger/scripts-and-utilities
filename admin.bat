@echo off
rem
rem Activate the administrator account @rem in a «privileged»; CMD.EXE
rem
rem      c:\> net user administrator MYSECRETPASSWORD /active:yes
rem

rem runas /profile /user:%HOSTNAME%\administrator   "cmd.exe /K cd %git_work_dir%\scripts && c.admin.bat"
rem runas /profile /user:%USERDOMAIN%\administrator "cmd.exe"
rem runas /profile /user:administrator "cmd.exe /k call %github_top_root%\lib\scripts\red.bat"
    runas /profile /user:administrator "cmd.exe /k color cf"
