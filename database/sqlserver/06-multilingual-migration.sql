/* Nâng cấp database cũ, giữ nguyên tài khoản/đăng ký/nội dung đã sửa.
   Database mới chạy 01 và 02. Database cũ chạy 06 rồi 07.
   Có thể chạy lại; chỉ thêm cột còn thiếu. */
USE [TrungTamNgoaiNgu];
GO
SET XACT_ABORT ON;
BEGIN TRY
    BEGIN TRANSACTION;
    IF COL_LENGTH('dbo.courses','language') IS NULL
        ALTER TABLE dbo.courses ADD language varchar(8) NOT NULL CONSTRAINT DF_courses_language DEFAULT 'en';
    IF COL_LENGTH('dbo.teachers','languages') IS NULL
        ALTER TABLE dbo.teachers ADD languages nvarchar(200) NOT NULL CONSTRAINT DF_teachers_languages DEFAULT N'["en"]';
    IF COL_LENGTH('dbo.questions','language') IS NULL
        ALTER TABLE dbo.questions ADD language varchar(8) NOT NULL CONSTRAINT DF_questions_language DEFAULT 'en';
    IF COL_LENGTH('dbo.placement_results','language') IS NULL
        ALTER TABLE dbo.placement_results ADD language varchar(8) NOT NULL CONSTRAINT DF_results_language DEFAULT 'en';
    IF COL_LENGTH('dbo.placement_attempts','language') IS NULL
        ALTER TABLE dbo.placement_attempts ADD language varchar(8) NOT NULL CONSTRAINT DF_attempts_language DEFAULT 'en';
    COMMIT;
END TRY
BEGIN CATCH
    IF XACT_STATE()<>0 ROLLBACK;
    THROW;
END CATCH;
GO
-- Compile after the new columns are available.
IF NOT EXISTS(SELECT 1 FROM sys.check_constraints WHERE name=N'CK_teachers_languages' AND parent_object_id=OBJECT_ID(N'dbo.teachers'))
    ALTER TABLE dbo.teachers WITH CHECK ADD CONSTRAINT CK_teachers_languages CHECK(ISJSON(languages)=1 AND LEFT(LTRIM(languages),1)=N'[');
GO
