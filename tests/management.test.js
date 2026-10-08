import { test } from "node:test";
import assert from "node:assert/strict";
import { createApp } from "./helpers/app.js";

const day = (offset) => {
  const date = new Date();
  date.setUTCDate(date.getUTCDate() + offset);
  return date.toISOString().slice(0, 10);
};

async function setup(t) {
  const app = await createApp({ dbPath: ":memory:", demo: true });
  const server = app.listen(0, "127.0.0.1");
  await new Promise((resolve) => server.once("listening", resolve));
  t.after(async () => {
    await new Promise((resolve) => server.close(resolve));
    await app.locals.db.close();
  });
  const base = `http://127.0.0.1:${server.address().port}/api`;
  async function request(path, method = "GET", body, cookie) {
    const response = await fetch(base + path, {
      method,
      headers: {
        ...(body ? { "Content-Type": "application/json" } : {}),
        ...(cookie ? { Cookie: cookie } : {}),
      },
      body: body ? JSON.stringify(body) : undefined,
    });
    const contentType = response.headers.get("content-type") || "";
    return {
      status: response.status,
      body: contentType.includes("application/json")
        ? await response.json()
        : Buffer.from(await response.arrayBuffer()),
      cookie: response.headers.get("set-cookie")?.split(";")[0],
      contentType,
    };
  }
  const adminLogin = await request("/auth/login", "POST", {
    email: "admin@vinhenglish.vn",
    password: "Admin@123456",
  });
  const studentLogin = await request("/auth/login", "POST", {
    email: "hocvien@example.com",
    password: "Student@123456",
  });
  assert.equal(adminLogin.status, 200);
  assert.equal(studentLogin.status, 200);
  const admin = adminLogin.cookie;
  const student = studentLogin.cookie;
  const classPayload = (overrides = {}) => ({
    courseId: 1,
    teacherId: 1,
    name: "MANAGEMENT-TEST",
    startDate: day(14),
    endDate: day(60),
    weekdays: [7],
    startTime: "07:00",
    endTime: "08:00",
    room: "TEST-101",
    status: "enrolling",
    campus: "Cơ sở kiểm thử",
    capacity: 20,
    ...overrides,
  });
  async function createClass(overrides) {
    const result = await request(
      "/admin/classes",
      "POST",
      classPayload(overrides),
      admin,
    );
    assert.equal(result.status, 201, JSON.stringify(result.body));
    return result.body;
  }
  async function enroll(classId, email = "guest@example.com", cookie) {
    const result = await request(
      "/enrollments",
      "POST",
      {
        classId,
        name: "Học viên kiểm thử",
        email,
        phone: "0901234567",
      },
      cookie,
    );
    assert.equal(result.status, 201);
    return result.body.id;
  }
  return {
    request,
    admin,
    student,
    studentId: studentLogin.body.user.id,
    adminId: adminLogin.body.user.id,
    classPayload,
    createClass,
    enroll,
  };
}

// A complete small PDF, including valid object offsets and cross-reference table.
function pdfBytes() {
  const objects = [
    "<< /Type /Catalog /Pages 2 0 R >>",
    "<< /Type /Pages /Kids [3 0 R] /Count 1 >>",
    "<< /Type /Page /Parent 2 0 R /MediaBox [0 0 200 200] >>",
  ];
  let body = "%PDF-1.4\n";
  const offsets = [0];
  objects.forEach((object, index) => {
    offsets.push(Buffer.byteLength(body));
    body += `${index + 1} 0 obj\n${object}\nendobj\n`;
  });
  const xref = Buffer.byteLength(body);
  body += `xref\n0 4\n0000000000 65535 f \n${offsets
    .slice(1)
    .map((offset) => `${String(offset).padStart(10, "0")} 00000 n \n`)
    .join("")}trailer\n<< /Size 4 /Root 1 0 R >>\nstartxref\n${xref}\n%%EOF`;
  return Buffer.from(body);
}

test("changing password verifies the old password and revokes every previous session", async (t) => {
  const { request, student } = await setup(t);
  const second = await request("/auth/login", "POST", {
    email: "hocvien@example.com",
    password: "Student@123456",
  });
  const payload = {
    currentPassword: "incorrect",
    newPassword: "ChangedStudent@1234",
  };
  assert.equal((await request("/auth/password", "POST", payload)).status, 401);
  assert.equal(
    (await request("/auth/password", "POST", payload, student)).status,
    400,
  );
  assert.equal((await request("/student", "GET", null, student)).status, 200);
  assert.equal(
    (
      await request(
        "/auth/password",
        "POST",
        { ...payload, currentPassword: "Student@123456" },
        student,
      )
    ).status,
    200,
  );
  assert.equal((await request("/student", "GET", null, student)).status, 401);
  assert.equal(
    (await request("/student", "GET", null, second.cookie)).status,
    401,
  );
  assert.equal(
    (
      await request("/auth/login", "POST", {
        email: "hocvien@example.com",
        password: "Student@123456",
      })
    ).status,
    401,
  );
  assert.equal(
    (
      await request("/auth/login", "POST", {
        email: "hocvien@example.com",
        password: payload.newPassword,
      })
    ).status,
    200,
  );
});

test("verified intake creates one usable student account and links the guest registration", async (t) => {
  const { request, admin, createClass, enroll } = await setup(t);
  const cls = await createClass();
  const enrollmentId = await enroll(cls.id);
  const payload = {
    verified: true,
    mode: "create",
    password: "NewStudent@1234",
  };
  assert.equal(
    (
      await request(
        `/admin/enrollments/${enrollmentId}/intake`,
        "POST",
        { ...payload, verified: false },
        admin,
      )
    ).status,
    400,
  );
  const created = await request(
    `/admin/enrollments/${enrollmentId}/intake`,
    "POST",
    payload,
    admin,
  );
  assert.ok([200, 201].includes(created.status), JSON.stringify(created.body));
  const login = await request("/auth/login", "POST", {
    email: "guest@example.com",
    password: payload.password,
  });
  assert.equal(login.status, 200);
  const profile = await request("/student", "GET", null, login.cookie);
  assert.equal(
    profile.body.enrollments.find((row) => row.id === enrollmentId)?.userId,
    login.body.user.id,
  );
});

test("intake duplicate email fails atomically without creating or linking a student", async (t) => {
  const { request, admin, createClass, enroll } = await setup(t);
  const cls = await createClass();
  const id = await enroll(cls.id, "hocvien@example.com");
  const before = (await request("/admin/students", "GET", null, admin)).body;
  assert.equal(
    (
      await request(
        `/admin/enrollments/${id}/intake`,
        "POST",
        {
          verified: true,
          mode: "create",
          password: "NewStudent@1234",
        },
        admin,
      )
    ).status,
    409,
  );
  const after = (await request("/admin/students", "GET", null, admin)).body;
  assert.deepEqual(after, before);
  const rows = (await request("/admin/enrollments", "GET", null, admin)).body;
  assert.equal(rows.find((row) => row.id === id).userId, null);
});

test("intake linking requires verification and student role and rejects an existing class registration", async (t) => {
  const { request, admin, student, studentId, adminId, createClass, enroll } =
    await setup(t);
  const cls = await createClass();
  const id = await enroll(cls.id);
  const payload = { verified: true, mode: "existing", userId: studentId };
  assert.equal(
    (await request(`/admin/enrollments/${id}/intake`, "POST", payload, student))
      .status,
    403,
  );
  assert.equal(
    (
      await request(
        `/admin/enrollments/${id}/intake`,
        "POST",
        { ...payload, verified: false },
        admin,
      )
    ).status,
    400,
  );
  assert.equal(
    (
      await request(
        `/admin/enrollments/${id}/intake`,
        "POST",
        { ...payload, userId: adminId },
        admin,
      )
    ).status,
    400,
  );
  assert.equal(
    (await request(`/admin/enrollments/${id}/intake`, "POST", payload, admin))
      .status,
    200,
  );
  const duplicateId = await enroll(cls.id, "another-guest@example.com");
  assert.equal(
    (
      await request(
        `/admin/enrollments/${duplicateId}/intake`,
        "POST",
        payload,
        admin,
      )
    ).status,
    409,
  );
  const rows = (await request("/admin/enrollments", "GET", null, admin)).body;
  assert.equal(rows.find((row) => row.id === duplicateId).userId, null);
});

test("admin can track contact status and consultation notes persist", async (t) => {
  const { request, admin, student } = await setup(t);
  const created = await request("/contact", "POST", {
    name: "Khách tư vấn",
    email: "contact@example.com",
    phone: "0901234567",
    message: "Tôi muốn học IELTS.",
  });
  assert.equal(created.status, 201);
  const path = `/admin/contacts/${created.body.id}`;
  assert.equal(
    (await request(path, "PATCH", { status: "done" }, student)).status,
    403,
  );
  assert.equal(
    (
      await request(
        path,
        "PATCH",
        { status: "contacted", note: "Đã gọi, hẹn kiểm tra trình độ." },
        admin,
      )
    ).status,
    200,
  );
  assert.equal(
    (await request(path, "PATCH", { status: "done" }, admin)).status,
    200,
  );
  const rows = (await request("/admin/contacts", "GET", null, admin)).body;
  const row = rows.find((item) => item.id === created.body.id);
  assert.equal(row.status, "done");
  assert.equal(row.note, "Đã gọi, hẹn kiểm tra trình độ.");
});

test("reports expose monthly registration and class data and a real Excel workbook only to admins", async (t) => {
  const { request, admin, student } = await setup(t);
  for (const path of ["/admin/reports", "/admin/reports/export.xlsx"]) {
    assert.equal((await request(path)).status, 401);
    assert.equal((await request(path, "GET", null, student)).status, 403);
  }
  const report = await request("/admin/reports", "GET", null, admin);
  assert.equal(report.status, 200);
  assert.ok(Array.isArray(report.body.monthly));
  assert.ok(Array.isArray(report.body.classes));
  assert.ok(report.body.classes.length > 0);
  const exported = await request(
    "/admin/reports/export.xlsx",
    "GET",
    null,
    admin,
  );
  assert.equal(exported.status, 200);
  assert.match(exported.contentType, /spreadsheetml/);
  const { default: ExcelJS } = await import("exceljs");
  const workbook = new ExcelJS.Workbook();
  await workbook.xlsx.load(exported.body);
  assert.ok(workbook.worksheets.length > 0);
  assert.ok(workbook.worksheets.some((sheet) => sheet.actualRowCount > 1));
});

test("PDF materials are visible and downloadable only by admins or confirmed students of the class", async (t) => {
  const { request, admin, student, createClass, enroll } = await setup(t);
  const cls = await createClass();
  const id = await enroll(cls.id, "hocvien@example.com", student);
  const bytes = pdfBytes();
  const uploaded = await request(
    "/admin/materials",
    "POST",
    {
      classId: cls.id,
      title: "Tài liệu buổi 1",
      lesson: "Buổi 1",
      filename: "lesson.pdf",
      content: bytes.toString("base64"),
    },
    admin,
  );
  assert.equal(uploaded.status, 201, JSON.stringify(uploaded.body));
  const path = `/materials/${uploaded.body.id}/download`;
  assert.equal((await request(path)).status, 401);
  assert.equal((await request(path, "GET", null, student)).status, 403);
  let profile = await request("/student", "GET", null, student);
  assert.ok(Array.isArray(profile.body.files));
  assert.equal(
    profile.body.files.some((file) => file.id === uploaded.body.id),
    false,
  );
  const adminDownload = await request(path, "GET", null, admin);
  assert.equal(adminDownload.status, 200);
  assert.deepEqual(adminDownload.body, bytes);
  assert.equal(
    (
      await request(
        `/admin/enrollments/${id}`,
        "PATCH",
        { status: "confirmed" },
        admin,
      )
    ).status,
    200,
  );
  profile = await request("/student", "GET", null, student);
  assert.ok(profile.body.files.some((file) => file.id === uploaded.body.id));
  assert.deepEqual((await request(path, "GET", null, student)).body, bytes);
  assert.equal(
    (
      await request(
        `/admin/enrollments/${id}`,
        "PATCH",
        { status: "cancelled" },
        admin,
      )
    ).status,
    200,
  );
  assert.equal((await request(path, "GET", null, student)).status, 403);
  assert.equal(
    (
      await request(
        `/admin/materials/${uploaded.body.id}`,
        "DELETE",
        null,
        admin,
      )
    ).status,
    200,
  );
  assert.equal((await request(path, "GET", null, admin)).status, 404);
});

test("DOCX upload accepts document containers and rejects renamed PDF content", async (t) => {
  const { request, admin } = await setup(t);
  const content =
    "UEsDBBQAAAAIAFt8Nl2sbhJanQAAANwAAAATAAAAW0NvbnRlbnRfVHlwZXNdLnhtbF2PMQ7CMAxFr1JlRdSIgQG1XdiBgQtYqdtGxHaUGCi3RwWpA/PXe0+/ub0TlWrmKKV1k1k6AhQ/EWOpNZHMHAfNjFZqzSMk9HccCfa73QG8ipHY1haH65rLk3IOPVVXzHZGptbBS3MPvfoHk1g9c3TV6Yct5dZhSjF4tKACT+n/mlsdhuBp5RdbyuqplCAjx3pdGINsFj10DXxPdR9QSwMEFAAAAAgAW3w2XUY9PuV0AAAAmAAAABEAAAB3b3JkL2RvY3VtZW50LnhtbEXOMQ7CMAwF0KugHqCuGBiikBNwiZCYtlJsR3ZQyu1RysDy/h/+8H13WdKbkNvloMLm+n3aWqsOwNKGFG2WinxQeYlSbDaLrtBFc1VJaLbzSgWuy3IDijtPwXf3lPwZWQc6aOGBZsIeRh/qaT397eH/JXwBUEsBAhQAFAAAAAgAW3w2XaxuElqdAAAA3AAAABMAAAAAAAAAAAAAAIABAAAAAFtDb250ZW50X1R5cGVzXS54bWxQSwECFAAUAAAACABbfDZdRj0+5XQAAACYAAAAEQAAAAAAAAAAAAAAgAHOAAAAd29yZC9kb2N1bWVudC54bWxQSwUGAAAAAAIAAgCAAAAAcQEAAAAA";
  const payload = {
    classId: 1,
    title: "Bài tập DOCX",
    filename: "lesson.docx",
    content,
  };
  const uploaded = await request("/admin/materials", "POST", payload, admin);
  assert.equal(uploaded.status, 201, JSON.stringify(uploaded.body));
  const downloaded = await request(
    `/materials/${uploaded.body.id}/download`,
    "GET",
    null,
    admin,
  );
  assert.deepEqual(downloaded.body, Buffer.from(content, "base64"));
  assert.equal(
    (
      await request(
        "/admin/materials",
        "POST",
        { ...payload, content: pdfBytes().toString("base64") },
        admin,
      )
    ).status,
    400,
  );
});

test("material upload rejects executable extensions, mismatched PDF bytes and files over 5 MB", async (t) => {
  const { request, admin, student, createClass } = await setup(t);
  const cls = await createClass();
  const payload = {
    classId: cls.id,
    title: "Tài liệu",
    lesson: "Buổi 1",
    filename: "lesson.pdf",
    content: pdfBytes().toString("base64"),
  };
  assert.equal(
    (await request("/admin/materials", "POST", payload, student)).status,
    403,
  );
  assert.equal(
    (
      await request(
        "/admin/materials",
        "POST",
        { ...payload, filename: "lesson.pdf.exe" },
        admin,
      )
    ).status,
    400,
  );
  assert.equal(
    (
      await request(
        "/admin/materials",
        "POST",
        {
          ...payload,
          content: Buffer.from("MZ executable content").toString("base64"),
        },
        admin,
      )
    ).status,
    400,
  );
  const large = Buffer.concat([
    Buffer.from("%PDF-1.4\n"),
    Buffer.alloc(5 * 1024 * 1024, 32),
    Buffer.from("\n%%EOF"),
  ]);
  const oversized = await request(
    "/admin/materials",
    "POST",
    { ...payload, content: large.toString("base64") },
    admin,
  );
  assert.ok([400, 413].includes(oversized.status));
});

test("structured schedules reject teacher and room collisions but allow adjacent and cancelled classes", async (t) => {
  const { request, admin, classPayload, createClass } = await setup(t);
  await createClass();
  assert.equal(
    (
      await request(
        "/admin/classes",
        "POST",
        classPayload({ name: "TEACHER-CONFLICT", room: "OTHER-ROOM" }),
        admin,
      )
    ).status,
    409,
  );
  assert.equal(
    (
      await request(
        "/admin/classes",
        "POST",
        classPayload({ name: "ROOM-CONFLICT", teacherId: 2 }),
        admin,
      )
    ).status,
    409,
  );
  const adjacent = await createClass({
    name: "ADJACENT",
    startTime: "08:00",
    endTime: "09:00",
  });
  assert.equal(adjacent.startTime, "08:00");
  await createClass({ name: "CANCELLED-OVERLAP", status: "cancelled" });
  await createClass({
    name: "CANCELLED-ONLY",
    weekdays: [6],
    status: "cancelled",
  });
  await createClass({ name: "ACTIVE-AFTER-CANCELLATION", weekdays: [6] });
  assert.equal(
    (
      await request(
        "/admin/classes",
        "POST",
        classPayload({ name: "INVALID-DAY", weekdays: [8] }),
        admin,
      )
    ).status,
    400,
  );
  assert.equal(
    (
      await request(
        "/admin/classes",
        "POST",
        classPayload({ name: "INVALID-TIME", startTime: "25:00" }),
        admin,
      )
    ).status,
    400,
  );
  assert.equal(
    (
      await request(
        "/admin/classes",
        "POST",
        classPayload({
          name: "REVERSED-TIME",
          startTime: "09:00",
          endTime: "08:00",
        }),
        admin,
      )
    ).status,
    400,
  );
});
