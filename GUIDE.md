1. Tạo phân vùng FAT32 có kích thước tùy chọn (tối thiểu 100MB, càng nhiều càng tốt)
2. Tải bản [latest-raw.7z](https://builds.kolibrios.org/en_US/latest-raw.7z)
3. Giải nén và chạy Rawrite32Kos.exe để ghi file raw vào phân vùng / ổ cứng (khuyến khích là USB)
4. (Optional) Mở rộng bằng cách tải [latest-iso.7z](https://builds.kolibrios.org/en_US/latest-iso.7z) để thay thế cho KOLIBRI.IMG
5. Copy folder EFI vào phân vùng bạn đã tạo
6. Cấu hình KOLIBRI.INI (độ phân giải, boot từ .img hay phân vùng, đường dẫn hệ thống, chế độ sửa lỗi) và thêm DEVICES.DAT
7. Cấu hình phân vùng EFI của máy để trỏ vào BOOTX64.EFI
