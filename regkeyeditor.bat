@echo off
REM https://stackoverflow.com/questions/35458001/check-if-registry-key-value-exists-and-if-so-log-it?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
set regdarkmode="HKCU:\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme"
set mykey="HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"^
^ "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"^
^ "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"^
^ "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServices"^
^ "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunServices"^
^ "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"^
^ "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"^
^ "HKEY_LOCAL_MACHINE\SOFTWARE\Hackoo"

REM set LogFile=logkey.txt
REM if exist %LogFile% del %LogFile%
REM start "" %LogFile%
REM 2 for %%K in (%mykey%) do call :Check_Key %%K %LogFile%
exit /b

:Check_Key
reg query %1 >nul 
2>&1
(
if %errorlevel% equ 0 ( echo %1 ===^> Found && reg QUERY %1 ) else ( echo %1 ===^> Not found )
) >>%2 

2>&1


