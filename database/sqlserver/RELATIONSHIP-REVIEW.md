# Kiểm tra quan hệ bảng — cập nhật 05/11/2026

**Kết luận: 19 khóa ngoại đúng và toàn bộ 17 bảng ứng dụng nằm trong cùng một sơ đồ nối.** Đã đối chiếu schema với database `TrungTamNgoaiNgu` trên instance `manh\MAYAO` và thử ghi/xóa trong transaction rollback. Bốn liên kết mới nối tin tức, metadata và ngân hàng câu hỏi.

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
| `teacher_applications.userId` | `users.id` | Không | Chặn khi còn CV của tài khoản | Đúng |
| `teacher_applications.reviewedBy` | `users.id` | Có | Chặn khi còn đánh giá tuyển dụng | Đúng |
| `teacher_assessments.applicationId` | `teacher_applications.id` | Không | Chặn khi hồ sơ còn đề/bài làm | Đúng |
| `teacher_assessments.createdBy` | `users.id` | Không | Chặn khi còn đề do QTV giao | Đúng |
| `news.authorId` | `users.id` | Có | Đặt NULL, giữ bài viết | Đúng |
| `metadata.updatedBy` | `users.id` | Có | Đặt NULL, giữ dấu mốc | Đúng |
| `placement_attempt_questions.attemptToken` | `placement_attempts.token` | Không | Xóa dòng câu hỏi theo lượt thi | Đúng |
| `placement_attempt_questions.questionId` | `questions.id` | Có | Đặt NULL, giữ bản chụp đề | Đúng |

Cột `attemptToken` và khóa cha `token` cùng kiểu `VARCHAR(128)`; các khóa còn lại cùng kiểu `INT`. Cả 19 khóa ngoại có `is_disabled=0`, `is_not_trusted=0`; hành vi cập nhật khóa chính là `NO ACTION`.

Một học viên đăng ký nhiều lớp và một lớp có nhiều học viên: đây là quan hệ nhiều–nhiều được tách qua bảng `enrollments`, đúng thiết kế. Không cần thêm liên kết trực tiếp từ học viên đến khóa học vì đã xác định được qua `enrollments → classes → courses`.

## Bằng chứng kiểm tra

File thực thi: [05-verify-relationships.sql](05-verify-relationships.sql).

- So khớp 19 liên kết dự kiến với database thật: đạt. Duyệt đồ thị từ `users` đến được đủ 17 bảng ứng dụng.
- Kiểm tra toàn bộ 19 liên kết bằng LEFT JOIN: **0 bản ghi mồ côi**.
- Thử ghi khóa cha không tồn tại tại từng cột khóa ngoại: **19/19 bị chặn với lỗi 547**.
- Thử xóa cha còn liên kết, gồm hồ sơ còn bài kiểm tra và tài khoản còn dữ liệu tuyển dụng: **6/6 bị chặn**.
- Kiểm tra CASCADE/SET NULL: giữ bản chụp sau xóa câu nguồn; xóa dòng nối theo lượt thi; giữ bài viết và metadata sau xóa tài khoản; cùng các hành vi cũ: **8/8 đạt**.
- `DBCC CHECKCONSTRAINTS WITH ALL_CONSTRAINTS`: không trả bản ghi vi phạm.
- Tất cả bản ghi thử đã rollback; giá trị ID tự tăng có thể có khoảng trống bình thường sau các lần thử.

`NO ACTION` được kiểm tra trước các thao tác CASCADE/SET NULL: một tài khoản còn đăng ký hoặc lượt thi sẽ chưa xóa được. Đây là bảo vệ dữ liệu học tập; cần xử lý các liên kết chặn trước nếu muốn xóa tài khoản.

## Các điểm cần hiểu khi xem sơ đồ

1. `questions`, `news`, `metadata` đã có liên kết thật qua bảng nối lượt thi, tác giả và người cập nhật. Nội dung đề tại thời điểm giao nằm trong `placement_attempt_questions.snapshot`; sửa/xóa câu nguồn không làm đổi đề. JSON cũ vẫn được giữ cho lịch sử và tương thích.
2. `enrollments.verifiedBy` là liên kết thứ hai đến `users`, khác với `enrollments.userId`. Đã bổ sung liên kết này vào sơ đồ README.
3. `audit_logs.recordId` tham chiếu nghiệp vụ theo `resource` như tài liệu, đăng ký… nên không thể dùng một khóa ngoại duy nhất đến tất cả bảng. Nhật ký cần được giữ ngay cả sau khi đối tượng bị xóa.
4. Cơ sở, phòng và thứ/giờ học đang lưu trong `classes`. Không có bảng cơ sở/phòng/lịch riêng để nối; đây là phạm vi thiết kế hiện tại. Khi cần quản lý cơ sở và phòng độc lập có thể chuẩn hóa thêm các bảng đó.

## Giới hạn nghiệp vụ tại tầng database

Các liên kết hiện tại bảo đảm ID tồn tại và hành vi xóa đúng, nhưng không thay thế toàn bộ kiểm tra nghiệp vụ:

- Khóa ngoại `enrollments.userId → users.id` không bảo đảm `role='student'`; `verifiedBy → users.id` không tự bảo đảm `role='admin'`. Backend hiện có kiểm tra vai trò; khi tích hợp SQL Server phải giữ các bước đó.
- Chống trùng lịch giáo viên/phòng, chống duyệt vượt sĩ số và liên kết lượt thi với kết quả đang nằm trong backend/JSON, không được thực thi chỉ bằng khóa ngoại.
- Điểm kỹ năng, danh sách thứ học và lựa chọn câu hỏi là JSON; kiểm tra `ISJSON` chỉ bảo đảm cú pháp. Cấu trúc và giá trị bên trong cần validation nghiệp vụ.

Không phát hiện khóa ngoại trỏ nhầm. Bản cập nhật liên kết bổ sung một bảng nối, tổng cộng 17 bảng. Quyền QTV và điều kiện hoàn thành bài kiểm tra mới nhất trước khi duyệt vẫn được backend thực thi.

`dbo.sysdiagrams` do SSMS tạo để lưu sơ đồ, không phải bảng nghiệp vụ. Bộ kiểm tra không đếm bảng này vào 17 bảng ứng dụng. Sau nâng cấp, mở lại sơ đồ và Add Table `placement_attempt_questions` để thấy đầy đủ đường nối mới.
