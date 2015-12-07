set year=%1
set month=%2
set day=%3
set hour=%4
set minute=%5

set message=%hour%:%minute% - %*

set taskname=NotifyMeAt%year%%month%%day%%year%%hour%%minute%

@rem
@rem  TODO
@rem    The task removes itself after running once. Maybe, /Z could
@rem    be used to delete the task after running once.
@rem
@schtasks /create /SC once /ST %hour%:%minute%:00 /TN %taskname% /SD %day%/%month%/%year% /TR "cmd /c msg * %message% && schtasks /delete /tn %taskname% /f"
