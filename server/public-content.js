import { assertSchedule, formatSchedule, today } from "./domain.js";

const toeic = {
  name: "TOEIC 650+",
  category: "TOEIC",
  level: "A2 – B1",
  duration: 12,
  tuition: 3600000,
  lessons: 24,
  audience: "Sinh viên & người đi làm",
  image: "/images/work.jpg",
  description:
    "Củng cố ngữ pháp, từ vựng công sở và kỹ năng nghe, đọc theo định dạng TOEIC Listening & Reading. Mục tiêu 650+ được điều chỉnh sau kiểm tra đầu vào, không phải cam kết điểm thi.",
  material:
    "Tuần 1–4: ngữ pháp nền tảng và từ vựng công sở.\nTuần 5–8: luyện nghe hội thoại, đọc email và thông báo.\nTuần 9–12: luyện đề theo thời gian và phân tích lỗi.",
};
const extraQuestions = [
  [
    "Please send the report _____ Friday.",
    ["by", "onward", "during", "within"],
    0,
  ],
  [
    "The train was delayed, _____ we arrived late.",
    ["because", "so", "although", "unless"],
    1,
  ],
  [
    "Could you _____ me your pen for a moment?",
    ["borrow", "owe", "lend", "rent"],
    2,
  ],
  [
    "This is the restaurant _____ we had lunch.",
    ["which", "who", "whose", "where"],
    3,
  ],
  [
    "The instructions were clear enough for everyone _____.",
    ["understand", "understood", "to understand", "understanding"],
    2,
  ],
  ["Neither of the answers _____ correct.", ["is", "are", "be", "being"], 0],
  [
    "We look forward to _____ you next week.",
    ["meet", "meeting", "met", "have met"],
    1,
  ],
  [
    "The meeting has been postponed. It will take place _____.",
    ["earlier", "never", "at the same time", "later"],
    3,
  ],
  [
    "Notice: The library closes at 5 p.m. today. When must visitors leave?",
    ["Before 5 a.m.", "After 6 p.m.", "By 5 p.m.", "Tomorrow morning"],
    2,
  ],
  [
    "Email: Please confirm your attendance by replying to this message. What should the reader do?",
    ["Send a reply", "Cancel the event", "Call a taxi", "Print a receipt"],
    0,
  ],
];

export function classDates(weekdays, lessons, referenceDate = today()) {
  const cursor = new Date(`${referenceDate}T00:00:00Z`);
  cursor.setUTCDate(cursor.getUTCDate() + 14);
  let startDate,
    endDate,
    count = 0;
  while (count < lessons) {
    if (weekdays.includes(cursor.getUTCDay() || 7)) {
      startDate ??= cursor.toISOString().slice(0, 10);
      endDate = cursor.toISOString().slice(0, 10);
      count++;
    }
    cursor.setUTCDate(cursor.getUTCDate() + 1);
  }
  return { startDate, endDate };
}

// Explicit sample update: preserve existing records and never depend on fixed IDs.
export function addPublicContent(db) {
  const result = { courses: 0, classes: 0, questions: 0, teachers: 0 };
  if (db.prepare("SELECT 1 FROM metadata WHERE key='public-content-v1'").get())
    return result;
  const insert = (table, data) => {
    const keys = Object.keys(data);
    return Number(
      db
        .prepare(
          `INSERT INTO ${table}(${keys.join(",")}) VALUES(${keys.map(() => "?").join(",")})`,
        )
        .run(
          ...keys.map((key) =>
            Array.isArray(data[key]) ? JSON.stringify(data[key]) : data[key],
          ),
        ).lastInsertRowid,
    );
  };
  db.exec("BEGIN IMMEDIATE");
  try {
    let course = db
      .prepare("SELECT * FROM courses WHERE name=?")
      .get(toeic.name);
    if (!course) {
      course = { ...toeic, id: insert("courses", toeic) };
      result.courses++;
    }
    for (const [prompt, options, answer] of extraQuestions) {
      if (!db.prepare("SELECT 1 FROM questions WHERE prompt=?").get(prompt)) {
        insert("questions", { prompt, options, answer });
        result.questions++;
      }
    }
    const profiles = [
      "Nguyễn Minh Anh",
      "Trần Thảo Linh",
      "Lê Hoàng Nam",
      "Phạm Thu Hà",
      "Nguyễn Mai Chi",
      "Trần Gia Bảo",
      "Đặng Ngọc Lan",
      "Võ Quốc Huy",
    ];
    for (const name of [...profiles, "David Wilson"]) {
      result.teachers += Number(
        db
          .prepare(
            "UPDATE teachers SET nationality=? WHERE name=? AND nationality=''",
          )
          .run(name === "David Wilson" ? "Vương quốc Anh" : "Việt Nam", name)
          .changes,
      );
    }
    const teacher = db
      .prepare("SELECT id FROM teachers WHERE name='Võ Quốc Huy'")
      .get();
    if (!teacher)
      throw new Error(
        "Cần bổ sung hồ sơ giáo viên Võ Quốc Huy trước khi tạo lớp TOEIC.",
      );
    for (const [name, weekdays, startTime, endTime, campus] of [
      ["TOEIC-TOI-01", [2, 4], "18:30", "20:30", "Cơ sở Lê Lợi"],
      ["TOEIC-SANG-02", [6, 7], "08:00", "10:00", "Cơ sở Nguyễn Văn Cừ"],
    ]) {
      if (db.prepare("SELECT 1 FROM classes WHERE name=?").get(name)) continue;
      const row = {
        courseId: course.id,
        teacherId: teacher.id,
        name,
        weekdays,
        startTime,
        endTime,
        campus,
        room: "TOEIC-01",
        capacity: 18,
        status: "enrolling",
        ...classDates(weekdays, course.lessons),
      };
      row.schedule = formatSchedule(row);
      assertSchedule(db, row);
      insert("classes", row);
      result.classes++;
    }
    db.prepare(
      "INSERT INTO metadata(key,value) VALUES('public-content-v1','1')",
    ).run();
    db.exec("COMMIT");
    return result;
  } catch (error) {
    db.exec("ROLLBACK");
    throw error;
  }
}
