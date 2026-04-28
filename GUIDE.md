# Hướng dẫn

### Real Hardware
1. Tạo phân vùng FAT12/16/32 mang tên là KOLIBRIOS có kích thước tùy chọn (tối thiểu 50MB, càng nhiều càng tốt)
2. Tải bản [latest-raw.7z](https://builds.kolibrios.org/en_US/latest-raw.7z)
3. Giải nén và chạy Rawrite32Kos.exe để ghi file raw vào USB
4. Copy folder EFI từ USB vào KOLIBRIOS
5. Cấu hình KOLIBRI.INI (độ phân giải, boot từ .img hay phân vùng, đường dẫn hệ thống, chế độ sửa lỗi) và thêm DEVICES.DAT (file nhận diện các giao thức kết nối của thiết bị)
6. Gán phân vùng EFI bằng việc run [EFI_Config.ps1](./Tools/EFI_Config.ps1) và cấu hình refind.conf (thêm menuentry)
```
menuentry "KolibriOS" {
    icon \EFI\refind\img\icons\os_kolibri.png
    volume "KOLIBRIOS"
    loader /EFI/BOOT/BOOTX64.EFI
    shortcuts K
}
```
7. (optional) Sử dụng [7-Zip](./Tools/7-Zip.exe) hoặc [WinImage](./Tools/WinImage.exe) để bổ sung thêm tính năng vào file img

---

### Virtual Machine
1. Tải bản [latest-img.7z](https://builds.kolibrios.org/en_US/latest-img.7z)
2. Install [qemu-w64-setup-20260422.exe](./Tools/qemu-w64-setup-20260422.exe) và move các file theo cấu trúc bên dưới
3. Run file [KOLIBRI_IMG.ps1](./Tools/KOLIBRI_IMG.ps1) để load trực tiếp lên RAM hoặc [KOLIBRI_rEFInd.ps1](./Tools/KOLIBRI_rEFInd.ps1) để sử dụng thông qua rEFInd

```
Tools/
├── 7-Zip.exe
├── bios.bin
├── EFI_Config.ps1
├── KOLIBRI_IMG.ps1
├── KOLIBRI_rEFInd.ps1
├── KOLIBRI.IMG                 # File floppy image
├── edk2-x86_64-code.fd
├── qemu-w64-setup-20260422.exe
├── qemu-system-x86_64.exe
├── SDL2.dll
├── vgabios-stdvga.bin
└── WinImage.exe
```