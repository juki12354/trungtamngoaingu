import { resolve } from "node:path";
import { pathToFileURL } from "node:url";
import { openDatabase } from "../server/db.js";
import { assertSchedule, formatSchedule, today } from "../server/domain.js";
import { schemas } from "../server/schemas.js";

// Each course gets three additional choices. Weekdays use ISO 1=Monday, 7=Sunday.
const options = [
  [1, 1, "IELTS-OPT-TOI", [2, 4], "18:00", "20:00", "Cơ sở Lê Lợi", "201", 18],
  [
    1,
    1,
    "IELTS-OPT-SANG-CN",
    [6, 7],
    "08:00",
    "10:00",
    "Cơ sở Lê Lợi",
    "201",
    18,
  ],
  [
    1,
    1,
    "IELTS-OPT-CHIEU-CN",
    [6, 7],
    "14:00",
    "16:00",
    "Cơ sở Lê Lợi",
    "201",
    18,
  ],
  [
    2,
    2,
    "GT-OPT-SANG",
    [1, 3],
    "08:00",
    "10:00",
    "Cơ sở Nguyễn Văn Cừ",
    "101",
    18,
  ],
  [
    2,
    2,
    "GT-OPT-TOI",
    [1, 3],
    "18:30",
    "20:30",
    "Cơ sở Nguyễn Văn Cừ",
    "101",
    18,
  ],
  [
    2,
    2,
    "GT-OPT-CHIEU-CN",
    [6, 7],
    "14:00",
    "16:00",
    "Cơ sở Nguyễn Văn Cừ",
    "101",
    18,
  ],
  [
    3,
    3,
    "KIDS-OPT-SAU-GIO-HOC",
    [2, 4],
    "17:00",
    "18:30",
    "Cơ sở Lê Lợi",
    "101",
    15,
  ],
  [
    3,
    3,
    "KIDS-OPT-SANG-CN",
    [6, 7],
    "08:00",
    "09:30",
    "Cơ sở Lê Lợi",
    "101",
    15,
  ],
  [
    3,
    3,
    "KIDS-OPT-CHIEU-CN",
    [6, 7],
    "15:00",
    "16:30",
    "Cơ sở Lê Lợi",
    "101",
    15,
  ],
  [
    4,
    3,
    "TEEN-OPT-SAU-GIO-HOC",
    [1, 3],
    "16:30",
    "18:00",
    "Cơ sở Lê Lợi",
    "102",
    18,
  ],
  [4, 3, "TEEN-OPT-TOI", [5, 7], "18:30", "20:00", "Cơ sở Lê Lợi", "102", 18],
  [
    4,
    3,
    "TEEN-OPT-SANG-CN",
    [6, 7],
    "09:45",
    "11:15",
    "Cơ sở Lê Lợi",
    "102",
    18,
  ],
  [5, 1, "CB-OPT-SANG", [2, 4], "08:00", "10:00", "Cơ sở Lê Lợi", "202", 18],
  [5, 1, "CB-OPT-CHIEU", [2, 4], "14:00", "16:00", "Cơ sở Lê Lợi", "202", 18],
  [5, 1, "CB-OPT-SANG-CN", [6, 7], "10:15", "12:15", "Cơ sở Lê Lợi", "202", 18],
  [
    6,
    2,
    "WORK-OPT-TRUA",
    [1, 3],
    "12:00",
    "13:30",
    "Cơ sở Nguyễn Văn Cừ",
    "102",
    18,
  ],
  [
    6,
    2,
    "WORK-OPT-TOI",
    [5, 7],
    "19:00",
    "21:00",
    "Cơ sở Nguyễn Văn Cừ",
    "102",
    18,
  ],
  [
    6,
    2,
    "WORK-OPT-SANG-CN",
    [6, 7],
    "10:30",
    "12:30",
    "Cơ sở Nguyễn Văn Cừ",
    "102",
    18,
  ],
];
function courseDates(weekdays, lessons, referenceDate) {
  if (!Number.isInteger(lessons) || lessons < 1 || lessons > 500)
    throw new Error("Số buổi của khóa học không hợp lệ.");
  const cursor = new Date(`${referenceDate}T00:00:00Z`);
  cursor.setUTCDate(cursor.getUTCDate() + 14);
  let startDate,
    endDate,
    count = 0;
  while (count < lessons) {
    if (weekdays.includes(cursor.getUTCDay() || 7)) {
      const date = cursor.toISOString().slice(0, 10);
      startDate ??= date;
      endDate = date;
      count++;
    }
    cursor.setUTCDate(cursor.getUTCDate() + 1);
  }
  return { startDate, endDate };
}
export function addClassOptions(db, referenceDate = today()) {
  const added = [],
    adjusted = [];
  db.exec("BEGIN IMMEDIATE");
  try {
    // Correct the two old sample collisions only when no learner has registered.
    for (const [
      name,
      teacherId,
      weekdays,
      oldStart,
      oldEnd,
      startTime,
      endTime,
      room,
    ] of [
      ["CB-05", 1, [1, 3], "18:30", "20:30", "16:00", "18:00", "202"],
      ["WORK-06", 2, [2, 4], "19:00", "21:00", "17:00", "18:30", "102"],
    ]) {
      const row = db.prepare("SELECT * FROM classes WHERE name=?").get(name);
      if (
        !row ||
        row.teacherId !== teacherId ||
        row.startTime !== oldStart ||
        row.endTime !== oldEnd ||
        row.weekdays !== JSON.stringify(weekdays)
      )
        continue;
      if (db.prepare("SELECT 1 FROM enrollments WHERE classId=?").get(row.id))
        continue;
      const updated = { ...row, weekdays, startTime, endTime, room };
      assertSchedule(db, updated, row.id);
      db.prepare(
        "UPDATE classes SET startTime=?,endTime=?,room=?,schedule=? WHERE id=?",
      ).run(startTime, endTime, room, formatSchedule(updated), row.id);
      adjusted.push(name);
    }
    for (const [
      courseId,
      teacherId,
      name,
      weekdays,
      startTime,
      endTime,
      campus,
      room,
      capacity,
    ] of options) {
      if (db.prepare("SELECT 1 FROM classes WHERE name=?").get(name)) continue;
      const course = db
        .prepare("SELECT * FROM courses WHERE id=?")
        .get(courseId);
      if (!course) throw new Error(`Không tìm thấy khóa học #${courseId}.`);
      const row = schemas.classes.parse({
        courseId,
        teacherId,
        name,
        weekdays,
        startTime,
        endTime,
        campus,
        room,
        capacity,
        status: "enrolling",
        ...courseDates(weekdays, course.lessons, referenceDate),
      });
      row.schedule = formatSchedule(row);
      assertSchedule(db, row);
      const columns = Object.keys(row);
      db.prepare(
        `INSERT INTO classes(${columns.join(",")}) VALUES(${columns.map(() => "?").join(",")})`,
      ).run(
        ...columns.map((k) =>
          Array.isArray(row[k]) ? JSON.stringify(row[k]) : row[k],
        ),
      );
      added.push(name);
    }
    db.exec("COMMIT");
    return { added, adjusted };
  } catch (error) {
    db.exec("ROLLBACK");
    throw error;
  }
}
if (
  process.argv[1] &&
  import.meta.url === pathToFileURL(resolve(process.argv[1])).href
) {
  const db = openDatabase(process.env.DB_PATH || "data/center.sqlite", false);
  try {
    const result = addClassOptions(db);
    console.log(
      `Đã thêm ${result.added.length} lớp, điều chỉnh ${result.adjusted.length} ca mẫu chưa có đăng ký.`,
    );
  } finally {
    db.close();
  }
}
