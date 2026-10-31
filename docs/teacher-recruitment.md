# Tuyển dụng giáo viên

Ứng viên dùng tài khoản hiện có, gửi CV PDF/DOCX tối đa 5 MB cùng ngôn ngữ,
cấp độ, bằng cấp/chứng chỉ và kinh nghiệm ghi trong CV. Một hồ sơ ứng tuyển cho
một ngôn ngữ. Không công khai CV hoặc tự động tạo hồ sơ giáo viên trên website.

QTV tải CV, đối chiếu thông tin rồi xác nhận ngôn ngữ/cấp độ và căn cứ giao đề.
Hệ thống ghép câu hỏi kiến thức đúng cấp độ (và tối đa hai cấp độ liền trước)
với hai nhiệm vụ viết bằng ngôn ngữ ứng tuyển: giải thích kiến thức/lập giáo án
và phản hồi lỗi của học viên. QTV có thể điều chỉnh nhiệm vụ theo kinh nghiệm
trong CV khi giao đề. Đây là bài sàng lọc nội bộ, không phải kỳ thi chứng chỉ.
Không có AI tự đọc hay xác thực bằng cấp trong CV.

Đề được lưu thành bản chụp. Mỗi lần làm tối đa 60 phút tính từ máy chủ khi
bắt đầu; tải lại trang tiếp tục thời gian cũ. Chỉ chủ hồ sơ được làm bài, một
lần nộp cho mỗi đề. QTV có thể giao lại với lý do; đề cũ được lưu và không
còn hợp lệ để duyệt. Đáp án trắc nghiệm chỉ QTV xem được.

Trắc nghiệm tự chấm quy đổi tối đa 30 điểm. QTV chấm diễn đạt ngôn ngữ (20),
thiết kế bài dạy (30), phản hồi học viên (20), ghi nhận xét riêng và phản hồi
cho ứng viên. Duyệt chỉ khi đề mới nhất đã nộp đủ và QTV xác nhận đối chiếu CV.
QTV quyết định tuyển dụng, hệ thống không tự loại/tự duyệt theo điểm.

API (đều yêu cầu đăng nhập; `/admin/*` chỉ QTV):

| Phương thức | Đường dẫn sau `/api` | Mục đích |
| --- | --- | --- |
| GET/POST | /recruitment/applications | Hồ sơ của mình / gửi CV |
| GET | /recruitment/applications/:id | Chi tiết hồ sơ của mình |
| GET | /recruitment/applications/:id/cv | Tải CV của mình hoặc QTV |
| POST | /recruitment/applications/:id/start | Bắt đầu/tiếp tục đề mới nhất |
| PUT | /recruitment/applications/:id/draft | Lưu nháp khi đề còn hạn |
| POST | /recruitment/applications/:id/submit | Nộp đề mới nhất |
| GET | /admin/recruitment | Danh sách, lọc trạng thái/ngôn ngữ, phân trang |
| GET | /admin/recruitment/:id | CV metadata, toàn bộ đề, bài làm và đánh giá |
| POST | /admin/recruitment/:id/assessments | Xác nhận CV và giao/giao lại đề |
| POST | /admin/recruitment/:id/review | Chấm, lưu nhận xét, duyệt hoặc từ chối |

CV nằm trong database riêng tư (BLOB/BYTEA), đi cùng bản sao lưu dữ liệu.
SQLite và PostgreSQL là backend chạy website; SQL Server là bộ SQL độc lập
phục vụ đồ án. Chạy script `10-teacher-recruitment.sql` sau các nâng cấp cũ
để bổ sung hai bảng và bốn quan hệ cho SQL Server.
