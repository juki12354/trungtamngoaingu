# Hosting miễn phí: Render Free + Neon Free

Website chạy trên Render; tài khoản, đăng ký, điểm và tài liệu nằm trong PostgreSQL của Neon. Tắt máy cá nhân vẫn truy cập được. Người xem dùng link HTTPS `*.onrender.com`, tự đăng ký tài khoản học viên và đăng nhập.

**Trạng thái:** đã chuẩn bị mã nguồn và cấu hình; chưa có URL Render thực tế được xác minh. Chủ dự án cần đăng nhập/tạo tài khoản tại [Render](https://dashboard.render.com/) và [Neon](https://console.neon.tech/). Không gửi mật khẩu hoặc chuỗi kết nối vào chat/GitHub.

## Giới hạn miễn phí

- Chọn **Free** ở cả hai dịch vụ. Cấu hình không tạo disk trả phí hoặc Render Postgres.
- Render Free ngủ sau 15 phút không có truy cập; lần mở tiếp theo có thể mất khoảng một phút. Có giới hạn 750 giờ instance miễn phí mỗi workspace/tháng và hạn mức lưu lượng/build. Xem [Render Free](https://render.com/docs/free).
- Neon Free hiện có 1 GB/project và 100 CU-hours/project/tháng; theo dõi Usage khi tải nhiều tài liệu. Xem [Neon Free](https://neon.com/blog/neon-free-plan-1-gb-per-project).
- Không chọn nâng cấp trả phí. Nếu nền tảng yêu cầu xác minh bằng thẻ, dừng bước đó; hướng dẫn này không yêu cầu chấp nhận khoản phí. Gói Free không có cam kết hoạt động liên tục.

## 1. Tạo database Neon

1. Tạo project **Free**, tên `vinh-english-center`, PostgreSQL **17**, ưu tiên khu vực gần Singapore nếu có.
2. Mở **Connect**, chọn database/role và lấy connection string PostgreSQL. Có thể bật connection pooling cho ứng dụng.
3. Giữ TLS; dùng `sslmode=verify-full`. Không tắt kiểm tra chứng chỉ.
4. Muốn giữ dữ liệu đang có trên máy: làm mục **Chuyển dữ liệu cũ** dưới đây **trước lần khởi động đầu tiên trên Render**. Nếu bỏ qua, website mới có 7 khóa, 9 giáo viên, 26 lớp mẫu và 25 câu hỏi; chưa có học viên.

## 2. Tạo Web Service Render

Cách nhanh: [Deploy từ repository](https://render.com/deploy?repo=https://github.com/juki12354/trungtamngoaingu). Blueprint đọc `render.yaml` ở nhánh `main`. Kiểm tra gói **Free**, không có disk/dịch vụ trả phí.

Hoặc chọn **New → Web Service → Public Git Repository**, nhập `https://github.com/juki12354/trungtamngoaingu.git`:

| Mục | Giá trị |
| --- | --- |
| Branch / Runtime | `main` / `Node` |
| Region / Instance type | `Singapore` / **Free** |
| Build command | `npm ci --include=dev && npm run build` |
| Start command | `npm start` |
| Health check | `/api/health` |

Điền trực tiếp trong **Environment**:

| Biến | Giá trị |
| --- | --- |
| `NODE_VERSION` | `24.17.0` |
| `NODE_ENV` | `production` |
| `HOST` | `0.0.0.0` |
| `PORT` | `10000` |
| `DATABASE_URL` | Chuỗi kết nối Neon vừa lấy |
| `ADMIN_EMAIL` | Email riêng để đăng nhập quản trị |
| `ADMIN_PASSWORD` | Mật khẩu riêng từ 14–128 ký tự |

Chọn tạo/triển khai dịch vụ. Không tạo Persistent Disk và không đặt `DB_PATH`. Server từ chối khởi động trên Render nếu thiếu `DATABASE_URL`, tránh lưu nhầm trên ổ đĩa tạm.

Database chưa có Admin: server tự tạo bằng hai biến trên, không cần Shell. Khởi động lại **không đổi mật khẩu Admin hiện có**. Nếu đã nhập SQLite, dùng tài khoản Admin đã nhập; biến khởi tạo không ghi đè nó.

## 3. Kiểm tra và chia sẻ

1. Đợi **Live**, mở link HTTPS `*.onrender.com` được cấp.
2. Đăng nhập Admin, kiểm tra khóa/lớp/giáo viên. Khi đăng nhập thành công, xóa `ADMIN_PASSWORD` trong Render và lưu; tài khoản vẫn ở Neon.
3. Tạo học viên, đăng ký một lớp; dùng Admin duyệt rồi kiểm tra lịch học và tải tài liệu.
4. Restart Web Service; đăng nhập lại, xác nhận dữ liệu và tài liệu vẫn còn.
5. Mở từ điện thoại bằng mạng khác khi đã tắt máy cá nhân.
6. Đặt URL website vào **GitHub → About → Website** và thay link đầu README. URL dashboard không phải link cho học viên.

Chỉ công bố URL sau khi kiểm tra. Link Cloudflare tạm cũ vẫn phụ thuộc máy cá nhân.

## Chuyển dữ liệu cũ (tùy chọn)

Neon đích phải **trống**, chưa được website khởi tạo. Nếu đã khởi tạo nhầm, dùng database mới trống; công cụ không ghi đè dữ liệu hiện có.

1. Sao lưu SQLite: `npm.cmd run backup` trước khi đặt `DATABASE_URL`.
2. Đổi mật khẩu các tài khoản demo đã công khai trong README nếu giữ chúng để đưa lên mạng.
3. Trong `.env` local (bị Git bỏ qua), đặt `DB_PATH` đến SQLite nguồn, `DATABASE_URL` đến Neon mới. Đặt `NODE_ENV=production` nếu chạy ứng dụng với dữ liệu cloud.
4. Chạy `npm.cmd run migrate:postgres`. Công cụ mở nguồn chỉ đọc, lấy snapshot nhất quán, chuyển 14 bảng trong một transaction, đối chiếu số bản ghi và chỉnh sequence ID. Giữ mật khẩu đã băm, liên kết và tệp nhị phân; không sửa SQLite nguồn.
5. Sau thông báo thành công, dùng cùng `DATABASE_URL` ở Render. Giữ bản sao local đến khi kiểm tra website xong.

Lỗi giữa chừng sẽ rollback transaction đích. Các script `seed:classes`, `seed:teachers`, `seed:public` dành cho SQLite local; cloud sửa nội dung qua Admin. PostgreSQL mới đã có các ca học từ lần khởi tạo đầu tiên.

## Sao lưu và hoàn nguyên

Đặt `DATABASE_URL` trong `.env`, cài PostgreSQL client tương thích rồi chạy `npm.cmd run backup`. Windows có thể đặt `PG_DUMP_PATH=C:/Program Files/PostgreSQL/17/bin/pg_dump.exe`. File `.dump` lưu trong `data/backups`, bị Git bỏ qua. Với Neon, ưu tiên connection string **Direct** khi backup/restore. Mật khẩu được truyền bằng biến môi trường, không đặt trong tham số lệnh.

Dùng `pg_restore` vào **database mới trống**; kiểm tra đăng nhập, số bản ghi, tài liệu rồi mới đổi `DATABASE_URL` trên Render. Giữ database cũ để đối chiếu dữ liệu phát sinh. Không chạy mã chỉ hỗ trợ SQLite với database cloud.

## Lỗi thường gặp

- Thiếu/sai `DATABASE_URL`: sửa Environment, không chuyển sang SQLite để bỏ qua lỗi.
- Chưa có Admin: kiểm tra email và mật khẩu ít nhất 14 ký tự. Email đã thuộc học viên thì chọn email khác.
- Không giữ phiên đăng nhập: truy cập **HTTPS**, vì cookie production có `Secure`.
- Hết hạn mức: xem Usage, giảm dung lượng/lưu lượng hoặc đợi chu kỳ mới; không tự nâng cấp trả phí.
- Rate limit hiện dùng IP kết nối trực tiếp. Sau proxy, nhiều người có thể dùng chung hạn mức. Chỉ cấu hình trust proxy sau khi xác minh chuỗi proxy; không tin mọi `X-Forwarded-For`.

Tài liệu kỹ thuật: [Render Express](https://render.com/docs/deploy-node-express-app), [node-postgres transactions](https://node-postgres.com/features/transactions), [TLS](https://node-postgres.com/features/ssl).
