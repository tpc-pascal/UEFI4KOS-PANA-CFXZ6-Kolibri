# --- 1. TU DONG YEU CAU QUYEN ADMIN (Bat buoc de doc PhysicalDrive) ---
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[INFO] Dang yeu cau quyen Admin de truy cap SSD vat ly..." -ForegroundColor Cyan
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- 2. THIET LAP MOI TRUONG ---
Set-Location $PSScriptRoot

$DiskDrive = "\\.\PhysicalDrive0" # Sua thanh PhysicalDrive1 neu SSD la Disk 1
$UefiBios = "edk2-x86_64-code.fd"
$VmName = "rEFInd SSD Boot Test"

Write-Host "[INFO] Dang khoi chay rEFInd tu SSD vat ly: $DiskDrive" -ForegroundColor Green
Write-Host ""

# --- 3. KIEM TRA DIEU KIEN TRUOC KHI CHAY ---

# Kiem tra file Firmware UEFI
if (!(Test-Path $UefiBios)) {
    Write-Host "[CANH BAO] Khong tim thay file $UefiBios!" -ForegroundColor Yellow
    Write-Host "QEMU co the khong boot duoc vao che do UEFI." -ForegroundColor Yellow
}

# Kiem tra quyen truy cap o dia vat ly
try {
    $diskTest = [System.IO.File]::Open($DiskDrive, 'Open', 'Read', 'ReadWrite')
    $diskTest.Close()
} catch {
    Write-Host "[LOI] Khong the truy cap $DiskDrive!" -ForegroundColor Red
    Write-Host "Nguyen nhan: O dia dang bi khoa, sai so Disk, hoac dang mo WinImage/DiskGenius." -ForegroundColor Yellow
    pause
    exit
}

# --- 4. CHAY QEMU ---
$qemuArgs = @(
    "-L", ".",
    "-m", "1G",
    "-pflash", "$UefiBios",
    "-drive", "file=$DiskDrive,format=raw,if=ide",
    "-vga", "std",
    "-rtc", "base=localtime",
    "-net", "none",
    "-name", "$VmName"
)

try {
    Write-Host "Dang kich hoat QEMU..." -ForegroundColor Cyan
    # Chay va doi den khi tat VM
    Start-Process "qemu-system-x86_64.exe" -ArgumentList $qemuArgs -Wait -NoNewWindow
} catch {
    Write-Host ""
    Write-Host "[LOI] QEMU gap su co khi khoi chay." -ForegroundColor Red
    Write-Host "Hay dam bao qemu-system-x86_64.exe da co trong PATH hoac cung thu muc." -ForegroundColor Yellow
    pause
}

Write-Host ""
Write-Host "Chuong trinh ket thuc." -ForegroundColor Gray