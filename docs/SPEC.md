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
GET /api/questions → câu hỏi không có đáp án; POST /api/placement → answers, kết quả.
POST /api/auth/register, /login, /logout; GET /api/auth/me.
POST /api/enrollments; GET/PATCH /api/student.
POST /api/contact; GET /api/admin/overview.
GET/POST/PATCH/DELETE /api/admin/:resource[/:id], tài nguyên trong whitelist.
Lỗi thống nhất `{error: {message}}`; 400 dữ liệu, 401 chưa đăng nhập, 403 quyền, 404 thiếu tài nguyên, 409 xung đột.

## Lưu trữ

users (học viên/admin), sessions, courses, teachers, classes (lịch, cơ sở), enrollments (điểm), questions, placement_results, news, contacts.
teachers 1—n classes; courses 1—n classes; users 1—n enrollments; classes 1—n enrollments.
Tài liệu học nằm trong course; lịch tuần trong class. Chưa tích hợp cổng thanh toán, email, chat hoặc kiểm tra nghe/nói.
