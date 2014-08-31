@rem
@rem   Open ftp:// url in firefox with username and password.
@rem
@rem   Script assumes that the following three environment variables are set for the host, the login-user and the password, respetively:
@rem     tq84_XYZ_ftp_host
@rem     tq84_XYZ_ftp_user
@rem     tq84_XYZ_ftp_pw
@rem    
@rem   The script gets the value XYZ from the first passed parameter (%1):
@rem     c:\> ff_ftp XYZ
@rem

@for /f "usebackq" %%a in (`echo %%tq84_%1_ftp_user%%:%%tq84_%1_ftp_pw%%@%%tq84_%1_ftp_host%%`) do @set tq84_tmp=%%a
start "c:\Program Files\Mozilla Firefox\firefox.exe" ftp://%tq84_tmp%
