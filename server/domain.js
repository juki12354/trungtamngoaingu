export const fail = (status, message) =>
  Object.assign(new Error(message), { status });
export const today = () =>
  new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Ho_Chi_Minh",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(new Date());
export const classStatus = (cls) =>
  ["cancelled", "completed"].includes(cls.status)
    ? cls.status
    : cls.endDate < today()
      ? "completed"
      : cls.startDate <= today()
        ? "ongoing"
        : cls.status || "enrolling";
export function assertEnrolling(cls) {
  if (!cls) throw fail(404, "Lớp học không tồn tại.");
  if (classStatus(cls) !== "enrolling")
    throw fail(
      409,
      "Lớp không còn tuyển sinh. Vui lòng chọn lớp đang mở đăng ký.",
    );
}
export function formatSchedule(cls) {
  const days = [...cls.weekdays]
    .sort((a, b) => a - b)
    .map((d) => (d === 7 ? "Chủ nhật" : `Thứ ${d + 1}`));
  return `${days.join(", ")} · ${cls.startTime} – ${cls.endTime}`;
}
export function assertSchedule(db, cls, id) {
  if (
    !cls.weekdays.length ||
    !cls.startTime ||
    !cls.endTime ||
    !cls.room.trim()
  )
    throw fail(400, "Vui lòng chọn thứ, giờ học và phòng học.");
  if (cls.startTime >= cls.endTime)
    throw fail(400, "Giờ kết thúc phải sau giờ bắt đầu.");
  if (["completed", "cancelled"].includes(cls.status)) return;
  const candidates = db
    .prepare(
      "SELECT * FROM classes WHERE id != ? AND status NOT IN ('completed','cancelled') AND startDate <= ? AND endDate >= ?",
    )
    .all(Number(id || 0), cls.endDate, cls.startDate);
  for (const other of candidates) {
    if (!(
      cls.teacherId === other.teacherId ||
      (cls.campus.trim().toLowerCase() === other.campus.trim().toLowerCase() &&
        cls.room.trim().toLowerCase() === other.room.trim().toLowerCase())
    ))
      continue;
    if (cls.startTime >= other.endTime || cls.endTime <= other.startTime)
      continue;
    const shared = cls.weekdays.filter((d) =>
      JSON.parse(other.weekdays).includes(d),
    );
    const start = new Date(
      `${cls.startDate > other.startDate ? cls.startDate : other.startDate}T00:00:00Z`,
    );
    const end = cls.endDate < other.endDate ? cls.endDate : other.endDate;
    for (
      let n = 0;
      n < 7 && start.toISOString().slice(0, 10) <= end;
      n++, start.setUTCDate(start.getUTCDate() + 1)
    ) {
      if (shared.includes(start.getUTCDay() || 7))
        throw fail(
          409,
          `Trùng lịch giáo viên hoặc phòng với lớp ${other.name}.`,
        );
    }
  }
}
export function assertUniqueEnrollment(db, data, excludeId = 0) {
  if (data.status === "cancelled") return;
  const row = db
    .prepare(
      "SELECT id FROM enrollments WHERE classId=? AND status!='cancelled' AND id!=? AND (email=? OR (? IS NOT NULL AND userId=?))",
    )
    .get(
      data.classId,
      Number(excludeId),
      data.email,
      data.userId ?? null,
      data.userId ?? null,
    );
  if (row)
    throw fail(409, "Học viên đã có đăng ký đang hoạt động trong lớp này.");
}
