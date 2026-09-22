# Kết quả kiểm tra — 22/09/2026

Môi trường: Windows, Node.js 24.17.0. Kiểm thử trình duyệt bằng Chromium/Playwright.

## Kết quả

- `npm run lint`: **đạt**, không có lỗi hoặc cảnh báo ESLint.
- `npm test`: **36/36 đạt**, sử dụng database riêng.
- `npm run build`: **đạt**.
- `npm run test:e2e`: **9/9 đạt** trên bản đã build.
- Kiểm tra trực tiếp ở `http://127.0.0.1:5173`: đăng nhập qua proxy thành công, cổng học viên hiển thị lớp đã xác nhận, đăng xuất từ menu 320px thành công; không có lỗi JavaScript.
- `npm audit` khi cài thư viện: không phát hiện lỗ hổng.
- `npm run backup`: tạo được bản sao SQLite nhất quán. Số bản ghi sau migration khớp backup trước nâng cấp: 3 tài khoản, 6 khóa, 3 giáo viên, 6 lớp, 2 đăng ký, 15 câu hỏi, 1 kết quả test và 3 tin tức. `PRAGMA integrity_check` trả `ok`.
- Bộ slide HTML/PDF: 10 trang, có văn bản tiếng Việt, chuyển trang hoạt động; không phát hiện lỗi JavaScript hoặc tràn khung slide. PDF đã mở và kiểm tra trang kết xuất.
- Workflow GitHub Actions đã được thêm. Các lệnh tương ứng đã chạy local; chưa có lần chạy CI từ GitHub hoặc triển khai công khai.

## Các luồng đã kiểm tra

1. Tạo tài khoản → tìm khóa học → đăng ký lớp → Admin duyệt và nhập điểm → học viên xem trạng thái, điểm, tải tài liệu.
2. Bài test 15 câu → chọn đáp án → nộp bài → nhận điểm và gợi ý khóa học.
3. Admin thêm → sửa → xóa khóa học.
4. Gửi form liên hệ → Admin nhận nội dung.
5. 11 trang công khai tại 320, 768, 1024, 1440px: không tràn ngang toàn trang; không có lỗi JavaScript được phát hiện. Bảng rộng cuộn trong vùng bảng.
6. Axe tự động cho trang chủ, đăng ký, bài test và dashboard Admin: không có vi phạm phát hiện theo nhóm WCAG 2 A/AA và 2.1 AA được kiểm tra. Đây không phải chứng nhận accessibility toàn diện.
7. Đăng ký khách → Admin tiếp nhận/tạo tài khoản → duyệt lớp → upload PDF → học viên xem lịch tuần và tải tệp → đổi mật khẩu → đăng nhập bằng mật khẩu mới.
8. Tư vấn → cập nhật trạng thái/ghi chú → lọc kết quả; xuất Excel. Các mục Báo cáo, Tài liệu, Tư vấn, Lớp học kiểm tra tại 360/1440px và Axe tự động.
9. Tạo lớp trùng lịch giáo viên bị từ chối; đổi sang ca không trùng tạo được lớp qua giao diện.
10. Bổ sung 18 lớp bằng `seed:classes`: database hiện tại có 24 lớp, mỗi khóa 4 ca. Trình duyệt xác nhận trang Lịch khai giảng lọc được 4 lớp/khóa, form Đăng ký có đủ 4 lựa chọn và chi tiết khóa trẻ em có đủ 4 lớp. Ba kiểm thử mới kiểm tra đủ số buổi/ngày học, không trùng lịch, chạy lại không nhân đôi và không đổi lịch lớp đã có đăng ký.

API kiểm tra thêm: phân quyền, đăng xuất vô hiệu session, chống trùng đăng ký, sức chứa khi duyệt, dữ liệu ngày/điểm không hợp lệ, ẩn đáp án và tài liệu công khai, chống tự nâng quyền, hồ sơ và kết quả chỉ thuộc tài khoản hiện tại, database giữ dữ liệu sau khi mở lại.

Nâng cấp kiểm tra thêm: đổi email không tạo đăng ký trùng; liên kết tài khoản trùng lớp bị từ chối; không duyệt lớp hết hạn; đề kiểm tra cố định dù Admin sửa câu hỏi; nộp lại không tạo kết quả mới; token sai, tài khoản khác và lượt hết hạn bị từ chối; đổi mật khẩu kiểm tra mật khẩu cũ và thu hồi mọi phiên; tiếp nhận thất bại hoàn tác; trùng giáo viên/phòng và ca liền kề; PDF/DOCX, tệp giả dạng và quá 5 MB; hủy lớp đăng ký thu hồi quyền tải; báo cáo phân quyền và Excel đọc lại; migration dữ liệu cũ chạy lặp không ghi đè lịch đã sửa.

## Lỗi đã phát hiện và sửa

- Select tài khoản học viên tải dữ liệu bất đồng bộ: chuyển sang trạng thái có kiểm soát để giữ liên kết tài khoản khi Admin duyệt đăng ký.
- Nhãn ẩn trong bảng tạo overflow 320px: giới hạn phần tử định vị trong vùng bảng cuộn.
- Một số chữ phụ thiếu tương phản: điều chỉnh màu và kiểm tra lại với Axe.
- Bổ sung đăng xuất và liên kết đúng vai trò trong menu điện thoại.
- Proxy Vite mặc định đổi Host làm kiểm tra Origin từ chối đăng nhập ở cổng 5173: đặt `changeOrigin: false`, giữ kiểm tra chống yêu cầu khác nguồn tại API. Có regression test chạy qua Vite thật.
- Regression test Vite dùng cache tạm riêng, tránh ảnh hưởng dependency cache của server phát triển đang chạy.
- Kiểm tra base64 bằng biểu thức lặp gây vượt ngăn xếp với tệp lớn: thay bằng kiểm tra kích thước và so khớp mã hóa lại; tệp quá lớn trả lỗi 413.
- Đổi mật khẩu khiến hai chuyển hướng React tranh nhau và mất thông báo: chuyển về trang đăng nhập bằng điều hướng tải mới, đọc lại phiên đã thu hồi.
- Menu Admin nhiều mục làm grid tràn ngang trên điện thoại: đặt `min-width: 0` cho sidebar, giữ cuộn trong vùng menu/bảng.

Ảnh responsive: `test-results/home-320.png`, `home-768.png`, `home-1024.png`, `home-1440.png`. Dữ liệu kiểm thử không được ghi vào database demo đang chạy.
