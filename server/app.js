import express from "express";
import helmet from "helmet";
import { rateLimit } from "express-rate-limit";
import { randomBytes, createHash } from "node:crypto";
import { resolve } from "node:path";
import { existsSync } from "node:fs";
import { ZodError } from "zod";
import { openDatabase, safeUser, hashPassword, verifyPassword } from "./db.js";
import * as validation from "./schemas.js";
import {
  assertEnrolling,
  assertSchedule,
  assertUniqueEnrollment,
  classStatus,
  formatSchedule,
} from "./domain.js";
import { mountPlacement } from "./placement.js";
import { campuses } from "./campuses.js";
import { mountManagement } from "./management.js";

const fail = (status, message) => Object.assign(new Error(message), { status });
const digest = (token) => createHash("sha256").update(token).digest("hex");
const parseRow = (row) =>
  row &&
  Object.fromEntries(
    Object.entries(row).map(([key, value]) => [
      key,
      ["options", "grades", "weekdays", "review"].includes(key)
        ? JSON.parse(value)
        : value,
    ]),
  );
export function createApp({
  dbPath = resolve("data/center.sqlite"),
  demo = process.env.NODE_ENV !== "production",
} = {}) {
  const db = openDatabase(dbPath, demo);
  const app = express();
  app.locals.db = db;
  app.disable("x-powered-by");
  app.use(
    helmet({
      contentSecurityPolicy: {
        directives: {
          "img-src": ["'self'", "https:", "data:"],
          "script-src": ["'self'"],
          "style-src": ["'self'", "'unsafe-inline'"],
          "upgrade-insecure-requests": null,
        },
      },
      strictTransportSecurity:
        process.env.NODE_ENV === "production" ? undefined : false,
    }),
  );
  app.use("/api/admin/materials", express.json({ limit: "8mb" }));
  app.use(express.json({ limit: "100kb" }));
  app.use("/api", (req, res, next) => {
    res.set("Cache-Control", "no-store");
    if (
      !["GET", "HEAD", "OPTIONS"].includes(req.method) &&
      req.headers.origin
    ) {
      try {
        if (new URL(req.headers.origin).host !== req.headers.host)
          throw new Error();
      } catch {
        return next(fail(403, "Nguồn yêu cầu không được phép."));
      }
    }
    const raw = req.headers.cookie
      ?.split(";")
      .map((v) => v.trim())
      .find((v) => v.startsWith("vec_session="))
      ?.slice(12);
    req.sessionToken = raw ? digest(raw) : null;
    req.user = req.sessionToken
      ? db
          .prepare(
            "SELECT users.* FROM sessions JOIN users ON users.id=sessions.userId WHERE token=? AND expires>?",
          )
          .get(req.sessionToken, Date.now())
      : null;
    next();
  });
  const requireUser = (req, _res, next) =>
    next(req.user ? null : fail(401, "Vui lòng đăng nhập để tiếp tục."));
  const requireAdmin = (req, _res, next) =>
    next(
      req.user?.role === "admin"
        ? null
        : fail(403, "Bạn không có quyền quản trị."),
    );
  const authLimit = rateLimit({
    windowMs: 15 * 60 * 1000,
    limit: 40,
    standardHeaders: "draft-8",
    legacyHeaders: false,
    message: {
      error: {
        message: "Bạn thao tác quá nhiều lần. Vui lòng thử lại sau 15 phút.",
      },
    },
  });
  const submitLimit = rateLimit({
    windowMs: 15 * 60 * 1000,
    limit: 80,
    standardHeaders: "draft-8",
    legacyHeaders: false,
    message: { error: { message: "Vui lòng chờ trước khi gửi thêm yêu cầu." } },
  });
  const all = (table) =>
    db.prepare(`SELECT * FROM ${table} ORDER BY id DESC`).all().map(parseRow);
  const one = (table, id) =>
    parseRow(db.prepare(`SELECT * FROM ${table} WHERE id=?`).get(id));
  function write(table, data, id) {
    const keys = Object.keys(data);
    const values = keys.map((k) =>
      typeof data[k] === "object" && data[k] !== null
        ? JSON.stringify(data[k])
        : data[k],
    );
    if (id) {
      db.prepare(
        `UPDATE ${table} SET ${keys.map((k) => `${k}=?`).join(",")} WHERE id=?`,
      ).run(...values, id);
      return id;
    }
    return Number(
      db
        .prepare(
          `INSERT INTO ${table} (${keys.join(",")}) VALUES (${keys.map(() => "?").join(",")})`,
        )
        .run(...values).lastInsertRowid,
    );
  }
  function session(res, user) {
    db.prepare("DELETE FROM sessions WHERE expires<?").run(Date.now());
    const token = randomBytes(32).toString("hex");
    db.prepare("INSERT INTO sessions VALUES (?,?,?)").run(
      digest(token),
      user.id,
      Date.now() + 86400000,
    );
    res.cookie("vec_session", token, {
      httpOnly: true,
      sameSite: "lax",
      secure: process.env.NODE_ENV === "production",
      maxAge: 86400000,
      path: "/",
    });
    return safeUser(user);
  }
  const classList = () =>
    db
      .prepare(
        "SELECT classes.*, (SELECT count(*) FROM enrollments e WHERE e.classId=classes.id AND e.status='confirmed') AS enrolled FROM classes ORDER BY startDate",
      )
      .all()
      .map((row) => ({ ...parseRow(row), effectiveStatus: classStatus(row) }));
  app.get("/api/health", (_req, res) => res.json({ ok: true }));
  app.get("/api/catalog", (_req, res) =>
    res.json({
      courses: all("courses")
        .reverse()
        .map(({ material, ...c }) => c),
      teachers: all("teachers").reverse(),
      classes: classList(),
      news: all("news").reverse(),
      campuses,
    }),
  );
  app.get("/api/auth/me", (req, res) =>
    res.json({ user: safeUser(req.user), demo }),
  );
  app.post("/api/auth/register", authLimit, (req, res) => {
    const { password, ...data } = validation.register.parse(req.body);
    const id = write("users", {
      ...data,
      passwordHash: hashPassword(password),
      role: "student",
    });
    res.status(201).json({ user: session(res, one("users", id)) });
  });
  app.post("/api/auth/login", authLimit, (req, res) => {
    const data = validation.login.parse(req.body);
    const user = db
      .prepare("SELECT * FROM users WHERE email=?")
      .get(data.email);
    if (!user || !verifyPassword(data.password, user.passwordHash))
      throw fail(401, "Email hoặc mật khẩu chưa đúng.");
    if (req.sessionToken)
      db.prepare("DELETE FROM sessions WHERE token=?").run(req.sessionToken);
    res.json({ user: session(res, user) });
  });
  app.post("/api/auth/logout", (req, res) => {
    if (req.sessionToken)
      db.prepare("DELETE FROM sessions WHERE token=?").run(req.sessionToken);
    res.clearCookie("vec_session", { path: "/" });
    res.json({ ok: true });
  });
  app.post("/api/auth/password", requireUser, authLimit, (req, res) => {
    const { currentPassword, newPassword } = validation.changePassword.parse(
      req.body,
    );
    if (!verifyPassword(currentPassword, req.user.passwordHash))
      throw fail(400, "Mật khẩu hiện tại chưa đúng.");
    if (currentPassword === newPassword)
      throw fail(400, "Hãy chọn mật khẩu mới khác mật khẩu hiện tại.");
    db.exec("BEGIN IMMEDIATE");
    try {
      write("users", { passwordHash: hashPassword(newPassword) }, req.user.id);
      db.prepare("DELETE FROM sessions WHERE userId=?").run(req.user.id);
      db.exec("COMMIT");
    } catch (e) {
      db.exec("ROLLBACK");
      throw e;
    }
    res.clearCookie("vec_session", { path: "/" });
    res.json({ ok: true });
  });
  app.post("/api/enrollments", submitLimit, (req, res) => {
    const data = validation.enrollment.parse(req.body);
    const cls = one("classes", data.classId);
    assertEnrolling(cls);
    const count = db
      .prepare(
        "SELECT count(*) AS n FROM enrollments WHERE classId=? AND status='confirmed'",
      )
      .get(cls.id).n;
    if (count >= cls.capacity)
      throw fail(409, "Lớp đã đủ sĩ số. Vui lòng chọn lớp khác.");
    if (req.user) data.email = req.user.email;
    assertUniqueEnrollment(db, { ...data, userId: req.user?.id ?? null });
    const id = write("enrollments", { ...data, userId: req.user?.id ?? null });
    res.status(201).json({
      id,
      message: "Đăng ký thành công! Trung tâm sẽ liên hệ để xác nhận.",
    });
  });
  app.get("/api/questions", (_req, res) =>
    res.json(
      all("questions")
        .reverse()
        .map(({ answer, ...q }) => q),
    ),
  );
  mountPlacement(app, { db, submitLimit, all, write });
  app.post("/api/contact", submitLimit, (req, res) => {
    const data = validation.contact.parse(req.body);
    if (data.courseId && !one("courses", data.courseId))
      throw fail(400, "Khóa học quan tâm không còn tồn tại.");
    const id = write("contacts", data);
    res.status(201).json({ id });
  });
  app.get("/api/student", requireUser, (req, res) => {
    const enrollments = db
      .prepare("SELECT * FROM enrollments WHERE userId=? ORDER BY id DESC")
      .all(req.user.id)
      .map(parseRow);
    const courseIds = new Set(
      enrollments
        .filter((e) => e.status === "confirmed")
        .map((e) => one("classes", e.classId)?.courseId),
    );
    res.json({
      user: safeUser(req.user),
      enrollments,
      materials: all("courses")
        .filter((c) => courseIds.has(c.id))
        .map(({ id, name, material }) => ({ id, name, material })),
      files: db
        .prepare(
          "SELECT m.id,m.classId,m.title,m.lesson,m.filename,m.size,m.createdAt FROM materials m WHERE EXISTS(SELECT 1 FROM enrollments e WHERE e.userId=? AND e.classId=m.classId AND e.status='confirmed') ORDER BY m.id DESC",
        )
        .all(req.user.id),
      results: db
        .prepare(
          "SELECT * FROM placement_results WHERE userId=? ORDER BY id DESC",
        )
        .all(req.user.id)
        .map(parseRow),
    });
  });
  app.patch("/api/student", requireUser, (req, res) => {
    const data = validation.profile.parse(req.body);
    write("users", data, req.user.id);
    res.json({ user: safeUser(one("users", req.user.id)) });
  });
  app.use("/api/admin", requireUser, requireAdmin);
  mountManagement(app, { db, requireUser, one, write });
  app.get("/api/admin/overview", (_req, res) =>
    res.json({
      students: db
        .prepare("SELECT count(*) AS n FROM users WHERE role='student'")
        .get().n,
      courses: all("courses").length,
      teachers: all("teachers").length,
      classes: all("classes").length,
      pending: db
        .prepare("SELECT count(*) AS n FROM enrollments WHERE status='pending'")
        .get().n,
      enrollments: all("enrollments").slice(0, 5),
      contacts: all("contacts"),
    }),
  );
  app.param("resource", (req, _res, next, resource) => {
    if (!Object.hasOwn(validation.schemas, resource))
      return next(fail(404, "Không tìm thấy tài nguyên."));
    req.table = resource === "students" ? "users" : resource;
    next();
  });
  app.get("/api/admin/:resource", (req, res) => {
    const rows = req.table === "classes" ? classList() : all(req.table);
    res.json(
      req.table === "users"
        ? rows.filter((u) => u.role === "student").map(safeUser)
        : rows,
    );
  });
  function validateRelations(resource, data, id) {
    if (resource === "classes") {
      if (data.endDate < data.startDate)
        throw fail(400, "Ngày kết thúc phải sau ngày bắt đầu.");
      const count = db
        .prepare(
          "SELECT count(*) AS n FROM enrollments WHERE classId=? AND status='confirmed'",
        )
        .get(id ?? 0).n;
      if (data.capacity < count)
        throw fail(409, "Sĩ số mới nhỏ hơn số học viên đã xác nhận.");
      const previous = id ? one("classes", id) : null;
      const scheduleChanged =
        !previous ||
        [
          "teacherId",
          "startDate",
          "endDate",
          "campus",
          "room",
          "startTime",
          "endTime",
          "weekdays",
          "status",
        ].some(
          (key) => JSON.stringify(previous[key]) !== JSON.stringify(data[key]),
        );
      if (scheduleChanged && !["completed", "cancelled"].includes(data.status))
        assertSchedule(db, data, id);
      if (data.weekdays.length && data.startTime && data.endTime)
        data.schedule = formatSchedule(data);
    }
    if (resource === "enrollments") {
      const existing = one("enrollments", id);
      assertUniqueEnrollment(db, { ...existing, ...data }, id);
      if (data.userId != null && one("users", data.userId)?.role !== "student")
        throw fail(400, "Hãy chọn tài khoản học viên hợp lệ.");
      if (data.userId !== existing.userId)
        throw fail(
          409,
          "Hãy dùng Tiếp nhận học viên để xác minh và liên kết tài khoản.",
        );
      if (data.status === "confirmed" && existing.status !== "confirmed") {
        const cls = one("classes", one("enrollments", id).classId);
        assertEnrolling(cls);
        const count = db
          .prepare(
            "SELECT count(*) AS n FROM enrollments WHERE classId=? AND status='confirmed' AND id!=?",
          )
          .get(cls.id, Number(id)).n;
        if (count >= cls.capacity)
          throw fail(409, "Lớp đã đủ sĩ số. Không thể xác nhận thêm học viên.");
      }
    }
  }
  app.post("/api/admin/:resource", (req, res) => {
    if (["enrollments", "contacts"].includes(req.params.resource))
      throw fail(400, "Tạo đăng ký từ trang đăng ký lớp.");
    let data = validation.schemas[req.params.resource].parse(req.body);
    if (req.table === "users") {
      const { password, ...profile } = data;
      data = {
        ...profile,
        passwordHash: hashPassword(password),
        role: "student",
      };
    }
    validateRelations(req.params.resource, data);
    const id = write(req.table, data);
    const row = one(req.table, id);
    res.status(201).json(req.table === "users" ? safeUser(row) : row);
  });
  app.patch("/api/admin/:resource/:id", (req, res) => {
    const existing = one(req.table, req.params.id);
    if (!existing || (req.table === "users" && existing.role !== "student"))
      throw fail(404, "Không tìm thấy dữ liệu.");
    let data;
    if (req.table === "users") {
      const changes = validation.schemas.students.partial().parse(req.body);
      const { password, ...profile } = changes;
      data = {
        ...profile,
        ...(password ? { passwordHash: hashPassword(password) } : {}),
      };
    } else
      data = validation.schemas[req.params.resource].parse({
        ...existing,
        ...req.body,
      });
    if (!Object.keys(data).length) throw fail(400, "Không có thay đổi hợp lệ.");
    validateRelations(req.params.resource, data, req.params.id);
    write(req.table, data, req.params.id);
    if (req.table === "users" && data.passwordHash)
      db.prepare("DELETE FROM sessions WHERE userId=?").run(
        Number(req.params.id),
      );
    const row = one(req.table, req.params.id);
    res.json(req.table === "users" ? safeUser(row) : row);
  });
  app.delete("/api/admin/:resource/:id", (req, res) => {
    const row = one(req.table, req.params.id);
    if (!row || (req.table === "users" && row.role !== "student"))
      throw fail(404, "Không tìm thấy dữ liệu.");
    db.prepare(`DELETE FROM ${req.table} WHERE id=?`).run(req.params.id);
    res.json({ ok: true });
  });
  app.use("/api", (_req, _res, next) => next(fail(404, "Không tìm thấy API.")));
  if (existsSync(resolve("dist/index.html"))) {
    app.use(express.static(resolve("dist")));
    app.get("/{*path}", (_req, res) =>
      res.sendFile(resolve("dist/index.html")),
    );
  }
  app.use((error, _req, res, _next) => {
    if (error instanceof ZodError)
      return res.status(400).json({
        error: {
          message: error.issues[0]?.message || "Dữ liệu chưa hợp lệ.",
        },
      });
    if (error.message?.includes("UNIQUE constraint"))
      return res.status(409).json({
        error: {
          message: "Thông tin đã tồn tại hoặc bạn đã đăng ký lớp này.",
        },
      });
    if (error.message?.includes("FOREIGN KEY constraint"))
      return res.status(409).json({
        error: {
          message:
            "Dữ liệu đang liên kết với bản ghi khác hoặc lựa chọn không còn tồn tại.",
        },
      });
    if (error.status)
      return res.status(error.status).json({
        error: {
          message:
            error.status === 400 && error instanceof SyntaxError
              ? "Nội dung JSON không hợp lệ."
              : error.message,
        },
      });
    console.error(error);
    res
      .status(500)
      .json({ error: { message: "Có lỗi xử lý. Vui lòng thử lại." } });
  });
  return app;
}
