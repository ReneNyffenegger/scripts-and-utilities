@rem
@rem   Script to start SQLcl with an "connection-ID"
@rem
@rem   c:\> sqlcl FOO
@rem
@rem   The script expects the following three variables to be set:
@rem     ora_FOO_name
@rem     ora_FOO_pw
@rem     ora_FOO_db
@rem
@rem   The script will then connect %ora_FOO_name%/%ora_FOO_pw%@%ora_FOO_db%
@rem

@setlocal EnableDelayedExpansion 

@set name=!ora_%1%_name!
@set pw=!ora_%1%_pw!
@set db=!ora_%1%_db!

@h:\sqlcl\bin\sql.bat %name%/%pw%@%db%
