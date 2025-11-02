:: opmgh2dx_unified
:: batch coded by Caserol23

@echo off
title OPM Guitar Hero 2 Deluxe Unified PS2 - Installer and Patcher

:: install by default

:: downloading resources
set dirset=%HomeDrive%
set sevenz=C:\Program Files\7-Zip\7z.exe
set meyn=%dirset%\main.zip
set gitmain=opmgh2dx_patcher-main
set gitout=bin
set scriptbranch=%dirset%\%gitout%\_lib\scripts
set toolbranch=%dirset%\%gitout%\_lib\tools
set buildiml=%scriptbranch%\patch.iml
set updaterecompile=%scriptbranch%\update_recompile.bat
set addcustompatch=%scriptbranch%\addcustom.bat
set reinstall_patch=%scriptbranch%\reinstall_all.bat
set arkhelper=%scriptbranch%\tools\arkhelper.exe
set buildark=%dirset%\bin\build
set arkfolder=%dirset%\bin\_ark
set libs=%dirset%\%gitout%\_lib
set libtmp=%dirset%\%gitout%\tmp

echo.
echo Please avoid much space, use "_" underscore instead.
set /p ps2dir="Locate PS2 Folder: "
rmdir /S /Q %dirset%\%gitout%
mkdir %dirset%
cls
echo.

:: extraction main branch
if not exist "%sevenz%" (
	echo Error! Installation Aborted!
	echo Please install "7Zip" by default first
	echo.
	pause
	exit /b
	)
if exist "%meyn%" (
	goto :proc
	)
if not exist "%meyn%" (
	goto :mainproc
	) else (
		goto procext
		)

:mainproc
echo.
echo Downloading Resources...
echo.
curl -L https://github.com/Caserol23/opmgh2dx_patcher/archive/refs/heads/main.zip --output %meyn%
cls

:proc
"%sevenz%" x %meyn% -o"%dirset%" -y
cd %dirset%
ren %dirset%\%gitmain% %gitout%

:: create menu
(
echo @echo off
echo mode con: cols=42 lines=20
echo :mainmenu
echo title OPMGH2DXU Patcher
echo echo ==========================
echo echo  OPMGH2DX Unified Patcher
echo echo     Coded by Caserol23
echo echo ==========================
echo echo.
echo echo 1. Update Patches
echo echo.
echo echo ==========================
echo echo.
echo echo 0. Exit
echo echo.
echo set /p menunum=" > "
echo if "%%menunum%%"=="1" start "" "%updaterecompile%"
echo if "%%menunum%%"=="0" exit
echo cls
echo goto mainmenu
) > %scriptbranch%\opmgh2dxu.bat

:: optional scripts
mkdir %buildark%\GEN
echo Copying Scripts 2/2
(
echo @echo off
echo cls
echo %toolbranch%\arkhelper.exe dir2ark "%arkfolder%" "%buildark%\GEN" -n MAIN -s 4073741823
echo %libs%\python.exe %libs%\main.py --iml=%buildiml% --out_disc_image="%ps2dir%\OPMGH2DXU.iso"
echo cls
echo pause
echo exit
) > "%updaterecompile%"
copy %scriptbranch%\opmgh2dxu.bat %SystemDrive%%HomePath%\Desktop
ren %SystemDrive%%HomePath%\Desktop\opmgh2dxu.bat %SystemDrive%%HomePath%\Desktop\OPMGH2DXU.bat
cls
echo.
echo Requirements Installed!
echo.
pause
exit /b
