@echo off
setlocal enabledelayedexpansion

set "sngdir=%HomeDrive%\bin"
set "sngarksong=%sngdir%\_ark\songs"
set "sngarkconfig=%sngdir%\_ark\^(..^)\(^..^)\system\run\config"
set "sngarklocale=%sngdir%\_ark\ui\eng"
set "libstmp=%sngdir%\tmp"

for /d %%A in ("*") do (
echo Creating batch file in: %%~nxA
(
echo @echo off
echo set sngfolder=%sngarksong%\%%~nxA
echo set sngdta=%sngarkconfig%\sng.dta
echo set sngcampdta=%sngarkconfig%\sngcamp.dta
echo set authordta=%sngarklocale%\locale_authors.dta
echo set sngtxt=%libstmp%\%%~nxA\sng.txt
echo set sngcamptxt=%libstmp%\%%~nxA\camp.txt
echo set authortxt=%libstmp%\%%~nxA\auth.txt

echo.
echo if exist "%%sngfolder%%" (
echo ^ goto :print
echo ^) else (
echo ^ goto :install
echo ^)
echo.

echo :install
echo mkdir "%%sngfolder%%"
echo copy "%libstmp%\%%~nxA\%%~nxA.mid" "%%sngfolder%%"
echo copy "%libstmp%\%%~nxA\%%~nxA.vgs" "%%sngfolder%%"
echo copy "%libstmp%\%%~nxA\%%~nxA.voc" "%%sngfolder%%"
echo copy "%libstmp%\%%~nxA\%%~nxA_p60.vgs" "%%sngfolder%%"
echo copy "%libstmp%\%%~nxA\%%~nxA_p75.vgs" "%%sngfolder%%"
echo copy "%libstmp%\%%~nxA\%%~nxA_p90.vgs" "%%sngfolder%%"

echo.
echo findstr /C:"%%~nxA" %%sngdta%% %%sngcampdta%% %%authordta%% ^>nul
echo if %%errorlevel%%==0 (
echo ^ cls
echo ^ goto :print
echo ^ pause
echo ^) else (
echo ^ cls
echo ^ goto :installdta
echo ^ pause
echo ^)
echo.

echo :installdta
echo type %%sngtxt%% ^>^> %%sngdta%%
echo type %%sngcamptxt%% ^>^> %%sngcampdta%%
echo type %%authortxt%% ^>^> %%authordta%%
echo goto :eof

echo :print
echo echo Error "%%~nxA" has exist, installing ignored
echo pause
) > "%%A\songp.bat"
)
echo.
echo Done%% Batch files created in all subfolders.
pause
