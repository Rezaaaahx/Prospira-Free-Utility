:: ============================================================================
::  Prospira Free Utility
::  Copyright (C) 2025  p.rezaa
::
::  This program is free software: you can redistribute it and/or modify
::  it under the terms of the GNU General Public License as published by
::  the Free Software Foundation, either version 3 of the License, or
::  (at your option) any later version.
::
::  This program is distributed in the hope that it will be useful,
::  but WITHOUT ANY WARRANTY; without even the implied warranty of
::  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
::  GNU General Public License for more details.
::
::  You should have received a copy of the GNU General Public License
::  along with this program. If not, see https://www.gnu.org/licenses/
:: ============================================================================

set "titleprospira=Prospira Free Utility V0.1"
title %titleprospira%

set w=[97m >nul 2>&1
set g=[90m >nul 2>&1
set p=[95m >nul 2>&1
set b=[34m >nul 2>&1
set o=[1m >nul 2>&1
set b1=[38;5;45m >nul 2>&1
set r=[91m >nul 2>&1
set gg1=[92m >nul 2>&1
set y=[93m >nul 2>&1
set g2=[38;5;220m >nul 2>&1

@echo off
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b >nul 2>&1
cls

setlocal enabledelayedexpansion >nul 2>&1
reg add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d 1 /f >nul 2>&1
powershell "Set-ExecutionPolicy Unrestricted" >nul 2>&1

chcp 65001 >nul 2>&1

rmdir %SystemDrive%\Windows\system32\test >nul 2>&1
mkdir %SystemDrive%\Windows\system32\test >nul 2>&1

if %errorlevel% neq 1 (
    goto check_license_and_login  
) else ( 
    cls 
    chcp 437 >nul 2>&1
    powershell -NoProfile -NonInteractive -Command "try { $proc = Start-Process -FilePath '%~f0' -Verb RunAs -ArgumentList 'max' -PassThru -WindowStyle Maximized; exit 0 } catch { exit 1 }" >nul 2>&1
    if errorlevel 1 (
        chcp 65001 >nul 2>&1
        goto mainmenu1
    )
    exit
)

:check_license_and_login
cls

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).BuildNumber"') do set "build_number=%%a"
chcp 65001 >nul 2>&1

if !build_number! lss 22000 (
    goto unsupported_windows
)

echo.
echo.
echo.
echo.
echo.%b%                                                     ██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗███████╗    ██████╗ ███████╗███████╗███████╗███╗   ██╗██████╗ ███████╗██████╗ 
echo.%b%                                                     ██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║██╔════╝    ██╔══██╗██╔════╝██╔════╝██╔════╝████╗  ██║██╔══██╗██╔════╝██╔══██╗
echo.%b%                                                     ██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║███████╗    ██║  ██║█████╗  █████╗  █████╗  ██╔██╗ ██║██║  ██║█████╗  ██████╔╝
echo.%b%                                                     ██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║╚════██║    ██║  ██║██╔══╝  ██╔══╝  ██╔══╝  ██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗
echo.%b%                                                     ╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝███████║    ██████╔╝███████╗██║     ███████╗██║ ╚████║██████╔╝███████╗██║  ██║
echo.%b%                                                      ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚══════╝    ╚═════╝ ╚══════╝╚═╝     ╚══════╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                             %g%🛡️ Configuring Windows Defender Protection...%W%
echo.
echo.                                                                                 %gg1%⚙️ Adding script to Defender exclusion list to prevent false detection...%W%
echo.

chcp 437 >nul 2>&1
powershell -NoProfile -Command "try { Add-MpPreference -ExclusionPath '%~f0' -ErrorAction Stop; exit 0 } catch { exit 1 }" >nul 2>&1
set "exclusion_result=%errorlevel%"
chcp 65001 >nul 2>&1

if %exclusion_result% equ 0 (
    echo.                                                                                      %gg1%✔️ Script Successfully Added to Windows Defender Exclusion List!%W%
    echo.                                                                                       %g%Your system is now protected from false positive detections.%W%
) else (
    echo.                                                                                                  %r%❌ Could Not Add to Defender Exclusions%W%
    echo.
    echo.                                                              %g%• Windows Defender may be removed or completely disabled on this system.%W%
    echo.                                                              %g%• Group Policy restrictions may be preventing this action.%W%
    echo.                                                              %g%• Another antivirus program may be blocking the operation.%W%
)

echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                               %b%╔═══════════════════════════════════════════╗
echo.                                                                                               %b%║      %w% Press any key to continue... ➡️   %b%║
echo.                                                                                               %b%╚═══════════════════════════════════════════╝
pause >nul 2>&1

if not exist "%APPDATA%\ProspiraTweaks\license.dat" (
    goto show_license
) else (
    goto check_credentials
)

:unsupported_windows
cls
echo.
echo.
echo.
echo.
echo.%b%                                                                      ██╗   ██╗███╗   ██╗███████╗██╗   ██╗██████╗ ██████╗  ██████╗ ██████╗ ████████╗███████╗██████╗ 
echo.%b%                                                                      ██║   ██║████╗  ██║██╔════╝██║   ██║██╔══██╗██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔════╝██╔══██╗
echo.%b%                                                                      ██║   ██║██╔██╗ ██║███████╗██║   ██║██████╔╝██████╔╝██║   ██║██████╔╝   ██║   █████╗  ██║  ██║
echo.%b%                                                                      ██║   ██║██║╚██╗██║╚════██║██║   ██║██╔═══╝ ██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══╝  ██║  ██║
echo.%b%                                                                      ╚██████╔╝██║ ╚████║███████║╚██████╔╝██║     ██║     ╚██████╔╝██║  ██║   ██║   ███████╗██████╔╝
echo.%b%                                                                        ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═════╝ 
echo.                             
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%W%
echo.
echo.                                                                                                       %r%❌ UNSUPPORTED WINDOWS VERSION%W%
echo.
echo.                                                                                             %W%Prospira Free Utility requires Windows 11 or newer
echo.
echo.                                                                                                         %y%Your current build:%r%!build_number!%W%
echo.                                                                                                      %g%Required build:%gg1%22000 or higher%W%
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%W%
echo.
echo.                                                                                                            %g%💡 What you can do:%W%
echo.
echo.                                                                                                    %gg1%1. Upgrade to Windows 11 (recommended)
echo.                                                                                                    %W%2. Check for Windows updates
echo.                                                                                                    %W%3. Visit prospiratweaks.com for support
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%W%
echo.
echo.                                                                     %p%[%w%1%p%]%b1%Visit Prospira Website 🌐      %p%[%w%2%p%]%gg1%Windows 11 Upgrade Info 📚      %p%[%w%X%p%]%r%Exit Utility ❌
echo.
choice /c 12X /n >nul
if errorlevel 3 exit
if errorlevel 2 (
    start https://www.microsoft.com/en-us/software-download/windows11
    goto unsupported_windows
)
if errorlevel 1 (
    start https://prospiratweaks.com
    goto unsupported_windows
)

:show_license
cls
call :check_daily_usage
echo.
echo.
echo.
echo.
echo.%b%                                                                                      ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗
echo.%b%                                                                                      ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝
echo.%b%                                                                                      ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  
echo.%b%                                                                                      ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  
echo.%b%                                                                                      ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗
echo.%b%                                                                                       ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝
echo.                                                                                                                                                                                                                                
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                              %W%Prospira Free Utility – License and Legal Notice
echo.
echo.                                                                                   This program is free software: you can redistribute it and/or modify it
echo.                                                                                    under the terms of the GNU General Public License as published by the
echo.                                                                                Free Software Foundation, either version 3 of the License, or (at your option)
echo.                                                                                                              any later version.
echo.
echo.                                                                                     This program is distributed in the hope that it will be useful, but
echo.                                                                                  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
echo.                                                                                                     or FITNESS FOR A PARTICULAR PURPOSE.
echo.
echo.                                                                                              For official updates and community support, visit:
echo.                                                                                      %p%https://prospiratweaks.com   %b1%/   %p%https://discord.gg/EcEBEsjGkk
echo.
echo.                                                                                                  %p%© 2025 p.rezaa — Licensed under GPL-3.0%w%
echo.                           
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%   
echo.                                                                                                                    
echo.                                                                                   %p%[%w%Y%p%]%gg1%I Accept and Continue ✔️%b%          %p%[%w%N%p%]%r%I Decline and Exit ❌%b%                                                                                                                 
choice /c YN /n >nul 2>&1
if errorlevel 2 exit
if errorlevel 1 (
    call :unlock_achievement 1 
    call :save_license_acceptance
    goto check_credentials
)

:mainmenu1
cls
echo. 
echo. 
echo. 
echo.
echo.%b%                                                              ██████╗ ██████╗  ██████╗ ███████╗██████╗ ██╗██████╗  █████╗     ██╗   ██╗████████╗██╗██╗     ██╗████████╗██╗   ██╗
echo.%b%                                                              ██╔══██╗██╔══██╗██╔═══██╗██╔════╝██╔══██╗██║██╔══██╗██╔══██╗    ██║   ██║╚══██╔══╝██║██║     ██║╚══██╔══╝╚██╗ ██╔╝
echo.%b%                                                              ██████╔╝██████╔╝██║   ██║███████╗██████╔╝██║██████╔╝███████║    ██║   ██║   ██║   ██║██║     ██║   ██║    ╚████╔╝ 
echo.%b%                                                              ██╔═══╝ ██╔══██╗██║   ██║╚════██║██╔═══╝ ██║██╔══██╗██╔══██║    ██║   ██║   ██║   ██║██║     ██║   ██║     ╚██╔╝  
echo.%b%                                                              ██║     ██║  ██║╚██████╔╝███████║██║     ██║██║  ██║██║  ██║    ╚██████╔╝   ██║   ██║███████╗██║   ██║      ██║   
echo.%b%                                                              ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝     ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝   
echo.                                                                                                                                                         
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                       %b1%Prospira Utility%W%is%r%not running with administrator privileges!%W%
echo.
echo.                                                               %W%Please close this window and re-open the utility as administrator to ensure all optimizations apply correctly.
echo.                                           
echo.                                                                                                        %W%Press%p%X%w%to exit the program.                                     
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                   
echo.                                                                           %W%If running as admin still doesn’t work, press%p%U%w%to disable UAC, then restart your PC.           
echo.  
echo.                                                                                           %W%After reboot, launch the utility again as administrator.
echo.
echo.                                                                  %p%You are using the FREE Version of Prospira Free Utility — Unlock full performance at%b1%prospiratweaks.com%W%                    
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%

choice /c XU /n >nul
if errorlevel 2 (
    start https://learn.microsoft.com/en-us/answers/questions/3289894/disable-uac-using-the-registry
    goto mainmenu1
)
if errorlevel 1 exit
goto mainmenu1

:check_credentials
cls
if not exist "%APPDATA%\ProspiraTweaks" mkdir "%APPDATA%\ProspiraTweaks" 2>nul

if not exist "%APPDATA%\ProspiraTweaks\user_credentials.dat" (
    goto first_time_setup
) else (
    goto login_screen
)

:first_time_setup
chcp 65001 >nul 2>&1
cls
echo.
echo.
echo.
echo.
echo.%b%                                                                  ██████╗ ██████╗  ██████╗ ███████╗██████╗ ██╗██████╗  █████╗     ██╗      ██████╗  ██████╗ ██╗███╗   ██╗
echo.%b%                                                                  ██╔══██╗██╔══██╗██╔═══██╗██╔════╝██╔══██╗██║██╔══██╗██╔══██╗    ██║     ██╔═══██╗██╔════╝ ██║████╗  ██║
echo.%b%                                                                  ██████╔╝██████╔╝██║   ██║███████╗██████╔╝██║██████╔╝███████║    ██║     ██║   ██║██║  ███╗██║██╔██╗ ██║
echo.%b%                                                                  ██╔═══╝ ██╔══██╗██║   ██║╚════██║██╔═══╝ ██║██╔══██╗██╔══██║    ██║     ██║   ██║██║   ██║██║██║╚██╗██║
echo.%b%                                                                  ██║     ██║  ██║╚██████╔╝███████║██║     ██║██║  ██║██║  ██║    ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║
echo.%b%                                                                  ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝
echo.                                                                                                                                       
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                 %W%🎉 WELCOME TO%p%%titleprospira%%W%🎉%W%
echo.
echo.                                                                                            %W%This is your first time using Prospira Free Utility.
echo.                                                                                      %W%Please create your account to secure your optimization profile.
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                          %p%🔐 CREATE YOUR ACCOUNT%W%
echo.
set "new_username="
set "new_password="
set "confirm_password="

:input_new_username
<nul set /p "=%p%                                                              👤 Enter Username:%w%"
set /p "new_username="

if not defined new_username (
    echo.
    echo                                                               %r%❌ Username cannot be empty!%W%
    timeout /t 4 /nobreak >nul
    goto first_time_setup
)

chcp 437 >nul 2>&1
powershell -NoProfile -Command "if ('%new_username%' -match ' ') { exit 1 } else { exit 0 }" >nul 2>&1
set "space_check=%errorlevel%"
chcp 65001 >nul 2>&1

if "%space_check%"=="1" (
    echo.
    echo                                                               %r%❌ Username cannot contain spaces!%W%
    timeout /t 4 /nobreak >nul
    set "new_username="
    goto first_time_setup
)

:input_new_password
<nul set /p "=%p%                                                              🔒 Enter Password:%w%"

chcp 437 >nul 2>&1
for /f "usebackq delims=" %%a in (`powershell -NoProfile -Command "$pass = Read-Host -AsSecureString; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass))"`) do set "new_password=%%a"
chcp 65001 >nul 2>&1

if not defined new_password (
    echo.
    echo                                                               %r%❌ Password cannot be empty!%W%
    timeout /t 4 /nobreak >nul
    goto first_time_setup
)

chcp 437 >nul 2>&1
powershell -NoProfile -Command "if ('%new_password%' -match ' ') { exit 1 } else { exit 0 }" >nul 2>&1
set "space_check=%errorlevel%"
chcp 65001 >nul 2>&1

if "%space_check%"=="1" (
    echo.
    echo                                                               %r%❌ Password cannot contain spaces!%W%
    timeout /t 4 /nobreak >nul
    set "new_password="
    goto first_time_setup
)

:input_confirm_password
<nul set /p "=%p%                                                              🔐 Retype Password:%w%"

chcp 437 >nul 2>&1
for /f "usebackq delims=" %%a in (`powershell -NoProfile -Command "$pass = Read-Host -AsSecureString; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass))"`) do set "confirm_password=%%a"
chcp 65001 >nul 2>&1

if not defined confirm_password (
    echo.
    echo                                                               %r%❌ Password cannot be empty!%W%
    timeout /t 4 /nobreak >nul
    goto first_time_setup
)

if not "!new_password!"=="!confirm_password!" (
    echo.
    echo                                                               %r%❌ Passwords do not match! Please try again.%W%
    timeout /t 4 /nobreak >nul
    set "new_password="
    set "confirm_password="
    goto first_time_setup
)

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$pass='!new_password!'; $bytes=[System.Text.Encoding]::UTF8.GetBytes($pass); $hash=[System.Security.Cryptography.SHA256]::Create().ComputeHash($bytes); [System.BitConverter]::ToString($hash).Replace('-','')"') do set "hashed_password=%%a"
chcp 65001 >nul 2>&1

>"%APPDATA%\ProspiraTweaks\user_credentials.dat" echo !new_username!
>>"%APPDATA%\ProspiraTweaks\user_credentials.dat" echo !hashed_password!

echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                      %gg1%✅ ACCOUNT CREATED SUCCESSFULLY!%W%
echo.
echo.                                                                                                 %W%Your credentials have been securely saved.
echo.                                                                                            %W%You can now log in to access Prospira Free Utility.
echo.
echo.                                                                                               %b%╔═══════════════════════════════════════════╗
echo.                                                                                               %b%║      %w% Press any key to continue... ➡️   %b%║
echo.                                                                                               %b%╚═══════════════════════════════════════════╝
pause >nul 2>&1
goto login_screen

set "login_attempts=0"

:login_screen
chcp 65001 >nul 2>&1
cls
echo.
echo.
echo.
echo.
echo.%b%                                                                       ██╗      ██████╗  ██████╗ ██╗███╗   ██╗    ███████╗ ██████╗██████╗ ███████╗███████╗███╗   ██╗
echo.%b%                                                                       ██║     ██╔═══██╗██╔════╝ ██║████╗  ██║    ██╔════╝██╔════╝██╔══██╗██╔════╝██╔════╝████╗  ██║
echo.%b%                                                                       ██║     ██║   ██║██║  ███╗██║██╔██╗ ██║    ███████╗██║     ██████╔╝█████╗  █████╗  ██╔██╗ ██║
echo.%b%                                                                       ██║     ██║   ██║██║   ██║██║██║╚██╗██║    ╚════██║██║     ██╔══██╗██╔══╝  ██╔══╝  ██║╚██╗██║
echo.%b%                                                                       ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║    ███████║╚██████╗██║  ██║███████╗███████╗██║ ╚████║
echo.%b%                                                                       ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝
echo.                                                                                                                           
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                         %p%🔐 LOG IN TO YOUR ACCOUNT%W%
echo.
echo.                                                                                           %W%Please enter your credentials to access the utility.
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.  
set "stored_username="
set "stored_password_hash="
set "line_number=0"

for /f "usebackq tokens=*" %%a in ("%APPDATA%\ProspiraTweaks\user_credentials.dat") do (
    set /a line_number+=1
    if !line_number! equ 1 set "stored_username=%%a"
    if !line_number! equ 2 set "stored_password_hash=%%a"
)

set "input_username="
set "input_password="

:login_attempt
if !login_attempts! geq 3 (
    echo.
    echo.                                                                                                        %r%❌ TOO MANY FAILED ATTEMPTS!%W%
    echo.
    echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
    echo.
    echo.                                                                                      %p%[%w%R%p%]%y%Reset Password 🔄%w%                  %p%[%w%X%p%]%r%Exit Utility ❌%w%
    echo.
    choice /c RX /n >nul
    if errorlevel 2 exit
    if errorlevel 1 goto reset_password
)

echo.
set /p "input_username=%p%                                                              👤 Username:%w%"

<nul set /p "=%p%                                                              🔐 Password:%w%"
chcp 437 >nul 2>&1
for /f "usebackq delims=" %%a in (`powershell -NoProfile -Command "$pass = Read-Host -AsSecureString; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass))"`) do set "input_password=%%a"
chcp 65001 >nul 2>&1

if not defined input_username (
    set /a login_attempts+=1
    echo.
    echo.                                                              %r%❌ Invalid username or password%W%
    echo.                                                              %r%Login attempts: !login_attempts!/3%W%
    set "input_username="
    set "input_password="
    if !login_attempts! lss 3 (
        timeout /t 4 /nobreak >nul
        goto login_screen
    )
    goto login_attempt
)

if not defined input_password (
    set /a login_attempts+=1
    echo.
    echo.                                                              %r%❌ Invalid username or password%W%
    echo.                                                              %r%Login attempts: !login_attempts!/3%W%
    set "input_username="
    set "input_password="
    if !login_attempts! lss 3 (
        timeout /t 4 /nobreak >nul
        goto login_screen
    )
    goto login_attempt
)

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$pass='!input_password!'; $bytes=[System.Text.Encoding]::UTF8.GetBytes($pass); $hash=[System.Security.Cryptography.SHA256]::Create().ComputeHash($bytes); [System.BitConverter]::ToString($hash).Replace('-','')"') do set "input_password_hash=%%a"
chcp 65001 >nul 2>&1

if "!input_username!"=="!stored_username!" (
    if "!input_password_hash!"=="!stored_password_hash!" (
        echo.
        echo.                                                              %gg1%✅ LOGIN SUCCESSFUL!%W%
        echo.                                                              %g%Welcome back,%p%!input_username!%g%!👋%W%
        call :check_daily_usage
        timeout /t 2 /nobreak >nul
        goto restorepoint
    )
)

set /a login_attempts+=1
echo.
echo.                                                              %r%❌ Invalid username or password%W%
echo.                                                              %r%Login attempts: !login_attempts!/3%W%
set "input_username="
set "input_password="
if !login_attempts! lss 3 (
    timeout /t 4 /nobreak >nul
    goto login_screen
)
goto login_attempt

:reset_password
cls
echo.
echo.
echo.
echo.
echo.%b%                                                              ██████╗ ███████╗███████╗███████╗████████╗    ██████╗  █████╗ ███████╗███████╗██╗    ██╗ ██████╗ ██████╗ ██████╗ 
echo.%b%                                                              ██╔══██╗██╔════╝██╔════╝██╔════╝╚══██╔══╝    ██╔══██╗██╔══██╗██╔════╝██╔════╝██║    ██║██╔═══██╗██╔══██╗██╔══██╗
echo.%b%                                                              ██████╔╝█████╗  ███████╗█████╗     ██║       ██████╔╝███████║███████╗███████╗██║ █╗ ██║██║   ██║██████╔╝██║  ██║
echo.%b%                                                              ██╔══██╗██╔══╝  ╚════██║██╔══╝     ██║       ██╔═══╝ ██╔══██║╚════██║╚════██║██║███╗██║██║   ██║██╔══██╗██║  ██║
echo.%b%                                                              ██║  ██║███████╗███████║███████╗   ██║       ██║     ██║  ██║███████║███████║╚███╔███╔╝╚██████╔╝██║  ██║██████╔╝
echo.%b%                                                              ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝ 
echo.                                                                                                                                                 
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                         %y%🔐 PASSWORD RESET UTILITY%W%
echo.
echo.                                                                                             %W%This will reset your password and create a new one
echo.                                                                                            %r%Your current credentials will be permanently deleted!%W%
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                   %p%[%w%C%p%]%y%Continue with Reset 🔄%w%                  %p%[%w%B%p%]%gg1%Back to Login 🔒%w%
echo.
choice /c CB /n >nul
if errorlevel 2 (
    set "login_attempts=0"
    goto login_screen
)
if errorlevel 1 (
    del "%APPDATA%\ProspiraTweaks\user_credentials.dat" >nul 2>&1
    echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
    echo.
    echo.                                                                                                        %gg1%✅ PASSWORD RESET SUCCESSFUL!%W%
    echo.
    echo.                                                                                                 %W%Your password has been successfully reset.
    echo.                                                                                                     %W%You can now create a new account.
    echo.
    echo.                                                                                               %b%╔═══════════════════════════════════════════╗
    echo.                                                                                               %b%║      %w% Press any key to continue... ➡️   %b%║
    echo.                                                                                               %b%╚═══════════════════════════════════════════╝
    pause >nul 2>&1
    set "login_attempts=0"
    goto first_time_setup
)

:restorepoint
cls
echo.
echo.
echo.
echo.                                                
echo.%b%                                                                     ██████╗ ███████╗███████╗████████╗ ██████╗ ██████╗ ███████╗    ██████╗  ██████╗ ██╗███╗   ██╗████████╗
echo.%b%                                                                     ██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝    ██╔══██╗██╔═══██╗██║████╗  ██║╚══██╔══╝
echo.%b%                                                                     ██████╔╝█████╗  ███████╗   ██║   ██║   ██║██████╔╝█████╗      ██████╔╝██║   ██║██║██╔██╗ ██║   ██║   
echo.%b%                                                                     ██╔══██╗██╔══╝  ╚════██║   ██║   ██║   ██║██╔══██╗██╔══╝      ██╔═══╝ ██║   ██║██║██║╚██╗██║   ██║   
echo.%b%                                                                     ██║  ██║███████╗███████║   ██║   ╚██████╔╝██║  ██║███████╗    ██║     ╚██████╔╝██║██║ ╚████║   ██║   
echo.%b%                                                                     ╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚═╝      ╚═════╝ ╚═╝╚═╝  ╚═══╝   ╚═╝   
echo.                                                                                                                                                                                                                
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w% 
echo.     
echo.                                                                                                 %w%Would you like to Create a Restore Point?                                 
echo.                                                                                                                                                                 
echo.                                                                                                                                                                 
echo.                                                                          %p%[%w%1%p%]%w%Create Restore Point 💾                                 %p%[%w%2%p%]%w%Skip This Step ⏩
echo.
echo.                                                                                                                                                                 
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.                                                                                     %W%Restore points let you revert your PC to its previous optimized state         
echo.                                                                                          %W%You can easily undo tweaks made by Prospira anytime you wish 
echo.
echo.                                                                  %p%You are using the FREE Version of Prospira Free Utility — Unlock full performance at%b1%prospiratweaks.com%W%              
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo. 
choice /c 12 /n >nul
if errorlevel 2 goto downloadresources
if errorlevel 1 goto createrestorepoint

:createrestorepoint
cls 
echo.
echo.
echo.
echo.
echo.%b%                                                                     ██████╗ ███████╗███████╗████████╗ ██████╗ ██████╗ ███████╗    ██████╗  ██████╗ ██╗███╗   ██╗████████╗
echo.%b%                                                                     ██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝    ██╔══██╗██╔═══██╗██║████╗  ██║╚══██╔══╝
echo.%b%                                                                     ██████╔╝█████╗  ███████╗   ██║   ██║   ██║██████╔╝█████╗      ██████╔╝██║   ██║██║██╔██╗ ██║   ██║   
echo.%b%                                                                     ██╔══██╗██╔══╝  ╚════██║   ██║   ██║   ██║██╔══██╗██╔══╝      ██╔═══╝ ██║   ██║██║██║╚██╗██║   ██║   
echo.%b%                                                                     ██║  ██║███████╗███████║   ██║   ╚██████╔╝██║  ██║███████╗    ██║     ╚██████╔╝██║██║ ╚████║   ██║   
echo.%b%                                                                     ╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚═╝      ╚═════╝ ╚═╝╚═╝  ╚═══╝   ╚═╝ 
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                        %g%Creating a Restore Point 💾%W%   

chcp 437 >nul 2>&1
powershell -NoProfile -Command "Enable-ComputerRestore -Drive '%SystemDrive%'" >nul 2>&1
chcp 65001 >nul 2>&1

reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "RPSessionInterval" /f  >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "DisableConfig" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1

chcp 437 >nul 2>&1
powershell -Command "Checkpoint-Computer -Description 'Prospira Free Utility'" >nul 2>&1
chcp 65001 >nul 2>&1
if errorlevel 1 (
    echo.
    echo.                                                                                                     %r%Failed%W%to Create Restore Point...%W%                                            
    echo.
    echo.                                                                                              %b%╔════════════════════════════════════════════╗
    echo.                                                                                              %b%║     %w% Press any key to continue... ➡️     %b%║
    echo.                                                                                              %b%╚════════════════════════════════════════════╝
    pause >nul 2>&1
) else (
    echo.
    echo.                                                                                                   %W%Restore Point Created%gg1%Successfully...%W%                                          
    call :unlock_achievement 4
    echo.                                                                                              %b%╔════════════════════════════════════════════╗
    echo.                                                                                              %b%║      %w% Press any key to continue... ➡️    %b%║
    echo.                                                                                              %b%╚════════════════════════════════════════════╝
    pause >nul 2>&1
)
cls
goto downloadresources

:downloadresources
cls
echo.
echo.
echo. 
echo.
echo.%b%                                           ██████╗  ██████╗ ██╗    ██╗███╗   ██╗██╗      ██████╗  █████╗ ██████╗     ██████╗ ███████╗███████╗ ██████╗ ██╗   ██╗██████╗  ██████╗███████╗███████╗
echo.%b%                                           ██╔══██╗██╔═══██╗██║    ██║████╗  ██║██║     ██╔═══██╗██╔══██╗██╔══██╗    ██╔══██╗██╔════╝██╔════╝██╔═══██╗██║   ██║██╔══██╗██╔════╝██╔════╝██╔════╝
echo.%b%                                           ██║  ██║██║   ██║██║ █╗ ██║██╔██╗ ██║██║     ██║   ██║███████║██║  ██║    ██████╔╝█████╗  ███████╗██║   ██║██║   ██║██████╔╝██║     █████╗  ███████╗
echo.%b%                                           ██║  ██║██║   ██║██║███╗██║██║╚██╗██║██║     ██║   ██║██╔══██║██║  ██║    ██╔══██╗██╔══╝  ╚════██║██║   ██║██║   ██║██╔══██╗██║     ██╔══╝  ╚════██║
echo.%b%                                           ██████╔╝╚██████╔╝╚███╔███╔╝██║ ╚████║███████╗╚██████╔╝██║  ██║██████╔╝    ██║  ██║███████╗███████║╚██████╔╝╚██████╔╝██║  ██║╚██████╗███████╗███████║
echo.%b%                                           ╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝     ╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝╚══════╝                                                                                                                                                                                                                                                               
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                       %g%Checking Required Resources...%W%
echo.

set "resource_path=%SystemDrive%\Prospira Tweaks Free Utility Resources"
set "nsudo_path=%resource_path%\NSudo.exe"
set "nsudo_url=https://github.com/Rezaaaahx/Prospira-Free-Utility-Res/releases/download/Windows/NSudo.exe"

if not exist "%resource_path%" (
    mkdir "%resource_path%" >nul 2>&1
    echo.                                                              %gg1%✔️ Created Resource Directory%W%
) else (
    echo.                                                              %gg1%✔️ Resource Directory Exists%W%
)

echo.
if exist "%nsudo_path%" (
    echo.                                                              %gg1%✔️ NSudo.exe Found%W%
    echo.                                                              %p%📍 Location:%w%%nsudo_path%
    echo.
    echo.                                                              %y%⚠️ NSudo already exists. Skip download?%W%
    echo.
    echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
    echo.
    echo.                                                                                      %p%[%w%S%p%]%gg1%Skip Download ⏩%w%                    %p%[%w%R%p%]%y%Re-download 🔄%w%
    choice /c SR /n >nul
    if errorlevel 2 goto redownload_nsudo
    if errorlevel 1 goto download_complete
) else (
    echo.                                                              %y%⚠️ NSudo.exe Not Found%W%
    echo.                                                              %g%📥 Preparing to download...%W%
    timeout /t 1 /nobreak >nul 2>&1
    goto download_nsudo
)

:redownload_nsudo
cls
echo.
echo.
echo.
echo.
echo.%b%                                            ██████╗  ██████╗ ██╗    ██╗███╗   ██╗██╗      ██████╗  █████╗ ██████╗     ██████╗ ███████╗███████╗ ██████╗ ██╗   ██╗██████╗  ██████╗███████╗███████╗
echo.%b%                                            ██╔══██╗██╔═══██╗██║    ██║████╗  ██║██║     ██╔═══██╗██╔══██╗██╔══██╗    ██╔══██╗██╔════╝██╔════╝██╔═══██╗██║   ██║██╔══██╗██╔════╝██╔════╝██╔════╝
echo.%b%                                            ██║  ██║██║   ██║██║ █╗ ██║██╔██╗ ██║██║     ██║   ██║███████║██║  ██║    ██████╔╝█████╗  ███████╗██║   ██║██║   ██║██████╔╝██║     █████╗  ███████╗
echo.%b%                                            ██║  ██║██║   ██║██║███╗██║██║╚██╗██║██║     ██║   ██║██╔══██║██║  ██║    ██╔══██╗██╔══╝  ╚════██║██║   ██║██║   ██║██╔══██╗██║     ██╔══╝  ╚════██║
echo.%b%                                            ██████╔╝╚██████╔╝╚███╔███╔╝██║ ╚████║███████╗╚██████╔╝██║  ██║██████╔╝    ██║  ██║███████╗███████║╚██████╔╝╚██████╔╝██║  ██║╚██████╗███████╗███████║
echo.%b%                                            ╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝     ╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝╚══════╝   
echo.                                                                                                                                                                                                                                      
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                     %y%Re-downloading NSudo.exe...%W%
echo.                                                              %p%🌐 Source:%w%GitHub
echo.                                                              %p%📦 File:%w%NSudo.exe
echo.                                                              %p%💾 Destination:%w%%resource_path%
echo.

if not exist "%resource_path%" mkdir "%resource_path%" 2>nul 1>&2

del "%nsudo_path%" >nul 2>&1
set "delete_result=%errorLevel%"
if %delete_result% equ 0 (
    echo.                                                              %gg1%✔️ Previous NSudo.exe Deleted Successfully.%W%
) else (
    echo.                                                              %y%⚠️ Previous NSudo.exe Deletion Failed or File Not Found.%W%
)
chcp 437 >nul 2>&1
powershell -Command "(New-Object Net.WebClient).DownloadFile('%nsudo_url%', '%nsudo_path%')" >nul 2>&1
set "download_result=%errorLevel%"
chcp 65001 >nul 2>&1
if %download_result% equ 0 (
    if exist "%nsudo_path%" (
        echo.
        echo.                                                              %gg1%✔️ NSudo.exe Re-downloaded Successfully!%W%
        chcp 437 >nul 2>&1
        set "file_size=N/A"
        for /f "tokens=*" %%a in ('powershell -NoProfile -Command "try { $file = Get-Item '%nsudo_path%' -ErrorAction Stop; '{0:N2} MB' -f ($file.Length/1MB) } catch { 'N/A' }"') do set "file_size=%%a"
        chcp 65001 >nul 2>&1
        
        echo.                                                              %p%📊 File Size:%w%!file_size!
        goto download_complete
    ) else (
        echo.
        echo.                                                              %r%❌ Download verification failed%W%
        goto download_failed
    )
) else (
    goto download_failed
)
pause >nul 2>&1

:download_nsudo
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                          %g%Downloading NSudo.exe...%W%
echo.
echo.                                                              %p%🌐 Source:%w%GitHub
echo.                                                              %p%📦 File:%w%NSudo.exe
echo.                                                              %p%💾 Destination:%w%%resource_path%
chcp 437 >nul 2>&1
powershell -Command "(New-Object Net.WebClient).DownloadFile('%nsudo_url%', '%nsudo_path%')" >nul 2>&1
set "download_result=%errorLevel%"
chcp 65001 >nul 2>&1

if %download_result% equ 0 (
    if exist "%nsudo_path%" (
        echo.
        echo.                                                              %gg1%✔️ NSudo.exe Downloaded Successfully!%W%
        
        chcp 437 >nul 2>&1
        for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$file = Get-Item '%nsudo_path%'; '{0:N2} MB' -f ($file.Length/1MB)"') do set "file_size=%%a"
        chcp 65001 >nul 2>&1
        
        echo.                                                              %p%📊 File Size:%w%!file_size!
    ) else (
        echo.
        echo.                                                              %r%❌ Download verification failed%W%
        goto download_failed
    )
) else (
    :download_failed
    echo.
    echo.                                                              %r%❌ Download Failed!%W%
    echo.
    echo.                                                              %y%⚠️ Possible reasons:%W%
    echo.                                                              %w%• No internet connection
    echo.                                                              %w%• GitHub servers unavailable
    echo.                                                              %w%• Antivirus blocking download
    echo.                                                              %w%• Insufficient permissions
    echo.                                                              %w%• The path to the folder does not exist.
    echo.
    echo.                                                              %p%💡 You can manually download from:%W%
    echo.                                                              %b1%%nsudo_url%%W%
    echo.
    echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
    echo.
    echo.                                                              %p%[%w%R%p%]%y%Retry Download 🔄%w%                  %p%[%w%M%p%]%gg1%Return to Main Menu 🏠%w%                 %p%[%w%X%p%]%r%Exit Utility ❌%w%
    echo.
    choice /c RMX /n >nul
    if errorlevel 3 exit
    if errorlevel 2 goto skiprestorepoint
    if errorlevel 1 goto download_nsudo
)

:download_complete
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                         %gg1%✔️ All Resources Ready%W%
echo.
echo.                                                              %g%📋 Resource Summary:%W%
echo.                                                              %w%• NSudo.exe - Tool for elevated execution
echo.                                                              %w%• Location:%p%%resource_path%%w%
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                      %p%[%w%M%p%]%gg1%Go to Main Menu 🏠%w%                %p%[%w%X%p%]%r%Exit Utility ❌%w%
echo.
choice /c MX /n >nul
if errorlevel 2 exit
if errorlevel 1 goto skiprestorepoint

:skiprestorepoint
cls
echo.
echo.
echo.
echo.
echo.%b%                                                                      ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗    ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
echo.%b%                                                                      ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝    ████╗ ████║██╔════╝████╗  ██║██║   ██║
echo.%b%                                                                         ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗    ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
echo.%b%                                                                         ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║    ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
echo.%b%                                                                         ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║    ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
echo.%b%                                                                         ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ 
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                         %g%Version:%p%0.1%b1%Free Edition
echo.                                                                                                         %g%Last Update:%p%November 2025%W%
echo.                                                                                                             %g%Developer:%p%p.rezaa%W%                              
echo.
echo.                                                                  %p%You are using the FREE Version of Prospira Free Utility — Unlock full performance at%b1%prospiratweaks.com%W%
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                          %p%[%w%1%p%]%w%BCDedit Tweaks ⚙️                                    %p%[%w%2%p%]%w%Privacy Tweaks 🔒
echo.
echo.                                                                          %p%[%w%3%p%]%w%Performance Tweaks 🚀                                %p%[%w%4%p%]%w%Network Tweaks 🌐
echo.
echo.                                                                          %p%[%w%5%p%]%w%Visual Effects Tweaks 🎨                             %p%[%w%6%p%]%w%Disable Services ⚡
echo.
echo.                                                                          %p%[%w%7%p%]%w%Additional Tweaks 🛠️                                
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                          %p%[%w%U%p%]%b1%Prospira Website 🌐%w%                                 %p%[%w%C%p%]%b1%Create Restore Point 💾%w%
echo.                                                                          %p%[%w%R%p%]%b1%Revert All Tweaks 🔄%w%                                %p%[%w%I%p%]%b1%System Info ℹ️%w%
echo.                                                                          %p%[%w%A%p%]%y%Achievements 🏆%w%                                     %p%[%w%X%p%]%r%Exit Utility ❌%w%
echo.                                                             
choice /c 1234567URXICA /n >nul
if errorlevel 13 goto achievements                                           
if errorlevel 12 goto createrestorepointmain
if errorlevel 11 goto systeminfo
if errorlevel 10 exit
if errorlevel 9 goto revertall
if errorlevel 8 goto prospiraweb
if errorlevel 7 goto additionaltweaks
if errorlevel 6 goto disableservices
if errorlevel 5 goto visualeffects
if errorlevel 4 goto networktweaks
if errorlevel 3 goto performancetweaks
if errorlevel 2 goto privacytweaks
if errorlevel 1 goto bcdedittweaks

:bcdedittweaks
cls
echo.
echo.
echo.
echo.
echo.%b%                                                                ██████╗  ██████╗██████╗ ███████╗██████╗ ██╗████████╗    ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗
echo.%b%                                                                ██╔══██╗██╔════╝██╔══██╗██╔════╝██╔══██╗██║╚══██╔══╝    ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝
echo.%b%                                                                ██████╔╝██║     ██║  ██║█████╗  ██║  ██║██║   ██║          ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗
echo.%b%                                                                ██╔══██╗██║     ██║  ██║██╔══╝  ██║  ██║██║   ██║          ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║
echo.%b%                                                                ██████╔╝╚██████╗██████╔╝███████╗██████╔╝██║   ██║          ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║
echo.%b%                                                                ╚═════╝  ╚═════╝╚═════╝ ╚══════╝╚═════╝ ╚═╝   ╚═╝          ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ 
echo.                                                                                                                                            
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                         %g%Applying BCDedit Tweaks...%W%
echo.
set success_count=0
set total_count=6

bcdedit /set linearaddress57 OptOut >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ linearaddress57 OptOut%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ linearaddress57 OptOut
)

bcdedit /set vm No >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ vm No%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ vm No
)

bcdedit /set nx AlwaysOff >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ nx AlwaysOff%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ nx AlwaysOff
)

bcdedit /set disabledynamictick yes >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ disabledynamictick yes%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ disabledynamictick yes
)

bcdedit /set bootux disabled >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ bootux disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ bootux disabled
)

bcdedit /set tscsyncpolicy enhanced >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ tscsyncpolicy enhanced%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ tscsyncpolicy enhanced
)

echo.
if %success_count% equ %total_count% (
    echo.                                                                                                   %gg1%✔️ BCDedit Tweaks Applied Successfully!%W%
    call :unlock_achievement 2
) else if %success_count% equ 0 (
    echo.                                                                                                  %r%❌ No BCDedit Settings Have Been Applied!%W%
) else (
    echo.                                                                                               %y%⚠️ Only %success_count%/%total_count% BCDedit Settings Have Been Applied!%W%
    call :unlock_achievement 2
)
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                              %p%[%w%C%p%]%gg1%Continue to Privacy Tweaks 🔒             %p%[%w%X%p%]%r%Exit Utility ❌            %p%[%w%M%p%]%y%Return to Main Menu 🏠
echo. 
call :mark_tweak_done 1 
call :check_all_tweaks_done                                                                                               
choice /c CMX /n >nul
if errorlevel 3 exit
if errorlevel 2 goto skiprestorepoint
if errorlevel 1 goto privacytweaks

:privacytweaks
cls
echo.
echo.
echo.
echo.
echo.%b%                                                                ██████╗ ██████╗ ██╗██╗   ██╗ █████╗  ██████╗██╗   ██╗    ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗
echo.%b%                                                                ██╔══██╗██╔══██╗██║██║   ██║██╔══██╗██╔════╝╚██╗ ██╔╝    ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝
echo.%b%                                                                ██████╔╝██████╔╝██║██║   ██║███████║██║      ╚████╔╝        ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗
echo.%b%                                                                ██╔═══╝ ██╔══██╗██║╚██╗ ██╔╝██╔══██║██║       ╚██╔╝         ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║
echo.%b%                                                                ██║     ██║  ██║██║ ╚████╔╝ ██║  ██║╚██████╗   ██║          ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║
echo.%b%                                                                ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝  ╚═╝ ╚═════╝   ╚═╝          ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
echo.                                                                                                                                                                                                                                                                                 
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                         %g%Applying Privacy Tweaks...%W%
echo.
set success_count=0
set total_count=20

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Telemetry Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Telemetry Failed
)

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Windows Tips Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Windows Tips Failed
)

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Windows Spotlight Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Windows Spotlight Failed
)

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Shared Experiences Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Shared Experiences Failed
)

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Tailored Experiences Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Tailored Experiences Failed
)

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Search History Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Search History Failed
)

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Device History Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Device History Failed
)

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Bing Search Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Bing Search Failed
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Activity Feed Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Activity Feed Failed
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Location Services Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Location Services Failed
)

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Advertising ID Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Advertising ID Failed
)

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ App Diagnostics Access Denied%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ App Diagnostics Failed
)

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Broad File System Access Denied%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ File System Access Failed
)

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Notifications Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Notifications Failed
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Error Reporting Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Error Reporting Failed
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Windows Insider Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Windows Insider Failed
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Feedback Notifications Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Feedback Notifications Failed
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Handwriting Data Sharing Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Handwriting Data Failed
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Sample Submission Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Sample Submission Failed
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Cloud Consumer Features Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Cloud Content Failed
)

echo.
if %success_count% equ %total_count% (
    echo.                                                                                                   %gg1%✔️ Privacy Tweaks Applied Successfully!%W%
) else if %success_count% equ 0 (
    echo.                                                                                                  %r%❌ No Privacy Settings Have Been Applied!%W%
) else (
    echo.                                                                                              %y%⚠️ Only %success_count%/%total_count% Privacy Settings Have Been Applied!%W%
)
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                              %p%[%w%C%p%]%gg1%Continue to Performance Tweaks 🚀           %p%[%w%X%p%]%r%Exit Utility ❌          %p%[%w%M%p%]%y%Return to Main Menu 🏠
echo. 
call :mark_tweak_done 2  
call :check_all_tweaks_done                                                                                              
choice /c CMX /n >nul
if errorlevel 3 exit
if errorlevel 2 goto skiprestorepoint
if errorlevel 1 goto performancetweaks

:performancetweaks
cls
echo.
echo.
echo.
echo.
echo.%b%                                           ██████╗ ███████╗██████╗ ███████╗ ██████╗ ██████╗ ███╗   ███╗ █████╗ ███╗   ██╗ ██████╗███████╗    ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗
echo.%b%                                           ██╔══██╗██╔════╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗████╗ ████║██╔══██╗████╗  ██║██╔════╝██╔════╝    ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝
echo.%b%                                           ██████╔╝█████╗  ██████╔╝█████╗  ██║   ██║██████╔╝██╔████╔██║███████║██╔██╗ ██║██║     █████╗         ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗
echo.%b%                                           ██╔═══╝ ██╔══╝  ██╔══██╗██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║██╔══██║██║╚██╗██║██║     ██╔══╝         ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║
echo.%b%                                           ██║     ███████╗██║  ██║██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╗███████╗       ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║
echo.%b%                                           ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝       ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
echo.                                                                                                                                                                                              
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                       %g%Applying Performance Tweaks...%W%
echo.
set success_count=0
set total_count=24

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 0x00000018 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Win32 Priority Separation Set%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Win32 Priority Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Large System Cache Enabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Large System Cache Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Fast Startup Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Fast Startup Failed
)

powercfg /h off >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Hibernation Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Hibernation Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Sleep Study Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Sleep Study Failed
)

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Automatic Maintenance Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Automatic Maintenance Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Paging Executive Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Paging Executive Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Contiguous Memory Allocation Enabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Contiguous Memory Failed
)

reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Fault Tolerant Heap Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ FTH Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ ASLR Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ ASLR Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Power Throttling Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Power Throttling Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Hardware-Accelerated GPU Scheduling Enabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ HAGS Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Timer Distribution Enabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Timer Distribution Failed
)

reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Game Mode Enabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Game Mode Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDr" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ GPU Energy Driver Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ GPU Energy Driver Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Energy Logging Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Energy Logging Failed
)

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ MMCSS Configured%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ MMCSS Failed
)

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "10" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ System Responsiveness Optimized%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ System Responsiveness Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "Latency" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "TransitionLatency" /t REG_DWORD /d 1 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Latency Tolerance Configured%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Latency Tolerance Failed
)

reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\HardCap0" /v "CapPercentage" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\HardCap0" /v "SchedulingType" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\Paused" /v "CapPercentage" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\Paused" /v "SchedulingType" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapFull" /v "CapPercentage" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapFull" /v "SchedulingType" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapLow" /v "CapPercentage" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapLow" /v "SchedulingType" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Resource Policies Optimized%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Resource Policies Failed
)

reg delete "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /f >nul 2>&1
reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "VRROptimizeEnable=0;SwapEffectUpgradeEnable=1;" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ FSE Enabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ FSE Failed
)

reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Windows Experiments Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Windows Experiments Failed
)

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ CSRSS Priority Optimized%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ CSRSS Priority Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "PassiveIntRealTimeWorkerPriority" /t REG_DWORD /d "18" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\KernelVelocity" /v "DisableFGBoostDecay" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\audiodg.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\audiodg.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Service Priorities Optimized%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Service Priorities Failed
)
echo.
if %success_count% equ %total_count% (
    echo.                                                                                             %gg1%✔️ System Performance Tweaks Applied Successfully!%W%
) else if %success_count% equ 0 (
    echo.                                                                                            %r%❌ No System Performance Settings Have Been Applied!%W%
) else (
    echo.                                                                                        %y%⚠️ Only %success_count%/%total_count% System Performance Settings Have Been Applied!%W%
)
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                              %p%[%w%C%p%]%gg1%Continue to Network Tweaks 🌐             %p%[%w%X%p%]%r%Exit Utility ❌            %p%[%w%M%p%]%y%Return to Main Menu 🏠
echo. 
call :mark_tweak_done 3   
call :check_all_tweaks_done                                                                                             
choice /c CMX /n >nul
if errorlevel 3 exit
if errorlevel 2 goto skiprestorepoint
if errorlevel 1 goto networktweaks

:networktweaks
cls
echo.
echo.
echo.
echo.
echo.%b%                                                           ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗    ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗
echo.%b%                                                           ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝    ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝
echo.%b%                                                           ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝        ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗
echo.%b%                                                           ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗        ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║
echo.%b%                                                           ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗       ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║
echo.%b%                                                           ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝       ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
echo.                                                                                                                                                                                                                                                                                                
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                         %g%Applying Network Tweaks...%W%
echo.
set success_count=0
set total_count=20

netsh int tcp set global timestamps=disabled >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ TCP Timestamps Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ TCP Timestamps Failed
)

netsh int tcp set global rss=enabled >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Receive Side Scaling Enabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ RSS Failed
)

netsh int tcp set global rsc=disabled >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Receive Segment Coalescing Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ RSC Failed
)

netsh int tcp set global dca=enabled >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Direct Cache Access Enabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ DCA Failed
)

netsh int tcp set global netdma=disabled >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ NetDMA Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ NetDMA Failed
)

netsh int tcp set global ecncapability=disabled >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ ECN Capability Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ ECN Failed
)

netsh int tcp set global fastopen=enabled >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ TCP Fast Open Enabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Fast Open Failed
)

netsh int tcp set global autotuninglevel=normal >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Auto-Tuning Level Set%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Auto-Tuning Failed
)

netsh int tcp set global maxsynretransmissions=2 >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Max SYN Retransmissions Set%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ SYN Retrans Failed
)

netsh int tcp set global initialRto=2000 >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Initial RTO Set%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Initial RTO Failed
)

netsh int tcp set heuristics disabled >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ TCP Heuristics Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Heuristics Failed
)

netsh int tcp set supplemental template=internet congestionprovider=ctcp >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Congestion Provider Set%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Congestion Provider Failed
)

netsh int ipv4 set dynamicport tcp start=1025 num=64511 >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Dynamic TCP Ports Configured%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ TCP Ports Failed
)

netsh int ipv4 set dynamicport udp start=1025 num=64511 >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Dynamic UDP Ports Configured%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ UDP Ports Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "30" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ TCP Timed Wait Delay Set%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Wait Delay Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Max User Port Set%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ User Port Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d "64" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Default TTL Set%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ TTL Failed
)

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Network Throttling Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Throttling Failed
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ QoS Packet Scheduler Optimized%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ QoS Failed
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ PMTU Discovery Enabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ PMTU Failed
)

echo.
if %success_count% equ %total_count% (
    echo.                                                                                                      %gg1%✔️ Network Tweaks Applied Successfully!%W%
) else if %success_count% equ 0 (
    echo.                                                                                                       %r%❌ No Network Settings Have Been Applied!%W%
) else (
    echo.                                                                                                  %y%⚠️ Only %success_count%/%total_count% Network Settings Have Been Applied!%W%
)
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                              %p%[%w%C%p%]%gg1%Continue to Visual Effects Tweaks 🎨         %p%[%w%X%p%]%r%Exit Utility ❌         %p%[%w%M%p%]%y%Return to Main Menu 🏠
echo.   
call :mark_tweak_done 4  
call :check_all_tweaks_done                                                                                            
choice /c CMX /n >nul
if errorlevel 3 exit
if errorlevel 2 goto skiprestorepoint
if errorlevel 1 goto visualeffects

:visualeffects
cls
echo.
echo.
echo.
echo.
echo.%b%                                                                   ██╗   ██╗██╗███████╗██╗   ██╗ █████╗ ██╗         ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗
echo.%b%                                                                   ██║   ██║██║██╔════╝██║   ██║██╔══██╗██║         ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝
echo.%b%                                                                   ██║   ██║██║███████╗██║   ██║███████║██║            ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗
echo.%b%                                                                   ╚██╗ ██╔╝██║╚════██║██║   ██║██╔══██║██║            ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║
echo.%b%                                                                    ╚████╔╝ ██║███████║╚██████╔╝██║  ██║███████╗       ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║
echo.%b%                                                                     ╚═══╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝       ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
echo.                                                                                                                                            
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                     %g%Applying Visual Effects Tweaks...%W%
echo.
set success_count=0
set total_count=15

reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038010000000" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ User Preferences Mask Configured%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ User Preferences Mask Failed
)

reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Window Animations Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Window Animations Failed
)

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "3" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Visual FX Set to Best Performance%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Visual FX Failed
)

reg add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Aero Peek Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Aero Peek Failed
)

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Taskbar Animations Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Taskbar Animations Failed
)

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Selection Shadow Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Selection Shadow Failed
)

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Listview Shadow Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Listview Shadow Failed
)

reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Drag Full Windows Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Drag Full Windows Failed
)

reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Font Smoothing Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Font Smoothing Failed
)

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Thumbnails Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Thumbnails Failed
)

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Transparency Effects Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Transparency Failed
)

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "2" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ System Visual Effects Optimized%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ System Visual Effects Failed
)

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewDesktop" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Desktop Peek Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Desktop Peek Failed
)

reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Menu Show Delay Reduced%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Menu Delay Failed
)

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Recent Items Tracking Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Recent Items Failed
)

echo.
if %success_count% equ %total_count% (
    echo.                                                                                               %gg1%✔️ Visual Effects Tweaks Applied Successfully!%W%
) else if %success_count% equ 0 (
    echo.                                                                                              %r%❌ No Visual Effects Settings Have Been Applied!%W%
) else (
    echo.                                                                                          %y%⚠️ Only %success_count%/%total_count% Visual Effects Settings Have Been Applied!%W%
)
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                              %p%[%w%C%p%]%gg1%Continue to Disable Services ⚡           %p%[%w%X%p%]%r%Exit Utility ❌            %p%[%w%M%p%]%y%Return to Main Menu 🏠
echo.
call :mark_tweak_done 5   
call :check_all_tweaks_done                                                                                              
choice /c CMX /n >nul
if errorlevel 3 exit
if errorlevel 2 goto skiprestorepoint
if errorlevel 1 goto disableservices

:disableservices
cls
echo.
echo.
echo. 
echo.
echo.%b%                                                            ██████╗ ██╗███████╗ █████╗ ██████╗ ██╗     ███████╗    ███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗███████╗
echo.%b%                                                            ██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██║     ██╔════╝    ██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝██╔════╝
echo.%b%                                                            ██║  ██║██║███████╗███████║██████╔╝██║     █████╗      ███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗  ███████╗
echo.%b%                                                            ██║  ██║██║╚════██║██╔══██║██╔══██╗██║     ██╔══╝      ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝  ╚════██║
echo.%b%                                                            ██████╔╝██║███████║██║  ██║██████╔╝███████╗███████╗    ███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗███████║
echo.%b%                                                            ╚═════╝ ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝    ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝╚══════╝
echo.                                                                                                                                                                                                                                                                                                                    
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                 %y%🔧 Disabling Unnecessary Windows Services%W%
echo.
echo.                                                                      %g%This will disable services that are not essential for most users to improve system performance.%w%
echo.                                           
echo.                                                                                       %r%⚠️ Warning: Some services may be needed for specific features.%W%
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                              %p%[%w%C%p%]%gg1%Continue with Service Optimization ✔️       %p%[%w%S%p%]%r%Skip This Step ❌        %p%[%w%M%p%]%y%Return to Main Menu 🏠
echo.                                                                                                 
choice /c CSM /n >nul
if errorlevel 3 goto skiprestorepoint
if errorlevel 2 goto nextsection
if errorlevel 1 goto applyservicedisable

:applyservicedisable
cls
echo.
echo.
echo. 
echo.
echo.%b%                                                            ██████╗ ██╗███████╗ █████╗ ██████╗ ██╗     ███████╗    ███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗███████╗
echo.%b%                                                            ██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██║     ██╔════╝    ██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝██╔════╝
echo.%b%                                                            ██║  ██║██║███████╗███████║██████╔╝██║     █████╗      ███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗  ███████╗
echo.%b%                                                            ██║  ██║██║╚════██║██╔══██║██╔══██╗██║     ██╔══╝      ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝  ╚════██║
echo.%b%                                                            ██████╔╝██║███████║██║  ██║██████╔╝███████╗███████╗    ███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗███████║
echo.%b%                                                            ╚═════╝ ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝    ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝╚══════╝ 
echo.                                                                                                                                                                                                          
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                     %g%Applying Service Optimizations...%W%
echo.
set success_count=0
set total_count=25

set nsudo_path1=%SystemDrive%\Prospira Tweaks Free Utility Resources\NSudo.exe
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Delivery Optimization Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Delivery Optimization Service Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Spatial Data Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Spatial Data Service Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\icssvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Windows Mobile Hotspot Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Windows Mobile Hotspot Service Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\ssh-agent" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ OpenSSH Authentication Agent Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ OpenSSH Authentication Agent Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Windows Update Medic Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Windows Update Medic Service Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\perceptionsimulation" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Windows Perception Simulation Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Windows Perception Simulation Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Telephony Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Telephony Service Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\PhoneSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Phone Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Phone Service Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Windows Event Collector Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Windows Event Collector Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Geolocation Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Geolocation Service Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Windows Media Player Network Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Windows Media Player Network Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Superfetch/SysMain Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Superfetch/SysMain Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Connected User Experiences Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Connected User Experiences Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushsvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Device Management WAP Push Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Device Management WAP Push Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Downloaded Maps Manager Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Downloaded Maps Manager Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\RetailDemo" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Retail Demo Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Retail Demo Service Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Touch Keyboard Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Touch Keyboard Service Failed%W%
)

"!nsudo_path1!" -U:T -P:E -ShowWindowMode:Hide reg add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Diagnostic Policy Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Diagnostic Policy Service Failed%W%
)

"!nsudo_path1!" -U:T -P:E -ShowWindowMode:Hide reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Diagnostic Service Host Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Diagnostic Service Host Failed%W%
)

"!nsudo_path1!" -U:T -P:E -ShowWindowMode:Hide reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Diagnostic System Host Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Diagnostic System Host Failed%W%
)

"!nsudo_path1!" -U:T -P:E -ShowWindowMode:Hide reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Distributed Link Tracking Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Distributed Link Tracking Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Payments and NFC/SE Manager Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Payments and NFC/SE Manager Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Windows Insider Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Windows Insider Service Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Sync Host Service Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Sync Host Service Failed%W%
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\SENS" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ System Event Notification Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ System Event Notification Failed%W%
)

echo.
if %success_count% equ %total_count% (
    echo.                                                                                                   %gg1%✔️ All Services Disabled Successfully!%W%
) else if %success_count% equ 0 (
    echo.                                                                                                     %r%❌ No Services Have Been Disabled!%W%
) else (
    echo.                                                                                                 %y%⚠️ Only %success_count%/%total_count% Services Have Been Disabled!%W%
)
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                              %p%[%w%C%p%]%gg1%Continue to Additional Tweaks 🛠️          %p%[%w%X%p%]%r%Exit Utility ❌           %p%[%w%M%p%]%y%Return to Main Menu 🏠
echo.
call :mark_tweak_done 6 
call :check_all_tweaks_done                                                                                                
choice /c CMX /n >nul
if errorlevel 3 exit
if errorlevel 2 goto skiprestorepoint
if errorlevel 1 goto additionaltweaks

:additionaltweaks
cls
echo.
echo.
echo. 
echo.
echo.%b%                                                      █████╗ ██████╗ ██████╗ ██╗████████╗██╗ ██████╗ ███╗   ██╗ █████╗ ██╗         ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗
echo.%b%                                                     ██╔══██╗██╔══██╗██╔══██╗██║╚══██╔══╝██║██╔═══██╗████╗  ██║██╔══██╗██║         ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝
echo.%b%                                                     ███████║██║  ██║██║  ██║██║   ██║   ██║██║   ██║██╔██╗ ██║███████║██║            ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗
echo.%b%                                                     ██╔══██║██║  ██║██║  ██║██║   ██║   ██║██║   ██║██║╚██╗██║██╔══██║██║            ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║
echo.%b%                                                     ██║  ██║██████╔╝██████╔╝██║   ██║   ██║╚██████╔╝██║ ╚████║██║  ██║███████╗       ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║
echo.%b%                                                     ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝       ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
echo.                                                                                                                                                                          
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                      %g%Additional System Optimizations%W%
echo.
echo.                                                                          %p%[%w%1%p%]%w%Power Plan Optimization ⚡                             %p%[%w%2%p%]%w%PC Cleaner 🧹
echo.
echo.                                                                          %p%[%w%3%p%]%w%Remove Bloatware 🗑️                                   %p%[%w%4%p%]%w%Disable OneDrive ☁️
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                     %p%[%w%M%p%]%y%Return to Main Menu 🏠               %p%[%w%X%p%]%r%Exit Utility ❌                  
echo.
echo.
echo.                                                                  %p%You are using the FREE Version of Prospira Free Utility – Unlock full performance at%b1%prospiratweaks.com%W%
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo. 
choice /c 1234MX /n >nul
if errorlevel 6 exit
if errorlevel 5 goto skiprestorepoint
if errorlevel 4 goto disableonedrive
if errorlevel 3 goto removebloatware
if errorlevel 2 goto pccleaner
if errorlevel 1 goto powerplanopt

:powerplanopt
cls
echo.
echo.
echo. 
echo.
echo.%b%                                                                             ██████╗  ██████╗ ██╗    ██╗███████╗██████╗     ██████╗ ██╗      █████╗ ███╗   ██╗
echo.%b%                                                                             ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗    ██╔══██╗██║     ██╔══██╗████╗  ██║
echo.%b%                                                                             ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝    ██████╔╝██║     ███████║██╔██╗ ██║
echo.%b%                                                                             ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗    ██╔═══╝ ██║     ██╔══██║██║╚██╗██║
echo.%b%                                                                             ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║    ██║     ███████╗██║  ██║██║ ╚████║
echo.%b%                                                                             ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝    ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝
echo.                                                                                           
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                     %g%Optimizing Power Plan Settings...%W%
echo.

set success_count=0
set total_count=3

powercfg /list | findstr /C:"Ultimate Performance" >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Ultimate Performance Plan Already Exists%W%
    set /a success_count+=1
    
    for /f "tokens=4" %%G in ('powercfg /list ^| findstr /C:"Ultimate Performance"') do set "UltimateGUID=%%G"
) else (
    for /f "tokens=4" %%G in ('powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2^>nul ^| findstr "GUID"') do set "UltimateGUID=%%G"
    
    if defined UltimateGUID (
        echo.                                                              %gg1%✔️ Ultimate Performance Plan Created%W%
        set /a success_count+=1
    ) else (
        echo.                                                              %r%❌ Ultimate Performance Plan Failed
        goto :skip_ultimate_activation
    )
)

powercfg /setactive %UltimateGUID% >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Ultimate Performance Plan Activated%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Plan Activation Failed
)

:skip_ultimate_activation

powercfg /change monitor-timeout-ac 0 >nul 2>&1
powercfg /change monitor-timeout-dc 0 >nul 2>&1
powercfg /change standby-timeout-ac 0 >nul 2>&1
powercfg /change standby-timeout-dc 0 >nul 2>&1
powercfg /change disk-timeout-ac 0 >nul 2>&1
powercfg /change disk-timeout-dc 0 >nul 2>&1
powercfg /change hibernate-timeout-ac 0 >nul 2>&1
powercfg /change hibernate-timeout-dc 0 >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Power Saving Features Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Power Settings Failed
)

echo.
if %success_count% equ %total_count% (
    echo.                                                                                                    %gg1%✔️ Power Plan Optimized Successfully!%W%
) else if %success_count% equ 0 (
    echo.                                                                                                   %r%❌ No Power Settings Have Been Applied!%W%
) else (
    echo.                                                                                                %y%⚠️ Only %success_count%/%total_count% Power Settings Have Been Applied!%W%
)
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                              %p%[%w%C%p%]%gg1%Continue to PC Cleaner 🧹               %p%[%w%X%p%]%r%Exit Utility ❌              %p%[%w%M%p%]%y%Return to Main Menu 🏠
echo.  
call :mark_tweak_done 7
call :check_all_tweaks_done                                                                                               
choice /c CMX /n >nul
if errorlevel 3 exit
if errorlevel 2 goto skiprestorepoint
if errorlevel 1 goto pccleaner

:pccleaner
cls
echo.
echo.
echo. 
echo.
echo.%b%                                                                               ██████╗  ██████╗     ██████╗██╗     ███████╗ █████╗ ███╗   ██╗███████╗██████╗ 
echo.%b%                                                                               ██╔══██╗██╔════╝    ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║██╔════╝██╔══██╗
echo.%b%                                                                               ██████╔╝██║         ██║     ██║     █████╗  ███████║██╔██╗ ██║█████╗  ██████╔╝
echo.%b%                                                                               ██╔═══╝ ██║         ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║██╔══╝  ██╔══██╗
echo.%b%                                                                               ██║     ╚██████╗    ╚██████╗███████╗███████╗██║  ██║██║ ╚████║███████╗██║  ██║
echo.%b%                                                                               ╚═╝      ╚═════╝     ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝
echo.                                                                                                     
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                        %g%Cleaning Temporary Files...%W%
echo.
set success_count=0
set total_count=5

del /s /f /q c:\windows\temp\*.* >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Windows Temp Cleaned%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Windows Temp Failed
)

del /s /f /q %temp%\*.* >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ User Temp Cleaned%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ User Temp Failed
)

del /s /f /q C:\WINDOWS\Prefetch\*.* >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Prefetch Cleaned%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Prefetch Failed
)

del /s /f /q %systemdrive%\*.tmp >nul 2>&1
del /s /f /q %systemdrive%\*.log >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ System Logs Cleaned%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ System Logs Failed
)

del /s /f /q %LocalAppData%\Microsoft\Windows\Explorer\*.db >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ Thumbnail Cache Cleaned%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Thumbnail Cache Failed
)

echo.
if %success_count% equ %total_count% (
    echo.                                                                                                        %gg1%✔️ PC Cleaned Successfully!%W%
    call :unlock_achievement 5
) else if %success_count% equ 0 (
    echo.                                                                                                       %r%❌ No Files Have Been Cleaned!%W%
) else (
    echo.                                                                                                 %y%⚠️ Only %success_count%/%total_count% Cleaning Operations Completed!%W%
    call :unlock_achievement 5
)
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                              %p%[%w%C%p%]%gg1%Continue to Bloatware Removal 🗑️          %p%[%w%X%p%]%r%Exit Utility ❌           %p%[%w%M%p%]%y%Return to Main Menu 🏠
echo. 
call :mark_tweak_done 8       
call :check_all_tweaks_done                                                                                     
choice /c CMX /n >nul
if errorlevel 3 exit
if errorlevel 2 goto skiprestorepoint
if errorlevel 1 goto removebloatware

:removebloatware
cls
echo.
echo.
echo. 
echo.
echo.%b%                                                                      ██████╗ ███████╗███╗   ███╗ ██████╗ ██╗   ██╗███████╗    ██████╗ ██╗      ██████╗  █████╗ ████████╗
echo.%b%                                                                      ██╔══██╗██╔════╝████╗ ████║██╔═══██╗██║   ██║██╔════╝    ██╔══██╗██║     ██╔═══██╗██╔══██╗╚══██╔══╝
echo.%b%                                                                      ██████╔╝█████╗  ██╔████╔██║██║   ██║██║   ██║█████╗      ██████╔╝██║     ██║   ██║███████║   ██║   
echo.%b%                                                                      ██╔══██╗██╔══╝  ██║╚██╔╝██║██║   ██║╚██╗ ██╔╝██╔══╝      ██╔══██╗██║     ██║   ██║██╔══██║   ██║   
echo.%b%                                                                      ██║  ██║███████╗██║ ╚═╝ ██║╚██████╔╝ ╚████╔╝ ███████╗    ██████╔╝███████╗╚██████╔╝██║  ██║   ██║   
echo.%b%                                                                      ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝   ╚═══╝  ╚══════╝    ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
echo.                                                                                                                            
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                        %g%Removing Unnecessary Apps...%W%
echo.
chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *3DBuilder* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ 3D Builder Removed%W%

chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *bing* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ Bing Apps Removed%W%

chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *BingWeather* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ Weather App Removed%W%

chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ Office Hub Removed%W%

chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *OneNote* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ OneNote Removed%W%

chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *people* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ People App Removed%W%

chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *SkypeApp* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ Skype Removed%W%

chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *solit* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ Solitaire Removed%W%

chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *WindowsAlarms* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ Alarms App Removed%W%

chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *WindowsMaps* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ Maps App Removed%W%

chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ Feedback Hub Removed%W%

chcp 437 >nul 2>&1
PowerShell -NoProfile -Command "Get-AppxPackage *zune* | Remove-AppxPackage" >nul 2>&1
chcp 65001 >nul 2>&1
echo.                                                              %gg1%✔️ Zune Apps Removed%W%
echo.
echo.                                                                                                       %gg1%✔️ Bloatware Removal Complete!%W%
call :unlock_achievement 6
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                              %p%[%w%C%p%]%gg1%Continue to OneDrive Disable ☁️          %p%[%w%X%p%]%r%Exit Utility ❌            %p%[%w%M%p%]%y%Return to Main Menu 🏠
echo.
call :mark_tweak_done 9    
call :check_all_tweaks_done                                                                                             
choice /c CMX /n >nul
if errorlevel 3 exit
if errorlevel 2 goto skiprestorepoint
if errorlevel 1 goto disableonedrive

:disableonedrive
cls
echo.
echo.
echo. 
echo.
echo.%b%                                                          ██████╗ ██╗███████╗ █████╗ ██████╗ ██╗     ███████╗     ██████╗ ███╗   ██╗███████╗██████╗ ██████╗ ██╗██╗   ██╗███████╗
echo.%b%                                                          ██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██║     ██╔════╝    ██╔═══██╗████╗  ██║██╔════╝██╔══██╗██╔══██╗██║██║   ██║██╔════╝
echo.%b%                                                          ██║  ██║██║███████╗███████║██████╔╝██║     █████╗      ██║   ██║██╔██╗ ██║█████╗  ██║  ██║██████╔╝██║██║   ██║█████╗  
echo.%b%                                                          ██║  ██║██║╚════██║██╔══██║██╔══██╗██║     ██╔══╝      ██║   ██║██║╚██╗██║██╔══╝  ██║  ██║██╔══██╗██║╚██╗ ██╔╝██╔══╝  
echo.%b%                                                          ██████╔╝██║███████║██║  ██║██████╔╝███████╗███████╗    ╚██████╔╝██║ ╚████║███████╗██████╔╝██║  ██║██║ ╚████╔╝ ███████╗
echo.%b%                                                          ╚═════╝ ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝     ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚══════╝
echo.                                                                                                                                                               
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                           %g%Disabling OneDrive...%W%
echo.

set success_count=0
set total_count=6

taskkill /f /im OneDrive.exe >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ OneDrive Process Terminated%W%
    set /a success_count+=1
) else (
    echo.                                                              %y%⚠️ OneDrive Process Not Running%W%
    set /a success_count+=1
)

for %%a in ("SysWOW64" "System32") do (
    if exist "%windir%\%%~a\OneDriveSetup.exe" (
        "%windir%\%%~a\OneDriveSetup.exe" /uninstall >nul 2>&1
    )
)

reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKEY_USERS\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f >nul 2>&1
reg delete "HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f >nul 2>&1

if exist "%SYSTEMROOT%\System32\OneDriveSetup.exe" (
    icacls "%SYSTEMROOT%\System32\OneDriveSetup.exe" /grant administrators:F /t /c /q >nul 2>&1
    takeown /f "%SYSTEMROOT%\System32\OneDriveSetup.exe" /a >nul 2>&1
    del /f /q "%SYSTEMROOT%\System32\OneDriveSetup.exe" >nul 2>&1
)
if exist "%SYSTEMROOT%\System32\OneDrive.ico" (
    icacls "%SYSTEMROOT%\System32\OneDrive.ico" /grant administrators:F /t /c /q >nul 2>&1
    takeown /f "%SYSTEMROOT%\System32\OneDrive.ico" /a >nul 2>&1
    del /f /q "%SYSTEMROOT%\System32\OneDrive.ico" >nul 2>&1
)

if exist "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" (
    icacls "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" /grant administrators:F /t /c /q >nul 2>&1
    takeown /f "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" /a >nul 2>&1
    del /f /q "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" >nul 2>&1
)
if exist "%SYSTEMROOT%\SysWOW64\OneDrive.ico" (
    icacls "%SYSTEMROOT%\SysWOW64\OneDrive.ico" /grant administrators:F /t /c /q >nul 2>&1
    takeown /f "%SYSTEMROOT%\SysWOW64\OneDrive.ico" /a >nul 2>&1
    del /f /q "%SYSTEMROOT%\SysWOW64\OneDrive.ico" >nul 2>&1
)

if exist "%SYSTEMROOT%\System32\SettingsHandlers_OneDriveBackup.dll" (
    icacls "%SYSTEMROOT%\System32\SettingsHandlers_OneDriveBackup.dll" /grant administrators:F /t /c /q >nul 2>&1
    takeown /f "%SYSTEMROOT%\System32\SettingsHandlers_OneDriveBackup.dll" /a >nul 2>&1
    del /f /q "%SYSTEMROOT%\System32\SettingsHandlers_OneDriveBackup.dll" >nul 2>&1
)

set files_deleted=0
if not exist "%SYSTEMROOT%\System32\OneDriveSetup.exe" set /a files_deleted+=1
if not exist "%SYSTEMROOT%\System32\OneDrive.ico" set /a files_deleted+=1
if not exist "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" set /a files_deleted+=1
if not exist "%SYSTEMROOT%\SysWOW64\OneDrive.ico" set /a files_deleted+=1
if not exist "%SYSTEMROOT%\System32\SettingsHandlers_OneDriveBackup.dll" set /a files_deleted+=1

if %files_deleted% geq 3 (
    echo.                                                              %gg1%✔️ OneDrive System Files Removed%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ OneDrive File Removal Failed%W%
)

rd "%SystemDrive%\OneDriveTemp" /q /s >nul 2>&1
rd "%USERPROFILE%\OneDrive" /q /s >nul 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /q /s >nul 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /q /s >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ OneDrive Folders Removed%W%
    set /a success_count+=1
) else (
    echo.                                                              %y%⚠️ Some OneDrive Folders May Remain%W%
    set /a success_count+=1
)

reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ OneDrive Shell Attributes Modified%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Shell Attributes Failed
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d "1" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ OneDrive File Sync Disabled%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ OneDrive Sync Registry Failed
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% equ 0 (
    echo.                                                              %gg1%✔️ OneDrive Additional Policies Set%W%
    set /a success_count+=1
) else (
    echo.                                                              %r%❌ Additional Policies Failed
)

echo.
if %success_count% equ %total_count% (
    echo.                                                                                                     %gg1%✔️ OneDrive Disabled Successfully!%W%
) else (
    if %success_count% equ 0 (
        echo.                                                                                                         %r%❌ OneDrive Disable Failed!%W%
    ) else (
        set "result=%success_count% of %total_count%"
        echo.                                                                                                   %y%⚠️ OneDrive Partially Disabled !result!!%W%
    )
)
call :mark_tweak_done 10    
call :check_all_tweaks_done 
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                         %p%[%w%M%p%]%gg1%Return to Main Menu 🏠           %p%[%w%X%p%]%r%Exit Utility ❌
echo.                                                                                            
choice /c MX /n >nul
if errorlevel 2 exit
if errorlevel 1 goto skiprestorepoint

:prospiraweb
call :unlock_achievement 9
start https://prospiratweaks.com
goto skiprestorepoint

:revertall
cls
echo.
echo.
echo.
echo.
echo.%b%                                                                     ██████╗ ███████╗███████╗████████╗ ██████╗ ██████╗ ███████╗    ██████╗  ██████╗ ██╗███╗   ██╗████████╗
echo.%b%                                                                     ██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝    ██╔══██╗██╔═══██╗██║████╗  ██║╚══██╔══╝
echo.%b%                                                                     ██████╔╝█████╗  ███████╗   ██║   ██║   ██║██████╔╝█████╗      ██████╔╝██║   ██║██║██╔██╗ ██║   ██║   
echo.%b%                                                                     ██╔══██╗██╔══╝  ╚════██║   ██║   ██║   ██║██╔══██╗██╔══╝      ██╔═══╝ ██║   ██║██║██║╚██╗██║   ██║   
echo.%b%                                                                     ██║  ██║███████╗███████║   ██║   ╚██████╔╝██║  ██║███████╗    ██║     ╚██████╔╝██║██║ ╚████║   ██║   
echo.%b%                                                                     ╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚═╝      ╚═════╝ ╚═╝╚═╝  ╚═══╝   ╚═╝ 
echo.                                                                                                                               
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                         %y%🔄 SYSTEM RESTORE UTILITY 🔄%W%
echo.
echo.                                                                                            %W%Opening Windows System Restore to revert changes...
echo.
echo.                                                                                        %g%• Select the restore point named%p%"Prospira Free Utility"%g%
echo.                                                                                        %g%• Follow the on-screen instructions to complete the restore
echo.                                                                                        %g%• Your computer will restart automatically after restoration
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                              %b%╔════════════════════════════════════════════╗
echo.                                                                                              %b%║     %w% Press any key to continue... ➡️     %b%║
echo.                                                                                              %b%╚════════════════════════════════════════════╝
pause >nul 2>&1

rstrui.exe
goto skiprestorepoint

:systeminfo
cls
echo.
echo.
echo.
echo.
echo.%b%                                                                           ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗    ██╗███╗   ██╗███████╗ ██████╗ 
echo.%b%                                                                           ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║    ██║████╗  ██║██╔════╝██╔═══██╗
echo.%b%                                                                           ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║    ██║██╔██╗ ██║█████╗  ██║   ██║
echo.%b%                                                                           ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║    ██║██║╚██╗██║██╔══╝  ██║   ██║
echo.%b%                                                                           ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║    ██║██║ ╚████║██║     ╚██████╔╝
echo.%b%                                                                           ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝    ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝  
echo.                                                                                                                
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                            %g%📊 SYSTEM INFORMATION%W%
echo.
echo.                                                              %g%•%y%⚡ Initializing system scan...%w%
timeout /t 1 /nobreak >nul 2>&1
echo.                                                              %g%•%b1%🔍 Analyzing hardware components...%w%
timeout /t 1 /nobreak >nul 2>&1
echo.                                                              %g%•%p%💾 Reading memory information...%w%
timeout /t 1 /nobreak >nul 2>&1
echo.                                                              %g%•%gg1%🎮 Detecting graphics hardware...%w%
timeout /t 1 /nobreak >nul 2>&1
echo.                                                              %g%•%b1%💽 Analyzing storage devices...%w%
echo.
set "dxdiag_file=%temp%\prospira_dxdiag.txt"
start /wait dxdiag /t "%dxdiag_file%"

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).Caption"') do set "os_name=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).BuildNumber"') do set "os_build=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).Version"') do set "os_version=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).OSArchitecture"') do set "os_arch=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$uptime = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime; '{0} Days, {1} Hours, {2} Minutes' -f $uptime.Days, $uptime.Hours, $uptime.Minutes"') do set "uptime=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_Processor).Name.Trim()"') do set "cpu_name=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_Processor).NumberOfCores"') do set "cpu_cores=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_Processor).NumberOfLogicalProcessors"') do set "cpu_threads=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_Processor).MaxClockSpeed"') do set "cpu_speed=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_Processor).CurrentClockSpeed"') do set "cpu_current=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB, 2)"') do set "total_ram=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "[math]::Round((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory/1MB, 2)"') do set "free_ram=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$os = Get-CimInstance Win32_OperatingSystem; [math]::Round(($os.TotalVisibleMemorySize - $os.FreePhysicalMemory)/1MB, 2)"') do set "used_ram=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController | Where-Object {$_.Name -notlike '*Microsoft*' -and $_.Name -notlike '*Basic*'} | Select-Object -First 1).Name"') do set "gpu_name=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController | Where-Object {$_.Name -notlike '*Microsoft*' -and $_.Name -notlike '*Basic*'} | Select-Object -First 1).DriverVersion"') do set "gpu_driver=%%a"
chcp 65001 >nul 2>&1

set "gpu_ram=N/A"
if exist "%dxdiag_file%" (
    chcp 437 >nul 2>&1
    for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$content = Get-Content '%dxdiag_file%'; $line = $content | Where-Object {$_ -match 'Dedicated Memory:'} | Select-Object -First 1; if($line -match '(\d+)\s*MB') { [math]::Round([int]$matches[1]/1024, 2) } else { 'N/A' }"') do set "gpu_ram=%%a"
    chcp 65001 >nul 2>&1
)

if "!gpu_ram!"=="N/A" (
    chcp 437 >nul 2>&1
    for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$gpu = Get-CimInstance Win32_VideoController | Where-Object {$_.Name -notlike '*Microsoft*' -and $_.Name -notlike '*Basic*'} | Select-Object -First 1; if($gpu.AdapterRAM -gt 0) {[math]::Round($gpu.AdapterRAM/1GB, 2)} else {'N/A'}"') do set "gpu_ram=%%a"
    chcp 65001 >nul 2>&1
)

if "!gpu_ram!"=="N/A" (
    chcp 437 >nul 2>&1
    for /f "tokens=*" %%a in ('powershell -NoProfile -Command "try { $dedicatedMemory = (Get-ItemProperty -Path 'HKLM:\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000' -Name HardwareInformation.qwMemorySize -ErrorAction SilentlyContinue).'HardwareInformation.qwMemorySize'; if($dedicatedMemory) {[math]::Round($dedicatedMemory/1GB, 2)} else {'N/A'} } catch {'N/A'}"') do set "gpu_ram=%%a"
    chcp 65001 >nul 2>&1
)

set "gpu_resolution=N/A"
if exist "%dxdiag_file%" (
    chcp 437 >nul 2>&1
    for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$content = Get-Content '%dxdiag_file%'; $line = $content | Where-Object {$_ -match 'Current Mode:'} | Select-Object -First 1; if($line -match 'Current Mode:\s*(.+)') { $matches[1].Trim() } else { 'N/A' }"') do set "gpu_resolution=%%a"
    chcp 65001 >nul 2>&1
)

if "!gpu_resolution!"=="N/A" (
    chcp 437 >nul 2>&1
    for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController | Where-Object {$_.Name -notlike '*Microsoft*' -and $_.Name -notlike '*Basic*'} | Select-Object -First 1).VideoModeDescription"') do set "gpu_resolution=%%a"
    chcp 65001 >nul 2>&1
)

if exist "%dxdiag_file%" del /f /q "%dxdiag_file%" >nul 2>&1

set "test_file=%temp%\prospira_speed_test.tmp"

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_ComputerSystem).Manufacturer"') do set "pc_manufacturer=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_ComputerSystem).Model"') do set "pc_model=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_BIOS).SMBIOSBIOSVersion"') do set "bios_version=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_BaseBoard).Product"') do set "motherboard=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_NetworkAdapter | Where-Object {$_.NetConnectionStatus -eq 2 -and $_.PhysicalAdapter -eq $true} | Select-Object -First 1).Name"') do set "network_adapter=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$speed = (Get-CimInstance Win32_NetworkAdapter | Where-Object {$_.NetConnectionStatus -eq 2 -and $_.PhysicalAdapter -eq $true} | Select-Object -First 1).Speed; if($speed) {[math]::Round($speed/1000000)} else {'N/A'}"') do set "network_speed=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$disk = Get-PhysicalDisk | Where-Object {$_.DeviceID -eq 0}; if($disk.MediaType -eq 'SSD') {'SSD'} elseif($disk.MediaType -eq 'HDD') {'HDD'} else {$disk.MediaType}"') do set "disk_type=%%a"
chcp 65001 >nul 2>&1

cls
echo.
echo.
echo.
echo.
echo.%b%                                                                           ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗    ██╗███╗   ██╗███████╗ ██████╗ 
echo.%b%                                                                           ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║    ██║████╗  ██║██╔════╝██╔═══██╗
echo.%b%                                                                           ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║    ██║██╔██╗ ██║█████╗  ██║   ██║
echo.%b%                                                                           ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║    ██║██║╚██╗██║██╔══╝  ██║   ██║
echo.%b%                                                                           ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║    ██║██║ ╚████║██║     ╚██████╔╝
echo.%b%                                                                           ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝    ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝    
echo.                                                                                                                
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                            %g%📊 SYSTEM INFORMATION%W%
echo.
chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$testFile='%test_file%'; $size=50MB; $data=New-Object byte[] $size; (New-Object Random).NextBytes($data); $start=Get-Date; [System.IO.File]::WriteAllBytes($testFile,$data); $elapsed=(Get-Date)-$start; $speed=[math]::Round(($size/1MB)/$elapsed.TotalSeconds,2); Remove-Item $testFile -Force -ErrorAction SilentlyContinue; $speed"') do set "disk_write_speed=%%a"
chcp 65001 >nul 2>&1

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$testFile='%test_file%'; $size=50MB; $data=New-Object byte[] $size; (New-Object Random).NextBytes($data); [System.IO.File]::WriteAllBytes($testFile,$data); $start=Get-Date; $null=[System.IO.File]::ReadAllBytes($testFile); $elapsed=(Get-Date)-$start; $speed=[math]::Round(($size/1MB)/$elapsed.TotalSeconds,2); Remove-Item $testFile -Force -ErrorAction SilentlyContinue; $speed"') do set "disk_read_speed=%%a"
chcp 65001 >nul 2>&1

echo.                                                              %b1%═══════════════════ OPERATING SYSTEM ═══════════════════%w%
echo.                                                              %p%🖥️ OS Name:%w%!os_name!
echo.                                                              %p%📦 Build Number:%w%!os_build! ^(Version !os_version!^)
echo.                                                              %p%🏗️ Architecture:%w%!os_arch!
echo.                                                              %p%⏱️ System Uptime:%w%!uptime!
echo.
echo.                                                              %b1%════════════════════ PROCESSOR ════════════════════%w%
echo.                                                              %p%⚙️ CPU:%w%!cpu_name!
echo.                                                              %p%🔢 Cores / Threads:%w%!cpu_cores! Cores / !cpu_threads! Threads
echo.                                                              %p%⚡ Base Speed:%w%!cpu_speed! MHz
echo.                                                              %p%📊 Current Speed:%w%!cpu_current! MHz
echo.
echo.                                                              %b1%══════════════════════ MEMORY ══════════════════════%w%
echo.                                                              %p%🧠 Total RAM:%w%!total_ram! GB
echo.                                                              %p%✅ Available RAM:%w%!free_ram! GB
echo.                                                              %p%📈 Used RAM:%w%!used_ram! GB
echo.
echo.                                                              %b1%═══════════════════ GRAPHICS CARD ═══════════════════%w%
echo.                                                              %p%🎮 GPU:%w%!gpu_name!
echo.                                                              %p%💾 VRAM:%w%!gpu_ram! GB
echo.                                                              %p%🔧 Driver Version:%w%!gpu_driver!
echo.                                                              %p%🖼️ Resolution:%w%!gpu_resolution!
echo.
echo.                                                              %b1%═══════════════════════ STORAGE ═══════════════════════%w%
echo.                                                              %p%💽 Disk Type:%w%!disk_type!
echo.                                                              %p%📝 Write Speed:%w%!disk_write_speed! MB/s
echo.                                                              %p%📖 Read Speed:%w%!disk_read_speed! MB/s
echo.
echo.                                                              %b1%═══════════════════ SYSTEM HARDWARE ═══════════════════%w%
echo.                                                              %p%🏭 Manufacturer:%w%!pc_manufacturer!
echo.                                                              %p%📋 Model:%w%!pc_model!
echo.                                                              %p%🔌 Motherboard:%w%!motherboard!
echo.                                                              %p%⚡ BIOS Version:%w%!bios_version!
echo.
echo.                                                              %b1%═══════════════════════ NETWORK ═══════════════════════%w%
echo.                                                              %p%🌐 Adapter:%w%!network_adapter!
echo.                                                              %p%⚡ Link Speed:%w%!network_speed! Mbps
echo.
call :unlock_achievement 8
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                  %p%You are using the FREE Version of Prospira Free Utility – Unlock full performance at%b1%prospiratweaks.com%W%
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                    %p%[%w%M%p%]%y%Return to Main Menu 🏠            %p%[%w%X%p%]%r%Exit Utility ❌
echo.
choice /c MX /n >nul
if errorlevel 2 exit
if errorlevel 1 goto skiprestorepoint

:createrestorepointmain
cls
goto restorepoint

:nextsection
goto additionaltweaks

:achievements
setlocal enabledelayedexpansion
cls
echo.
echo.
echo.
echo.
echo.%b%                                                                      █████╗  ██████╗██╗  ██╗██╗███████╗██╗   ██╗███████╗███╗   ███╗███████╗███╗   ██╗████████╗███████╗
echo.%b%                                                                     ██╔══██╗██╔════╝██║  ██║██║██╔════╝██║   ██║██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
echo.%b%                                                                     ███████║██║     ███████║██║█████╗  ██║   ██║█████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║   ███████╗
echo.%b%                                                                     ██╔══██║██║     ██╔══██║██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   ╚════██║
echo.%b%                                                                     ██║  ██║╚██████╗██║  ██║██║███████╗ ╚████╔╝ ███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   ███████║
echo.%b%                                                                     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚══════╝  ╚═══╝  ╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝
echo.                                                                                                                                 
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                                           %g%🏆 YOUR ACHIEVEMENTS 🏆%W%
echo.

if not exist "%APPDATA%\ProspiraTweaks" mkdir "%APPDATA%\ProspiraTweaks" 2>nul

if not exist "%APPDATA%\ProspiraTweaks\achievements.dat" (
    echo 0,0,0,0,0,0,0,0,0,0> "%APPDATA%\ProspiraTweaks\achievements.dat"
)

set "ach1=0"
set "ach2=0"
set "ach3=0"
set "ach4=0"
set "ach5=0"
set "ach6=0"
set "ach7=0"
set "ach8=0"
set "ach9=0"
set "ach10=0"

for /f "usebackq tokens=1-10 delims=, " %%a in ("%APPDATA%\ProspiraTweaks\achievements.dat") do (
    if not "%%a"=="" set "ach1=%%a"
    if not "%%b"=="" set "ach2=%%b"
    if not "%%c"=="" set "ach3=%%c"
    if not "%%d"=="" set "ach4=%%d"
    if not "%%e"=="" set "ach5=%%e"
    if not "%%f"=="" set "ach6=%%f"
    if not "%%g"=="" set "ach7=%%g"
    if not "%%h"=="" set "ach8=%%h"
    if not "%%i"=="" set "ach9=%%i"
    if not "%%j"=="" set "ach10=%%j"
)

set /a total_unlocked=0
if "!ach1!"=="1" set /a total_unlocked+=1
if "!ach2!"=="1" set /a total_unlocked+=1
if "!ach3!"=="1" set /a total_unlocked+=1
if "!ach4!"=="1" set /a total_unlocked+=1
if "!ach5!"=="1" set /a total_unlocked+=1
if "!ach6!"=="1" set /a total_unlocked+=1
if "!ach7!"=="1" set /a total_unlocked+=1
if "!ach8!"=="1" set /a total_unlocked+=1
if "!ach9!"=="1" set /a total_unlocked+=1
if "!ach10!"=="1" set /a total_unlocked+=1

set /a progress_percent=total_unlocked*10

set "progress_bar="
set /a filled_blocks=total_unlocked*2
set /a empty_blocks=20-filled_blocks

for /l %%i in (1,1,!filled_blocks!) do set "progress_bar=!progress_bar!█"
for /l %%i in (1,1,!empty_blocks!) do set "progress_bar=!progress_bar!░"

echo.                                                                                                           %p%Progress: %w%!total_unlocked!/10 %p%^(!progress_percent!%%^)%w%
echo.                                                                                                          %b%[%gg1%!progress_bar!%b%]%w%
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.

if "!ach1!"=="1" (
    echo.                                                              %gg1%✅ [UNLOCKED]%w%🎮 %p%First Steps%w%- Launch Prospira Tweaks for the first time
) else (
    echo.                                                              %g%🔒 [LOCKED]%w%  🎮 %g%First Steps%w%- Launch Prospira Tweaks for the first time
)

if "!ach2!"=="1" (
    echo.                                                              %gg1%✅ [UNLOCKED]%w%⚙️ %p%The Optimizer%w%- Apply your first optimization
) else (
    echo.                                                              %g%🔒 [LOCKED]%w%  ⚙️ %g%The Optimizer%w%- Apply your first optimization
)

if "!ach3!"=="1" (
    echo.                                                              %gg1%✅ [UNLOCKED]%w%🔥 %p%Power User%w%- Apply all available tweaks
) else (
    echo.                                                              %g%🔒 [LOCKED]%w%  🔥 %g%Power User%w%- Apply all available tweaks
)

if "!ach4!"=="1" (
    echo.                                                              %gg1%✅ [UNLOCKED]%w%💾 %p%Safety First%w%- Create a system restore point
) else (
    echo.                                                              %g%🔒 [LOCKED]%w%  💾 %g%Safety First%w%- Create a system restore point
)

if "!ach5!"=="1" (
    echo.                                                              %gg1%✅ [UNLOCKED]%w%🧹 %p%Clean Freak%w%- Use PC Cleaner to remove junk files
) else (
    echo.                                                              %g%🔒 [LOCKED]%w%  🧹 %g%Clean Freak%w%- Use PC Cleaner to remove junk files
)

if "!ach6!"=="1" (
    echo.                                                              %gg1%✅ [UNLOCKED]%w%🗑️%p%Minimalist%w%- Remove all bloatware apps
) else (
    echo.                                                              %g%🔒 [LOCKED]%w%  🗑️%g%Minimalist%w%- Remove all bloatware apps
)

if "!ach7!"=="1" (
    echo.                                                              %gg1%✅ [UNLOCKED]%w%⏰ %p%Dedicated%w%- Use Prospira for 5 consecutive days
) else (
    echo.                                                              %g%🔒 [LOCKED]%w%  ⏰ %g%Dedicated%w%- Use Prospira for 5 consecutive days
)

if "!ach8!"=="1" (
    echo.                                                              %gg1%✅ [UNLOCKED]%w%📊 %p%Tech Savvy%w%- Check your system information
) else (
    echo.                                                              %g%🔒 [LOCKED]%w%  📊 %g%Tech Savvy%w%- Check your system information
)

if "!ach9!"=="1" (
    echo.                                                              %gg1%✅ [UNLOCKED]%w%🌐 %p%Explorer%w%- Visit Prospira Tweaks website
) else (
    echo.                                                              %g%🔒 [LOCKED]%w%  🌐 %g%Explorer%w%- Visit Prospira Tweaks website
)

if "!ach10!"=="1" (
    echo.                                                              %gg1%✅ [UNLOCKED]%w%👑 %g2%Master Tweaker%w%- Unlock all achievements%g2%^(LEGENDARY!^)%w%
) else (
    echo.                                                              %g%🔒 [LOCKED]%w%  👑 %g%Master Tweaker%w%- Unlock all achievements%g%^(LEGENDARY!^)%w%
)

echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.

if !total_unlocked! equ 10 (
    echo.                                                                                            %g2%🎉 CONGRATULATIONS YOU ARE A TRUE PROSPIRA USER! 🎉%W%
    echo.
)

echo.                                                                  %p%You are using the FREE Version of Prospira Free Utility – Unlock full performance at%b1%prospiratweaks.com%W%
echo.
echo.                                                             %b%"═══════════════════════════════════════════════════════════════════════════════════════════════════════════════"%w%
echo.
echo.                                                                                     %p%[%w%M%p%]%y%Return to Main Menu 🏠               %p%[%w%X%p%]%r%Exit Utility ❌
echo.
choice /c MX /n >nul
if errorlevel 2 exit
if errorlevel 1 (
    endlocal
    goto skiprestorepoint
)

:unlock_achievement
setlocal enabledelayedexpansion

if not exist "%APPDATA%\ProspiraTweaks" mkdir "%APPDATA%\ProspiraTweaks" 2>nul

if not exist "%APPDATA%\ProspiraTweaks\achievements.dat" (
    >"%APPDATA%\ProspiraTweaks\achievements.dat" echo 0,0,0,0,0,0,0,0,0,0
)

set "ach1=0"
set "ach2=0"
set "ach3=0"
set "ach4=0"
set "ach5=0"
set "ach6=0"
set "ach7=0"
set "ach8=0"
set "ach9=0"
set "ach10=0"

for /f "usebackq tokens=1-10 delims=, " %%a in ("%APPDATA%\ProspiraTweaks\achievements.dat") do (
    if not "%%a"=="" set "ach1=%%a"
    if not "%%b"=="" set "ach2=%%b"
    if not "%%c"=="" set "ach3=%%c"
    if not "%%d"=="" set "ach4=%%d"
    if not "%%e"=="" set "ach5=%%e"
    if not "%%f"=="" set "ach6=%%f"
    if not "%%g"=="" set "ach7=%%g"
    if not "%%h"=="" set "ach8=%%h"
    if not "%%i"=="" set "ach9=%%i"
    if not "%%j"=="" set "ach10=%%j"
)

set "show_notif="
set "show_master="

if "%~1"=="1" if "!ach1!"=="0" set "ach1=1" & set "show_notif=1" & set "ach_name=🎮 First Steps"
if "%~1"=="2" if "!ach2!"=="0" set "ach2=1" & set "show_notif=1" & set "ach_name=⚙️ The Optimizer"
if "%~1"=="3" if "!ach3!"=="0" set "ach3=1" & set "show_notif=1" & set "ach_name=🔥 Power User"
if "%~1"=="4" if "!ach4!"=="0" set "ach4=1" & set "show_notif=1" & set "ach_name=💾 Safety First"
if "%~1"=="5" if "!ach5!"=="0" set "ach5=1" & set "show_notif=1" & set "ach_name=🧹 Clean Freak"
if "%~1"=="6" if "!ach6!"=="0" set "ach6=1" & set "show_notif=1" & set "ach_name=🗑️ Minimalist"
if "%~1"=="7" if "!ach7!"=="0" set "ach7=1" & set "show_notif=1" & set "ach_name=⏰ Dedicated"
if "%~1"=="8" if "!ach8!"=="0" set "ach8=1" & set "show_notif=1" & set "ach_name=📊 Tech Savvy"
if "%~1"=="9" if "!ach9!"=="0" set "ach9=1" & set "show_notif=1" & set "ach_name=🌐 Explorer"

set /a unlocked_count=0
if "!ach1!"=="1" set /a unlocked_count+=1
if "!ach2!"=="1" set /a unlocked_count+=1
if "!ach3!"=="1" set /a unlocked_count+=1
if "!ach4!"=="1" set /a unlocked_count+=1
if "!ach5!"=="1" set /a unlocked_count+=1
if "!ach6!"=="1" set /a unlocked_count+=1
if "!ach7!"=="1" set /a unlocked_count+=1
if "!ach8!"=="1" set /a unlocked_count+=1
if "!ach9!"=="1" set /a unlocked_count+=1

if !unlocked_count! equ 9 (
    if "!ach10!"=="0" (
        set "ach10=1"
        set "show_master=1"
    )
)

>"%APPDATA%\ProspiraTweaks\achievements.dat" echo !ach1!,!ach2!,!ach3!,!ach4!,!ach5!,!ach6!,!ach7!,!ach8!,!ach9!,!ach10!

if defined show_notif (
    echo.
    echo                                                                                                          %gg1%🎉 ACHIEVEMENT UNLOCKED! 🎉%w%
    echo                                                                                                                 !ach_name!%w%
    timeout /t 2 /nobreak >nul
)

if defined show_master (
    echo.
    echo                                                                                                   %g2%╔══════════════════════════════════════╗%w%
    echo                                                                                                   %g2%║      🏆 LEGENDARY ACHIEVEMENT! 🏆     ║%w%
    echo                                                                                                   %g2%║                                      ║%w%
    echo                                                                                                   %g2%║          %gg1%👑 Master Tweaker%g2%         ║%w%
    echo                                                                                                   %g2%║                                      ║%w%
    echo                                                                                                   %g2%║   You unlocked ALL achievements! 🎉   ║%w%
    echo                                                                                                   %g2%╚══════════════════════════════════════╝%w%
    timeout /t 3 /nobreak >nul
)

endlocal
goto :eof

:check_daily_usage
setlocal enabledelayedexpansion

if not exist "%APPDATA%\ProspiraTweaks\usage_log.dat" (
    if not exist "%APPDATA%\ProspiraTweaks" mkdir "%APPDATA%\ProspiraTweaks" 2>nul
    chcp 437 >nul 2>&1
    for /f "tokens=*" %%a in ('powershell -NoProfile -Command "Get-Date -Format 'yyyyMMdd'"') do set "today=%%a"
    chcp 65001 >nul 2>&1
    >"%APPDATA%\ProspiraTweaks\usage_log.dat" echo !today!,1
    endlocal
    goto :eof
)

for /f "tokens=1,2 delims=," %%a in (%APPDATA%\ProspiraTweaks\usage_log.dat) do (
    set "last_date=%%a"
    set "streak=%%b"
)

REM Sprawdź achievement PRZED sprawdzeniem daty
if !streak! geq 5 (
    endlocal
    call :unlock_achievement 7
    goto :eof
)

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "Get-Date -Format 'yyyyMMdd'"') do set "today=%%a"
chcp 65001 >nul 2>&1

if "!today!"=="!last_date!" (
    endlocal
    goto :eof
)

chcp 437 >nul 2>&1
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "$lastDate = [datetime]::ParseExact('!last_date!', 'yyyyMMdd', $null); $today = Get-Date; ($today.Date - $lastDate.Date).Days"') do set "days_diff=%%a"
chcp 65001 >nul 2>&1

if "!days_diff!"=="1" (
    set /a streak+=1
) else (
    set /a streak=1
)

>"%APPDATA%\ProspiraTweaks\usage_log.dat" echo !today!,!streak!

if !streak! geq 5 (
    endlocal
    call :unlock_achievement 7
    goto :eof
)
endlocal
goto :eof

:check_all_tweaks_done
setlocal enabledelayedexpansion
if not exist "%APPDATA%\ProspiraTweaks\tweaks_progress.dat" (
    mkdir "%APPDATA%\ProspiraTweaks" 2>nul
    >"%APPDATA%\ProspiraTweaks\tweaks_progress.dat" echo 0,0,0,0,0,0,0,0,0,0
)

for /f "tokens=1-10 delims=," %%a in (%APPDATA%\ProspiraTweaks\tweaks_progress.dat) do (
    set "tw1=%%a"
    set "tw2=%%b"
    set "tw3=%%c"
    set "tw4=%%d"
    set "tw5=%%e"
    set "tw6=%%f"
    set "tw7=%%g"
    set "tw8=%%h"
    set "tw9=%%i"
    set "tw10=%%j"
)

set /a completed=0
if !tw1! equ 1 set /a completed+=1
if !tw2! equ 1 set /a completed+=1
if !tw3! equ 1 set /a completed+=1
if !tw4! equ 1 set /a completed+=1
if !tw5! equ 1 set /a completed+=1
if !tw6! equ 1 set /a completed+=1
if !tw7! equ 1 set /a completed+=1
if !tw8! equ 1 set /a completed+=1
if !tw9! equ 1 set /a completed+=1
if !tw10! equ 1 set /a completed+=1

if !completed! equ 10 (
    endlocal
    call :unlock_achievement 3
    goto :eof
)
endlocal
goto :eof

:mark_tweak_done
setlocal enabledelayedexpansion
if not exist "%APPDATA%\ProspiraTweaks\tweaks_progress.dat" (
    mkdir "%APPDATA%\ProspiraTweaks" 2>nul
    >"%APPDATA%\ProspiraTweaks\tweaks_progress.dat" echo 0,0,0,0,0,0,0,0,0,0
)

for /f "tokens=1-10 delims=," %%a in (%APPDATA%\ProspiraTweaks\tweaks_progress.dat) do (
    set "tw1=%%a"
    set "tw2=%%b"
    set "tw3=%%c"
    set "tw4=%%d"
    set "tw5=%%e"
    set "tw6=%%f"
    set "tw7=%%g"
    set "tw8=%%h"
    set "tw9=%%i"
    set "tw10=%%j"
)

if "%1"=="1" set "tw1=1"
if "%1"=="2" set "tw2=1"
if "%1"=="3" set "tw3=1"
if "%1"=="4" set "tw4=1"
if "%1"=="5" set "tw5=1"
if "%1"=="6" set "tw6=1"
if "%1"=="7" set "tw7=1"
if "%1"=="8" set "tw8=1"
if "%1"=="9" set "tw9=1"
if "%1"=="10" set "tw10=1"

>"%APPDATA%\ProspiraTweaks\tweaks_progress.dat" echo !tw1!,!tw2!,!tw3!,!tw4!,!tw5!,!tw6!,!tw7!,!tw8!,!tw9!,!tw10!

set /a completed=0
if !tw1! equ 1 set /a completed+=1
if !tw2! equ 1 set /a completed+=1
if !tw3! equ 1 set /a completed+=1
if !tw4! equ 1 set /a completed+=1
if !tw5! equ 1 set /a completed+=1
if !tw6! equ 1 set /a completed+=1
if !tw7! equ 1 set /a completed+=1
if !tw8! equ 1 set /a completed+=1
if !tw9! equ 1 set /a completed+=1
if !tw10! equ 1 set /a completed+=1

if !completed! equ 10 (
    endlocal
    call :unlock_achievement 3
    goto :eof
)

endlocal
goto :eof

:save_license_acceptance
if not exist "%APPDATA%\ProspiraTweaks" mkdir "%APPDATA%\ProspiraTweaks" 2>nul
>"%APPDATA%\ProspiraTweaks\license.dat" echo 1
goto :eof
