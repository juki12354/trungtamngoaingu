/* Bổ sung tuyển dụng giáo viên; chạy sau các nâng cấp 06–09 nếu database cũ.
   Chạy lại an toàn, không ghi đè CV hoặc bài làm. Website vẫn dùng SQLite/PostgreSQL. */
USE [TrungTamNgoaiNgu];
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET ARITHABORT ON;
SET NUMERIC_ROUNDABORT OFF;
SET XACT_ABORT ON;
IF OBJECT_ID(N'dbo.users',N'U') IS NULL THROW 51300, N'Cần tạo schema cũ trước.', 1;
BEGIN TRY
    BEGIN TRANSACTION;
    IF OBJECT_ID(N'dbo.teacher_applications',N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.teacher_applications (
            id int IDENTITY(1,1) CONSTRAINT PK_teacher_applications PRIMARY KEY,
            userId int NOT NULL CONSTRAINT FK_teacher_applications_users REFERENCES dbo.users(id),
            name nvarchar(150) NOT NULL, email nvarchar(254) NOT NULL, phone varchar(20) NOT NULL,
            language varchar(8) NOT NULL, levelCode varchar(20) NOT NULL,
            qualifications nvarchar(3000) NOT NULL, experience int NOT NULL CHECK(experience BETWEEN 0 AND 60),
            coverLetter nvarchar(3000) NOT NULL DEFAULT N'',
            filename nvarchar(180) NOT NULL, mime varchar(100) NOT NULL,
            size int NOT NULL, content varbinary(max) NOT NULL,
            status varchar(20) NOT NULL DEFAULT 'submitted' CHECK(status IN ('submitted','test_assigned','review','approved','rejected')),
            feedback nvarchar(3000) NOT NULL DEFAULT N'', internalNote nvarchar(3000) NOT NULL DEFAULT N'',
            evaluation nvarchar(max) NOT NULL DEFAULT N'{}' CHECK(ISJSON(evaluation)=1),
            reviewedBy int NULL CONSTRAINT FK_teacher_applications_reviewers REFERENCES dbo.users(id),
            reviewedAt datetime2(3) NULL, createdAt datetime2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
            CONSTRAINT CK_teacher_applications_file CHECK(size BETWEEN 1 AND 5242880 AND DATALENGTH(content)=size)
        );
        CREATE UNIQUE INDEX UX_teacher_application_active ON dbo.teacher_applications(userId,language) WHERE status<>'rejected';
    END;
    IF OBJECT_ID(N'dbo.teacher_assessments',N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.teacher_assessments (
            id int IDENTITY(1,1) CONSTRAINT PK_teacher_assessments PRIMARY KEY,
            applicationId int NOT NULL CONSTRAINT FK_teacher_assessments_applications REFERENCES dbo.teacher_applications(id),
            language varchar(8) NOT NULL, levelCode varchar(20) NOT NULL,
            basis nvarchar(2000) NOT NULL, reason nvarchar(1000) NOT NULL DEFAULT N'',
            questions nvarchar(max) NOT NULL CHECK(ISJSON(questions)=1),
            tasks nvarchar(max) NOT NULL CHECK(ISJSON(tasks)=1),
            answers nvarchar(max) NOT NULL DEFAULT N'{}' CHECK(ISJSON(answers)=1),
            written nvarchar(max) NOT NULL DEFAULT N'[]' CHECK(ISJSON(written)=1),
            status varchar(20) NOT NULL DEFAULT 'assigned' CHECK(status IN ('assigned','started','submitted','superseded')),
            startedAt bigint NULL, expires bigint NULL, submittedAt datetime2(3) NULL, score int NULL CHECK(score>=0),
            createdBy int NOT NULL CONSTRAINT FK_teacher_assessments_users REFERENCES dbo.users(id),
            createdAt datetime2(3) NOT NULL DEFAULT SYSUTCDATETIME()
        );
        CREATE INDEX IX_teacher_assessment_application ON dbo.teacher_assessments(applicationId,id);
    END;
    COMMIT;
    PRINT N'Đã bổ sung 2 bảng tuyển dụng và 4 khóa ngoại; dữ liệu hiện có giữ nguyên.';
END TRY
BEGIN CATCH
    IF XACT_STATE()<>0 ROLLBACK;
    THROW;
END CATCH;
GO
