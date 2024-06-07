    powershell.exe /c "Invoke-WebRequest -Uri 'https://github.com/aalpereny/winltscetup/raw/main/files/ltsc/skus.zip' -OutFile %temp%\skus.zip"
    powershell.exe /c "Expand-Archive -Force %temp%\skus.zip -DestinationPath %temp%\skus"
    powershell.exe /c "Copy-Item -Path %temp%\skus -Destination %windir%\system32\spp\tokens -Recurse"
    cscript.exe %windir%\system32\slmgr.vbs /rilc
    cscript.exe %windir%\system32\slmgr.vbs /upk
    cscript.exe %windir%\system32\slmgr.vbs /ckms
    cscript.exe %windir%\system32\slmgr.vbs /cpky
    cscript.exe %windir%\system32\slmgr.vbs /ipk M7XTQ-FN8P6-TTKYV-9D4CC-J462D
    cscript.exe %windir%\system32\slmgr.vbs /skms kms.lotro.cc
    cscript.exe %windir%\system32\slmgr.vbs /ato
    rmdir %temp%\skus
    del %temp%\skus.zip
    WSReset -i&&TimeOut 20&&WSReset -i&&exit
