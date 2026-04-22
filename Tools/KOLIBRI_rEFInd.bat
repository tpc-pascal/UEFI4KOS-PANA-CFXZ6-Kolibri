@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /B
)

echo [INFO] Dang khoi chay rEFInd...
echo.

set QEMU_PATH="D:\Tools"
cd /d %QEMU_PATH%

set DISK_DRIVE=\\.\PhysicalDrive0

qemu-system-x86_64.exe -m 1G -bios %QEMU_PATH%\OVMF.fd -drive file=%DISK_DRIVE%,format=raw,if=ide -rtc base=localtime -net none

if %errorlevel% neq 0 (
    echo.
    echo [LOI] QEMU thoat voi ma: %errorlevel%
    pause
)