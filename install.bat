:: opmgh2dx_unified
:: batch coded by Caserol23

@echo off
title OPM Guitar Hero 2 Deluxe Unified PS2 - Installer and Patcher

:: install by default

:: downloading resources
set dirset=%ALLUSERSPROFILE%
set sevenz=C:\Program Files\7-Zip\7z.exe
set meyn=%dirset%\main.zip
set gitmain=opmgh2dx_patcher-main
set gitout=bin
set scriptbranch=%dirset%\%gitout%\_lib\scripts
set geniml=%scriptbranch%\patch.iml
set updaterecompile=%scriptbranch%\update_recompile.bat
set addcustompatch=%scriptbranch%\addcustom.bat
set reinstall_patch=%scriptbranch%\reinstall_all.bat
set arkhelper=%scriptbranch%\tools\arkhelper.exe
set buildark=%dirset%\bin\build\GEN
set arkfolder=%dirset%\bin\_ark

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
	goto proc
	)
if not exist "%meyn%" (
	goto mainproc
	) else (
		goto procext
		)

:mainproc
echo.
echo Downloading Resources...
echo.
curl -L https://github.com/Caserol23/opmgh2dx_patcher/archive/refs/heads/main.zip --output %dirset%

:proc
"%sevenz%" x %meyn% -o"%dirset%" -y
cd %dirset%
ren "%gitmain%" "%gitout%"

:: generating scripts
echo.
echo Generating Scripts...
echo.

:: IML File
echo Copying Scripts 1/4
(
[SYS]
VERSION=1.00
MEDIA=DVD
TARGET=PS2
DISCVERSION=1.00
DATE=2025/10/29-23:10:27
[/SYS]

[CUE]
DISCNAME="OPGH-12345                      "
PRODUCER="PLAYSTATION                     "
COPYRIGHT="                                "
CREATIONDATE=20251029
PSTYPE=2
DISCCODE=02
[/CUE]

[LOC]
0        291      0.0  0   "%geniml%\patch.ims"
292      324      0.0  0   "%geniml%\GEN\MAIN.HDR"
325      164059   0.0  0   "%geniml%\GEN\MAIN_0.ARK"
164060   164076   0.0  0   "%geniml%\IOP\CDVDSTM.IRX"
164077   164211   0.0  0   "%geniml%\IOP\IOPRP300.IMG"
164212   164236   0.0  0   "%geniml%\IOP\LGAUD.IRX"
164237   164251   0.0  0   "%geniml%\IOP\LIBSD.IRX"
164252   164302   0.0  0   "%geniml%\IOP\MCMAN.IRX"
164303   164306   0.0  0   "%geniml%\IOP\MCSERV.IRX"
164307   164310   0.0  0   "%geniml%\IOP\MSIFRPC.IRX"
164311   164316   0.0  0   "%geniml%\IOP\MTAPMAN.IRX"
164317   164339   0.0  0   "%geniml%\IOP\PADMAN.IRX"
164340   164340   0.0  0   "%geniml%\IOP\SCRTCHPD.IRX"
164341   164345   0.0  0   "%geniml%\IOP\SDRDRV.IRX"
164346   164348   0.0  0   "%geniml%\IOP\SIO2MAN.IRX"
164349   164416   0.0  0   "%geniml%\IOP\SYNTH_R.IRX"
164417   164433   0.0  0   "%geniml%\IOP\SYNTH_S.IRX"
164434   164451   0.0  0   "%geniml%\IOP\USBD.IRX"
164452   164458   0.0  0   "%geniml%\IOP\USBKB.IRX"
164459   166204   0.0  0   "%geniml%\OPGH_123.45"
166205   166205   0.0  0   "%geniml%\SYSTEM.CNF"
176447   176447   0.0  0   "%geniml%\patch.ims" 598016
[/LOC]
) > %geniml%"

:: optional scripts
echo Copying Scripts 2/4
(
echo @echo off
echo :: update files
echo.
echo rmdir /S /Q %dirset%
echo mkdir %dirset%
echo echo.
echo Downloading Resources...
echo echo.
echo curl -L https://github.com/Caserol23/opmgh2dx_patcher/archive/refs/heads/main.zip --output %dirset%
"%sevenz%" x %meyn% -o"%dirset%" -y
cd %dirset%
ren "%gitmain%" "%gitout%"
echo.
echo :: recompile files
mkdir %buildark%
echo "%arkhelper%" dir2ark "%buildark%" "%arkfolder%" -n MAIN -s 4073741823
echo
) > "%updaterecompile%"

echo Copying Scripts 3/4
(

) > "%addcustompatch%"

echo Copying Scripts 4/4
(

) > "%reinstall_patch%"
