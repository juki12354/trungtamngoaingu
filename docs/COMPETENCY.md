# Cấp độ, kiểm tra năng lực và gợi ý lớp — 31/10/2026

Website có 99 khóa thuộc 16 ngôn ngữ, với mã cấp độ riêng để tìm lớp theo kết quả kiểm tra. Database local và bộ SQL Server mẫu có 302 lớp, 24 giáo viên. Ngân hàng có 288 câu kiểm tra năng lực mới và giữ 175 câu khảo sát cũ để tương thích các lượt làm bài đã có.

## Thang chương trình

| Ngôn ngữ | Cấp độ khóa học |
| --- | --- |
| Trung | HSK 1, 2, 3, 4, 5, 6; nhóm nâng cao HSK 7–9 |
| Hàn | TOPIK 1–6 |
| Nhật | N5 → N4 → N3 → N2 → N1 |
| Anh, Pháp, Đức, Ý, Tây Ban Nha, Bồ Đào Nha, Nga | A1 → A2 → B1 → B2 → C1 → C2 |
| Ả Rập, Hindi, Thái, Indonesia, Việt, Thổ Nhĩ Kỳ | Lộ trình nội bộ dùng nhãn A1–C2 |

Nguồn tên thang cấp độ: [Council of Europe — CEFR levels](https://www.coe.int/en/web/common-european-framework-reference-languages/level-descriptions), [Chinese Tests Service Website — HSK](https://www.chinesetest.cn/HSK), [JLPT — N1–N5](https://www.jlpt.jp/e/about/levelsummary.html), [NIIED — TOPIK](https://www.niied.go.kr/web/NIIED/contents/niiedEng/eng_topikOverview). HSK 7–9 được trình bày như nhóm chương trình nâng cao; bài của trung tâm không phân biệt kết quả chứng chỉ 7, 8 hay 9.

Các thang được dùng để đặt mục tiêu khóa học, không quy đổi điểm giữa các hệ thi. Nhãn A1–C2 cho nhóm ngôn ngữ dùng lộ trình nội bộ không có nghĩa trung tâm được công nhận là đơn vị tổ chức kỳ thi chính thức.

## Bài kiểm tra trên website

- Mỗi nhóm cấp độ có 3 câu do dự án tự biên soạn: từ vựng, ngữ pháp và đọc hiểu.
- Tiếng Trung: 21 câu / 7 nhóm; Nhật: 15 câu / 5 nhóm; 14 ngôn ngữ còn lại: 18 câu / 6 nhóm. Tổng 288 câu.
- Câu hỏi có văn bản bản ngữ, phần ngữ pháp điền khuyết và đoạn đọc ngắn. Không lấy đề thi chính thức hoặc giả lập điểm chứng chỉ.
- Trình tự từ nhóm nền tảng đến nâng cao. Không gửi đáp án trước khi nộp. Lượt làm bài giữ bản chụp đề, đáp án, cấp độ và ngôn ngữ trong 30 phút, nên sửa ngân hàng không đổi điểm lượt đang làm.
- Nếu một nhóm thiếu kỹ năng hoặc có mã cấp độ không hợp lệ, server từ chối mở lượt thi thay vì chấm một bộ đề không đầy đủ.

Đây là bài sàng lọc ngắn, không được hiệu chuẩn tâm trắc hoặc bao phủ toàn bộ năng lực của một cấp độ. Chưa đánh giá nghe, nói và viết. Kết quả cần giáo viên xác nhận khi xếp lớp, đặc biệt ở mức cao; không dùng để cấp chứng chỉ hoặc khẳng định người học đã đạt CEFR/HSK/TOPIK/JLPT.

## Chấm bài và đề xuất

Mỗi câu đúng được 1 điểm. Hệ thống hiển thị tổng điểm, điểm từng kỹ năng và kết quả từng nhóm cấp độ. Một nhóm được coi là “làm tốt nhóm câu” khi đúng ít nhất 2/3 số câu, với ít nhất 3 câu trong nhóm.

Chỉ tính các nhóm làm tốt liên tiếp từ mức thấp nhất. Ví dụ: làm tốt HSK 1 và HSK 2, chưa vững HSK 3 → gợi ý học khóa HSK 3. Nếu nhóm đầu còn yếu, vài câu nâng cao đúng rời rạc không khiến hệ thống nhảy qua nền tảng. Nếu hoàn thành tốt toàn bộ, gợi ý khóa cao nhất kèm trao đổi thêm với giáo viên.

Quy tắc này là chính sách gợi ý nội bộ, không phải ngưỡng đỗ của các kỳ thi. “Gợi ý học: HSK 3” là mục tiêu khóa nên học tiếp; không phải tuyên bố người học đã đạt HSK 3.

Lọc lớp theo đồng thời:

1. Đúng ngôn ngữ của lượt làm bài.
2. Đúng `courses.levelCode` được gợi ý.
3. Không dùng khóa trẻ em/thiếu niên trong gợi ý tổng quát cho người lớn.
4. Chưa khai giảng, chưa kết thúc/hủy và trạng thái nhận đăng ký.
5. Số học viên đã xác nhận nhỏ hơn sĩ số tối đa.

Kết quả cho tối đa 9 lớp với lịch, cơ sở, giáo viên và số chỗ còn lại; nút Đăng ký mở đúng `classId`. Nếu không còn lớp phù hợp, giữ đúng cấp độ và dẫn sang tư vấn. Nộp lại lượt đã chấm giữ một kết quả, đồng thời cập nhật lại danh sách lớp còn nhận đăng ký.

## Quản lý và nâng cấp

Admin → Khóa học có “Cấp độ xếp lớp”. Admin → Bài kiểm tra có loại bài, ngôn ngữ, nhóm cấp độ và kỹ năng. API kiểm tra mã cấp độ phải thuộc ngôn ngữ đó. Mã và thứ tự chương trình dùng chung trong `shared/proficiency.js`.

SQLite/PostgreSQL tự thêm `courses.levelCode`, `questions.levelCode/skill/assessment`, `placement_attempts.assessment`, `placement_results.analysis`. Seed `competency-v1` bổ sung 62 khóa theo cấp độ, 186 lớp và 288 câu; không thay mật khẩu, đăng ký, điểm cũ hoặc nội dung khóa đã chỉnh. Lịch mới được kiểm tra trùng giáo viên/phòng; database với lịch tùy chỉnh kín có thể chờ xếp lịch thay vì chèn một lớp trùng.

Chạy `npm.cmd run backup` rồi `npm.cmd run seed:languages` để nâng cấp local. SQL Server đã có bản đa ngôn ngữ: sao lưu, chạy `08-competency-migration.sql` rồi `09-competency-data.sql`. Bản mới dùng `01-schema.sql` + `02-sample-data.sql`. Backend website vẫn là SQLite/PostgreSQL.

## Kiểm tra

Kiểm thử riêng từng ngôn ngữ và từng ranh giới cấp độ; lớp hủy/đủ chỗ/kết thúc không được gợi ý; không có lớp thì trả danh sách trống; dữ liệu client giả ngôn ngữ/cấp độ/điểm không thay đổi kết quả; đề bị sửa sau khi bắt đầu vẫn chấm từ bản chụp; nộp lại không thêm kết quả; thiếu kỹ năng trong bộ đề nhận lỗi 409. Chromium kiểm tra luồng làm bài Trung → HSK 3 → đăng ký đúng lớp, điểm từng kỹ năng, bố cục 360/1440px và Axe tự động.
