@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /B
)

echo [INFO] Dang khoi chay KolibriOS tu file IMG (Che do UEFI)...
echo.

:: Di chuyen den thu muc chua file bat nay
cd /d "%~dp0"

:: Kiem tra file firmware co ton tai khong
if not exist "edk2-x86_64-code.fd" (
    echo [CANH BAO] Khong tim thay file edk2-x86_64-code.fd trong thu muc!
    echo QEMU se chay o che do Legacy BIOS.
    pause
)

:: CHAY QEMU
qemu-system-x86_64.exe ^
-L . ^
-pflash "edk2-x86_64-code.fd" ^
-fda "KOLIBRI.IMG" ^
-m 1024 ^
-vga std ^
-rtc base=localtime ^
-net none ^
-soundhw hda

if %errorlevel% neq 0 (
    echo.
    echo [LOI] QEMU thoat voi ma: %errorlevel%
    echo Hay kiem tra xem file KOLIBRI.IMG co nam cung thu muc nay khong.
    pause
)