# Vinh English Center

Website đồ án bằng React, giao diện tiếng Việt; tên trung tâm, hình ảnh và dữ liệu là minh họa.

## Phạm vi và tiêu chí nghiệm thu

- Khách xem giới thiệu, 6 khóa học, chi tiết học phí, giáo viên, lịch khai giảng, tin tức và liên hệ.
- Tìm/lọc khóa học; đăng ký một lớp với kiểm tra dữ liệu, chống trùng và lưu SQLite.
- Bài kiểm tra 15 câu, chấm tại server, gợi ý khóa học. Chỉ đánh giá tham khảo ngữ pháp/từ vựng, không thay chứng chỉ CEFR.
- Đăng ký tài khoản, đăng nhập, đăng xuất; mật khẩu băm, cookie HttpOnly; phân quyền ở API.
- Học viên xem đăng ký, lịch học, điểm, tài liệu và sửa hồ sơ của mình.
- Admin CRUD khóa học, giáo viên, học viên, lớp/lịch, câu hỏi, tin tức; duyệt/hủy đăng ký và nhập điểm.
- Kiểm tra sức chứa khi xác nhận; không xóa dữ liệu đang có quan hệ tham chiếu.
- Responsive, trạng thái tải/lỗi/rỗng, bàn phím và nhãn form.

## Các chặng triển khai

1. Database, dữ liệu mẫu, API và kiểm thử các luồng quan trọng.
2. Trang công khai React, đăng ký và kiểm tra trình độ.
3. Tài khoản học viên, quản trị CRUD và tích hợp.
4. Build, kiểm thử trình duyệt desktop/mobile, tài liệu chạy.

## Kiến trúc và hợp đồng API

React + Vite → Express API `/api` → SQLite (`node:sqlite`, Node 24+).
GET /api/catalog → courses, teachers, classes, news (không có dữ liệu học viên).
GET /api/questions → câu hỏi giới thiệu không có đáp án.
POST /api/placement/attempts → token, expiresAt, questions cố định.
POST /api/placement → token + answers; trả kết quả, review và courseId.
POST /api/auth/register, /login, /logout; GET /api/auth/me.
POST /api/auth/password → currentPassword, newPassword; thu hồi mọi phiên.
POST /api/enrollments; GET/PATCH /api/student.
POST /api/contact; GET /api/admin/overview.
GET/POST/PATCH/DELETE /api/admin/:resource[/:id], tài nguyên trong whitelist.
POST /api/admin/enrollments/:id/intake → verified=true, mode=create|existing và password hoặc userId.
GET/POST/DELETE /api/admin/materials[/:id]; tải lên JSON chứa classId, title, lesson, filename, content base64.
GET /api/materials/:id/download → chỉ Admin hoặc học viên đã xác nhận của lớp.
GET /api/admin/reports[?from=YYYY-MM-DD&to=YYYY-MM-DD].
GET /api/admin/reports/export.xlsx → workbook 3 sheet.
Lỗi thống nhất `{error: {message}}`; 400 dữ liệu, 401 chưa đăng nhập, 403 quyền, 404 thiếu tài nguyên, 409 xung đột.

## Lưu trữ

users (học viên/admin), sessions, courses, teachers, classes (lịch, cơ sở), enrollments (điểm), questions, placement_results, news, contacts.
teachers 1—n classes; courses 1—n classes; users 1—n enrollments; classes 1—n enrollments.
Ghi chú học nằm trong course; tệp nằm ở materials liên kết lớp. Lịch tuần có weekdays (ISO 1–7), startTime/endTime, room, campus, status. Các lượt kiểm tra nằm trong placement_attempts, thao tác tiếp nhận/tài liệu có audit_logs. Chưa tích hợp cổng thanh toán, email, chat hoặc kiểm tra nghe/nói.

## Tiêu chí nghiệm thu nâng cấp

- Đăng ký trùng bị chặn cả sau khi đổi email; không liên kết một tài khoản vào hai đăng ký đang hoạt động của cùng lớp.
- Đăng ký/duyệt mới chỉ khi lớp đang tuyển sinh và còn chỗ. Điểm lớp đã học vẫn có thể cập nhật.
- Lịch trùng giáo viên hoặc phòng cùng cơ sở bị từ chối khi khoảng ngày, ngày trong tuần và giờ học giao nhau. Ca liền kề được phép.
- Mỗi bài test giữ nguyên câu hỏi/đáp án lúc bắt đầu, hết hạn sau 30 phút; nộp lại trả cùng kết quả. Xem lại đáp án sau nộp.
- Admin xác minh trước khi liên kết đăng ký khách. Tạo tài khoản và liên kết là một transaction.
- PDF/DOCX tối đa 5 MB; từ chối tải khi học viên chưa xác nhận hoặc đăng ký đã hủy.
- Tư vấn có trạng thái mới/đã liên hệ/hoàn tất và ghi chú.
- Báo cáo đăng ký theo tháng theo giờ Việt Nam; sĩ số lớp là số liệu hiện tại. Xuất Excel thật và kiểm tra đọc lại.
- Đổi mật khẩu kiểm tra mật khẩu hiện tại; thu hồi toàn bộ phiên cũ.
