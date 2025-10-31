:: opmgh2dx_unified
:: batch coded by Caserol23

@echo off
title OPM Guitar Hero 2 Deluxe Unified PS2 - Installer and Patcher

:: install by default

:: downloading resources
set dirset=%AppData%
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
set sng=%arkfolder%\(..)\(..)\system\run\config\sng.dta
set sngstore=%arkfolder%\(..)\(..)\system\run\config\sngpatch.dta

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
goto :eof

:proc
"%sevenz%" x %meyn% -o"%dirset%" -y
cd %dirset%
ren %dirset%\%gitmain% %gitout%

:: generating scripts
echo.
echo Generating Scripts...
echo.

:: create menu
(
echo @echo off
echo mode con: cols=42 lines=20
echo :mainmenu
echo title OPMGH2DXU Patcher
echo echo ==========================================
echo echo  OPM Guitar Hero 2 Deluxe Unified Patcher
echo echo             Coded by Caserol23
echo echo ==========================================
echo echo.
echo echo 1. Update Patches
echo echo.
echo echo ==========================================
echo echo.
echo echo 0. Exit
echo echo.
echo set /p menunum=" > "
echo if "%%menunum%%"=="1" start "" "%updaterecompile%"
echo if "%%menunum%%"=="0" exit
echo cls
echo goto mainmenu
) > %scriptbranch%\opmgh2dxu.bat

:: IML File
echo Copying Scripts 1/2
(
echo [SYS]
echo VERSION=1.00
echo MEDIA=DVD
echo TARGET=PS2
echo DISCVERSION=1.00
echo DATE=2025/10/29-23:10:27
echo [/SYS]
echo.
echo [CUE]
echo DISCNAME="OPGH-12345                      "
echo PRODUCER="PLAYSTATION                     "
echo COPYRIGHT="                                "
echo CREATIONDATE=20251029
echo PSTYPE=2
echo DISCCODE=02
echo [/CUE]
echo.
echo [LOC]
echo 0        291      0.0  0   "%scriptbranch%\patch.ims"
echo 292      324      0.0  0   "%buildark%\GEN\MAIN.HDR"
echo 325      164059   0.0  0   "%buildark%\GEN\MAIN_0.ARK"
echo 164060   164076   0.0  0   "%buildark%\IOP\CDVDSTM.IRX"
echo 164077   164211   0.0  0   "%buildark%\IOP\IOPRP300.IMG"
echo 164212   164236   0.0  0   "%buildark%\IOP\LGAUD.IRX"
echo 164237   164251   0.0  0   "%buildark%\IOP\LIBSD.IRX"
echo 164252   164302   0.0  0   "%buildark%\IOP\MCMAN.IRX"
echo 164303   164306   0.0  0   "%buildark%\IOP\MCSERV.IRX"
echo 164307   164310   0.0  0   "%buildark%\IOP\MSIFRPC.IRX"
echo 164311   164316   0.0  0   "%buildark%\IOP\MTAPMAN.IRX"
echo 164317   164339   0.0  0   "%buildark%\IOP\PADMAN.IRX"
echo 164340   164340   0.0  0   "%buildark%\IOP\SCRTCHPD.IRX"
echo 164341   164345   0.0  0   "%buildark%\IOP\SDRDRV.IRX"
echo 164346   164348   0.0  0   "%buildark%\IOP\SIO2MAN.IRX"
echo 164349   164416   0.0  0   "%buildark%\IOP\SYNTH_R.IRX"
echo 164417   164433   0.0  0   "%buildark%\IOP\SYNTH_S.IRX"
echo 164434   164451   0.0  0   "%buildark%\IOP\USBD.IRX"
echo 164452   164458   0.0  0   "%buildark%\IOP\USBKB.IRX"
echo 164459   166204   0.0  0   "%buildark%\OPGH_123.45"
echo 166205   166205   0.0  0   "%buildark%\SYSTEM.CNF"
echo 176447   176447   0.0  0   "%scriptbranch%\patch.ims" 598016
echo [/LOC]
) > %buildiml%

:: optional scripts
mkdir %buildark%\GEN
echo Copying Scripts 2/2
(
echo @echo off
echo cls
echo curl -L https://github.com/Caserol23/opmgh2dx_patcher/releases/download/song_patch/update.zip --output %TMP%\update.zip
echo cls
echo "%sevenz%" x %TMP%\update.zip -o"%arkfolder%\songs" -y
echo type %arkfolder%\songs\songdta.txt ^>^> %sng%
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
