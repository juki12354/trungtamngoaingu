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
- **Kiểm tra trình độ:** 15 câu mẫu; chuyển qua lại giữa các câu; chấm tại server, hiển thị điểm và gợi ý khóa học. Admin có thể quản lý ngân hàng câu hỏi.
- **Học viên:** tự tạo tài khoản, đăng nhập/đăng xuất, xem đăng ký và trạng thái, lịch lớp, điểm kỹ năng, tải tài liệu `.txt`, sửa hồ sơ, xem lịch sử kiểm tra.
- **Admin:** dashboard; thêm/sửa/xóa khóa học, giáo viên, học viên, lớp/lịch học, câu hỏi, tin tức; duyệt/hủy/xóa đăng ký, gắn tài khoản học viên, nhập điểm; xem lời nhắn liên hệ.
- **Nghiệp vụ:** chống đăng ký trùng email/lớp; kiểm tra sĩ số lúc đăng ký và duyệt; chỉ học viên được xác nhận mới nhận tài liệu; chặn xóa dữ liệu còn liên kết; phân quyền API.

Đăng ký khi chưa đăng nhập vẫn được lưu. Admin vào **Đăng ký & điểm → Sửa → Liên kết tài khoản học viên** để gắn với đúng tài khoản sau khi xác minh. Đăng ký khi đã đăng nhập tự gắn vào tài khoản hiện tại.

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
  pages/AccountPages.jsx   Đăng ký, bài test, tài khoản, cổng học viên
  pages/Admin.jsx          Dashboard và CRUD
  styles.css               Responsive và hệ thống giao diện
server/
  app.js                   API, phân quyền và nghiệp vụ
  db.js                    Schema SQLite, seed, băm mật khẩu
  schemas.js               Kiểm tra dữ liệu với Zod
  seed.js                  Nội dung minh họa và câu hỏi
public/                    Ảnh, font cục bộ và biểu tượng
data/center.sqlite         Database tự tạo, không đưa vào Git
tests/                     Kiểm thử API và trình duyệt
docs/                      Đặc tả và sơ đồ dữ liệu
```

Ảnh và font được lưu cục bộ, vì vậy website không cần tải Google Fonts hay Unsplash lúc sử dụng. Xem [nguồn tài nguyên](docs/ASSETS.md).

## Dữ liệu và sao lưu

Database mặc định: `data/center.sqlite`. Có thể đổi bằng biến môi trường `DB_PATH`. Khởi động lại server không xóa dữ liệu. Nội dung seed chỉ được tạo một lần; chỉnh nội dung hiện có từ Admin.

Để sao lưu: dừng server, sao chép cả thư mục `data/` sang vị trí an toàn. Không xóa database nếu muốn giữ đăng ký và tài khoản. Kiểm thử dùng database tách biệt và không sửa database demo.

## Kiểm tra

```powershell
npm.cmd test
npm.cmd run build
npx.cmd playwright install chromium
npm.cmd run test:e2e
```

Kiểm thử trình duyệt tự mở một server riêng ở cổng 3002, dùng database tạm. Build lại trước khi chạy E2E nếu đã sửa mã nguồn. Ảnh kiểm tra giao diện được xuất trong `test-results/`.

## Phạm vi đồ án

- Tên trung tâm, địa chỉ, nhân sự, học phí, lịch và phản hồi học viên là dữ liệu minh họa. Ảnh chân dung không xác nhận danh tính người được đặt tên.
- Bài test chỉ sàng lọc ngữ pháp/từ vựng; mức A1–B2 là gợi ý minh họa, không phải chứng nhận CEFR hoặc kết quả IELTS.
- Chưa tích hợp thanh toán, email/SMS, khôi phục mật khẩu, xác thực email, chat hay bài thi nghe/nói. Gửi form lưu dữ liệu cho Admin, không gửi email tự động.
- SQLite được chọn để dễ chạy đồ án. React là thư viện giao diện; backend dùng JavaScript/Node.js. Không cần PHP, XAMPP hoặc MySQL cho bản này.
- Bản này phục vụ chạy local. Trước khi dùng thật cần cấu hình triển khai HTTPS, tài khoản quản trị riêng, quy trình khôi phục tài khoản và chính sách bảo vệ dữ liệu. `NODE_ENV=production` bật cookie Secure và ngừng tạo tài khoản mẫu; không tự biến dữ liệu demo hiện có thành dữ liệu thật.

Tài liệu nền tảng: [React](https://react.dev/learn), [Vite](https://vite.dev/guide/), [Node.js SQLite](https://nodejs.org/api/sqlite.html).
