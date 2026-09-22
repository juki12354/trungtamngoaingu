# Vận hành Vinh English Center

## Chạy và xử lý lỗi thường gặp

1. Cài Node.js 24+, mở PowerShell tại thư mục chứa `package.json`.
2. `npm.cmd ci`, sau đó `npm.cmd run dev`.
3. Mở `http://127.0.0.1:5173`. Giữ cửa sổ terminal chạy. API dùng cổng 3001.
4. Nếu cổng bận, kiểm tra tiến trình đang chạy và dừng đúng phiên của dự án bằng Ctrl+C. Không dừng mọi tiến trình Node trên máy.
5. Nếu giao diện báo không kết nối, kiểm tra `http://127.0.0.1:3001/api/health` và terminal API. Proxy Vite phải giữ `changeOrigin: false` để đăng nhập được.

`npm.cmd run build` rồi `npm.cmd start` phục vụ cả React và API tại cổng 3001. Lệnh start đọc `.env` nếu có. Dev mặc định dùng 3001/5173.

## Dữ liệu và bản sao

`npm.cmd run backup` dùng SQLite `VACUUM INTO`, tạo tệp mới trong thư mục `backups` cạnh DB. Tệp chứa tài khoản, đăng ký, tài liệu và lịch sử. Giữ bản sao ở nơi riêng có kiểm soát truy cập; không đưa lên GitHub. Mặc định script không xóa bản sao cũ.

Khôi phục thủ công:

1. Dừng ứng dụng và mọi kết nối vào database.
2. Giữ một bản sao toàn bộ thư mục dữ liệu hiện tại để có thể quay lại.
3. Chép bản sao cần phục hồi vào **đường dẫn mới**, ví dụ `data/restored.sqlite`; tránh ghi đè database đang dùng hoặc ghép với tệp WAL cũ.
4. Đặt `DB_PATH=data/restored.sqlite` trong `.env`, chạy `npm.cmd start`.
5. Kiểm tra đăng nhập, số lượng bản ghi, lịch học và tải một tài liệu. Chỉ chuyển chính thức sau khi kiểm tra xong.

Nâng cấp schema trong `server/migrations.js` chạy trong transaction, có thể chạy lại. Lịch cũ vẫn giữ chuỗi gốc. Phòng học cũ để trống vì hệ thống không biết phòng thực tế; Admin bổ sung trước khi chỉnh lịch.

## Chuẩn bị chạy trên máy chủ

Đây là hướng dẫn cấu hình, chưa phải một website đã triển khai.

- Dùng máy chủ hỗ trợ Node 24 và ổ lưu trữ bền vững. SQLite không thích hợp với nhiều bản sao ứng dụng dùng chung một tệp qua ổ mạng.
- `npm ci`, `npm run build`, tạo `.env` với `NODE_ENV=production`, `PORT=3001`, `HOST=127.0.0.1`, `DB_PATH` trỏ đến thư mục dữ liệu riêng.
- Khởi tạo Admin trên database mới bằng `ADMIN_EMAIL`, `ADMIN_PASSWORD` (ít nhất 14 ký tự) rồi `npm run setup:admin`. Script không ghi đè tài khoản có sẵn. Xóa biến mật khẩu khỏi cấu hình sau khi tạo.
- Nếu dùng DB demo cũ, đổi mật khẩu tất cả tài khoản mẫu và thay nội dung minh họa. Production ngừng tạo tài khoản demo mới nhưng không tự xóa hay đổi tài khoản đã có.
- Đặt reverse proxy HTTPS phía trước Node. Chuyển tiếp đúng Host công khai để kiểm tra Origin hoạt động. Cookie production có Secure nên phải truy cập qua HTTPS.
- Hiện rate limit nhìn theo IP kết nối trực tiếp. Sau reverse proxy, các khách có thể cùng chia sẻ một hạn mức. Cần cấu hình tin cậy proxy đúng topology trước khi phục vụ nhiều người dùng, không tin mọi `X-Forwarded-For`.
- Kiểm tra `/api/health`, quyền Admin/học viên, tải tài liệu, lưu dữ liệu sau restart và khôi phục backup trước khi đưa vào dùng.
- Thiết lập tự khởi động dịch vụ và sao lưu định kỳ theo hạ tầng sử dụng. Giám sát lỗi 5xx, dung lượng DB và tình trạng sao lưu.

## Tài khoản và tài liệu

Admin tạo/liên kết tài khoản qua Tiếp nhận sau khi xác minh người đăng ký. Mật khẩu ban đầu trao qua kênh liên hệ đã xác minh. Học viên đổi mật khẩu tại cổng học viên. Đổi mật khẩu hoặc Admin đặt lại mật khẩu sẽ thu hồi mọi phiên đăng nhập cũ.

Nếu học viên quên mật khẩu, Admin xác minh rồi cập nhật mật khẩu trong Quản lý học viên. Không có dịch vụ email/SMS được cấu hình nên chưa có gửi liên kết khôi phục tự động. Quản trị viên cần giữ tài khoản dự phòng hoặc quy trình phục hồi máy chủ riêng.

Tài liệu chỉ do Admin tải lên. Giới hạn 5 MB/tệp, PDF/DOCX, kiểm tra chữ ký PDF hoặc cấu trúc ZIP của DOCX, tải về dưới dạng attachment. Đây không phải hệ thống quét mã độc; trước khi triển khai rộng cần kết nối trình quét tệp nếu có yêu cầu vận hành đó.

## Hoàn nguyên bản nâng cấp

Giữ bản mã đã kiểm thử và backup DB cùng thời điểm. Dừng dịch vụ, phục hồi mã và dùng bản DB trước nâng cấp ở đường dẫn mới. Không chạy bản cũ trên DB mới mà chưa kiểm tra tương thích. Dữ liệu phát sinh sau bản sao phải được đối soát trước khi hoàn nguyên.
