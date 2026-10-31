/* Cấp độ và bài kiểm tra minh họa, không phải đề thi chứng chỉ.
Chạy sau 08. Không dùng ID cố định và không ghi đè các cấp độ đã chỉnh. */
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
IF EXISTS(SELECT 1 FROM dbo.metadata WHERE [key]=N'competency-v1') BEGIN PRINT N'Đã có cấp độ và đề năng lực; giữ dữ liệu hiện tại.'; RETURN; END;
BEGIN TRY
BEGIN TRANSACTION;
UPDATE dbo.courses SET levelCode=N'B1' WHERE name=N'IELTS Foundation' AND language=N'en' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Anh giao tiếp' AND language=N'en' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Anh trẻ em' AND language=N'en' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Anh thiếu niên' AND language=N'en' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Anh căn bản' AND language=N'en' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'B2' WHERE name=N'English for Work' AND language=N'en' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'B1' WHERE name=N'TOEIC 650+' AND language=N'en' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'HSK1' WHERE name=N'Tiếng Trung nhập môn' AND language=N'zh' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'HSK2' WHERE name=N'Tiếng Trung giao tiếp' AND language=N'zh' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'TOPIK1' WHERE name=N'Tiếng Hàn nhập môn' AND language=N'ko' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'TOPIK2' WHERE name=N'Tiếng Hàn giao tiếp' AND language=N'ko' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'N5' WHERE name=N'Tiếng Nhật nhập môn' AND language=N'ja' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'N4' WHERE name=N'Tiếng Nhật giao tiếp' AND language=N'ja' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Pháp nhập môn' AND language=N'fr' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Pháp giao tiếp' AND language=N'fr' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Đức nhập môn' AND language=N'de' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Đức giao tiếp' AND language=N'de' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Ý nhập môn' AND language=N'it' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Ý giao tiếp' AND language=N'it' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Tây Ban Nha nhập môn' AND language=N'es' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Tây Ban Nha giao tiếp' AND language=N'es' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Bồ Đào Nha nhập môn' AND language=N'pt' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Bồ Đào Nha giao tiếp' AND language=N'pt' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Nga nhập môn' AND language=N'ru' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Nga giao tiếp' AND language=N'ru' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Ả Rập nhập môn' AND language=N'ar' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Ả Rập giao tiếp' AND language=N'ar' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Hindi nhập môn' AND language=N'hi' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Hindi giao tiếp' AND language=N'hi' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Thái nhập môn' AND language=N'th' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Thái giao tiếp' AND language=N'th' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Indonesia nhập môn' AND language=N'id' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Indonesia giao tiếp' AND language=N'id' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Việt nhập môn' AND language=N'vi' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Việt giao tiếp' AND language=N'vi' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A1' WHERE name=N'Tiếng Thổ Nhĩ Kỳ nhập môn' AND language=N'tr' AND levelCode='';
UPDATE dbo.courses SET levelCode=N'A2' WHERE name=N'Tiếng Thổ Nhĩ Kỳ giao tiếp' AND language=N'tr' AND levelCode='';
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'en' AND name=N'Tiếng Anh C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Anh C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-en.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng anh hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'en' AND name=N'Tiếng Anh C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Anh C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-en.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng anh hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'zh' AND name=N'Tiếng Trung HSK 3')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Trung HSK 3',N'Theo cấp độ',N'HSK 3',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-zh.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng trung hướng tới HSK 3; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình HSK 3.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'HSK3',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'zh' AND name=N'Tiếng Trung HSK 4')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Trung HSK 4',N'Theo cấp độ',N'HSK 4',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-zh.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng trung hướng tới HSK 4; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình HSK 4.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'HSK4',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'zh' AND name=N'Tiếng Trung HSK 5')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Trung HSK 5',N'Theo cấp độ',N'HSK 5',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-zh.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng trung hướng tới HSK 5; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình HSK 5.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'HSK5',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'zh' AND name=N'Tiếng Trung HSK 6')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Trung HSK 6',N'Theo cấp độ',N'HSK 6',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-zh.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng trung hướng tới HSK 6; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình HSK 6.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'HSK6',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'zh' AND name=N'Tiếng Trung HSK 7-9')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Trung HSK 7-9',N'Theo cấp độ',N'HSK 7-9',12,4200000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-zh.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng trung hướng tới HSK 7-9; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình HSK 7-9.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'HSK7-9',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ko' AND name=N'Tiếng Hàn TOPIK 3')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Hàn TOPIK 3',N'Theo cấp độ',N'TOPIK 3',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ko.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng hàn hướng tới TOPIK 3; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình TOPIK 3.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'TOPIK3',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ko' AND name=N'Tiếng Hàn TOPIK 4')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Hàn TOPIK 4',N'Theo cấp độ',N'TOPIK 4',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ko.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng hàn hướng tới TOPIK 4; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình TOPIK 4.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'TOPIK4',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ko' AND name=N'Tiếng Hàn TOPIK 5')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Hàn TOPIK 5',N'Theo cấp độ',N'TOPIK 5',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ko.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng hàn hướng tới TOPIK 5; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình TOPIK 5.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'TOPIK5',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ko' AND name=N'Tiếng Hàn TOPIK 6')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Hàn TOPIK 6',N'Theo cấp độ',N'TOPIK 6',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ko.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng hàn hướng tới TOPIK 6; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình TOPIK 6.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'TOPIK6',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ja' AND name=N'Tiếng Nhật N3')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Nhật N3',N'Theo cấp độ',N'N3',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ja.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng nhật hướng tới N3; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình N3.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'N3',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ja' AND name=N'Tiếng Nhật N2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Nhật N2',N'Theo cấp độ',N'N2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ja.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng nhật hướng tới N2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình N2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'N2',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ja' AND name=N'Tiếng Nhật N1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Nhật N1',N'Theo cấp độ',N'N1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ja.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng nhật hướng tới N1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình N1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'N1',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'fr' AND name=N'Tiếng Pháp B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Pháp B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-fr.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng pháp hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'fr' AND name=N'Tiếng Pháp B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Pháp B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-fr.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng pháp hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'fr' AND name=N'Tiếng Pháp C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Pháp C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-fr.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng pháp hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'fr' AND name=N'Tiếng Pháp C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Pháp C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-fr.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng pháp hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'de' AND name=N'Tiếng Đức B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Đức B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-de.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng đức hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'de' AND name=N'Tiếng Đức B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Đức B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-de.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng đức hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'de' AND name=N'Tiếng Đức C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Đức C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-de.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng đức hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'de' AND name=N'Tiếng Đức C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Đức C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-de.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng đức hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'it' AND name=N'Tiếng Ý B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Ý B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-it.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng ý hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'it' AND name=N'Tiếng Ý B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Ý B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-it.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng ý hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'it' AND name=N'Tiếng Ý C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Ý C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-it.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng ý hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'it' AND name=N'Tiếng Ý C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Ý C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-it.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng ý hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'es' AND name=N'Tiếng Tây Ban Nha B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Tây Ban Nha B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-es.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng tây ban nha hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'es' AND name=N'Tiếng Tây Ban Nha B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Tây Ban Nha B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-es.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng tây ban nha hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'es' AND name=N'Tiếng Tây Ban Nha C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Tây Ban Nha C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-es.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng tây ban nha hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'es' AND name=N'Tiếng Tây Ban Nha C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Tây Ban Nha C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-es.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng tây ban nha hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'pt' AND name=N'Tiếng Bồ Đào Nha B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Bồ Đào Nha B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-pt.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng bồ đào nha hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'pt' AND name=N'Tiếng Bồ Đào Nha B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Bồ Đào Nha B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-pt.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng bồ đào nha hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'pt' AND name=N'Tiếng Bồ Đào Nha C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Bồ Đào Nha C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-pt.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng bồ đào nha hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'pt' AND name=N'Tiếng Bồ Đào Nha C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Bồ Đào Nha C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-pt.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng bồ đào nha hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ru' AND name=N'Tiếng Nga B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Nga B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ru.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng nga hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ru' AND name=N'Tiếng Nga B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Nga B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ru.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng nga hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ru' AND name=N'Tiếng Nga C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Nga C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ru.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng nga hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ru' AND name=N'Tiếng Nga C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Nga C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ru.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng nga hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ar' AND name=N'Tiếng Ả Rập B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Ả Rập B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ar.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng ả rập hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ar' AND name=N'Tiếng Ả Rập B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Ả Rập B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ar.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng ả rập hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ar' AND name=N'Tiếng Ả Rập C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Ả Rập C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ar.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng ả rập hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'ar' AND name=N'Tiếng Ả Rập C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Ả Rập C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-ar.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng ả rập hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'hi' AND name=N'Tiếng Hindi B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Hindi B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-hi.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng hindi hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'hi' AND name=N'Tiếng Hindi B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Hindi B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-hi.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng hindi hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'hi' AND name=N'Tiếng Hindi C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Hindi C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-hi.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng hindi hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'hi' AND name=N'Tiếng Hindi C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Hindi C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-hi.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng hindi hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'th' AND name=N'Tiếng Thái B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Thái B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-th.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng thái hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'th' AND name=N'Tiếng Thái B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Thái B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-th.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng thái hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'th' AND name=N'Tiếng Thái C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Thái C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-th.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng thái hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'th' AND name=N'Tiếng Thái C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Thái C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-th.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng thái hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'id' AND name=N'Tiếng Indonesia B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Indonesia B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-id.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng indonesia hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'id' AND name=N'Tiếng Indonesia B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Indonesia B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-id.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng indonesia hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'id' AND name=N'Tiếng Indonesia C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Indonesia C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-id.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng indonesia hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'id' AND name=N'Tiếng Indonesia C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Indonesia C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-id.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng indonesia hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'vi' AND name=N'Tiếng Việt B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Việt B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-vi.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng việt hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'vi' AND name=N'Tiếng Việt B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Việt B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-vi.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng việt hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'vi' AND name=N'Tiếng Việt C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Việt C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-vi.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng việt hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'vi' AND name=N'Tiếng Việt C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Việt C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-vi.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng việt hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'tr' AND name=N'Tiếng Thổ Nhĩ Kỳ B1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ B1',N'Theo cấp độ',N'B1',12,3400000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-tr.svg',N'Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến. Khóa tiếng thổ nhĩ kỳ hướng tới B1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B1',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'tr' AND name=N'Tiếng Thổ Nhĩ Kỳ B2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ B2',N'Theo cấp độ',N'B2',12,3600000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-tr.svg',N'Đọc nội dung dài hơn và giải thích quan điểm với lập luận. Khóa tiếng thổ nhĩ kỳ hướng tới B2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình B2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'B2',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'tr' AND name=N'Tiếng Thổ Nhĩ Kỳ C1')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ C1',N'Theo cấp độ',N'C1',12,3800000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-tr.svg',N'Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh. Khóa tiếng thổ nhĩ kỳ hướng tới C1; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C1.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C1',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.courses WHERE language=N'tr' AND name=N'Tiếng Thổ Nhĩ Kỳ C2')
INSERT INTO dbo.courses ([name],[category],[level],[duration],[tuition],[lessons],[audience],[image],[description],[material],[levelCode],[language]) VALUES (N'Tiếng Thổ Nhĩ Kỳ C2',N'Theo cấp độ',N'C2',12,4000000,24,N'Từ 16 tuổi · Học tiếp theo nền tảng đã có',N'/images/language-tr.svg',N'Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng. Khóa tiếng thổ nhĩ kỳ hướng tới C2; cần trao đổi thêm với giáo viên khi xếp lớp.',N'Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình C2.
Ôn tập theo chủ đề, thực hành và đánh giá cuối khóa.',N'C2',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'EN-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Anh C1' AND language=N'en'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Minh Anh'),N'EN-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'08:00',N'09:30',N'LV-en-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'EN-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Anh C1' AND language=N'en'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Minh Anh'),N'EN-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-en-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'EN-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Anh C1' AND language=N'en'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Minh Anh'),N'EN-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-en-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'EN-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Anh C2' AND language=N'en'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Minh Anh'),N'EN-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'10:00',N'11:30',N'LV-en-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'EN-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Anh C2' AND language=N'en'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Minh Anh'),N'EN-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-en-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'EN-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Anh C2' AND language=N'en'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Minh Anh'),N'EN-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-en-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK3-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 3' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK3-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-zh-HSK3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK3-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 3' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK3-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-zh-HSK3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK3-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 3' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK3-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-zh-HSK3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK4-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 4' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK4-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-zh-HSK4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK4-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 4' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK4-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-zh-HSK4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK4-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 4' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK4-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-zh-HSK4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK5-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 5' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK5-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-zh-HSK5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK5-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 5' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK5-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-zh-HSK5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK5-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 5' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK5-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-zh-HSK5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK6-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 6' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK6-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-zh-HSK6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK6-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 6' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK6-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-zh-HSK6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK6-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 6' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK6-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-zh-HSK6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK7-9-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 7-9' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK7-9-1',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'13:30',N'15:00',N'LV-zh-HSK7-9',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK7-9-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 7-9' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK7-9-2',N'2026-11-21',N'2027-02-13',N'Chủ nhật · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[7]',N'18:00',N'19:30',N'LV-zh-HSK7-9',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ZH-HSK7-9-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Trung HSK 7-9' AND language=N'zh'),(SELECT id FROM dbo.teachers WHERE name=N'Lưu Minh Châu'),N'ZH-HSK7-9-3',N'2026-11-21',N'2027-02-13',N'Chủ nhật · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[7]',N'13:30',N'15:00',N'LV-zh-HSK7-9',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK3-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 3' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK3-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-ko-TOPIK3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK3-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 3' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK3-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-ko-TOPIK3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK3-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 3' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK3-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-ko-TOPIK3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK4-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 4' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK4-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-ko-TOPIK4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK4-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 4' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK4-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-ko-TOPIK4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK4-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 4' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK4-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-ko-TOPIK4',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK5-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 5' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK5-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-ko-TOPIK5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK5-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 5' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK5-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-ko-TOPIK5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK5-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 5' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK5-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-ko-TOPIK5',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK6-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 6' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK6-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-ko-TOPIK6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK6-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 6' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK6-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-ko-TOPIK6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'KO-TOPIK6-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hàn TOPIK 6' AND language=N'ko'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Hà Yến'),N'KO-TOPIK6-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-ko-TOPIK6',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-N3-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật N3' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-N3-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-ja-N3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-N3-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật N3' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-N3-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-ja-N3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-N3-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật N3' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-N3-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-ja-N3',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-N2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật N2' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-N2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-ja-N2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-N2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật N2' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-N2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-ja-N2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-N2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật N2' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-N2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-ja-N2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-N1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật N1' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-N1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-ja-N1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-N1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật N1' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-N1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-ja-N1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'JA-N1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nhật N1' AND language=N'ja'),(SELECT id FROM dbo.teachers WHERE name=N'Phạm Nhật Minh'),N'JA-N1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-ja-N1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp B1' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-fr-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp B1' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-fr-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp B1' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-fr-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp B2' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-fr-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp B2' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-fr-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp B2' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-fr-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp C1' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-fr-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp C1' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-fr-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp C1' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-fr-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp C2' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-fr-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp C2' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-fr-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'FR-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Pháp C2' AND language=N'fr'),(SELECT id FROM dbo.teachers WHERE name=N'Lê Thanh Trúc'),N'FR-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-fr-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức B1' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-de-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức B1' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-de-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức B1' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-de-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức B2' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-de-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức B2' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-de-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức B2' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-de-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức C1' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-de-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức C1' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-de-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức C1' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-de-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức C2' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-de-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức C2' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-de-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'DE-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Đức C2' AND language=N'de'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Đức Khang'),N'DE-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-de-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý B1' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-it-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý B1' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-it-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý B1' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-it-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý B2' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-it-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý B2' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-it-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý B2' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-it-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý C1' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-it-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý C1' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-it-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý C1' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-it-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý C2' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-it-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý C2' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-it-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'IT-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ý C2' AND language=N'it'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn Ý Nhi'),N'IT-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-it-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha B1' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-es-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha B1' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-es-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha B1' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-es-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha B2' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-es-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha B2' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-es-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha B2' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-es-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha C1' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-es-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha C1' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-es-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha C1' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-es-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha C2' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-es-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha C2' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-es-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ES-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Tây Ban Nha C2' AND language=N'es'),(SELECT id FROM dbo.teachers WHERE name=N'Vũ Hoàng Mai'),N'ES-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-es-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha B1' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-pt-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha B1' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-pt-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha B1' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-pt-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha B2' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-pt-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha B2' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-pt-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha B2' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-pt-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha C1' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-pt-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha C1' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-pt-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha C1' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-pt-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha C2' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-pt-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha C2' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-pt-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'PT-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Bồ Đào Nha C2' AND language=N'pt'),(SELECT id FROM dbo.teachers WHERE name=N'Đỗ Minh Tâm'),N'PT-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-pt-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga B1' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-ru-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga B1' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-ru-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga B1' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-ru-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga B2' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-ru-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga B2' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-ru-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga B2' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-ru-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga C1' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-ru-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga C1' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-ru-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga C1' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-ru-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga C2' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-ru-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga C2' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-ru-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'RU-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Nga C2' AND language=N'ru'),(SELECT id FROM dbo.teachers WHERE name=N'Bùi Ngọc Ánh'),N'RU-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-ru-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập B1' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-ar-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập B1' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-ar-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập B1' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-ar-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập B2' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-ar-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập B2' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-ar-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập B2' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-ar-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập C1' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-ar-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập C1' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-ar-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập C1' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-ar-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập C2' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-ar-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập C2' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-ar-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'AR-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Ả Rập C2' AND language=N'ar'),(SELECT id FROM dbo.teachers WHERE name=N'Hoàng Minh Quân'),N'AR-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-ar-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi B1' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-hi-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi B1' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-hi-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi B1' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-hi-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi B2' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-hi-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi B2' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-hi-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi B2' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-hi-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi C1' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-hi-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi C1' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-hi-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi C1' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-hi-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi C2' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-hi-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi C2' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-hi-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'HI-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Hindi C2' AND language=N'hi'),(SELECT id FROM dbo.teachers WHERE name=N'Nguyễn An Bình'),N'HI-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-hi-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái B1' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-th-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái B1' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-th-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái B1' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-th-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái B2' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-th-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái B2' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-th-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái B2' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-th-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái C1' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-th-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái C1' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-th-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái C1' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-th-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái C2' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-th-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái C2' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-th-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TH-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thái C2' AND language=N'th'),(SELECT id FROM dbo.teachers WHERE name=N'Trịnh Thảo Vy'),N'TH-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-th-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia B1' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-id-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia B1' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-id-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia B1' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-id-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia B2' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-id-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia B2' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-id-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia B2' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-id-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia C1' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-id-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia C1' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-id-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia C1' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-id-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia C2' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-id-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia C2' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-id-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'ID-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Indonesia C2' AND language=N'id'),(SELECT id FROM dbo.teachers WHERE name=N'Phan Gia Hân'),N'ID-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-id-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt B1' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-vi-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt B1' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-vi-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt B1' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-vi-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt B2' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-vi-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt B2' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-vi-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt B2' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-vi-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt C1' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-vi-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt C1' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-vi-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt C1' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-vi-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt C2' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-vi-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt C2' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-vi-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'VI-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Việt C2' AND language=N'vi'),(SELECT id FROM dbo.teachers WHERE name=N'Đặng Khánh Hòa'),N'VI-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-vi-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-B1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ B1' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-B1-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'08:00',N'09:30',N'LV-tr-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-B1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ B1' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-B1-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[1,3]',N'18:00',N'19:30',N'LV-tr-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-B1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ B1' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-B1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 13:30 – 15:00',N'Cơ sở Lê Lợi',18,N'[6]',N'13:30',N'15:00',N'LV-tr-B1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-B2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ B2' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-B2-1',N'2026-11-21',N'2027-02-13',N'Thứ 3, Thứ 5 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[2,4]',N'10:00',N'11:30',N'LV-tr-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-B2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ B2' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-B2-2',N'2026-11-21',N'2027-02-13',N'Thứ 2, Thứ 4 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[1,3]',N'19:30',N'21:00',N'LV-tr-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-B2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ B2' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-B2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 15:30 – 17:00',N'Cơ sở Lê Lợi',18,N'[6]',N'15:30',N'17:00',N'LV-tr-B2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-C1-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ C1' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-C1-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 08:00 – 09:30',N'Cơ sở Lê Lợi',18,N'[5]',N'08:00',N'09:30',N'LV-tr-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-C1-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ C1' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-C1-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[5]',N'18:00',N'19:30',N'LV-tr-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-C1-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ C1' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-C1-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 18:00 – 19:30',N'Cơ sở Lê Lợi',18,N'[6]',N'18:00',N'19:30',N'LV-tr-C1',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-C2-1')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ C2' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-C2-1',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 10:00 – 11:30',N'Cơ sở Lê Lợi',18,N'[5]',N'10:00',N'11:30',N'LV-tr-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-C2-2')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ C2' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-C2-2',N'2026-11-21',N'2027-02-13',N'Thứ 6 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[5]',N'19:30',N'21:00',N'LV-tr-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.classes WHERE name=N'TR-C2-3')
INSERT INTO dbo.classes ([courseId],[teacherId],[name],[startDate],[endDate],[schedule],[campus],[capacity],[weekdays],[startTime],[endTime],[room],[status]) VALUES ((SELECT id FROM dbo.courses WHERE name=N'Tiếng Thổ Nhĩ Kỳ C2' AND language=N'tr'),(SELECT id FROM dbo.teachers WHERE name=N'Trần Tuấn Kiệt'),N'TR-C2-3',N'2026-11-21',N'2027-02-13',N'Thứ 7 · 19:30 – 21:00',N'Cơ sở Lê Lợi',18,N'[6]',N'19:30',N'21:00',N'LV-tr-C2',N'enrolling');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“hello” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“hello” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'She ___ to school every day.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'She ___ to school every day.',N'["go","goes","going","gone"]',1,N'A1',N'grammar',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Linh goes to the library to borrow a book.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Linh goes to the library to borrow a book.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“appointment” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“appointment” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'We ___ the museum yesterday.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'We ___ the museum yesterday.',N'["visited","visit","visiting","visits"]',0,N'A2',N'grammar',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'The picnic planned for Saturday has been moved to Sunday because of heavy rain.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'The picnic planned for Saturday has been moved to Sunday because of heavy rain.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“responsibility” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“responsibility” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'If I had more time, I ___ another language.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'If I had more time, I ___ another language.',N'["have learned","will learn","learn","would learn"]',3,N'B1',N'grammar',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'The course had ten sessions. Mai missed two and attended all the others.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'The course had ten sessions. Mai missed two and attended all the others.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“sustainable” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“sustainable” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'___ the rain, they continued the journey.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ the rain, they continued the journey.',N'["Because","Although","Despite","Even"]',2,N'B2',N'grammar',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Although the study included many participants, all came from one city; its findings cannot automatically be applied everywhere.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Although the study included many participants, all came from one city; its findings cannot automatically be applied everywhere.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“nuance” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“nuance” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'No sooner had she arrived ___ the meeting began.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'No sooner had she arrived ___ the meeting began.',N'["when","than","that","then"]',1,N'C1',N'grammar',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'The writer welcomes remote work for its flexibility, provided that employers protect privacy and give staff equal access to information.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'The writer welcomes remote work for its flexibility, provided that employers protect privacy and give staff equal access to information.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“paradox” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“paradox” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Had I known about the delay, I ___ earlier.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Had I known about the delay, I ___ earlier.',N'["would have left","will leave","would leave","had left"]',0,N'C2',N'grammar',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'en' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'The lack of evidence for a claim is not necessarily proof that the claim is false; it may instead reflect the limits of the available inquiry.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'The lack of evidence for a claim is not necessarily proof that the claim is false; it may instead reflect the limits of the available inquiry.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'en');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK1' AND prompt=N'“你好” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“你好” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'HSK1',N'vocabulary',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK1' AND prompt=N'我___学生。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'我___学生。',N'["在","是","有","去"]',1,N'HSK1',N'grammar',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK1' AND prompt=N'小林去图书馆借书。

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'小林去图书馆借书。

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'HSK1',N'reading',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK2' AND prompt=N'“预约” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“预约” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'HSK2',N'vocabulary',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK2' AND prompt=N'昨天我___了三本书。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'昨天我___了三本书。',N'["买","很","的","从"]',0,N'HSK2',N'grammar',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK2' AND prompt=N'原定星期六的野餐因为大雨改到星期天。

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'原定星期六的野餐因为大雨改到星期天。

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'HSK2',N'reading',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK3' AND prompt=N'“责任” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“责任” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'HSK3',N'vocabulary',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK3' AND prompt=N'___下雨，我们还是出发了。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___下雨，我们还是出发了。',N'["只有","因为","如果","虽然"]',3,N'HSK3',N'grammar',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK3' AND prompt=N'这门课一共有十次课，小梅缺席了两次，其余都参加了。

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'这门课一共有十次课，小梅缺席了两次，其余都参加了。

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'HSK3',N'reading',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK4' AND prompt=N'“可持续” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“可持续” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'HSK4',N'vocabulary',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK4' AND prompt=N'只有认真准备，___能取得进步。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'只有认真准备，___能取得进步。',N'["又","就","才","也"]',2,N'HSK4',N'grammar',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK4' AND prompt=N'这项研究的参与者虽然很多，却都来自同一座城市，因此不能直接把结论推广到所有地区。

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'这项研究的参与者虽然很多，却都来自同一座城市，因此不能直接把结论推广到所有地区。

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'HSK4',N'reading',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK5' AND prompt=N'“细微差别” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“细微差别” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'HSK5',N'vocabulary',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK5' AND prompt=N'与其抱怨，___采取行动。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'与其抱怨，___采取行动。',N'["由于","不如","以免","何况"]',1,N'HSK5',N'grammar',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK5' AND prompt=N'作者赞成远程工作的灵活性，但强调雇主必须保护隐私，并确保员工平等获取信息。

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'作者赞成远程工作的灵活性，但强调雇主必须保护隐私，并确保员工平等获取信息。

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'HSK5',N'reading',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK6' AND prompt=N'“悖论” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“悖论” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'HSK6',N'vocabulary',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK6' AND prompt=N'他___没有放弃，反而更加努力了。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'他___没有放弃，反而更加努力了。',N'["非但","除非","既然","以便"]',0,N'HSK6',N'grammar',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK6' AND prompt=N'没有找到支持某一主张的证据，并不必然证明该主张错误，也可能反映调查方法的局限。

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'没有找到支持某一主张的证据，并不必然证明该主张错误，也可能反映调查方法的局限。

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'HSK6',N'reading',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK7-9' AND prompt=N'“认识论” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“认识论” có nghĩa là gì?',N'["lịch hẹn","xin chào","nhận thức luận","trách nhiệm"]',2,N'HSK7-9',N'vocabulary',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK7-9' AND prompt=N'计划固然周密，___执行仍需因地制宜。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'计划固然周密，___执行仍需因地制宜。',N'["从而","因此","以致","但"]',3,N'HSK7-9',N'grammar',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'zh' AND assessment='competency' AND levelCode=N'HSK7-9' AND prompt=N'当一个理论能够解释现有材料，却无法排除其他同样合理的解释时，其说服力不应与结论的确定性混为一谈。

Tác giả phân biệt điều gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'当一个理论能够解释现有材料，却无法排除其他同样合理的解释时，其说服力不应与结论的确定性混为一谈。

Tác giả phân biệt điều gì?',N'["Khả năng giải thích và mức độ chắc chắn của kết luận","Số người và số buổi học","Địa điểm và lịch hẹn","Mọi lý thuyết đều sai"]',0,N'HSK7-9',N'reading',N'competency',N'zh');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK1' AND prompt=N'“안녕하세요” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“안녕하세요” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'TOPIK1',N'vocabulary',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK1' AND prompt=N'저는 학생___.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'저는 학생___.',N'["갑니다","입니다","먹습니다","있습니다"]',1,N'TOPIK1',N'grammar',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK1' AND prompt=N'린은 책을 빌리려고 도서관에 갑니다.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'린은 책을 빌리려고 도서관에 갑니다.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'TOPIK1',N'reading',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK2' AND prompt=N'“예약” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“예약” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'TOPIK2',N'vocabulary',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK2' AND prompt=N'어제 친구를 ___.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'어제 친구를 ___.',N'["만났어요","만나요","만날 거예요","만나세요"]',0,N'TOPIK2',N'grammar',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK2' AND prompt=N'토요일에 하기로 했던 소풍은 폭우 때문에 일요일로 미뤄졌습니다.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'토요일에 하기로 했던 소풍은 폭우 때문에 일요일로 미뤄졌습니다.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'TOPIK2',N'reading',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK3' AND prompt=N'“책임” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“책임” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'TOPIK3',N'vocabulary',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK3' AND prompt=N'비가 ___ 우산을 가져가세요.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'비가 ___ 우산을 가져가세요.',N'["오려고","오지만","오거나","오니까"]',3,N'TOPIK3',N'grammar',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK3' AND prompt=N'수업은 모두 열 번이었습니다. 마이는 두 번 결석하고 나머지 수업에는 모두 참석했습니다.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'수업은 모두 열 번이었습니다. 마이는 두 번 결석하고 나머지 수업에는 모두 참석했습니다.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'TOPIK3',N'reading',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK4' AND prompt=N'“지속 가능한” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“지속 가능한” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'TOPIK4',N'vocabulary',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK4' AND prompt=N'열심히 공부한 ___ 시험에 합격했다.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'열심히 공부한 ___ 시험에 합격했다.',N'["중에","대신에","덕분에","뿐이다"]',2,N'TOPIK4',N'grammar',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK4' AND prompt=N'연구 참여자는 많았지만 모두 한 도시에서 모집했으므로 결과를 모든 지역에 그대로 적용하기는 어렵다.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'연구 참여자는 많았지만 모두 한 도시에서 모집했으므로 결과를 모든 지역에 그대로 적용하기는 어렵다.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'TOPIK4',N'reading',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK5' AND prompt=N'“미묘한 차이” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“미묘한 차이” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'TOPIK5',N'vocabulary',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK5' AND prompt=N'직접 확인하지 않고서는 사실이라고 ___ 어렵다.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'직접 확인하지 않고서는 사실이라고 ___ 어렵다.',N'["단정해서","단정하기","단정한 뒤","단정했지만"]',1,N'TOPIK5',N'grammar',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK5' AND prompt=N'필자는 재택근무의 유연성을 긍정적으로 평가하지만, 사생활 보호와 정보 접근의 공정성이 보장되어야 한다고 본다.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'필자는 재택근무의 유연성을 긍정적으로 평가하지만, 사생활 보호와 정보 접근의 공정성이 보장되어야 한다고 본다.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'TOPIK5',N'reading',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK6' AND prompt=N'“역설” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“역설” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'TOPIK6',N'vocabulary',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK6' AND prompt=N'노력도 하지 않으면서 성공을 바라다니, 그야말로 ___.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'노력도 하지 않으면서 성공을 바라다니, 그야말로 ___.',N'["어불성설이다","금상첨화이다","일석이조이다","전화위복이다"]',0,N'TOPIK6',N'grammar',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ko' AND assessment='competency' AND levelCode=N'TOPIK6' AND prompt=N'어떤 주장을 뒷받침할 증거가 발견되지 않았다는 사실만으로 그 주장이 거짓이라고 단정할 수는 없다. 이는 조사 방법의 한계를 드러낼 수도 있다.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'어떤 주장을 뒷받침할 증거가 발견되지 않았다는 사실만으로 그 주장이 거짓이라고 단정할 수는 없다. 이는 조사 방법의 한계를 드러낼 수도 있다.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'TOPIK6',N'reading',N'competency',N'ko');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N5' AND prompt=N'“こんにちは” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“こんにちは” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'N5',N'vocabulary',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N5' AND prompt=N'わたしは学生___。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'わたしは学生___。',N'["ます","です","ある","する"]',1,N'N5',N'grammar',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N5' AND prompt=N'リンさんは本を借りに図書館へ行きます。

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'リンさんは本を借りに図書館へ行きます。

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'N5',N'reading',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N4' AND prompt=N'“予約” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“予約” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'N4',N'vocabulary',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N4' AND prompt=N'昨日、図書館へ___。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'昨日、図書館へ___。',N'["行きました","行きます","行きましょう","行きません"]',0,N'N4',N'grammar',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N4' AND prompt=N'土曜日に予定していたピクニックは、大雨のため日曜日に変更されました。

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'土曜日に予定していたピクニックは、大雨のため日曜日に変更されました。

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'N4',N'reading',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N3' AND prompt=N'“責任” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“責任” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'N3',N'vocabulary',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N3' AND prompt=N'雨が降っている___、試合は行われた。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'雨が降っている___、試合は行われた。',N'["ことに","ために","ように","のに"]',3,N'N3',N'grammar',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N3' AND prompt=N'授業は全部で十回あった。マイさんは二回欠席し、それ以外はすべて出席した。

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'授業は全部で十回あった。マイさんは二回欠席し、それ以外はすべて出席した。

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'N3',N'reading',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N2' AND prompt=N'“微妙な違い” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“微妙な違い” có nghĩa là gì?',N'["xin chào","sắc thái / khác biệt tinh tế","lịch hẹn","trách nhiệm"]',1,N'N2',N'vocabulary',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N2' AND prompt=N'この問題は、専門家___解決できないほど難しい。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'この問題は、専門家___解決できないほど難しい。',N'["ばかりに","にだけ","でさえ","のうちに"]',2,N'N2',N'grammar',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N2' AND prompt=N'筆者は在宅勤務の柔軟性を評価する一方、個人情報の保護と情報への公平なアクセスが不可欠だと指摘している。

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'筆者は在宅勤務の柔軟性を評価する一方、個人情報の保護と情報への公平なアクセスが不可欠だと指摘している。

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Chỉ đề cập lương thưởng","Ủng hộ bất kể quyền riêng tư","Phản đối hoàn toàn","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin"]',3,N'N2',N'reading',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N1' AND prompt=N'“逆説” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“逆説” có nghĩa là gì?',N'["nghịch lý","xin chào","lịch hẹn","trách nhiệm"]',0,N'N1',N'vocabulary',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N1' AND prompt=N'十分な根拠がない以上、その結論には同意___。')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'十分な根拠がない以上、その結論には同意___。',N'["しがちだ","しかねる","し終える","しつつある"]',1,N'N1',N'grammar',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ja' AND assessment='competency' AND levelCode=N'N1' AND prompt=N'ある主張を裏付ける証拠が見つからないからといって、その主張が誤りだと断定できるわけではない。調査の限界を示している可能性もある。

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'ある主張を裏付ける証拠が見つからないからといって、その主張が誤りだと断定できるわけではない。調査の限界を示している可能性もある。

Có thể rút ra nhận định nào?',N'["Mọi nhận định đều đúng","Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Không cần xem xét phương pháp nghiên cứu"]',2,N'N1',N'reading',N'competency',N'ja');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“bonjour” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“bonjour” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Je ___ étudiant.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Je ___ étudiant.',N'["es","suis","est","sommes"]',1,N'A1',N'grammar',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Linh va à la bibliothèque pour emprunter un livre.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Linh va à la bibliothèque pour emprunter un livre.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“rendez-vous” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“rendez-vous” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Hier, nous ___ au musée.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Hier, nous ___ au musée.',N'["sommes allés","allons","irons","allez"]',0,N'A2',N'grammar',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Le pique-nique prévu samedi est reporté à dimanche à cause de fortes pluies.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Le pique-nique prévu samedi est reporté à dimanche à cause de fortes pluies.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“responsabilité” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“responsabilité” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Si j''avais plus de temps, je ___ davantage.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Si j''avais plus de temps, je ___ davantage.',N'["voyageais","voyagerai","voyage","voyagerais"]',3,N'B1',N'grammar',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Le cours comptait dix séances. Mai en a manqué deux et a assisté à toutes les autres.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Le cours comptait dix séances. Mai en a manqué deux et a assisté à toutes les autres.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“durable” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“durable” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Il faut que tu ___ à l''heure.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Il faut que tu ___ à l''heure.',N'["viendras","viens","viennes","venais"]',2,N'B2',N'grammar',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Malgré le nombre élevé de participants, l''étude porte sur une seule ville : ses résultats ne sont donc pas automatiquement généralisables.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Malgré le nombre élevé de participants, l''étude porte sur une seule ville : ses résultats ne sont donc pas automatiquement généralisables.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“nuance” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“nuance” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Bien qu''il ___ fatigué, il poursuit son travail.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Bien qu''il ___ fatigué, il poursuit son travail.',N'["est","soit","sera","était"]',1,N'C1',N'grammar',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'L''auteur apprécie la souplesse du télétravail, à condition que la vie privée soit protégée et que chacun ait un accès équitable à l''information.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'L''auteur apprécie la souplesse du télétravail, à condition que la vie privée soit protégée et que chacun ait un accès équitable à l''information.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“paradoxe” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“paradoxe” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Si j''avais su, je ___ autrement.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Si j''avais su, je ___ autrement.',N'["serais parti","partirai","pars","partais"]',0,N'C2',N'grammar',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'fr' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'L''absence de preuve en faveur d''une affirmation ne constitue pas nécessairement la preuve de sa fausseté ; elle peut révéler les limites de l''enquête.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'L''absence de preuve en faveur d''une affirmation ne constitue pas nécessairement la preuve de sa fausseté ; elle peut révéler les limites de l''enquête.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'fr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“hallo” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“hallo” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Ich ___ Student.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Ich ___ Student.',N'["bist","bin","ist","sind"]',1,N'A1',N'grammar',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Linh geht in die Bibliothek, um ein Buch auszuleihen.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Linh geht in die Bibliothek, um ein Buch auszuleihen.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“Termin” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“Termin” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Gestern ___ ich im Museum.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Gestern ___ ich im Museum.',N'["war","bin","werde","sei"]',0,N'A2',N'grammar',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Das für Samstag geplante Picknick wurde wegen starken Regens auf Sonntag verschoben.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Das für Samstag geplante Picknick wurde wegen starken Regens auf Sonntag verschoben.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“Verantwortung” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“Verantwortung” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Wenn ich mehr Zeit hätte, ___ ich mehr lesen.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Wenn ich mehr Zeit hätte, ___ ich mehr lesen.',N'["bin","werde","habe","würde"]',3,N'B1',N'grammar',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Der Kurs hatte zehn Termine. Mai fehlte zweimal und nahm an allen übrigen Terminen teil.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Der Kurs hatte zehn Termine. Mai fehlte zweimal und nahm an allen übrigen Terminen teil.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“nachhaltig” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“nachhaltig” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'___ es regnete, gingen wir spazieren.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ es regnete, gingen wir spazieren.',N'["Damit","Weil","Obwohl","Sobald"]',2,N'B2',N'grammar',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Obwohl viele Personen teilnahmen, stammen sie aus nur einer Stadt; die Ergebnisse lassen sich deshalb nicht ohne Weiteres verallgemeinern.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Obwohl viele Personen teilnahmen, stammen sie aus nur einer Stadt; die Ergebnisse lassen sich deshalb nicht ohne Weiteres verallgemeinern.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“Nuance” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“Nuance” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Er tat so, als ___ er von nichts.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Er tat so, als ___ er von nichts.',N'["weiß","wüsste","wissen","gewusst"]',1,N'C1',N'grammar',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Der Autor begrüßt die Flexibilität der Heimarbeit, sofern Privatsphäre und ein gleichberechtigter Zugang zu Informationen gewährleistet sind.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Der Autor begrüßt die Flexibilität der Heimarbeit, sofern Privatsphäre und ein gleichberechtigter Zugang zu Informationen gewährleistet sind.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“Paradox” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“Paradox” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Hätte ich davon gewusst, ___ ich früher gekommen.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Hätte ich davon gewusst, ___ ich früher gekommen.',N'["wäre","werde","bin","habe"]',0,N'C2',N'grammar',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'de' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Das Fehlen von Belegen für eine Behauptung ist nicht zwangsläufig ein Beleg für deren Unrichtigkeit, sondern kann auch die Grenzen der Untersuchung widerspiegeln.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Das Fehlen von Belegen für eine Behauptung ist nicht zwangsläufig ein Beleg für deren Unrichtigkeit, sondern kann auch die Grenzen der Untersuchung widerspiegeln.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'de');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“ciao” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“ciao” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Io ___ studente.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Io ___ studente.',N'["sei","sono","è","siamo"]',1,N'A1',N'grammar',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Linh va in biblioteca per prendere in prestito un libro.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Linh va in biblioteca per prendere in prestito un libro.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“appuntamento” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“appuntamento” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Ieri noi ___ al museo.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Ieri noi ___ al museo.',N'["siamo andati","andiamo","andremo","andate"]',0,N'A2',N'grammar',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Il picnic previsto per sabato è stato rinviato a domenica a causa della forte pioggia.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Il picnic previsto per sabato è stato rinviato a domenica a causa della forte pioggia.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“responsabilità” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“responsabilità” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Se avessi tempo, ___ di più.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Se avessi tempo, ___ di più.',N'["leggevo","leggerò","leggo","leggerei"]',3,N'B1',N'grammar',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Il corso comprendeva dieci lezioni. Mai ne ha saltate due e ha frequentato tutte le altre.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Il corso comprendeva dieci lezioni. Mai ne ha saltate due e ha frequentato tutte le altre.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“sostenibile” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“sostenibile” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Spero che tu ___ bene.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Spero che tu ___ bene.',N'["starai","stai","stia","stavi"]',2,N'B2',N'grammar',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Nonostante i numerosi partecipanti, lo studio riguarda una sola città: i risultati non sono quindi automaticamente generalizzabili.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Nonostante i numerosi partecipanti, lo studio riguarda una sola città: i risultati non sono quindi automaticamente generalizzabili.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“sfumatura” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“sfumatura” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Benché ___ tardi, continuarono a discutere.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Benché ___ tardi, continuarono a discutere.',N'["era","fosse","sarà","è"]',1,N'C1',N'grammar',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'L''autore apprezza la flessibilità del lavoro a distanza, purché siano garantiti la riservatezza e un accesso equo alle informazioni.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'L''autore apprezza la flessibilità del lavoro a distanza, purché siano garantiti la riservatezza e un accesso equo alle informazioni.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“paradosso” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“paradosso” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Se lo avessi saputo, ___ prima.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Se lo avessi saputo, ___ prima.',N'["sarei partito","partirò","parto","partivo"]',0,N'C2',N'grammar',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'it' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'L''assenza di prove a favore di un''affermazione non dimostra necessariamente che sia falsa; può invece rivelare i limiti dell''indagine.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'L''assenza di prove a favore di un''affermazione non dimostra necessariamente che sia falsa; può invece rivelare i limiti dell''indagine.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'it');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“hola” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“hola” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Yo ___ estudiante.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Yo ___ estudiante.',N'["eres","soy","es","somos"]',1,N'A1',N'grammar',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Linh va a la biblioteca para pedir prestado un libro.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Linh va a la biblioteca para pedir prestado un libro.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“cita” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“cita” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Ayer nosotros ___ al museo.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Ayer nosotros ___ al museo.',N'["fuimos","vamos","iremos","vais"]',0,N'A2',N'grammar',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'El picnic previsto para el sábado se ha aplazado al domingo por las fuertes lluvias.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'El picnic previsto para el sábado se ha aplazado al domingo por las fuertes lluvias.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“responsabilidad” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“responsabilidad” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Si tuviera tiempo, ___ más.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Si tuviera tiempo, ___ más.',N'["viajaba","viajaré","viajo","viajaría"]',3,N'B1',N'grammar',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'El curso tenía diez sesiones. Mai faltó a dos y asistió a todas las demás.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'El curso tenía diez sesiones. Mai faltó a dos y asistió a todas las demás.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“sostenible” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“sostenible” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Espero que tú ___ bien.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Espero que tú ___ bien.',N'["estarás","estás","estés","estabas"]',2,N'B2',N'grammar',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Aunque participaron muchas personas, todas procedían de una sola ciudad; los resultados no se pueden generalizar automáticamente.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Aunque participaron muchas personas, todas procedían de una sola ciudad; los resultados no se pueden generalizar automáticamente.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“matiz” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“matiz” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Aunque ___ difícil, lo intentaremos. (Tình huống giả định)')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Aunque ___ difícil, lo intentaremos. (Tình huống giả định)',N'["es","sea","será","fue"]',1,N'C1',N'grammar',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'El autor valora la flexibilidad del teletrabajo siempre que se proteja la privacidad y se garantice un acceso equitativo a la información.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'El autor valora la flexibilidad del teletrabajo siempre que se proteja la privacidad y se garantice un acceso equitativo a la información.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“paradoja” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“paradoja” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Si lo hubiera sabido, ___ antes.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Si lo hubiera sabido, ___ antes.',N'["habría salido","saldré","salgo","salía"]',0,N'C2',N'grammar',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'es' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'La ausencia de pruebas que respalden una afirmación no demuestra necesariamente su falsedad; puede revelar las limitaciones de la investigación.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'La ausencia de pruebas que respalden una afirmación no demuestra necesariamente su falsedad; puede revelar las limitaciones de la investigación.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'es');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“olá” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“olá” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Eu ___ estudante.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Eu ___ estudante.',N'["és","sou","é","somos"]',1,N'A1',N'grammar',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Linh vai à biblioteca para pegar um livro emprestado.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Linh vai à biblioteca para pegar um livro emprestado.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“agendamento” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“agendamento” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Ontem nós ___ ao museu.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Ontem nós ___ ao museu.',N'["fomos","vamos","iremos","vão"]',0,N'A2',N'grammar',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'O piquenique previsto para sábado foi adiado para domingo por causa da chuva forte.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'O piquenique previsto para sábado foi adiado para domingo por causa da chuva forte.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“responsabilidade” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“responsabilidade” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Se eu tivesse tempo, ___ mais.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Se eu tivesse tempo, ___ mais.',N'["viajava","viajarei","viajo","viajaria"]',3,N'B1',N'grammar',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'O curso teve dez aulas. Mai faltou a duas e participou de todas as outras.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'O curso teve dez aulas. Mai faltou a duas e participou de todas as outras.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“sustentável” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“sustentável” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Espero que você ___ bem.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Espero que você ___ bem.',N'["estará","está","esteja","estava"]',2,N'B2',N'grammar',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Apesar do grande número de participantes, todos vieram de uma única cidade; os resultados não podem ser generalizados automaticamente.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Apesar do grande número de participantes, todos vieram de uma única cidade; os resultados não podem ser generalizados automaticamente.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“nuance” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“nuance” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Embora ___ tarde, continuaram a discussão.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Embora ___ tarde, continuaram a discussão.',N'["era","fosse","será","é"]',1,N'C1',N'grammar',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'O autor valoriza a flexibilidade do trabalho remoto, desde que a privacidade e o acesso equitativo às informações sejam garantidos.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'O autor valoriza a flexibilidade do trabalho remoto, desde que a privacidade e o acesso equitativo às informações sejam garantidos.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“paradoxo” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“paradoxo” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Se eu soubesse, ___ antes.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Se eu soubesse, ___ antes.',N'["teria saído","sairei","saio","saía"]',0,N'C2',N'grammar',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'pt' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'A ausência de provas a favor de uma afirmação não demonstra necessariamente que ela seja falsa; pode refletir as limitações da investigação.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'A ausência de provas a favor de uma afirmação não demonstra necessariamente que ela seja falsa; pode refletir as limitações da investigação.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'pt');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“здравствуйте” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“здравствуйте” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Это ___ книга.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Это ___ книга.',N'["мой","моя","моё","мои"]',1,N'A1',N'grammar',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Линь идёт в библиотеку, чтобы взять книгу.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Линь идёт в библиотеку, чтобы взять книгу.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“запись на приём” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“запись на приём” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Вчера я ___ в музее.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Вчера я ___ в музее.',N'["был","буду","быть","будешь"]',0,N'A2',N'grammar',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Пикник, запланированный на субботу, перенесли на воскресенье из-за сильного дождя.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Пикник, запланированный на субботу, перенесли на воскресенье из-за сильного дождя.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“ответственность” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“ответственность” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Если бы у меня было время, я ___ больше.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Если бы у меня было время, я ___ больше.',N'["читай","читаю","буду читать","читал бы"]',3,N'B1',N'grammar',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'В курсе было десять занятий. Май пропустила два, а все остальные посетила.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'В курсе было десять занятий. Май пропустила два, а все остальные посетила.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“устойчивый” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“устойчивый” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'___ дождь, мы продолжили путь.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ дождь, мы продолжили путь.',N'["Из-за","Благодаря","Несмотря на","Вследствие"]',2,N'B2',N'grammar',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Хотя участников было много, все они представляли один город, поэтому результаты нельзя автоматически распространять на другие регионы.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Хотя участников было много, все они представляли один город, поэтому результаты нельзя автоматически распространять на другие регионы.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“нюанс” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“нюанс” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Он говорил так, ___ всё уже знал.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Он говорил так, ___ всё уже знал.',N'["потому что","как будто","для того чтобы","если бы не"]',1,N'C1',N'grammar',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Автор ценит гибкость удалённой работы при условии защиты частной жизни и равного доступа сотрудников к информации.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Автор ценит гибкость удалённой работы при условии защиты частной жизни и равного доступа сотрудников к информации.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“парадокс” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“парадокс” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Будь у нас больше данных, выводы ___ точнее.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Будь у нас больше данных, выводы ___ точнее.',N'["были бы","будут","есть","быть"]',0,N'C2',N'grammar',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ru' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Отсутствие доказательств в пользу утверждения не обязательно доказывает его ложность: оно может отражать ограничения проведённого исследования.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Отсутствие доказательств в пользу утверждения не обязательно доказывает его ложность: оно может отражать ограничения проведённого исследования.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'ru');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“مرحبا” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“مرحبا” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'أنا ___. (Tôi là học sinh)')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'أنا ___. (Tôi là học sinh)',N'["كتاب","طالب","بيت","قلم"]',1,N'A1',N'grammar',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'تذهب لين إلى المكتبة لاستعارة كتاب.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'تذهب لين إلى المكتبة لاستعارة كتاب.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“موعد” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“موعد” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'أمس ___ إلى المتحف.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'أمس ___ إلى المتحف.',N'["ذهبتُ","أذهبُ","سأذهبُ","اذهبْ"]',0,N'A2',N'grammar',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'تأجلت النزهة المقررة يوم السبت إلى يوم الأحد بسبب الأمطار الغزيرة.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'تأجلت النزهة المقررة يوم السبت إلى يوم الأحد بسبب الأمطار الغزيرة.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“مسؤولية” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“مسؤولية” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'لو كان عندي وقت، ___ أكثر.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'لو كان عندي وقت، ___ أكثر.',N'["لن أقرأَ","سأقرأُ","اقرأْ","لقرأتُ"]',3,N'B1',N'grammar',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'تضمنت الدورة عشرة دروس. غابت ماي عن درسين وحضرت بقية الدروس كلها.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'تضمنت الدورة عشرة دروس. غابت ماي عن درسين وحضرت بقية الدروس كلها.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“مستدام” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“مستدام” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'لن ___ الطالبُ عن الدرس.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'لن ___ الطالبُ عن الدرس.',N'["يتأخرْ","يتأخرُ","يتأخرَ","تأخّرَ"]',2,N'B2',N'grammar',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'على الرغم من كثرة المشاركين، فإنهم جميعاً من مدينة واحدة، ولذلك لا يمكن تعميم النتائج تلقائياً على جميع المناطق.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'على الرغم من كثرة المشاركين، فإنهم جميعاً من مدينة واحدة، ولذلك لا يمكن تعميم النتائج تلقائياً على جميع المناطق.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“فارق دقيق” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“فارق دقيق” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'لم ___ الباحثُ من عمله بعدُ.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'لم ___ الباحثُ من عمله بعدُ.',N'["ينتهي","ينتهِ","انتهى","سينتهي"]',1,N'C1',N'grammar',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'يرى الكاتب أن مرونة العمل عن بُعد مفيدة، شريطة حماية الخصوصية وضمان وصول العاملين إلى المعلومات على قدم المساواة.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'يرى الكاتب أن مرونة العمل عن بُعد مفيدة، شريطة حماية الخصوصية وضمان وصول العاملين إلى المعلومات على قدم المساواة.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“مفارقة” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“مفارقة” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'___ تنوّعت الآراء، فإن الحوار يظل ضرورياً. (Dù quan điểm đa dạng)')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ تنوّعت الآراء، فإن الحوار يظل ضرورياً. (Dù quan điểm đa dạng)',N'["مهما","لأن","كي","حتى"]',0,N'C2',N'grammar',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'ar' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'إن غياب الدليل المؤيد لادعاء ما لا يثبت بالضرورة بطلانه، فقد يعكس حدود البحث المتاح بدلاً من ذلك.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'إن غياب الدليل المؤيد لادعاء ما لا يثبت بالضرورة بطلانه، فقد يعكس حدود البحث المتاح بدلاً من ذلك.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'ar');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“नमस्ते” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“नमस्ते” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'मैं विद्यार्थी ___.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'मैं विद्यार्थी ___.',N'["है","हूँ","हो","हैं"]',1,N'A1',N'grammar',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'लिन किताब उधार लेने के लिए पुस्तकालय जाती है।

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'लिन किताब उधार लेने के लिए पुस्तकालय जाती है।

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“मुलाकात का समय” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“मुलाकात का समय” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'कल राम संग्रहालय ___.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'कल राम संग्रहालय ___.',N'["गया था","जाएगा","जाता है","जाओ"]',0,N'A2',N'grammar',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'भारी बारिश के कारण शनिवार की पिकनिक रविवार तक टाल दी गई है।

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'भारी बारिश के कारण शनिवार की पिकनिक रविवार तक टाल दी गई है।

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“ज़िम्मेदारी” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“ज़िम्मेदारी” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'अगर मेरे पास समय होता, तो मैं और ___.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'अगर मेरे पास समय होता, तो मैं और ___.',N'["पढ़ना","पढ़ूँगा","पढ़ो","पढ़ता"]',3,N'B1',N'grammar',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'पाठ्यक्रम में दस कक्षाएँ थीं। माई दो कक्षाओं में अनुपस्थित रही और बाकी सभी में उपस्थित थी।

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'पाठ्यक्रम में दस कक्षाएँ थीं। माई दो कक्षाओं में अनुपस्थित रही और बाकी सभी में उपस्थित थी।

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“टिकाऊ” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“टिकाऊ” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'बारिश होने के ___ हम बाहर गए।')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'बारिश होने के ___ हम बाहर गए।',N'["लिए","कारण","बावजूद","पहले"]',2,N'B2',N'grammar',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'अध्ययन में बहुत से लोग शामिल थे, लेकिन वे सभी एक ही शहर से थे; इसलिए परिणाम हर क्षेत्र पर अपने आप लागू नहीं होते।

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'अध्ययन में बहुत से लोग शामिल थे, लेकिन वे सभी एक ही शहर से थे; इसलिए परिणाम हर क्षेत्र पर अपने आप लागू नहीं होते।

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“सूक्ष्म अंतर” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“सूक्ष्म अंतर” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'उसने ऐसे कहा ___ उसे सब पता हो।')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'उसने ऐसे कहा ___ उसे सब पता हो।',N'["क्योंकि","मानो","इसलिए","ताकि"]',1,N'C1',N'grammar',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'लेखक घर से काम करने की सुविधा का समर्थन करता है, बशर्ते निजता की रक्षा हो और सभी कर्मचारियों को सूचना तक समान पहुँच मिले।

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'लेखक घर से काम करने की सुविधा का समर्थन करता है, बशर्ते निजता की रक्षा हो और सभी कर्मचारियों को सूचना तक समान पहुँच मिले।

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“विरोधाभास” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“विरोधाभास” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'यदि पर्याप्त प्रमाण उपलब्ध होते, तो निष्कर्ष अधिक स्पष्ट ___.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'यदि पर्याप्त प्रमाण उपलब्ध होते, तो निष्कर्ष अधिक स्पष्ट ___.',N'["होते","होगा","है","होना"]',0,N'C2',N'grammar',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'hi' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'किसी दावे के पक्ष में प्रमाण न मिलना आवश्यक रूप से उसके असत्य होने का प्रमाण नहीं है; यह उपलब्ध जाँच की सीमाओं को भी दर्शा सकता है।

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'किसी दावे के पक्ष में प्रमाण न मिलना आवश्यक रूप से उसके असत्य होने का प्रमाण नहीं है; यह उपलब्ध जाँच की सीमाओं को भी दर्शा सकता है।

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'hi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“สวัสดี” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“สวัสดี” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'ฉัน___นักเรียน (Tôi là học sinh)')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'ฉัน___นักเรียน (Tôi là học sinh)',N'["กิน","เป็น","ไป","อ่าน"]',1,N'A1',N'grammar',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'ลินไปห้องสมุดเพื่อยืมหนังสือ

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'ลินไปห้องสมุดเพื่อยืมหนังสือ

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“การนัดหมาย” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“การนัดหมาย” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'เมื่อวานฉัน___พิพิธภัณฑ์มา')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'เมื่อวานฉัน___พิพิธภัณฑ์มา',N'["ไป","จะไป","กำลังไป","อย่าไป"]',0,N'A2',N'grammar',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'การปิกนิกที่กำหนดไว้วันเสาร์เลื่อนไปเป็นวันอาทิตย์เพราะฝนตกหนัก

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'การปิกนิกที่กำหนดไว้วันเสาร์เลื่อนไปเป็นวันอาทิตย์เพราะฝนตกหนัก

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“ความรับผิดชอบ” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“ความรับผิดชอบ” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'___มีเวลา ฉันจะอ่านหนังสือเพิ่ม (Nếu có thời gian)')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___มีเวลา ฉันจะอ่านหนังสือเพิ่ม (Nếu có thời gian)',N'["หรือ","เพราะ","แต่","ถ้า"]',3,N'B1',N'grammar',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'หลักสูตรมีทั้งหมดสิบครั้ง มายขาดเรียนสองครั้งและเข้าเรียนครั้งอื่นทั้งหมด

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'หลักสูตรมีทั้งหมดสิบครั้ง มายขาดเรียนสองครั้งและเข้าเรียนครั้งอื่นทั้งหมด

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“ยั่งยืน” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“ยั่งยืน” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'___ฝนจะตก เราก็ยังออกเดินทาง (Mặc dù)')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ฝนจะตก เราก็ยังออกเดินทาง (Mặc dù)',N'["ดังนั้น","เพราะว่า","แม้ว่า","หรือว่า"]',2,N'B2',N'grammar',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'แม้ว่าจะมีผู้เข้าร่วมวิจัยจำนวนมาก แต่ทุกคนมาจากเมืองเดียวกัน จึงไม่อาจสรุปว่าผลวิจัยใช้ได้กับทุกพื้นที่โดยอัตโนมัติ

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'แม้ว่าจะมีผู้เข้าร่วมวิจัยจำนวนมาก แต่ทุกคนมาจากเมืองเดียวกัน จึงไม่อาจสรุปว่าผลวิจัยใช้ได้กับทุกพื้นที่โดยอัตโนมัติ

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“ความแตกต่างเล็กน้อย” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“ความแตกต่างเล็กน้อย” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'เขาพูด___รู้เรื่องทั้งหมด (Như thể biết mọi chuyện)')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'เขาพูด___รู้เรื่องทั้งหมด (Như thể biết mọi chuyện)',N'["เพราะว่า","ราวกับว่า","เพื่อให้","ดังนั้น"]',1,N'C1',N'grammar',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'ผู้เขียนเห็นข้อดีของความยืดหยุ่นในการทำงานทางไกล โดยมีเงื่อนไขว่าต้องคุ้มครองความเป็นส่วนตัวและให้ทุกคนเข้าถึงข้อมูลอย่างเท่าเทียม

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'ผู้เขียนเห็นข้อดีของความยืดหยุ่นในการทำงานทางไกล โดยมีเงื่อนไขว่าต้องคุ้มครองความเป็นส่วนตัวและให้ทุกคนเข้าถึงข้อมูลอย่างเท่าเทียม

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“ปฏิทรรศน์” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“ปฏิทรรศน์” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'___ผลวิจัยนี้จะมีประโยชน์ ก็ไม่ควรนำไปใช้โดยไม่พิจารณาบริบท (Mặc dù)')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ผลวิจัยนี้จะมีประโยชน์ ก็ไม่ควรนำไปใช้โดยไม่พิจารณาบริบท (Mặc dù)',N'["ถึงแม้ว่า","เนื่องจาก","เพื่อที่","เพราะฉะนั้น"]',0,N'C2',N'grammar',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'th' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'การไม่พบหลักฐานสนับสนุนข้อกล่าวอ้างไม่ได้พิสูจน์เสมอไปว่าข้อกล่าวอ้างนั้นเป็นเท็จ แต่อาจสะท้อนข้อจำกัดของการศึกษาที่มีอยู่

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'การไม่พบหลักฐานสนับสนุนข้อกล่าวอ้างไม่ได้พิสูจน์เสมอไปว่าข้อกล่าวอ้างนั้นเป็นเท็จ แต่อาจสะท้อนข้อจำกัดของการศึกษาที่มีอยู่

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'th');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“halo” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“halo” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Saya ___ mahasiswa. (Tôi là sinh viên)')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Saya ___ mahasiswa. (Tôi là sinh viên)',N'["makan","adalah","pergi","membaca"]',1,N'A1',N'grammar',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Linh pergi ke perpustakaan untuk meminjam buku.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Linh pergi ke perpustakaan untuk meminjam buku.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“janji temu” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“janji temu” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Kemarin saya ___ pergi ke museum.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Kemarin saya ___ pergi ke museum.',N'["sudah","akan","sedang","jangan"]',0,N'A2',N'grammar',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Piknik yang dijadwalkan pada hari Sabtu ditunda hingga Minggu karena hujan lebat.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Piknik yang dijadwalkan pada hari Sabtu ditunda hingga Minggu karena hujan lebat.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“tanggung jawab” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“tanggung jawab” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'___ ada waktu, saya akan membaca lebih banyak.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ ada waktu, saya akan membaca lebih banyak.',N'["Atau","Karena","Tetapi","Jika"]',3,N'B1',N'grammar',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Kursus itu terdiri atas sepuluh pertemuan. Mai tidak hadir dua kali dan mengikuti semua pertemuan lainnya.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Kursus itu terdiri atas sepuluh pertemuan. Mai tidak hadir dua kali dan mengikuti semua pertemuan lainnya.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“berkelanjutan” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“berkelanjutan” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'___ hujan turun, kami tetap berangkat.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ hujan turun, kami tetap berangkat.',N'["Sehingga","Karena","Meskipun","Agar"]',2,N'B2',N'grammar',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Walaupun pesertanya banyak, semuanya berasal dari satu kota sehingga hasil penelitian tidak dapat langsung digeneralisasi ke semua daerah.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Walaupun pesertanya banyak, semuanya berasal dari satu kota sehingga hasil penelitian tidak dapat langsung digeneralisasi ke semua daerah.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“nuansa” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“nuansa” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Ia berbicara ___ mengetahui semuanya.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Ia berbicara ___ mengetahui semuanya.',N'["supaya","seolah-olah","karena","akibatnya"]',1,N'C1',N'grammar',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Penulis mendukung fleksibilitas kerja jarak jauh asalkan privasi dilindungi dan akses terhadap informasi diberikan secara adil.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Penulis mendukung fleksibilitas kerja jarak jauh asalkan privasi dilindungi dan akses terhadap informasi diberikan secara adil.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“paradoks” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“paradoks” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'___ data diperiksa, semakin jelas keterbatasan kesimpulannya.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ data diperiksa, semakin jelas keterbatasan kesimpulannya.',N'["Semakin teliti","Walaupun teliti","Karena teliti","Agar teliti"]',0,N'C2',N'grammar',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'id' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Tidak ditemukannya bukti yang mendukung suatu pernyataan belum tentu membuktikan bahwa pernyataan itu salah; hal tersebut dapat mencerminkan keterbatasan penelitian.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Tidak ditemukannya bukti yang mendukung suatu pernyataan belum tentu membuktikan bahwa pernyataan itu salah; hal tersebut dapat mencerminkan keterbatasan penelitian.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'id');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“xin chào” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“xin chào” có nghĩa là gì trong tiếng Anh?',N'["hello","appointment","responsibility","sustainable"]',0,N'A1',N'vocabulary',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Tôi ___ sinh viên.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Tôi ___ sinh viên.',N'["ở","là","đi","ăn"]',1,N'A1',N'grammar',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Linh đến thư viện để mượn một cuốn sách.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Linh đến thư viện để mượn một cuốn sách.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“lịch hẹn” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“lịch hẹn” có nghĩa là gì trong tiếng Anh?',N'["sustainable","hello","responsibility","appointment"]',3,N'A2',N'vocabulary',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Hôm qua, tôi ___ đến bảo tàng.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Hôm qua, tôi ___ đến bảo tàng.',N'["đã","sẽ","sắp","hãy"]',0,N'A2',N'grammar',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Buổi dã ngoại dự kiến vào thứ Bảy được chuyển sang Chủ nhật vì mưa lớn.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Buổi dã ngoại dự kiến vào thứ Bảy được chuyển sang Chủ nhật vì mưa lớn.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“trách nhiệm” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“trách nhiệm” có nghĩa là gì trong tiếng Anh?',N'["appointment","hello","responsibility","sustainable"]',2,N'B1',N'vocabulary',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'___ có thêm thời gian, tôi sẽ đọc nhiều hơn.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ có thêm thời gian, tôi sẽ đọc nhiều hơn.',N'["Hoặc","Vì","Nhưng","Nếu"]',3,N'B1',N'grammar',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Khóa học có mười buổi. Mai nghỉ hai buổi và tham dự tất cả các buổi còn lại.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Khóa học có mười buổi. Mai nghỉ hai buổi và tham dự tất cả các buổi còn lại.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“bền vững” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“bền vững” có nghĩa là gì trong tiếng Anh?',N'["hello","sustainable","appointment","responsibility"]',1,N'B2',N'vocabulary',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'___ trời mưa, chúng tôi vẫn khởi hành.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ trời mưa, chúng tôi vẫn khởi hành.',N'["Do đó","Bởi vì","Mặc dù","Để mà"]',2,N'B2',N'grammar',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Dù có nhiều người tham gia, nghiên cứu chỉ khảo sát một thành phố; kết quả vì vậy không thể tự động áp dụng cho mọi địa phương.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Dù có nhiều người tham gia, nghiên cứu chỉ khảo sát một thành phố; kết quả vì vậy không thể tự động áp dụng cho mọi địa phương.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“sắc thái” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“sắc thái” có nghĩa là gì trong tiếng Anh?',N'["nuance","hello","appointment","responsibility"]',0,N'C1',N'vocabulary',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Anh ấy nói ___ đã biết hết mọi chuyện.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Anh ấy nói ___ đã biết hết mọi chuyện.',N'["bởi vì","như thể","cho nên","nhằm để"]',1,N'C1',N'grammar',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Tác giả ủng hộ sự linh hoạt của làm việc từ xa, với điều kiện quyền riêng tư và khả năng tiếp cận thông tin bình đẳng được bảo đảm.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Tác giả ủng hộ sự linh hoạt của làm việc từ xa, với điều kiện quyền riêng tư và khả năng tiếp cận thông tin bình đẳng được bảo đảm.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“nghịch lý” có nghĩa là gì trong tiếng Anh?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“nghịch lý” có nghĩa là gì trong tiếng Anh?',N'["responsibility","hello","appointment","paradox"]',3,N'C2',N'vocabulary',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'___ số liệu được thu thập kỹ lưỡng, kết luận vẫn cần được kiểm chứng độc lập.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'___ số liệu được thu thập kỹ lưỡng, kết luận vẫn cần được kiểm chứng độc lập.',N'["Dẫu","Bởi vì","Để","Do đó"]',0,N'C2',N'grammar',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'vi' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Không tìm thấy bằng chứng ủng hộ một nhận định chưa đủ để chứng minh nhận định ấy sai; điều đó cũng có thể phản ánh giới hạn của quá trình khảo sát.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Không tìm thấy bằng chứng ủng hộ một nhận định chưa đủ để chứng minh nhận định ấy sai; điều đó cũng có thể phản ánh giới hạn của quá trình khảo sát.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'vi');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'“merhaba” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“merhaba” có nghĩa là gì?',N'["xin chào","lịch hẹn","trách nhiệm","bền vững"]',0,N'A1',N'vocabulary',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Ben bir ___. (Tôi là sinh viên)')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Ben bir ___. (Tôi là sinh viên)',N'["öğrencisin","öğrenciyim","öğrenciye","öğrencinin"]',1,N'A1',N'grammar',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'A1' AND prompt=N'Linh kitap ödünç almak için kütüphaneye gidiyor.

Mục đích đến thư viện là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Linh kitap ödünç almak için kütüphaneye gidiyor.

Mục đích đến thư viện là gì?',N'["Tìm việc","Mua vé","Mượn sách","Tham dự cuộc họp"]',2,N'A1',N'reading',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'“randevu” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“randevu” có nghĩa là gì?',N'["bền vững","xin chào","trách nhiệm","lịch hẹn"]',3,N'A2',N'vocabulary',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Dün müzeye ___.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Dün müzeye ___.',N'["gittim","gideceğim","gidiyorum","git"]',0,N'A2',N'grammar',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'A2' AND prompt=N'Cumartesi yapılması planlanan piknik, şiddetli yağmur nedeniyle pazar gününe ertelendi.

Buổi dã ngoại được chuyển sang ngày nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Cumartesi yapılması planlanan piknik, şiddetli yağmur nedeniyle pazar gününe ertelendi.

Buổi dã ngoại được chuyển sang ngày nào?',N'["Thứ Bảy","Chủ nhật","Thứ Hai","Thứ Sáu"]',1,N'A2',N'reading',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'“sorumluluk” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“sorumluluk” có nghĩa là gì?',N'["lịch hẹn","xin chào","trách nhiệm","bền vững"]',2,N'B1',N'vocabulary',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Zamanım olsaydı daha çok ___.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Zamanım olsaydı daha çok ___.',N'["oku","okuyacağım","okuyorum","okurdum"]',3,N'B1',N'grammar',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'B1' AND prompt=N'Kursta on ders vardı. Mai iki derse katılmadı ve diğer derslerin hepsine katıldı.

Mai đã tham gia bao nhiêu buổi học?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Kursta on ders vardı. Mai iki derse katılmadı ve diğer derslerin hepsine katıldı.

Mai đã tham gia bao nhiêu buổi học?',N'["8 buổi","2 buổi","10 buổi","12 buổi"]',0,N'B1',N'reading',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'“sürdürülebilir” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“sürdürülebilir” có nghĩa là gì?',N'["xin chào","bền vững","lịch hẹn","trách nhiệm"]',1,N'B2',N'vocabulary',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Yağmur yağmasına ___ yola çıktık.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Yağmur yağmasına ___ yola çıktık.',N'["için","çünkü","rağmen","dolayı"]',2,N'B2',N'grammar',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'B2' AND prompt=N'Katılımcı sayısı yüksek olsa da hepsi aynı şehirden seçildiği için sonuçlar tüm bölgelere kendiliğinden genellenemez.

Hạn chế chính của nghiên cứu là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Katılımcı sayısı yüksek olsa da hepsi aynı şehirden seçildiği için sonuçlar tüm bölgelere kendiliğinden genellenemez.

Hạn chế chính của nghiên cứu là gì?',N'["Kết quả luôn áp dụng toàn cầu","Không có người tham gia","Đã khảo sát mọi nơi","Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi"]',3,N'B2',N'reading',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'“nüans” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“nüans” có nghĩa là gì?',N'["sắc thái / khác biệt tinh tế","xin chào","lịch hẹn","trách nhiệm"]',0,N'C1',N'vocabulary',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Her şeyi biliyor___ konuştu.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Her şeyi biliyor___ konuştu.',N'["mak için","muş gibi","duğu için","dıktan sonra"]',1,N'C1',N'grammar',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'C1' AND prompt=N'Yazar, mahremiyetin korunması ve bilgiye eşit erişimin sağlanması koşuluyla uzaktan çalışmanın esnekliğini destekliyor.

Quan điểm của tác giả về làm việc từ xa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Yazar, mahremiyetin korunması ve bilgiye eşit erişimin sağlanması koşuluyla uzaktan çalışmanın esnekliğini destekliyor.

Quan điểm của tác giả về làm việc từ xa là gì?',N'["Phản đối hoàn toàn","Ủng hộ bất kể quyền riêng tư","Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin","Chỉ đề cập lương thưởng"]',2,N'C1',N'reading',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'“paradoks” có nghĩa là gì?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'“paradoks” có nghĩa là gì?',N'["trách nhiệm","xin chào","lịch hẹn","nghịch lý"]',3,N'C2',N'vocabulary',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Veriler ne kadar ayrıntılı ___ olsun, sonuçlar bağımsız olarak sınanmalıdır.')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Veriler ne kadar ayrıntılı ___ olsun, sonuçlar bağımsız olarak sınanmalıdır.',N'["olursa","olacak","oldu","olmak"]',0,N'C2',N'grammar',N'competency',N'tr');
IF NOT EXISTS(SELECT 1 FROM dbo.questions WHERE language=N'tr' AND assessment='competency' AND levelCode=N'C2' AND prompt=N'Bir iddiayı destekleyen kanıtın bulunmaması, o iddianın yanlış olduğunu zorunlu olarak göstermez; mevcut araştırmanın sınırlarını da yansıtabilir.

Có thể rút ra nhận định nào?')
INSERT INTO dbo.questions ([prompt],[options],[answer],[levelCode],[skill],[assessment],[language]) VALUES (N'Bir iddiayı destekleyen kanıtın bulunmaması, o iddianın yanlış olduğunu zorunlu olarak göstermez; mevcut araştırmanın sınırlarını da yansıtabilir.

Có thể rút ra nhận định nào?',N'["Không có bằng chứng thì chắc chắn sai","Thiếu bằng chứng chưa đủ chứng minh nhận định sai","Mọi nhận định đều đúng","Không cần xem xét phương pháp nghiên cứu"]',1,N'C2',N'reading',N'competency',N'tr');
INSERT INTO dbo.metadata([key],value) VALUES(N'competency-v1',N'1');
COMMIT;
PRINT N'Đã bổ sung 62 khóa theo cấp độ, 186 lớp và 288 câu kiểm tra năng lực.';
END TRY
BEGIN CATCH
IF XACT_STATE()<>0 ROLLBACK;
THROW;
END CATCH;
GO
