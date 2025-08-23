@echo off
title V7614 WinKill - Last Resort for stubborn PCs
color 0c

:MENU
cls
echo ================================
echo        V7614 WinKill v1.0
echo ================================
echo.
echo  THIS IS A LAST RESORT TOOL!
echo  Use with caution...
echo.
echo ================================
echo 1. Shutdown
echo 2. Restart
echo 3. Log off
echo 4. Kill Explorer.exe
echo 5. Restart Explorer.exe
echo 6. Kill ALL apps (force close)
echo 7. Exit
echo ================================
set /p choice=Choose an option (1-7): 

if "%choice%"=="1" goto CONFIRM_SHUTDOWN
if "%choice%"=="2" goto CONFIRM_RESTART
if "%choice%"=="3" goto CONFIRM_LOGOFF
if "%choice%"=="4" goto CONFIRM_KILL_EXPLORER
if "%choice%"=="5" goto RESTART_EXPLORER
if "%choice%"=="6" goto CONFIRM_KILL_ALL
if "%choice%"=="7" exit
goto MENU

:CONFIRM_SHUTDOWN
call :CONFIRM "Shutdown the system NOW"
if "%sure%"=="Y" shutdown /s /f /t 0
goto MENU

:CONFIRM_RESTART
call :CONFIRM "Restart the system NOW"
if "%sure%"=="Y" shutdown /r /f /t 0
goto MENU

:CONFIRM_LOGOFF
call :CONFIRM "Log off the current user"
if "%sure%"=="Y" shutdown /l
goto MENU

:CONFIRM_KILL_EXPLORER
call :CONFIRM "Kill explorer.exe (Taskbar, Start menu, desktop)"
if "%sure%"=="Y" taskkill /f /im explorer.exe
goto MENU

:RESTART_EXPLORER
start explorer.exe
goto MENU

:CONFIRM_KILL_ALL
call :CONFIRM "Kill ALL running apps (FORCE CLOSE EVERYTHING)"
if "%sure%"=="Y" taskkill /f /fi "STATUS eq RUNNING"
goto MENU

:CONFIRM
echo.
set /p sure=Are you sure you want to %~1? (Y/N): 
set sure=%sure:~0,1%
set sure=%sure:~0,1%
set sure=%sure:A=Y%
set sure=%sure:a=Y%
if /i not "%sure%"=="Y" set sure=N
exit /b
