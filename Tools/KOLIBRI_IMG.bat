@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /B
)

echo [INFO] Dang khoi chay KolibriOS IMG...
echo.

set QEMU_PATH="D:\Tools"
cd /d %QEMU_PATH%

qemu-system-x86_64.exe -fda KOLIBRI.IMG -m 512 -vga std -net none

if %errorlevel% neq 0 (
    echo.
    echo [LOI] QEMU thoat voi ma: %errorlevel%
    pause
)