# Kết quả kiểm tra — 21/09/2026

Môi trường: Windows, Node.js 24.17.0. Kiểm thử trình duyệt bằng Chromium/Playwright.

## Kết quả

- `npm test`: **16/16 đạt**, sử dụng database riêng.
- `npm run build`: **đạt**.
- `npm run test:e2e`: **6/6 đạt** trên bản đã build.
- Kiểm tra trực tiếp ở `http://127.0.0.1:5173`: đăng nhập qua proxy thành công, cổng học viên hiển thị lớp đã xác nhận, đăng xuất từ menu 320px thành công; không có lỗi JavaScript.
- `npm audit` khi cài thư viện: không phát hiện lỗ hổng.

## Các luồng đã kiểm tra

1. Tạo tài khoản → tìm khóa học → đăng ký lớp → Admin duyệt và nhập điểm → học viên xem trạng thái, điểm, tải tài liệu.
2. Bài test 15 câu → chọn đáp án → nộp bài → nhận điểm và gợi ý khóa học.
3. Admin thêm → sửa → xóa khóa học.
4. Gửi form liên hệ → Admin nhận nội dung.
5. 11 trang công khai tại 320, 768, 1024, 1440px: không tràn ngang toàn trang; không có lỗi JavaScript được phát hiện. Bảng rộng cuộn trong vùng bảng.
6. Axe tự động cho trang chủ, đăng ký, bài test và dashboard Admin: không có vi phạm phát hiện theo nhóm WCAG 2 A/AA và 2.1 AA được kiểm tra. Đây không phải chứng nhận accessibility toàn diện.

API kiểm tra thêm: phân quyền, đăng xuất vô hiệu session, chống trùng đăng ký, sức chứa khi duyệt, dữ liệu ngày/điểm không hợp lệ, ẩn đáp án và tài liệu công khai, chống tự nâng quyền, hồ sơ và kết quả chỉ thuộc tài khoản hiện tại, database giữ dữ liệu sau khi mở lại.

## Lỗi đã phát hiện và sửa

- Select tài khoản học viên tải dữ liệu bất đồng bộ: chuyển sang trạng thái có kiểm soát để giữ liên kết tài khoản khi Admin duyệt đăng ký.
- Nhãn ẩn trong bảng tạo overflow 320px: giới hạn phần tử định vị trong vùng bảng cuộn.
- Một số chữ phụ thiếu tương phản: điều chỉnh màu và kiểm tra lại với Axe.
- Bổ sung đăng xuất và liên kết đúng vai trò trong menu điện thoại.
- Proxy Vite mặc định đổi Host làm kiểm tra Origin từ chối đăng nhập ở cổng 5173: đặt `changeOrigin: false`, giữ kiểm tra chống yêu cầu khác nguồn tại API. Có regression test chạy qua Vite thật.
- Regression test Vite dùng cache tạm riêng, tránh ảnh hưởng dependency cache của server phát triển đang chạy.

Ảnh responsive: `test-results/home-320.png`, `home-768.png`, `home-1024.png`, `home-1440.png`. Dữ liệu kiểm thử không được ghi vào database demo đang chạy.
