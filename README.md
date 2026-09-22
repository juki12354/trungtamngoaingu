# Vinh English Center — Website trung tâm ngoại ngữ

Đồ án chạy thực tế bằng **React + Vite**, giao diện tiếng Việt, có **Express API + SQLite**. Dữ liệu đăng ký, tài khoản, điểm và thay đổi của Admin được lưu trong database; không dùng localStorage để giả lập backend.

## Chạy trên Windows

Yêu cầu **Node.js 24 trở lên**. Mở PowerShell tại thư mục dự án:

```powershell
npm.cmd ci
npm.cmd run dev
```

Mở **http://127.0.0.1:5173**. API chạy ở cổng **3001**. Dừng bằng `Ctrl+C`.

Có thể nhấp đúp **CHAY-WEBSITE.cmd** để cài thư viện nếu cần rồi chạy website.

Để chạy bản đã build:

```powershell
npm.cmd run build
npm.cmd start
```

Mở **http://127.0.0.1:3001**. Lệnh này vẫn chạy ở chế độ demo local nếu không đặt `NODE_ENV=production`.

## Tài khoản dùng thử

| Vai trò  | Email                  | Mật khẩu         |
| -------- | ---------------------- | ---------------- |
| Admin    | `admin@vinhenglish.vn` | `Admin@123456`   |
| Học viên | `hocvien@example.com`  | `Student@123456` |

Tài khoản mẫu chỉ được tạo khi database chưa có người dùng, trong chế độ phát triển/demo. Mật khẩu trong database được băm bằng scrypt với salt riêng. Các thông tin đăng nhập trên chỉ phục vụ trình diễn đồ án.

## Chức năng

- **Khách:** trang chủ, giới thiệu, tìm/lọc 6 khóa học, chi tiết học phí, hồ sơ giáo viên, lịch khai giảng, tin tức, liên hệ, đăng ký lớp.
- **Kiểm tra trình độ:** 15 câu mẫu; mỗi lượt giữ cố định bộ câu hỏi trong 30 phút, chấm tại server, xem lại câu trả lời và gợi ý khóa học. Nộp lại cùng lượt không tạo kết quả trùng.
- **Học viên:** tự tạo tài khoản, đăng nhập/đăng xuất, đổi mật khẩu và thu hồi mọi phiên cũ, xem lịch tuần, điểm, tải tài liệu PDF/DOCX và ghi chú `.txt`, sửa hồ sơ, xem lại bài kiểm tra.
- **Admin:** CRUD nội dung; duyệt/hủy đăng ký, tiếp nhận và xác minh tài khoản; nhập điểm; quản lý thứ/giờ/phòng/trạng thái lớp; tải tài liệu tối đa 5 MB; xử lý tư vấn theo trạng thái; báo cáo đăng ký theo tháng, sĩ số và xuất Excel 3 sheet.
- **Nghiệp vụ:** chống trùng theo email hoặc tài khoản trong cùng lớp; kiểm tra sức chứa và trạng thái tuyển sinh lúc đăng ký/duyệt; chống trùng lịch giáo viên và phòng cùng cơ sở; tải tài liệu theo quyền lớp; chặn xóa dữ liệu còn liên kết; phân quyền API.

Đăng ký khi chưa đăng nhập vẫn được lưu. Admin vào **Đăng ký & điểm → Tiếp nhận**, chọn tạo tài khoản mới hoặc liên kết tài khoản đã có, xác nhận đã liên hệ xác minh rồi lưu. Sau đó dùng **Sửa → Đã xác nhận** để duyệt lớp. Đăng ký khi đã đăng nhập tự gắn vào tài khoản hiện tại. Không tự gắn đăng ký khách chỉ dựa trên email.

## Kịch bản trình diễn

1. Mở **Khóa học**, tìm “IELTS”, xem thông tin và lịch lớp.
2. Làm **Kiểm tra trình độ**, trả lời đủ các câu và xem gợi ý.
3. Tạo tài khoản hoặc đăng nhập học viên, vào **Đăng ký khóa học**, chọn lớp và gửi thông tin.
4. Đăng nhập Admin, chọn **Đăng ký & điểm**, tìm học viên, sửa trạng thái thành **Đã xác nhận**, nhập điểm nếu cần.
5. Đăng nhập lại học viên để xem lịch học, kết quả và tải tài liệu.
6. Thử thêm/sửa/xóa một khóa học chưa được sử dụng; thử xóa khóa có lớp để xem kiểm tra ràng buộc.

## Cấu trúc

```text
src/
  App.jsx                  Router, phiên đăng nhập, header/footer
  lib.jsx                  API client và thành phần dùng chung
  pages/Home.jsx           Trang chủ
  pages/PublicPages.jsx    Khóa học, giáo viên, tin tức, liên hệ
  pages/Enrollment.jsx     Đăng ký khóa học
  pages/Placement.jsx      Bài test và xem lại đáp án
  pages/Login.jsx          Đăng nhập/đăng ký tài khoản
  pages/Student.jsx        Cổng học viên
  pages/ManagementPanels.jsx Tài liệu, tiếp nhận, mật khẩu, báo cáo
  pages/Admin.jsx          Dashboard và CRUD
  styles.css               Responsive và hệ thống giao diện
server/
  app.js                   API, phân quyền và nghiệp vụ
  db.js                    Schema SQLite, seed, băm mật khẩu
  schemas.js               Kiểm tra dữ liệu với Zod
  seed.js                  Nội dung minh họa và câu hỏi
  migrations.js            Nâng cấp database hiện có
  domain.js                Ràng buộc đăng ký và lịch học
  placement.js             Lượt kiểm tra và chấm điểm
  management.js            Tiếp nhận, tệp và báo cáo Excel
public/                    Ảnh, font cục bộ và biểu tượng
data/center.sqlite         Database tự tạo, không đưa vào Git
tests/                     Kiểm thử API và trình duyệt
docs/                      Đặc tả và sơ đồ dữ liệu
```

Ảnh và font được lưu cục bộ, vì vậy website không cần tải Google Fonts hay Unsplash lúc sử dụng. Xem [nguồn tài nguyên](docs/ASSETS.md).

## Dữ liệu và sao lưu

Database mặc định: `data/center.sqlite`. Có thể đổi bằng biến môi trường `DB_PATH`. Khởi động lại server không xóa dữ liệu. Nội dung seed chỉ được tạo một lần; chỉnh nội dung hiện có từ Admin.

Chạy `npm.cmd run backup` để tạo bản sao SQLite nhất quán trong `data/backups/`, kể cả khi server đang chạy. Bản sao bao gồm tệp PDF/DOCX lưu dưới dạng BLOB. Quy trình khôi phục nằm trong [hướng dẫn vận hành](docs/OPERATIONS.md). Kiểm thử dùng database tách biệt.

Database cũ được nâng cấp tự động, giữ dữ liệu và phân tích lịch chữ thành thứ/giờ khi nhận diện được. Admin cần bổ sung phòng học và rà lại lịch cũ không nhận diện được. Các lớp cũ không tự đổi ngày khai giảng.

## Kiểm tra

```powershell
npm.cmd run lint
npm.cmd test
npm.cmd run build
npx.cmd playwright install chromium
npm.cmd run test:e2e
npm.cmd audit --audit-level=moderate
```

Kiểm thử trình duyệt tự mở một server riêng ở cổng 3002, dùng database tạm. Build lại trước khi chạy E2E nếu đã sửa mã nguồn. Ảnh kiểm tra giao diện được xuất trong `test-results/`.

## Phạm vi đồ án

- Tên trung tâm, địa chỉ, nhân sự, học phí, lịch và phản hồi học viên là dữ liệu minh họa. Ảnh chân dung không xác nhận danh tính người được đặt tên.
- Bài test chỉ sàng lọc ngữ pháp/từ vựng; mức A1–B2 là gợi ý minh họa, không phải chứng nhận CEFR hoặc kết quả IELTS.
- Chưa tích hợp thanh toán, email/SMS, khôi phục mật khẩu, xác thực email, chat hay bài thi nghe/nói. Gửi form lưu dữ liệu cho Admin, không gửi email tự động.
- SQLite được chọn để dễ chạy đồ án. React là thư viện giao diện; backend dùng JavaScript/Node.js. Không cần PHP, XAMPP hoặc MySQL cho bản này.
- Bản này phục vụ chạy local. Trước khi dùng thật cần cấu hình triển khai HTTPS, tài khoản quản trị riêng, quy trình khôi phục tài khoản và chính sách bảo vệ dữ liệu. `NODE_ENV=production` bật cookie Secure và ngừng tạo tài khoản mẫu; không tự biến dữ liệu demo hiện có thành dữ liệu thật.

Tài liệu nền tảng: [React](https://react.dev/learn), [Vite](https://vite.dev/guide/), [Node.js SQLite](https://nodejs.org/api/sqlite.html).

## Tài liệu đồ án

- [Báo cáo, use case và kịch bản bảo vệ](docs/REPORT.md)
- [Slide thuyết trình HTML](docs/defense.html) và [bản PDF 10 trang](docs/defense.pdf): HTML mở bằng trình duyệt, phím trái/phải chuyển trang, Ctrl+P xuất PDF.
- [Database và quan hệ](docs/DATABASE.md)
- [Hướng dẫn vận hành và triển khai](docs/OPERATIONS.md)
- [Kết quả kiểm thử](docs/VERIFICATION.md)

CI nằm trong `.github/workflows/ci.yml`, chạy lint, test, build, E2E và audit khi repository được đưa lên GitHub. Chưa phát hành website hoặc chạy CI trên GitHub trong lần nâng cấp này.
