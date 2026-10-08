import { test } from "node:test";
import assert from "node:assert/strict";
import { createApp } from "./helpers/app.js";
import { openDatabase } from "../server/db.js";
import { addPublicContent } from "../server/public-content.js";

test("sample upgrade offers TOEIC and 25 questions without overwriting edits on rerun", () => {
  const db = openDatabase(":memory:", true);
  try {
    assert.equal(db.prepare("SELECT count(*) n FROM questions").get().n, 25);
    const course = db
      .prepare("SELECT * FROM courses WHERE category='TOEIC'")
      .get();
    assert.equal(
      db
        .prepare("SELECT count(*) n FROM classes WHERE courseId=?")
        .get(course.id).n,
      2,
    );
    db.prepare(
      "UPDATE courses SET name='TOEIC đã sửa',tuition=1234567 WHERE id=?",
    ).run(course.id);
    db.exec("UPDATE questions SET prompt='Câu hỏi đã sửa' WHERE id=16");
    assert.deepEqual(addPublicContent(db), {
      courses: 0,
      classes: 0,
      questions: 0,
      teachers: 0,
    });
    assert.equal(
      db.prepare("SELECT tuition FROM courses WHERE id=?").get(course.id)
        .tuition,
      1234567,
    );
    assert.equal(
      db.prepare("SELECT prompt FROM questions WHERE id=16").get().prompt,
      "Câu hỏi đã sửa",
    );
  } finally {
    db.close();
  }
});

test("trial requests persist structured preferences and reject invalid choices", async () => {
  const app = await createApp({ dbPath: ":memory:", demo: true });
  const server = app.listen(0, "127.0.0.1");
  await new Promise((resolve) => server.once("listening", resolve));
  const base = `http://127.0.0.1:${server.address().port}/api`;
  const post = (path, body) =>
    fetch(base + path, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });
  try {
    const payload = {
      name: "Học viên học thử",
      email: "trial@example.com",
      phone: "0901234567",
      message: "Luyện nghe và đọc cho công việc",
      kind: "trial",
      age: 22,
      courseId: 1,
      campus: "Cơ sở Lê Lợi",
    };
    assert.equal((await post("/contact", payload)).status, 201);
    const login = await post("/auth/login", {
      email: "admin@vinhenglish.vn",
      password: "Admin@123456",
    });
    const response = await fetch(base + "/admin/contacts", {
      headers: { Cookie: login.headers.get("set-cookie").split(";")[0] },
    });
    const [row] = await response.json();
    for (const key of ["kind", "age", "courseId", "campus", "message"])
      assert.equal(row[key], payload[key]);
    for (const invalid of [
      { age: -1 },
      { kind: "invalid" },
      { courseId: 999999 },
      { campus: "Không tồn tại" },
    ])
      assert.equal(
        (await post("/contact", { ...payload, ...invalid })).status,
        400,
      );
    assert.equal((await fetch(base + "/admin/contacts")).status, 401);
    const catalog = await (await fetch(base + "/catalog")).json();
    assert.equal(catalog.campuses.length, 2);
  } finally {
    await new Promise((resolve) => server.close(resolve));
    await app.locals.db.close();
  }
});

test("legacy sample upgrade preserves existing learners, questions and teacher edits", () => {
  const db = openDatabase(":memory:", true);
  try {
    db.exec(
      "DELETE FROM classes WHERE courseId=7; DELETE FROM courses WHERE id=7; DELETE FROM questions WHERE id>15; DELETE FROM metadata WHERE key='public-content-v1'; UPDATE teachers SET nationality='Custom nationality' WHERE id=1; UPDATE questions SET prompt='Original edited prompt' WHERE id=1;",
    );
    const learners = db.prepare("SELECT * FROM enrollments").all();
    const oldClasses = db.prepare("SELECT * FROM classes").all();
    const added = addPublicContent(db);
    assert.equal(added.courses, 1);
    assert.equal(added.questions, 10);
    assert.equal(added.classes, 2);
    assert.deepEqual(db.prepare("SELECT * FROM enrollments").all(), learners);
    assert.deepEqual(
      db.prepare("SELECT * FROM classes WHERE id<=6").all(),
      oldClasses,
    );
    assert.equal(
      db.prepare("SELECT nationality FROM teachers WHERE id=1").get()
        .nationality,
      "Custom nationality",
    );
    assert.equal(
      db.prepare("SELECT prompt FROM questions WHERE id=1").get().prompt,
      "Original edited prompt",
    );
  } finally {
    db.close();
  }
});
