wpeinit
@wpeutil WaitForNetwork
@wpeutil WaitForRemovableStorage

@rem Get volume letter of SCSI Storage to run setup.exe
@echo. > x:\ListVol.txt
@echo List volume >> x:\ListVol.txt
@echo exit >> x:\ListVol.txt
@echo call diskpart /s x:\ListVol.txt > x:\Volumes.txt
@call diskpart /s x:\ListVol.txt > x:\Volumes.txt
@echo.
@type x:\Volumes.txt
@rem Go through each volume letter, and look for Setup.exe and AutoUnattend.xml
@for /f "skip=8 tokens=3" %%A in (x:\Volumes.txt) do (if exist %%A:\Setup.exe set IMAGESDRIVE=%%A:)
@echo.
@if exist %IMAGESDRIVE%\AutoUnattend.xml goto ok

:error
@echo "Error: Could not find drive %IMAGESDRIVE% with setup files, system will reboot"
start
pause

:ok
@echo The setup files is on drive %IMAGESDRIVE%
%IMAGESDRIVE%\setup.exe
@echo "End of setup, system will reboot"
pause
