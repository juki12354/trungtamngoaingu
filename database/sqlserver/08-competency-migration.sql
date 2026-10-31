/* Database cũ: sao lưu, chạy 06+07 nếu chưa có đa ngôn ngữ, rồi 08+09.
   Chỉ thêm cột còn thiếu; không sửa điểm hoặc đăng ký đã có. */
USE [TrungTamNgoaiNgu];
GO
SET XACT_ABORT ON;
BEGIN TRY
BEGIN TRANSACTION;
IF COL_LENGTH('dbo.courses','levelCode') IS NULL
    ALTER TABLE dbo.courses ADD levelCode varchar(20) NOT NULL DEFAULT '';
IF COL_LENGTH('dbo.questions','levelCode') IS NULL
    ALTER TABLE dbo.questions ADD levelCode varchar(20) NOT NULL DEFAULT '';
IF COL_LENGTH('dbo.questions','skill') IS NULL
    ALTER TABLE dbo.questions ADD skill varchar(20) NOT NULL DEFAULT 'vocabulary';
IF COL_LENGTH('dbo.questions','assessment') IS NULL
    ALTER TABLE dbo.questions ADD assessment varchar(20) NOT NULL DEFAULT 'legacy';
IF COL_LENGTH('dbo.placement_attempts','assessment') IS NULL
    ALTER TABLE dbo.placement_attempts ADD assessment varchar(20) NOT NULL DEFAULT 'legacy';
IF COL_LENGTH('dbo.placement_results','analysis') IS NULL
    ALTER TABLE dbo.placement_results ADD analysis nvarchar(max) NOT NULL DEFAULT N'{}';
COMMIT;
END TRY
BEGIN CATCH
IF XACT_STATE()<>0 ROLLBACK;
THROW;
END CATCH;
GO
IF NOT EXISTS(SELECT 1 FROM sys.check_constraints WHERE name=N'CK_results_analysis' AND parent_object_id=OBJECT_ID(N'dbo.placement_results'))
    ALTER TABLE dbo.placement_results WITH CHECK ADD CONSTRAINT CK_results_analysis CHECK(ISJSON(analysis)=1);
GO
ALTER VIEW dbo.vw_LichKhaiGiang AS
SELECT cl.id AS MaLop, cl.name AS TenLop, c.name AS KhoaHoc,
       t.name AS GiaoVien, cl.campus AS CoSo, cl.room AS Phong,
       cl.startDate AS NgayBatDau, cl.endDate AS NgayKetThuc,
       cl.weekdays AS ThuHoc, cl.startTime AS GioBatDau, cl.endTime AS GioKetThuc,
       cl.capacity AS SiSoToiDa, c.tuition AS HocPhi, cl.status AS TrangThai,
       c.language AS NgonNgu, c.levelCode AS CapDo,
       (SELECT COUNT(*) FROM dbo.enrollments e WHERE e.classId=cl.id AND e.status='confirmed') AS DaXacNhan
FROM dbo.classes cl JOIN dbo.courses c ON c.id=cl.courseId
JOIN dbo.teachers t ON t.id=cl.teacherId;
GO
