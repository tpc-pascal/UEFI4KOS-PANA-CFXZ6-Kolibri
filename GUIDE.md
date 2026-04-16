# Hướng dẫn nếu bạn muốn tự làm

1. Tạo phân vùng FAT12/16/32 mang tên là KOLIBRIOS có kích thước tùy chọn (tối thiểu 100MB, càng nhiều càng tốt)
2. Tải bản [latest-raw.7z](https://builds.kolibrios.org/en_US/latest-raw.7z)
3. Giải nén và chạy Rawrite32Kos.exe để ghi file raw vào USB
4. Copy folder EFI từ USB vào KOLIBRIOS
5. Cấu hình KOLIBRI.INI (độ phân giải, boot từ .img hay phân vùng, đường dẫn hệ thống, chế độ sửa lỗi) và thêm DEVICES.DAT (file nhận diện các giao thức kết nối của thiết bị)
6. Gán phân vùng EFI bằng việc chạy [EFI_Config.bat](./Tools/EFI_Config.bat) và tùy chỉnh refind.conf (thêm menuentry)
```
menuentry "KolibriOS" {
    icon \EFI\refind\img\icons\os_kolibri.png
    volume "KOLIBRIOS"
    loader /EFI/BOOT/BOOTX64.EFI
    shortcuts K
}
```
