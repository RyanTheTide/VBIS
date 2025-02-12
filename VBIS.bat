@echo off

REM - Welcome to the VirtualBox Installer Script for Windows v1.0.
REM - This script was created by Ryan Murray for TAFENSW ICT courses to simplify the installation of new versions of VirtualBox on Windows 10/11 machines.
REM - Here's what this script does. First it ensures that the latest version of Python is installed (winget repoistory) and the pywin32 dependency is installed. Then it installs the latest verson of VirtualBox (winget repository) and finally attempts to install the VirtualBox Extention Pack for the installed version. The script also contains a built in logger for the output of the commands ran. This log file is named 'VBIS-log.txt' and can be found in '%localappdata%\temp'.
REM - Finally a quick warning. As always you should never run any script unless it has been vetted, you understand its purpose and you understand that things can go wrong. In the case of this script the "worst that should" happen is it doesn't work and the log file shows what went wrong. If you have any problems please open an Issue on GitHub (https://github.com/RyanTheTide/VBIS/issues) and attach (or copy the contents of) the log file found at '%localappdata%\temp\VBIS-log.txt'.

REM			Sets terminal to quiet and loads script content as Administrator

title VirtualBox Installer Script for Windows v1.0
if exist %localappdata%\temp\VBIS-log.txt (
	del %localappdata%\temp\VBIS-log.txt
) else (
	echo VirtualBox Installer Script by Ryan Murray > %localappdata%\temp\VBIS-log.txt 2>&1
)
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
echo #------ RUNNING AS ADMINISTRATOR ------# >> %localappdata%\temp\VBIS-log.txt 2>&1
echo This script was last ran on %date% - %time%. >> %localappdata%\temp\VBIS-log.txt 2>&1


REM			Installs Python, pywin32, VirtualBox and VirtualBox Extention Pack
echo #------ INSTALL LATEST PYTHON MACHINE-WIDE AND ADD TO PATH ------# >> %localappdata%\temp\VBIS-log.txt 2>&1
powershell write-host -fore Cyan Installing latest version of Python...
winget install python --silent --accept-source-agreements --accept-package-agreements >> %localappdata%\temp\VBIS-log.txt 2>&1
powershell write-host -fore Blue Python Installed!
echo #------ INSTALL VIRTUALBOX PYTHON 7.0.24+ DEPENDENCIES ------# >> %localappdata%\temp\VBIS-log.txt 2>&1
powershell write-host -fore Cyan Installing Dependencies...
pip install pywin32 >> %localappdata%\temp\VBIS-log.txt 2>&1
powershell write-host -fore Blue Installed!
echo #------ INSTALL LATEST VIRTUALBOX VERSION ------# >> %localappdata%\temp\VBIS-log.txt 2>&1
powershell write-host -fore Cyan Installing latest Version of VirtualBox...
winget install virtualbox --silent --accept-source-agreements --accept-package-agreements >> %localappdata%\temp\VBIS-log.txt 2>&1
echo #------ GET INSTALLED VIRTUALBOX VERSION AND STORE TO VAR ------# >> %localappdata%\temp\VBIS-log.txt 2>&1
if exist "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" (
	for /f "tokens=1 delims=r" %%a in ('"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" --version') do set VER=%%a
) else (
	for /f "tokens=1 delims=r" %%a in ('"D:\Program Files\Oracle\VirtualBox\VBoxManage.exe" --version') do set VER=%%a
)
powershell write-host -fore Blue VirtualBox %VER% Installed!
echo #------ DOWNLOAD LATEST VIRTUALBOX EXTENSION PACK TO TEMP ------# >> %localappdata%\temp\VBIS-log.txt 2>&1
powershell write-host -fore Cyan Installing VirtualBox Extention Pack...
powershell Invoke-WebRequest https://download.virtualbox.org/virtualbox/%VER%/Oracle_VirtualBox_Extension_Pack-%VER%.vbox-extpack -OutFile %localappdata%\temp\Oracle_VirtualBox_Extension_Pack-%VER%.vbox-extpack
echo #------ INSTALL VIRTUALBOX EXTENSION PACK ------# >> %localappdata%\temp\VBIS-log.txt 2>&1
if exist "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" (
	echo y | "C:\Program Files\Oracle\VirtualBox\VBoxManage" extpack install %localappdata%\temp\Oracle_VirtualBox_Extension_Pack-%VER%.vbox-extpack >> %localappdata%\temp\VBIS-log.txt 2>&1
) else (
	echo y | "D:\Program Files\Oracle\VirtualBox\VBoxManage" extpack install %localappdata%\temp\Oracle_VirtualBox_Extension_Pack-%VER%.vbox-extpack >> %localappdata%\temp\VBIS-log.txt 2>&1
)
powershell write-host -fore Blue Installed VirtualBox %VER% Extention Pack!

echo #------ DELETE THE EXTENSION PACK TEMP FILE ------# >> %localappdata%\temp\VBIS-log.txt 2>&1
del %localappdata%\temp\Oracle_VirtualBox_Extension_Pack-%VER%.vbox-extpack >> %localappdata%\temp\VBIS-log.txt 2>&1
powershell write-host -fore Yellow VirtualBox Install Completed!
exit
