@if "%1" == "" (
  @echo Provide a registry key or env
  @exit /b
)


@if %1 == env (
  @set RegistryKey="HKCU\Environment"
) else (
  @set RegistryKey=%*
)


@set RegistryKey=%RegistryKey:HKCU=HKEY_CURRENT_USER%
@set RegistryKey=%RegistryKey:HKLM=HKEY_LOCAL_MACHINE%
@set RegistryKey=%RegistryKey:HKCR=HKEY_CLASSES_ROOT%

@rem Kill regedit.exe process if already running.
@rem If it's not running, it would write an error message. Redirect
@rem the message to nul
@taskkill /f /im regedit.exe 2> nul

@reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit /v LastKey /t REG_SZ /d "%RegistryKey%" /f > nul

@start regedit
