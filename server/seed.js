export const courses = [
  {
    id: 1,
    name: "IELTS Foundation",
    category: "IELTS",
    level: "A2 – B1",
    duration: 12,
    tuition: 3500000,
    lessons: 24,
    audience: "Từ 16 tuổi",
    image: "/images/ielts.jpg",
    description:
      "Xây nền tảng vững chắc, chinh phục mục tiêu IELTS đầu tiên. Phát triển đồng đều bốn kỹ năng với lộ trình cá nhân và phản hồi sau mỗi buổi học.",
    material:
      "Tuần 1: Present simple & present continuous. Viết một đoạn 100 từ giới thiệu bản thân.\nTuần 2: Đọc một bài báo ngắn, ghi lại 10 từ mới và đặt câu.\nTuần 3: Luyện mô tả biểu đồ đường và cách diễn đạt xu hướng.",
  },
  {
    id: 2,
    name: "Tiếng Anh giao tiếp",
    category: "Giao tiếp",
    level: "A2 – B1",
    duration: 10,
    tuition: 2800000,
    lessons: 20,
    audience: "Từ 16 tuổi",
    image: "/images/adults.jpg",
    description:
      "Tự tin mở lời trong những tình huống đời thường. Học qua thảo luận, đóng vai và các dự án thực tế trong một lớp học luôn khuyến khích bạn lên tiếng.",
    material:
      "Chủ đề 1: Introduce yourself.\nChủ đề 2: Ordering food — thực hành hội thoại với bạn học.\nChủ đề 3: Giving directions — mô tả đường từ nhà đến trường.",
  },
  {
    id: 3,
    name: "Tiếng Anh trẻ em",
    category: "Trẻ em",
    level: "Pre-A1 – A1",
    duration: 12,
    tuition: 3200000,
    lessons: 24,
    audience: "6 – 11 tuổi",
    image: "/images/kids.jpg",
    description:
      "Nuôi dưỡng niềm yêu thích tiếng Anh qua câu chuyện, trò chơi và hoạt động sáng tạo. Giúp con tự tin khám phá thế giới theo cách của riêng mình.",
    material:
      "Ôn tập từ vựng: colors, animals, family.\nVẽ gia đình và giới thiệu từng thành viên bằng tiếng Anh.",
  },
  {
    id: 4,
    name: "Tiếng Anh thiếu niên",
    category: "Thiếu niên",
    level: "A1 – B1",
    duration: 12,
    tuition: 3300000,
    lessons: 24,
    audience: "12 – 15 tuổi",
    image: "/images/teens.jpg",
    description:
      "Phát triển tư duy, kỹ năng thuyết trình và sự tự tin. Chương trình kết hợp kiến thức học đường với những dự án gần gũi với tuổi teen.",
    material:
      "Dự án: My green school. Chuẩn bị bài thuyết trình 3 phút về một ý tưởng bảo vệ môi trường.",
  },
  {
    id: 5,
    name: "Tiếng Anh căn bản",
    category: "Căn bản",
    level: "A1",
    duration: 8,
    tuition: 2200000,
    lessons: 16,
    audience: "Người mới bắt đầu",
    image: "/images/basics.jpg",
    description:
      "Bắt đầu lại từ những điều đơn giản nhất. Nắm chắc phát âm, từ vựng và ngữ pháp thiết yếu với tốc độ học vừa sức và sự hỗ trợ sát sao.",
    material:
      "Học bảng phiên âm cơ bản.\nÔn động từ to be; viết 10 câu với I am, You are, She is.",
  },
  {
    id: 6,
    name: "English for Work",
    category: "Đi làm",
    level: "B1 – B2",
    duration: 10,
    tuition: 3800000,
    lessons: 20,
    audience: "Sinh viên & người đi làm",
    image: "/images/work.jpg",
    description:
      "Để tiếng Anh trở thành lợi thế nghề nghiệp. Thực hành viết email, phỏng vấn, thuyết trình và làm việc cùng đồng nghiệp quốc tế.",
    material:
      "Viết email ứng tuyển 150 từ.\nChuẩn bị câu trả lời: Tell me about yourself.\nThực hành cách lên lịch họp qua email.",
  },
];
export const teachers = [
  {
    id: 1,
    name: "Nguyễn Minh Anh",
    degree: "Thạc sĩ TESOL · IELTS 8.5",
    experience: 8,
    specialty: "IELTS · Tiếng Anh học thuật",
    image: "/images/teacher1.jpg",
    description:
      "Cô Minh Anh tin rằng mỗi học viên đều có một cách học riêng. Các buổi học của cô kết hợp tư duy phản biện với những hoạt động thực hành gần gũi.",
  },
  {
    id: 2,
    name: "David Wilson",
    degree: "CELTA · University of Leeds",
    experience: 10,
    specialty: "Giao tiếp · English for Work",
    image: "/images/teacher2.jpg",
    description:
      "Thầy David tạo ra một không gian học cởi mở, nơi mọi câu hỏi đều được chào đón. Thầy chú trọng phát âm và khả năng sử dụng tiếng Anh thực tế.",
  },
  {
    id: 3,
    name: "Trần Thảo Linh",
    degree: "Cử nhân Sư phạm Anh · TESOL",
    experience: 6,
    specialty: "Trẻ em · Tiếng Anh thiếu niên",
    image: "/images/teacher3.jpg",
    description:
      "Cô Linh mang những câu chuyện, trò chơi và dự án sáng tạo vào lớp học, giúp các bạn nhỏ học tiếng Anh với sự tò mò và niềm vui.",
  },
];
const futureDate = (days) => {
  const value = new Date();
  value.setUTCDate(value.getUTCDate() + days);
  return value.toISOString().slice(0, 10);
};
export const classes = courses.map((c, i) => ({
  id: i + 1,
  courseId: c.id,
  teacherId: i === 0 || i === 4 ? 1 : i === 1 || i === 5 ? 2 : 3,
  name: ["IELTS-F01", "GT-02", "KIDS-03", "TEEN-04", "CB-05", "WORK-06"][i],
  startDate: futureDate(14 + i * 3),
  endDate: futureDate(110 + i * 3),
  schedule:
    i === 4
      ? "Thứ 2, Thứ 4 · 16:00 – 18:00"
      : i === 5
        ? "Thứ 7, Chủ nhật · 08:00 – 10:00"
        : i % 2
          ? "Thứ 3, Thứ 5 · 19:00 – 21:00"
          : "Thứ 2, Thứ 4 · 18:30 – 20:30",
  campus: i % 2 ? "Cơ sở Nguyễn Văn Cừ" : "Cơ sở Lê Lợi",
  capacity: 18,
}));
export const news = [
  {
    id: 1,
    title: "Bắt đầu hành trình IELTS: từ đâu và như thế nào?",
    category: "Góc học tập",
    date: "2026-09-18",
    image: "/images/ielts.jpg",
    excerpt:
      "Một lộ trình rõ ràng sẽ giúp việc học nhẹ nhàng hơn. Cùng tìm điểm khởi đầu phù hợp với bạn.",
    content:
      "Bước đầu tiên không phải là làm thật nhiều đề, mà là hiểu trình độ hiện tại của mình. Hãy dành thời gian kiểm tra từ vựng, ngữ pháp và khả năng đọc hiểu.\n\nTiếp theo, đặt một mục tiêu nhỏ cho từng tuần: học 20 từ mới theo chủ đề, nghe một đoạn hội thoại ngắn hoặc viết một đoạn văn 100 từ. Việc học đều đặn quan trọng hơn những buổi học kéo dài nhưng thiếu tập trung.\n\nCuối cùng, hãy tìm người phản hồi cho bài viết và phần nói của bạn. Giáo viên có thể giúp bạn nhận ra lỗi lặp lại và xây dựng cách sửa phù hợp.",
  },
  {
    id: 2,
    title: "5 cách để con yêu tiếng Anh mỗi ngày",
    category: "Cùng con khôn lớn",
    date: "2026-09-15",
    image: "/images/kids.jpg",
    excerpt:
      "Những hoạt động nhỏ tại nhà để ba mẹ đồng hành cùng con, bắt đầu bằng niềm vui.",
    content:
      "Đọc một cuốn truyện tranh ngắn, hát một bài hát hoặc cùng chơi trò đoán đồ vật đều là những cách đưa tiếng Anh vào cuộc sống.\n\nHãy để con chọn chủ đề mình thích. Khi con nói sai, ba mẹ có thể nhắc lại câu đúng một cách tự nhiên thay vì ngắt lời.\n\nMỗi ngày 10–15 phút là một khởi đầu tốt. Điều quan trọng là giữ không khí vui vẻ, khuyến khích con thử và ghi nhận sự tiến bộ của con.",
  },
  {
    id: 3,
    title: "Nói tiếng Anh tự tin hơn, từng chút một",
    category: "Kỹ năng giao tiếp",
    date: "2026-09-12",
    image: "/images/adults.jpg",
    excerpt:
      "Bạn không cần hoàn hảo để bắt đầu một cuộc trò chuyện. Bạn chỉ cần sẵn sàng mở lời.",
    content:
      "Sự tự tin được hình thành qua luyện tập. Hãy bắt đầu với một chủ đề quen thuộc: công việc, sở thích hoặc một bộ phim bạn vừa xem.\n\nGhi âm một phút mỗi ngày, nghe lại và chọn một điểm muốn cải thiện. Không cần sửa tất cả lỗi cùng một lúc.\n\nKhi trò chuyện, hãy dùng câu ngắn và hỏi lại nếu chưa hiểu. Giao tiếp là kết nối ý nghĩa, vì vậy hãy tập trung vào thông điệp bạn muốn chia sẻ.",
  },
];
const items = [
  ["She _____ to school every day.", ["go", "goes", "going", "gone"], 1],
  ["There _____ a book on the table.", ["are", "be", "is", "am"], 2],
  ["I have lived here _____ 2020.", ["for", "since", "at", "during"], 1],
  ["They _____ football yesterday.", ["play", "plays", "played", "playing"], 2],
  [
    "This bag is _____ than that one.",
    ["heavy", "heaviest", "more heavy", "heavier"],
    3,
  ],
  ["We do not have _____ milk left.", ["some", "any", "many", "a"], 1],
  [
    "If it rains, we _____ at home.",
    ["stayed", "would stay", "will stay", "staying"],
    2,
  ],
  [
    "The book _____ by a young author last year.",
    ["wrote", "was written", "writes", "is writing"],
    1,
  ],
  [
    "I enjoy _____ new languages.",
    ["learn", "to learning", "learning", "learned"],
    2,
  ],
  [
    "You _____ wear a helmet when riding a motorbike.",
    ["must", "might", "would", "could have"],
    0,
  ],
  [
    "By the time we arrived, the film _____.",
    ["starts", "has started", "had started", "starting"],
    2,
  ],
  [
    "The woman _____ lives next door is a teacher.",
    ["which", "who", "where", "whose"],
    1,
  ],
  [
    "Despite _____ tired, he finished his work.",
    ["be", "was", "being", "been"],
    2,
  ],
  [
    "If I _____ you, I would take the opportunity.",
    ["am", "was being", "were", "have been"],
    2,
  ],
  [
    "The word “reliable” is closest in meaning to _____.",
    ["expensive", "dependable", "creative", "unusual"],
    1,
  ],
];
export const questions = items.map(([prompt, options, answer], i) => ({
  id: i + 1,
  prompt,
  options,
  answer,
}));
