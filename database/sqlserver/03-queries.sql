USE [TrungTamNgoaiNgu];
GO
SET NOCOUNT ON;

-- 1. Khóa học và học phí (VND).
SELECT id AS MaKhoaHoc, name AS TenKhoaHoc, level AS TrinhDo,
       duration AS SoTuan, lessons AS SoBuoi, tuition AS HocPhi
FROM dbo.courses ORDER BY id;

-- 2. Giáo viên, bằng cấp và thành tích (dữ liệu minh họa).
SELECT id AS MaGiaoVien, name AS HoTen, nationality AS QuocTich,
       degree AS BangCap, experience AS SoNamKinhNghiem,
       specialty AS ChuyenMon, achievements AS ThanhTich
FROM dbo.teachers ORDER BY id;

-- 3. Toàn bộ lịch khai giảng, nhiều ca theo từng khóa.
SELECT *, SiSoToiDa - DaXacNhan AS ChoConLai
FROM dbo.vw_LichKhaiGiang ORDER BY KhoaHoc, NgayBatDau, GioBatDau;

-- 4. Lọc lớp buổi tối còn chỗ và chưa kết thúc.
-- Ngày mẫu được chụp khi xuất file; về sau có thể không còn lớp khớp.
SELECT * FROM dbo.vw_LichKhaiGiang
WHERE GioBatDau >= '17:00' AND TrangThai = 'enrolling'
  AND NgayKetThuc >= CONVERT(date,GETDATE()) AND DaXacNhan < SiSoToiDa;

-- 5. Danh sách học viên (view không lộ passwordHash).
SELECT * FROM dbo.vw_HocVien;

-- 6. Đăng ký và điểm 4 kỹ năng, gồm cả đăng ký khách chưa có tài khoản.
SELECT * FROM dbo.vw_DangKyHoc ORDER BY NgayDangKy DESC;

-- 7. Lịch học của một học viên đã được xác nhận.
DECLARE @MaHocVien int = (SELECT id FROM dbo.users WHERE email=N'hocvien@example.com');
SELECT cl.name AS TenLop, c.name AS KhoaHoc, t.name AS GiaoVien,
       cl.schedule AS LichHoc, cl.campus AS CoSo, cl.room AS Phong
FROM dbo.enrollments e
JOIN dbo.classes cl ON cl.id=e.classId
JOIN dbo.courses c ON c.id=cl.courseId
JOIN dbo.teachers t ON t.id=cl.teacherId
WHERE e.userId=@MaHocVien AND e.status='confirmed';

-- 8. Thống kê đăng ký theo khóa học; không coi đây là doanh thu đã thu tiền.
SELECT c.id, c.name AS KhoaHoc, COUNT(e.id) AS TongDangKy,
       SUM(CASE WHEN e.status='confirmed' THEN 1 ELSE 0 END) AS DaXacNhan,
       SUM(CASE WHEN e.status='pending' THEN 1 ELSE 0 END) AS ChoDuyet
FROM dbo.courses c
LEFT JOIN dbo.classes cl ON cl.courseId=c.id
LEFT JOIN dbo.enrollments e ON e.classId=cl.id
GROUP BY c.id,c.name ORDER BY c.id;

-- 9. Yêu cầu tư vấn/học thử chưa xử lý.
SELECT name, email, phone, kind, age, message, createdAt
FROM dbo.contacts WHERE status='new' ORDER BY createdAt DESC;

-- 10. Câu hỏi và 4 lựa chọn. Đáp án chỉ dùng cho Admin/chấm tại server.
SELECT q.id, q.prompt, o.[key] AS ThuTuLuaChon, o.value AS LuaChon
FROM dbo.questions q CROSS APPLY OPENJSON(q.options) o
ORDER BY q.id, CONVERT(int,o.[key]);
GO
