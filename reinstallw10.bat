@echo off
setlocal enabledelayedexpansion enableextensions
set userid=%USERNAME%
set userhomedir=%USERPROFILE%
REM https://superuser.com/questions/131777/windows-7-command-line-variable-equivalent-to-0?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
set DIR0=%~f0
set userdowndir=%userhomedir%\Documents
set userdocdir=%userhomedir%\Documents
call :setvar
call :addexctodefender %userdocdir%
call :addexctodefender %userdowndir%
call :choosenow
exit /B %ERRORLEVEL%
REM forfiles /p "C:\what\ever" /s /m *.* /D -<number of days> /C "cmd /c del @path"
REM https://stackoverflow.com/questions/51054/batch-file-to-delete-files-older-than-n-days?rq=1

:setvar
set downloaddir=%userdocdir%\winreinstall\EXE
set w10actapp=""
set chromeinstallerlink="http://dl.google.com/chrome/install/375.126/chrome_installer.exe"
REM set chromeinstallerlink="https://www.google.com/chrome/thankyou.html?statcb=1^&installdataindex=defaultbrowser"
REM set chromeinstallerlink="https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BF75ED97E-B0F0-69D9-FD6B-D8AD00C9017C%7D%26lang%3Did%26browser%3D4%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Ddefaultbrowser/update2/installers/Chromesetup.exe"
set chromeexe=ChromeSetup.exe
set nppinstallerlink="https://notepad-plus-plus.org/repository/7.x/7.5.6/npp.7.5.6.Installer.x64.exe"
set nppfile=npp.exe
set wxhexeditorinstallerlink="https://sourceforge.net/projects/wxhexeditor/files/latest/download"
set wxhexfile="wxhexeditor.zip"

set githubdlink=""
set atomlink=""
set "nvidiadinstallerlink=http://us.download.nvidia.com/Windows/398.11/398.11-desktop-win10-64bit-international-whql.exe"
set nvidiadexe=nvidia397driver.exe
set teknopinstallerlink="https://teknoparrot.com/download"
set teknopzip=TeknoParrot.zip
set ucrinstallerlink="http://evilc.com/files/ahk/ucr/UCR.zip"
set ucrzip=UCR.zip
set adbtoolsapp=https://dl.google.com/android/repository/platform-tools-latest-windows.zip
set adbtoolzip=platform-tools-latest-windows.zip
set ahkinstallerlink="https://autohotkey.com/download/ahk-install.exe"
set ahkexe=ahk-install.exe
set gnirehtetapp=""
set eglinstallerlink=""
set vlcpinstallerlink=""
set vjoyinstallerlink=""
set winpythoninstallerlink="https://sourceforge.net/settings/mirror_choices?projectname=winpython&filename=WinPython_3.6/3.6.5.0/WinPython64-3.6.5.0Qt5.exe&selected=jaist"
set winpythonexe=winpython.exe
set matlabinstallerlink=""
set matlabexe=matlab.zip
REM regkey
set windefexcdir=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths
set regdarkmodedir=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize
set regdarkmodekey=AppsUseLightTheme

set psldir=%SystemRoot%
set pslexe=powershell.exe
set cmddir=%SystemRoot%
set cmdexe=cmd.exe
set ucrdir=%userdocdir%\UCR
set ucrexe=UCR.exe
set egldir=C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win32
set eglexe=EpicGamesLauncher.exe
set tp151dir=%userdocdir%\TeknoParrot_1.51_Hotfix23
set tpdir=%tp151dir%
set tpexe=TeknoParrotUi.exe
set blexe=BudgieLoader.exe
set plexe=ParrotLoader.exe
set cpbldir=%exe2dir%\%blexe%
set cppldir=%exe2dir%\%plexe%
set tpbldir=%tpdir%\%blexe%
set tppldir=%tpdir%\%plexe%
set exe2dir=%userdocdir%\winreinstall\EXE2
goto:EOF
:testdelimit
REM https://stackoverflow.com/questions/27443383/how-to-get-first-part-of-a-delimited-string-in-batch
for /f "tokens=1 delims=." %%a in ("%var%") do set "new_var=%%a"
set var=something.contains.text
set new_var=%var:.=&rem %

set "str=Te$ting thi$ $cript for $zero"
set "result=%str:$=" & set "result=%"
echo %result%

set windefexcdir=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths
set "str=%windefexcdir%"
set "result=%str:\=" & 
set "result=%"
echo %result%

goto:EOF

:testlinkd
call :getstrlastdlink "%nvidiadinstallerlink%" "/"
echo %result%
goto:EOF
:getstrlastdlink
REM set windefexcdir=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths
REM set "str=%windefexcdir%"
set "str=%1"
set "del=%2"

set "result=%str:/=" & set "result=%"
echo %result%
goto:EOF
:testingregkey
set windefexcdir=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths
set regdarkmodedir=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize
set regdarkmodekey=AppsUseLightTheme
set KEY_NAME=%windefexcdir%
set KEY_NAME=%regdarkmodedir%
set VALUE_NAME=C:\Users\user\Downloads
set dir=%VALUE_NAME%
set keytype=REG_DWORD
set valto=0x0
set dmname=dm
set bladir=%KEY_NAME%\%VALUE_NAME%
reg add "%KEY_NAME%" /v "%VALUE_NAME%" /t %keytype% /d %valto% /f
reg delete "%KEY_NAME%" /v "%VALUE_NAME%" /f
powershell.exe -Command "Add-MpPreference -ExclusionPath '%dir%'"
powershell.exe -Command "Remove-MpPreference -ExclusionPath '%dir%'"
powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath $ENV:USERPROFILE\Downloads
goto:EOF
:elevatecmd
powershell.exe -Command "Start-Process cmd \"/k cd /d %cd%\" -Verb RunAs"
goto:EOF
:checkapprunningnrun
REM https://stackoverflow.com/questions/162291/how-to-check-if-a-process-is-running-via-a-batch-script
set appdir=%1
set app=%2
tasklist /FI "IMAGENAME eq %app%" 2>NUL | find /I /N "%app%">NUL
if %ERRORLEVEL% equ 0 (
echo Program is running
) else ( 
cd /d "%appdir%"
start "" "%app%"
)
goto:EOF
:opencmd
call :checkapprunningnrun %cmddir% %cmdexe% 
goto:EOF
:openpsl
call :checkapprunningnrun %psldir% %pslexe% 
goto:EOF
:opendirinexp
set dir=%1
%SystemRoot%\explorer.exe "%dir%"
goto:EOF
:traprestart
REM https://stackoverflow.com/questions/3827567/how-to-get-the-path-of-the-batch-script-in-windows
set mypath=%~dp0
set PATH0=%mypath:~0,-1%
echo %PATH0%
start "" %DIR0%
goto:EOF
::TOOLS
:wsleditrw10
set rw10scriptdir="/mnt/c/Users/user/Documents/winreinstall/script/reinstallw10.bat"
wsl export DISPLAY=:0 ; nohup gedit %rw10scriptdir% & disown $!
REM ubuntu -c export DISPLAY=:0 ; nohup gedit %rw10scriptdir% & disown $!
goto:EOF
:sleep
REM https://stackoverflow.com/questions/1672338/how-to-sleep-for-5-seconds-in-windowss-command-prompt-or-dos?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
echo sleep %1
set /a sleeptime=%1+1
ping 127.0.0.1 -n %sleeptime% > nul
goto:EOF
:download
set url=%1
set output=%2
REM https://stackoverflow.com/questions/4619088/windows-batch-file-file-download-from-a-url?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
REM https://blog.netspi.com/15-ways-to-download-a-file/
REM powershell set-ExecutionPolicy Unrestricted
REM set output="%userhomedir%\%filename%"
REM bitsadmin /transfer wcb /priority high %url% %output%
REM ftp %url% user password
REM 1powershell -Command "Invoke-WebRequest %url% -OutFile %output%"
REM 2powershell -c "Start-BitsTransfer -Source %url% -Destination %output%"
REM 3powershell -c "(New-Object Net.WebClient).DownloadFile('%url%','%output%')"
REM powershell -ExecutionPolicy RemoteSigned -File "download.ps1" "%url%" "%output%"
certutil.exe -urlcache -split -f "%url%" "%output%"
REM bitsadmin.exe /transfer "Downloading" %url% "%output%"
goto:EOF
:addexctofirewall
REM https://community.spiceworks.com/scripts/show/1336-add-exception-in-firewall
netsh firewall add allowedprogram "%1%" >nul
goto:EOF

:addexctodefender
set dir=%1
REM https://blogs.technet.microsoft.com/heyscriptingguy/2016/02/14/powertip-add-exclusion-folder-to-windows-defender-using-powershell/
powershell.exe -Command "Add-MpPreference -ExclusionPath '%dir%'"
REM powershell.exe -Command "Remove-MpPreference -ExclusionPath '%dir%'"
goto:EOF
:addexctodefender2
set dir=%1
set keytype=REG_SZ
set keyval=0x0
call :checkthiskey %windefexcdir% %dir% %keytype% %keyval% dirdef
echo %dir% added
call :sleep 600
goto:EOF
:testelif
REM https://stackoverflow.com/questions/11081735/how-to-use-if-else-structure-in-a-batch-file
set test1result=2
IF %test1result%==1 (
   echo Example 2 fails
) ELSE IF %test1result%==2 (
   echo Example 2 works correctly
) ELSE (
    echo Example 2 fails
)
goto:EOF
:invokewsl
REM https://blogs.msdn.microsoft.com/commandline/2017/11/28/a-guide-to-invoking-wsl/
REM ubuntu -c [command]
REM bash -c [command]
REM wsl [command] (NOTE: In this case you don't append '-c', you just type in your command)
goto:EOF
:staticinetcompno
set /p compno="Enter Compno: "
call :setinternet "%compno%"
goto:EOF
:setinternet
REM https://stackoverflow.com/questions/12535419/setting-a-global-powershell-variable-from-a-function-where-the-global-variable-n?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
REM runas /user:Administrator
REM ipconfig /all
cd \ && cd windows\system32
netsh interface ip set address name="Ethernet 5" static 192.168.1.%1 255.255.255.0 192.168.1.254
netsh interface ip set dns name="Ethernet 5" static 192.168.1.83
netsh interface ip add dns name="Ethernet 5" 8.8.8.8 index=2
goto:EOF

::REINSTALL
:reinstallw10SP3
call :updateregkey
call :downloadallapps
wsl
ubuntu -c "sudo apt-get update"
goto:EOF

:reinstallw10g
REM https://answers.microsoft.com/en-us/windows/forum/windows_10-update-winpc/you-cant-install-windows-on-a-usb-flash-drive/003a982e-aa32-49ad-8bf5-e7e83d488c63
REM call :updateregkey "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlset\Control" "1"
goto:EOF
::download
:downloadallapps
echo %chromeinstallerlink%
echo "!nvidiadinstallerlink!"
call :download "!nvidiadinstallerlink!" "%downloaddir%\%nvidiadexe%"
call :sleep 600
call :download "!chromeinstallerlink!" "%downloaddir%\%chromeexe%"
call :download "%nppinstallerlink%" "%downloaddir%\%nppfile%"
call :download "%wxhexeditorinstallerlink%" "%downloaddir%\%wxhexfile%"
call :download "!nvidiadinstallerlink!" "%downloaddir%\%nvidiadexe%"
call :sleep 600
call :download "%adbtoolsapp%" "%downloaddir%\%adbtoolzip%"
call :download "%teknopinstallerlink%" "%downloaddir%\%teknopzip%"
call :download "%ucrinstallerlink%" "%downloaddir%\%ucrzip%"
call :download "%ahkinstallerlink%" "%downloaddir%\%ahkexe%"
call :download "%winpythoninstallerlink%" "%downloaddir%\%winpythonexe%"
call :download "%matlabinstallerlink%" "%downloaddir%\%matlabexe%"
call :download "!nvidiadinstallerlink!" "%downloaddir%\%nvidiadexe%"
goto:EOF
REM https://www.digitalcitizen.life/six-ways-removeuninstall-windows-programs-and-apps
:setdefaultapps
REM https://superuser.com/questions/362063/how-to-associate-a-file-with-a-program-in-windows-via-cmd
REM assoc | more
onassoc .mkv=MPC-BE.AssocFile.MKV
ftype MPC-BE.AssocFile.MKV=c:\Program Files\MPC-BE x64\mpc-be64.exe "%1"pause
ftype TIFImage.Document="C:\Program Files\MSPVIEW.exe" "%1"
goto:EOF
:listallinstalledapps
wmic product get name
:uninstallapps
REM msiexec /x
REM ReturnValue=0 and a message saying “Method execution successful.”
echo y | wmic product where name="%1" call uninstall.

:uninstallgamepreinstalled
REM "Bubble Witch 3 Saga"
REM "Candy Crush Soda Saga"
Get-AppxPackage *CandyCrush* | Remove-AppxPackage
REM "Disney Magic Kingdoms"
REM "March of Emipres:War of Lords"

::installallapps
:installchrome
REM https://superuser.com/questions/337210/how-can-i-silently-install-google-chrome?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
REM https://www.youtube.com/watch?v=gl4R1CaSpDU
cd /d .
.\chrome_installer.exe /silent /install
msiexec /i .msi /quiet /passive
:installnpp
REM 64-bit
REM npp.7.5.5.Installer.x64
REM 32-bit
REM "%~dp0npp.7.5.5.Installer.exe" /S
if defined ProgramFiles(x86) "%~dp0.npp.exe" /S
if defined ProgramFiles(x86) exit
:installnvidiadriver
REM https://lazyadmin.nl/it/deploy-nvidia-drivers/
setup.exe -noreboot -clean -noeula -nofinish -passive
:installteknoparrot
:installvjoy
goto:EOF


::regedit
REM http://www.thewindowsclub.com/fix-cant-install-windows-usb-flash-drive-setup-upgrading-windows-8-1.

:checkthiskey
set KEY_NAME=%1
set VALUE_NAME=%2
set keytype=%3
set valto=%4
set keyname=%5
FOR /F "usebackq skip=2 tokens=1-3" %%A IN (`REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul`) DO (
    set ValueName=%%A
    set ValueType=%%B
    set ValueValue=%%C
)
REM if defined ValueName (
REM    @echo Value Name = %ValueName%
REM    @echo Value Type = %ValueType%
REM    @echo Value Value = %ValueValue%
REM ) else (
REM    @echo %KEY_NAME%\%VALUE_NAME% not found.
REM )
if defined ValueName (
if defined valto (
if %ValueValue% == %valto% (
echo alrsame
) else (
echo changevalto %valto%
reg add %KEY_NAME% /v %VALUE_NAME% /t %keytype% /d %valto% /f
)
)
) else (
@echo %KEY_NAME%\%VALUE_NAME% not found; creating one
reg add %KEY_NAME% /v %VALUE_NAME% /t %keytype% /d %valto% /f
)
goto:EOF


:newregkey
REM https://www.lifewire.com/how-to-create-edit-and-use-reg-files-2622817
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdhid\Parameters]
"CrashOnCtrlScroll"=dword:00000001

:testbogus
set regdarkmodekey=BOGUS
set keytype=REG_SZ
set valto=0x1
set dmname=bogus
call :checkthiskey %regdarkmodedir% %regdarkmodekey% %keytype% %valto% %dmname%
goto:choosenow
:enabledarkmode
set keytype=REG_SZ
set valto=0x1
set dmname=dm
reg query %regdarkmodedir% /v %regdarkmodekey%
if %ERRORLEVEL% equ 0 (
call :checkthiskey %regdarkmodedir% %regdarkmodekey% %keytype% %valto% %dmname% 
) else (
call :checkthiskey %regdarkmodedir% %regdarkmodekey% %keytype% %valto% %dmname% 
)
call :sleep 600
goto:choosenow

:pslenabledm
powershell New-ItemProperty "%regdarkmode%" -Name "AppsUseLightTheme" -PropertyType "DWord" -Value 0 -Force
:enabledevelopermode
REM https://blogs.technet.microsoft.com/heyscriptingguy/2015/04/02/update-or-add-registry-key-value-with-powershell/
# Create AppModelUnlock if it doesn't exist, required for enabling Developer Mode
$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
if (-not(Test-Path -Path $RegistryKeyPath)) {
    New-Item -Path $RegistryKeyPath -ItemType Directory -Force
}
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name $name -Value $value `-PropertyType DWORD -Force
powershell New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -PropertyType DWORD -Value 1 -Force
goto:EOF

:enablewsl
:downloadubuntu
:runupdatebashc
ubuntu -c "sudo apt-get update"
:disablehyperv
:disableportable
::login
:logintounimelb
:logintogmail
:logintoreddit
:logintodiscord
:logintoyoutube


::RUNWMMT5


:extractzip
.\7zip.exe %zipdir%
goto:EOF
:runwmmt5
REM correctbudgiloader
REM if not exist %tpbldir% ( cp exe2dir )
REM if not exist %tppldir% ()
call :addexctodefender2 %userdocdir%
call :addexctodefender2 %exe2dir%
call :addexctodefender2 %tpbldir%
call :addexctodefender2 %tppldir%
call :checkapprunningnrun %ucrdir% %ucrexe%
call :checkapprunningnrun %tpdir% %tpexe% 
goto:choosenow
::RUNFORTNITE
:runeglPC
call :checkapprunningnrun %egldir% %eglexe%
goto:choosenow
:listallfn
REM https://stackoverflow.com/questions/9789563/how-to-write-a-search-pattern-to-include-a-space-in-findstr/42534211?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
REM cd /d %userhomedir%\Downloads\winreinstall\script\
REM exceptionhandler https://stackoverflow.com/questions/31445330/does-windows-batch-support-exception-handling
REM https://www.windows-commandline.com/findstr-command-examples-regular/
echo %1
set /a countfn=1
for /f "tokens=* delims=" %%x in ('findstr /r /i ^
/c:"^:downloadallapps" ^
/c:"^:reinstallw10" ^
/c:"^:staticinetcompno" ^
/c:"^:testecho" ^
/c:"^:run" ^
/c:"^:checkthiskey" ^
/c:"^:enabledarkmode" ^
/c:"^:testelif" ^
/c:"^:testbogus" ^
/c:"^:openpsl" ^
/c:"^:opendirinexp" ^
/c:"^:testlinkd" ^
/c:"^:traprestart" %1') do (
set allfn[!countfn!]=%%x
REM echo !countfn!%%x
call echo !countfn!%%allfn[!countfn!]%%
set /a countfn+=1
)
goto:EOF
:choosefn
REM call echo 1%allfn[1]%
set /p fnno="choosefn: "
call echo =====start%%allfn[!fnno!]%%=====
REM https://stackoverflow.com/questions/17584282/how-to-check-if-a-parameter-or-variable-is-numeric-in-windows-batch-file?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
SET "var="&for /f "delims=0123456789" %%i in ("%fnno%") do set "var=%%i"
if defined var (call :%fnno%) else (call %%allfn[!fnno!]%%)
REM call %%allfn[!fnno!]%%
goto:choosenow
:choosenow
call :listallfn %DIR0%
call :choosefn %DIR0%
EXIT /B %ERRORLEVEL%

:testecho
echo "Hello World!"
test&cls
goto:choosenow


REM IF "%~1" == "" GOTO MyLabel
:installnppwine
sudo apt-get install -y wine
winecfg
wine ~/Downloads/npp.7.3.3.Installer.exe
wine "C:\\Program Files\\Notepad++\\notepad++.exe"
#wine uninstall
goto:choosenow
:setinternetlong
$global:var1 = $null
set REM="@echo off

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%ERRORLEVEL%' NEQ '0' (
    echo Requesting Admin access...
    goto goUAC )
    else goto goADMIN

:goUAC
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:goADMIN
    pushd "%CD%"
    CD /D "%~dp0"
	
rem --- FROM HERE PASTE YOUR ADMIN-ENABLED BATCH SCRIPT ---
echo Stopping some Microsoft Service...
rem --- END OF BATCH ----"
goto:choosenow
