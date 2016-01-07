@rem
@rem    Turn the internet proxy on or off,
@rem    or show current statua
@rem


@if "%1" equ "" (
  goto Usage
)

@if "%1" equ "on" (
  @reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
  @rem @netsh winhttp set proxy
  @exit /b
)

@if "%1" equ "off" (
  @reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
  @rem @netsh winhttp reset proxy
  @exit /b
)

@if "%1" equ "show" (
  @echo.
  @for /f "usebackq tokens=3" %%i in (`reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable`) do @(
    @if %%i equ 0x0  @echo proxy is off
    @if %%i equ 0x1  @echo proxy is on
  )
  @exit /b
)

:Usage
@echo.
@echo   enter
@echo     proxy on
@echo   or
@echo     proxy off
@echo   or
@echo     proxy show
@echo.
