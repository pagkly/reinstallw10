REM https://stackoverflow.com/questions/7044985/how-can-i-auto-elevate-my-batch-file-so-that-it-requests-from-uac-administrator
REM selfelevated
@echo off
setlocal enabledelayedexpansion enableextensions
cd \ && cd windows\system32
set userid=%USERNAME%
set userhomedir=%USERPROFILE%
REM https://superuser.com/questions/131777/windows-7-command-line-variable-equivalent-to-0?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
set DIR0=%~f0
set userdowndir=%userhomedir%\Downloads
set userdocdir=%userhomedir%\Documents

 CLS
 ECHO.
 ECHO =============================
 ECHO Running Admin shell
 ECHO =============================

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~0"
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO.
  ECHO **************************************
  ECHO Invoking UAC for Privilege Escalation
  ECHO **************************************

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"

  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

call :setvar
REM call :selfelevateasadmin
call :addexctodefender %userdocdir%
call :addexctodefender %userdowndir%
call :startworking
call :choosenow
exit /B %ERRORLEVEL%
REM forfiles /p "C:\what\ever" /s /m *.* /D -<number of days> /C "cmd /c del @path"
REM https://stackoverflow.com/questions/51054/batch-file-to-delete-files-older-than-n-days?rq=1

:setvar2
REM if exist
REM if not download
REM install
set cpbldir=%exe2dir%\%blexe%
set cppldir=%exe2dir%\%plexe%
set tpbldir=%tpdir%\%blexe%
set tppldir=%tpdir%\%plexe%
set exe2dir=%userdocdir%\winreinstall\EXE2
REM psl;;%SystemRoot%;;powershell.exe
REM cmd;;;;%SystemRoot%;;cmd.exe
REM ucr;;;;%userdocdir%\UCR;;UCR.exe
REM tpdir;;;%tp151dir%
REM tp151;;;;%userdocdir%\TeknoParrot_1.51_Hotfix23;;TeknoParrotUi.exe
REM tpblexe;;%exe2dir%;;BudgieLoader.exe
REM tpplexe;;%exe2dir%;;ParrotLoader.exe
REM egl;;;;C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win32;;EpicGamesLauncher.exe
REM chrome;;"http://dl.google.com/chrome/install/375.126/chrome_installer.exe";;ChromeSetup.exe
REM npp;;https://notepad-plus-plus.org/repository/7.x/7.5.6/npp.7.5.6.Installer.x64.exe";;npp.exe
REM wxhexeditor;;"https://sourceforge.net/projects/wxhexeditor/files/latest/download";;wxhexeditor.zip

REM rw10;;"/mnt/c/Users/user/Documents/GitHub/reinstallw10/reinstallw10.bat"
REM mb1ms;;"/mnt/d/notes/Documentsv2/1mstart2"
REM mb3gs;;"/mnt/d/notes/3gsnit"
REM "mbios1ms;;D:\notes\Documentsv2\1mstart2"
REM  "mbios3gs;;D:\notes\3gsnit"
set xdisplay=0
REM D:\
set downloaddir=%userdocdir%\winreinstall\EXE
goto:EOF
:setvar
set "downloaddir=%userdocdir%\winreinstall\EXE"
set w10actapp=""
set chromeinstallerlink="http://dl.google.com/chrome/install/375.126/chrome_installer.exe"
REM set chromeinstallerlink="https://www.google.com/chrome/thankyou.html?statcb=1^&installdataindex=defaultbrowser"
REM set chromeinstallerlink="https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BF75ED97E-B0F0-69D9-FD6B-D8AD00C9017C%7D%26lang%3Did%26browser%3D4%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Ddefaultbrowser/update2/installers/Chromesetup.exe"
set chromeexe=ChromeSetup.exe
set nppinstallerlink="https://notepad-plus-plus.org/repository/7.x/7.5.6/npp.7.5.6.Installer.x64.exe"
set nppfile=npp.exe
set wxhexeditorinstallerlink="https://sourceforge.net/projects/wxhexeditor/files/latest/download"
set "wxhexfile=wxhexeditor.zip"

set githubdlink=""
set atomlink=""
set "nvidiadinstallerlink=http://us.download.nvidia.com/Windows/398.11/398.11-desktop-win10-64bit-international-whql.exe"
set nvidiadexe=nvidia397driver.exe
set "teknopinstallerlink=https://teknoparrot.com/download"
set teknopzip=TeknoParrot.zip
set "ucrinstallerlink=http://evilc.com/files/ahk/ucr/UCR.zip"
set ucrzip=UCR.zip
set adbtoolsapp=https://dl.google.com/android/repository/platform-tools-latest-windows.zip
set adbtoolzip=platform-tools-latest-windows.zip
set "ahkinstallerlink=https://autohotkey.com/download/ahk-install.exe"
set ahkexe=ahk-install.exe
set gnirehtetapp=""
set eglinstallerlink=""
set vlcpinstallerlink=""
set vjoyinstallerlink=""
set "winpythoninstallerlink=https://sourceforge.net/settings/mirror_choices?projectname=winpython&filename=WinPython_3.6/3.6.5.0/WinPython64-3.6.5.0Qt5.exe&selected=jaist"
set "winpythonexe=winpython.exe"
set "matlabinstallerlink="
set matlabexe=matlab.zip
REM regkey
set "regwindefexcdir=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths"
set "regdarkmodedir=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
set regdarkmodekey=AppsUseLightTheme
set regdevmodedir=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock
set regdevmodekey=AllowDevelopmentWithoutDevLicense
set "regimfeodir=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"
set "npadexe=notepad.exe"
set "nppdir=C:\Program^ Files\Notepad++"
set "nppexe=notepad++.exe"
set "xmingdir=C:\Program Files (x86)\Xming"
set "xmingdir2=C:\Program Files\VcXsrv"
set xmingexe=XLaunch.exe
set xmingexe2=xlaunch.exe
REM set xmingexe=Xming.exe

set psldir=%SystemRoot%
set pslexe=powershell.exe
set cmddir=%SystemRoot%
set cmdexe=cmd.exe
set ucrdir=%userdocdir%\UCR
set ucrexe=UCR.exe
set "egldir=C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win32"
set "eglexe=EpicGamesLauncher.exe"
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
REM set rw10scriptdir="/mnt/c/Users/user/Documents/winreinstall/script/reinstallw10.bat"
set rw10scriptdir="/mnt/c/Users/user/Documents/GitHub/reinstallw10/reinstallw10.bat"
set mb1ms="/mnt/d/notes/Documentsv2/1mstart2"
set mb3gs="/mnt/d/notes/3gsnit"
set "mbios1ms=D:\notes\Documentsv2\1mstart2"
set "mbios3gs=D:\notes\3gsnit"
set xdisplay=0
goto:EOF
:sleep
REM https://stackoverflow.com/questions/1672338/how-to-sleep-for-5-seconds-in-windowss-command-prompt-or-dos?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
echo sleep %1
set /a sleeptime=%1+1
ping 127.0.0.1 -n %sleeptime% > nul
goto:EOF
:selfelevateasadmin
runas /user:administrator /savecred "%DIR0%"
goto:EOF
:elevatecmd
powershell.exe -Command "Start-Process cmd \"/k cd /d %cd%\" -Verb RunAs"
goto:EOF
:endParams
goto:EOF
:regcheckosver
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT echo This is a 32bit operating system
if %OS%==64BIT echo This is a 64bit operating system
goto:EOF
:deletestrafter
REM https://stackoverflow.com/questions/24735624/removing-everything-after-specific-character-in-batch
set FULLNAME=%1
REM set ENDTEXT=!FULLNAME:*E0=!
set ENDTEXT=%2
call set TRIMMEDNAME=%%FULLNAME:!ENDTEXT!=%%
echo !TRIMMEDNAME!
goto:EOF
:getstrlastdlink
REM https://stackoverflow.com/questions/20004597/extracting-string-after-last-instance-of-delimiter-in-a-batch-file
REM https://stackoverflow.com/questions/47796707/how-to-extract-text-after-in-batch-file
REM set regwindefexcdir=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths
REM set "str=%regwindefexcdir%"
set "str=%~1"
if not defined str goto endParams
for %%a in (%str:/= %) do set result=%%a
REM echo result:%result%
shift
goto:getstrlastdlink
:getstrlastdlink2
set "str=%1"
set "del=%2"
set "result=%str:/=" & set "result=%"
echo result:%result%
goto:EOF

:installskype
https://go.skype.com/classic.skype
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
:seeregedit
regedit "%regwindefexcdir%"
goto:EOF
:addexctofirewall
REM https://community.spiceworks.com/scripts/show/1336-add-exception-in-firewall
netsh firewall add allowedprogram "%1%" >nul
goto:EOF
:addexctodefender
REM https://blogs.technet.microsoft.com/heyscriptingguy/2016/02/14/powertip-add-exclusion-folder-to-windows-defender-using-powershell/
set KEY_NAME=
set VALUE_NAME=
set ValueName=
set ValueType=
set ValueValue=
set dir=%1
set "KEY_NAME=%regwindefexcdir%"
set "VALUE_NAME=%dir%"
REG QUERY "%KEY_NAME%" /v "%VALUE_NAME%"
FOR /F "usebackq skip=2 tokens=1-3" %%A IN (`REG QUERY "%KEY_NAME%" /v "%VALUE_NAME%" 2^>nul`) DO (
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
echo %dir% excluded in windef
) else (
@echo %KEY_NAME%\%VALUE_NAME% not found
REM powershell.exe -Command "Add-MpPreference -ExclusionPath '%dir%'"
Powershell.exe -Command "& {Start-Process Powershell.exe -ArgumentList 'Add-MpPreference -ExclusionPath "%dir%"' -Verb RunAs}"
echo %dir% added
)
REM powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath $ENV:USERPROFILE\Downloads
goto:EOF
:addexctodefender2
set dir=%1
set keytype=REG_SZ
set keyval=0x0
call :updatethisregkey %regwindefexcdir% %dir% %keytype% %keyval% dirdef
echo %dir% added
call :sleep 600
goto:EOF


:checkapprunningnrun
REM https://stackoverflow.com/questions/162291/how-to-check-if-a-process-is-running-via-a-batch-script
set "appdir="%1""
set "app=%2"
echo %appdir%
REM call :sleep 500
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
:extractzip
.\7zip.exe %zipdir%
goto:EOF

:updatethisregkey
set KEY_NAME=
set VALUE_NAME=
set keytype=
set "valto="
set "keyname="
set ValueName=
set ValueType=
set ValueValue=

set KEY_NAME=%1
set VALUE_NAME=%2
set keytype=%3
set "valto=%4"
set keyname=%5
echo %KEY_NAME%
FOR /F "usebackq skip=2 tokens=1-3" %%A IN (`REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul`) DO (
set ValueName=%%A
set ValueType=%%B
set ValueValue=%%C
)
REG QUERY %KEY_NAME% /v %VALUE_NAME%
if defined ValueName (
@echo Value Name = %ValueName%
@echo Value Type = %ValueType%
@echo Value Value = %ValueValue%
) else (
@echo %KEY_NAME%\%VALUE_NAME% not found.
)

if defined ValueName (
echo %KEY_NAME%\%VALUE_NAME% exists
REM call :sleep 600
if defined valto (
echo curvalue:%ValueValue%
if %ValueValue% == %valto% (
echo alrsame
) else (
echo notsamesochangevalto:%valto%
REM call :removethisregkey %KEY_NAME% %VALUE_NAME%
reg add %KEY_NAME% /v %VALUE_NAME% /t %keytype% /d %valto% /f
)
)

) else (
REM echo %KEY_NAME%\%VALUE_NAME% not found; creating one
reg add %KEY_NAME% /v %VALUE_NAME% /t %keytype% /d %valto% /f
)
goto:EOF
:removethisregkey
set KEY_NAME=%1
set VALUE_NAME=%2
reg delete %KEY_NAME% /v %VALUE_NAME% /f
goto:EOF


::REINSTALL
:setdownvar
REM https://superuser.com/questions/191224/populating-array-in-dos-batch-script
REM https://www.youtube.com/watch?v=ux9vb18eoAE
FOR %f IN (*.txt) DO ECHO %f
goto:EOF
:installoffice16
goto:EOF
:downloadmicrosofttk
REM https://www.reddit.com/r/MSToolkit/comments/8hf4tc/microsoft_toolkit_v264_download/
REM MEGA: https://mega.nz/#F!Ir5S1bSD!y7zqy6BdG14J_Kq8mLmzKA
REM Google Drive: https://drive.google.com/drive/folders/1ky-AX_B1CqB8zHC3l4ldpPjDLIoCDccx
REM OneDrive: https://1drv.ms/f/s!Agk9fHaAotuehTB1oQaGkq_kb1Rk
REM Box: https://app.box.com/s/xdzsk9lm1uyrzikvrzabs5xk5hijd8x7
REM Dropbox: https://www.dropbox.com/sh/5o2zaw63f2jhbn2/AAC2Cv1nnTZbNDy50YqOF6ria?dl=0
utorrent.exe magnet:?xt=urn:btih:1FB324E0158C8D23FF42922C92731CE1A8D08BF0
:installmicrosofttk
start "" "MTK.exe"
:downloadfiinotewine
:installfiinotewine
:disablehibernate
powercfg -hibernate off
goto:EOF
:rw10common
call :disablehibernate
call :enabledevmode
call :enabledarkmode
call :disablehyperv
call :disablecortana
call :wincleanup
call :exclusionwindef
call :disablefirewall

call :downloadallapps
call :installchrome
call :installnpp
call :installwxhexeditor
call :installoffice16
call :installpython
call :installubuntuwsl
call :updatewsl

wsl
wsl "sudo apt-get update"
wsl "sudo apt-get install -y gedit"
:reinstallw10SP3
call :rw10common
call :downloadallapps
call :installallapps
goto:EOF
:reinstallw10g
REM https://answers.microsoft.com/en-us/windows/forum/windows_10-update-winpc/you-cant-install-windows-on-a-usb-flash-drive/003a982e-aa32-49ad-8bf5-e7e83d488c63
REM call :updateregkey "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlset\Control" "1"
call :rw10common
call :enableportablemode
call :installwslgedit
call :installmatlab
call :installdockerce
call :installahk
call :installandroidstudio
call :installatom
call :installgithubdesktop

REM games
call :installnvidiadriver
call :installfortnite
call :installteknoparrot
call :installucr
call :installtgb
call :uninstallbloatgame
goto:EOF
::download
:downloadallappscommon
call :download "!chromeinstallerlink!" "%downloaddir%\%chromeexe%"
call :download "%nppinstallerlink%" "%downloaddir%\%nppfile%"
call :download "%wxhexeditorinstallerlink%" "%downloaddir%\%wxhexfile%"
call :download "%adbtoolsapp%" "%downloaddir%\%adbtoolzip%"
:downloadallapps
echo %chromeinstallerlink%
echo "!nvidiadinstallerlink!"
call :download "!nvidiadinstallerlink!" "%downloaddir%\%nvidiadexe%"
call :sleep 600
call :download "!nvidiadinstallerlink!" "%downloaddir%\%nvidiadexe%"
call :sleep 600
call :download "%teknopinstallerlink%" "%downloaddir%\%teknopzip%"
call :download "%ucrinstallerlink%" "%downloaddir%\%ucrzip%"
call :download "%ahkinstallerlink%" "%downloaddir%\%ahkexe%"
call :download "%winpythoninstallerlink%" "%downloaddir%\%winpythonexe%"
call :download "%matlabinstallerlink%" "%downloaddir%\%matlabexe%"
goto:EOF
REM https://www.digitalcitizen.life/six-ways-removeuninstall-windows-programs-and-apps
:listallinstalledapps
wmic product get name
:uninstallapps
REM msiexec /x
REM ReturnValue=0 and a message saying “Method execution successful.”
echo y | wmic product where name="%1" call uninstall.
:uninstallgamepreinstalled

powershell.exe Get-AppxPackage *CandyCrush* | Remove-AppxPackage &&
powershell.exe Get-AppxPackage *DisneyMagicKingdoms* | Remove-AppxPackage &&
powershell.exe Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage &&
powershell.exe Get-AppxPackage *BubbleWitch* | Remove-AppxPackage &&
REM "Bubble Witch 3 Saga"
REM "Candy Crush Soda Saga"
REM "Disney Magic Kingdoms"
REM "March of Emipres:War of Lords"
goto:EOF

::installallapps
:installw10
REM mkdir C:\w10pro
REM set "isofile="
REM set "wim0file=D:\Users\user\Documents\win10iso\sources\install.wim"
REM set "wimfile=D:\Users\user\Documents\win10iso\sources\installw10pro.wim"
REM powershell -Command Mount-DiskImage -ImagePath %isofile%

REM set "wimfile=%USERPROFILE%\Documents\installw10pro.wim"
REM dism /Get-WimInfo /WimFile:%wim0file%
REM dism /export-image /SourceImageFile:%wim0file% /SourceIndex:6 /DestinationImageFile:%wimfile%  /Compress:max /CheckIntegrity
REM dism /Mount-Image /ImageFile:%wimfile% /index:1 /MountDir:C:\w10pro
REM dism /Unmount-Image /MountDir:C:\w10pro /commit


:installpython3
REM reg copy "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" "HKEY_LOCAL_MACHINE\WTGS\CurrentControlSet\Control" /s
REM reg copy "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet" "HKEY_LOCAL_MACHINE\WTGS\CurrentControlSet" /s
REM reg copy "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" "HKEY_LOCAL_MACHINE\WTGS\CurrentControlSet\Control\Session Manager" /sreg copy "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" "HKEY_LOCAL_MACHINE\WTGS\CurrentControlSet\Control\Session Manager" /s
REM https://docs.python.org/3/using/windows.html
REM https://www.howtogeek.com/197947/how-to-install-python-on-windows/
REM https://stackoverflow.com/questions/573817/where-are-environment-variables-stored-in-registry
REM HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
set PATH0=%LOCALAPPDATA%\Programs\Python\Python37;%LOCALAPPDATA%\Programs\Python\Python37\Scripts;%PATH%
set PATH=%USERPROFILE%\Downloads\swigwin-3.0.12;%PATH%
set PYTHONPATH=%LOCALAPPDATA%\Programs\Python\Python37\Scripts
set swigpath=%USERPROFILE%\Downloads\swigwin-3.0.12
REM call :download "" ""
set "envpathdir=HKEY_CURRENT_USER\Environment"
set "envpathkey=Path"
set "keytype=REG_EXPAND_SZ"
set "valto=%LOCALAPPDATA%\Programs\Python\Python37\;%LOCALAPPDATA%\Programs\Python\Python37\Scripts"
set "dmname="
call :updatethisregkey %envpathdir% %envpathkey% %keytype% %valto% %dmname% 
goto:EOF
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
:installtgb
:installgithub
:installatom
:installwinpython3
:installandroidstudio


::regedit
REM http://www.thewindowsclub.com/fix-cant-install-windows-usb-flash-drive-setup-upgrading-windows-8-1.
:enabledarkmode
set keytype=REG_DWORD
set "valto=0x0"
set dmname=dm
reg query %regdarkmodedir% /v %regdarkmodekey%
call :updatethisregkey %regdarkmodedir% %regdarkmodekey% %keytype% %valto% %dmname% 
goto:choosenow
:enabledevmode
powershell New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -PropertyType DWORD -Value 1 -Force
goto:EOF
:pslenabledarkmode
powershell New-ItemProperty "%regdarkmode%" -Name "AppsUseLightTheme" -PropertyType "DWord" -Value 0 -Force
goto:EOF
:pslenabledevmode
REM https://blogs.technet.microsoft.com/heyscriptingguy/2015/04/02/update-or-add-registry-key-value-with-powershell/
# Create AppModelUnlock if it doesn't exist, required for enabling Developer Mode
$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
if (-not(Test-Path -Path $RegistryKeyPath)) {
    New-Item -Path $RegistryKeyPath -ItemType Directory -Force
}
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name $name -Value $value `-PropertyType DWORD -Force
goto:EOF
:enablewsl
:downloadubuntu
:runupdatebashc
ubuntu -c "sudo apt-get update"
goto:EOF
:disablehyperv
REM https://stackoverflow.com/questions/30496116/how-to-disable-hyper-v-in-command-line
bcdedit /set hypervisorlaunchtype off
REM restartlater
goto:EOF
:otherhypervcmd
bcdedit /set hypervisorlaunchtype auto
dism /online /disable-feature /featurename:microsoft-hyper-v-all
bcdedit /copy {current} /d "Windows 10 no Hyper-V"
find the new id of the just created "Windows 10 no Hyper-V" bootentry, eg. {094a0b01-3350-11e7-99e1-bc5ec82bc470}
"bcdedit" and then look for identifier {XXX} in the added boot loader configuration
bcdedit /set {094a0b01-3350-11e7-99e1-bc5ec82bc470} hypervisorlaunchtype Off
powershell.exe Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
goto:EOF
:disableportable
::login
:logintounimelb
:logintogmail
:logintoyoutube
:logintoreddit
:logintodiscord


:startworking
REM npp.chrome,w10dir
REM if mbiosloadedopen
REM call :checkapprunningnrun "%nppdir%" "%nppexe%"

if exist %mbios1ms% (
if exist %mbios3gs% (
if exist "%xmingdir%" (
call :checkapprunningnrun "%xmingdir%" "%xmingexe%"
)
if exist "%xmingdir2%" (
call :checkapprunningnrun "%xmingdir2%" "%xmingexe2%"
)
call :wslgeditmbboth
)
)
goto:choosenow
:disableethernetconnection
:installwinisohdd
:installwindowsefi
REM https://prodesigntools.com/adobe-cc-2018-direct-download-links.html
REM C:\Program Files (x86)\Common Files\Adobe\OOBE\PDApp\IPC\AdobeIPCBroker.exe
REM C:\Program Files (x86)\Adobe\Adobe Creative Cloud\CCXProcess\CCXProcess.exe
REM C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exe

REM C:\Program Files (x86)\Common Files\Adobe\OOBE\PDApp\core\PDapp.exe
REM ADobe Licensing Utility

REM PremierePRO
REM C:\Program Files\Adobe\Adobe Premiere Pro CC 2018\32\dynamiclink.exe

:installadobephotoshopcc
REm AdobePhotoshop19-mul_x64.zip
REM https://prodesigntools.com/prdl-download/Photoshop/66A1D1E00DE44601B041A631261EC584/1507846032938/AdobePhotoshop19-mul_x64.zip
:installadobepremiereprocc
REM AdobePremierePro12AllTrial.zip
REm https://prodesigntools.com/prdl-download/Premiere%20Pro/50AAFADD563D4691896967A6AB1D47F8/1507826592638/AdobePremierePro12AllTrial.zip
:installadobeaftereffectscc
REM AdobeAfterEffects15AllTrial.zip
REM https://prodesigntools.com/prdl-download/After%20Effects/FDF6C521034E467BB283B5837FA042FF/1509090722739/AdobeAfterEffects15AllTrial.zip
:installadobesnrpatcher

set "vboxvmdefdir=%USERPROFILE%\VirtualBox VMs"
set "vboxvmuserdir=%USERPROFILE%\Documents\Docs"
set "fnnotesdefdir=%USERPROFILE%\AppData\Roaming\FiiNote"
set "fnnotesuserdir=%USERPROFILE%\Documents\Docs\FiiNote"

set "ph3downlink=https://files.pythonhosted.org/packages/00/36/c08af743a671d94da7fe10ac2d078624f3efc09273ffae7b18601a8414fe/PyHook3-1.6.1-cp35-win32.whl"
set "ph3fn=pyhook-1.6.1-cp35-cp35m-win32.whl"
set "ph3downdirfn=%USERPROFILE%\Downloads\%ph3fn%"
set "winpythonsenvdir=%winpythonsdir%\env.bat"
set "winpythondir=%USERPROFILE%\Documents\Docs\Automate\3WinPython-32bit-3.5.3.1Qt5"
set "winpythonsdir=%winpythondir%\scripts"

set "winpythonspdir=%winpythondir%\python-3.5.3\Lib\site-packages"
set "winpythonw32dir=%winpythonspdir%\win32"
set "winpythonpw32dir=%winpythonspdir%\pywin32_system32"
set "pcomdll=pythoncom35.dll"
set "pwtdll=pywintypes35.dll"

:linkvboxandos
if not exist "%vboxvmdefdir%" (
mkdir "%vboxvmdefdir%"
)
REM mklink /d notexists exists 
REM mklink [options] <Link> <Target>
REM Target is the file/folder that exists, and Link is the created one that links to the target.
mklink /d "%vboxvmdefdir%\ANDOS" "%vboxvmuserdir%\ANDOS"
goto:EOF
:linkfn
if exist "%fnnotesdefdir%" (
ren "%fnnotesdefdir%" "FiiNotebk"
)
mklink /d "%fnnotesdefdir%" "%fnnotesuserdir%"
goto:EOF
:installpyhook3
REM https://stackoverflow.com/questions/7238403/import-win32api-error-in-python-2-6
REM PyHook3-1.6.1-cp35-win32.whl
call :download "%ph3downlink%" "%ph3downdirfn%"
copy "%ph3downdirfn%" "%winpythondir%\%ph3fn%"
call "%winpythonsenvdir%"
pip install wmi win32gui win32api opencv-python
if not exist "%winpythonpw32dir%\%pcomdll%" (
copy "%winpythonpw32dir%\%pcomdll%" "%winpythonw32dir%\%pcomdll%"
)
if not exist "%winpythonpw32dir%\%pwtdll%" (
copy "%winpythonpw32dir%\%pwtdll%" "%winpythonw32dir%\%pwtdll%"
)
pip install "%ph3downdirfn%"
goto:EOF
:pipupgrade
call "%winpythonsdir%\upgrade_pip.bat"
goto:EOF
:changekeyboardtous
goto:EOF
::RUNWMMT5
:runwmmt5
REM correctbudgiloader
REM if not exist %tpbldir% ( cp exe2dir )
REM if not exist %tppldir% ()
REM call :addexctodefender2 %userdocdir%
REM call :addexctodefender2 %exe2dir%
REM call :addexctodefender2 %tpbldir%
REM call :addexctodefender2 %tppldir%
call :checkapprunningnrun %ucrdir% %ucrexe%
call :checkapprunningnrun %tpdir% %tpexe% 
goto:choosenow
::RUNFORTNITE
:runeglPC
call :checkapprunningnrun %egldir% %eglexe%
goto:choosenow
:setdefaultappsbyreg
REM COMMENT
REM THIS IS AN EXAMPLE. CREATE ABOVE BATCH FILE AND EXECUTE IT.
REM You will be able to open Python files 
rem https://stackoverflow.com/questions/35669120/simple-ftype-command-not-working
reg.exe add "%key%\.py" /f /t REG_SZ /d "Python.File" >NUL 2>NUL
reg.exe add "%key%\Python.File" /f /t REG_SZ /d "Python File" >NUL 2>NUL
reg.exe add "%key%\Python.File\DefaultIcon" /f /t REG_SZ /d "%pyhome%DLLs\py.ico" >NUL 2>NUL
reg.exe add "%key%\Python.File\shell\Edit with IDLE\command" /f /t REG_SZ /d "\"%pyhome%pythonw.exe\" \"%pyhome%Lib\idlelib\idle.pyw\" -e \"%%1\"" >NUL 2>NUL
reg.exe add "%key%\Python.File\shell\open\command" /f /t REG_SZ /d "\"%pyhome%pywin.bat\" \"%%1\" %%*" >NUL 2>NUL
reg.exe add "%key%\Python.File\shellex\DropHandler" /f /t REG_SZ /d "{60254CA5-953B-11CF-8C96-00AA00B8708C}" >NUL 2>NUL
goto:EOF
:setdefaultapps
REM https://social.technet.microsoft.com/Forums/ie/en-US/06d35f90-56cb-4dec-b326-bd471d06acee/change-default-program-for-file-command-line-or-registry?forum=w7itprogeneral
REM https://superuser.com/questions/362063/how-to-associate-a-file-with-a-program-in-windows-via-cmd
REM https://ss64.com/nt/ftype.html
REM assoc | more
rem %localappdata%
rem needadmin
set "pdfadobe=C:\Users\%username%\Documents\Automate\3Acrobat.Pro.DC\Acrobat DC\Acrobat\Acrobat.exe"
set "pdfsumatra=C:\Users\%username%\Documents\Automate\SumatraPDF-3.1.2\SumatraPDF.exe"
set "editnpp=C:\Users\%username%\Documents\Automate\3Notepad++\notepad++.exe"
set "editwxhex=C:\Users\%username%\Documents\Automate\3wxHexEditor-v0.23-Win32\wxHexEditor\wxHexEditor.exe"
set "editatom=C:\Users\%username%\AppData\Local\atom\atom.exe"
set "editidle3=C:\Users\%username%\Documents\Automate\3WinPython-32bit-3.5.3.1Qt5\IDLEX (Python GUI).exe"
ftype userpdfeditor1=%pdfadobe% "%1"
ftype userpdfeditor2=%pdfsumatra% "%1"
assoc .pdf=userpdfeditor1
ftype usereditor1=%editnpp% "%1"
ftype usereditor2=%editatom% "%1"
assoc .txt=usereditor1
ftype userpyeditor2=%editidle3% "%1"
goto:EOF
:wslgedit
REM https://stackoverflow.com/questions/1449188/running-windows-batch-file-commands-asynchronously
set filedir1=%1
REM wsl export DISPLAY=:%xdisplay% ; nohup gedit %filedir1% &
start /b cmd /c "wsl export DISPLAY=:%xdisplay% ; nohup gedit %filedir1% &"
goto:EOF
:wslgeditrw10
REM https://blogs.msdn.microsoft.com/commandline/2017/11/28/a-guide-to-invoking-wsl/
REM ubuntu -c [command]
REM bash -c [command]
REM wsl [command] (NOTE: In this case you don't append '-c', you just type in your command)
REM ubuntu -c export DISPLAY=:%xdisplay% ; nohup gedit %rw10scriptdir% & disown $!
call :wslgedit "%rw10scriptdir%"
goto:EOF
:wslgeditmb1ms
call :wslgedit "%mb1ms%"
goto:EOF
:wslgeditmb3gs
call :wslgedit "%mb3gs%"
goto:EOF
:wslgeditmbboth
REM wsl export DISPLAY=:%xdisplay% ; nohup gedit "%mb3gs%" "%mb1ms%" &
start /b cmd /c "wsl export DISPLAY=:%xdisplay% ; nohup gedit "%mb3gs%" "%mb1ms%" &"
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
:addmanualwindefexclusiondir
set "KEY_NAME=%regwindefexcdir%"
REG QUERY "%KEY_NAME%"
set /p dir="Enter DIR: "
call :addexctodefender %dir%
goto:choosenow
:removemanualwindefexclusiondir
set "KEY_NAME=%regwindefexcdir%"
REG QUERY "%KEY_NAME%"
set /p dir="Enter DIR: "
REM powershell.exe -Command "Remove-MpPreference -ExclusionPath '%dir%'"
Powershell.exe -Command "& {Start-Process Powershell.exe -ArgumentList 'Remove-MpPreference -ExclusionPath "%dir%"' -Verb RunAs}"
goto:choosenow

:regswitchnpp
set "key=%regimfeodir%\%npadexe%"
set keyname=Debugger
set keytype=REG_SZ
set "npval=C:\Program Files\Notepad++\notepad++.exebla"
echo "%regimfeodir%\%npadexe%"
REM call :removethisregkey "%regexec%\%npadexe%" %keyname%
call :updatethisregkey "%key%" %keyname% %keytype% "C:\Program Files\Notepad++\notepad++.exe"
goto:choosenow


::FNENGINE

:listallfn
REM https://stackoverflow.com/questions/9789563/how-to-write-a-search-pattern-to-include-a-space-in-findstr/42534211?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
REM cd /d %userhomedir%\Downloads\winreinstall\script\
REM exceptionhandler https://stackoverflow.com/questions/31445330/does-windows-batch-support-exception-handling
REM https://www.windows-commandline.com/findstr-command-examples-regular/
echo %1
set /a countfn=1
for /f "tokens=* delims=" %%x in ('findstr /r /i ^
/c:"^:openpsl" ^
/c:"^:opendirinexp" ^
/c:"^:downloadallapps" ^
/c:"^:installpyhook3" ^
/c:"^:reinstallw10" ^
/c:"^:reinstallw10g" ^
/c:"^:setdefaultapps" ^
/c:"^:run" ^
/c:"^:updatethisregkey" ^
/c:"^:enabledarkmode" ^
/c:"^:staticinetcompno" ^
/c:"^:addmanualwindefexclusiondir" ^
/c:"^:removemanualwindefexclusiondir" ^
/c:"^:regswitchnpp" ^
/c:"^:seeregedit" ^
/c:"^:wslgeditrw10" ^
/c:"^:wslgeditmb1ms" ^
/c:"^:wslgeditmb3gs" ^
/c:"^:wslgeditmbboth" ^
/c:"^:startworking" ^
/c:"^:testcheckapprunningnrun" ^
/c:"^:testecho" ^
/c:"^:testlinkd" ^
/c:"^:testelif" ^
/c:"^:testbogus" ^
/c:"^:traprestart" %1') do (
set allfn[!countfn!]=%%x
REM echo !countfn!%%x
call echo !countfn!%%allfn[!countfn!]%%
set /a countfn+=1
)
goto:EOF

:traprestart
REM https://stackoverflow.com/questions/3827567/how-to-get-the-path-of-the-batch-script-in-windows
set mypath=%~dp0
set PATH0=%mypath:~0,-1%
echo %PATH0%
start "" %DIR0%
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
call :listallfn "%DIR0%"
call :choosefn "%DIR0%"
EXIT /B %ERRORLEVEL%


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

:testecho
echo "Hello World!"
test&cls
goto:choosenow
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
:testdelimit
REM https://stackoverflow.com/questions/27443383/how-to-get-first-part-of-a-delimited-string-in-batch
for /f "tokens=1 delims=." %%a in ("%var%") do set "new_var=%%a"
set var=something.contains.text
set new_var=%var:.=&rem %

set "str=Te$ting thi$ $cript for $zero"
set "result=%str:$=" & set "result=%"
REM echo %result%
goto:EOF
:testlinkd
call :getstrlastdlink "%nvidiadinstallerlink%" "/"
echo result:%result%
call :deletestrafter %result% .exe
REM call :getstrlastdlink2 "%nvidiadinstallerlink%" "/"
REM echo result:%result%
REM echo bla0:%winpythoninstallerlink%

set "winpythoninstallerlink=https://sourceforge.net/settings/mirror_choices?projectname=winpython^&filename=WinPython_3.6/3.6.5.0/WinPython64-3.6.5.0Qt5.exe^&selected=jaist"
REM for %%a in ("%winpythoninstallerlink%") do echo bla:%%~a
echo bla2:%winpythoninstallerlink%
call :deletestrafter %winpythoninstallerlink% "selected=jaist"
set result=
call :getstrlastdlink %winpythoninstallerlink%
echo result:%result%
REM echo wplink:%wplink%
REM call :deletestrafter %result% "jaist"
goto:EOF
:testnewregkey
REM https://www.lifewire.com/how-to-create-edit-and-use-reg-files-2622817
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdhid\Parameters]
"CrashOnCtrlScroll"=dword:00000001
:testregbogus
set regdarkmodekey=BOGUS
set keytype=REG_SZ
set valto=0x1
set dmname=bogus
call :updatethisregkey %regdarkmodedir% %regdarkmodekey% %keytype% %valto% %dmname%
goto:choosenow

:testupdatewdir
set "regwindefexcdir=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths"
set "regdarkmodedir=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
set regdarkmodekey=AppsUseLightTheme
set regdevmodedir=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock
set regdevmodekey=AllowDevelopmentWithoutDevLicense
set "regimfeodir=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"
set "npadexe=notepad.exe"
set nppdir="C:\Program Files\Notepad++"
set "nppexe=notepad++.exe"

set KEY_NAME=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize &&
set VALUE_NAME="AppsUseLightTheme" &&
set keytype=REG_DWORD &&
set valto=0x0 &&
reg delete %KEY_NAME% /v %VALUE_NAME% /f &&
reg add %KEY_NAME% /v %VALUE_NAME% /t %keytype% /d %valto% /f

set KEY_NAME=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize &&
set VALUE_NAME="AppsUseLightTheme" &&
set VALUE_NAME="C:\Program Files\Notepad++\notepad++.exe" &&
set keytype=REG_SZ &&
set valto="C:\\Program Files\\Notepad++\\notepad++.exe" &&
reg delete %KEY_NAME% /v %VALUE_NAME% /f &&
reg add %KEY_NAME% /v %VALUE_NAME% /t %keytype% /d %valto% /f

set KEY_NAME=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock &&
set VALUE_NAME="AllowDevelopmentWithoutDevLicense" &&
set keytype=REG_DWORD &&
set valto="1" &&
reg delete %KEY_NAME% /v %VALUE_NAME% /f &&
reg add %KEY_NAME% /v %VALUE_NAME% /t %keytype% /d %valto% /f

set KEY_NAME="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths" &&
set VALUE_NAME="C:\Users\user\Desktop" &&
set keytype=REG_DWORD &&
set valto="0" &&
reg delete %KEY_NAME% /v %VALUE_NAME% /f ;
reg add %KEY_NAME% /v %VALUE_NAME% /t %keytype% /d %valto% /f

goto:EOF

:testcheckapprunningnrun
REM https://stackoverflow.com/questions/162291/how-to-check-if-a-process-is-running-via-a-batch-script
set "xmingdir=C:\Program Files (x86)\Xming"
echo "%xmingdir%"
echo "bla"
set xmingexe=XLaunch.exe

set "appdir=%xmingdir%"
set app=%xmingexe%
tasklist /FI "IMAGENAME eq %app%" 2>NUL | find /I /N "%app%">NUL
if %ERRORLEVEL% equ 0 (
echo Program is running
) else ( 
cd /d "%appdir%"
start "" "%app%"
)
REM call :sleep 600
goto:EOF

:testupdatethisregkey2
set KEY_NAME=
set VALUE_NAME=
set keytype=
set "valto="
set "keyname="
set ValueName=
set ValueType=
set ValueValue=

set KEY_NAME=%1
set VALUE_NAME=%2
set keytype=%3
set "valto=%4"
set keyname=%5
echo %KEY_NAME%
FOR /F "usebackq skip=2 tokens=1-3" %%A IN (`REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul`) DO (
set ValueName=%%A
set ValueType=%%B
set ValueValue=%%C
)
REM REG QUERY %KEY_NAME% /v %VALUE_NAME%
if defined ValueName (
@echo Value Name = %ValueName%
@echo Value Type = %ValueType%
@echo Value Value = %ValueValue%
) else (
@echo %KEY_NAME%\%VALUE_NAME% not found.
)

echo current: %KEY_NAME% /v %ValueName% /t %ValueType% /d %ValueValue% /f
call :sleep 600
if defined ValueName (
echo %KEY_NAME%\%VALUE_NAME% exists
if defined valto (
echo curvalue:%ValueValue%
if %ValueValue% == %valto% (
echo alrsame
) else (
echo notsamesochangevalto:%valto%
REM call :removethisregkey %KEY_NAME% %VALUE_NAME%
reg add %KEY_NAME% /v %VALUE_NAME% /t %keytype% /d %valto% /f
)
)

) else (
echo %KEY_NAME%\%VALUE_NAME% not found; creating one
call :sleep 600
reg add %KEY_NAME% /v %VALUE_NAME% /t %keytype% /d %valto% /f
)
goto:choosenow

:projects
reinstallw10
reinstallw10g
mstart2
ubuntu resquash
ubuntu reinstall

python ocv
python receipt
python scanning from photos
voice assistant?

backup tgb

portingandroid
projectsrasbpi
projectandroidemulator
projectupcycleandroid
projectusbducky
projectbatterylabeling
project3dprinterusbcover
project3dpspecs
goto:EOF