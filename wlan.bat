@rem
@rem    connect or disconnect wlan
@rem

@if "%1" equ "" (
  goto Usage
)

@if "%1" equ "on" (

  @if "%2" equ "" (
    goto Usage
  )

  @netsh wlan connect "%2"

  @exit /b
)

@if "%1" equ "off" (
  @netsh wlan disconnect
  @exit /b
)

:Usage
@echo.
@echo   enter
@echo     wlan on   wlan-name
@echo   or
@echo     wlan off
@echo.
