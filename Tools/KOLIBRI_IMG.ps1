# --- 1. TU DONG YEU CAU QUYEN ADMIN ---
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[INFO] Dang yeu cau quyen Admin de chay QEMU..." -ForegroundColor Cyan
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- 2. THIET LAP MOI TRUONG ---
# Di chuyen den thu muc chua script (tuong duong %~dp0)
Set-Location $PSScriptRoot

$Firmware = "edk2-x86_64-code.fd"
$DiskImg = "KOLIBRI.IMG"

Write-Host "[INFO] Dang khoi chay KolibriOS tu file $DiskImg (Che do UEFI)..." -ForegroundColor Green
Write-Host ""

# --- 3. KIEM TRA FILE TRUOC KHI CHAY ---
if (!(Test-Path $Firmware)) {
    Write-Host "[CANH BAO] Khong tim thay file $Firmware trong thu muc!" -ForegroundColor Yellow
    Write-Host "QEMU se chay o che do Legacy BIOS." -ForegroundColor Yellow
    $FirmwareParam = "" # Bo tham so pflash neu thieu firmware
} else {
    $FirmwareParam = "-pflash `"$Firmware`""
}

if (!(Test-Path $DiskImg)) {
    Write-Host "[LOI] Khong tim thay file $DiskImg! Vui long kiem tra lai." -ForegroundColor Red
    pause
    exit
}

# --- 4. CHAY QEMU ---
# Su dung mang de quan ly tham so cho sach se
$qemuArgs = @(
    "-L", ".",
    "-fda", "$DiskImg",
    "-m", "1024",
    "-vga", "std",
    "-rtc", "base=localtime",
    "-net", "none",
    "-soundhw", "hda"
)

# Neu co firmware thi them vao tham so
if ($FirmwareParam) { $qemuArgs += "-pflash", "$Firmware" }

try {
    # Chay QEMU va doi cho den khi dong cua so
    Start-Process "qemu-system-x86_64.exe" -ArgumentList $qemuArgs -Wait -NoNewWindow
} catch {
    Write-Host ""
    Write-Host "[LOI] Khong the khoi chay QEMU. Hay kiem tra xem qemu-system-x86_64.exe co trong PATH khong." -ForegroundColor Red
    pause
}

Write-Host ""
Write-Host "Chuong trinh ket thuc." -ForegroundColor Gray