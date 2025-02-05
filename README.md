# VirtualBox Installer Script  

This script was created by me for TAFE NSW ICT courses to simplify the installation of new versions of VirtualBox on Windows 10/11 machines.

## How to Use
### Prerequisites:
* Ensure your system has the latest updates installed before proceeding.
* Verify that you have an internet connection, as the script requires it to download packages from Winget and Oracle.

### Downloading and running the Script
1. Click [here](https://raw.githubusercontent.com/RyanTheTide/VBIS/refs/heads/main/VBIS.bat) to navigate to the script online.
2. Press **Control + S** (**Ctrl-S**) on your keyboard to open the save prompt.  
   - Ensure the following:  
     - **File name:** `VBIS.bat`  
     - **Save as type:** `All files (*.*)`
   - Press 'Save'.
3. Locate `VBIS.bat` in your Downloads folder (or wherever you saved it locally).
4. Double-click or right-click and select 'Open'.
5. Select 'Yes' on the "Do you want to install this app to make changes to your device?" UAC prompt.
6. The script has completed running when the window closes. Reboot if needed for software to function correctly.

## What This Script Does  

1. Ensures the latest version of Python is installed (using the Winget repository) and installs the `pywin32` dependency.  
2. Installs the latest version of VirtualBox (using the Winget repository).  
3. Attempts to install the VirtualBox Extension Pack for the installed version.  
4. Creates a log to capture command outputs. The log file, named `VBIS-log.txt`, can be found in `%localappdata%\temp`.  

## Important Information

As always, you should never run a script unless you have vetted it, understand its purpose, and are aware that things can go wrong. The worst outcome of using this script should be a failed installation, in which case it can be easily diagnosed using the log file.

If you encounter any issues, please open an [Issue](https://github.com/RyanTheTide/VBIS/issues) and attach (or copy the contents of) the log file found at `%localappdata%\temp\VBIS-log.txt`.  

Finally, since this script is designed to install the latest version of VirtualBox, it does not support specifying a particular version. I likely won’t be releasing updates for the Windows version unless I decide to convert it to PowerShell or something drastically breaks. I intend to release a version for Arch Linux and macOS 15+ since I also use these operating systems. However, I currently have no timeframe or plan for the installation methods I will use.

Best of luck, and thank you for using my script!
