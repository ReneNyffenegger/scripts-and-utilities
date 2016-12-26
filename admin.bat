@rem
@rem in a «privileged∷; CMD.EXE
@rem
@rem Activate the adminstrator account with
@rem      c:\> net user administrator /active:yes
@rem
@rem Change the administrator's password with
@rem      c:\> net user administrator MYSECRETPASSWORD
@rem

@runas /profile /user:%HOSTNAME%\administrator "cmd.exe /K cd %git_work_dir%\scripts && c.admin.bat"
