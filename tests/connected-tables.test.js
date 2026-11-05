import { test } from "node:test";
import assert from "node:assert/strict";
import { createHash } from "node:crypto";
import { createApp } from "./helpers/app.js";
import { backfillQuestionLinks } from "../server/content-relations.js";

async function setup(t) {
  const app = await createApp({ dbPath: ":memory:", demo: true });
  const server = app.listen(0, "127.0.0.1");
  await new Promise((r) => server.once("listening", r));
  t.after(async () => {
    await new Promise((r) => server.close(r));
    await app.locals.db.close();
  });
  const r = async (path, method = "GET", body, cookie) => {
    const res = await fetch(
      `http://127.0.0.1:${server.address().port}/api${path}`,
      {
        method,
        headers: {
          "Content-Type": "application/json",
          ...(cookie ? { Cookie: cookie } : {}),
        },
        ...(body ? { body: JSON.stringify(body) } : {}),
      },
    );
    return {
      status: res.status,
      body: await res.json(),
      cookie: res.headers.get("set-cookie")?.split(";")[0],
    };
  };
  const login = await r("/auth/login", "POST", {
    email: "admin@vinhenglish.vn",
    password: "Admin@123456",
  });
  return {
    r,
    db: app.locals.db,
    admin: login.cookie,
    adminId: login.body.user.id,
  };
}

test("news authors and metadata editors are set by the authenticated admin and cannot be spoofed", async (t) => {
  const { r, db, admin, adminId } = await setup(t);
  const payload = {
    title: "Bài viết kiểm tra quan hệ",
    category: "Tin tức",
    date: "2026-11-05",
    image: "/images/hero.jpg",
    excerpt: "Tóm tắt bài viết",
    content: "Nội dung kiểm tra người đăng và người cập nhật.",
    authorId: -1,
    updatedBy: -1,
  };
  const created = await r("/admin/news", "POST", payload, admin);
  assert.equal(created.status, 201);
  assert.equal(created.body.authorId, adminId);
  const mark = await db
    .prepare("SELECT * FROM metadata WHERE key='content:news'")
    .get();
  assert.equal(mark.updatedBy, adminId);
  assert.ok(mark.updatedAt);
  await r(
    `/admin/news/${created.body.id}`,
    "PATCH",
    { title: "Tiêu đề được sửa", authorId: -1 },
    admin,
  );
  assert.equal(
    (
      await db
        .prepare("SELECT authorId FROM news WHERE id=?")
        .get(created.body.id)
    ).authorId,
    adminId,
  );
  await assert.rejects(
    db.prepare("UPDATE news SET authorId=-1 WHERE id=?").run(created.body.id),
    /foreign key/i,
  );
  await assert.rejects(
    db
      .prepare("UPDATE metadata SET updatedBy=-1 WHERE key='content:news'")
      .run(),
    /foreign key/i,
  );
  assert.equal(
    (await r(`/admin/news/${created.body.id}`, "DELETE", undefined, admin))
      .status,
    200,
  );
  assert.equal(
    (
      await db
        .prepare("SELECT updatedBy FROM metadata WHERE key='content:news'")
        .get()
    ).updatedBy,
    adminId,
  );
});

test("question joins preserve original exam content, record selections and enforce foreign keys", async (t) => {
  const { r, db } = await setup(t);
  const attempt = (
    await r("/placement/attempts", "POST", {
      language: "ja",
      assessment: "competency",
    })
  ).body;
  const token = createHash("sha256").update(attempt.token).digest("hex");
  const rows = await db
    .prepare(
      "SELECT * FROM placement_attempt_questions WHERE attemptToken=? ORDER BY position",
    )
    .all(token);
  assert.equal(rows.length, 15);
  assert.equal(rows[0].questionId, attempt.questions[0].id);
  assert.equal(rows[0].position, 1);
  assert.equal(JSON.stringify(attempt).includes('"answer"'), false);
  const snapshots = rows.map((row) => JSON.parse(row.snapshot));
  await db
    .prepare("UPDATE questions SET answer=(answer+1)%4 WHERE id=?")
    .run(rows[1].questionId);
  await db.prepare("DELETE FROM questions WHERE id=?").run(rows[0].questionId);
  assert.equal(
    (
      await db
        .prepare(
          "SELECT questionId FROM placement_attempt_questions WHERE id=?",
        )
        .get(rows[0].id)
    ).questionId,
    null,
  );
  const answers = Object.fromEntries(snapshots.map((q) => [q.id, q.answer]));
  const result = await r("/placement", "POST", {
    token: attempt.token,
    answers,
  });
  assert.equal(result.status, 200);
  assert.equal(result.body.score, 15);
  const submitted = await db
    .prepare(
      "SELECT * FROM placement_attempt_questions WHERE attemptToken=? ORDER BY position",
    )
    .all(token);
  assert.deepEqual(
    submitted.map((q) => q.selected),
    snapshots.map((q) => q.answer),
  );
  await assert.rejects(
    db
      .prepare(
        "UPDATE placement_attempt_questions SET questionId=-1 WHERE id=?",
      )
      .run(rows[1].id),
    /foreign key/i,
  );
  await assert.rejects(
    db
      .prepare(
        "UPDATE placement_attempt_questions SET attemptToken='missing' WHERE id=?",
      )
      .run(rows[1].id),
    /foreign key/i,
  );
  await db.prepare("DELETE FROM placement_attempts WHERE token=?").run(token);
  assert.equal(
    (
      await db
        .prepare(
          "SELECT count(*) n FROM placement_attempt_questions WHERE attemptToken=?",
        )
        .get(token)
    ).n,
    0,
  );
  assert.equal(
    (
      await db
        .prepare("SELECT total FROM placement_results WHERE id=?")
        .get(result.body.id)
    ).total,
    15,
  );
});

test("legacy attempts gain question links without rewriting snapshots or inventing authors", async (t) => {
  const { db } = await setup(t);
  const question = await db
    .prepare("SELECT * FROM questions ORDER BY id LIMIT 1")
    .get();
  const snapshot = [
    { ...question, options: JSON.parse(question.options) },
    {
      id: -9999,
      prompt: "Câu hỏi cũ đã xóa",
      options: ["A", "B", "C", "D"],
      answer: 2,
    },
  ];
  const original = JSON.stringify(snapshot),
    result = JSON.stringify({
      review: [
        { id: question.id, selected: 1 },
        { id: -9999, selected: 2 },
      ],
    });
  await db
    .prepare(
      "INSERT INTO placement_attempts(token,questions,expires,result) VALUES (?,?,?,?)",
    )
    .run("old-attempt-for-migration", original, Date.now() + 60000, result);
  await db.transaction(() => backfillQuestionLinks(db));
  await db.transaction(() => backfillQuestionLinks(db));
  const links = await db
    .prepare(
      "SELECT * FROM placement_attempt_questions WHERE attemptToken=? ORDER BY position",
    )
    .all("old-attempt-for-migration");
  assert.equal(links.length, 2);
  assert.equal(links[0].questionId, question.id);
  assert.equal(links[1].questionId, null);
  assert.deepEqual(
    links.map((q) => q.selected),
    [1, 2],
  );
  assert.deepEqual(
    links.map((q) => JSON.parse(q.snapshot)),
    snapshot,
  );
  const unchanged = await db
    .prepare("SELECT questions,result FROM placement_attempts WHERE token=?")
    .get("old-attempt-for-migration");
  assert.equal(unchanged.questions, original);
  assert.equal(unchanged.result, result);
  assert.equal(
    (
      await db
        .prepare("SELECT count(*) n FROM news WHERE authorId IS NOT NULL")
        .get()
    ).n,
    0,
  );
});
