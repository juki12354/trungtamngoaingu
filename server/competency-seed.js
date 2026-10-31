import { languages } from "../shared/languages.js";
import { proficiencyFor } from "../shared/proficiency.js";
import { competencyContent } from "./competency-content.js";
import { checkSchedule, formatSchedule } from "./domain.js";

const meanings = [
  "xin chào",
  "lịch hẹn",
  "trách nhiệm",
  "bền vững",
  "sắc thái / khác biệt tinh tế",
  "nghịch lý",
  "nhận thức luận",
];
const englishMeanings = [
  "hello",
  "appointment",
  "responsibility",
  "sustainable",
  "nuance",
  "paradox",
];
const readingTasks = [
  [
    "Mục đích đến thư viện là gì?",
    "Mượn sách",
    "Mua vé",
    "Tìm việc",
    "Tham dự cuộc họp",
  ],
  [
    "Buổi dã ngoại được chuyển sang ngày nào?",
    "Chủ nhật",
    "Thứ Bảy",
    "Thứ Hai",
    "Thứ Sáu",
  ],
  [
    "Mai đã tham gia bao nhiêu buổi học?",
    "8 buổi",
    "2 buổi",
    "10 buổi",
    "12 buổi",
  ],
  [
    "Hạn chế chính của nghiên cứu là gì?",
    "Mẫu chỉ ở một thành phố, khó khái quát cho mọi nơi",
    "Không có người tham gia",
    "Đã khảo sát mọi nơi",
    "Kết quả luôn áp dụng toàn cầu",
  ],
  [
    "Quan điểm của tác giả về làm việc từ xa là gì?",
    "Ủng hộ có điều kiện về riêng tư và tiếp cận thông tin",
    "Ủng hộ bất kể quyền riêng tư",
    "Phản đối hoàn toàn",
    "Chỉ đề cập lương thưởng",
  ],
  [
    "Có thể rút ra nhận định nào?",
    "Thiếu bằng chứng chưa đủ chứng minh nhận định sai",
    "Không có bằng chứng thì chắc chắn sai",
    "Mọi nhận định đều đúng",
    "Không cần xem xét phương pháp nghiên cứu",
  ],
  [
    "Tác giả phân biệt điều gì?",
    "Khả năng giải thích và mức độ chắc chắn của kết luận",
    "Số người và số buổi học",
    "Địa điểm và lịch hẹn",
    "Mọi lý thuyết đều sai",
  ],
];
export function buildCompetencyQuestions(language) {
  const content = competencyContent[language];
  const { levels } = proficiencyFor(language);
  return levels.flatMap((level, index) => {
    const meaningIndex = language === "ja" ? [0, 1, 2, 4, 5][index] : index;
    const meaningList = language === "vi" ? englishMeanings : meanings;
    const correct = meaningList[meaningIndex];
    const vocabularyOptions = [
      correct,
      ...meaningList.filter((v) => v !== correct).slice(0, 3),
    ];
    const reading = readingTasks[meaningIndex];
    return [
      {
        skill: "vocabulary",
        prompt: `“${content.words[index]}” có nghĩa là gì${language === "vi" ? " trong tiếng Anh" : ""}?`,
        choices: vocabularyOptions,
      },
      {
        skill: "grammar",
        prompt: content.grammar[index][0],
        choices: content.grammar[index].slice(1),
      },
      {
        skill: "reading",
        prompt: `${content.readings[index]}\n\n${reading[0]}`,
        choices: reading.slice(1),
      },
    ].map((q, skillIndex) => {
      const options = [...q.choices],
        answer = (index * 3 + skillIndex) % 4;
      [options[0], options[answer]] = [options[answer], options[0]];
      return {
        language,
        levelCode: level.code,
        skill: q.skill,
        assessment: "competency",
        prompt: q.prompt,
        options,
        answer,
      };
    });
  });
}

export async function seedCompetency(db) {
  if (
    await db.prepare("SELECT 1 FROM metadata WHERE key='competency-v1'").get()
  )
    return;
  const insert = async (table, data) => {
    const keys = Object.keys(data);
    return Number(
      (
        await db
          .prepare(
            `INSERT INTO ${table} (${keys.join(",")}) VALUES (${keys.map(() => "?").join(",")})`,
          )
          .run(
            ...keys.map((k) =>
              typeof data[k] === "object" ? JSON.stringify(data[k]) : data[k],
            ),
          )
      ).lastInsertRowid,
    );
  };
  const day = (n) =>
    new Date(Date.now() + n * 86400000).toISOString().slice(0, 10);
  const groups = [[1, 3], [2, 4], [5], [6], [7], [6, 7]];
  const hours = ["08:00", "10:00", "13:30", "15:30", "18:00", "19:30"];
  const candidates = groups.flatMap((weekdays) =>
    hours.map((startTime) => ({ weekdays, startTime })),
  );
  const classCache = await db.prepare("SELECT * FROM classes").all();
  for (const lang of languages) {
    const { levels } = proficiencyFor(lang.code);
    const existing = await db
      .prepare("SELECT * FROM courses WHERE language=? ORDER BY id")
      .all(lang.code);
    for (const course of existing) {
      if (course.levelCode) continue;
      const index =
        lang.code === "en"
          ? ({
              "Căn bản": 0,
              "Trẻ em": 0,
              "Giao tiếp": 1,
              "Thiếu niên": 1,
              IELTS: 2,
              TOEIC: 2,
              "Đi làm": 3,
            }[course.category] ?? 0)
          : course.category === "Giao tiếp"
            ? 1
            : 0;
      const level = levels[index];
      await db
        .prepare("UPDATE courses SET levelCode=? WHERE id=?")
        .run(level.code, course.id);
      if (["Nhập môn", "Sơ cấp"].includes(course.level))
        await db
          .prepare("UPDATE courses SET level=? WHERE id=?")
          .run(level.label, course.id);
    }
    const teachers = (
      await db.prepare("SELECT * FROM teachers ORDER BY id").all()
    ).filter((t) => JSON.parse(t.languages).includes(lang.code));
    for (const level of levels) {
      if (
        await db
          .prepare("SELECT id FROM courses WHERE language=? AND levelCode=?")
          .get(lang.code, level.code)
      )
        continue;
      const courseId = await insert("courses", {
        language: lang.code,
        levelCode: level.code,
        name: `${lang.name} ${level.label}`,
        category: "Theo cấp độ",
        level: level.label,
        audience: "Từ 16 tuổi · Học tiếp theo nền tảng đã có",
        duration: 12,
        lessons: 24,
        tuition: 2800000 + level.rank * 200000,
        image: `/images/language-${lang.code}.svg`,
        description: `${level.description} Khóa ${lang.name.toLocaleLowerCase("vi")} hướng tới ${level.label}; cần trao đổi thêm với giáo viên khi xếp lớp.`,
        material: `Nghe nói, từ vựng, ngữ pháp và đọc viết theo lộ trình ${level.label}.\nÔn tập theo chủ đề, thực hành và đánh giá cuối khóa.`,
      });
      for (let shift = 0; shift < 3; shift++) {
        const preferred = [...candidates].sort((a, b) => {
          const weight = (c) =>
            shift === 0
              ? Number(c.startTime.slice(0, 2)) < 12
              : shift === 1
                ? Number(c.startTime.slice(0, 2)) >= 18
                : c.weekdays.every((d) => d >= 6);
          return Number(weight(b)) - Number(weight(a));
        });
        let created = false;
        for (const teacher of teachers) {
          for (const slot of preferred) {
            const [h, m] = slot.startTime.split(":").map(Number),
              end = h * 60 + m + 90;
            const cls = {
              courseId,
              teacherId: teacher.id,
              name: `${lang.code.toUpperCase()}-${level.code}-${shift + 1}`,
              startDate: day(21),
              endDate: day(105),
              ...slot,
              endTime: `${String(Math.floor(end / 60)).padStart(2, "0")}:${String(end % 60).padStart(2, "0")}`,
              campus: "Cơ sở Lê Lợi",
              room: `LV-${lang.code}-${level.code}`,
              capacity: 18,
              status: "enrolling",
            };
            try {
              checkSchedule(
                cls,
                classCache.filter(
                  (other) =>
                    !["completed", "cancelled"].includes(other.status) &&
                    other.startDate <= cls.endDate &&
                    other.endDate >= cls.startDate,
                ),
              );
            } catch (error) {
              if (error.status === 409) continue;
              throw error;
            }
            const id = await insert("classes", {
              ...cls,
              schedule: formatSchedule(cls),
            });
            classCache.push({
              ...cls,
              id,
              weekdays: JSON.stringify(cls.weekdays),
            });
            created = true;
            break;
          }
          if (created) break;
        }
        // A database with fully booked teachers can keep the course and await a real schedule.
        if (!created) break;
      }
    }
    for (const question of buildCompetencyQuestions(lang.code))
      await insert("questions", question);
  }
  await db
    .prepare("INSERT INTO metadata(key,value) VALUES ('competency-v1','1')")
    .run();
}
