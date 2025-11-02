@echo off
setlocal enabledelayedexpansion
for /r %%A in (songp.bat) do (
    pushd "%%~dpA"
	cls
    call songp.bat
    popd
    echo.
)
:: last
echo Update Finished
pause
