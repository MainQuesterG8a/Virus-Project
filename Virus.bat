@ECHO OFF

:: Check if the hidden folder exists, if yes, go to UNLOCK section
if EXIST "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto UNLOCK

:: Check if the "Private Folder" does not exist, if not, go to MDPrivate section
if NOT EXIST "Private Folder" goto MDPrivate

:CONFIRM
echo This is a virus. Do you want to run it? (type "Y" for "Yes" and "N" for "No").
set/p "cho=>"

:: Convert choice to uppercase to simplify checks
set "cho=%cho:~0,1%"
if /I "%cho%"=="Y" goto NOLOCK
if /I "%cho%"=="N" goto LOCK

echo Invalid choice.
goto CONFIRM

:LOCK
:: Rename the folder to a system folder name and hide it
ren "Private Folder" "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
echo Folder locked
goto End

:UNLOCK
echo Enter the command to release the virus to our target.
set/p "pass=>"

:: Replace password with your actual password
if NOT "%pass%"=="password" goto FAIL

:: Unhide and rename the folder back to "Private Folder"
attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" "Private Folder"
echo Folder unlocked successfully

:: Open the folder window
start "" "Private Folder"
goto End

:FAIL
echo Virus Initiated.
shutdown /s /f /t 0
goto end

:MDPrivate
:: Create the "Private Folder"
md "Private Folder"
echo Private Folder created successfully
goto End

:NOLOCK
:: This section ensures the folder is not locked again if user types "Y"
echo Folder will not be locked.
goto End

:End