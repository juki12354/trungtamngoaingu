/* Vinh English Center - SQL Server 2016+ (tested with SQL Server 2022).
   Run this file in SSMS, then 02-sample-data.sql, then 03-queries.sql.
   No DROP DATABASE/TABLE: existing application tables are never overwritten.
   This standalone SQL Server edition does not change the running website.
*/
USE [master];
GO
IF DB_ID(N'TrungTamNgoaiNgu') IS NULL
    EXEC(N'CREATE DATABASE [TrungTamNgoaiNgu] COLLATE Latin1_General_100_CI_AS_SC');
GO
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

-- Refuse to mix this schema into an existing database containing user tables.
IF EXISTS (SELECT 1 FROM sys.tables WHERE is_ms_shipped = 0)
    THROW 51000, N'Database đã có bảng. Không ghi đè; hãy dùng database mới trống.', 1;

BEGIN TRY
    BEGIN TRANSACTION;

    CREATE TABLE dbo.users (
        id int IDENTITY(1,1) CONSTRAINT PK_users PRIMARY KEY,
        name nvarchar(100) NOT NULL,
        email nvarchar(254) COLLATE Latin1_General_100_CI_AS_SC NOT NULL CONSTRAINT UQ_users_email UNIQUE,
        phone varchar(20) NOT NULL DEFAULT '',
        birthday date NULL,
        passwordHash varchar(161) NOT NULL,
        role varchar(10) NOT NULL DEFAULT 'student',
        CONSTRAINT CK_users_role CHECK (role IN ('student','admin')),
        CONSTRAINT CK_users_name CHECK (LEN(LTRIM(RTRIM(name))) > 0),
        CONSTRAINT CK_users_hash CHECK (LEN(passwordHash) = 161 AND SUBSTRING(passwordHash,33,1) = ':')
    );

    CREATE TABLE dbo.courses (
        id int IDENTITY(1,1) CONSTRAINT PK_courses PRIMARY KEY,
        language varchar(8) NOT NULL DEFAULT 'en',
        levelCode varchar(20) NOT NULL DEFAULT '',
        name nvarchar(500) NOT NULL,
        category nvarchar(100) NOT NULL,
        level nvarchar(100) NOT NULL,
        duration int NOT NULL, -- weeks
        tuition decimal(12,0) NOT NULL, -- VND
        lessons int NOT NULL,
        audience nvarchar(500) NOT NULL,
        image nvarchar(1000) NOT NULL DEFAULT N'',
        description nvarchar(max) NOT NULL,
        material nvarchar(max) NOT NULL DEFAULT N'',
        CONSTRAINT CK_courses_numbers CHECK (duration BETWEEN 1 AND 104 AND tuition BETWEEN 0 AND 100000000 AND lessons BETWEEN 1 AND 500)
    );

    CREATE TABLE dbo.teachers (
        id int IDENTITY(1,1) CONSTRAINT PK_teachers PRIMARY KEY,
        languages nvarchar(200) NOT NULL DEFAULT N'["en"]' CONSTRAINT CK_teachers_languages CHECK (ISJSON(languages)=1 AND LEFT(LTRIM(languages),1)=N'['),
        name nvarchar(500) NOT NULL,
        degree nvarchar(500) NOT NULL,
        experience int NOT NULL,
        specialty nvarchar(500) NOT NULL,
        image nvarchar(1000) NOT NULL DEFAULT N'',
        description nvarchar(max) NOT NULL,
        achievements nvarchar(3000) NOT NULL DEFAULT N'',
        nationality nvarchar(80) NOT NULL DEFAULT N'',
        CONSTRAINT CK_teachers_experience CHECK (experience BETWEEN 0 AND 60)
    );

    CREATE TABLE dbo.classes (
        id int IDENTITY(1,1) CONSTRAINT PK_classes PRIMARY KEY,
        courseId int NOT NULL CONSTRAINT FK_classes_courses REFERENCES dbo.courses(id),
        teacherId int NOT NULL CONSTRAINT FK_classes_teachers REFERENCES dbo.teachers(id),
        name nvarchar(200) NOT NULL CONSTRAINT UQ_classes_name UNIQUE,
        startDate date NOT NULL,
        endDate date NOT NULL,
        schedule nvarchar(500) NOT NULL DEFAULT N'',
        campus nvarchar(500) NOT NULL,
        capacity int NOT NULL,
        weekdays nvarchar(30) NOT NULL DEFAULT N'[]', -- JSON ISO days: 1=Monday, 7=Sunday
        startTime time(0) NULL,
        endTime time(0) NULL,
        room nvarchar(80) NOT NULL DEFAULT N'',
        status varchar(15) NOT NULL DEFAULT 'enrolling',
        CONSTRAINT CK_classes_dates CHECK (endDate >= startDate),
        CONSTRAINT CK_classes_times CHECK ((startTime IS NULL AND endTime IS NULL) OR (startTime IS NOT NULL AND endTime IS NOT NULL AND endTime > startTime)),
        CONSTRAINT CK_classes_capacity CHECK (capacity BETWEEN 1 AND 100),
        CONSTRAINT CK_classes_days CHECK (ISJSON(weekdays)=1 AND LEFT(LTRIM(weekdays),1)=N'['),
        CONSTRAINT CK_classes_status CHECK (status IN ('enrolling','ongoing','completed','cancelled'))
    );

    CREATE TABLE dbo.enrollments (
        id int IDENTITY(1,1) CONSTRAINT PK_enrollments PRIMARY KEY,
        userId int NULL CONSTRAINT FK_enrollments_users REFERENCES dbo.users(id),
        classId int NOT NULL CONSTRAINT FK_enrollments_classes REFERENCES dbo.classes(id),
        name nvarchar(100) NOT NULL,
        email nvarchar(254) COLLATE Latin1_General_100_CI_AS_SC NOT NULL,
        phone varchar(20) NOT NULL,
        birthday date NULL,
        note nvarchar(2000) NOT NULL DEFAULT N'',
        status varchar(12) NOT NULL DEFAULT 'pending',
        grades nvarchar(500) NOT NULL DEFAULT N'{}',
        createdAt datetime2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
        verifiedAt datetime2(0) NULL,
        verifiedBy int NULL CONSTRAINT FK_enrollments_verifier REFERENCES dbo.users(id),
        CONSTRAINT CK_enrollments_status CHECK (status IN ('pending','confirmed','cancelled')),
        CONSTRAINT CK_enrollments_grades CHECK (ISJSON(grades)=1 AND LEFT(LTRIM(grades),1)=N'{')
    );

    CREATE TABLE dbo.questions (
        id int IDENTITY(1,1) CONSTRAINT PK_questions PRIMARY KEY,
        language varchar(8) NOT NULL DEFAULT 'en',
        levelCode varchar(20) NOT NULL DEFAULT '',
        skill varchar(20) NOT NULL DEFAULT 'vocabulary',
        assessment varchar(20) NOT NULL DEFAULT 'legacy',
        prompt nvarchar(500) NOT NULL,
        options nvarchar(max) NOT NULL,
        answer tinyint NOT NULL, -- zero-based index, 0..3
        CONSTRAINT CK_questions_options CHECK (ISJSON(options)=1 AND LEFT(LTRIM(options),1)=N'['),
        CONSTRAINT CK_questions_answer CHECK (answer BETWEEN 0 AND 3)
    );

    CREATE TABLE dbo.placement_results (
        id int IDENTITY(1,1) CONSTRAINT PK_placement_results PRIMARY KEY,
        language varchar(8) NOT NULL DEFAULT 'en',
        userId int NULL CONSTRAINT FK_results_users REFERENCES dbo.users(id) ON DELETE SET NULL,
        score int NOT NULL,
        total int NOT NULL,
        level nvarchar(50) NOT NULL,
        createdAt datetime2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
        review nvarchar(max) NOT NULL DEFAULT N'[]',
        analysis nvarchar(max) NOT NULL DEFAULT N'{}' CONSTRAINT CK_results_analysis CHECK(ISJSON(analysis)=1),
        CONSTRAINT CK_results_score CHECK (total > 0 AND score BETWEEN 0 AND total),
        CONSTRAINT CK_results_review CHECK (ISJSON(review)=1 AND LEFT(LTRIM(review),1)=N'[')
    );

    CREATE TABLE dbo.news (
        id int IDENTITY(1,1) CONSTRAINT PK_news PRIMARY KEY,
        title nvarchar(500) NOT NULL,
        category nvarchar(100) NOT NULL,
        [date] date NOT NULL,
        image nvarchar(1000) NOT NULL DEFAULT N'',
        excerpt nvarchar(500) NOT NULL,
        content nvarchar(max) NOT NULL
    );

    CREATE TABLE dbo.contacts (
        id int IDENTITY(1,1) CONSTRAINT PK_contacts PRIMARY KEY,
        name nvarchar(100) NOT NULL,
        email nvarchar(254) NOT NULL,
        phone varchar(20) NOT NULL,
        message nvarchar(3000) NOT NULL,
        createdAt datetime2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
        status varchar(12) NOT NULL DEFAULT 'new',
        note nvarchar(3000) NOT NULL DEFAULT N'',
        kind varchar(15) NOT NULL DEFAULT 'consultation',
        age int NULL,
        courseId int NULL CONSTRAINT FK_contacts_courses REFERENCES dbo.courses(id) ON DELETE SET NULL,
        campus nvarchar(500) NOT NULL DEFAULT N'',
        CONSTRAINT CK_contacts_status CHECK (status IN ('new','contacted','done')),
        CONSTRAINT CK_contacts_kind CHECK (kind IN ('consultation','trial')),
        CONSTRAINT CK_contacts_age CHECK (age IS NULL OR age BETWEEN 4 AND 100)
    );

    CREATE TABLE dbo.metadata (
        [key] nvarchar(200) CONSTRAINT PK_metadata PRIMARY KEY,
        value nvarchar(max) NOT NULL
    );

    CREATE TABLE dbo.placement_attempts (
        token varchar(128) CONSTRAINT PK_placement_attempts PRIMARY KEY,
        language varchar(8) NOT NULL DEFAULT 'en',
        assessment varchar(20) NOT NULL DEFAULT 'legacy',
        userId int NULL CONSTRAINT FK_attempts_users REFERENCES dbo.users(id),
        questions nvarchar(max) NOT NULL,
        expires bigint NOT NULL, -- Unix epoch milliseconds, matches Node.js
        result nvarchar(max) NULL,
        CONSTRAINT CK_attempts_questions CHECK (ISJSON(questions)=1 AND LEFT(LTRIM(questions),1)=N'['),
        CONSTRAINT CK_attempts_result CHECK (result IS NULL OR ISJSON(result)=1),
        CONSTRAINT CK_attempts_expiry CHECK (expires > 0)
    );

    CREATE TABLE dbo.materials (
        id int IDENTITY(1,1) CONSTRAINT PK_materials PRIMARY KEY,
        classId int NOT NULL CONSTRAINT FK_materials_classes REFERENCES dbo.classes(id),
        title nvarchar(500) NOT NULL,
        lesson nvarchar(500) NOT NULL DEFAULT N'',
        filename nvarchar(255) NOT NULL,
        mime varchar(100) NOT NULL,
        size int NOT NULL,
        content varbinary(max) NOT NULL,
        createdAt datetime2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT CK_materials_size CHECK (size BETWEEN 1 AND 5242880 AND DATALENGTH(content)=size)
    );

    CREATE TABLE dbo.audit_logs (
        id int IDENTITY(1,1) CONSTRAINT PK_audit_logs PRIMARY KEY,
        actorId int NULL CONSTRAINT FK_audit_users REFERENCES dbo.users(id) ON DELETE SET NULL,
        action nvarchar(50) NOT NULL,
        resource nvarchar(50) NOT NULL,
        recordId int NULL,
        createdAt datetime2(0) NOT NULL DEFAULT SYSUTCDATETIME()
    );

    CREATE TABLE dbo.sessions (
        token varchar(64) CONSTRAINT PK_sessions PRIMARY KEY, -- SHA-256 digest, not raw cookie
        userId int NOT NULL CONSTRAINT FK_sessions_users REFERENCES dbo.users(id) ON DELETE CASCADE,
        expires bigint NOT NULL,
        CONSTRAINT CK_sessions_expiry CHECK (expires > 0)
    );

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

    CREATE UNIQUE INDEX UX_enrollments_active_email ON dbo.enrollments(email,classId) WHERE status <> 'cancelled';
    CREATE UNIQUE INDEX UX_enrollments_active_user ON dbo.enrollments(userId,classId) WHERE status <> 'cancelled' AND userId IS NOT NULL;
    CREATE INDEX IX_enrollments_class_status ON dbo.enrollments(classId,status);
    CREATE INDEX IX_classes_course ON dbo.classes(courseId,startDate);
    CREATE INDEX IX_classes_teacher ON dbo.classes(teacherId,startDate);
    CREATE INDEX IX_materials_class ON dbo.materials(classId);
    CREATE INDEX IX_sessions_user ON dbo.sessions(userId);
    CREATE INDEX IX_sessions_expiry ON dbo.sessions(expires);
    CREATE INDEX IX_results_user ON dbo.placement_results(userId,createdAt);
    CREATE INDEX IX_contacts_status ON dbo.contacts(status,createdAt);

    -- Dynamic batches allow views and tables to be created atomically together.
    EXEC(N'CREATE VIEW dbo.vw_LichKhaiGiang AS
        SELECT cl.id AS MaLop, cl.name AS TenLop, c.name AS KhoaHoc,
               t.name AS GiaoVien, cl.campus AS CoSo, cl.room AS Phong,
               cl.startDate AS NgayBatDau, cl.endDate AS NgayKetThuc,
               cl.weekdays AS ThuHoc, cl.startTime AS GioBatDau, cl.endTime AS GioKetThuc,
               cl.capacity AS SiSoToiDa, c.tuition AS HocPhi, cl.status AS TrangThai,
               c.language AS NgonNgu, c.levelCode AS CapDo,
               (SELECT COUNT(*) FROM dbo.enrollments e WHERE e.classId=cl.id AND e.status=''confirmed'') AS DaXacNhan
        FROM dbo.classes cl JOIN dbo.courses c ON c.id=cl.courseId
        JOIN dbo.teachers t ON t.id=cl.teacherId;');

    EXEC(N'CREATE VIEW dbo.vw_DangKyHoc AS
        SELECT e.id AS MaDangKy, e.userId AS MaTaiKhoan, e.name AS HoTen,
               e.email AS Email, e.phone AS DienThoai, c.name AS KhoaHoc,
               cl.name AS TenLop, e.status AS TrangThai, e.createdAt AS NgayDangKy,
               TRY_CONVERT(decimal(4,2),JSON_VALUE(e.grades,''$.listening'')) AS DiemNghe,
               TRY_CONVERT(decimal(4,2),JSON_VALUE(e.grades,''$.reading'')) AS DiemDoc,
               TRY_CONVERT(decimal(4,2),JSON_VALUE(e.grades,''$.writing'')) AS DiemViet,
               TRY_CONVERT(decimal(4,2),JSON_VALUE(e.grades,''$.speaking'')) AS DiemNoi
        FROM dbo.enrollments e JOIN dbo.classes cl ON cl.id=e.classId
        JOIN dbo.courses c ON c.id=cl.courseId;');

    EXEC(N'CREATE VIEW dbo.vw_HocVien AS
        SELECT id AS MaHocVien, name AS HoTen, email AS Email,
               phone AS DienThoai, birthday AS NgaySinh
        FROM dbo.users WHERE role=''student'';');

    COMMIT;
    PRINT N'Đã tạo 16 bảng và 3 view trong TrungTamNgoaiNgu.';
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK;
    THROW;
END CATCH;
GO
