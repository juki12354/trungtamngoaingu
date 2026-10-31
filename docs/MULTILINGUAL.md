# Trung tâm đa ngôn ngữ — cập nhật 31/10/2026

Giao diện tiếng Việt của Vinh Language Center cung cấp chương trình cho 16 ngôn ngữ: Anh (`en`), Trung (`zh`), Hàn (`ko`), Nhật (`ja`), Pháp (`fr`), Đức (`de`), Ý (`it`), Tây Ban Nha (`es`), Bồ Đào Nha (`pt`), Nga (`ru`), Ả Rập (`ar`), Hindi (`hi`), Thái (`th`), Indonesia (`id`), Việt (`vi`) và Thổ Nhĩ Kỳ (`tr`). Đây là danh mục đang triển khai của đồ án, không phải danh sách đầy đủ mọi ngôn ngữ trên thế giới.

## Nội dung và trải nghiệm

- Có 99 khóa, 24 giáo viên; giữ nội dung tiếng Anh, thêm các ngôn ngữ mới và bổ sung khóa theo từng cấp độ.
- Database local đủ ca tiếng Anh có 302 lớp; database demo mới chưa chạy `seed:classes` có 284 lớp. Seed theo cấp độ thử nhiều khung giờ và kiểm tra trùng giáo viên/phòng trước khi thêm lớp.
- Trang chủ chọn ngôn ngữ; danh sách khóa, giáo viên và lịch lớp có bộ lọc theo ngôn ngữ. Đăng ký, học thử, tư vấn, lộ trình đều chọn đúng chương trình.
- Admin chọn ngôn ngữ của khóa/câu hỏi và nhiều ngôn ngữ giảng dạy cho giáo viên; bộ chọn giáo viên của lớp lọc theo ngôn ngữ khóa. API từ chối gán giáo viên không phù hợp hoặc bỏ ngôn ngữ đang có lớp liên kết.
- 16 ảnh minh họa SVG riêng cho từng ngôn ngữ, có lời chào bản ngữ; hình ảnh tải từ dự án, không phụ thuộc dịch vụ bên ngoài.

## Bài khảo sát

Bài mới có 288 câu năng lực theo cấp độ, gồm từ vựng, ngữ pháp và đọc hiểu; mỗi lượt có 15–21 câu. Kết quả phân tích kỹ năng, nền tảng và gợi ý lớp đang mở đúng cấp độ. Giữ 175 câu khảo sát cũ để tương thích dữ liệu trước nâng cấp. Không quy đổi điểm sàng lọc thành chứng chỉ. Xem [quy tắc chấm và xếp lớp](COMPETENCY.md).

Server chỉ gửi câu hỏi của ngôn ngữ được chọn và không gửi đáp án trước khi nộp. Mỗi lượt giữ bản chụp đề và ngôn ngữ; nộp lại giữ một kết quả. Ngôn ngữ từ lượt thi quyết định gợi ý khóa, không tin trường `language` do client gửi lúc nộp. Kết quả học viên lưu cả ngôn ngữ.

## Nâng cấp và dữ liệu cũ

SQLite/PostgreSQL: ứng dụng tự thêm các cột mới, đặt dữ liệu cũ là tiếng Anh và thêm mẫu đa ngôn ngữ trong transaction. Metadata `multilingual-v1` giúp chạy lại không thêm trùng hoặc ghi đè nội dung Admin đã chỉnh. Thao tác vẫn giữ tài khoản, đăng ký, phiên đăng nhập, điểm và tài liệu hiện có.

```powershell
npm.cmd run backup
npm.cmd run seed:languages
npm.cmd run dev
```

Mở `http://127.0.0.1:5173/khoa-hoc`. `seed:languages` dùng cùng kết nối database với ứng dụng; tránh đặt DATABASE_URL cloud nếu chỉ muốn nâng cấp local.

SQL Server: dùng `06` + `07` để bổ sung đa ngôn ngữ, sau đó `08` + `09` để bổ sung cấp độ và đề năng lực. Bộ `01` + `02` tạo bản mới đủ dữ liệu. Không đổi backend sang SQL Server; xem [hướng dẫn](../database/sqlserver/README.md).

## Giới hạn và phạm vi

Hồ sơ giáo viên, học phí, thành tích, cơ sở và lịch là mẫu phục vụ đồ án. Tiếng Trung dùng chữ giản thể; tiếng Ả Rập giới thiệu dạng tiêu chuẩn hiện đại. Khóa theo cấp độ và câu hỏi là chương trình minh họa, chưa có hiệu chuẩn chứng nhận đầu ra. Không nhân bản nội dung IELTS tiếng Anh sang ngôn ngữ khác.

Danh mục ngôn ngữ trong `shared/languages.js` dùng chung cho API và React. Thêm ngôn ngữ mới cần bổ sung chương trình, giáo viên, câu hỏi và hình ảnh tương ứng rồi tăng phiên bản seed; Admin chỉ sửa nội dung thuộc danh mục đã triển khai.
