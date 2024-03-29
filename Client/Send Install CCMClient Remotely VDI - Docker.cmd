@echo off

set source=%~dp0

setlocal ENABLEDELAYEDEXPANSION

if NOT exist %source%hosts.txt GOTO :ERROR

FOR /f "Tokens=*" %%x in (%source%hosts.txt) do call :TEST %%x

:TEST
::cls
set host=%1

if "%host%"=="" GOTO :FINISH
echo.======================================>>result.log
ping %host% -n 1 >> Result.log
if %errorlevel% == 0 goto :COPY
goto :Skip

:COPY
::echo. Copying client to %host%
MD \\%host%\c$\Temp
xcopy /e /c /i /g /h /r /y %source%Docker-Desktop-Installer.exe \\%host%\c$\Temp


echo
echo. Installing ON %host%...

:Install

%source%psexec.exe -d \\%host% c:\Temp\Docker-Desktop-Installer.exe uninstall --quiet
echo. %host% Installing... >> RESULT.log

goto :END

:ERROR
echo.
echo. HOSTS.TXT NOT FOUND
pause
goto :END

:FINISH
echo.
echo.================ FINISH ================>> result.log
echo. Finished
pause > nul
goto :END

:Skip
echo.%host% - not available. >> Result.log

:END@echo off

set source=%~dp0

setlocal ENABLEDELAYEDEXPANSION

if NOT exist %source%hosts.txt GOTO :ERROR

FOR /f "Tokens=*" %%x in (%source%hosts.txt) do call :TEST %%x

:TEST
::cls
set host=%1

if "%host%"=="" GOTO :FINISH
echo.======================================>>result.log
ping %host% -n 1 >> Result.log
if %errorlevel% == 0 goto :COPY
goto :Skip

:COPY
::echo. Copying client to %host%
MD \\%host%\c$\Temp\VDI-SCCM\Client
xcopy /e /c /i /g /h /r /y %Docker-Desktop-Installer.exe \\%host%\c$\windows


echo
echo. Installing ON %host%...

:Install

%source%psexec.exe -d \\%host% c:\windows\Docker-Desktop-Installer.exe uninstall --quiet

echo. %host% Installing... >> RESULT.log

goto :END

:ERROR
echo.
echo. HOSTS.TXT NOT FOUND
pause
goto :END

:FINISH
echo.
echo.================ FINISH ================>> result.log
echo. Finished
pause > nul
goto :END

:Skip
echo.%host% - not available. >> Result.log

:END