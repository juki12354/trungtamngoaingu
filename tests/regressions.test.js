import { test } from "node:test";
import assert from "node:assert/strict";
import { createApp } from "../server/app.js";

const day = (offset) => {
  const date = new Date();
  date.setUTCDate(date.getUTCDate() + offset);
  return date.toISOString().slice(0, 10);
};

async function setup(t) {
  const app = createApp({ dbPath: ":memory:", demo: true });
  const server = app.listen(0, "127.0.0.1");
  await new Promise((resolve) => server.once("listening", resolve));
  t.after(async () => {
    await new Promise((resolve) => server.close(resolve));
    app.locals.db.close();
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
    return {
      status: response.status,
      body: await response.json(),
      cookie: response.headers.get("set-cookie")?.split(";")[0],
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
  async function createClass(name) {
    const result = await request(
      "/admin/classes",
      "POST",
      {
        name,
        courseId: 1,
        teacherId: 1,
        startDate: day(30),
        endDate: day(90),
        schedule: "Thứ 2, 18:30–20:30",
        campus: "Cơ sở kiểm thử",
        capacity: 20,
        weekdays: [7],
        startTime: "07:00",
        endTime: "08:00",
        room: `TEST-${name}`,
        status: "enrolling",
      },
      admin,
    );
    assert.equal(result.status, 201);
    return result.body.id;
  }
  return {
    request,
    admin,
    student,
    studentId: studentLogin.body.user.id,
    createClass,
    db: app.locals.db,
  };
}

const registration = (classId, email = "hocvien@example.com") => ({
  name: "Học viên hồi quy",
  email,
  phone: "0901234567",
  classId,
});

test("expired placement attempts cannot create results", async (t) => {
  const { request, student, db } = await setup(t);
  const started = await request("/placement/attempts", "POST", {}, student);
  db.prepare("UPDATE placement_attempts SET expires=?").run(Date.now() - 1);
  const answers = Object.fromEntries(
    started.body.questions.map((q) => [q.id, 0]),
  );
  assert.equal(
    (
      await request(
        "/placement",
        "POST",
        { token: started.body.token, answers },
        student,
      )
    ).status,
    409,
  );
  assert.equal(
    db.prepare("SELECT count(*) n FROM placement_results").get().n,
    0,
  );
});

test("changing a student's email cannot create a second active enrollment in the same class", async (t) => {
  const { request, admin, student, studentId, createClass } = await setup(t);
  const classId = await createClass("EMAIL-REGRESSION");
  assert.equal(
    (await request("/enrollments", "POST", registration(classId), student))
      .status,
    201,
  );
  assert.equal(
    (
      await request(
        `/admin/students/${studentId}`,
        "PATCH",
        {
          email: "changed@example.com",
        },
        admin,
      )
    ).status,
    200,
  );
  const duplicate = await request(
    "/enrollments",
    "POST",
    registration(classId, "changed@example.com"),
    student,
  );
  assert.equal(duplicate.status, 409);
  const records = (await request("/admin/enrollments", "GET", null, admin))
    .body;
  assert.equal(
    records.filter(
      (row) =>
        row.userId === studentId &&
        row.classId === classId &&
        row.status !== "cancelled",
    ).length,
    1,
  );
});

test("linking a guest registration rejects a student who already has an active registration in that class", async (t) => {
  const { request, admin, student, studentId, createClass } = await setup(t);
  const classId = await createClass("LINK-REGRESSION");
  assert.equal(
    (await request("/enrollments", "POST", registration(classId), student))
      .status,
    201,
  );
  const guest = await request(
    "/enrollments",
    "POST",
    registration(classId, "guest@example.com"),
  );
  assert.equal(guest.status, 201);
  const linked = await request(
    `/admin/enrollments/${guest.body.id}`,
    "PATCH",
    { userId: studentId },
    admin,
  );
  assert.equal(linked.status, 409);
  const records = (await request("/admin/enrollments", "GET", null, admin))
    .body;
  assert.equal(records.find((row) => row.id === guest.body.id).userId, null);
});

test("admin cannot approve a pending registration after the class has ended", async (t) => {
  const { request, admin, createClass } = await setup(t);
  const classId = await createClass("ENDED-REGRESSION");
  const registrationResult = await request(
    "/enrollments",
    "POST",
    registration(classId, "pending@example.com"),
  );
  assert.equal(registrationResult.status, 201);
  assert.equal(
    (
      await request(
        `/admin/classes/${classId}`,
        "PATCH",
        {
          startDate: day(-90),
          endDate: day(-1),
        },
        admin,
      )
    ).status,
    200,
  );
  const approved = await request(
    `/admin/enrollments/${registrationResult.body.id}`,
    "PATCH",
    { status: "confirmed" },
    admin,
  );
  assert.equal(approved.status, 409);
  const records = (await request("/admin/enrollments", "GET", null, admin))
    .body;
  assert.equal(
    records.find((row) => row.id === registrationResult.body.id).status,
    "pending",
  );
});

test("placement attempts retain the original question snapshot and retrying submission keeps one result", async (t) => {
  const { request, admin, student } = await setup(t);
  const original = (await request("/admin/questions", "GET", null, admin)).body;
  const started = await request("/placement/attempts", "POST", {}, student);
  assert.ok(
    [200, 201].includes(started.status),
    `start attempt returned ${started.status}`,
  );
  const { token, questions, expiresAt } = started.body;
  assert.equal(typeof token, "string");
  assert.ok(token.length > 0);
  assert.ok(expiresAt);
  assert.equal(questions.length, original.length);
  assert.ok(questions.every((question) => question.answer === undefined));
  const answers = Object.fromEntries(
    original.map((question) => [question.id, question.answer]),
  );
  const changed = original[0];
  assert.equal(
    (
      await request(
        `/admin/questions/${changed.id}`,
        "PATCH",
        {
          prompt: "An edited question must not change a running attempt.",
          answer: (changed.answer + 1) % 4,
        },
        admin,
      )
    ).status,
    200,
  );
  const first = await request(
    "/placement",
    "POST",
    { token, answers },
    student,
  );
  assert.equal(first.status, 200);
  assert.equal(first.body.total, original.length);
  assert.equal(first.body.score, original.length);
  const repeated = await request(
    "/placement",
    "POST",
    { token, answers },
    student,
  );
  assert.equal(repeated.status, 200);
  assert.equal(repeated.body.id, first.body.id);
  const profile = await request("/student", "GET", null, student);
  assert.equal(
    profile.body.results.filter((result) => result.id === first.body.id).length,
    1,
  );
  assert.equal(profile.body.results.length, 1);
});

test("placement attempts cannot be submitted with an invalid token or by another account", async (t) => {
  const { request, admin, student } = await setup(t);
  const original = (await request("/admin/questions", "GET", null, admin)).body;
  const answers = Object.fromEntries(
    original.map((question) => [question.id, question.answer]),
  );
  const started = await request("/placement/attempts", "POST", {}, student);
  assert.ok(
    [200, 201].includes(started.status),
    `start attempt returned ${started.status}`,
  );
  const invalid = await request(
    "/placement",
    "POST",
    { token: "invalid-attempt-token", answers },
    student,
  );
  assert.ok(invalid.status >= 400 && invalid.status < 500);
  const unowned = await request(
    "/placement",
    "POST",
    { token: started.body.token, answers },
    admin,
  );
  assert.ok(
    [401, 403, 404].includes(unowned.status),
    `other account returned ${unowned.status}`,
  );
  const guest = await request("/placement", "POST", {
    token: started.body.token,
    answers,
  });
  assert.ok(
    [401, 403, 404].includes(guest.status),
    `anonymous submission returned ${guest.status}`,
  );
  const profile = await request("/student", "GET", null, student);
  assert.equal(profile.body.results.length, 0);
  assert.equal(
    (
      await request(
        "/placement",
        "POST",
        { token: started.body.token, answers },
        student,
      )
    ).status,
    200,
  );
});
