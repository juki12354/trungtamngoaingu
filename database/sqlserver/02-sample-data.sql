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
    VALUES (1,N'Quản trị viên',N'admin@vinhenglish.vn',N'',NULL,N'cb8c6ff4a4d4f9827902c1b8b213fd13:1416c46906e5e936c27909e5b712b6bd5d56d4af190927f59ec6aea6eddaecc6d4498e9e484e8f32b7d7497331c4727ebbcd53cb75bf20430ad766ed025de521',N'admin');
    INSERT INTO dbo.[users] ([id],[name],[email],[phone],[birthday],[passwordHash],[role])
    VALUES (2,N'Nguyễn Hoàng An',N'hocvien@example.com',N'0901234567',NULL,N'4bd8ad92da5506828bd46338a9368ab9:1fd07f7b531f0b8519c51404111319950c304fecce3e5c727cd600c20cfede29b02f5491a6d5bb683780dc1d8c2595ae34b604546b1b5b9248f998bda14fab47',N'student');
    SET IDENTITY_INSERT dbo.[users] OFF;

    -- courses: 37 bản ghi
    SET IDENTITY_INSERT dbo.[courses] ON;
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (1,N'IELTS Foundation',N'IELTS',N'A2 – B1',12,3500000,24,N'Từ 16 tuổi',N'/images/ielts.jpg',N'Xây nền tảng vững chắc, chinh phục mục tiêu IELTS đầu tiên. Phát triển đồng đều bốn kỹ năng với lộ trình cá nhân và phản hồi sau mỗi buổi học.',N'Tuần 1: Present simple & present continuous. Viết một đoạn 100 từ giới thiệu bản thân.
Tuần 2: Đọc một bài báo ngắn, ghi lại 10 từ mới và đặt câu.
Tuần 3: Luyện mô tả biểu đồ đường và cách diễn đạt xu hướng.',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (2,N'Tiếng Anh giao tiếp',N'Giao tiếp',N'A2 – B1',10,2800000,20,N'Từ 16 tuổi',N'/images/adults.jpg',N'Tự tin mở lời trong những tình huống đời thường. Học qua thảo luận, đóng vai và các dự án thực tế trong một lớp học luôn khuyến khích bạn lên tiếng.',N'Chủ đề 1: Introduce yourself.
Chủ đề 2: Ordering food — thực hành hội thoại với bạn học.
Chủ đề 3: Giving directions — mô tả đường từ nhà đến trường.',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (3,N'Tiếng Anh trẻ em',N'Trẻ em',N'Pre-A1 – A1',12,3200000,24,N'6 – 11 tuổi',N'/images/kids.jpg',N'Nuôi dưỡng niềm yêu thích tiếng Anh qua câu chuyện, trò chơi và hoạt động sáng tạo. Giúp con tự tin khám phá thế giới theo cách của riêng mình.',N'Ôn tập từ vựng: colors, animals, family.
Vẽ gia đình và giới thiệu từng thành viên bằng tiếng Anh.',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (4,N'Tiếng Anh thiếu niên',N'Thiếu niên',N'A1 – B1',12,3300000,24,N'12 – 15 tuổi',N'/images/teens.jpg',N'Phát triển tư duy, kỹ năng thuyết trình và sự tự tin. Chương trình kết hợp kiến thức học đường với những dự án gần gũi với tuổi teen.',N'Dự án: My green school. Chuẩn bị bài thuyết trình 3 phút về một ý tưởng bảo vệ môi trường.',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (5,N'Tiếng Anh căn bản',N'Căn bản',N'A1',8,2200000,16,N'Người mới bắt đầu',N'/images/basics.jpg',N'Bắt đầu lại từ những điều đơn giản nhất. Nắm chắc phát âm, từ vựng và ngữ pháp thiết yếu với tốc độ học vừa sức và sự hỗ trợ sát sao.',N'Học bảng phiên âm cơ bản.
Ôn động từ to be; viết 10 câu với I am, You are, She is.',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (6,N'English for Work',N'Đi làm',N'B1 – B2',10,3800000,20,N'Sinh viên & người đi làm',N'/images/work.jpg',N'Để tiếng Anh trở thành lợi thế nghề nghiệp. Thực hành viết email, phỏng vấn, thuyết trình và làm việc cùng đồng nghiệp quốc tế.',N'Viết email ứng tuyển 150 từ.
Chuẩn bị câu trả lời: Tell me about yourself.
Thực hành cách lên lịch họp qua email.',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (7,N'TOEIC 650+',N'TOEIC',N'A2 – B1',12,3600000,24,N'Sinh viên & người đi làm',N'/images/work.jpg',N'Củng cố ngữ pháp, từ vựng công sở và kỹ năng nghe, đọc theo định dạng TOEIC Listening & Reading. Mục tiêu 650+ được điều chỉnh sau kiểm tra đầu vào, không phải cam kết điểm thi.',N'Tuần 1–4: ngữ pháp nền tảng và từ vựng công sở.
Tuần 5–8: luyện nghe hội thoại, đọc email và thông báo.
Tuần 9–12: luyện đề theo thời gian và phân tích lỗi.',N'en');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (8,N'Tiếng Trung nhập môn',N'Căn bản',N'Nhập môn',12,2600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-zh.svg',N'Làm quen âm, chữ viết và từ vựng tiếng trung. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 你好.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'zh');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (9,N'Tiếng Trung giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-zh.svg',N'Thực hành tiếng trung trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 你好.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'zh');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (10,N'Tiếng Hàn nhập môn',N'Căn bản',N'Nhập môn',12,2800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ko.svg',N'Làm quen âm, chữ viết và từ vựng tiếng hàn. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 안녕하세요.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ko');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (11,N'Tiếng Hàn giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ko.svg',N'Thực hành tiếng hàn trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 안녕하세요.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ko');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (12,N'Tiếng Nhật nhập môn',N'Căn bản',N'Nhập môn',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ja.svg',N'Làm quen âm, chữ viết và từ vựng tiếng nhật. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào こんにちは.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ja');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (13,N'Tiếng Nhật giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ja.svg',N'Thực hành tiếng nhật trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào こんにちは.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ja');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (14,N'Tiếng Pháp nhập môn',N'Căn bản',N'Nhập môn',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-fr.svg',N'Làm quen âm, chữ viết và từ vựng tiếng pháp. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Bonjour.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'fr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (15,N'Tiếng Pháp giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-fr.svg',N'Thực hành tiếng pháp trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Bonjour.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'fr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (16,N'Tiếng Đức nhập môn',N'Căn bản',N'Nhập môn',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-de.svg',N'Làm quen âm, chữ viết và từ vựng tiếng đức. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hallo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'de');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (17,N'Tiếng Đức giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-de.svg',N'Thực hành tiếng đức trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hallo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'de');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (18,N'Tiếng Ý nhập môn',N'Căn bản',N'Nhập môn',12,2600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-it.svg',N'Làm quen âm, chữ viết và từ vựng tiếng ý. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Ciao.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'it');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (19,N'Tiếng Ý giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-it.svg',N'Thực hành tiếng ý trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Ciao.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'it');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (20,N'Tiếng Tây Ban Nha nhập môn',N'Căn bản',N'Nhập môn',12,2800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-es.svg',N'Làm quen âm, chữ viết và từ vựng tiếng tây ban nha. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hola.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'es');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (21,N'Tiếng Tây Ban Nha giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-es.svg',N'Thực hành tiếng tây ban nha trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hola.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'es');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (22,N'Tiếng Bồ Đào Nha nhập môn',N'Căn bản',N'Nhập môn',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-pt.svg',N'Làm quen âm, chữ viết và từ vựng tiếng bồ đào nha. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Olá.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'pt');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (23,N'Tiếng Bồ Đào Nha giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-pt.svg',N'Thực hành tiếng bồ đào nha trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Olá.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'pt');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (24,N'Tiếng Nga nhập môn',N'Căn bản',N'Nhập môn',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ru.svg',N'Làm quen âm, chữ viết và từ vựng tiếng nga. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Здравствуйте.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ru');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (25,N'Tiếng Nga giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ru.svg',N'Thực hành tiếng nga trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Здравствуйте.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ru');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (26,N'Tiếng Ả Rập nhập môn',N'Căn bản',N'Nhập môn',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ar.svg',N'Làm quen âm, chữ viết và từ vựng tiếng ả rập. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào مرحبا.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ar');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (27,N'Tiếng Ả Rập giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ar.svg',N'Thực hành tiếng ả rập trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào مرحبا.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ar');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (28,N'Tiếng Hindi nhập môn',N'Căn bản',N'Nhập môn',12,2600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-hi.svg',N'Làm quen âm, chữ viết và từ vựng tiếng hindi. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào नमस्ते.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'hi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (29,N'Tiếng Hindi giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-hi.svg',N'Thực hành tiếng hindi trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào नमस्ते.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'hi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (30,N'Tiếng Thái nhập môn',N'Căn bản',N'Nhập môn',12,2800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-th.svg',N'Làm quen âm, chữ viết và từ vựng tiếng thái. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào สวัสดี.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'th');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (31,N'Tiếng Thái giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-th.svg',N'Thực hành tiếng thái trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào สวัสดี.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'th');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (32,N'Tiếng Indonesia nhập môn',N'Căn bản',N'Nhập môn',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-id.svg',N'Làm quen âm, chữ viết và từ vựng tiếng indonesia. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Halo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'id');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (33,N'Tiếng Indonesia giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-id.svg',N'Thực hành tiếng indonesia trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Halo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'id');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (34,N'Tiếng Việt nhập môn',N'Căn bản',N'Nhập môn',12,3200000,24,N'Người nước ngoài học tiếng Việt',N'/images/language-vi.svg',N'Làm quen âm, chữ viết và từ vựng tiếng việt. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Xin chào.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'vi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (35,N'Tiếng Việt giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3600000,24,N'Người nước ngoài học tiếng Việt',N'/images/language-vi.svg',N'Thực hành tiếng việt trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Xin chào.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'vi');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (36,N'Tiếng Thổ Nhĩ Kỳ nhập môn',N'Căn bản',N'Nhập môn',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-tr.svg',N'Làm quen âm, chữ viết và từ vựng tiếng thổ nhĩ kỳ. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Merhaba.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'tr');
    INSERT INTO dbo.[courses] ([id],[name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language])
    VALUES (37,N'Tiếng Thổ Nhĩ Kỳ giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-tr.svg',N'Thực hành tiếng thổ nhĩ kỳ trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Merhaba.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'tr');
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

    -- classes: 116 bản ghi
    SET IDENTITY_INSERT dbo.[classes] ON;
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (1,1,1,N'IELTS-F01',N'2026-11-13',N'2027-02-17',N'Thứ 2, Thứ 4 · 18:30 – 20:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:30',N'20:30',N'',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (2,2,2,N'GT-02',N'2026-11-16',N'2027-02-20',N'Thứ 3, Thứ 5 · 19:00 – 21:00',N'Cơ sở Nguyễn Văn Cừ',18,N'[2,4]',N'19:00',N'21:00',N'',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (3,3,3,N'KIDS-03',N'2026-11-19',N'2027-02-23',N'Thứ 2, Thứ 4 · 18:30 – 20:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:30',N'20:30',N'',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (4,4,3,N'TEEN-04',N'2026-11-22',N'2027-02-26',N'Thứ 3, Thứ 5 · 19:00 – 21:00',N'Cơ sở Nguyễn Văn Cừ',18,N'[2,4]',N'19:00',N'21:00',N'',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (5,5,1,N'CB-05',N'2026-11-25',N'2027-03-01',N'Thứ 2, Thứ 4 · 16:00 – 18:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'16:00',N'18:00',N'',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (6,6,2,N'WORK-06',N'2026-11-28',N'2027-03-04',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Nguyễn Văn Cừ',18,N'[6,7]',N'08:00',N'10:00',N'',N'enrolling');
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
    VALUES (19,4,3,N'TEEN-OPT-TOI',N'2026-11-13',N'2027-01-31',N'Thứ 6, Chủ nhật · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[5,7]',N'18:30',N'20:00',N'102',N'enrolling');
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
    VALUES (25,6,2,N'WORK-OPT-TOI',N'2026-11-13',N'2027-01-17',N'Thứ 6, Chủ nhật · 19:00 – 21:00',N'Cơ sở Nguyễn Văn Cừ',18,N'[5,7]',N'19:00',N'21:00',N'102',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (26,6,2,N'WORK-OPT-SANG-CN',N'2026-11-14',N'2027-01-17',N'Thứ 7, Chủ nhật · 10:30 – 12:30',N'Cơ sở Nguyễn Văn Cừ',18,N'[6,7]',N'10:30',N'12:30',N'102',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (27,8,10,N'ZH-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (28,8,10,N'ZH-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (29,8,10,N'ZH-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (30,9,10,N'ZH-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (31,9,10,N'ZH-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (32,9,10,N'ZH-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN1',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (33,10,11,N'KO-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (34,10,11,N'KO-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (35,10,11,N'KO-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (36,11,11,N'KO-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (37,11,11,N'KO-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (38,11,11,N'KO-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN2',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (39,12,12,N'JA-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (40,12,12,N'JA-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (41,12,12,N'JA-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (42,13,12,N'JA-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (43,13,12,N'JA-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (44,13,12,N'JA-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN3',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (45,14,13,N'FR-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (46,14,13,N'FR-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (47,14,13,N'FR-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (48,15,13,N'FR-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (49,15,13,N'FR-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (50,15,13,N'FR-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN4',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (51,16,14,N'DE-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (52,16,14,N'DE-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (53,16,14,N'DE-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (54,17,14,N'DE-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (55,17,14,N'DE-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (56,17,14,N'DE-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN5',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (57,18,15,N'IT-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (58,18,15,N'IT-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (59,18,15,N'IT-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (60,19,15,N'IT-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (61,19,15,N'IT-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (62,19,15,N'IT-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN6',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (63,20,16,N'ES-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (64,20,16,N'ES-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (65,20,16,N'ES-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (66,21,16,N'ES-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (67,21,16,N'ES-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (68,21,16,N'ES-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN7',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (69,22,17,N'PT-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (70,22,17,N'PT-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (71,22,17,N'PT-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (72,23,17,N'PT-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (73,23,17,N'PT-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (74,23,17,N'PT-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN8',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (75,24,18,N'RU-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (76,24,18,N'RU-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (77,24,18,N'RU-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (78,25,18,N'RU-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (79,25,18,N'RU-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (80,25,18,N'RU-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN9',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (81,26,19,N'AR-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (82,26,19,N'AR-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (83,26,19,N'AR-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (84,27,19,N'AR-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (85,27,19,N'AR-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (86,27,19,N'AR-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN10',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (87,28,20,N'HI-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (88,28,20,N'HI-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (89,28,20,N'HI-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (90,29,20,N'HI-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (91,29,20,N'HI-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (92,29,20,N'HI-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN11',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (93,30,21,N'TH-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (94,30,21,N'TH-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (95,30,21,N'TH-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (96,31,21,N'TH-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (97,31,21,N'TH-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (98,31,21,N'TH-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN12',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (99,32,22,N'ID-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (100,32,22,N'ID-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (101,32,22,N'ID-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (102,33,22,N'ID-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (103,33,22,N'ID-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (104,33,22,N'ID-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN13',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (105,34,23,N'VI-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (106,34,23,N'VI-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (107,34,23,N'VI-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (108,35,23,N'VI-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (109,35,23,N'VI-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (110,35,23,N'VI-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN14',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (111,36,24,N'TR-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN15',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (112,36,24,N'TR-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN15',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (113,36,24,N'TR-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN15',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (114,37,24,N'TR-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN15',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (115,37,24,N'TR-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN15',N'enrolling');
    INSERT INTO dbo.[classes] ([id],[courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status])
    VALUES (116,37,24,N'TR-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN15',N'enrolling');
    SET IDENTITY_INSERT dbo.[classes] OFF;

    -- enrollments: 1 bản ghi
    SET IDENTITY_INSERT dbo.[enrollments] ON;
    INSERT INTO dbo.[enrollments] ([id],[userId],[classId],[name],[email],[phone],[birthday],[note],[status],[grades],[createdAt],[verifiedAt],[verifiedBy])
    VALUES (1,2,1,N'Nguyễn Hoàng An',N'hocvien@example.com',N'0901234567',NULL,N'',N'confirmed',N'{"listening":7,"reading":8,"writing":6.5,"speaking":7}',N'2026-10-30 03:18:32',NULL,NULL);
    SET IDENTITY_INSERT dbo.[enrollments] OFF;

    -- questions: 175 bản ghi
    SET IDENTITY_INSERT dbo.[questions] ON;
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (1,N'She _____ to school every day.',N'["go","goes","going","gone"]',1,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (2,N'There _____ a book on the table.',N'["are","be","is","am"]',2,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (3,N'I have lived here _____ 2020.',N'["for","since","at","during"]',1,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (4,N'They _____ football yesterday.',N'["play","plays","played","playing"]',2,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (5,N'This bag is _____ than that one.',N'["heavy","heaviest","more heavy","heavier"]',3,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (6,N'We do not have _____ milk left.',N'["some","any","many","a"]',1,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (7,N'If it rains, we _____ at home.',N'["stayed","would stay","will stay","staying"]',2,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (8,N'The book _____ by a young author last year.',N'["wrote","was written","writes","is writing"]',1,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (9,N'I enjoy _____ new languages.',N'["learn","to learning","learning","learned"]',2,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (10,N'You _____ wear a helmet when riding a motorbike.',N'["must","might","would","could have"]',0,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (11,N'By the time we arrived, the film _____.',N'["starts","has started","had started","starting"]',2,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (12,N'The woman _____ lives next door is a teacher.',N'["which","who","where","whose"]',1,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (13,N'Despite _____ tired, he finished his work.',N'["be","was","being","been"]',2,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (14,N'If I _____ you, I would take the opportunity.',N'["am","was being","were","have been"]',2,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (15,N'The word “reliable” is closest in meaning to _____.',N'["expensive","dependable","creative","unusual"]',1,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (16,N'Please send the report _____ Friday.',N'["by","onward","during","within"]',0,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (17,N'The train was delayed, _____ we arrived late.',N'["because","so","although","unless"]',1,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (18,N'Could you _____ me your pen for a moment?',N'["borrow","owe","lend","rent"]',2,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (19,N'This is the restaurant _____ we had lunch.',N'["which","who","whose","where"]',3,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (20,N'The instructions were clear enough for everyone _____.',N'["understand","understood","to understand","understanding"]',2,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (21,N'Neither of the answers _____ correct.',N'["is","are","be","being"]',0,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (22,N'We look forward to _____ you next week.',N'["meet","meeting","met","have met"]',1,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (23,N'The meeting has been postponed. It will take place _____.',N'["earlier","never","at the same time","later"]',3,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (24,N'Notice: The library closes at 5 p.m. today. When must visitors leave?',N'["Before 5 a.m.","After 6 p.m.","By 5 p.m.","Tomorrow morning"]',2,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (25,N'Email: Please confirm your attendance by replying to this message. What should the reader do?',N'["Send a reply","Cancel the event","Call a taxi","Print a receipt"]',0,N'en');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (26,N'Tiếng Trung: “你好” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (27,N'Tiếng Trung: “谢谢” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (28,N'Tiếng Trung: “水” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (29,N'Tiếng Trung: “书” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (30,N'Tiếng Trung: “家” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (31,N'Tiếng Trung: “一” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (32,N'Tiếng Trung: “二” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (33,N'Tiếng Trung: “三” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (34,N'Tiếng Trung: “猫” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (35,N'Tiếng Trung: “狗” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'zh');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (36,N'Tiếng Hàn: “안녕하세요” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (37,N'Tiếng Hàn: “감사합니다” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (38,N'Tiếng Hàn: “물” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (39,N'Tiếng Hàn: “책” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (40,N'Tiếng Hàn: “집” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (41,N'Tiếng Hàn: “하나” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (42,N'Tiếng Hàn: “둘” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (43,N'Tiếng Hàn: “셋” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (44,N'Tiếng Hàn: “고양이” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (45,N'Tiếng Hàn: “개” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'ko');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (46,N'Tiếng Nhật: “こんにちは” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (47,N'Tiếng Nhật: “ありがとう” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (48,N'Tiếng Nhật: “水” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (49,N'Tiếng Nhật: “本” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (50,N'Tiếng Nhật: “家” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (51,N'Tiếng Nhật: “一” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (52,N'Tiếng Nhật: “二” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (53,N'Tiếng Nhật: “三” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (54,N'Tiếng Nhật: “猫” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (55,N'Tiếng Nhật: “犬” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'ja');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (56,N'Tiếng Pháp: “Bonjour” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (57,N'Tiếng Pháp: “Merci” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (58,N'Tiếng Pháp: “eau” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (59,N'Tiếng Pháp: “livre” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (60,N'Tiếng Pháp: “maison” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (61,N'Tiếng Pháp: “un” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (62,N'Tiếng Pháp: “deux” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (63,N'Tiếng Pháp: “trois” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (64,N'Tiếng Pháp: “chat” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (65,N'Tiếng Pháp: “chien” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'fr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (66,N'Tiếng Đức: “Hallo” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (67,N'Tiếng Đức: “Danke” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (68,N'Tiếng Đức: “Wasser” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (69,N'Tiếng Đức: “Buch” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (70,N'Tiếng Đức: “Haus” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (71,N'Tiếng Đức: “eins” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (72,N'Tiếng Đức: “zwei” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (73,N'Tiếng Đức: “drei” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (74,N'Tiếng Đức: “Katze” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (75,N'Tiếng Đức: “Hund” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'de');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (76,N'Tiếng Ý: “Ciao” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (77,N'Tiếng Ý: “Grazie” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (78,N'Tiếng Ý: “acqua” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (79,N'Tiếng Ý: “libro” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (80,N'Tiếng Ý: “casa” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (81,N'Tiếng Ý: “uno” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (82,N'Tiếng Ý: “due” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (83,N'Tiếng Ý: “tre” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (84,N'Tiếng Ý: “gatto” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (85,N'Tiếng Ý: “cane” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'it');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (86,N'Tiếng Tây Ban Nha: “Hola” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (87,N'Tiếng Tây Ban Nha: “Gracias” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (88,N'Tiếng Tây Ban Nha: “agua” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (89,N'Tiếng Tây Ban Nha: “libro” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (90,N'Tiếng Tây Ban Nha: “casa” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (91,N'Tiếng Tây Ban Nha: “uno” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (92,N'Tiếng Tây Ban Nha: “dos” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (93,N'Tiếng Tây Ban Nha: “tres” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (94,N'Tiếng Tây Ban Nha: “gato” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (95,N'Tiếng Tây Ban Nha: “perro” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'es');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (96,N'Tiếng Bồ Đào Nha: “Olá” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (97,N'Tiếng Bồ Đào Nha: “Obrigado” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (98,N'Tiếng Bồ Đào Nha: “água” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (99,N'Tiếng Bồ Đào Nha: “livro” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (100,N'Tiếng Bồ Đào Nha: “casa” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (101,N'Tiếng Bồ Đào Nha: “um” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (102,N'Tiếng Bồ Đào Nha: “dois” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (103,N'Tiếng Bồ Đào Nha: “três” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (104,N'Tiếng Bồ Đào Nha: “gato” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (105,N'Tiếng Bồ Đào Nha: “cachorro” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'pt');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (106,N'Tiếng Nga: “Здравствуйте” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (107,N'Tiếng Nga: “Спасибо” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (108,N'Tiếng Nga: “вода” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (109,N'Tiếng Nga: “книга” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (110,N'Tiếng Nga: “дом” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (111,N'Tiếng Nga: “один” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (112,N'Tiếng Nga: “два” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (113,N'Tiếng Nga: “три” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (114,N'Tiếng Nga: “кошка” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (115,N'Tiếng Nga: “собака” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'ru');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (116,N'Tiếng Ả Rập: “مرحبا” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (117,N'Tiếng Ả Rập: “شكرا” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (118,N'Tiếng Ả Rập: “ماء” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (119,N'Tiếng Ả Rập: “كتاب” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (120,N'Tiếng Ả Rập: “بيت” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (121,N'Tiếng Ả Rập: “واحد” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (122,N'Tiếng Ả Rập: “اثنان” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (123,N'Tiếng Ả Rập: “ثلاثة” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (124,N'Tiếng Ả Rập: “قطة” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (125,N'Tiếng Ả Rập: “كلب” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'ar');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (126,N'Tiếng Hindi: “नमस्ते” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (127,N'Tiếng Hindi: “धन्यवाद” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (128,N'Tiếng Hindi: “पानी” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (129,N'Tiếng Hindi: “किताब” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (130,N'Tiếng Hindi: “घर” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (131,N'Tiếng Hindi: “एक” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (132,N'Tiếng Hindi: “दो” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (133,N'Tiếng Hindi: “तीन” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (134,N'Tiếng Hindi: “बिल्ली” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (135,N'Tiếng Hindi: “कुत्ता” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'hi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (136,N'Tiếng Thái: “สวัสดี” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (137,N'Tiếng Thái: “ขอบคุณ” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (138,N'Tiếng Thái: “น้ำ” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (139,N'Tiếng Thái: “หนังสือ” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (140,N'Tiếng Thái: “บ้าน” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (141,N'Tiếng Thái: “หนึ่ง” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (142,N'Tiếng Thái: “สอง” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (143,N'Tiếng Thái: “สาม” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (144,N'Tiếng Thái: “แมว” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (145,N'Tiếng Thái: “สุนัข” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'th');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (146,N'Tiếng Indonesia: “Halo” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (147,N'Tiếng Indonesia: “Terima kasih” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (148,N'Tiếng Indonesia: “air” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (149,N'Tiếng Indonesia: “buku” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (150,N'Tiếng Indonesia: “rumah” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (151,N'Tiếng Indonesia: “satu” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (152,N'Tiếng Indonesia: “dua” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (153,N'Tiếng Indonesia: “tiga” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (154,N'Tiếng Indonesia: “kucing” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (155,N'Tiếng Indonesia: “anjing” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'id');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (156,N'Tiếng Việt: “xin chào” có nghĩa là gì trong tiếng Anh?',N'["hello","thank you","water","book"]',0,N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (157,N'Tiếng Việt: “cảm ơn” có nghĩa là gì trong tiếng Anh?',N'["water","thank you","book","house"]',1,N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (158,N'Tiếng Việt: “nước” có nghĩa là gì trong tiếng Anh?',N'["house","book","water","one"]',2,N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (159,N'Tiếng Việt: “sách” có nghĩa là gì trong tiếng Anh?',N'["two","house","one","book"]',3,N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (160,N'Tiếng Việt: “nhà” có nghĩa là gì trong tiếng Anh?',N'["house","one","two","three"]',0,N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (161,N'Tiếng Việt: “một” có nghĩa là gì trong tiếng Anh?',N'["two","one","three","cat"]',1,N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (162,N'Tiếng Việt: “hai” có nghĩa là gì trong tiếng Anh?',N'["cat","three","two","dog"]',2,N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (163,N'Tiếng Việt: “ba” có nghĩa là gì trong tiếng Anh?',N'["hello","cat","dog","three"]',3,N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (164,N'Tiếng Việt: “mèo” có nghĩa là gì trong tiếng Anh?',N'["cat","dog","hello","thank you"]',0,N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (165,N'Tiếng Việt: “chó” có nghĩa là gì trong tiếng Anh?',N'["hello","dog","thank you","water"]',1,N'vi');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (166,N'Tiếng Thổ Nhĩ Kỳ: “Merhaba” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (167,N'Tiếng Thổ Nhĩ Kỳ: “Teşekkürler” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (168,N'Tiếng Thổ Nhĩ Kỳ: “su” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (169,N'Tiếng Thổ Nhĩ Kỳ: “kitap” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (170,N'Tiếng Thổ Nhĩ Kỳ: “ev” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (171,N'Tiếng Thổ Nhĩ Kỳ: “bir” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (172,N'Tiếng Thổ Nhĩ Kỳ: “iki” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (173,N'Tiếng Thổ Nhĩ Kỳ: “üç” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (174,N'Tiếng Thổ Nhĩ Kỳ: “kedi” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'tr');
    INSERT INTO dbo.[questions] ([id],[prompt],[options],[answer],[language])
    VALUES (175,N'Tiếng Thổ Nhĩ Kỳ: “köpek” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'tr');
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
    PRINT N'Đã nhập dữ liệu mẫu: 16 ngôn ngữ, 37 khóa, 24 giáo viên, 116 lớp, 175 câu hỏi.';
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
