@echo off
:: GetAdmin
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
    powershell.exe /c "Invoke-WebRequest -Uri 'https://github.com/aalpereny/winltscetup/raw/main/files/ltsc/skus.zip' -OutFile %temp%\skus.zip"
    powershell.exe /c "Expand-Archive -Force %temp%\skus.zip -DestinationPath %temp%\skus"
    powershell.exe /c "Copy-Item -Path %temp%\skus -Destination %windir%\system32\spp\tokens -Recurse"
    cscript.exe %windir%\system32\slmgr.vbs /rilc
    cscript.exe %windir%\system32\slmgr.vbs /upk >nul 2>&1
    cscript.exe %windir%\system32\slmgr.vbs /ckms >nul 2>&1
    cscript.exe %windir%\system32\slmgr.vbs /cpky >nul 2>&1
    cscript.exe %windir%\system32\slmgr.vbs /ipk M7XTQ-FN8P6-TTKYV-9D4CC-J462D
    WSReset -i&&TimeOut 20&&WSReset -i&&exit
    shutdown.exe -r -f -t 0
