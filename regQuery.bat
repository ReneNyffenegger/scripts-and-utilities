@rem
@rem Usage:
@rem
@rem   regQuery  HKCU\Environment PATH
@rem   regQuery "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" TEMP
@rem

@set key=%1
@set val=%2

@if [%key%] equ [] goto usage
@if [%val%] equ [] goto usage

@rem
@rem Use skip=2 because reg query prints an empty line first.
@rem Use tokens=2,* because req query also prints value name and its data type which
@rem we don't want to be printed.
@rem

@for /f "skip=2 tokens=2,*" %%a in ('reg query %key% /v %val%') do @echo %%b

@exit /b 0

:usage
@echo.
@echo.   reqQuery registryKey ValueUnderThisKey
@echo.
