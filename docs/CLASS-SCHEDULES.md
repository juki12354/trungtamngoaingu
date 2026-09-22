# Các ca học bổ sung

Chạy `npm.cmd run seed:classes` để thêm 18 lớp vào database hiện tại, đưa mỗi khóa mẫu từ 1 lên 4 lựa chọn. Lệnh chạy lại không nhân đôi lớp và không ghi đè các lớp bổ sung đã chỉnh sửa.

| Khóa học | Lịch bổ sung | Phòng / cơ sở |
|---|---|---|
| IELTS Foundation | T3, T5 18:00–20:00; T7, CN 08:00–10:00; T7, CN 14:00–16:00 | 201 / Lê Lợi |
| Giao tiếp | T2, T4 08:00–10:00; T2, T4 18:30–20:30; T7, CN 14:00–16:00 | 101 / Nguyễn Văn Cừ |
| Trẻ em | T3, T5 17:00–18:30; T7, CN 08:00–09:30; T7, CN 15:00–16:30 | 101 / Lê Lợi |
| Thiếu niên | T2, T4 16:30–18:00; T6, CN 18:30–20:00; T7, CN 09:45–11:15 | 102 / Lê Lợi |
| Căn bản | T3, T5 08:00–10:00; T3, T5 14:00–16:00; T7, CN 10:15–12:15 | 202 / Lê Lợi |
| English for Work | T2, T4 12:00–13:30; T6, CN 19:00–21:00; T7, CN 10:30–12:30 | 102 / Nguyễn Văn Cừ |

Các ca trẻ em/thiếu niên dài 90 phút, ưu tiên sau giờ học và cuối tuần. Người lớn có thêm ca sáng, chiều, trưa và tối theo nhóm khóa. Lịch là dữ liệu minh họa của đồ án, có thể điều chỉnh trong Admin theo nhu cầu thực tế.

Ngày khai giảng của lớp mới là ngày học đầu tiên từ hai tuần sau lúc chạy lệnh. Ngày kết thúc tính đủ số buổi trong khóa, theo đúng thứ đã chọn. Mỗi lớp trẻ em tối đa 15 học viên; các lớp bổ sung khác tối đa 18.

Script kiểm tra trùng giáo viên/phòng và thực hiện trong một transaction: có xung đột sẽ hoàn tác toàn bộ lượt thêm. Nó cũng sửa hai lịch mẫu cũ trùng giáo viên, chỉ khi lịch còn đúng mẫu và **chưa có đăng ký nào**: CB-05 chuyển sang T2/T4 16:00–18:00; WORK-06 chuyển sang T3/T5 17:00–18:30. Lớp đã có đăng ký được giữ lịch để tránh làm thay đổi lịch người học.

Sau khi chạy, tải lại trang Lịch khai giảng, Chi tiết khóa học hoặc Đăng ký để thấy các lựa chọn mới. Nếu tạo một database mới, chạy lại lệnh trên sau khi cài dự án để có đủ 24 lớp mẫu.
