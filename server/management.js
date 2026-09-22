import { z } from "zod";
import ExcelJS from "exceljs";
import yauzl from "yauzl";
import { fail, assertUniqueEnrollment, classStatus, today } from "./domain.js";
import { hashPassword, safeUser } from "./db.js";

const uploadSchema = z.object({
  classId: z.number().int().positive(),
  title: z.string().trim().min(1).max(200),
  lesson: z.string().trim().max(100).default(""),
  filename: z
    .string()
    .min(1)
    .max(180)
    .refine(
      (s) => !/[\\/]/.test(s) && [...s].every((c) => c.charCodeAt(0) >= 32),
    ),
  content: z.string().min(1).max(7_000_000),
});
async function fileMime(filename, content) {
  if (
    /\.pdf$/i.test(filename) &&
    content.subarray(0, 5).toString() === "%PDF-" &&
    content.subarray(-1024).toString().includes("%%EOF")
  )
    return "application/pdf";
  if (!/\.docx$/i.test(filename))
    throw fail(400, "Chỉ chấp nhận PDF hoặc DOCX có nội dung hợp lệ.");
  await new Promise((resolve, reject) =>
    yauzl.fromBuffer(
      content,
      { lazyEntries: true, validateEntrySizes: true },
      (error, zip) => {
        if (error) return reject(fail(400, "Tệp DOCX không hợp lệ."));
        const names = new Set();
        let size = 0,
          count = 0;
        const invalid = () => {
          zip.close();
          reject(fail(400, "Tệp DOCX không hợp lệ hoặc vượt giới hạn."));
        };
        zip.on("error", invalid);
        zip.on("entry", (entry) => {
          size += entry.uncompressedSize;
          count++;
          if (
            size > 30 * 1024 * 1024 ||
            count > 2000 ||
            entry.generalPurposeBitFlag & 1 ||
            /vbaProject|\.exe$|\.bin$/i.test(entry.fileName)
          )
            return invalid();
          names.add(entry.fileName);
          zip.readEntry();
        });
        zip.on("end", () =>
          names.has("[Content_Types].xml") && names.has("word/document.xml")
            ? resolve()
            : reject(fail(400, "Tệp không phải tài liệu DOCX.")),
        );
        zip.readEntry();
      },
    ),
  );
  return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
}
export function mountManagement(app, { db, requireUser, one, write }) {
  const audit = (req, action, resource, id) =>
    db
      .prepare(
        "INSERT INTO audit_logs(actorId,action,resource,recordId) VALUES (?,?,?,?)",
      )
      .run(req.user.id, action, resource, id);
  app.post("/api/admin/enrollments/:id/intake", (req, res) => {
    const data = z
      .object({
        verified: z.literal(true, {
          error: "Cần xác nhận đã xác minh thông tin học viên.",
        }),
        mode: z.enum(["create", "existing"]),
        userId: z.number().int().positive().optional(),
        password: z.string().min(10).max(128).optional(),
      })
      .parse(req.body);
    const enrollment = one("enrollments", req.params.id);
    if (!enrollment) throw fail(404, "Không tìm thấy đăng ký.");
    if (enrollment.status === "cancelled") throw fail(409, "Đăng ký đã hủy.");
    if (enrollment.userId) throw fail(409, "Đăng ký đã liên kết tài khoản.");
    db.exec("BEGIN IMMEDIATE");
    try {
      let user;
      if (data.mode === "existing") {
        user = one("users", data.userId ?? 0);
        if (user?.role !== "student")
          throw fail(400, "Hãy chọn tài khoản học viên.");
      } else {
        if (!data.password)
          throw fail(400, "Vui lòng đặt mật khẩu ban đầu, ít nhất 10 ký tự.");
        const id = write("users", {
          name: enrollment.name,
          email: enrollment.email,
          phone: enrollment.phone,
          birthday: enrollment.birthday,
          passwordHash: hashPassword(data.password),
          role: "student",
        });
        user = one("users", id);
      }
      assertUniqueEnrollment(
        db,
        { ...enrollment, userId: user.id },
        enrollment.id,
      );
      write(
        "enrollments",
        {
          userId: user.id,
          verifiedAt: new Date().toISOString(),
          verifiedBy: req.user.id,
        },
        enrollment.id,
      );
      audit(req, "intake", "enrollments", enrollment.id);
      db.exec("COMMIT");
      res.json({
        user: safeUser(user),
        enrollment: one("enrollments", enrollment.id),
      });
    } catch (e) {
      db.exec("ROLLBACK");
      throw e;
    }
  });
  app.get("/api/admin/materials", (_req, res) =>
    res.json(
      db
        .prepare(
          "SELECT id,classId,title,lesson,filename,mime,size,createdAt FROM materials ORDER BY id DESC",
        )
        .all(),
    ),
  );
  app.post("/api/admin/materials", async (req, res) => {
    const data = uploadSchema.parse(req.body),
      content = Buffer.from(data.content, "base64");
    if (content.length > 5 * 1024 * 1024) throw fail(413, "Tệp tối đa 5 MB.");
    if (content.toString("base64") !== data.content)
      throw fail(400, "Dữ liệu tệp không hợp lệ.");
    if (!one("classes", data.classId)) throw fail(404, "Không tìm thấy lớp.");
    const mime = await fileMime(data.filename, content);
    const id = Number(
      db
        .prepare(
          "INSERT INTO materials(classId,title,lesson,filename,mime,size,content) VALUES (?,?,?,?,?,?,?)",
        )
        .run(
          data.classId,
          data.title,
          data.lesson,
          data.filename,
          mime,
          content.length,
          content,
        ).lastInsertRowid,
    );
    audit(req, "upload", "materials", id);
    res
      .status(201)
      .json({
        id,
        classId: data.classId,
        title: data.title,
        lesson: data.lesson,
        filename: data.filename,
        mime,
        size: content.length,
      });
  });
  app.delete("/api/admin/materials/:id", (req, res) => {
    const row = db
      .prepare("SELECT id FROM materials WHERE id=?")
      .get(req.params.id);
    if (!row) throw fail(404, "Không tìm thấy tài liệu.");
    db.prepare("DELETE FROM materials WHERE id=?").run(req.params.id);
    audit(req, "delete", "materials", row.id);
    res.json({ ok: true });
  });
  app.get("/api/materials/:id/download", requireUser, (req, res) => {
    const row = db
      .prepare("SELECT * FROM materials WHERE id=?")
      .get(req.params.id);
    if (!row) throw fail(404, "Không tìm thấy tài liệu.");
    if (
      req.user.role !== "admin" &&
      !db
        .prepare(
          "SELECT 1 FROM enrollments WHERE userId=? AND classId=? AND status='confirmed'",
        )
        .get(req.user.id, row.classId)
    )
      throw fail(
        403,
        "Tài liệu chỉ dành cho học viên đã được xác nhận vào lớp.",
      );
    res.set("Content-Type", row.mime);
    res.set(
      "Content-Disposition",
      `attachment; filename="material-${row.id}${row.mime === "application/pdf" ? ".pdf" : ".docx"}"; filename*=UTF-8''${encodeURIComponent(row.filename)}`,
    );
    res.set("Cache-Control", "no-store");
    res.send(Buffer.from(row.content));
  });
  const report = (query) => {
    const year = today().slice(0, 4),
      from = query.from || `${year}-01-01`,
      to = query.to || `${year}-12-31`;
    const valid = (s) =>
      typeof s === "string" &&
      /^\d{4}-\d{2}-\d{2}$/.test(s) &&
      !Number.isNaN(Date.parse(s)) &&
      new Date(s).toISOString().slice(0, 10) === s;
    if (
      !valid(from) ||
      !valid(to) ||
      from > to ||
      (Date.parse(to) - Date.parse(from)) / 86400000 > 1826
    )
      throw fail(400, "Chọn khoảng ngày hợp lệ, tối đa 5 năm.");
    const stats = db
      .prepare(
        "SELECT strftime('%Y-%m',datetime(createdAt,'+7 hours')) month,COUNT(*) total,SUM(status='confirmed') confirmed,SUM(status='pending') pending,SUM(status='cancelled') cancelled FROM enrollments WHERE date(createdAt,'+7 hours') BETWEEN ? AND ? GROUP BY month ORDER BY month",
      )
      .all(from, to);
    const monthly = [];
    const cursor = new Date(`${from.slice(0, 7)}-01T00:00:00Z`);
    while (cursor.toISOString().slice(0, 7) <= to.slice(0, 7)) {
      const month = cursor.toISOString().slice(0, 7);
      monthly.push(
        stats.find((s) => s.month === month) || {
          month,
          total: 0,
          confirmed: 0,
          pending: 0,
          cancelled: 0,
        },
      );
      cursor.setUTCMonth(cursor.getUTCMonth() + 1);
    }
    const classes = db
      .prepare(
        "SELECT c.*,co.name courseName,t.name teacherName,COUNT(e.id) enrolled FROM classes c JOIN courses co ON co.id=c.courseId JOIN teachers t ON t.id=c.teacherId LEFT JOIN enrollments e ON e.classId=c.id AND e.status='confirmed' GROUP BY c.id ORDER BY c.startDate",
      )
      .all()
      .map((c) => ({
        ...c,
        weekdays: JSON.parse(c.weekdays),
        effectiveStatus: classStatus(c),
      }));
    return { from, to, monthly, classes };
  };
  app.get("/api/admin/reports", (req, res) => res.json(report(req.query)));
  app.get("/api/admin/reports/export.xlsx", async (req, res) => {
    const data = report(req.query),
      workbook = new ExcelJS.Workbook();
    workbook.creator = "Vinh English Center";
    const addSheet = (name, columns, rows) => {
      const sheet = workbook.addWorksheet(name);
      sheet.columns = columns.map(([key, header, width]) => ({
        key,
        header,
        width,
      }));
      for (const row of rows) sheet.addRow(row);
      sheet.getRow(1).font = { bold: true, color: { argb: "FFFFFFFF" } };
      sheet.getRow(1).fill = {
        type: "pattern",
        pattern: "solid",
        fgColor: { argb: "FF17634D" },
      };
      sheet.views = [{ state: "frozen", ySplit: 1 }];
      sheet.autoFilter = {
        from: { row: 1, column: 1 },
        to: { row: 1, column: columns.length },
      };
      return sheet;
    };
    addSheet(
      "Dang ky theo thang",
      [
        ["month", "Tháng", 15],
        ["total", "Tổng đăng ký", 18],
        ["confirmed", "Đã xác nhận", 18],
        ["pending", "Chờ xác nhận", 18],
        ["cancelled", "Đã hủy", 15],
      ],
      data.monthly,
    );
    addSheet(
      "Si so lop",
      [
        ["name", "Mã lớp", 18],
        ["courseName", "Khóa học", 30],
        ["teacherName", "Giáo viên", 25],
        ["schedule", "Lịch học", 40],
        ["campus", "Cơ sở", 30],
        ["room", "Phòng", 15],
        ["enrolled", "Đã xác nhận", 18],
        ["capacity", "Sĩ số tối đa", 18],
      ],
      data.classes,
    );
    const members = db
      .prepare(
        "SELECT e.id,e.name,e.email,e.phone,c.name className,e.status,e.createdAt FROM enrollments e JOIN classes c ON c.id=e.classId WHERE date(e.createdAt,'+7 hours') BETWEEN ? AND ? ORDER BY c.id,e.id",
      )
      .all(data.from, data.to);
    const labels = {
      pending: "Chờ xác nhận",
      confirmed: "Đã xác nhận",
      cancelled: "Đã hủy",
    };
    addSheet(
      "Danh sach dang ky",
      [
        ["id", "Mã đăng ký", 16],
        ["name", "Họ và tên", 28],
        ["email", "Email", 35],
        ["phone", "Điện thoại", 20],
        ["className", "Mã lớp", 18],
        ["status", "Trạng thái", 22],
        ["createdAt", "Ngày tạo (UTC)", 24],
      ],
      members.map((m) => ({ ...m, status: labels[m.status] })),
    );
    res.set(
      "Content-Type",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    );
    res.set(
      "Content-Disposition",
      'attachment; filename="bao-cao-vinh-english.xlsx"',
    );
    res.send(Buffer.from(await workbook.xlsx.writeBuffer()));
  });
}
