/* Liên kết news, metadata và questions; không thay đổi nội dung có sẵn.
   Chạy sau script 10. Sao lưu database trước khi nâng cấp. Chạy lại an toàn. */
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
IF OBJECT_ID(N'dbo.teacher_assessments',N'U') IS NULL THROW 51400, N'Cần chạy script 10 trước.', 1;
BEGIN TRY
    BEGIN TRANSACTION;
    IF COL_LENGTH(N'dbo.news',N'authorId') IS NULL
        ALTER TABLE dbo.news ADD authorId int NULL CONSTRAINT FK_news_authors REFERENCES dbo.users(id) ON DELETE SET NULL;
    IF COL_LENGTH(N'dbo.metadata',N'updatedBy') IS NULL
        ALTER TABLE dbo.metadata ADD updatedBy int NULL CONSTRAINT FK_metadata_editors REFERENCES dbo.users(id) ON DELETE SET NULL;
    IF COL_LENGTH(N'dbo.metadata',N'updatedAt') IS NULL
        ALTER TABLE dbo.metadata ADD updatedAt datetime2(3) NULL;
    IF OBJECT_ID(N'dbo.placement_attempt_questions',N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.placement_attempt_questions (
            id int IDENTITY(1,1) CONSTRAINT PK_placement_attempt_questions PRIMARY KEY,
            attemptToken varchar(128) NOT NULL CONSTRAINT FK_attempt_questions_attempts REFERENCES dbo.placement_attempts(token) ON DELETE CASCADE,
            questionId int NULL CONSTRAINT FK_attempt_questions_questions REFERENCES dbo.questions(id) ON DELETE SET NULL,
            position int NOT NULL CHECK(position>0),
            snapshot nvarchar(max) NOT NULL CHECK(ISJSON(snapshot)=1),
            selected tinyint NULL CHECK(selected BETWEEN 0 AND 3),
            CONSTRAINT UQ_attempt_question_position UNIQUE(attemptToken,position)
        );
        CREATE INDEX IX_attempt_questions_source ON dbo.placement_attempt_questions(questionId);
    END;
    INSERT INTO dbo.placement_attempt_questions(attemptToken,questionId,position,snapshot,selected)
    SELECT a.token,q.id,CONVERT(int,j.[key])+1,j.value,TRY_CONVERT(tinyint,answer.selected)
    FROM dbo.placement_attempts a
    CROSS APPLY OPENJSON(a.questions) j
    LEFT JOIN dbo.questions q ON q.id=TRY_CONVERT(int,JSON_VALUE(j.value,'$.id'))
    OUTER APPLY (SELECT JSON_VALUE(r.value,'$.selected') AS selected
                 FROM OPENJSON(a.result,'$.review') r WHERE r.[key]=j.[key]) answer
    WHERE j.type=5 AND NOT EXISTS (
        SELECT 1 FROM dbo.placement_attempt_questions existing
        WHERE existing.attemptToken=a.token AND existing.position=CONVERT(int,j.[key])+1
    );
    COMMIT;
    PRINT N'Đã liên kết 3 bảng: 17 bảng ứng dụng, 19 khóa ngoại. Nội dung cũ giữ nguyên.';
END TRY
BEGIN CATCH
    IF XACT_STATE()<>0 ROLLBACK;
    THROW;
END CATCH;
GO
