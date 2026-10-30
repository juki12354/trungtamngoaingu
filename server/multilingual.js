import { languages } from "../shared/languages.js";
import { formatSchedule } from "./domain.js";

// Fictional teaching profiles and curricula for the student project.
const profiles = [
  [
    "zh",
    "Lưu Minh Châu",
    "Cử nhân Ngôn ngữ Trung",
    "Việt Nam",
    "Pinyin, thanh điệu và hội thoại tiếng Trung",
  ],
  [
    "ko",
    "Nguyễn Hà Yến",
    "Cử nhân Ngôn ngữ Hàn",
    "Việt Nam",
    "Hangul, phát âm và giao tiếp tiếng Hàn",
  ],
  [
    "ja",
    "Phạm Nhật Minh",
    "Cử nhân Ngôn ngữ Nhật",
    "Việt Nam",
    "Hiragana, Katakana và giao tiếp tiếng Nhật",
  ],
  [
    "fr",
    "Lê Thanh Trúc",
    "Thạc sĩ Giảng dạy tiếng Pháp",
    "Việt Nam",
    "Phát âm và giao tiếp tiếng Pháp",
  ],
  [
    "de",
    "Trần Đức Khang",
    "Cử nhân Ngôn ngữ Đức",
    "Việt Nam",
    "Ngữ pháp nền tảng và giao tiếp tiếng Đức",
  ],
  [
    "it",
    "Nguyễn Ý Nhi",
    "Cử nhân Ngôn ngữ Ý",
    "Việt Nam",
    "Phát âm và văn hóa giao tiếp tiếng Ý",
  ],
  [
    "es",
    "Vũ Hoàng Mai",
    "Cử nhân Ngôn ngữ Tây Ban Nha",
    "Việt Nam",
    "Giao tiếp tiếng Tây Ban Nha",
  ],
  [
    "pt",
    "Đỗ Minh Tâm",
    "Cử nhân Ngôn ngữ Bồ Đào Nha",
    "Việt Nam",
    "Tiếng Bồ Đào Nha trong đời sống",
  ],
  [
    "ru",
    "Bùi Ngọc Ánh",
    "Cử nhân Ngôn ngữ Nga",
    "Việt Nam",
    "Bảng chữ cái Cyrillic và hội thoại tiếng Nga",
  ],
  [
    "ar",
    "Hoàng Minh Quân",
    "Cử nhân Ngôn ngữ Ả Rập",
    "Việt Nam",
    "Chữ viết và tiếng Ả Rập tiêu chuẩn hiện đại",
  ],
  [
    "hi",
    "Nguyễn An Bình",
    "Cử nhân Ngôn ngữ Hindi",
    "Việt Nam",
    "Devanagari và giao tiếp tiếng Hindi",
  ],
  [
    "th",
    "Trịnh Thảo Vy",
    "Cử nhân Ngôn ngữ Thái",
    "Việt Nam",
    "Thanh điệu và giao tiếp tiếng Thái",
  ],
  [
    "id",
    "Phan Gia Hân",
    "Cử nhân Ngôn ngữ Indonesia",
    "Việt Nam",
    "Bahasa Indonesia cho du lịch và công việc",
  ],
  [
    "vi",
    "Đặng Khánh Hòa",
    "Thạc sĩ Việt Nam học",
    "Việt Nam",
    "Tiếng Việt cho người nước ngoài",
  ],
  [
    "tr",
    "Trần Tuấn Kiệt",
    "Cử nhân Ngôn ngữ Thổ Nhĩ Kỳ",
    "Việt Nam",
    "Giao tiếp tiếng Thổ Nhĩ Kỳ",
  ],
];
const meanings = [
  "xin chào",
  "cảm ơn",
  "nước",
  "sách",
  "nhà",
  "một",
  "hai",
  "ba",
  "mèo",
  "chó",
];
const vocabulary = {
  zh: ["你好", "谢谢", "水", "书", "家", "一", "二", "三", "猫", "狗"],
  ko: [
    "안녕하세요",
    "감사합니다",
    "물",
    "책",
    "집",
    "하나",
    "둘",
    "셋",
    "고양이",
    "개",
  ],
  ja: [
    "こんにちは",
    "ありがとう",
    "水",
    "本",
    "家",
    "一",
    "二",
    "三",
    "猫",
    "犬",
  ],
  fr: [
    "Bonjour",
    "Merci",
    "eau",
    "livre",
    "maison",
    "un",
    "deux",
    "trois",
    "chat",
    "chien",
  ],
  de: [
    "Hallo",
    "Danke",
    "Wasser",
    "Buch",
    "Haus",
    "eins",
    "zwei",
    "drei",
    "Katze",
    "Hund",
  ],
  it: [
    "Ciao",
    "Grazie",
    "acqua",
    "libro",
    "casa",
    "uno",
    "due",
    "tre",
    "gatto",
    "cane",
  ],
  es: [
    "Hola",
    "Gracias",
    "agua",
    "libro",
    "casa",
    "uno",
    "dos",
    "tres",
    "gato",
    "perro",
  ],
  pt: [
    "Olá",
    "Obrigado",
    "água",
    "livro",
    "casa",
    "um",
    "dois",
    "três",
    "gato",
    "cachorro",
  ],
  ru: [
    "Здравствуйте",
    "Спасибо",
    "вода",
    "книга",
    "дом",
    "один",
    "два",
    "три",
    "кошка",
    "собака",
  ],
  ar: [
    "مرحبا",
    "شكرا",
    "ماء",
    "كتاب",
    "بيت",
    "واحد",
    "اثنان",
    "ثلاثة",
    "قطة",
    "كلب",
  ],
  hi: [
    "नमस्ते",
    "धन्यवाद",
    "पानी",
    "किताब",
    "घर",
    "एक",
    "दो",
    "तीन",
    "बिल्ली",
    "कुत्ता",
  ],
  th: [
    "สวัสดี",
    "ขอบคุณ",
    "น้ำ",
    "หนังสือ",
    "บ้าน",
    "หนึ่ง",
    "สอง",
    "สาม",
    "แมว",
    "สุนัข",
  ],
  id: [
    "Halo",
    "Terima kasih",
    "air",
    "buku",
    "rumah",
    "satu",
    "dua",
    "tiga",
    "kucing",
    "anjing",
  ],
  vi: [
    "xin chào",
    "cảm ơn",
    "nước",
    "sách",
    "nhà",
    "một",
    "hai",
    "ba",
    "mèo",
    "chó",
  ],
  tr: [
    "Merhaba",
    "Teşekkürler",
    "su",
    "kitap",
    "ev",
    "bir",
    "iki",
    "üç",
    "kedi",
    "köpek",
  ],
};
const english = [
  "hello",
  "thank you",
  "water",
  "book",
  "house",
  "one",
  "two",
  "three",
  "cat",
  "dog",
];

export async function addMultilingual(db) {
  if (
    await db.prepare("SELECT 1 FROM metadata WHERE key='multilingual-v1'").get()
  )
    return { added: false };
  const insert = async (table, data) => {
    const keys = Object.keys(data);
    const result = await db
      .prepare(
        `INSERT INTO ${table} (${keys.join(",")}) VALUES (${keys.map(() => "?").join(",")})`,
      )
      .run(
        ...keys.map((k) =>
          typeof data[k] === "object" ? JSON.stringify(data[k]) : data[k],
        ),
      );
    return Number(result.lastInsertRowid);
  };
  const day = (n) =>
    new Date(Date.now() + n * 86400000).toISOString().slice(0, 10);
  for (const [
    index,
    [code, name, degree, nationality, specialty],
  ] of profiles.entries()) {
    const lang = languages.find((l) => l.code === code);
    const existingTeacher = await db
      .prepare("SELECT id FROM teachers WHERE name=?")
      .get(name);
    const teacherId =
      existingTeacher?.id ||
      (await insert("teachers", {
        name,
        degree,
        nationality,
        experience: 5 + (index % 5),
        specialty,
        languages: [code],
        image: `/images/teacher${4 + (index % 6)}.svg`,
        description: `Giáo viên ${lang.name.toLocaleLowerCase("vi")} đồng hành cùng người mới bắt đầu. Bài học kết hợp luyện phát âm, hoạt động theo cặp và phản hồi cá nhân. Hồ sơ minh họa cho đồ án.`,
        achievements: `Biên soạn học liệu ${lang.name.toLocaleLowerCase("vi")} nhập môn\nThiết kế bộ hội thoại theo tình huống đời sống\nPhụ trách câu lạc bộ giao tiếp và hoạt động tìm hiểu văn hóa`,
      }));
    for (const [track, category] of ["Căn bản", "Giao tiếp"].entries()) {
      const courseName = `${lang.name} ${track ? "giao tiếp" : "nhập môn"}`;
      const existing = await db
        .prepare("SELECT id FROM courses WHERE name=? AND language=?")
        .get(courseName, code);
      const courseId =
        existing?.id ||
        (await insert("courses", {
          name: courseName,
          language: code,
          category,
          level: track ? "Sơ cấp" : "Nhập môn",
          duration: 12,
          lessons: 24,
          tuition: 2600000 + (index % 5) * 200000 + track * 400000,
          audience:
            code === "vi"
              ? "Người nước ngoài học tiếng Việt"
              : "Từ 16 tuổi · Sinh viên & người đi làm",
          image: `/images/language-${code}.svg`,
          description: track
            ? `Thực hành ${lang.name.toLocaleLowerCase("vi")} trong giới thiệu bản thân, mua sắm, du lịch và công việc. Luyện nghe nói theo cặp, học mẫu câu và nhận phản hồi sau mỗi buổi.`
            : `Làm quen âm, chữ viết và từ vựng ${lang.name.toLocaleLowerCase("vi")}. Xây nền tảng nghe, nói, đọc, viết qua các chủ đề gần gũi, dành cho người bắt đầu từ đầu.`,
          material: `Tuần 1–4: Phát âm, chữ viết và lời chào ${lang.greeting}.\nTuần 5–8: Gia đình, số đếm, thời gian và sinh hoạt.\nTuần 9–12: Hội thoại thực tế, ôn tập và dự án cuối khóa.`,
        }));
      const shifts = [
        [[1, 3], track ? "10:00" : "08:00", track ? "11:30" : "09:30", "SANG"],
        [[2, 4], track ? "20:00" : "18:30", track ? "21:30" : "20:00", "TOI"],
        [
          [6, 7],
          track ? "10:15" : "08:00",
          track ? "12:15" : "10:00",
          "CUOITUAN",
        ],
      ];
      for (const [weekdays, startTime, endTime, shift] of shifts) {
        const className = `${code.toUpperCase()}-${track ? "GT" : "CB"}-${shift}`;
        if (
          await db.prepare("SELECT 1 FROM classes WHERE name=?").get(className)
        )
          continue;
        const cls = {
          courseId,
          teacherId,
          name: className,
          startDate: day(14),
          endDate: day(98),
          weekdays,
          startTime,
          endTime,
          campus: index % 2 ? "Cơ sở Quang Trung" : "Cơ sở Lê Lợi",
          room: `NN${index + 1}`,
          capacity: 18,
          status: "enrolling",
        };
        await insert("classes", { ...cls, schedule: formatSchedule(cls) });
      }
    }
    for (let n = 0; n < meanings.length; n++) {
      const values = code === "vi" ? english : meanings;
      const options = Array.from(
        { length: 4 },
        (_, k) => values[(n + k) % values.length],
      );
      const answer = n % 4;
      [options[0], options[answer]] = [options[answer], options[0]];
      await insert("questions", {
        language: code,
        prompt: `${lang.name}: “${vocabulary[code][n]}” có nghĩa là gì${code === "vi" ? " trong tiếng Anh" : ""}?`,
        options,
        answer,
      });
    }
  }
  await db
    .prepare("INSERT INTO metadata(key,value) VALUES ('multilingual-v1','1')")
    .run();
  return { added: true };
}
