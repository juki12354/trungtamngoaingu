# Đưa website đầy đủ lên mạng bằng Render

Repository GitHub lưu mã nguồn. Website sẽ có một link HTTPS riêng do Render cấp; sau khi chạy thành công, gắn link đó vào mục **About → Website** và đầu README trên GitHub để người xem bấm mở.

## Chi phí và dữ liệu

Cấu hình `render.yaml` dùng một Web Service Node.js có phí (`0.5c-512mb`) và disk 1 GB. Xem tổng chi phí Render hiển thị trước khi tạo dịch vụ. Không cần mua tên miền để dùng link `onrender.com` do Render cấp.

Không chọn Free cho database SQLite cần lưu lâu dài: filesystem của dịch vụ Free có thể bị mất khi redeploy, restart hoặc ngủ. Database của cấu hình này nằm tại `/var/data/center.sqlite` trên persistent disk. Mã nguồn và file build nằm ngoài disk.

## Các bước trên Render

1. Mở <https://dashboard.render.com>, tạo tài khoản hoặc đăng nhập bằng GitHub. Khi kết nối GitHub, cấp quyền cho repository `juki12354/trungtamngoaingu`.
2. Chọn **New → Blueprint**, chọn repository trên, nhánh **main**, file **render.yaml** ở gốc dự án.
3. Render đọc cấu hình Node 24, build React, chạy Express, health check và disk. Xem lại gói dịch vụ, khu vực Singapore và chi phí trước khi tiếp tục.
4. Điền `ADMIN_EMAIL` là email bạn sẽ dùng đăng nhập, `ADMIN_PASSWORD` là mật khẩu riêng dài ít nhất 14 ký tự. Điền trực tiếp trong Render; không đưa mật khẩu vào GitHub hoặc README. Chọn **Deploy Blueprint** khi bạn chấp nhận chi phí.
5. Khi Web Service báo **Live**, mở mục **Shell của chính Web Service**, chạy từng lệnh:

   ```sh
   npm run setup:admin
   npm run seed:classes
   ```

   Lệnh đầu tạo Admin; lệnh sau bổ sung 18 ca học, để database mới có tổng cộng 26 lớp. Chỉ chạy setup Admin một lần; chạy lại cùng email sẽ báo đã tồn tại và không đổi mật khẩu. Không chạy các lệnh database trong Build Command, Pre-deploy Command hay One-off Job vì các môi trường đó không có disk của dịch vụ.

6. Trong **Environment**, xóa `ADMIN_PASSWORD` sau khi tạo Admin, lưu và khởi động lại dịch vụ. Tài khoản đã tạo vẫn ở database trên disk. Không dùng tài khoản demo trong README: chế độ production không tạo các tài khoản đó.
7. Mở URL HTTPS Render cấp. Thử đăng nhập bằng Admin vừa tạo; kiểm tra danh sách khóa, giáo viên, lịch khai giảng. Đăng xuất, tự tạo tài khoản học viên và gửi đăng ký thử. Trở lại Admin để kiểm tra yêu cầu được lưu.
8. Restart dịch vụ một lần rồi kiểm tra lại tài khoản/đăng ký để xác nhận dữ liệu bền vững. Sau đó sao chép URL chính xác, thêm vào **GitHub repository → About (biểu tượng bánh răng) → Website**. Không dùng URL dashboard Render làm link website.

Database trên hosting là database mới từ dữ liệu mẫu trong mã nguồn. Tài khoản và đăng ký trên máy tính không được tự tải lên. Không upload database chứa dữ liệu riêng lên repository công khai.

## Cập nhật và vận hành

- Render được cấu hình triển khai khi các kiểm tra của nhánh main thành công. Chỉ nên có một instance vì ứng dụng dùng một file SQLite.
- `npm run backup` trong Shell tạo bản sao nhất quán tại `/var/data/backups/`; định kỳ tải bản sao ra nơi lưu riêng. Không xóa disk nếu cần giữ dữ liệu.
- HTTPS dùng cookie Secure. Khi kiểm tra lỗi đăng nhập, xem Logs và HTTP response của API; giữ nguyên kiểm tra Origin.
- Hiện ứng dụng giới hạn tần suất theo kết nối trực tiếp. Sau proxy Render, nhiều người dùng có thể cùng chia sẻ hạn mức. Trước khi dùng cho nhiều học viên thật, xác minh chuỗi proxy rồi cấu hình trust proxy phù hợp; không bật trust proxy cho mọi nguồn một cách tùy ý.
- Nếu build lỗi: xem bước `npm ci` / `npm run build`. Nếu dịch vụ không lên: kiểm tra `HOST=0.0.0.0`, PORT và DB_PATH đúng disk. Khi báo nguồn yêu cầu không hợp lệ, cần kiểm tra Host/Origin do proxy chuyển tiếp trước khi thay đổi cấu hình.

## Tài liệu chính thức

- [Express trên Render](https://render.com/docs/deploy-node-express-app)
- [Blueprint và các trường cấu hình](https://render.com/docs/blueprint-spec)
- [Persistent disk và giới hạn môi trường build](https://render.com/docs/disks)
- [Giới hạn dịch vụ Free](https://render.com/docs/free)
- [Bảng giá hiện hành](https://render.com/pricing)

Cấu hình này là bước chuẩn bị, không tự tạo tài khoản Render, mua hosting hay chứng minh website đã hoạt động công khai. Chỉ xác nhận triển khai sau khi có URL thực và kiểm tra trực tiếp.
