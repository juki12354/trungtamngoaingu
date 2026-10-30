# Kiểm tra quan hệ bảng — 22/10/2026

**Kết luận: 11 khóa ngoại trong bản SQL Server đều đúng với mô hình hiện tại của website.** Đã đối chiếu file `01-schema.sql` với metadata của database `TrungTamNgoaiNgu` trên instance `manh\MAYAO`, sau đó thử thao tác thật trong transaction được rollback.

## Toàn bộ liên kết

Mỗi dòng là một quan hệ một–nhiều từ bảng cha đến bảng con. Cột NULL cho phép bản ghi con tạm thời không gắn với bản ghi cha.

| Cột bảng con | Khóa bảng cha | Cho NULL | Khi xóa cha | Kết quả |
| --- | --- | --- | --- | --- |
| `classes.courseId` | `courses.id` | Không | Chặn khi còn lớp | Đúng |
| `classes.teacherId` | `teachers.id` | Không | Chặn khi còn lớp | Đúng |
| `enrollments.classId` | `classes.id` | Không | Chặn khi còn đăng ký | Đúng |
| `enrollments.userId` | `users.id` | Có | Chặn khi còn đăng ký đã gắn tài khoản | Đúng |
| `enrollments.verifiedBy` | `users.id` | Có | Chặn khi còn đăng ký ghi người xác minh | Đúng |
| `materials.classId` | `classes.id` | Không | Chặn khi còn tài liệu | Đúng |
| `placement_attempts.userId` | `users.id` | Có | Chặn khi còn lượt thi gắn tài khoản | Đúng |
| `placement_results.userId` | `users.id` | Có | Đặt NULL, giữ kết quả | Đúng |
| `contacts.courseId` | `courses.id` | Có | Đặt NULL, giữ yêu cầu tư vấn | Đúng |
| `sessions.userId` | `users.id` | Không | Xóa phiên theo tài khoản | Đúng |
| `audit_logs.actorId` | `users.id` | Có | Đặt NULL, giữ nhật ký | Đúng |

Toàn bộ cột khóa ngoại có kiểu `INT` tương ứng với khóa chính `INT`. Cả 11 khóa ngoại có `is_disabled=0`, `is_not_trusted=0`; hành vi cập nhật khóa chính là `NO ACTION`.

Một học viên đăng ký nhiều lớp và một lớp có nhiều học viên: đây là quan hệ nhiều–nhiều được tách qua bảng `enrollments`, đúng thiết kế. Không cần thêm liên kết trực tiếp từ học viên đến khóa học vì đã xác định được qua `enrollments → classes → courses`.

## Bằng chứng kiểm tra

File thực thi: [05-verify-relationships.sql](05-verify-relationships.sql).

- So khớp 11 liên kết dự kiến với database thật, gồm đích, kiểu dữ liệu, NULL, trạng thái và hành vi xóa: đạt.
- Kiểm tra toàn bộ 11 liên kết bằng LEFT JOIN: **0 bản ghi mồ côi**.
- Thử ghi ID cha không tồn tại tại từng cột khóa ngoại: **11/11 bị chặn với lỗi 547**.
- Thử xóa khóa học đang có lớp, giáo viên đang dạy lớp, lớp đang có đăng ký/tài liệu và tài khoản còn đăng ký/lượt thi: **4/4 bị chặn**.
- Sau khi gỡ các liên kết đang chặn: xóa tài khoản thu hồi phiên, giữ kết quả thi và nhật ký với khóa ngoại NULL; xóa khóa học giữ yêu cầu tư vấn với `courseId=NULL`: **4/4 hành vi đạt**.
- `DBCC CHECKCONSTRAINTS WITH ALL_CONSTRAINTS`: không trả bản ghi vi phạm.
- Tất cả bản ghi thử đã rollback; giá trị ID tự tăng có thể có khoảng trống bình thường sau các lần thử.

`NO ACTION` được kiểm tra trước các thao tác CASCADE/SET NULL: một tài khoản còn đăng ký hoặc lượt thi sẽ chưa xóa được. Đây là bảo vệ dữ liệu học tập; cần xử lý các liên kết chặn trước nếu muốn xóa tài khoản.

## Các điểm cần hiểu khi xem sơ đồ

1. `questions`, `news`, `metadata` là bảng độc lập trong thiết kế này. Bộ câu hỏi giao cho từng lượt thi được chụp vào `placement_attempts.questions`; phần xem lại nằm trong JSON của kết quả. Giữ bản chụp giúp sửa/xóa câu hỏi gốc không làm đổi đề thi cũ. Không có khóa ngoại trực tiếp từ các trường JSON.
2. `enrollments.verifiedBy` là liên kết thứ hai đến `users`, khác với `enrollments.userId`. Đã bổ sung liên kết này vào sơ đồ README.
3. `audit_logs.recordId` tham chiếu nghiệp vụ theo `resource` như tài liệu, đăng ký… nên không thể dùng một khóa ngoại duy nhất đến tất cả bảng. Nhật ký cần được giữ ngay cả sau khi đối tượng bị xóa.
4. Cơ sở, phòng và thứ/giờ học đang lưu trong `classes`. Không có bảng cơ sở/phòng/lịch riêng để nối; đây là phạm vi thiết kế hiện tại. Khi cần quản lý cơ sở và phòng độc lập có thể chuẩn hóa thêm các bảng đó.

## Giới hạn nghiệp vụ tại tầng database

Các liên kết hiện tại bảo đảm ID tồn tại và hành vi xóa đúng, nhưng không thay thế toàn bộ kiểm tra nghiệp vụ:

- Khóa ngoại `enrollments.userId → users.id` không bảo đảm `role='student'`; `verifiedBy → users.id` không tự bảo đảm `role='admin'`. Backend hiện có kiểm tra vai trò; khi tích hợp SQL Server phải giữ các bước đó.
- Chống trùng lịch giáo viên/phòng, chống duyệt vượt sĩ số và liên kết lượt thi với kết quả đang nằm trong backend/JSON, không được thực thi chỉ bằng khóa ngoại.
- Điểm kỹ năng, danh sách thứ học và lựa chọn câu hỏi là JSON; kiểm tra `ISJSON` chỉ bảo đảm cú pháp. Cấu trúc và giá trị bên trong cần validation nghiệp vụ.

Không phát hiện khóa ngoại trỏ nhầm hoặc cần đổi bảng đích. Bản cập nhật này bổ sung kiểm tra và hoàn thiện tài liệu/sơ đồ, giữ nguyên cấu trúc 14 bảng.

Database có thêm `dbo.sysdiagrams` do chức năng Database Diagrams của SSMS tạo. Đây là bảng lưu sơ đồ, không phải bảng nghiệp vụ thiếu liên kết. Đã sửa bộ kiểm tra cũ để không đếm bảng này vào 14 bảng ứng dụng; trước khi sửa, việc lưu sơ đồ khiến phép kiểm tra số bảng báo lỗi nhầm.
