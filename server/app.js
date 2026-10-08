import { mutation } from "./mutation.js";
import { connectDatabase } from "./database.js";
import express from "express";
import helmet from "helmet";
import { rateLimit } from "express-rate-limit";
import { randomBytes, createHash } from "node:crypto";
import { resolve } from "node:path";
import { existsSync } from "node:fs";
import { ZodError } from "zod";
import { safeUser, hashPassword, verifyPassword } from "./db.js";
import * as validation from "./schemas.js";
import {
  assertEnrolling,
  assertScheduleAsync as assertSchedule,
  assertUniqueEnrollment,
  classStatus,
  formatSchedule,
} from "./domain.js";
import { mountPlacement } from "./placement.js";
import { campuses } from "./campuses.js";
import { mountManagement } from "./management.js";
const fail = (status, message) =>
  Object.assign(new Error(message), {
    status,
  });
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
export async function createApp({
  databaseUrl,
  dbPath = resolve("data/center.sqlite"),
  demo = process.env.NODE_ENV !== "production",
} = {}) {
  const db = await connectDatabase({
    databaseUrl,
    dbPath,
    demo,
  });
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
  app.use(
    "/api/admin/materials",
    express.json({
      limit: "8mb",
    }),
  );
  app.use(
    express.json({
      limit: "100kb",
    }),
  );
  app.use("/api", async (req, res, next) => {
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
      ? await db
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
    message: {
      error: {
        message: "Vui lòng chờ trước khi gửi thêm yêu cầu.",
      },
    },
  });
  const all = async (table) =>
    (await db.prepare(`SELECT * FROM ${table} ORDER BY id DESC`).all()).map(
      parseRow,
    );
  const one = async (table, id) =>
    parseRow(await db.prepare(`SELECT * FROM ${table} WHERE id=?`).get(id));
  async function write(table, data, id) {
    const keys = Object.keys(data);
    const values = keys.map((k) =>
      typeof data[k] === "object" && data[k] !== null
        ? JSON.stringify(data[k])
        : data[k],
    );
    if (id) {
      await db
        .prepare(
          `UPDATE ${table} SET ${keys.map((k) => `${k}=?`).join(",")} WHERE id=?`,
        )
        .run(...values, id);
      return id;
    }
    return Number(
      (
        await db
          .prepare(
            `INSERT INTO ${table} (${keys.join(",")}) VALUES (${keys.map(() => "?").join(",")})`,
          )
          .run(...values)
      ).lastInsertRowid,
    );
  }
  async function session(res, user) {
    await db.prepare("DELETE FROM sessions WHERE expires<?").run(Date.now());
    const token = randomBytes(32).toString("hex");
    await db
      .prepare("INSERT INTO sessions VALUES (?,?,?)")
      .run(digest(token), user.id, Date.now() + 86400000);
    res.cookie("vec_session", token, {
      httpOnly: true,
      sameSite: "lax",
      secure: process.env.NODE_ENV === "production",
      maxAge: 86400000,
      path: "/",
    });
    return safeUser(user);
  }
  const classList = async () =>
    (
      await db
        .prepare(
          "SELECT classes.*, (SELECT count(*) FROM enrollments e WHERE e.classId=classes.id AND e.status='confirmed') AS enrolled FROM classes ORDER BY startDate",
        )
        .all()
    ).map((row) => ({
      ...parseRow(row),
      effectiveStatus: classStatus(row),
    }));
  app.get("/api/health", async (_req, res) => {
    try {
      await db.prepare("SELECT 1 AS ok").get();
      res.json({ ok: true });
    } catch {
      res.status(503).json({ ok: false });
    }
  });
  app.get("/api/catalog", async (_req, res) =>
    res.json({
      courses: (await all("courses")).reverse().map(({ material, ...c }) => c),
      teachers: (await all("teachers")).reverse(),
      classes: await classList(),
      news: (await all("news")).reverse(),
      campuses,
    }),
  );
  app.get("/api/auth/me", (req, res) =>
    res.json({
      user: safeUser(req.user),
      demo,
    }),
  );
  app.post(
    "/api/auth/register",
    authLimit,
    mutation(db, async (req, res) => {
      const { password, ...data } = validation.register.parse(req.body);
      const id = await write("users", {
        ...data,
        passwordHash: hashPassword(password),
        role: "student",
      });
      return {
        status: 201,
        body: {
          user: await session(res, await one("users", id)),
        },
      };
    }),
  );
  app.post(
    "/api/auth/login",
    authLimit,
    mutation(db, async (req, res) => {
      const data = validation.login.parse(req.body);
      const user = await db
        .prepare("SELECT * FROM users WHERE email=?")
        .get(data.email);
      if (!user || !verifyPassword(data.password, user.passwordHash))
        throw fail(401, "Email hoặc mật khẩu chưa đúng.");
      if (req.sessionToken)
        await db
          .prepare("DELETE FROM sessions WHERE token=?")
          .run(req.sessionToken);
      return {
        status: 200,
        body: {
          user: await session(res, user),
        },
      };
    }),
  );
  app.post(
    "/api/auth/logout",
    mutation(db, async (req, res) => {
      if (req.sessionToken)
        await db
          .prepare("DELETE FROM sessions WHERE token=?")
          .run(req.sessionToken);
      res.clearCookie("vec_session", {
        path: "/",
      });
      return {
        status: 200,
        body: {
          ok: true,
        },
      };
    }),
  );
  app.post(
    "/api/auth/password",
    requireUser,
    authLimit,
    mutation(db, async (req, res) => {
      const { currentPassword, newPassword } = validation.changePassword.parse(
        req.body,
      );
      if (!verifyPassword(currentPassword, req.user.passwordHash))
        throw fail(400, "Mật khẩu hiện tại chưa đúng.");
      if (currentPassword === newPassword)
        throw fail(400, "Hãy chọn mật khẩu mới khác mật khẩu hiện tại.");
      await write(
        "users",
        {
          passwordHash: hashPassword(newPassword),
        },
        req.user.id,
      );
      await db.prepare("DELETE FROM sessions WHERE userId=?").run(req.user.id);
      res.clearCookie("vec_session", {
        path: "/",
      });
      return {
        status: 200,
        body: {
          ok: true,
        },
      };
    }),
  );
  app.post(
    "/api/enrollments",
    submitLimit,
    mutation(db, async (req, _res) => {
      const data = validation.enrollment.parse(req.body);
      const cls = await one("classes", data.classId);
      assertEnrolling(cls);
      const count = (
        await db
          .prepare(
            "SELECT count(*) AS n FROM enrollments WHERE classId=? AND status='confirmed'",
          )
          .get(cls.id)
      ).n;
      if (count >= cls.capacity)
        throw fail(409, "Lớp đã đủ sĩ số. Vui lòng chọn lớp khác.");
      if (req.user) data.email = req.user.email;
      await assertUniqueEnrollment(db, {
        ...data,
        userId: req.user?.id ?? null,
      });
      const id = await write("enrollments", {
        ...data,
        userId: req.user?.id ?? null,
      });
      return {
        status: 201,
        body: {
          id,
          message: "Đăng ký thành công! Trung tâm sẽ liên hệ để xác nhận.",
        },
      };
    }),
  );
  app.get("/api/questions", async (_req, res) =>
    res.json((await all("questions")).reverse().map(({ answer, ...q }) => q)),
  );
  mountPlacement(app, {
    db,
    submitLimit,
    all,
    write,
  });
  app.post(
    "/api/contact",
    submitLimit,
    mutation(db, async (req, _res) => {
      const data = validation.contact.parse(req.body);
      if (data.courseId && !(await one("courses", data.courseId)))
        throw fail(400, "Khóa học quan tâm không còn tồn tại.");
      const id = await write("contacts", data);
      return {
        status: 201,
        body: {
          id,
        },
      };
    }),
  );
  app.get("/api/student", requireUser, async (req, res) => {
    const enrollments = (
      await db
        .prepare("SELECT * FROM enrollments WHERE userId=? ORDER BY id DESC")
        .all(req.user.id)
    ).map(parseRow);
    const courseIds = new Set(
      await Promise.all(
        enrollments
          .filter((e) => e.status === "confirmed")
          .map(async (e) => (await one("classes", e.classId))?.courseId),
      ),
    );
    res.json({
      user: safeUser(req.user),
      enrollments,
      materials: (await all("courses"))
        .filter((c) => courseIds.has(c.id))
        .map(({ id, name, material }) => ({
          id,
          name,
          material,
        })),
      files: await db
        .prepare(
          "SELECT m.id,m.classId,m.title,m.lesson,m.filename,m.size,m.createdAt FROM materials m WHERE EXISTS(SELECT 1 FROM enrollments e WHERE e.userId=? AND e.classId=m.classId AND e.status='confirmed') ORDER BY m.id DESC",
        )
        .all(req.user.id),
      results: (
        await db
          .prepare(
            "SELECT * FROM placement_results WHERE userId=? ORDER BY id DESC",
          )
          .all(req.user.id)
      ).map(parseRow),
    });
  });
  app.patch(
    "/api/student",
    requireUser,
    mutation(db, async (req, _res) => {
      const data = validation.profile.parse(req.body);
      await write("users", data, req.user.id);
      return {
        status: 200,
        body: {
          user: safeUser(await one("users", req.user.id)),
        },
      };
    }),
  );
  app.use("/api/admin", requireUser, requireAdmin);
  mountManagement(app, {
    db,
    requireUser,
    one,
    write,
  });
  app.get("/api/admin/overview", async (_req, res) =>
    res.json({
      students: (
        await db
          .prepare("SELECT count(*) AS n FROM users WHERE role='student'")
          .get()
      ).n,
      courses: (await all("courses")).length,
      teachers: (await all("teachers")).length,
      classes: (await all("classes")).length,
      pending: (
        await db
          .prepare(
            "SELECT count(*) AS n FROM enrollments WHERE status='pending'",
          )
          .get()
      ).n,
      enrollments: (await all("enrollments")).slice(0, 5),
      contacts: await all("contacts"),
    }),
  );
  app.param("resource", (req, _res, next, resource) => {
    if (!Object.hasOwn(validation.schemas, resource))
      return next(fail(404, "Không tìm thấy tài nguyên."));
    req.table = resource === "students" ? "users" : resource;
    next();
  });
  app.get("/api/admin/:resource", async (req, res) => {
    const rows =
      req.table === "classes" ? await classList() : await all(req.table);
    res.json(
      req.table === "users"
        ? rows.filter((u) => u.role === "student").map(safeUser)
        : rows,
    );
  });
  async function validateRelations(resource, data, id) {
    if (resource === "classes") {
      if (data.endDate < data.startDate)
        throw fail(400, "Ngày kết thúc phải sau ngày bắt đầu.");
      const count = (
        await db
          .prepare(
            "SELECT count(*) AS n FROM enrollments WHERE classId=? AND status='confirmed'",
          )
          .get(id ?? 0)
      ).n;
      if (data.capacity < count)
        throw fail(409, "Sĩ số mới nhỏ hơn số học viên đã xác nhận.");
      const previous = id ? await one("classes", id) : null;
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
        await assertSchedule(db, data, id);
      if (data.weekdays.length && data.startTime && data.endTime)
        data.schedule = formatSchedule(data);
    }
    if (resource === "enrollments") {
      const existing = await one("enrollments", id);
      await assertUniqueEnrollment(
        db,
        {
          ...existing,
          ...data,
        },
        id,
      );
      if (
        data.userId != null &&
        (await one("users", data.userId))?.role !== "student"
      )
        throw fail(400, "Hãy chọn tài khoản học viên hợp lệ.");
      if (data.userId !== existing.userId)
        throw fail(
          409,
          "Hãy dùng Tiếp nhận học viên để xác minh và liên kết tài khoản.",
        );
      if (data.status === "confirmed" && existing.status !== "confirmed") {
        const cls = await one(
          "classes",
          (await one("enrollments", id)).classId,
        );
        assertEnrolling(cls);
        const count = (
          await db
            .prepare(
              "SELECT count(*) AS n FROM enrollments WHERE classId=? AND status='confirmed' AND id!=?",
            )
            .get(cls.id, Number(id))
        ).n;
        if (count >= cls.capacity)
          throw fail(409, "Lớp đã đủ sĩ số. Không thể xác nhận thêm học viên.");
      }
    }
  }
  app.post(
    "/api/admin/:resource",
    mutation(db, async (req, _res) => {
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
      await validateRelations(req.params.resource, data);
      const id = await write(req.table, data);
      const row = await one(req.table, id);
      return {
        status: 201,
        body: req.table === "users" ? safeUser(row) : row,
      };
    }),
  );
  app.patch(
    "/api/admin/:resource/:id",
    mutation(db, async (req, _res) => {
      const existing = await one(req.table, req.params.id);
      if (!existing || (req.table === "users" && existing.role !== "student"))
        throw fail(404, "Không tìm thấy dữ liệu.");
      let data;
      if (req.table === "users") {
        const changes = validation.schemas.students.partial().parse(req.body);
        const { password, ...profile } = changes;
        data = {
          ...profile,
          ...(password
            ? {
                passwordHash: hashPassword(password),
              }
            : {}),
        };
      } else
        data = validation.schemas[req.params.resource].parse({
          ...existing,
          ...req.body,
        });
      if (!Object.keys(data).length)
        throw fail(400, "Không có thay đổi hợp lệ.");
      await validateRelations(req.params.resource, data, req.params.id);
      await write(req.table, data, req.params.id);
      if (req.table === "users" && data.passwordHash)
        await db
          .prepare("DELETE FROM sessions WHERE userId=?")
          .run(Number(req.params.id));
      const row = await one(req.table, req.params.id);
      return {
        status: 200,
        body: req.table === "users" ? safeUser(row) : row,
      };
    }),
  );
  app.delete(
    "/api/admin/:resource/:id",
    mutation(db, async (req, _res) => {
      const row = await one(req.table, req.params.id);
      if (!row || (req.table === "users" && row.role !== "student"))
        throw fail(404, "Không tìm thấy dữ liệu.");
      await db
        .prepare(`DELETE FROM ${req.table} WHERE id=?`)
        .run(req.params.id);
      return {
        status: 200,
        body: {
          ok: true,
        },
      };
    }),
  );
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
    if (error.code === "23505" || error.message?.includes("UNIQUE constraint"))
      return res.status(409).json({
        error: {
          message: "Thông tin đã tồn tại hoặc bạn đã đăng ký lớp này.",
        },
      });
    if (
      error.code === "23503" ||
      error.message?.includes("FOREIGN KEY constraint")
    )
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
    res.status(500).json({
      error: {
        message: "Có lỗi xử lý. Vui lòng thử lại.",
      },
    });
  });
  return app;
}
