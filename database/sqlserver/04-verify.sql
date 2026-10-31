/* Chạy sau 01 và 02 trên bản dữ liệu mẫu. Các thay đổi thử đều rollback.
   Không cần chạy file này khi chỉ xem hoặc sử dụng database. */
USE [TrungTamNgoaiNgu];
GO
SET NOCOUNT ON;
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET ARITHABORT ON;
SET NUMERIC_ROUNDABORT OFF;
SET XACT_ABORT OFF;

-- SSMS may add dbo.sysdiagrams when the user saves a database diagram.
IF (SELECT COUNT(*) FROM sys.tables WHERE schema_id=SCHEMA_ID(N'dbo') AND is_ms_shipped=0 AND name<>N'sysdiagrams') <> 16 THROW 51100, 'Expected 16 application tables.', 1;
IF (SELECT COUNT(*) FROM dbo.courses) <> 99 THROW 51100, 'Expected 99 courses.', 1;
IF (SELECT COUNT(*) FROM dbo.teachers) <> 24 THROW 51100, 'Expected 24 teachers.', 1;
IF (SELECT COUNT(*) FROM dbo.classes) <> 302 THROW 51100, 'Expected 302 classes.', 1;
IF (SELECT COUNT(*) FROM dbo.questions) <> 463 THROW 51100, 'Expected 463 questions.', 1;
IF (SELECT COUNT(*) FROM dbo.questions WHERE assessment='competency') <> 288 THROW 51100, 'Expected 288 competency questions.', 1;
IF (SELECT COUNT(DISTINCT language) FROM dbo.courses) <> 16 THROW 51100, 'Expected 16 languages.', 1;
IF (SELECT COUNT(*) FROM dbo.vw_LichKhaiGiang) <> 302 THROW 51100, 'Schedule view mismatch.', 1;
IF NOT EXISTS (SELECT 1 FROM dbo.teachers WHERE name=N'Nguyễn Minh Anh') THROW 51100, 'Unicode seed mismatch.', 1;

-- Each test must reject the write, then rollback without changing sample data.
DECLARE @Tests TABLE (id int IDENTITY PRIMARY KEY, title nvarchar(100), command nvarchar(max), expected int);
INSERT INTO @Tests VALUES
(N'Khóa ngoại lớp học',N'UPDATE dbo.classes SET courseId=-1 WHERE id=1',547),
(N'Học phí âm',N'UPDATE dbo.courses SET tuition=-1 WHERE id=1',547),
(N'Sĩ số bằng 0',N'UPDATE dbo.classes SET capacity=0 WHERE id=1',547),
(N'Ngày kết thúc trước ngày bắt đầu',N'UPDATE dbo.classes SET endDate=DATEADD(day,-1,startDate) WHERE id=1',547),
(N'Giờ kết thúc trước giờ bắt đầu',N'UPDATE dbo.classes SET startTime=''20:00'',endTime=''18:00'' WHERE id=1',547),
(N'JSON điểm không hợp lệ',N'UPDATE dbo.enrollments SET grades=N''not-json'' WHERE id=1',547),
(N'Điểm kiểm tra vượt tổng câu',N'INSERT INTO dbo.placement_results(score,total,level) VALUES(26,25,N''B1'')',547),
(N'Vai trò tài khoản không hợp lệ',N'UPDATE dbo.users SET role=''teacher'' WHERE id=2',547),
(N'Email trùng không phân biệt hoa thường',N'UPDATE dbo.users SET email=N''ADMIN@VINHENGLISH.VN'' WHERE id=2',2627),
(N'Đăng ký trùng email',N'INSERT INTO dbo.enrollments(classId,name,email,phone) SELECT classId,name,email,phone FROM dbo.enrollments WHERE id=1',2601),
(N'Đăng ký trùng tài khoản với email khác',N'INSERT INTO dbo.enrollments(userId,classId,name,email,phone) SELECT userId,classId,name,N''other@example.com'',phone FROM dbo.enrollments WHERE id=1',2601),
(N'Tệp có kích thước khai báo sai',N'INSERT INTO dbo.materials(classId,title,filename,mime,size,content) VALUES(1,N''T'',N''t.pdf'',''application/pdf'',20,0x25504446)',547);

DECLARE @n int=1, @title nvarchar(100), @sql nvarchar(max), @expected int, @actual int;
WHILE @n <= (SELECT COUNT(*) FROM @Tests)
BEGIN
    SELECT @title=title,@sql=command,@expected=expected FROM @Tests WHERE id=@n;
    SET @actual=0;
    BEGIN TRANSACTION;
    BEGIN TRY
        EXEC sp_executesql @sql;
    END TRY
    BEGIN CATCH
        SET @actual=ERROR_NUMBER();
    END CATCH;
    IF XACT_STATE()<>0 ROLLBACK;
    IF @actual <> @expected
    BEGIN
        PRINT @title;
        THROW 51101, 'Expected database constraint rejection was not observed.', 1;
    END;
    PRINT N'PASS: '+@title;
    SET @n+=1;
END;

-- A cancelled record must not prevent a new active enrollment.
BEGIN TRY
    BEGIN TRANSACTION;
    UPDATE dbo.enrollments SET status='cancelled' WHERE id=1;
    INSERT INTO dbo.enrollments(userId,classId,name,email,phone)
    SELECT userId,classId,name,email,phone FROM dbo.enrollments WHERE id=1;
    ROLLBACK;
    PRINT N'PASS: Cho phép đăng ký lại sau khi hủy';
END TRY
BEGIN CATCH
    IF XACT_STATE()<>0 ROLLBACK;
    THROW;
END CATCH;

DBCC CHECKCONSTRAINTS WITH ALL_CONSTRAINTS;
PRINT N'Hoàn tất kiểm tra. Dữ liệu mẫu giữ nguyên; ID tự tăng có thể có khoảng trống do rollback.';
GO
