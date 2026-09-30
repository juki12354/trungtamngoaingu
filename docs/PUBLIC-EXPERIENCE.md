# Bổ sung trải nghiệm tìm khóa học

Phạm vi từ tài liệu tham khảo ngày 30/09/2026: bổ sung TOEIC; bài kiểm tra mẫu 25 câu; quốc tịch giáo viên; lộ trình theo mục tiêu; tìm cơ sở; lọc lịch theo khóa, cơ sở, ngày, ca, học phí và chỗ trống; đăng ký học thử/tư vấn có độ tuổi, khóa quan tâm, cơ sở và mục tiêu. Góc học tập có tìm kiếm và lọc chủ đề.

Giữ React/Vite, Express/SQLite và giao diện hiện có. Form dùng API `/api/contact`, lưu loại yêu cầu và các lựa chọn riêng để Admin tiếp nhận. Yêu cầu học thử chưa phải lịch đã được xác nhận. Giữ tương thích form liên hệ cũ. Cơ sở, giáo viên, kết quả và học phí là dữ liệu minh họa.

Dữ liệu mẫu mới dùng lệnh bổ sung có thể chạy lại, không ghi đè nội dung Admin đã sửa. Migration chỉ thêm cột. Quốc tịch chưa có dữ liệu sẽ để trống, không suy đoán từ tên.

Kiểm chứng: lưu/đọc yêu cầu qua API và quyền Admin; dữ liệu cũ và chạy seed lặp; bộ lọc trên trình duyệt; liên kết cơ sở → lịch → đăng ký; làm hết bài kiểm tra; responsive và axe.

API `/api/catalog` bổ sung `campuses` (name, province, address, phone, hours, image). `POST /api/contact` nhận thêm `kind: consultation | trial`, `age: 4..100 | null`, `courseId: ID khóa học | null`, `campus: tên cơ sở | chuỗi rỗng`; mặc định tương thích form cũ. Các trường cũ name/email/phone/message vẫn được kiểm tra. Chỉ Admin được đọc danh sách yêu cầu. Teacher CRUD bổ sung `nationality` tối đa 80 ký tự, mặc định rỗng.

Migration thêm nationality cho teachers và kind/age/courseId/campus cho contacts. Khi xóa khóa học, contact.courseId chuyển NULL để giữ yêu cầu tư vấn. Hai cơ sở mẫu được định nghĩa tại `server/campuses.js`; cấu trúc lớp cũ giữ trường campus dạng tên. `seed:public` cập nhật một lần theo metadata `public-content-v1`, transaction hoàn tác toàn bộ nếu lịch TOEIC xung đột. Không tự khôi phục dữ liệu Admin đã xóa/sửa sau lần cập nhật.

Bài tập, điểm danh, tiến độ và chứng chỉ học viên là phạm vi mở rộng riêng. Tiếng Trung/Hàn/Nhật chỉ bổ sung khi xác định trung tâm có chương trình tương ứng.
