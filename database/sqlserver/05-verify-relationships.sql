/* Kiểm tra quan hệ thực tế, bản ghi mồ côi và thao tác xóa.
   Tất cả bản ghi thử nằm trong transaction và được rollback.
   Chạy sau 01-schema.sql. Không cần dữ liệu mẫu.
   ID tự tăng có thể có khoảng trống sau kiểm thử rollback. */
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
SET LOCK_TIMEOUT 15000;

DECLARE @Expected TABLE (
    childTable sysname, childColumn sysname, parentTable sysname,
    deleteAction nvarchar(60), nullable bit
);
INSERT INTO @Expected VALUES
('classes','courseId','courses','NO_ACTION',0),
('classes','teacherId','teachers','NO_ACTION',0),
('enrollments','userId','users','NO_ACTION',1),
('enrollments','classId','classes','NO_ACTION',0),
('enrollments','verifiedBy','users','NO_ACTION',1),
('placement_attempts','userId','users','NO_ACTION',1),
('placement_results','userId','users','SET_NULL',1),
('materials','classId','classes','NO_ACTION',0),
('contacts','courseId','courses','SET_NULL',1),
('sessions','userId','users','CASCADE',0),
('audit_logs','actorId','users','SET_NULL',1),
('teacher_applications','userId','users','NO_ACTION',0),
('teacher_applications','reviewedBy','users','NO_ACTION',1),
('teacher_assessments','applicationId','teacher_applications','NO_ACTION',0),
('teacher_assessments','createdBy','users','NO_ACTION',0);

IF (SELECT COUNT(*) FROM sys.foreign_keys WHERE schema_id=SCHEMA_ID(N'dbo')) <> 15
    THROW 51200, 'Expected exactly 15 foreign keys.', 1;

IF EXISTS (
    SELECT 1 FROM @Expected e
    WHERE NOT EXISTS (
        SELECT 1 FROM sys.foreign_keys fk
        JOIN sys.foreign_key_columns fc ON fc.constraint_object_id=fk.object_id
        JOIN sys.columns cc ON cc.object_id=fc.parent_object_id AND cc.column_id=fc.parent_column_id
        JOIN sys.columns pc ON pc.object_id=fc.referenced_object_id AND pc.column_id=fc.referenced_column_id
        WHERE fk.parent_object_id=OBJECT_ID(N'dbo.'+e.childTable)
          AND fk.referenced_object_id=OBJECT_ID(N'dbo.'+e.parentTable)
          AND cc.name COLLATE DATABASE_DEFAULT=e.childColumn AND pc.name=N'id'
          AND cc.system_type_id=pc.system_type_id AND cc.max_length=pc.max_length
          AND cc.is_nullable=e.nullable
          AND fk.delete_referential_action_desc COLLATE DATABASE_DEFAULT=e.deleteAction
          AND fk.update_referential_action_desc=N'NO_ACTION'
          AND fk.is_disabled=0 AND fk.is_not_trusted=0
    )
) THROW 51201, 'Foreign key target, type, nullability, action or trust mismatch.', 1;

DECLARE @child sysname,@column sysname,@parent sysname,@sql nvarchar(max),@orphans bigint;
DECLARE RelationCursor CURSOR LOCAL FAST_FORWARD FOR
    SELECT childTable,childColumn,parentTable FROM @Expected;
OPEN RelationCursor;
FETCH NEXT FROM RelationCursor INTO @child,@column,@parent;
WHILE @@FETCH_STATUS=0
BEGIN
    SET @sql=N'SELECT @n=COUNT_BIG(*) FROM dbo.'+QUOTENAME(@child)+N' c LEFT JOIN dbo.'
        +QUOTENAME(@parent)+N' p ON p.id=c.'+QUOTENAME(@column)
        +N' WHERE c.'+QUOTENAME(@column)+N' IS NOT NULL AND p.id IS NULL';
    EXEC sp_executesql @sql,N'@n bigint OUTPUT',@n=@orphans OUTPUT;
    IF @orphans<>0 THROW 51202, 'Orphan records detected.', 1;
    PRINT N'PASS: '+@child+N'.'+@column+N' -> '+@parent+N'.id; no orphans';
    FETCH NEXT FROM RelationCursor INTO @child,@column,@parent;
END;
CLOSE RelationCursor;
DEALLOCATE RelationCursor;

BEGIN TRY
    BEGIN TRANSACTION;
    DECLARE @user int,@course int,@teacher int,@class int,@enrollment int,
            @result int,@material int,@contact int,@audit int,@application int,@assessment int,
            @token varchar(64)=REPLACE(CONVERT(varchar(36),NEWID()),'-',''),
            @missing int=-2147483648;
    IF EXISTS(SELECT 1 FROM dbo.users WHERE id=@missing)
       OR EXISTS(SELECT 1 FROM dbo.courses WHERE id=@missing)
       OR EXISTS(SELECT 1 FROM dbo.teachers WHERE id=@missing)
       OR EXISTS(SELECT 1 FROM dbo.classes WHERE id=@missing)
       OR EXISTS(SELECT 1 FROM dbo.teacher_applications WHERE id=@missing)
        THROW 51203, 'Reserved invalid ID exists; cannot run negative tests.', 1;

    INSERT INTO dbo.users(name,email,passwordHash,role)
    VALUES(N'Relationship check',@token+N'@example.com',REPLICATE('0',32)+':'+REPLICATE('0',128),'student');
    SET @user=CONVERT(int,SCOPE_IDENTITY());
    INSERT INTO dbo.courses(name,category,level,duration,tuition,lessons,audience,description)
    VALUES(N'Relationship check',N'Test',N'A1',1,0,1,N'Test',N'Test');
    SET @course=CONVERT(int,SCOPE_IDENTITY());
    INSERT INTO dbo.teachers(name,degree,experience,specialty,description)
    VALUES(N'Relationship check',N'Test',0,N'Test',N'Test');
    SET @teacher=CONVERT(int,SCOPE_IDENTITY());
    INSERT INTO dbo.classes(courseId,teacherId,name,startDate,endDate,campus,capacity)
    VALUES(@course,@teacher,@token,'20300101','20300102',N'Test',1);
    SET @class=CONVERT(int,SCOPE_IDENTITY());
    INSERT INTO dbo.enrollments(userId,classId,name,email,phone,verifiedBy)
    VALUES(@user,@class,N'Test',@token+N'@example.com','0901234567',@user);
    SET @enrollment=CONVERT(int,SCOPE_IDENTITY());
    INSERT INTO dbo.placement_attempts(token,userId,questions,expires) VALUES(@token,@user,N'[]',1);
    INSERT INTO dbo.placement_results(userId,score,total,level) VALUES(@user,0,1,N'A1');
    SET @result=CONVERT(int,SCOPE_IDENTITY());
    INSERT INTO dbo.materials(classId,title,filename,mime,size,content)
    VALUES(@class,N'Test',N'test.txt','text/plain',1,0x01);
    SET @material=CONVERT(int,SCOPE_IDENTITY());
    INSERT INTO dbo.contacts(name,email,phone,message,courseId)
    VALUES(N'Test',@token+N'@example.com','0901234567',N'Test',@course);
    SET @contact=CONVERT(int,SCOPE_IDENTITY());
    INSERT INTO dbo.sessions(token,userId,expires) VALUES(@token,@user,1);
    INSERT INTO dbo.audit_logs(actorId,action,resource,recordId) VALUES(@user,N'test',N'users',@user);
    SET @audit=CONVERT(int,SCOPE_IDENTITY());

    INSERT INTO dbo.teacher_applications(userId,name,email,phone,language,levelCode,qualifications,experience,filename,mime,size,content,reviewedBy)
    VALUES(@user,N'Test',@token+N'@example.com','0901234567','ja','N2',N'JLPT N2',4,N'cv.pdf','application/pdf',1,0x01,@user);
    SET @application=CONVERT(int,SCOPE_IDENTITY());
    INSERT INTO dbo.teacher_assessments(applicationId,language,levelCode,basis,questions,tasks,createdBy)
    VALUES(@application,'ja','N2',N'CV đã được đối chiếu',N'[]',N'[]',@user);
    SET @assessment=CONVERT(int,SCOPE_IDENTITY());

    DECLARE @Checks TABLE (id int IDENTITY PRIMARY KEY, label nvarchar(150), command nvarchar(max));
    INSERT INTO @Checks VALUES
    (N'classes.courseId',N'UPDATE dbo.classes SET courseId=@bad WHERE id=@class'),
    (N'classes.teacherId',N'UPDATE dbo.classes SET teacherId=@bad WHERE id=@class'),
    (N'enrollments.userId',N'UPDATE dbo.enrollments SET userId=@bad WHERE id=@enrollment'),
    (N'enrollments.classId',N'UPDATE dbo.enrollments SET classId=@bad WHERE id=@enrollment'),
    (N'enrollments.verifiedBy',N'UPDATE dbo.enrollments SET verifiedBy=@bad WHERE id=@enrollment'),
    (N'placement_attempts.userId',N'UPDATE dbo.placement_attempts SET userId=@bad WHERE token=@token'),
    (N'placement_results.userId',N'UPDATE dbo.placement_results SET userId=@bad WHERE id=@result'),
    (N'materials.classId',N'UPDATE dbo.materials SET classId=@bad WHERE id=@material'),
    (N'contacts.courseId',N'UPDATE dbo.contacts SET courseId=@bad WHERE id=@contact'),
    (N'sessions.userId',N'UPDATE dbo.sessions SET userId=@bad WHERE token=@token'),
    (N'audit_logs.actorId',N'UPDATE dbo.audit_logs SET actorId=@bad WHERE id=@audit'),
    (N'teacher_applications.userId',N'UPDATE dbo.teacher_applications SET userId=@bad WHERE id=@application'),
    (N'teacher_applications.reviewedBy',N'UPDATE dbo.teacher_applications SET reviewedBy=@bad WHERE id=@application'),
    (N'teacher_assessments.applicationId',N'UPDATE dbo.teacher_assessments SET applicationId=@bad WHERE id=@assessment'),
    (N'teacher_assessments.createdBy',N'UPDATE dbo.teacher_assessments SET createdBy=@bad WHERE id=@assessment'),
    (N'Chặn xóa hồ sơ đang có bài kiểm tra',N'DELETE FROM dbo.teacher_applications WHERE id=@application'),
    (N'Chặn xóa khóa học đang có lớp',N'DELETE FROM dbo.courses WHERE id=@course'),
    (N'Chặn xóa giáo viên đang dạy lớp',N'DELETE FROM dbo.teachers WHERE id=@teacher'),
    (N'Chặn xóa lớp đang có đăng ký/tài liệu',N'DELETE FROM dbo.classes WHERE id=@class'),
    (N'Chặn xóa tài khoản đang có đăng ký/lượt thi',N'DELETE FROM dbo.users WHERE id=@user');

    DECLARE @i int=1,@error int,@label nvarchar(150);
    WHILE @i<=(SELECT COUNT(*) FROM @Checks)
    BEGIN
        SELECT @label=label,@sql=command FROM @Checks WHERE id=@i;
        SET @error=0;
        BEGIN TRY
            EXEC sp_executesql @sql,
                N'@bad int,@user int,@course int,@teacher int,@class int,@enrollment int,@result int,@material int,@contact int,@audit int,@token varchar(64),@application int,@assessment int',
                @bad=@missing,@user=@user,@course=@course,@teacher=@teacher,@class=@class,@enrollment=@enrollment,
                @result=@result,@material=@material,@contact=@contact,@audit=@audit,@token=@token,@application=@application,@assessment=@assessment;
        END TRY
        BEGIN CATCH
            SET @error=ERROR_NUMBER();
        END CATCH;
        IF @error<>547
        BEGIN
            PRINT @label;
            THROW 51204, 'Foreign key write/delete was not rejected as expected.', 1;
        END;
        PRINT N'PASS: Reject '+@label;
        SET @i+=1;
    END;

    -- Release blocking references to test CASCADE and SET NULL explicitly.
    UPDATE dbo.enrollments SET userId=NULL,verifiedBy=NULL WHERE id=@enrollment;
    DELETE FROM dbo.placement_attempts WHERE token=@token;
    -- The recruitment record must still block user deletion after learning links are released.
    DECLARE @recruitmentDeleteError int=0;
    BEGIN TRY
        DELETE FROM dbo.users WHERE id=@user;
    END TRY
    BEGIN CATCH
        SET @recruitmentDeleteError=ERROR_NUMBER();
    END CATCH;
    IF @recruitmentDeleteError<>547 THROW 51209, 'Recruitment must prevent deleting its referenced account.', 1;
    DELETE FROM dbo.teacher_assessments WHERE id=@assessment;
    DELETE FROM dbo.teacher_applications WHERE id=@application;
    DELETE FROM dbo.users WHERE id=@user;
    IF EXISTS(SELECT 1 FROM dbo.sessions WHERE token=@token)
        THROW 51205, 'Session cascade failed.', 1;
    IF NOT EXISTS(SELECT 1 FROM dbo.placement_results WHERE id=@result AND userId IS NULL)
        THROW 51206, 'Placement result preservation failed.', 1;
    IF NOT EXISTS(SELECT 1 FROM dbo.audit_logs WHERE id=@audit AND actorId IS NULL)
        THROW 51207, 'Audit preservation failed.', 1;
    PRINT N'PASS: Xóa user thu hồi session, giữ kết quả thi và nhật ký';

    DELETE FROM dbo.enrollments WHERE id=@enrollment;
    DELETE FROM dbo.materials WHERE id=@material;
    DELETE FROM dbo.classes WHERE id=@class;
    DELETE FROM dbo.courses WHERE id=@course;
    IF NOT EXISTS(SELECT 1 FROM dbo.contacts WHERE id=@contact AND courseId IS NULL)
        THROW 51208, 'Contact preservation failed.', 1;
    PRINT N'PASS: Xóa khóa học giữ yêu cầu tư vấn, đặt courseId=NULL';

    ROLLBACK;
    PRINT N'PASS: 15 quan hệ, 0 mồ côi, 15 lần chặn ID sai, 6 lần chặn xóa và 4 hành vi CASCADE/SET NULL. Đã rollback.';
END TRY
BEGIN CATCH
    IF XACT_STATE()<>0 ROLLBACK;
    THROW;
END CATCH;
GO
