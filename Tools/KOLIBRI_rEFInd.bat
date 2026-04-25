@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /B
)

echo [INFO] Dang khoi chay rEFInd tu SSD vat ly (Che do UEFI)...
echo.

:: Di chuyen den thu muc chua file bat nay
cd /d "%~dp0"

:: Thiet lap o dia vat ly (Sua thanh PhysicalDrive1 neu SSD la Disk 1)
set DISK_DRIVE=\\.\PhysicalDrive0
set UEFI_BIOS=edk2-x86_64-code.fd

:: CHAY QEMU
:: -L . : Su dung cac file ho tro (bios.bin, vgabios) tai cho
:: -pflash : Su dung firmware UEFI moi thay cho -bios
qemu-system-x86_64.exe ^
-L . ^
-m 1G ^
-pflash "%UEFI_BIOS%" ^
-drive file=%DISK_DRIVE%,format=raw,if=ide ^
-vga std ^
-rtc base=localtime ^
-net none ^
-name "rEFInd SSD Boot Test"

if %errorlevel% neq 0 (
    echo.
    echo [LOI] QEMU thoat voi ma: %errorlevel%
    echo Kiem tra xem SSD co dang bi khoa boi WinImage hoac sai so PhysicalDrive khong.
    pause
)