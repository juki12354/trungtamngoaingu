# Liên kết metadata, news và questions

Yêu cầu: ba bảng đang đứng riêng phải có quan hệ nghiệp vụ thật, giữ dữ liệu cũ,
bảo toàn đề đã giao và chạy trên SQLite/PostgreSQL; bộ SQL Server phải tương ứng.

- `news.authorId → users.id`, nullable, `ON DELETE SET NULL`: ghi tài khoản QTV
  tạo bài mới. Bài cũ không rõ tác giả giữ NULL, không gán tác giả phỏng đoán.
- `metadata.updatedBy → users.id`, nullable, `ON DELETE SET NULL`, cùng `updatedAt`:
  các thay đổi nội dung qua Admin ghi khóa `content:<table>` và người cập nhật.
  Các dấu mốc do hệ thống chạy tự động có `updatedBy=NULL`.
- `placement_attempt_questions.attemptToken → placement_attempts.token`, bắt buộc,
  `ON DELETE CASCADE`: mỗi lượt kiểm tra có các câu theo thứ tự.
- `placement_attempt_questions.questionId → questions.id`, nullable,
  `ON DELETE SET NULL`: giữ nguồn câu hỏi nếu còn trong ngân hàng. `snapshot`
  lưu nội dung, đáp án và ID gốc; sửa/xóa nguồn không làm đổi bài đã giao.
  `selected` lưu lựa chọn người làm. Không lộ snapshot có đáp án qua API công khai.

Một lượt có nhiều câu, một câu dùng trong nhiều lượt: quan hệ nhiều–nhiều qua
bảng nối. Mỗi `(attemptToken, position)` là duy nhất. Khi nộp, máy chủ chấm bản
chụp trong bảng nối; JSON cũ tiếp tục được giữ để tương thích và xem lại kết quả.
Các lượt cũ được bổ sung dòng nối khi khởi động; chạy lại không tạo trùng.

Số bảng ứng dụng: 17. Số khóa ngoại SQL Server: 19. Tất cả bảng đều nằm trong
cùng thành phần liên thông của sơ đồ. `dbo.sysdiagrams` của SSMS không thuộc
17 bảng ứng dụng.

SQL Server cũ: sao lưu, chạy `11-connect-independent-tables.sql`, sau đó chạy
`05-verify-relationships.sql`. Database chưa có tuyển dụng phải chạy `10` trước.
Database mới dùng `01` + `02`. Không cập nhật thủ công thư mục ZIP đã giải nén
của người dùng; bộ SQL chuẩn và ZIP được phát hành tại `database/sqlserver`.

Trong SSMS, Refresh Object Explorer, đóng/mở lại sơ đồ, chọn **Add Table** để
thêm `placement_attempt_questions`, rồi lưu sơ đồ. Khóa ngoại đã có trong
database; sơ đồ cũ không tự thêm bảng mới vào vùng vẽ.

## Kiểm chứng 05/11/2026

- Database SQL Server local đã sao lưu COPY_ONLY/CHECKSUM và RESTORE VERIFYONLY
  thành công trước nâng cấp. Script 11 chạy hai lần; 05 xác nhận đủ 17 bảng nối,
  19 khóa ngoại tin cậy, 0 mồ côi, 19 ghi khóa sai bị chặn, 6 xóa cha bị chặn,
  8 hành vi CASCADE/SET NULL đúng. Mọi bản ghi thử đều rollback.
- Tạo mới từ 01+02 và các kiểm tra 04+05 đạt trên database thử riêng. Kiểm tra
  nâng cấp riêng với câu nguồn còn/xóa và câu trả lời cũ đạt sau hai lượt nâng cấp.
- Nhóm API PostgreSQL: 15/15 đạt, gồm chuyển dữ liệu từ SQLite, liên kết mới,
  dữ liệu cũ, câu hỏi đã sửa/xóa và nộp lại bài. Dùng database test riêng.
- Build/lint đạt; 8 luồng trình duyệt liên quan đến đăng ký, CRUD, bài năng lực,
  tuyển dụng, giao diện và accessibility đạt.

Website tiếp tục dùng SQLite/PostgreSQL. SQL Server là bộ SQL độc lập cho đồ án;
thay đổi này không chuyển backend sang SQL Server hoặc cập nhật hosting.
