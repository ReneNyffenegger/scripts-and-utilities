@echo off

rem
rem      Use enableDelayedExpansion so that
rem      assigning values to variables does
rem      not assign them to variables of the
rem      calling process.
rem
setlocal enableDelayedExpansion

if [%2] == [] (
  echo write-profile.bat SSID password
  exit /b
)

set SSID=%~1
set password=%~2

echo ^<?xml version="1.0"?^> >> wlan-profile.xml
echo ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^> >> wlan-profile.xml
echo   ^<name^>%SSID%^</name^> >> wlan-profile.xml
echo   ^<SSIDConfig^>^<SSID^>^<name^>%SSID%^</name^>^</SSID^>^</SSIDConfig^> >> wlan-profile.xml
echo   ^<connectionType^>ESS^</connectionType^> >> wlan-profile.xml
echo   ^<connectionMode^>auto^</connectionMode^> >> wlan-profile.xml
echo   ^<MSM^> >> wlan-profile.xml
echo     ^<security^> >> wlan-profile.xml
echo        ^<authEncryption^> >> wlan-profile.xml
echo          ^<authentication^>WPA2PSK^</authentication^> >> wlan-profile.xml
echo           ^<encryption^>AES^</encryption^> >> wlan-profile.xml
echo           ^<useOneX^>false^</useOneX^> >> wlan-profile.xml
echo        ^</authEncryption^> >> wlan-profile.xml
echo        ^<sharedKey^> >> wlan-profile.xml
echo           ^<keyType^>passPhrase^</keyType^> >> wlan-profile.xml
echo           ^<protected^>false^</protected^> >> wlan-profile.xml
echo           ^<keyMaterial^>%PASSWORD%^</keyMaterial^> >> wlan-profile.xml
echo        ^</sharedKey^> >> wlan-profile.xml
echo       ^</security^> >> wlan-profile.xml
echo   ^</MSM^> >> wlan-profile.xml
echo   ^<MacRandomization xmlns="http://www.microsoft.com/networking/WLAN/profile/v3"^> >> wlan-profile.xml
echo       ^<enableRandomization^>false^</enableRandomization^> >> wlan-profile.xml
echo   ^</MacRandomization^> >> wlan-profile.xml
echo ^</WLANProfile^> >> wlan-profile.xml

netsh wlan add profile filename="wlan-profile.xml"
netsh wlan connect name="%SSID%"

del wlan-profile.xml

endlocal
