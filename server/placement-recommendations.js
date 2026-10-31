import { classStatus } from "./domain.js";
export async function recommendClasses(db, language, levelCode) {
  const courses = await db
    .prepare(
      "SELECT id,name,language,levelCode FROM courses WHERE language=? AND levelCode=? AND category NOT IN ('Trẻ em','Thiếu niên') ORDER BY id",
    )
    .all(language, levelCode);
  const ids = new Set(courses.map((c) => c.id));
  const rows = await db
    .prepare(
      `SELECT cl.*,c.language,c.levelCode,c.name AS courseName,t.name AS teacherName,
    (SELECT count(*) FROM enrollments e WHERE e.classId=cl.id AND e.status='confirmed') AS enrolled
    FROM classes cl JOIN courses c ON c.id=cl.courseId JOIN teachers t ON t.id=cl.teacherId
    WHERE c.language=? AND c.levelCode=? ORDER BY cl.startDate,cl.startTime,cl.id`,
    )
    .all(language, levelCode);
  const classes = rows
    .filter(
      (cls) =>
        ids.has(cls.courseId) &&
        classStatus(cls) === "enrolling" &&
        cls.enrolled < cls.capacity,
    )
    .slice(0, 9)
    .map((cls) => ({
      id: cls.id,
      name: cls.name,
      courseId: cls.courseId,
      courseName: cls.courseName,
      language: cls.language,
      levelCode: cls.levelCode,
      teacherName: cls.teacherName,
      startDate: cls.startDate,
      schedule: cls.schedule,
      campus: cls.campus,
      available: cls.capacity - cls.enrolled,
    }));
  return {
    courseId: classes[0]?.courseId ?? courses[0]?.id ?? null,
    classes,
    message: classes.length
      ? "Các lớp đúng ngôn ngữ và cấp độ, còn nhận đăng ký."
      : "Chưa có lớp đúng cấp độ đang nhận đăng ký. Hãy để lại yêu cầu tư vấn; hệ thống không chuyển sang lớp sai cấp độ.",
  };
}
