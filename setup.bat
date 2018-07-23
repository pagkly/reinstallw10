:cleandiskw10g
REM https://smallbusiness.chron.com/putting-wim-usb-78160.html
REM https://4sysops.com/archives/windows-to-go-some-tips-and-an-odd-boot-problem-error-code-0xc000000e/
REM https://pureinfotech.com/repair-master-boot-record-mbr-windows-10/
REM https://www.wintips.org/how-to-extract-an-install-wim-file-that-contains-several-install-wim-files/
REM https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-8.1-and-8/hh824814(v=win.10)
REM https://www.peppercrew.nl/index.php/2015/02/automated-usb-wim-deployment/
REM download iso
REM extract only winpro
diskpart 
diskpart list disk
diskpart select disk 1
diskpart clean
create partition primary
format fs=ntfs quick
active
exit

copy "C:\Program Files\Windows AIK\Tools\amd64\imagex.exe" %USERPROFILE%\Documents
cd %USERPROFILE%\Documents
imagex.exe /apply installw10pro.wim 1 D:\
bcdboot.exe D:\Windows /s D: /f ALL
REM D:\efi\boot
goto:EOF

:initrw10
REM https://social.technet.microsoft.com/Forums/ie/en-US/af677b8e-f30d-4fbc-a3b7-cd70c001c89f/windows-10-remove-cortanasearch-box-from-task-bar-via-gpo-for-osd?forum=win10itprosetup
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search SearchboxTaskbarMode REG_DWORD 0
REM https://superuser.com/questions/395818/how-to-change-keyboard-layout-via-command-line-cmd-exe-on-windows-xp-7
REM ipmo international
REM powershell Get-WinSystemLocale
powershell Set-WinSystemLocale en-US
REM https://stackoverflow.com/questions/16656229/how-do-i-set-the-timezone-from-command-line
tzutil /s "AUS Eastern Standard Time"
REM tzutil /g
REM tzutil /l
REM tzutil /s
goto:EOF

:startupedit
REM http://www.robvanderwoude.com/escapechars.php
REM https://stackoverflow.com/questions/11893309/escape-double-quotes-inside-batchs-input-parameters
REM https://www.online-tech-tips.com/computer-tips/list-windows-startup-programs/
REM https://smallbusiness.chron.com/remove-startup-items-regedit-64095.html
REM https://www.overclock.net/forum/132-windows/622070-how-remove-startup-programs-command-line.html
REM sc query
wmic startup get caption,command
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Skype

REM reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run OneDrive "\"C:\Users\user\AppData\Local\Microsoft\OneDrive\OneDrive.exe" /background\"
REM reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run Skype "\"C:\Program Files (x86)\Skype\Phone\Skype.exe" /minimized /regrun\"
goto:EOF

:pinuptb
REM https://superuser.com/questions/1193985/command-line-code-to-pin-program-to-taskbar-windows-10
REM C:\Users\user\AppData\Roaming
REM C:\Users\Public\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar
REM %AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar
REM unpin MStore,Edge,Mail

:adobeinstall
REM https://www.windowscentral.com/how-enable-or-disable-wi-fi-and-ethernet-network-adapters-windows-10
REM netsh interface show interface
netsh interface set interface "Ethernet" disable

:notes
ocvreceipt
scanning from photos

web like fiinote
tax
reinstallw10g
rpi3
blender
livestream setup?

:pythonpip
REM installvisualbuildtools
pip install pyhook3