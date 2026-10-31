/* Dữ liệu minh họa từ seed của dự án, không lấy tài khoản/database thật.
   Chỉ dành cho học tập: admin@vinhenglish.vn / Admin@123456
   Học viên mẫu: hocvien@example.com / Student@123456
   passwordHash lưu scrypt (salt:hash), không lưu mật khẩu rõ trong bảng.
   Những tài khoản này KHÔNG phải tài khoản của website online.
*/
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
IF EXISTS (SELECT 1 FROM dbo.metadata WHERE [key]=N'sqlserver-sample-v1')
BEGIN
    PRINT N'Dữ liệu mẫu đã có. Bỏ qua, giữ nguyên chỉnh sửa.';
    RETURN;
END;
IF EXISTS (SELECT 1 FROM dbo.users) OR EXISTS (SELECT 1 FROM dbo.courses)
   OR EXISTS (SELECT 1 FROM dbo.teachers) OR EXISTS (SELECT 1 FROM dbo.classes)
   OR EXISTS (SELECT 1 FROM dbo.questions) OR EXISTS (SELECT 1 FROM dbo.news)
    THROW 51001, N'Chỉ nhập mẫu vào database mới trống; không ghi đè dữ liệu hiện có.', 1;
BEGIN TRY
    BEGIN TRANSACTION;

    -- users: 2 bản ghi
    SET IDENTITY_INSERT dbo.[users] ON;
    INSERT INTO dbo.[users] ([id],[name],[email],[phone],[birthday],[passwordHash],[role])
    VALUES (1,N'Quản trị viên',N'admin@vinhenglish.vn',N'',NULL,N'39e93e437f44a3b4af51cdcf693d656a:ac8f27de8f81f81f72b9103072ac6662ab14a2049e9fca999f09078ce249d1ceecd3b361c3905e28dac309047ba8f82e62c5f966ce13142d13af149a0d0b1dfe',N'admin');
    INSERT INTO dbo.[users] ([id],[name],[email],[phone],[birthday],[passwordHash],[role])
    VALUES (2,N'Nguyễn Hoàng An',N'hocvien@example.com',N'0901234567',NULL,N'a4bc6096d06a151a265f256427e4ecd1:ec3680e982f5a7a44b0352af17be1a70f0f52bd6f27796fb2fcf0f815012becf89fa2938dfc623dff98576d339a18391f97ac15bda9986d369fef0d1cbd7965e',N'student');
    SET IDENTITY_INSERT dbo.[users] OFF;

    -- courses: 99 bản ghi
    SET IDENTITY_INSERT dbo.[courses] ON;
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (1,N'IELTS Foundation',N'IELTS',N'A2 – B1',12,3500000,24,N'Từ 16 tuổi',N'/images/ielts.jpg',N'Xây nền tảng vững chắc, chinh phục mục tiêu IELTS đầu tiên. Phát triển đồng đều bốn kỹ năng với lộ trình cá nhân và phản hồi sau mỗi buổi học.',N'Tuần 1: Present simple & present continuous. Viết một đoạn 100 từ giới thiệu bản thân.
Tuần 2: Đọc một bài báo ngắn, ghi lại 10 từ mới và đặt câu.
Tuần 3: Luyện mô tả biểu đồ đường và cách diễn đạt xu hướng.',N'B1',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (2,N'Tiếng Anh giao tiếp',N'Giao tiếp',N'A2 – B1',10,2800000,20,N'Từ 16 tuổi',N'/images/adults.jpg',N'Tự tin mở lời trong những tình huống đời thường. Học qua thảo luận, đóng vai và các dự án thực tế trong một lớp học luôn khuyến khích bạn lên tiếng.',N'Chủ đề 1: Introduce yourself.
Chủ đề 2: Ordering food — thực hành hội thoại với bạn học.
Chủ đề 3: Giving directions — mô tả đường từ nhà đến trường.',N'A2',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (3,N'Tiếng Anh trẻ em',N'Trẻ em',N'Pre-A1 – A1',12,3200000,24,N'6 – 11 tuổi',N'/images/kids.jpg',N'Nuôi dưỡng niềm yêu thích tiếng Anh qua câu chuyện, trò chơi và hoạt động sáng tạo. Giúp con tự tin khám phá thế giới theo cách của riêng mình.',N'Ôn tập từ vựng: colors, animals, family.
Vẽ gia đình và giới thiệu từng thành viên bằng tiếng Anh.',N'A1',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (4,N'Tiếng Anh thiếu niên',N'Thiếu niên',N'A1 – B1',12,3300000,24,N'12 – 15 tuổi',N'/images/teens.jpg',N'Phát triển tư duy, kỹ năng thuyết trình và sự tự tin. Chương trình kết hợp kiến thức học đường với những dự án gần gũi với tuổi teen.',N'Dự án: My green school. Chuẩn bị bài thuyết trình 3 phút về một ý tưởng bảo vệ môi trường.',N'A2',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (5,N'Tiếng Anh căn bản',N'Căn bản',N'A1',8,2200000,16,N'Người mới bắt đầu',N'/images/basics.jpg',N'Bắt đầu lại từ những điều đơn giản nhất. Nắm chắc phát âm, từ vựng và ngữ pháp thiết yếu với tốc độ học vừa sức và sự hỗ trợ sát sao.',N'Học bảng phiên âm cơ bản.
Ôn động từ to be; viết 10 câu với I am, You are, She is.',N'A1',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (6,N'English for Work',N'Đi làm',N'B1 – B2',10,3800000,20,N'Sinh viên & người đi làm',N'/images/work.jpg',N'Để tiếng Anh trở thành lợi thế nghề nghiệp. Thực hành viết email, phỏng vấn, thuyết trình và làm việc cùng đồng nghiệp quốc tế.',N'Viết email ứng tuyển 150 từ.
Chuẩn bị câu trả lời: Tell me about yourself.
Thực hành cách lên lịch họp qua email.',N'B2',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (7,N'TOEIC 650+',N'TOEIC',N'A2 – B1',12,3600000,24,N'Sinh viên & người đi làm',N'/images/work.jpg',N'Củng cố ngữ pháp, từ vựng công sở và kỹ năng nghe, đọc theo định dạng TOEIC Listening & Reading. Mục tiêu 650+ được điều chỉnh sau kiểm tra đầu vào, không phải cam kết điểm thi.',N'Tuần 1–4: ngữ pháp nền tảng và từ vựng công sở.
Tuần 5–8: luyện nghe hội thoại, đọc email và thông báo.
Tuần 9–12: luyện đề theo thời gian và phân tích lỗi.',N'B1',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (8,N'Tiếng Trung nhập môn',N'Căn bản',N'HSK 1',12,2600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-zh.svg',N'Làm quen âm, chữ viết và từ vựng tiếng trung. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 你好.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'HSK1',N'zh');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (9,N'Tiếng Trung giao tiếp',N'Giao tiếp',N'HSK 2',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-zh.svg',N'Thực hành tiếng trung trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 你好.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'HSK2',N'zh');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (10,N'Tiếng Hàn nhập môn',N'Căn bản',N'TOPIK 1',12,2800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ko.svg',N'Làm quen âm, chữ viết và từ vựng tiếng hàn. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 안녕하세요.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'TOPIK1',N'ko');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (11,N'Tiếng Hàn giao tiếp',N'Giao tiếp',N'TOPIK 2',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ko.svg',N'Thực hành tiếng hàn trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 안녕하세요.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'TOPIK2',N'ko');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (12,N'Tiếng Nhật nhập môn',N'Căn bản',N'N5',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ja.svg',N'Làm quen âm, chữ viết và từ vựng tiếng nhật. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào こんにちは.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'N5',N'ja');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (13,N'Tiếng Nhật giao tiếp',N'Giao tiếp',N'N4',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ja.svg',N'Thực hành tiếng nhật trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào こんにちは.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'N4',N'ja');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (14,N'Tiếng Pháp nhập môn',N'Căn bản',N'A1',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-fr.svg',N'Làm quen âm, chữ viết và từ vựng tiếng pháp. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Bonjour.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'fr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (15,N'Tiếng Pháp giao tiếp',N'Giao tiếp',N'A2',12,3600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-fr.svg',N'Thực hành tiếng pháp trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Bonjour.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'fr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (16,N'Tiếng Đức nhập môn',N'Căn bản',N'A1',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-de.svg',N'Làm quen âm, chữ viết và từ vựng tiếng đức. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hallo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'de');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (17,N'Tiếng Đức giao tiếp',N'Giao tiếp',N'A2',12,3800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-de.svg',N'Thực hành tiếng đức trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hallo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'de');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (18,N'Tiếng Ý nhập môn',N'Căn bản',N'A1',12,2600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-it.svg',N'Làm quen âm, chữ viết và từ vựng tiếng ý. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Ciao.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'it');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (19,N'Tiếng Ý giao tiếp',N'Giao tiếp',N'A2',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-it.svg',N'Thực hành tiếng ý trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Ciao.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'it');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (20,N'Tiếng Tây Ban Nha nhập môn',N'Căn bản',N'A1',12,2800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-es.svg',N'Làm quen âm, chữ viết và từ vựng tiếng tây ban nha. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hola.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'es');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (21,N'Tiếng Tây Ban Nha giao tiếp',N'Giao tiếp',N'A2',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-es.svg',N'Thực hành tiếng tây ban nha trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hola.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'es');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (22,N'Tiếng Bồ Đào Nha nhập môn',N'Căn bản',N'A1',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-pt.svg',N'Làm quen âm, chữ viết và từ vựng tiếng bồ đào nha. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Olá.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'pt');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (23,N'Tiếng Bồ Đào Nha giao tiếp',N'Giao tiếp',N'A2',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-pt.svg',N'Thực hành tiếng bồ đào nha trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Olá.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'pt');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (24,N'Tiếng Nga nhập môn',N'Căn bản',N'A1',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ru.svg',N'Làm quen âm, chữ viết và từ vựng tiếng nga. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Здравствуйте.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'ru');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (25,N'Tiếng Nga giao tiếp',N'Giao tiếp',N'A2',12,3600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ru.svg',N'Thực hành tiếng nga trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Здравствуйте.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'ru');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (26,N'Tiếng Ả Rập nhập môn',N'Căn bản',N'A1',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ar.svg',N'Làm quen âm, chữ viết và từ vựng tiếng ả rập. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào مرحبا.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'ar');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (27,N'Tiếng Ả Rập giao tiếp',N'Giao tiếp',N'A2',12,3800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ar.svg',N'Thực hành tiếng ả rập trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào مرحبا.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'ar');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (28,N'Tiếng Hindi nhập môn',N'Căn bản',N'A1',12,2600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-hi.svg',N'Làm quen âm, chữ viết và từ vựng tiếng hindi. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào नमस्ते.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'hi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (29,N'Tiếng Hindi giao tiếp',N'Giao tiếp',N'A2',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-hi.svg',N'Thực hành tiếng hindi trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào नमस्ते.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'hi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (30,N'Tiếng Thái nhập môn',N'Căn bản',N'A1',12,2800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-th.svg',N'Làm quen âm, chữ viết và từ vựng tiếng thái. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào สวัสดี.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'th');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (31,N'Tiếng Thái giao tiếp',N'Giao tiếp',N'A2',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-th.svg',N'Thực hành tiếng thái trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào สวัสดี.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'th');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (32,N'Tiếng Indonesia nhập môn',N'Căn bản',N'A1',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-id.svg',N'Làm quen âm, chữ viết và từ vựng tiếng indonesia. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Halo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'id');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (33,N'Tiếng Indonesia giao tiếp',N'Giao tiếp',N'A2',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-id.svg',N'Thực hành tiếng indonesia trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Halo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'id');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (34,N'Tiếng Việt nhập môn',N'Căn bản',N'A1',12,3200000,24,N'Người nước ngoài học tiếng Việt',N'/images/language-vi.svg',N'Làm quen âm, chữ viết và từ vựng tiếng việt. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Xin chào.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'vi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (35,N'Tiếng Việt giao tiếp',N'Giao tiếp',N'A2',12,3600000,24,N'Người nước ngoài học tiếng Việt',N'/images/language-vi.svg',N'Thực hành tiếng việt trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Xin chào.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'vi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (36,N'Tiếng Thổ Nhĩ Kỳ nhập môn',N'Căn bản',N'A1',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-tr.svg',N'Làm quen âm, chữ viết và từ vựng tiếng thổ nhĩ kỳ. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Merhaba.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A1',N'tr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (37,N'Tiếng Thổ Nhĩ Kỳ giao tiếp',N'Giao tiếp',N'A2',12,3800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-tr.svg',N'Thực hành tiếng thổ nhĩ kỳ trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Merhaba.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'A2',N'tr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (38,N'Tiếng Anh C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-en.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng anh hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (39,N'Tiếng Anh C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-en.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng anh hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (40,N'Tiếng Trung HSK 3',N'Theo cấp độ',N'HSK 3',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-zh.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng trung hướng tới HSK 3; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình HSK 3.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'HSK3',N'zh');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (41,N'Tiếng Trung HSK 4',N'Theo cấp độ',N'HSK 4',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-zh.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng trung hướng tới HSK 4; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình HSK 4.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'HSK4',N'zh');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (42,N'Tiếng Trung HSK 5',N'Theo cấp độ',N'HSK 5',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-zh.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng trung hướng tới HSK 5; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình HSK 5.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'HSK5',N'zh');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (43,N'Tiếng Trung HSK 6',N'Theo cấp độ',N'HSK 6',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-zh.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng trung hướng tới HSK 6; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình HSK 6.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'HSK6',N'zh');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (44,N'Tiếng Trung HSK 7-9',N'Theo cấp độ',N'HSK 7-9',12,4200000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-zh.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng trung hướng tới HSK 7-9; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình HSK 7-9.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'HSK7-9',N'zh');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (45,N'Tiếng Hàn TOPIK 3',N'Theo cấp độ',N'TOPIK 3',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ko.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng hàn hướng tới TOPIK 3; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình TOPIK 3.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'TOPIK3',N'ko');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (46,N'Tiếng Hàn TOPIK 4',N'Theo cấp độ',N'TOPIK 4',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ko.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng hàn hướng tới TOPIK 4; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình TOPIK 4.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'TOPIK4',N'ko');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (47,N'Tiếng Hàn TOPIK 5',N'Theo cấp độ',N'TOPIK 5',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ko.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng hàn hướng tới TOPIK 5; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình TOPIK 5.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'TOPIK5',N'ko');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (48,N'Tiếng Hàn TOPIK 6',N'Theo cấp độ',N'TOPIK 6',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ko.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng hàn hướng tới TOPIK 6; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình TOPIK 6.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'TOPIK6',N'ko');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (49,N'Tiếng Nhật N3',N'Theo cấp độ',N'N3',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ja.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng nhật hướng tới N3; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình N3.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'N3',N'ja');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (50,N'Tiếng Nhật N2',N'Theo cấp độ',N'N2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ja.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng nhật hướng tới N2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình N2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'N2',N'ja');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (51,N'Tiếng Nhật N1',N'Theo cấp độ',N'N1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ja.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng nhật hướng tới N1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình N1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'N1',N'ja');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (52,N'Tiếng Pháp B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-fr.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng pháp hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'fr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (53,N'Tiếng Pháp B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-fr.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng pháp hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'fr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (54,N'Tiếng Pháp C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-fr.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng pháp hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'fr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (55,N'Tiếng Pháp C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-fr.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng pháp hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'fr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (56,N'Tiếng Đức B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-de.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng đức hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'de');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (57,N'Tiếng Đức B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-de.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng đức hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'de');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (58,N'Tiếng Đức C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-de.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng đức hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'de');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (59,N'Tiếng Đức C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-de.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng đức hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'de');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (60,N'Tiếng Ý B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-it.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng ý hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'it');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (61,N'Tiếng Ý B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-it.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng ý hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'it');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (62,N'Tiếng Ý C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-it.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng ý hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'it');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (63,N'Tiếng Ý C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-it.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng ý hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'it');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (64,N'Tiếng Tây Ban Nha B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-es.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng tây ban nha hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'es');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (65,N'Tiếng Tây Ban Nha B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-es.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng tây ban nha hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'es');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (66,N'Tiếng Tây Ban Nha C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-es.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng tây ban nha hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'es');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (67,N'Tiếng Tây Ban Nha C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-es.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng tây ban nha hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'es');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (68,N'Tiếng Bồ Đào Nha B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-pt.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng bồ đào nha hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'pt');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (69,N'Tiếng Bồ Đào Nha B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-pt.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng bồ đào nha hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'pt');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (70,N'Tiếng Bồ Đào Nha C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-pt.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng bồ đào nha hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'pt');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (71,N'Tiếng Bồ Đào Nha C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-pt.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng bồ đào nha hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'pt');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (72,N'Tiếng Nga B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ru.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng nga hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'ru');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (73,N'Tiếng Nga B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ru.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng nga hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'ru');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (74,N'Tiếng Nga C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ru.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng nga hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'ru');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (75,N'Tiếng Nga C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ru.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng nga hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'ru');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (76,N'Tiếng Ả Rập B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ar.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng ả rập hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'ar');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (77,N'Tiếng Ả Rập B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ar.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng ả rập hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'ar');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (78,N'Tiếng Ả Rập C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ar.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng ả rập hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'ar');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (79,N'Tiếng Ả Rập C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ar.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng ả rập hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'ar');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (80,N'Tiếng Hindi B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-hi.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng hindi hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'hi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (81,N'Tiếng Hindi B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-hi.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng hindi hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'hi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (82,N'Tiếng Hindi C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-hi.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng hindi hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'hi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (83,N'Tiếng Hindi C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-hi.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng hindi hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'hi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (84,N'Tiếng Thái B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-th.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng thái hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'th');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (85,N'Tiếng Thái B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-th.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng thái hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'th');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (86,N'Tiếng Thái C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-th.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng thái hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'th');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (87,N'Tiếng Thái C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-th.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng thái hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'th');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (88,N'Tiếng Indonesia B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-id.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng indonesia hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'id');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (89,N'Tiếng Indonesia B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-id.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng indonesia hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'id');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (90,N'Tiếng Indonesia C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-id.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng indonesia hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'id');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (91,N'Tiếng Indonesia C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-id.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng indonesia hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'id');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (92,N'Tiếng Việt B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-vi.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng việt hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'vi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (93,N'Tiếng Việt B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-vi.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng việt hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'vi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (94,N'Tiếng Việt C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-vi.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng việt hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'vi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (95,N'Tiếng Việt C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-vi.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng việt hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'vi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (96,N'Tiếng Thổ Nhĩ Kỳ B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-tr.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng thổ nhĩ kỳ hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'tr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (97,N'Tiếng Thổ Nhĩ Kỳ B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-tr.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng thổ nhĩ kỳ hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'tr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (98,N'Tiếng Thổ Nhĩ Kỳ C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-tr.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng thổ nhĩ kỳ hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'tr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language])
    VALUES (99,N'Tiếng Thổ Nhĩ Kỳ C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-tr.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng thổ nhĩ kỳ hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'tr');
    SET IDENTITY_INSERT dbo.[courses] OFF;

    -- teachers: 24 bản ghi
    SET IDENTITY_INSERT dbo.[teachers] ON;
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (1,N'Nguyễn Minh Anh',N'Thạc sĩ TESOL · IELTS 8.5',8,N'IELTS · Tiếng Anh học thuật',N'/images/teacher1.jpg',N'Cô Minh Anh tin rằng mỗi học viên đều có một cách học riêng. Các buổi học của cô kết hợp tư duy phản biện với những hoạt động thực hành gần gũi.',N'IELTS Academic 8.5
Biên soạn lộ trình IELTS Foundation gồm 24 buổi
Phụ trách chuyên đề phản hồi bài viết và luyện Speaking tại trung tâm',N'["en"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (2,N'David Wilson',N'CELTA · University of Leeds',10,N'Giao tiếp · English for Work',N'/images/teacher2.jpg',N'Thầy David tạo ra một không gian học cởi mở, nơi mọi câu hỏi đều được chào đón. Thầy chú trọng phát âm và khả năng sử dụng tiếng Anh thực tế.',N'Chứng chỉ giảng dạy tiếng Anh CELTA
Thiết kế bộ tình huống giao tiếp dành cho người đi làm
Điều phối câu lạc bộ English Speaking Club',N'["en"]',N'Vương quốc Anh');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (3,N'Trần Thảo Linh',N'Cử nhân Sư phạm Anh · TESOL',6,N'Trẻ em · Tiếng Anh thiếu niên',N'/images/teacher3.jpg',N'Cô Linh mang những câu chuyện, trò chơi và dự án sáng tạo vào lớp học, giúp các bạn nhỏ học tiếng Anh với sự tò mò và niềm vui.',N'Chứng chỉ TESOL
Xây dựng bộ hoạt động học qua truyện và trò chơi cho trẻ 6–11 tuổi
Hướng dẫn dự án thuyết trình My Green School cho học viên thiếu niên',N'["en"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (4,N'Lê Hoàng Nam',N'Cử nhân Ngôn ngữ Anh · IELTS 8.0',7,N'IELTS · Reading & Writing',N'/images/teacher4.svg',N'Thầy Nam giúp học viên xây nền tảng đọc hiểu, lập dàn ý và viết bài có dẫn chứng. Mỗi buổi học có bài luyện tập ngắn và phản hồi cụ thể để học viên tự theo dõi tiến bộ.',N'IELTS Academic 8.0
Biên soạn bộ chuyên đề IELTS Writing Task 1 và Task 2
Phụ trách workshop lập kế hoạch tự học IELTS cho sinh viên',N'["en"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (5,N'Phạm Thu Hà',N'Cử nhân Ngôn ngữ Anh · CELTA',6,N'Giao tiếp · Phát âm',N'/images/teacher5.svg',N'Cô Hà chú trọng phát âm dễ hiểu và phản xạ trong tình huống đời sống. Học viên được luyện nói theo cặp, ghi âm và nhận góp ý trong không khí thân thiện.',N'Chứng chỉ giảng dạy CELTA
Xây dựng bộ học liệu phát âm và nối âm cho người Việt
Tổ chức chuỗi hoạt động giao tiếp English in Daily Life',N'["en"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (6,N'Nguyễn Mai Chi',N'Cử nhân Sư phạm Anh · TESOL',5,N'Tiếng Anh trẻ em · Học qua hoạt động',N'/images/teacher6.svg',N'Cô Chi kết hợp vận động, bài hát và kể chuyện để trẻ làm quen tiếng Anh tự nhiên. Cô ưu tiên sự tự tin và tạo cơ hội để mỗi bạn nhỏ đều được tham gia.',N'Chứng chỉ TESOL
Thiết kế bộ trò chơi từ vựng cho chương trình Kids English
Hướng dẫn hoạt động kể chuyện tiếng Anh Storytelling Day',N'["en"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (7,N'Trần Gia Bảo',N'Cử nhân Sư phạm Anh · IELTS 8.0',5,N'Tiếng Anh thiếu niên · Thuyết trình',N'/images/teacher7.svg',N'Thầy Bảo đồng hành cùng học sinh ở phần ngữ pháp học đường và kỹ năng trình bày ý tưởng. Các dự án nhóm giúp học viên ứng dụng tiếng Anh vào chủ đề gần gũi.',N'IELTS Academic 8.0
Xây dựng chuyên đề thuyết trình bằng tiếng Anh cho học sinh 12–15 tuổi
Hướng dẫn câu lạc bộ tranh biện tiếng Anh tại trung tâm',N'["en"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (8,N'Đặng Ngọc Lan',N'Cử nhân Ngôn ngữ Anh · TESOL',4,N'Tiếng Anh căn bản · Người mới bắt đầu',N'/images/teacher8.svg',N'Cô Lan chia nhỏ kiến thức và hướng dẫn từng bước cho người bắt đầu lại. Bài học kết hợp phát âm, mẫu câu ngắn và ôn tập có hệ thống để học viên dễ duy trì thói quen.',N'Chứng chỉ TESOL
Biên soạn chương trình tiếng Anh căn bản 16 buổi
Phát triển bộ bài tập ôn phát âm và ngữ pháp nền tảng',N'["en"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (9,N'Võ Quốc Huy',N'Cử nhân Tiếng Anh thương mại · TOEIC 980',9,N'English for Work · Tiếng Anh công sở',N'/images/teacher9.svg',N'Thầy Huy hướng dẫn sử dụng tiếng Anh trong email, cuộc họp và phỏng vấn. Lớp học tập trung vào các tình huống công việc và cách diễn đạt rõ ràng, lịch sự.',N'TOEIC Listening & Reading 980/990
Thiết kế bộ tình huống viết email và họp bằng tiếng Anh
Phụ trách chuyên đề phỏng vấn tiếng Anh cho sinh viên mới tốt nghiệp',N'["en"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (10,N'Lưu Minh Châu',N'Cử nhân Ngôn ngữ Trung',5,N'Pinyin, thanh điệu và hội thoại tiếng Trung',N'/images/teacher4.svg',N'Giáo viên tiếng trung đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng trung nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["zh"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (11,N'Nguyễn Hà Yến',N'Cử nhân Ngôn ngữ Hàn',6,N'Hangul, phát âm và giao tiếp tiếng Hàn',N'/images/teacher5.svg',N'Giáo viên tiếng hàn đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng hàn nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["ko"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (12,N'Phạm Nhật Minh',N'Cử nhân Ngôn ngữ Nhật',7,N'Hiragana, Katakana và giao tiếp tiếng Nhật',N'/images/teacher6.svg',N'Giáo viên tiếng nhật đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng nhật nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["ja"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (13,N'Lê Thanh Trúc',N'Thạc sĩ Giảng dạy tiếng Pháp',8,N'Phát âm và giao tiếp tiếng Pháp',N'/images/teacher7.svg',N'Giáo viên tiếng pháp đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng pháp nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["fr"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (14,N'Trần Đức Khang',N'Cử nhân Ngôn ngữ Đức',9,N'Ngữ pháp nền tảng và giao tiếp tiếng Đức',N'/images/teacher8.svg',N'Giáo viên tiếng đức đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng đức nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["de"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (15,N'Nguyễn Ý Nhi',N'Cử nhân Ngôn ngữ Ý',5,N'Phát âm và văn hóa giao tiếp tiếng Ý',N'/images/teacher9.svg',N'Giáo viên tiếng ý đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng ý nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["it"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (16,N'Vũ Hoàng Mai',N'Cử nhân Ngôn ngữ Tây Ban Nha',6,N'Giao tiếp tiếng Tây Ban Nha',N'/images/teacher4.svg',N'Giáo viên tiếng tây ban nha đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng tây ban nha nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["es"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (17,N'Đỗ Minh Tâm',N'Cử nhân Ngôn ngữ Bồ Đào Nha',7,N'Tiếng Bồ Đào Nha trong đời sống',N'/images/teacher5.svg',N'Giáo viên tiếng bồ đào nha đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng bồ đào nha nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["pt"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (18,N'Bùi Ngọc Ánh',N'Cử nhân Ngôn ngữ Nga',8,N'Bảng chữ cái Cyrillic và hội thoại tiếng Nga',N'/images/teacher6.svg',N'Giáo viên tiếng nga đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng nga nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["ru"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (19,N'Hoàng Minh Quân',N'Cử nhân Ngôn ngữ Ả Rập',9,N'Chữ viết và tiếng Ả Rập tiêu chuẩn hiện đại',N'/images/teacher7.svg',N'Giáo viên tiếng ả rập đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng ả rập nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["ar"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (20,N'Nguyễn An Bình',N'Cử nhân Ngôn ngữ Hindi',5,N'Devanagari và giao tiếp tiếng Hindi',N'/images/teacher8.svg',N'Giáo viên tiếng hindi đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng hindi nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["hi"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (21,N'Trịnh Thảo Vy',N'Cử nhân Ngôn ngữ Thái',6,N'Thanh điệu và giao tiếp tiếng Thái',N'/images/teacher9.svg',N'Giáo viên tiếng thái đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng thái nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["th"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (22,N'Phan Gia Hân',N'Cử nhân Ngôn ngữ Indonesia',7,N'Bahasa Indonesia cho du lịch và công việc',N'/images/teacher4.svg',N'Giáo viên tiếng indonesia đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng indonesia nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["id"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (23,N'Đặng Khánh Hòa',N'Thạc sĩ Việt Nam học',8,N'Tiếng Việt cho người nước ngoài',N'/images/teacher5.svg',N'Giáo viên tiếng việt đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng việt nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["vi"]',N'Việt Nam');
    INSERT INTO dbo.[teachers] ([id],[name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality])
    VALUES (24,N'Trần Tuấn Kiệt',N'Cử nhân Ngôn ngữ Thổ Nhĩ Kỳ',9,N'Giao tiếp tiếng Thổ Nhĩ Kỳ',N'/images/teacher6.svg',N'Giáo viên tiếng thổ nhĩ kỳ đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng thổ nhĩ kỳ nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["tr"]',N'Việt Nam');
    SET IDENTITY_INSERT dbo.[teachers] OFF;

    -- classes: 302 bản ghi
    SET IDENTITY_INSERT dbo.[classes] ON;
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (1,1,1,N'IELTS-F01',N'2026-11-14',N'2027-02-18',N'Thứ 2, Thứ 4 · 18:30 – 20:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:30',N'20:30',N'',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (2,2,2,N'GT-02',N'2026-11-17',N'2027-02-21',N'Thứ 3, Thứ 5 · 19:00 – 21:00',N'Cơ sở Nguyễn Văn Cừ',18,N'[2,4]',N'19:00',N'21:00',N'',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (3,3,3,N'KIDS-03',N'2026-11-20',N'2027-02-24',N'Thứ 2, Thứ 4 · 18:30 – 20:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:30',N'20:30',N'',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (4,4,3,N'TEEN-04',N'2026-11-23',N'2027-02-27',N'Thứ 3, Thứ 5 · 19:00 – 21:00',N'Cơ sở Nguyễn Văn Cừ',18,N'[2,4]',N'19:00',N'21:00',N'',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (5,5,1,N'CB-05',N'2026-11-26',N'2027-03-02',N'Thứ 2, Thứ 4 · 16:00 – 18:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'16:00',N'18:00',N'',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (6,6,2,N'WORK-06',N'2026-11-29',N'2027-03-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Nguyễn Văn Cừ',18,N'[6,7]',N'08:00',N'10:00',N'',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (7,7,9,N'TOEIC-TOI-01',N'2026-11-17',N'2027-02-04',N'Thứ 3, Thứ 5 · 18:30 – 20:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:30',N'TOEIC-01',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (8,7,9,N'TOEIC-SANG-02',N'2026-11-14',N'2027-01-31',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Nguyễn Văn Cừ',18,N'[6,7]',N'08:00',N'10:00',N'TOEIC-01',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (9,1,1,N'IELTS-OPT-TOI',N'2026-11-17',N'2027-02-04',N'Thứ 3, Thứ 5 · 18:00 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:00',N'20:00',N'201',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (10,1,1,N'IELTS-OPT-SANG-CN',N'2026-11-14',N'2027-01-31',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'201',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (11,1,1,N'IELTS-OPT-CHIEU-CN',N'2026-11-14',N'2027-01-31',N'Thứ 7, Chủ nhật · 14:00 – 16:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'14:00',N'16:00',N'201',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (12,2,2,N'GT-OPT-SANG',N'2026-11-16',N'2027-01-20',N'Thứ 2, Thứ 4 · 08:00 – 10:00',N'Cơ sở Nguyễn Văn Cừ',18,N'[1,3]',N'08:00',N'10:00',N'101',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (13,2,2,N'GT-OPT-TOI',N'2026-11-16',N'2027-01-20',N'Thứ 2, Thứ 4 · 18:30 – 20:30',N'Cơ sở Nguyễn Văn Cừ',18,N'[1,3]',N'18:30',N'20:30',N'101',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (14,2,2,N'GT-OPT-CHIEU-CN',N'2026-11-14',N'2027-01-17',N'Thứ 7, Chủ nhật · 14:00 – 16:00',N'Cơ sở Nguyễn Văn Cừ',18,N'[6,7]',N'14:00',N'16:00',N'101',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (15,3,3,N'KIDS-OPT-SAU-GIO-HOC',N'2026-11-17',N'2027-02-04',N'Thứ 3, Thứ 5 · 17:00 – 18:30',N'Cơ sở Lê Lợi',15,N'[2,4]',N'17:00',N'18:30',N'101',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (16,3,3,N'KIDS-OPT-SANG-CN',N'2026-11-14',N'2027-01-31',N'Thứ 7, Chủ nhật · 08:00 – 09:30',N'Cơ sở Lê Lợi',15,N'[6,7]',N'08:00',N'09:30',N'101',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (17,3,3,N'KIDS-OPT-CHIEU-CN',N'2026-11-14',N'2027-01-31',N'Thứ 7, Chủ nhật · 15:00 – 16:30',N'Cơ sở Lê Lợi',15,N'[6,7]',N'15:00',N'16:30',N'101',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (18,4,3,N'TEEN-OPT-SAU-GIO-HOC',N'2026-11-16',N'2027-02-03',N'Thứ 2, Thứ 4 · 16:30 – 18:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'16:30',N'18:00',N'102',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (19,4,3,N'TEEN-OPT-TOI',N'2026-11-15',N'2027-02-05',N'Thứ 6, Chủ nhật · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[5,7]',N'18:30',N'20:00',N'102',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (20,4,3,N'TEEN-OPT-SANG-CN',N'2026-11-14',N'2027-01-31',N'Thứ 7, Chủ nhật · 09:45 – 11:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'09:45',N'11:15',N'102',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (21,5,1,N'CB-OPT-SANG',N'2026-11-17',N'2027-01-07',N'Thứ 3, Thứ 5 · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'10:00',N'202',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (22,5,1,N'CB-OPT-CHIEU',N'2026-11-17',N'2027-01-07',N'Thứ 3, Thứ 5 · 14:00 – 16:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'14:00',N'16:00',N'202',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (23,5,1,N'CB-OPT-SANG-CN',N'2026-11-14',N'2027-01-03',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'202',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (24,6,2,N'WORK-OPT-TRUA',N'2026-11-16',N'2027-01-20',N'Thứ 2, Thứ 4 · 12:00 – 13:30',N'Cơ sở Nguyễn Văn Cừ',18,N'[1,3]',N'12:00',N'13:30',N'102',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (25,6,2,N'WORK-OPT-TOI',N'2026-11-15',N'2027-01-22',N'Thứ 6, Chủ nhật · 19:00 – 21:00',N'Cơ sở Nguyễn Văn Cừ',18,N'[5,7]',N'19:00',N'21:00',N'102',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (26,6,2,N'WORK-OPT-SANG-CN',N'2026-11-14',N'2027-01-17',N'Thứ 7, Chủ nhật · 10:30 – 12:30',N'Cơ sở Nguyễn Văn Cừ',18,N'[6,7]',N'10:30',N'12:30',N'102',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (27,8,10,N'ZH-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (28,8,10,N'ZH-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (29,8,10,N'ZH-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (30,9,10,N'ZH-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (31,9,10,N'ZH-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (32,9,10,N'ZH-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (33,10,11,N'KO-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (34,10,11,N'KO-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (35,10,11,N'KO-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (36,11,11,N'KO-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (37,11,11,N'KO-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (38,11,11,N'KO-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (39,12,12,N'JA-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (40,12,12,N'JA-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (41,12,12,N'JA-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (42,13,12,N'JA-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (43,13,12,N'JA-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (44,13,12,N'JA-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (45,14,13,N'FR-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (46,14,13,N'FR-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (47,14,13,N'FR-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (48,15,13,N'FR-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (49,15,13,N'FR-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (50,15,13,N'FR-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (51,16,14,N'DE-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (52,16,14,N'DE-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (53,16,14,N'DE-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (54,17,14,N'DE-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (55,17,14,N'DE-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (56,17,14,N'DE-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (57,18,15,N'IT-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (58,18,15,N'IT-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (59,18,15,N'IT-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (60,19,15,N'IT-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (61,19,15,N'IT-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (62,19,15,N'IT-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (63,20,16,N'ES-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (64,20,16,N'ES-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (65,20,16,N'ES-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (66,21,16,N'ES-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (67,21,16,N'ES-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (68,21,16,N'ES-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (69,22,17,N'PT-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (70,22,17,N'PT-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (71,22,17,N'PT-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (72,23,17,N'PT-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (73,23,17,N'PT-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (74,23,17,N'PT-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (75,24,18,N'RU-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (76,24,18,N'RU-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (77,24,18,N'RU-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (78,25,18,N'RU-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (79,25,18,N'RU-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (80,25,18,N'RU-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (81,26,19,N'AR-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (82,26,19,N'AR-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (83,26,19,N'AR-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (84,27,19,N'AR-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (85,27,19,N'AR-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (86,27,19,N'AR-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (87,28,20,N'HI-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (88,28,20,N'HI-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (89,28,20,N'HI-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (90,29,20,N'HI-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (91,29,20,N'HI-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (92,29,20,N'HI-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (93,30,21,N'TH-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (94,30,21,N'TH-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (95,30,21,N'TH-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (96,31,21,N'TH-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (97,31,21,N'TH-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (98,31,21,N'TH-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (99,32,22,N'ID-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (100,32,22,N'ID-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (101,32,22,N'ID-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (102,33,22,N'ID-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (103,33,22,N'ID-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (104,33,22,N'ID-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (105,34,23,N'VI-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (106,34,23,N'VI-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (107,34,23,N'VI-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (108,35,23,N'VI-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (109,35,23,N'VI-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (110,35,23,N'VI-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (111,36,24,N'TR-CB-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN15',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (112,36,24,N'TR-CB-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN15',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (113,36,24,N'TR-CB-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN15',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (114,37,24,N'TR-GT-SANG',N'2026-11-14',N'2027-02-06',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN15',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (115,37,24,N'TR-GT-TOI',N'2026-11-14',N'2027-02-06',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN15',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (116,37,24,N'TR-GT-CUOITUAN',N'2026-11-14',N'2027-02-06',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN15',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (117,38,1,N'EN-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'LV-en-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (118,38,1,N'EN-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-en-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (119,38,1,N'EN-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-en-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (120,39,1,N'EN-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'LV-en-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (121,39,1,N'EN-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-en-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (122,39,1,N'EN-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-en-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (123,40,10,N'ZH-HSK3-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-zh-HSK3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (124,40,10,N'ZH-HSK3-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-zh-HSK3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (125,40,10,N'ZH-HSK3-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-zh-HSK3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (126,41,10,N'ZH-HSK4-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-zh-HSK4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (127,41,10,N'ZH-HSK4-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-zh-HSK4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (128,41,10,N'ZH-HSK4-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-zh-HSK4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (129,42,10,N'ZH-HSK5-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-zh-HSK5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (130,42,10,N'ZH-HSK5-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-zh-HSK5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (131,42,10,N'ZH-HSK5-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-zh-HSK5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (132,43,10,N'ZH-HSK6-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-zh-HSK6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (133,43,10,N'ZH-HSK6-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-zh-HSK6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (134,43,10,N'ZH-HSK6-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-zh-HSK6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (135,44,10,N'ZH-HSK7-9-1',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'13:30',N'15:00',N'LV-zh-HSK7-9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (136,44,10,N'ZH-HSK7-9-2',N'2026-11-21',N'2027-02-13',N'Chủ nhật · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[7]',N'18:00',N'19:30',N'LV-zh-HSK7-9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (137,44,10,N'ZH-HSK7-9-3',N'2026-11-21',N'2027-02-13',N'Chủ nhật · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[7]',N'13:30',N'15:00',N'LV-zh-HSK7-9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (138,45,11,N'KO-TOPIK3-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-ko-TOPIK3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (139,45,11,N'KO-TOPIK3-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-ko-TOPIK3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (140,45,11,N'KO-TOPIK3-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-ko-TOPIK3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (141,46,11,N'KO-TOPIK4-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-ko-TOPIK4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (142,46,11,N'KO-TOPIK4-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-ko-TOPIK4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (143,46,11,N'KO-TOPIK4-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-ko-TOPIK4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (144,47,11,N'KO-TOPIK5-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-ko-TOPIK5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (145,47,11,N'KO-TOPIK5-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-ko-TOPIK5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (146,47,11,N'KO-TOPIK5-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-ko-TOPIK5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (147,48,11,N'KO-TOPIK6-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-ko-TOPIK6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (148,48,11,N'KO-TOPIK6-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-ko-TOPIK6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (149,48,11,N'KO-TOPIK6-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-ko-TOPIK6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (150,49,12,N'JA-N3-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-ja-N3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (151,49,12,N'JA-N3-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-ja-N3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (152,49,12,N'JA-N3-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-ja-N3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (153,50,12,N'JA-N2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-ja-N2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (154,50,12,N'JA-N2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-ja-N2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (155,50,12,N'JA-N2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-ja-N2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (156,51,12,N'JA-N1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-ja-N1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (157,51,12,N'JA-N1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-ja-N1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (158,51,12,N'JA-N1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-ja-N1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (159,52,13,N'FR-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-fr-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (160,52,13,N'FR-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-fr-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (161,52,13,N'FR-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-fr-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (162,53,13,N'FR-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-fr-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (163,53,13,N'FR-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-fr-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (164,53,13,N'FR-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-fr-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (165,54,13,N'FR-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-fr-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (166,54,13,N'FR-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-fr-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (167,54,13,N'FR-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-fr-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (168,55,13,N'FR-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-fr-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (169,55,13,N'FR-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-fr-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (170,55,13,N'FR-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-fr-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (171,56,14,N'DE-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-de-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (172,56,14,N'DE-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-de-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (173,56,14,N'DE-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-de-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (174,57,14,N'DE-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-de-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (175,57,14,N'DE-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-de-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (176,57,14,N'DE-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-de-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (177,58,14,N'DE-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-de-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (178,58,14,N'DE-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-de-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (179,58,14,N'DE-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-de-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (180,59,14,N'DE-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-de-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (181,59,14,N'DE-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-de-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (182,59,14,N'DE-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-de-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (183,60,15,N'IT-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-it-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (184,60,15,N'IT-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-it-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (185,60,15,N'IT-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-it-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (186,61,15,N'IT-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-it-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (187,61,15,N'IT-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-it-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (188,61,15,N'IT-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-it-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (189,62,15,N'IT-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-it-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (190,62,15,N'IT-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-it-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (191,62,15,N'IT-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-it-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (192,63,15,N'IT-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-it-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (193,63,15,N'IT-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-it-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (194,63,15,N'IT-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-it-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (195,64,16,N'ES-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-es-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (196,64,16,N'ES-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-es-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (197,64,16,N'ES-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-es-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (198,65,16,N'ES-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-es-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (199,65,16,N'ES-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-es-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (200,65,16,N'ES-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-es-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (201,66,16,N'ES-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-es-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (202,66,16,N'ES-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-es-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (203,66,16,N'ES-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-es-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (204,67,16,N'ES-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-es-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (205,67,16,N'ES-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-es-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (206,67,16,N'ES-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-es-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (207,68,17,N'PT-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-pt-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (208,68,17,N'PT-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-pt-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (209,68,17,N'PT-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-pt-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (210,69,17,N'PT-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-pt-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (211,69,17,N'PT-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-pt-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (212,69,17,N'PT-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-pt-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (213,70,17,N'PT-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-pt-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (214,70,17,N'PT-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-pt-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (215,70,17,N'PT-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-pt-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (216,71,17,N'PT-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-pt-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (217,71,17,N'PT-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-pt-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (218,71,17,N'PT-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-pt-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (219,72,18,N'RU-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-ru-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (220,72,18,N'RU-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-ru-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (221,72,18,N'RU-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-ru-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (222,73,18,N'RU-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-ru-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (223,73,18,N'RU-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-ru-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (224,73,18,N'RU-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-ru-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (225,74,18,N'RU-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-ru-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (226,74,18,N'RU-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-ru-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (227,74,18,N'RU-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-ru-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (228,75,18,N'RU-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-ru-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (229,75,18,N'RU-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-ru-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (230,75,18,N'RU-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-ru-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (231,76,19,N'AR-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-ar-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (232,76,19,N'AR-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-ar-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (233,76,19,N'AR-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-ar-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (234,77,19,N'AR-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-ar-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (235,77,19,N'AR-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-ar-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (236,77,19,N'AR-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-ar-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (237,78,19,N'AR-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-ar-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (238,78,19,N'AR-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-ar-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (239,78,19,N'AR-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-ar-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (240,79,19,N'AR-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-ar-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (241,79,19,N'AR-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-ar-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (242,79,19,N'AR-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-ar-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (243,80,20,N'HI-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-hi-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (244,80,20,N'HI-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-hi-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (245,80,20,N'HI-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-hi-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (246,81,20,N'HI-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-hi-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (247,81,20,N'HI-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-hi-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (248,81,20,N'HI-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-hi-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (249,82,20,N'HI-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-hi-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (250,82,20,N'HI-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-hi-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (251,82,20,N'HI-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-hi-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (252,83,20,N'HI-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-hi-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (253,83,20,N'HI-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-hi-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (254,83,20,N'HI-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-hi-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (255,84,21,N'TH-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-th-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (256,84,21,N'TH-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-th-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (257,84,21,N'TH-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-th-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (258,85,21,N'TH-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-th-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (259,85,21,N'TH-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-th-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (260,85,21,N'TH-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-th-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (261,86,21,N'TH-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-th-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (262,86,21,N'TH-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-th-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (263,86,21,N'TH-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-th-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (264,87,21,N'TH-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-th-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (265,87,21,N'TH-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-th-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (266,87,21,N'TH-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-th-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (267,88,22,N'ID-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-id-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (268,88,22,N'ID-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-id-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (269,88,22,N'ID-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-id-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (270,89,22,N'ID-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-id-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (271,89,22,N'ID-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-id-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (272,89,22,N'ID-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-id-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (273,90,22,N'ID-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-id-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (274,90,22,N'ID-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-id-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (275,90,22,N'ID-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-id-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (276,91,22,N'ID-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-id-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (277,91,22,N'ID-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-id-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (278,91,22,N'ID-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-id-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (279,92,23,N'VI-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-vi-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (280,92,23,N'VI-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-vi-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (281,92,23,N'VI-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-vi-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (282,93,23,N'VI-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-vi-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (283,93,23,N'VI-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-vi-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (284,93,23,N'VI-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-vi-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (285,94,23,N'VI-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-vi-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (286,94,23,N'VI-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-vi-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (287,94,23,N'VI-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-vi-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (288,95,23,N'VI-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-vi-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (289,95,23,N'VI-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-vi-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (290,95,23,N'VI-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-vi-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (291,96,24,N'TR-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-tr-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (292,96,24,N'TR-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-tr-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (293,96,24,N'TR-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-tr-B1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (294,97,24,N'TR-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-tr-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (295,97,24,N'TR-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-tr-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (296,97,24,N'TR-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-tr-B2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (297,98,24,N'TR-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-tr-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (298,98,24,N'TR-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-tr-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (299,98,24,N'TR-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-tr-C1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (300,99,24,N'TR-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-tr-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (301,99,24,N'TR-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-tr-C2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (302,99,24,N'TR-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-tr-C2',N'enrolling');
    SET IDENTITY_INSERT dbo.[classes] OFF;

    -- enrollments: 1 bản ghi
    SET IDENTITY_INSERT dbo.[enrollments] ON;
    INSERT INTO dbo.[enrollments] ([id],[userId],[classId],[name],[email],[phone],[birthday],[note],[status],[grades],[createdAt],[verifiedAt],[verifiedBy])
    VALUES (1,2,1,N'Nguyễn Hoàng An',N'hocvien@example.com',N'0901234567',NULL,N'',N'confirmed',N'{"listening":7,"reading":8,"writing":6.5,"speaking":7}',N'2026-10-31 16:07:34',NULL,NULL);
    SET IDENTITY_INSERT dbo.[enrollments] OFF;

    -- questions: 463 bản ghi
    SET IDENTITY_INSERT dbo.[questions] ON;
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (1,N'She _____ to school every day.',N'["go","goes","going","gone"]',1,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (2,N'There _____ a book on the table.',N'["are","be","is","am"]',2,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (3,N'I have lived here _____ 2020.',N'["for","since","at","during"]',1,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (4,N'They _____ football yesterday.',N'["play","plays","played","playing"]',2,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (5,N'This bag is _____ than that one.',N'["heavy","heaviest","more heavy","heavier"]',3,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (6,N'We do not have _____ milk left.',N'["some","any","many","a"]',1,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (7,N'If it rains, we _____ at home.',N'["stayed","would stay","will stay","staying"]',2,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (8,N'The book _____ by a young author last year.',N'["wrote","was written","writes","is writing"]',1,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (9,N'I enjoy _____ new languages.',N'["learn","to learning","learning","learned"]',2,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (10,N'You _____ wear a helmet when riding a motorbike.',N'["must","might","would","could have"]',0,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (11,N'By the time we arrived, the film _____.',N'["starts","has started","had started","starting"]',2,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (12,N'The woman _____ lives next door is a teacher.',N'["which","who","where","whose"]',1,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (13,N'Despite _____ tired, he finished his work.',N'["be","was","being","been"]',2,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (14,N'If I _____ you, I would take the opportunity.',N'["am","was being","were","have been"]',2,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (15,N'The word “reliable” is closest in meaning to _____.',N'["expensive","dependable","creative","unusual"]',1,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (16,N'Please send the report _____ Friday.',N'["by","onward","during","within"]',0,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (17,N'The train was delayed, _____ we arrived late.',N'["because","so","although","unless"]',1,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (18,N'Could you _____ me your pen for a moment?',N'["borrow","owe","lend","rent"]',2,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (19,N'This is the restaurant _____ we had lunch.',N'["which","who","whose","where"]',3,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (20,N'The instructions were clear enough for everyone _____.',N'["understand","understood","to understand","understanding"]',2,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (21,N'Neither of the answers _____ correct.',N'["is","are","be","being"]',0,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (22,N'We look forward to _____ you next week.',N'["meet","meeting","met","have met"]',1,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (23,N'The meeting has been postponed. It will take place _____.',N'["earlier","never","at the same time","later"]',3,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (24,N'Notice: The library closes at 5 p.m. today. When must visitors leave?',N'["Before 5 a.m.","After 6 p.m.","By 5 p.m.","Tomorrow morning"]',2,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (25,N'Email: Please confirm your attendance by replying to this message. What should the reader do?',N'["Send a reply","Cancel the event","Call a taxi","Print a receipt"]',0,N'',N'vocabulary',N'legacy',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (26,N'Tiếng Trung: “你好” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (27,N'Tiếng Trung: “谢谢” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (28,N'Tiếng Trung: “水” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (29,N'Tiếng Trung: “书” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (30,N'Tiếng Trung: “家” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (31,N'Tiếng Trung: “一” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (32,N'Tiếng Trung: “二” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (33,N'Tiếng Trung: “三” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (34,N'Tiếng Trung: “猫” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (35,N'Tiếng Trung: “狗” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (36,N'Tiếng Hàn: “안녕하세요” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (37,N'Tiếng Hàn: “감사합니다” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (38,N'Tiếng Hàn: “물” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (39,N'Tiếng Hàn: “책” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (40,N'Tiếng Hàn: “집” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (41,N'Tiếng Hàn: “하나” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (42,N'Tiếng Hàn: “둘” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (43,N'Tiếng Hàn: “셋” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (44,N'Tiếng Hàn: “고양이” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (45,N'Tiếng Hàn: “개” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (46,N'Tiếng Nhật: “こんにちは” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (47,N'Tiếng Nhật: “ありがとう” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (48,N'Tiếng Nhật: “水” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (49,N'Tiếng Nhật: “本” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (50,N'Tiếng Nhật: “家” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (51,N'Tiếng Nhật: “一” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (52,N'Tiếng Nhật: “二” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (53,N'Tiếng Nhật: “三” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (54,N'Tiếng Nhật: “猫” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (55,N'Tiếng Nhật: “犬” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (56,N'Tiếng Pháp: “Bonjour” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (57,N'Tiếng Pháp: “Merci” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (58,N'Tiếng Pháp: “eau” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (59,N'Tiếng Pháp: “livre” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (60,N'Tiếng Pháp: “maison” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (61,N'Tiếng Pháp: “un” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (62,N'Tiếng Pháp: “deux” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (63,N'Tiếng Pháp: “trois” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (64,N'Tiếng Pháp: “chat” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (65,N'Tiếng Pháp: “chien” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (66,N'Tiếng Đức: “Hallo” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (67,N'Tiếng Đức: “Danke” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (68,N'Tiếng Đức: “Wasser” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (69,N'Tiếng Đức: “Buch” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (70,N'Tiếng Đức: “Haus” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (71,N'Tiếng Đức: “eins” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (72,N'Tiếng Đức: “zwei” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (73,N'Tiếng Đức: “drei” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (74,N'Tiếng Đức: “Katze” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (75,N'Tiếng Đức: “Hund” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (76,N'Tiếng Ý: “Ciao” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (77,N'Tiếng Ý: “Grazie” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (78,N'Tiếng Ý: “acqua” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (79,N'Tiếng Ý: “libro” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (80,N'Tiếng Ý: “casa” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (81,N'Tiếng Ý: “uno” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (82,N'Tiếng Ý: “due” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (83,N'Tiếng Ý: “tre” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (84,N'Tiếng Ý: “gatto” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (85,N'Tiếng Ý: “cane” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (86,N'Tiếng Tây Ban Nha: “Hola” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (87,N'Tiếng Tây Ban Nha: “Gracias” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (88,N'Tiếng Tây Ban Nha: “agua” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (89,N'Tiếng Tây Ban Nha: “libro” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (90,N'Tiếng Tây Ban Nha: “casa” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (91,N'Tiếng Tây Ban Nha: “uno” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (92,N'Tiếng Tây Ban Nha: “dos” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (93,N'Tiếng Tây Ban Nha: “tres” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (94,N'Tiếng Tây Ban Nha: “gato” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (95,N'Tiếng Tây Ban Nha: “perro” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (96,N'Tiếng Bồ Đào Nha: “Olá” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (97,N'Tiếng Bồ Đào Nha: “Obrigado” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (98,N'Tiếng Bồ Đào Nha: “água” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (99,N'Tiếng Bồ Đào Nha: “livro” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (100,N'Tiếng Bồ Đào Nha: “casa” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (101,N'Tiếng Bồ Đào Nha: “um” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (102,N'Tiếng Bồ Đào Nha: “dois” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (103,N'Tiếng Bồ Đào Nha: “três” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (104,N'Tiếng Bồ Đào Nha: “gato” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (105,N'Tiếng Bồ Đào Nha: “cachorro” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (106,N'Tiếng Nga: “Здравствуйте” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (107,N'Tiếng Nga: “Спасибо” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (108,N'Tiếng Nga: “вода” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (109,N'Tiếng Nga: “книга” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (110,N'Tiếng Nga: “дом” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (111,N'Tiếng Nga: “один” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (112,N'Tiếng Nga: “два” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (113,N'Tiếng Nga: “три” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (114,N'Tiếng Nga: “кошка” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (115,N'Tiếng Nga: “собака” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (116,N'Tiếng Ả Rập: “مرحبا” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (117,N'Tiếng Ả Rập: “شكرا” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (118,N'Tiếng Ả Rập: “ماء” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (119,N'Tiếng Ả Rập: “كتاب” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (120,N'Tiếng Ả Rập: “بيت” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (121,N'Tiếng Ả Rập: “واحد” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (122,N'Tiếng Ả Rập: “اثنان” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (123,N'Tiếng Ả Rập: “ثلاثة” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (124,N'Tiếng Ả Rập: “قطة” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (125,N'Tiếng Ả Rập: “كلب” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (126,N'Tiếng Hindi: “नमस्ते” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (127,N'Tiếng Hindi: “धन्यवाद” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (128,N'Tiếng Hindi: “पानी” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (129,N'Tiếng Hindi: “किताब” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (130,N'Tiếng Hindi: “घर” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (131,N'Tiếng Hindi: “एक” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (132,N'Tiếng Hindi: “दो” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (133,N'Tiếng Hindi: “तीन” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (134,N'Tiếng Hindi: “बिल्ली” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (135,N'Tiếng Hindi: “कुत्ता” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (136,N'Tiếng Thái: “สวัสดี” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (137,N'Tiếng Thái: “ขอบคุณ” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (138,N'Tiếng Thái: “น้ำ” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (139,N'Tiếng Thái: “หนังสือ” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (140,N'Tiếng Thái: “บ้าน” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (141,N'Tiếng Thái: “หนึ่ง” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (142,N'Tiếng Thái: “สอง” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (143,N'Tiếng Thái: “สาม” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (144,N'Tiếng Thái: “แมว” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (145,N'Tiếng Thái: “สุนัข” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (146,N'Tiếng Indonesia: “Halo” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (147,N'Tiếng Indonesia: “Terima kasih” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (148,N'Tiếng Indonesia: “air” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (149,N'Tiếng Indonesia: “buku” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (150,N'Tiếng Indonesia: “rumah” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (151,N'Tiếng Indonesia: “satu” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (152,N'Tiếng Indonesia: “dua” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (153,N'Tiếng Indonesia: “tiga” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (154,N'Tiếng Indonesia: “kucing” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (155,N'Tiếng Indonesia: “anjing” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (156,N'Tiếng Việt: “xin chào” có nghĩa là gì trong tiếng Anh?',N'["hello","thank you","water","book"]',0,N'',N'vocabulary',N'legacy',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (157,N'Tiếng Việt: “cảm ơn” có nghĩa là gì trong tiếng Anh?',N'["water","thank you","book","house"]',1,N'',N'vocabulary',N'legacy',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (158,N'Tiếng Việt: “nước” có nghĩa là gì trong tiếng Anh?',N'["house","book","water","one"]',2,N'',N'vocabulary',N'legacy',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (159,N'Tiếng Việt: “sách” có nghĩa là gì trong tiếng Anh?',N'["two","house","one","book"]',3,N'',N'vocabulary',N'legacy',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (160,N'Tiếng Việt: “nhà” có nghĩa là gì trong tiếng Anh?',N'["house","one","two","three"]',0,N'',N'vocabulary',N'legacy',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (161,N'Tiếng Việt: “một” có nghĩa là gì trong tiếng Anh?',N'["two","one","three","cat"]',1,N'',N'vocabulary',N'legacy',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (162,N'Tiếng Việt: “hai” có nghĩa là gì trong tiếng Anh?',N'["cat","three","two","dog"]',2,N'',N'vocabulary',N'legacy',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (163,N'Tiếng Việt: “ba” có nghĩa là gì trong tiếng Anh?',N'["hello","cat","dog","three"]',3,N'',N'vocabulary',N'legacy',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (164,N'Tiếng Việt: “mèo” có nghĩa là gì trong tiếng Anh?',N'["cat","dog","hello","thank you"]',0,N'',N'vocabulary',N'legacy',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (165,N'Tiếng Việt: “chó” có nghĩa là gì trong tiếng Anh?',N'["hello","dog","thank you","water"]',1,N'',N'vocabulary',N'legacy',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (166,N'Tiếng Thổ Nhĩ Kỳ: “Merhaba” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'',N'vocabulary',N'legacy',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (167,N'Tiếng Thổ Nhĩ Kỳ: “Teşekkürler” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'',N'vocabulary',N'legacy',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (168,N'Tiếng Thổ Nhĩ Kỳ: “su” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'',N'vocabulary',N'legacy',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (169,N'Tiếng Thổ Nhĩ Kỳ: “kitap” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'',N'vocabulary',N'legacy',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (170,N'Tiếng Thổ Nhĩ Kỳ: “ev” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'',N'vocabulary',N'legacy',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (171,N'Tiếng Thổ Nhĩ Kỳ: “bir” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'',N'vocabulary',N'legacy',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (172,N'Tiếng Thổ Nhĩ Kỳ: “iki” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'',N'vocabulary',N'legacy',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (173,N'Tiếng Thổ Nhĩ Kỳ: “üç” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'',N'vocabulary',N'legacy',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (174,N'Tiếng Thổ Nhĩ Kỳ: “kedi” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'',N'vocabulary',N'legacy',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (175,N'Tiếng Thổ Nhĩ Kỳ: “köpek” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'',N'vocabulary',N'legacy',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (176,N'“hello” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (177,N'She ___ to school every day.',N'["go","goes","going","gone"]',1,N'A1',N'grammar',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (178,N'Linh goes to the library to borrow a book.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (179,N'“appointment” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (180,N'We ___ the museum yesterday.',N'["visited","visit","visiting","visits"]',0,N'A2',N'grammar',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (181,N'The picnic planned for Saturday has been moved to Sunday because of heavy rain.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (182,N'“responsibility” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (183,N'If I had more time, I ___ another language.',N'["have learned","will learn","learn","would learn"]',3,N'B1',N'grammar',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (184,N'The course had ten sessions. Mai missed two and attended all the others.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (185,N'“sustainable” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (186,N'___ the rain, they continued the journey.',N'["Because","Although","Despite","Even"]',2,N'B2',N'grammar',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (187,N'Although the study included many participants, all came from one city; its findings cannot automatically be applied everywhere.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (188,N'“nuance” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (189,N'No sooner had she arrived ___ the meeting began.',N'["when","than","that","then"]',1,N'C1',N'grammar',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (190,N'The writer welcomes remote work for its flexibility, provided that employers protect privacy and give staff equal access to information.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (191,N'“paradox” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (192,N'Had I known about the delay, I ___ earlier.',N'["would have left","will leave","would leave","had left"]',0,N'C2',N'grammar',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (193,N'The lack of evidence for a claim is not necessarily proof that the claim is false; it may instead reflect the limits of the available inquiry.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (194,N'“你好” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'HSK1',N'vocabulary',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (195,N'我___学生。',N'["在","是","有","去"]',1,N'HSK1',N'grammar',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (196,N'小林去图书馆借书。

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'HSK1',N'reading',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (197,N'“预约” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'HSK2',N'vocabulary',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (198,N'昨天我___了三本书。',N'["买","很","的","从"]',0,N'HSK2',N'grammar',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (199,N'原定星期六的野餐因为大雨改到星期天。

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'HSK2',N'reading',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (200,N'“责任” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'HSK3',N'vocabulary',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (201,N'___下雨，我们还是出发了。',N'["只有","因为","如果","虽然"]',3,N'HSK3',N'grammar',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (202,N'这门课一共有十次课，小梅缺席了两次，其余都参加了。

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'HSK3',N'reading',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (203,N'“可持续” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'HSK4',N'vocabulary',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (204,N'只有认真准备，___能取得进步。',N'["又","就","才","也"]',2,N'HSK4',N'grammar',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (205,N'这项研究的参与者虽然很多，却都来自同一座城市，因此不能直接把结论推广到所有地区。

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'HSK4',N'reading',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (206,N'“细微差别” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'HSK5',N'vocabulary',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (207,N'与其抱怨，___采取行动。',N'["由于","不如","以免","何况"]',1,N'HSK5',N'grammar',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (208,N'作者赞成远程工作的灵活性，但强调雇主必须保护隐私，并确保员工平等获取信息。

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'HSK5',N'reading',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (209,N'“悖论” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'HSK6',N'vocabulary',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (210,N'他___没有放弃，反而更加努力了。',N'["非但","除非","既然","以便"]',0,N'HSK6',N'grammar',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (211,N'没有找到支持某一主张的证据，并不必然证明该主张错误，也可能反映调查方法的局限。

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'HSK6',N'reading',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (212,N'“认识论” có nghĩa là gì?',N'["lịch hẹn","xin chào","nhận thức luận","trách nhiệm"]',2,N'HSK7-9',N'vocabulary',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (213,N'计划固然周密，___执行仍需因地制宜。',N'["从而","因此","以致","但"]',3,N'HSK7-9',N'grammar',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (214,N'当一个理论能够解释现有材料，却无法排除其他同样合理的解释时，其说服力不应与结论的确定性混为一谈。

Tác giả phân biệt điều gì?',N'["Khả năng giải thích và mức độ chắc chắn của kết luận","Số người và số buổi học","Địa điểm và lịch hẹn","Mọi lý thuyết đều sai"]',0,N'HSK7-9',N'reading',N'competency',N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (215,N'“안녕하세요” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'TOPIK1',N'vocabulary',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (216,N'저는 학생___.',N'["갑니다","입니다","먹습니다","있습니다"]',1,N'TOPIK1',N'grammar',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (217,N'린은 책을 빌리려고 도서관에 갑니다.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'TOPIK1',N'reading',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (218,N'“예약” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'TOPIK2',N'vocabulary',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (219,N'어제 친구를 ___.',N'["만났어요","만나요","만날 거예요","만나세요"]',0,N'TOPIK2',N'grammar',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (220,N'토요일에 하기로 했던 소풍은 폭우 때문에 일요일로 미뤄졌습니다.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'TOPIK2',N'reading',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (221,N'“책임” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'TOPIK3',N'vocabulary',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (222,N'비가 ___ 우산을 가져가세요.',N'["오려고","오지만","오거나","오니까"]',3,N'TOPIK3',N'grammar',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (223,N'수업은 모두 열 번이었습니다. 마이는 두 번 결석하고 나머지 수업에는 모두 참석했습니다.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'TOPIK3',N'reading',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (224,N'“지속 가능한” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'TOPIK4',N'vocabulary',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (225,N'열심히 공부한 ___ 시험에 합격했다.',N'["중에","대신에","덕분에","뿐이다"]',2,N'TOPIK4',N'grammar',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (226,N'연구 참여자는 많았지만 모두 한 도시에서 모집했으므로 결과를 모든 지역에 그대로 적용하기는 어렵다.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'TOPIK4',N'reading',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (227,N'“미묘한 차이” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'TOPIK5',N'vocabulary',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (228,N'직접 확인하지 않고서는 사실이라고 ___ 어렵다.',N'["단정해서","단정하기","단정한 뒤","단정했지만"]',1,N'TOPIK5',N'grammar',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (229,N'필자는 재택근무의 유연성을 긍정적으로 평가하지만, 사생활 보호와 정보 접근의 공정성이 보장되어야 한다고 본다.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'TOPIK5',N'reading',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (230,N'“역설” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'TOPIK6',N'vocabulary',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (231,N'노력도 하지 않으면서 성공을 바라다니, 그야말로 ___.',N'["어불성설이다","금상첨화이다","일석이조이다","전화위복이다"]',0,N'TOPIK6',N'grammar',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (232,N'어떤 주장을 뒷받침할 증거가 발견되지 않았다는 사실만으로 그 주장이 거짓이라고 단정할 수는 없다. 이는 조사 방법의 한계를 드러낼 수도 있다.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'TOPIK6',N'reading',N'competency',N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (233,N'“こんにちは” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'N5',N'vocabulary',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (234,N'わたしは学生___。',N'["ます","です","ある","する"]',1,N'N5',N'grammar',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (235,N'リンさんは本を借りに図書館へ行きます。

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'N5',N'reading',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (236,N'“予約” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'N4',N'vocabulary',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (237,N'昨日、図書館へ___。',N'["行きました","行きます","行きましょう","行きません"]',0,N'N4',N'grammar',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (238,N'土曜日に予定していたピクニックは、大雨のため日曜日に変更されました。

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'N4',N'reading',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (239,N'“責任” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'N3',N'vocabulary',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (240,N'雨が降っている___、試合は行われた。',N'["ことに","ために","ように","のに"]',3,N'N3',N'grammar',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (241,N'授業は全部で十回あった。マイさんは二回欠席し、それ以外はすべて出席した。

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'N3',N'reading',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (242,N'“微妙な違い” có nghĩa là gì?',N'["xin chào","sắc thái / khác biệt tinh tế","lịch hẹn","trách nhiệm"]',1,N'N2',N'vocabulary',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (243,N'この問題は、専門家___解決できないほど難しい。',N'["ばかりに","にだけ","でさえ","のうちに"]',2,N'N2',N'grammar',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (244,N'筆者は在宅勤務の柔軟性を評価する一方、個人情報の保護と情報への公平なアクセスが不可欠だと指摘している。

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Chỉ đề cập lương thưởng","Ủng hộ bất kể quyền riêng tư","Phản đối hoàn toàn","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin"]',3,N'N2',N'reading',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (245,N'“逆説” có nghĩa là gì?',N'["nghịch lý","xin chào","lịch hẹn","trách nhiệm"]',0,N'N1',N'vocabulary',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (246,N'十分な根拠がない以上、その結論には同意___。',N'["しがちだ","しかねる","し終える","しつつある"]',1,N'N1',N'grammar',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (247,N'ある主張を裏付ける証拠が見つからないからといって、その主張が誤りだと断定できるわけではない。調査の限界を示している可能性もある。

Có thể rút ra nhận định nào?',N'["Mọi nhận định đều đúng","Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Không cần xem xét phương pháp nghiên cứu"]',2,N'N1',N'reading',N'competency',N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (248,N'“bonjour” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (249,N'Je ___ étudiant.',N'["es","suis","est","sommes"]',1,N'A1',N'grammar',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (250,N'Linh va à la bibliothèque pour emprunter un livre.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (251,N'“rendez-vous” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (252,N'Hier, nous ___ au musée.',N'["sommes allés","allons","irons","allez"]',0,N'A2',N'grammar',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (253,N'Le pique-nique prévu samedi est reporté à dimanche à cause de fortes pluies.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (254,N'“responsabilité” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (255,N'Si j''avais plus de temps, je ___ davantage.',N'["voyageais","voyagerai","voyage","voyagerais"]',3,N'B1',N'grammar',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (256,N'Le cours comptait dix séances. Mai en a manqué deux et a assisté à toutes les autres.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (257,N'“durable” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (258,N'Il faut que tu ___ à l''heure.',N'["viendras","viens","viennes","venais"]',2,N'B2',N'grammar',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (259,N'Malgré le nombre élevé de participants, l''étude porte sur une seule ville : ses résultats ne sont donc pas automatiquement généralisables.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (260,N'“nuance” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (261,N'Bien qu''il ___ fatigué, il poursuit son travail.',N'["est","soit","sera","était"]',1,N'C1',N'grammar',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (262,N'L''auteur apprécie la souplesse du télétravail, à condition que la vie privée soit protégée et que chacun ait un accès équitable à l''information.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (263,N'“paradoxe” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (264,N'Si j''avais su, je ___ autrement.',N'["serais parti","partirai","pars","partais"]',0,N'C2',N'grammar',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (265,N'L''absence de preuve en faveur d''une affirmation ne constitue pas nécessairement la preuve de sa fausseté ; elle peut révéler les limites de l''enquête.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (266,N'“hallo” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (267,N'Ich ___ Student.',N'["bist","bin","ist","sind"]',1,N'A1',N'grammar',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (268,N'Linh geht in die Bibliothek, um ein Buch auszuleihen.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (269,N'“Termin” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (270,N'Gestern ___ ich im Museum.',N'["war","bin","werde","sei"]',0,N'A2',N'grammar',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (271,N'Das für Samstag geplante Picknick wurde wegen starken Regens auf Sonntag verschoben.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (272,N'“Verantwortung” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (273,N'Wenn ich mehr Zeit hätte, ___ ich mehr lesen.',N'["bin","werde","habe","würde"]',3,N'B1',N'grammar',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (274,N'Der Kurs hatte zehn Termine. Mai fehlte zweimal und nahm an allen übrigen Terminen teil.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (275,N'“nachhaltig” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (276,N'___ es regnete, gingen wir spazieren.',N'["Damit","Weil","Obwohl","Sobald"]',2,N'B2',N'grammar',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (277,N'Obwohl viele Personen teilnahmen, stammen sie aus nur einer Stadt; die Ergebnisse lassen sich deshalb nicht ohne Weiteres verallgemeinern.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (278,N'“Nuance” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (279,N'Er tat so, als ___ er von nichts.',N'["weiß","wüsste","wissen","gewusst"]',1,N'C1',N'grammar',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (280,N'Der Autor begrüßt die Flexibilität der Heimarbeit, sofern Privatsphäre und ein gleichberechtigter Zugang zu Informationen gewährleistet sind.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (281,N'“Paradox” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (282,N'Hätte ich davon gewusst, ___ ich früher gekommen.',N'["wäre","werde","bin","habe"]',0,N'C2',N'grammar',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (283,N'Das Fehlen von Belegen für eine Behauptung ist nicht zwangsläufig ein Beleg für deren Unrichtigkeit, sondern kann auch die Grenzen der Untersuchung widerspiegeln.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (284,N'“ciao” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (285,N'Io ___ studente.',N'["sei","sono","è","siamo"]',1,N'A1',N'grammar',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (286,N'Linh va in biblioteca per prendere in prestito un libro.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (287,N'“appuntamento” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (288,N'Ieri noi ___ al museo.',N'["siamo andati","andiamo","andremo","andate"]',0,N'A2',N'grammar',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (289,N'Il picnic previsto per sabato è stato rinviato a domenica a causa della forte pioggia.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (290,N'“responsabilità” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (291,N'Se avessi tempo, ___ di più.',N'["leggevo","leggerò","leggo","leggerei"]',3,N'B1',N'grammar',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (292,N'Il corso comprendeva dieci lezioni. Mai ne ha saltate due e ha frequentato tutte le altre.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (293,N'“sostenibile” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (294,N'Spero che tu ___ bene.',N'["starai","stai","stia","stavi"]',2,N'B2',N'grammar',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (295,N'Nonostante i numerosi partecipanti, lo studio riguarda una sola città: i risultati non sono quindi automaticamente generalizzabili.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (296,N'“sfumatura” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (297,N'Benché ___ tardi, continuarono a discutere.',N'["era","fosse","sarà","è"]',1,N'C1',N'grammar',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (298,N'L''autore apprezza la flessibilità del lavoro a distanza, purché siano garantiti la riservatezza e un accesso equo alle informazioni.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (299,N'“paradosso” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (300,N'Se lo avessi saputo, ___ prima.',N'["sarei partito","partirò","parto","partivo"]',0,N'C2',N'grammar',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (301,N'L''assenza di prove a favore di un''affermazione non dimostra necessariamente che sia falsa; può invece rivelare i limiti dell''indagine.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (302,N'“hola” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (303,N'Yo ___ estudiante.',N'["eres","soy","es","somos"]',1,N'A1',N'grammar',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (304,N'Linh va a la biblioteca para pedir prestado un libro.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (305,N'“cita” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (306,N'Ayer nosotros ___ al museo.',N'["fuimos","vamos","iremos","vais"]',0,N'A2',N'grammar',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (307,N'El picnic previsto para el sábado se ha aplazado al domingo por las fuertes lluvias.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (308,N'“responsabilidad” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (309,N'Si tuviera tiempo, ___ más.',N'["viajaba","viajaré","viajo","viajaría"]',3,N'B1',N'grammar',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (310,N'El curso tenía diez sesiones. Mai faltó a dos y asistió a todas las demás.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (311,N'“sostenible” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (312,N'Espero que tú ___ bien.',N'["estarás","estás","estés","estabas"]',2,N'B2',N'grammar',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (313,N'Aunque participaron muchas personas, todas procedían de una sola ciudad; los resultados no se pueden generalizar automáticamente.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (314,N'“matiz” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (315,N'Aunque ___ difícil, lo intentaremos. (Tình huống giả định)',N'["es","sea","será","fue"]',1,N'C1',N'grammar',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (316,N'El autor valora la flexibilidad del teletrabajo siempre que se proteja la privacidad y se garantice un acceso equitativo a la información.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (317,N'“paradoja” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (318,N'Si lo hubiera sabido, ___ antes.',N'["habría salido","saldré","salgo","salía"]',0,N'C2',N'grammar',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (319,N'La ausencia de pruebas que respalden una afirmación no demuestra necesariamente su falsedad; puede revelar las limitaciones de la investigación.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (320,N'“olá” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (321,N'Eu ___ estudante.',N'["és","sou","é","somos"]',1,N'A1',N'grammar',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (322,N'Linh vai à biblioteca para pegar um livro emprestado.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (323,N'“agendamento” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (324,N'Ontem nós ___ ao museu.',N'["fomos","vamos","iremos","vão"]',0,N'A2',N'grammar',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (325,N'O piquenique previsto para sábado foi adiado para domingo por causa da chuva forte.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (326,N'“responsabilidade” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (327,N'Se eu tivesse tempo, ___ mais.',N'["viajava","viajarei","viajo","viajaria"]',3,N'B1',N'grammar',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (328,N'O curso teve dez aulas. Mai faltou a duas e participou de todas as outras.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (329,N'“sustentável” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (330,N'Espero que você ___ bem.',N'["estará","está","esteja","estava"]',2,N'B2',N'grammar',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (331,N'Apesar do grande número de participantes, todos vieram de uma única cidade; os resultados não podem ser generalizados automaticamente.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (332,N'“nuance” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (333,N'Embora ___ tarde, continuaram a discussão.',N'["era","fosse","será","é"]',1,N'C1',N'grammar',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (334,N'O autor valoriza a flexibilidade do trabalho remoto, desde que a privacidade e o acesso equitativo às informações sejam garantidos.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (335,N'“paradoxo” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (336,N'Se eu soubesse, ___ antes.',N'["teria saído","sairei","saio","saía"]',0,N'C2',N'grammar',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (337,N'A ausência de provas a favor de uma afirmação não demonstra necessariamente que ela seja falsa; pode refletir as limitações da investigação.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (338,N'“здравствуйте” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (339,N'Это ___ книга.',N'["мой","моя","моё","мои"]',1,N'A1',N'grammar',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (340,N'Линь идёт в библиотеку, чтобы взять книгу.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (341,N'“запись на приём” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (342,N'Вчера я ___ в музее.',N'["был","буду","быть","будешь"]',0,N'A2',N'grammar',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (343,N'Пикник, запланированный на субботу, перенесли на воскресенье из-за сильного дождя.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (344,N'“ответственность” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (345,N'Если бы у меня было время, я ___ больше.',N'["читай","читаю","буду читать","читал бы"]',3,N'B1',N'grammar',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (346,N'В курсе было десять занятий. Май пропустила два, а все остальные посетила.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (347,N'“устойчивый” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (348,N'___ дождь, мы продолжили путь.',N'["Из-за","Благодаря","Несмотря на","Вследствие"]',2,N'B2',N'grammar',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (349,N'Хотя участников было много, все они представляли один город, поэтому результаты нельзя автоматически распространять на другие регионы.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (350,N'“нюанс” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (351,N'Он говорил так, ___ всё уже знал.',N'["потому что","как будто","для того чтобы","если бы не"]',1,N'C1',N'grammar',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (352,N'Автор ценит гибкость удалённой работы при условии защиты частной жизни и равного доступа сотрудников к информации.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (353,N'“парадокс” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (354,N'Будь у нас больше данных, выводы ___ точнее.',N'["были бы","будут","есть","быть"]',0,N'C2',N'grammar',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (355,N'Отсутствие доказательств в пользу утверждения не обязательно доказывает его ложность: оно может отражать ограничения проведённого исследования.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (356,N'“مرحبا” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (357,N'أنا ___. (Tôi là học sinh)',N'["كتاب","طالب","بيت","قلم"]',1,N'A1',N'grammar',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (358,N'تذهب لين إلى المكتبة لاستعارة كتاب.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (359,N'“موعد” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (360,N'أمس ___ إلى المتحف.',N'["ذهبتُ","أذهبُ","سأذهبُ","اذهبْ"]',0,N'A2',N'grammar',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (361,N'تأجلت النزهة المقررة يوم السبت إلى يوم الأحد بسبب الأمطار الغزيرة.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (362,N'“مسؤولية” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (363,N'لو كان عندي وقت، ___ أكثر.',N'["لن أقرأَ","سأقرأُ","اقرأْ","لقرأتُ"]',3,N'B1',N'grammar',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (364,N'تضمنت الدورة عشرة دروس. غابت ماي عن درسين وحضرت بقية الدروس كلها.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (365,N'“مستدام” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (366,N'لن ___ الطالبُ عن الدرس.',N'["يتأخرْ","يتأخرُ","يتأخرَ","تأخّرَ"]',2,N'B2',N'grammar',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (367,N'على الرغم من كثرة المشاركين، فإنهم جميعاً من مدينة واحدة، ولذلك لا يمكن تعميم النتائج تلقائياً على جميع المناطق.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (368,N'“فارق دقيق” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (369,N'لم ___ الباحثُ من عمله بعدُ.',N'["ينتهي","ينتهِ","انتهى","سينتهي"]',1,N'C1',N'grammar',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (370,N'يرى الكاتب أن مرونة العمل عن بُعد مفيدة، شريطة حماية الخصوصية وضمان وصول العاملين إلى المعلومات على قدم المساواة.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (371,N'“مفارقة” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (372,N'___ تنوّعت الآراء، فإن الحوار يظل ضرورياً. (Dù quan điểm đa dạng)',N'["مهما","لأن","كي","حتى"]',0,N'C2',N'grammar',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (373,N'إن غياب الدليل المؤيد لادعاء ما لا يثبت بالضرورة بطلانه، فقد يعكس حدود البحث المتاح بدلاً من ذلك.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (374,N'“नमस्ते” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (375,N'मैं विद्यार्थी ___.',N'["है","हूँ","हो","हैं"]',1,N'A1',N'grammar',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (376,N'लिन किताब उधार लेने के लिए पुस्तकालय जाती है।

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (377,N'“मुलाकात का समय” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (378,N'कल राम संग्रहालय ___.',N'["गया था","जाएगा","जाता है","जाओ"]',0,N'A2',N'grammar',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (379,N'भारी बारिश के कारण शनिवार की पिकनिक रविवार तक टाल दी गई है।

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (380,N'“ज़िम्मेदारी” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (381,N'अगर मेरे पास समय होता, तो मैं और ___.',N'["पढ़ना","पढ़ूँगा","पढ़ो","पढ़ता"]',3,N'B1',N'grammar',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (382,N'पाठ्यक्रम में दस कक्षाएँ थीं। माई दो कक्षाओं में अनुपस्थित रही और बाकी सभी में उपस्थित थी।

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (383,N'“टिकाऊ” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (384,N'बारिश होने के ___ हम बाहर गए।',N'["लिए","कारण","बावजूद","पहले"]',2,N'B2',N'grammar',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (385,N'अध्ययन में बहुत से लोग शामिल थे, लेकिन वे सभी एक ही शहर से थे; इसलिए परिणाम हर क्षेत्र पर अपने आप लागू नहीं होते।

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (386,N'“सूक्ष्म अंतर” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (387,N'उसने ऐसे कहा ___ उसे सब पता हो।',N'["क्योंकि","मानो","इसलिए","ताकि"]',1,N'C1',N'grammar',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (388,N'लेखक घर से काम करने की सुविधा का समर्थन करता है, बशर्ते निजता की रक्षा हो और सभी कर्मचारियों को सूचना तक समान पहुँच मिले।

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (389,N'“विरोधाभास” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (390,N'यदि पर्याप्त प्रमाण उपलब्ध होते, तो निष्कर्ष अधिक स्पष्ट ___.',N'["होते","होगा","है","होना"]',0,N'C2',N'grammar',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (391,N'किसी दावे के पक्ष में प्रमाण न मिलना आवश्यक रूप से उसके असत्य होने का प्रमाण नहीं है; यह उपलब्ध जाँच की सीमाओं को भी दर्शा सकता है।

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (392,N'“สวัสดี” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (393,N'ฉัน___นักเรียน (Tôi là học sinh)',N'["กิน","เป็น","ไป","อ่าน"]',1,N'A1',N'grammar',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (394,N'ลินไปห้องสมุดเพื่อยืมหนังสือ

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (395,N'“การนัดหมาย” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (396,N'เมื่อวานฉัน___พิพิธภัณฑ์มา',N'["ไป","จะไป","กำลังไป","อย่าไป"]',0,N'A2',N'grammar',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (397,N'การปิกนิกที่กำหนดไว้วันเสาร์เลื่อนไปเป็นวันอาทิตย์เพราะฝนตกหนัก

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (398,N'“ความรับผิดชอบ” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (399,N'___มีเวลา ฉันจะอ่านหนังสือเพิ่ม (Nếu có thời gian)',N'["หรือ","เพราะ","แต่","ถ้า"]',3,N'B1',N'grammar',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (400,N'หลักสูตรมีทั้งหมดสิบครั้ง มายขาดเรียนสองครั้งและเข้าเรียนครั้งอื่นทั้งหมด

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (401,N'“ยั่งยืน” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (402,N'___ฝนจะตก เราก็ยังออกเดินทาง (Mặc dù)',N'["ดังนั้น","เพราะว่า","แม้ว่า","หรือว่า"]',2,N'B2',N'grammar',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (403,N'แม้ว่าจะมีผู้เข้าร่วมวิจัยจำนวนมาก แต่ทุกคนมาจากเมืองเดียวกัน จึงไม่อาจสรุปว่าผลวิจัยใช้ได้กับทุกพื้นที่โดยอัตโนมัติ

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (404,N'“ความแตกต่างเล็กน้อย” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (405,N'เขาพูด___รู้เรื่องทั้งหมด (Như thể biết mọi chuyện)',N'["เพราะว่า","ราวกับว่า","เพื่อให้","ดังนั้น"]',1,N'C1',N'grammar',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (406,N'ผู้เขียนเห็นข้อดีของความยืดหยุ่นในการทำงานทางไกล โดยมีเงื่อนไขว่าต้องคุ้มครองความเป็นส่วนตัวและให้ทุกคนเข้าถึงข้อมูลอย่างเท่าเทียม

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (407,N'“ปฏิทรรศน์” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (408,N'___ผลวิจัยนี้จะมีประโยชน์ ก็ไม่ควรนำไปใช้โดยไม่พิจารณาบริบท (Mặc dù)',N'["ถึงแม้ว่า","เนื่องจาก","เพื่อที่","เพราะฉะนั้น"]',0,N'C2',N'grammar',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (409,N'การไม่พบหลักฐานสนับสนุนข้อกล่าวอ้างไม่ได้พิสูจน์เสมอไปว่าข้อกล่าวอ้างนั้นเป็นเท็จ แต่อาจสะท้อนข้อจำกัดของการศึกษาที่มีอยู่

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (410,N'“halo” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (411,N'Saya ___ mahasiswa. (Tôi là sinh viên)',N'["makan","adalah","pergi","membaca"]',1,N'A1',N'grammar',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (412,N'Linh pergi ke perpustakaan untuk meminjam buku.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (413,N'“janji temu” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (414,N'Kemarin saya ___ pergi ke museum.',N'["sudah","akan","sedang","jangan"]',0,N'A2',N'grammar',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (415,N'Piknik yang dijadwalkan pada hari Sabtu ditunda hingga Minggu karena hujan lebat.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (416,N'“tanggung jawab” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (417,N'___ ada waktu, saya akan membaca lebih banyak.',N'["Atau","Karena","Tetapi","Jika"]',3,N'B1',N'grammar',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (418,N'Kursus itu terdiri atas sepuluh pertemuan. Mai tidak hadir dua kali dan mengikuti semua pertemuan lainnya.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (419,N'“berkelanjutan” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (420,N'___ hujan turun, kami tetap berangkat.',N'["Sehingga","Karena","Meskipun","Agar"]',2,N'B2',N'grammar',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (421,N'Walaupun pesertanya banyak, semuanya berasal dari satu kota sehingga hasil penelitian tidak dapat langsung digeneralisasi ke semua daerah.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (422,N'“nuansa” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (423,N'Ia berbicara ___ mengetahui semuanya.',N'["supaya","seolah-olah","karena","akibatnya"]',1,N'C1',N'grammar',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (424,N'Penulis mendukung fleksibilitas kerja jarak jauh asalkan privasi dilindungi dan akses terhadap informasi diberikan secara adil.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (425,N'“paradoks” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (426,N'___ data diperiksa, semakin jelas keterbatasan kesimpulannya.',N'["Semakin teliti","Walaupun teliti","Karena teliti","Agar teliti"]',0,N'C2',N'grammar',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (427,N'Tidak ditemukannya bukti yang mendukung suatu pernyataan belum tentu membuktikan bahwa pernyataan itu salah; hal tersebut dapat mencerminkan keterbatasan penelitian.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (428,N'“xin chào” có nghĩa là gì trong tiếng Anh?',N'["hello","appointment","responsibility","sustainable"]',0,N'A1',N'vocabulary',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (429,N'Tôi ___ sinh viên.',N'["ở","là","đi","ăn"]',1,N'A1',N'grammar',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (430,N'Linh đến thư viện để mượn một cuốn sách.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (431,N'“lịch hẹn” có nghĩa là gì trong tiếng Anh?',N'["sustainable","hello","responsibility","appointment"]',3,N'A2',N'vocabulary',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (432,N'Hôm qua, tôi ___ đến bảo tàng.',N'["đã","sẽ","sắp","hãy"]',0,N'A2',N'grammar',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (433,N'Buổi dã ngoại dự kiến vào thứ Bảy được chuyển sang Chủ nhật vì mưa lớn.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (434,N'“trách nhiệm” có nghĩa là gì trong tiếng Anh?',N'["appointment","hello","responsibility","sustainable"]',2,N'B1',N'vocabulary',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (435,N'___ có thêm thời gian, tôi sẽ đọc nhiều hơn.',N'["Hoặc","Vì","Nhưng","Nếu"]',3,N'B1',N'grammar',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (436,N'Khóa học có mười buổi. Mai nghỉ hai buổi và tham dự tất cả các buổi còn lại.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (437,N'“bền vững” có nghĩa là gì trong tiếng Anh?',N'["hello","sustainable","appointment","responsibility"]',1,N'B2',N'vocabulary',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (438,N'___ trời mưa, chúng tôi vẫn khởi hành.',N'["Do đó","Bởi vì","Mặc dù","Để mà"]',2,N'B2',N'grammar',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (439,N'Dù có nhiều người tham gia, nghiên cứu chỉ khảo sát một thành phố; kết quả vì vậy không thể tự động áp dụng cho mọi địa phương.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (440,N'“sắc thái” có nghĩa là gì trong tiếng Anh?',N'["nuance","hello","appointment","responsibility"]',0,N'C1',N'vocabulary',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (441,N'Anh ấy nói ___ đã biết hết mọi chuyện.',N'["bởi vì","như thể","cho nên","nhằm để"]',1,N'C1',N'grammar',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (442,N'Tác giả ủng hộ sự linh hoạt của làm việc từ xa, với điều kiện quyền riêng tư và khả năng tiếp cận thông tin bình đẳng được bảo đảm.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (443,N'“nghịch lý” có nghĩa là gì trong tiếng Anh?',N'["responsibility","hello","appointment","paradox"]',3,N'C2',N'vocabulary',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (444,N'___ số liệu được thu thập kỹ lưỡng, kết luận vẫn cần được kiểm chứng độc lập.',N'["Dẫu","Bởi vì","Để","Do đó"]',0,N'C2',N'grammar',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (445,N'Không tìm thấy bằng chứng ủng hộ một nhận định chưa đủ để chứng minh nhận định ấy sai; điều đó cũng có thể phản ánh giới hạn của quá trình khảo sát.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (446,N'“merhaba” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (447,N'Ben bir ___. (Tôi là sinh viên)',N'["öğrencisin","öğrenciyim","öğrenciye","öğrencinin"]',1,N'A1',N'grammar',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (448,N'Linh kitap ödünç almak için kütüphaneye gidiyor.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (449,N'“randevu” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (450,N'Dün müzeye ___.',N'["gittim","gideceğim","gidiyorum","git"]',0,N'A2',N'grammar',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (451,N'Cumartesi yapılması planlanan piknik, şiddetli yağmur nedeniyle pazar gününe ertelendi.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (452,N'“sorumluluk” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (453,N'Zamanım olsaydı daha çok ___.',N'["oku","okuyacağım","okuyorum","okurdum"]',3,N'B1',N'grammar',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (454,N'Kursta on ders vardı. Mai iki derse katılmadı ve diğer derslerin hepsine katıldı.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (455,N'“sürdürülebilir” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (456,N'Yağmur yağmasına ___ yola çıktık.',N'["için","çünkü","rağmen","dolayı"]',2,N'B2',N'grammar',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (457,N'Katılımcı sayısı yüksek olsa da hepsi aynı şehirden seçildiği için sonuçlar tüm bölgelere kendiliğinden genellenemez.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (458,N'“nüans” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (459,N'Her şeyi biliyor___ konuştu.',N'["mak için","muş gibi","duğu için","dıktan sonra"]',1,N'C1',N'grammar',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (460,N'Yazar, mahremiyetin korunması ve bilgiye eşit erişimin sağlanması koşuluyla uzaktan çalışmanın esnekliğini destekliyor.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (461,N'“paradoks” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (462,N'Veriler ne kadar ayrıntılı ___ olsun, sonuçlar bağımsız olarak sınanmalıdır.',N'["olursa","olacak","oldu","olmak"]',0,N'C2',N'grammar',N'competency',N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[levelCode],[skill],[assessment],[language])
    VALUES (463,N'Bir iddiayı destekleyen kanıtın bulunmaması, o iddianın yanlış olduğunu zorunlu olarak göstermez; mevcut araştırmanın sınırlarını da yansıtabilir.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'tr');
    SET IDENTITY_INSERT dbo.[questions] OFF;

    -- news: 3 bản ghi
    SET IDENTITY_INSERT dbo.[news] ON;
    INSERT INTO dbo.[news] ([id],[title],[category],[date],[image],[excerpt],[content])
    VALUES (1,N'Bắt đầu hành trình IELTS: từ đâu và như thế nào?',N'Góc học tập',N'2026-09-18',N'/images/ielts.jpg',N'Một lộ trình rõ ràng sẽ giúp việc học nhẹ nhàng hơn. Cùng tìm điểm khởi đầu phù hợp với bạn.',N'Bước đầu tiên không phải là làm thật nhiều đề, mà là hiểu trình độ hiện tại của mình. Hãy dành thời gian kiểm tra từ vựng, ngữ pháp và khả năng đọc hiểu.

Tiếp theo, đặt một mục tiêu nhỏ cho từng tuần: học 20 từ mới theo chủ đề, nghe một đoạn hội thoại ngắn hoặc viết một đoạn văn 100 từ. Việc học đều đặn quan trọng hơn những buổi học kéo dài nhưng thiếu tập trung.

Cuối cùng, hãy tìm người phản hồi cho bài viết và phần nói của bạn. Giáo viên có thể giúp bạn nhận ra lỗi lặp lại và xây dựng cách sửa phù hợp.');
    INSERT INTO dbo.[news] ([id],[title],[category],[date],[image],[excerpt],[content])
    VALUES (2,N'5 cách để con yêu tiếng Anh mỗi ngày',N'Cùng con khôn lớn',N'2026-09-15',N'/images/kids.jpg',N'Những hoạt động nhỏ tại nhà để ba mẹ đồng hành cùng con, bắt đầu bằng niềm vui.',N'Đọc một cuốn truyện tranh ngắn, hát một bài hát hoặc cùng chơi trò đoán đồ vật đều là những cách đưa tiếng Anh vào cuộc sống.

Hãy để con chọn chủ đề mình thích. Khi con nói sai, ba mẹ có thể nhắc lại câu đúng một cách tự nhiên thay vì ngắt lời.

Mỗi ngày 10–15 phút là một khởi đầu tốt. Điều quan trọng là giữ không khí vui vẻ, khuyến khích con thử và ghi nhận sự tiến bộ của con.');
    INSERT INTO dbo.[news] ([id],[title],[category],[date],[image],[excerpt],[content])
    VALUES (3,N'Nói tiếng Anh tự tin hơn, từng chút một',N'Kỹ năng giao tiếp',N'2026-09-12',N'/images/adults.jpg',N'Bạn không cần hoàn hảo để bắt đầu một cuộc trò chuyện. Bạn chỉ cần sẵn sàng mở lời.',N'Sự tự tin được hình thành qua luyện tập. Hãy bắt đầu với một chủ đề quen thuộc: công việc, sở thích hoặc một bộ phim bạn vừa xem.

Ghi âm một phút mỗi ngày, nghe lại và chọn một điểm muốn cải thiện. Không cần sửa tất cả lỗi cùng một lúc.

Khi trò chuyện, hãy dùng câu ngắn và hỏi lại nếu chưa hiểu. Giao tiếp là kết nối ý nghĩa, vì vậy hãy tập trung vào thông điệp bạn muốn chia sẻ.');
    SET IDENTITY_INSERT dbo.[news] OFF;

    INSERT INTO dbo.contacts (name,email,phone,message,kind,age,courseId,campus)
    VALUES (N'Trần Minh Anh',N'tuvan@example.com','0912345678',N'Mong được tư vấn khóa IELTS buổi tối.','consultation',20,1,N'Cơ sở Lê Lợi');
    INSERT INTO dbo.metadata ([key],value) VALUES (N'sqlserver-sample-v1',N'1');
    COMMIT;
    PRINT N'Đã nhập dữ liệu mẫu: 16 ngôn ngữ, 99 khóa, 24 giáo viên, 302 lớp, 463 câu hỏi (288 câu năng lực).';
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK;
    SET IDENTITY_INSERT dbo.[users] OFF;
    SET IDENTITY_INSERT dbo.[courses] OFF;
    SET IDENTITY_INSERT dbo.[teachers] OFF;
    SET IDENTITY_INSERT dbo.[classes] OFF;
    SET IDENTITY_INSERT dbo.[enrollments] OFF;
    SET IDENTITY_INSERT dbo.[questions] OFF;
    SET IDENTITY_INSERT dbo.[news] OFF;
    THROW;
END CATCH;
GO
