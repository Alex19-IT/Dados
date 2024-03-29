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
MD \\%host%\c$\windows\ccmsetup
xcopy /e /c /i /g /h /r /y %source%ccmsetup.exe \\%host%\c$\windows\ccmsetup


echo
echo. Installing ON %host%...

:Install

%source%psexec.exe -d \\%host% c:\windows\ccmsetup\CCMSETUP.exe /mp:https://BVSCMG.BVSNET.COM.BR/CCM_Proxy_MutualAuth/72057594037927992 CCMHOSTNAME=BVSCMG.BVSNET.COM.BR/CCM_Proxy_MutualAuth/72057594037927992 /NoCRLCheck SMSSiteCode=MEM

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