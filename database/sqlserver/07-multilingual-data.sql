/* Thêm 15 ngôn ngữ vào database cũ sau khi chạy 06.
Không dùng ID cố định; không ghi đè hồ sơ/khóa/lớp đã tồn tại.
Dữ liệu chương trình và giáo viên minh họa cho đồ án. */
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
SET XACT_ABORT ON;
IF EXISTS(SELECT 1 FROM dbo.metadata WHERE [key]=N'multilingual-v1')
BEGIN PRINT N'Đã nâng cấp đa ngôn ngữ; giữ dữ liệu hiện có.'; RETURN; END;
BEGIN TRY
BEGIN TRANSACTION;
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Lưu Minh Châu')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Lưu Minh Châu',N'Cử nhân Ngôn ngữ Trung',5,N'Pinyin, thanh điệu và hội thoại tiếng Trung',N'/images/teacher4.svg',N'Giáo viên tiếng trung đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng trung nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["zh"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Nguyễn Hà Yến',N'Cử nhân Ngôn ngữ Hàn',6,N'Hangul, phát âm và giao tiếp tiếng Hàn',N'/images/teacher5.svg',N'Giáo viên tiếng hàn đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng hàn nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["ko"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Phạm Nhật Minh')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Phạm Nhật Minh',N'Cử nhân Ngôn ngữ Nhật',7,N'Hiragana, Katakana và giao tiếp tiếng Nhật',N'/images/teacher6.svg',N'Giáo viên tiếng nhật đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng nhật nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["ja"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Lê Thanh Trúc')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Lê Thanh Trúc',N'Thạc sĩ Giảng dạy tiếng Pháp',8,N'Phát âm và giao tiếp tiếng Pháp',N'/images/teacher7.svg',N'Giáo viên tiếng pháp đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng pháp nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["fr"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Trần Đức Khang')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Trần Đức Khang',N'Cử nhân Ngôn ngữ Đức',9,N'Ngữ pháp nền tảng và giao tiếp tiếng Đức',N'/images/teacher8.svg',N'Giáo viên tiếng đức đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng đức nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["de"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Nguyễn Ý Nhi',N'Cử nhân Ngôn ngữ Ý',5,N'Phát âm và văn hóa giao tiếp tiếng Ý',N'/images/teacher9.svg',N'Giáo viên tiếng ý đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng ý nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["it"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Vũ Hoàng Mai',N'Cử nhân Ngôn ngữ Tây Ban Nha',6,N'Giao tiếp tiếng Tây Ban Nha',N'/images/teacher4.svg',N'Giáo viên tiếng tây ban nha đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng tây ban nha nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["es"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Đỗ Minh Tâm',N'Cử nhân Ngôn ngữ Bồ Đào Nha',7,N'Tiếng Bồ Đào Nha trong đời sống',N'/images/teacher5.svg',N'Giáo viên tiếng bồ đào nha đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng bồ đào nha nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["pt"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Bùi Ngọc Ánh',N'Cử nhân Ngôn ngữ Nga',8,N'Bảng chữ cái Cyrillic và hội thoại tiếng Nga',N'/images/teacher6.svg',N'Giáo viên tiếng nga đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng nga nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["ru"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Hoàng Minh Quân')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Hoàng Minh Quân',N'Cử nhân Ngôn ngữ Ả Rập',9,N'Chữ viết và tiếng Ả Rập tiêu chuẩn hiện đại',N'/images/teacher7.svg',N'Giáo viên tiếng ả rập đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng ả rập nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["ar"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Nguyễn An Bình')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Nguyễn An Bình',N'Cử nhân Ngôn ngữ Hindi',5,N'Devanagari và giao tiếp tiếng Hindi',N'/images/teacher8.svg',N'Giáo viên tiếng hindi đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng hindi nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["hi"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Trịnh Thảo Vy',N'Cử nhân Ngôn ngữ Thái',6,N'Thanh điệu và giao tiếp tiếng Thái',N'/images/teacher9.svg',N'Giáo viên tiếng thái đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng thái nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["th"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Phan Gia Hân')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Phan Gia Hân',N'Cử nhân Ngôn ngữ Indonesia',7,N'Bahasa Indonesia cho du lịch và công việc',N'/images/teacher4.svg',N'Giáo viên tiếng indonesia đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng indonesia nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["id"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Đặng Khánh Hòa',N'Thạc sĩ Việt Nam học',8,N'Tiếng Việt cho người nước ngoài',N'/images/teacher5.svg',N'Giáo viên tiếng việt đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng việt nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["vi"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt')
INSERT INTO dbo.teachers ([name],[degree],[experience],[specialty],[image],[description],[achievements],[languages],[nationality]) VALUES (N'Trần Tuấn Kiệt',N'Cử nhân Ngôn ngữ Thổ Nhĩ Kỳ',9,N'Giao tiếp tiếng Thổ Nhĩ Kỳ',N'/images/teacher6.svg',N'Giáo viên tiếng thổ nhĩ kỳ đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.',N'Biên soạn học liệu tiếng thổ nhĩ kỳ nhập môn
Thiết kế bộ hội thoại theo tình huống đời sống
Phụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa',N'["tr"]',N'Việt Nam');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'zh' AND name=N'Tiếng Trung nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Trung nhập môn',N'Căn bản',N'Nhập môn',12,2600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-zh.svg',N'Làm quen âm, chữ viết và từ vựng tiếng trung. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 你好.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'zh' AND name=N'Tiếng Trung giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Trung giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-zh.svg',N'Thực hành tiếng trung trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 你好.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ko' AND name=N'Tiếng Hàn nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Hàn nhập môn',N'Căn bản',N'Nhập môn',12,2800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ko.svg',N'Làm quen âm, chữ viết và từ vựng tiếng hàn. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 안녕하세요.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ko' AND name=N'Tiếng Hàn giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Hàn giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ko.svg',N'Thực hành tiếng hàn trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào 안녕하세요.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ja' AND name=N'Tiếng Nhật nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Nhật nhập môn',N'Căn bản',N'Nhập môn',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ja.svg',N'Làm quen âm, chữ viết và từ vựng tiếng nhật. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào こんにちは.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ja' AND name=N'Tiếng Nhật giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Nhật giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ja.svg',N'Thực hành tiếng nhật trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào こんにちは.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'fr' AND name=N'Tiếng Pháp nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Pháp nhập môn',N'Căn bản',N'Nhập môn',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-fr.svg',N'Làm quen âm, chữ viết và từ vựng tiếng pháp. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Bonjour.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'fr' AND name=N'Tiếng Pháp giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Pháp giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-fr.svg',N'Thực hành tiếng pháp trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Bonjour.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'de' AND name=N'Tiếng Đức nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Đức nhập môn',N'Căn bản',N'Nhập môn',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-de.svg',N'Làm quen âm, chữ viết và từ vựng tiếng đức. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hallo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'de' AND name=N'Tiếng Đức giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Đức giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-de.svg',N'Thực hành tiếng đức trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hallo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'it' AND name=N'Tiếng Ý nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Ý nhập môn',N'Căn bản',N'Nhập môn',12,2600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-it.svg',N'Làm quen âm, chữ viết và từ vựng tiếng ý. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Ciao.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'it' AND name=N'Tiếng Ý giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Ý giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-it.svg',N'Thực hành tiếng ý trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Ciao.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'es' AND name=N'Tiếng Tây Ban Nha nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Tây Ban Nha nhập môn',N'Căn bản',N'Nhập môn',12,2800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-es.svg',N'Làm quen âm, chữ viết và từ vựng tiếng tây ban nha. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hola.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'es' AND name=N'Tiếng Tây Ban Nha giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Tây Ban Nha giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-es.svg',N'Thực hành tiếng tây ban nha trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Hola.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'pt' AND name=N'Tiếng Bồ Đào Nha nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Bồ Đào Nha nhập môn',N'Căn bản',N'Nhập môn',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-pt.svg',N'Làm quen âm, chữ viết và từ vựng tiếng bồ đào nha. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Olá.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'pt' AND name=N'Tiếng Bồ Đào Nha giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Bồ Đào Nha giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-pt.svg',N'Thực hành tiếng bồ đào nha trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Olá.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ru' AND name=N'Tiếng Nga nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Nga nhập môn',N'Căn bản',N'Nhập môn',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ru.svg',N'Làm quen âm, chữ viết và từ vựng tiếng nga. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Здравствуйте.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ru' AND name=N'Tiếng Nga giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Nga giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ru.svg',N'Thực hành tiếng nga trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Здравствуйте.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ar' AND name=N'Tiếng Ả Rập nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Ả Rập nhập môn',N'Căn bản',N'Nhập môn',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ar.svg',N'Làm quen âm, chữ viết và từ vựng tiếng ả rập. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào مرحبا.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ar' AND name=N'Tiếng Ả Rập giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Ả Rập giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-ar.svg',N'Thực hành tiếng ả rập trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào مرحبا.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'hi' AND name=N'Tiếng Hindi nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Hindi nhập môn',N'Căn bản',N'Nhập môn',12,2600000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-hi.svg',N'Làm quen âm, chữ viết và từ vựng tiếng hindi. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào नमस्ते.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'hi' AND name=N'Tiếng Hindi giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Hindi giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-hi.svg',N'Thực hành tiếng hindi trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào नमस्ते.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'th' AND name=N'Tiếng Thái nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Thái nhập môn',N'Căn bản',N'Nhập môn',12,2800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-th.svg',N'Làm quen âm, chữ viết và từ vựng tiếng thái. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào สวัสดี.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'th' AND name=N'Tiếng Thái giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Thái giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3200000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-th.svg',N'Thực hành tiếng thái trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào สวัสดี.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'id' AND name=N'Tiếng Indonesia nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Indonesia nhập môn',N'Căn bản',N'Nhập môn',12,3000000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-id.svg',N'Làm quen âm, chữ viết và từ vựng tiếng indonesia. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Halo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'id' AND name=N'Tiếng Indonesia giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Indonesia giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-id.svg',N'Thực hành tiếng indonesia trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Halo.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'vi' AND name=N'Tiếng Việt nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Việt nhập môn',N'Căn bản',N'Nhập môn',12,3200000,24,N'Người nước ngoài học tiếng Việt',N'/images/language-vi.svg',N'Làm quen âm, chữ viết và từ vựng tiếng việt. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Xin chào.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'vi' AND name=N'Tiếng Việt giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Việt giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3600000,24,N'Người nước ngoài học tiếng Việt',N'/images/language-vi.svg',N'Thực hành tiếng việt trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Xin chào.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'tr' AND name=N'Tiếng Thổ Nhĩ Kỳ nhập môn')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ nhập môn',N'Căn bản',N'Nhập môn',12,3400000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-tr.svg',N'Làm quen âm, chữ viết và từ vựng tiếng thổ nhĩ kỳ. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Merhaba.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'tr' AND name=N'Tiếng Thổ Nhĩ Kỳ giao tiếp')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ giao tiếp',N'Giao tiếp',N'Sơ cấp',12,3800000,24,N'Từ 16 tuổi · Sinh viên & người đi làm',N'/images/language-tr.svg',N'Thực hành tiếng thổ nhĩ kỳ trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.',N'Tuần 1–4: Phát âm, chữ viết và lời chào Merhaba.
Tuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.
Tuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung nhập môn' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung nhập môn' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung nhập môn' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung giao tiếp' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung giao tiếp' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung giao tiếp' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn nhập môn' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn nhập môn' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn nhập môn' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn giao tiếp' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn giao tiếp' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn giao tiếp' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật nhập môn' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật nhập môn' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật nhập môn' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật giao tiếp' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật giao tiếp' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật giao tiếp' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp nhập môn' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp nhập môn' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp nhập môn' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp giao tiếp' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp giao tiếp' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp giao tiếp' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức nhập môn' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức nhập môn' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức nhập môn' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức giao tiếp' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức giao tiếp' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức giao tiếp' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý nhập môn' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý nhập môn' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý nhập môn' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý giao tiếp' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý giao tiếp' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý giao tiếp' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha nhập môn' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN7',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha nhập môn' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN7',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha nhập môn' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN7',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha giao tiếp' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN7',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha giao tiếp' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN7',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha giao tiếp' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN7',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha nhập môn' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN8',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha nhập môn' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN8',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha nhập môn' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN8',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha giao tiếp' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN8',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha giao tiếp' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN8',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha giao tiếp' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN8',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga nhập môn' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN9',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga nhập môn' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN9',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga nhập môn' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN9',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga giao tiếp' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN9',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga giao tiếp' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN9',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga giao tiếp' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN9',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập nhập môn' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN10',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập nhập môn' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN10',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập nhập môn' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN10',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập giao tiếp' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN10',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập giao tiếp' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN10',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập giao tiếp' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN10',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi nhập môn' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN11',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi nhập môn' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN11',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi nhập môn' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN11',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi giao tiếp' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN11',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi giao tiếp' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN11',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi giao tiếp' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN11',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái nhập môn' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN12',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái nhập môn' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN12',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái nhập môn' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN12',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái giao tiếp' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN12',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái giao tiếp' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN12',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái giao tiếp' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN12',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia nhập môn' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN13',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia nhập môn' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN13',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia nhập môn' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN13',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia giao tiếp' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN13',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia giao tiếp' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN13',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia giao tiếp' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN13',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt nhập môn' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'08:00',N'09:30',N'NN14',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt nhập môn' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Quang Trung',18,N'[2,4]',N'18:30',N'20:00',N'NN14',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt nhập môn' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Quang Trung',18,N'[6,7]',N'08:00',N'10:00',N'NN14',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt giao tiếp' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Quang Trung',18,N'[1,3]',N'10:00',N'11:30',N'NN14',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt giao tiếp' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Quang Trung',18,N'[2,4]',N'20:00',N'21:30',N'NN14',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt giao tiếp' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Quang Trung',18,N'[6,7]',N'10:15',N'12:15',N'NN14',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-CB-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ nhập môn' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-CB-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'NN15',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-CB-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ nhập môn' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-CB-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 18:30 – 20:00',N'Cơ sở Lê Lợi',18,N'[2,4]',N'18:30',N'20:00',N'NN15',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-CB-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ nhập môn' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-CB-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 08:00 – 10:00',N'Cơ sở Lê Lợi',18,N'[6,7]',N'08:00',N'10:00',N'NN15',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-GT-SANG')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ giao tiếp' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-GT-SANG',N'2026-11-13',N'2027-02-05',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'NN15',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-GT-TOI')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ giao tiếp' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-GT-TOI',N'2026-11-13',N'2027-02-05',N'Thứ 3, Thứ 5 · 20:00 – 21:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'20:00',N'21:30',N'NN15',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-GT-CUOITUAN')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ giao tiếp' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-GT-CUOITUAN',N'2026-11-13',N'2027-02-05',N'Thứ 7, Chủ nhật · 10:15 – 12:15',N'Cơ sở Lê Lợi',18,N'[6,7]',N'10:15',N'12:15',N'NN15',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND prompt=N'Tiếng Trung: “你好” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Trung: “你好” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND prompt=N'Tiếng Trung: “谢谢” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Trung: “谢谢” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND prompt=N'Tiếng Trung: “水” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Trung: “水” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND prompt=N'Tiếng Trung: “书” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Trung: “书” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND prompt=N'Tiếng Trung: “家” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Trung: “家” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND prompt=N'Tiếng Trung: “一” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Trung: “一” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND prompt=N'Tiếng Trung: “二” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Trung: “二” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND prompt=N'Tiếng Trung: “三” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Trung: “三” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND prompt=N'Tiếng Trung: “猫” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Trung: “猫” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND prompt=N'Tiếng Trung: “狗” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Trung: “狗” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND prompt=N'Tiếng Hàn: “안녕하세요” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hàn: “안녕하세요” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND prompt=N'Tiếng Hàn: “감사합니다” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hàn: “감사합니다” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND prompt=N'Tiếng Hàn: “물” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hàn: “물” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND prompt=N'Tiếng Hàn: “책” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hàn: “책” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND prompt=N'Tiếng Hàn: “집” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hàn: “집” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND prompt=N'Tiếng Hàn: “하나” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hàn: “하나” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND prompt=N'Tiếng Hàn: “둘” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hàn: “둘” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND prompt=N'Tiếng Hàn: “셋” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hàn: “셋” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND prompt=N'Tiếng Hàn: “고양이” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hàn: “고양이” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND prompt=N'Tiếng Hàn: “개” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hàn: “개” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND prompt=N'Tiếng Nhật: “こんにちは” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nhật: “こんにちは” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND prompt=N'Tiếng Nhật: “ありがとう” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nhật: “ありがとう” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND prompt=N'Tiếng Nhật: “水” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nhật: “水” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND prompt=N'Tiếng Nhật: “本” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nhật: “本” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND prompt=N'Tiếng Nhật: “家” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nhật: “家” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND prompt=N'Tiếng Nhật: “一” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nhật: “一” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND prompt=N'Tiếng Nhật: “二” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nhật: “二” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND prompt=N'Tiếng Nhật: “三” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nhật: “三” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND prompt=N'Tiếng Nhật: “猫” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nhật: “猫” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND prompt=N'Tiếng Nhật: “犬” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nhật: “犬” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND prompt=N'Tiếng Pháp: “Bonjour” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Pháp: “Bonjour” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND prompt=N'Tiếng Pháp: “Merci” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Pháp: “Merci” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND prompt=N'Tiếng Pháp: “eau” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Pháp: “eau” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND prompt=N'Tiếng Pháp: “livre” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Pháp: “livre” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND prompt=N'Tiếng Pháp: “maison” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Pháp: “maison” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND prompt=N'Tiếng Pháp: “un” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Pháp: “un” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND prompt=N'Tiếng Pháp: “deux” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Pháp: “deux” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND prompt=N'Tiếng Pháp: “trois” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Pháp: “trois” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND prompt=N'Tiếng Pháp: “chat” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Pháp: “chat” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND prompt=N'Tiếng Pháp: “chien” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Pháp: “chien” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND prompt=N'Tiếng Đức: “Hallo” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Đức: “Hallo” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND prompt=N'Tiếng Đức: “Danke” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Đức: “Danke” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND prompt=N'Tiếng Đức: “Wasser” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Đức: “Wasser” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND prompt=N'Tiếng Đức: “Buch” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Đức: “Buch” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND prompt=N'Tiếng Đức: “Haus” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Đức: “Haus” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND prompt=N'Tiếng Đức: “eins” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Đức: “eins” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND prompt=N'Tiếng Đức: “zwei” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Đức: “zwei” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND prompt=N'Tiếng Đức: “drei” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Đức: “drei” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND prompt=N'Tiếng Đức: “Katze” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Đức: “Katze” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND prompt=N'Tiếng Đức: “Hund” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Đức: “Hund” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND prompt=N'Tiếng Ý: “Ciao” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ý: “Ciao” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND prompt=N'Tiếng Ý: “Grazie” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ý: “Grazie” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND prompt=N'Tiếng Ý: “acqua” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ý: “acqua” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND prompt=N'Tiếng Ý: “libro” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ý: “libro” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND prompt=N'Tiếng Ý: “casa” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ý: “casa” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND prompt=N'Tiếng Ý: “uno” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ý: “uno” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND prompt=N'Tiếng Ý: “due” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ý: “due” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND prompt=N'Tiếng Ý: “tre” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ý: “tre” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND prompt=N'Tiếng Ý: “gatto” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ý: “gatto” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND prompt=N'Tiếng Ý: “cane” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ý: “cane” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND prompt=N'Tiếng Tây Ban Nha: “Hola” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Tây Ban Nha: “Hola” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND prompt=N'Tiếng Tây Ban Nha: “Gracias” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Tây Ban Nha: “Gracias” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND prompt=N'Tiếng Tây Ban Nha: “agua” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Tây Ban Nha: “agua” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND prompt=N'Tiếng Tây Ban Nha: “libro” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Tây Ban Nha: “libro” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND prompt=N'Tiếng Tây Ban Nha: “casa” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Tây Ban Nha: “casa” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND prompt=N'Tiếng Tây Ban Nha: “uno” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Tây Ban Nha: “uno” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND prompt=N'Tiếng Tây Ban Nha: “dos” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Tây Ban Nha: “dos” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND prompt=N'Tiếng Tây Ban Nha: “tres” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Tây Ban Nha: “tres” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND prompt=N'Tiếng Tây Ban Nha: “gato” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Tây Ban Nha: “gato” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND prompt=N'Tiếng Tây Ban Nha: “perro” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Tây Ban Nha: “perro” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND prompt=N'Tiếng Bồ Đào Nha: “Olá” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Bồ Đào Nha: “Olá” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND prompt=N'Tiếng Bồ Đào Nha: “Obrigado” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Bồ Đào Nha: “Obrigado” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND prompt=N'Tiếng Bồ Đào Nha: “água” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Bồ Đào Nha: “água” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND prompt=N'Tiếng Bồ Đào Nha: “livro” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Bồ Đào Nha: “livro” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND prompt=N'Tiếng Bồ Đào Nha: “casa” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Bồ Đào Nha: “casa” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND prompt=N'Tiếng Bồ Đào Nha: “um” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Bồ Đào Nha: “um” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND prompt=N'Tiếng Bồ Đào Nha: “dois” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Bồ Đào Nha: “dois” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND prompt=N'Tiếng Bồ Đào Nha: “três” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Bồ Đào Nha: “três” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND prompt=N'Tiếng Bồ Đào Nha: “gato” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Bồ Đào Nha: “gato” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND prompt=N'Tiếng Bồ Đào Nha: “cachorro” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Bồ Đào Nha: “cachorro” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND prompt=N'Tiếng Nga: “Здравствуйте” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nga: “Здравствуйте” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND prompt=N'Tiếng Nga: “Спасибо” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nga: “Спасибо” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND prompt=N'Tiếng Nga: “вода” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nga: “вода” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND prompt=N'Tiếng Nga: “книга” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nga: “книга” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND prompt=N'Tiếng Nga: “дом” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nga: “дом” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND prompt=N'Tiếng Nga: “один” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nga: “один” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND prompt=N'Tiếng Nga: “два” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nga: “два” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND prompt=N'Tiếng Nga: “три” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nga: “три” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND prompt=N'Tiếng Nga: “кошка” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nga: “кошка” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND prompt=N'Tiếng Nga: “собака” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Nga: “собака” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND prompt=N'Tiếng Ả Rập: “مرحبا” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ả Rập: “مرحبا” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND prompt=N'Tiếng Ả Rập: “شكرا” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ả Rập: “شكرا” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND prompt=N'Tiếng Ả Rập: “ماء” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ả Rập: “ماء” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND prompt=N'Tiếng Ả Rập: “كتاب” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ả Rập: “كتاب” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND prompt=N'Tiếng Ả Rập: “بيت” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ả Rập: “بيت” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND prompt=N'Tiếng Ả Rập: “واحد” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ả Rập: “واحد” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND prompt=N'Tiếng Ả Rập: “اثنان” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ả Rập: “اثنان” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND prompt=N'Tiếng Ả Rập: “ثلاثة” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ả Rập: “ثلاثة” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND prompt=N'Tiếng Ả Rập: “قطة” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ả Rập: “قطة” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND prompt=N'Tiếng Ả Rập: “كلب” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Ả Rập: “كلب” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND prompt=N'Tiếng Hindi: “नमस्ते” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hindi: “नमस्ते” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND prompt=N'Tiếng Hindi: “धन्यवाद” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hindi: “धन्यवाद” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND prompt=N'Tiếng Hindi: “पानी” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hindi: “पानी” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND prompt=N'Tiếng Hindi: “किताब” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hindi: “किताब” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND prompt=N'Tiếng Hindi: “घर” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hindi: “घर” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND prompt=N'Tiếng Hindi: “एक” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hindi: “एक” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND prompt=N'Tiếng Hindi: “दो” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hindi: “दो” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND prompt=N'Tiếng Hindi: “तीन” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hindi: “तीन” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND prompt=N'Tiếng Hindi: “बिल्ली” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hindi: “बिल्ली” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND prompt=N'Tiếng Hindi: “कुत्ता” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Hindi: “कुत्ता” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND prompt=N'Tiếng Thái: “สวัสดี” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thái: “สวัสดี” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND prompt=N'Tiếng Thái: “ขอบคุณ” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thái: “ขอบคุณ” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND prompt=N'Tiếng Thái: “น้ำ” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thái: “น้ำ” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND prompt=N'Tiếng Thái: “หนังสือ” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thái: “หนังสือ” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND prompt=N'Tiếng Thái: “บ้าน” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thái: “บ้าน” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND prompt=N'Tiếng Thái: “หนึ่ง” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thái: “หนึ่ง” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND prompt=N'Tiếng Thái: “สอง” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thái: “สอง” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND prompt=N'Tiếng Thái: “สาม” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thái: “สาม” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND prompt=N'Tiếng Thái: “แมว” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thái: “แมว” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND prompt=N'Tiếng Thái: “สุนัข” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thái: “สุนัข” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND prompt=N'Tiếng Indonesia: “Halo” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Indonesia: “Halo” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND prompt=N'Tiếng Indonesia: “Terima kasih” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Indonesia: “Terima kasih” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND prompt=N'Tiếng Indonesia: “air” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Indonesia: “air” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND prompt=N'Tiếng Indonesia: “buku” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Indonesia: “buku” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND prompt=N'Tiếng Indonesia: “rumah” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Indonesia: “rumah” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND prompt=N'Tiếng Indonesia: “satu” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Indonesia: “satu” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND prompt=N'Tiếng Indonesia: “dua” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Indonesia: “dua” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND prompt=N'Tiếng Indonesia: “tiga” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Indonesia: “tiga” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND prompt=N'Tiếng Indonesia: “kucing” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Indonesia: “kucing” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND prompt=N'Tiếng Indonesia: “anjing” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Indonesia: “anjing” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND prompt=N'Tiếng Việt: “xin chào” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Việt: “xin chào” có nghĩa là gì trong tiếng Anh?',N'["hello","thank you","water","book"]',0,N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND prompt=N'Tiếng Việt: “cảm ơn” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Việt: “cảm ơn” có nghĩa là gì trong tiếng Anh?',N'["water","thank you","book","house"]',1,N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND prompt=N'Tiếng Việt: “nước” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Việt: “nước” có nghĩa là gì trong tiếng Anh?',N'["house","book","water","one"]',2,N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND prompt=N'Tiếng Việt: “sách” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Việt: “sách” có nghĩa là gì trong tiếng Anh?',N'["two","house","one","book"]',3,N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND prompt=N'Tiếng Việt: “nhà” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Việt: “nhà” có nghĩa là gì trong tiếng Anh?',N'["house","one","two","three"]',0,N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND prompt=N'Tiếng Việt: “một” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Việt: “một” có nghĩa là gì trong tiếng Anh?',N'["two","one","three","cat"]',1,N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND prompt=N'Tiếng Việt: “hai” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Việt: “hai” có nghĩa là gì trong tiếng Anh?',N'["cat","three","two","dog"]',2,N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND prompt=N'Tiếng Việt: “ba” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Việt: “ba” có nghĩa là gì trong tiếng Anh?',N'["hello","cat","dog","three"]',3,N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND prompt=N'Tiếng Việt: “mèo” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Việt: “mèo” có nghĩa là gì trong tiếng Anh?',N'["cat","dog","hello","thank you"]',0,N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND prompt=N'Tiếng Việt: “chó” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Việt: “chó” có nghĩa là gì trong tiếng Anh?',N'["hello","dog","thank you","water"]',1,N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND prompt=N'Tiếng Thổ Nhĩ Kỳ: “Merhaba” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ: “Merhaba” có nghĩa là gì?',N'["xin chào","cảm ơn","nước","sách"]',0,N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND prompt=N'Tiếng Thổ Nhĩ Kỳ: “Teşekkürler” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ: “Teşekkürler” có nghĩa là gì?',N'["nước","cảm ơn","sách","nhà"]',1,N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND prompt=N'Tiếng Thổ Nhĩ Kỳ: “su” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ: “su” có nghĩa là gì?',N'["nhà","sách","nước","một"]',2,N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND prompt=N'Tiếng Thổ Nhĩ Kỳ: “kitap” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ: “kitap” có nghĩa là gì?',N'["hai","nhà","một","sách"]',3,N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND prompt=N'Tiếng Thổ Nhĩ Kỳ: “ev” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ: “ev” có nghĩa là gì?',N'["nhà","một","hai","ba"]',0,N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND prompt=N'Tiếng Thổ Nhĩ Kỳ: “bir” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ: “bir” có nghĩa là gì?',N'["hai","một","ba","mèo"]',1,N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND prompt=N'Tiếng Thổ Nhĩ Kỳ: “iki” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ: “iki” có nghĩa là gì?',N'["mèo","ba","hai","chó"]',2,N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND prompt=N'Tiếng Thổ Nhĩ Kỳ: “üç” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ: “üç” có nghĩa là gì?',N'["xin chào","mèo","chó","ba"]',3,N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND prompt=N'Tiếng Thổ Nhĩ Kỳ: “kedi” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ: “kedi” có nghĩa là gì?',N'["mèo","chó","xin chào","cảm ơn"]',0,N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND prompt=N'Tiếng Thổ Nhĩ Kỳ: “köpek” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ: “köpek” có nghĩa là gì?',N'["xin chào","chó","cảm ơn","nước"]',1,N'tr');
INSERT INTO dbo.metadata([key],value) VALUES(N'multilingual-v1',N'1');
COMMIT;
PRINT N'Đã bổ sung khóa, giáo viên, lớp và bài khảo sát cho 15 ngôn ngữ mới.';
END TRY
BEGIN CATCH
IF XACT_STATE()<>0 ROLLBACK;
THROW;
END CATCH;
GO
