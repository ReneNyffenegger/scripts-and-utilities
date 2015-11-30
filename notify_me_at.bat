set year=%1
set month=%2
set day=%3
set hour=%4
set minute=%5

set message=%hour%:%minute% - %*

set taskname=NotifyMeAt%year%%month%%day%%year%%hour%%minute%

@schtasks /create /SC once /ST %hour%:%minute%:%day% /TN %taskname% /SD 30/11/2015 /TR "cmd /c msg * %message% && schtasks /delete /tn %taskname% /f"
