import { test } from "node:test";
import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { createApp, databaseFixture } from "./helpers/app.js";
import {
  connectDatabase,
  copySQLite,
  postgresSQL,
  tables,
} from "../server/database.js";
import { bootstrapAdmin } from "../server/bootstrap.js";
import { openDatabase, verifyPassword, hashPassword } from "../server/db.js";

test("SQL parameters leave question marks and camel case in literal text intact", () => {
  assert.equal(
    postgresSQL(
      "SELECT userId, 'What? studentId', 'it''s?' FROM enrollments WHERE classId=? AND email=? -- why?\n",
    ),
    "SELECT \"userId\", 'What? studentId', 'it''s?' FROM enrollments WHERE \"classId\"=$1 AND email=$2 -- why?\n",
  );
});

test("production bootstrap requires private credentials and never resets an existing admin", async () => {
  const app = await createApp({ dbPath: ":memory:", demo: false }),
    db = app.locals.db;
  try {
    await assert.rejects(bootstrapAdmin(db, {}), /ADMIN_EMAIL/);
    assert.equal((await db.prepare("SELECT count(*) n FROM users").get()).n, 0);
    const env = {
      ADMIN_EMAIL: "OWNER@example.com",
      ADMIN_PASSWORD: "Private-test-secret-2026",
    };
    assert.equal(await bootstrapAdmin(db, env), true);
    await db
      .prepare("UPDATE users SET passwordHash=? WHERE role='admin'")
      .run(hashPassword("Changed-private-secret-2026"));
    assert.equal(await bootstrapAdmin(db, env), false);
    assert.equal(await bootstrapAdmin(db, {}), false);
    const row = await db
      .prepare("SELECT * FROM users WHERE role='admin'")
      .get();
    assert.equal(row.email, "owner@example.com");
    assert.ok(verifyPassword("Changed-private-secret-2026", row.passwordHash));
  } finally {
    await db.close();
  }
});

test("concurrent approvals, schedules and placement retries stay consistent", async () => {
  const app = await createApp({ dbPath: ":memory:", demo: true });
  const db = app.locals.db,
    server = app.listen(0, "127.0.0.1");
  await new Promise((resolve) => server.once("listening", resolve));
  const url = `http://127.0.0.1:${server.address().port}/api`;
  const request = async (path, method, body, cookie) => {
    const response = await fetch(url + path, {
      method,
      headers: {
        "Content-Type": "application/json",
        ...(cookie ? { Cookie: cookie } : {}),
      },
      body: JSON.stringify(body),
    });
    return {
      status: response.status,
      body: await response.json(),
      cookie: response.headers.get("set-cookie")?.split(";")[0],
    };
  };
  try {
    const admin = (
      await request("/auth/login", "POST", {
        email: "admin@vinhenglish.vn",
        password: "Admin@123456",
      })
    ).cookie;
    const day = (n) =>
      new Date(Date.now() + n * 86400000).toISOString().slice(0, 10);
    const payload = {
      name: "RACE-A",
      courseId: 1,
      teacherId: 1,
      startDate: day(400),
      endDate: day(460),
      weekdays: [1],
      startTime: "05:00",
      endTime: "06:00",
      campus: "Race campus",
      room: "Race room",
      capacity: 1,
      status: "enrolling",
    };
    const created = await Promise.all([
      request("/admin/classes", "POST", payload, admin),
      request("/admin/classes", "POST", { ...payload, name: "RACE-B" }, admin),
    ]);
    assert.deepEqual(created.map((r) => r.status).sort(), [201, 409]);
    const classId = created.find((r) => r.status === 201).body.id;
    const registrations = await Promise.all(
      [1, 2].map((n) =>
        request("/enrollments", "POST", {
          name: `Race student ${n}`,
          email: `race${n}@example.com`,
          phone: "0901234567",
          classId,
        }),
      ),
    );
    assert.ok(registrations.every((r) => r.status === 201));
    const approved = await Promise.all(
      registrations.map((r) =>
        request(
          `/admin/enrollments/${r.body.id}`,
          "PATCH",
          { status: "confirmed" },
          admin,
        ),
      ),
    );
    assert.deepEqual(approved.map((r) => r.status).sort(), [200, 409]);
    assert.equal(
      (
        await db
          .prepare(
            "SELECT count(*) n FROM enrollments WHERE classId=? AND status='confirmed'",
          )
          .get(classId)
      ).n,
      1,
    );
    const attempt = (await request("/placement/attempts", "POST", {})).body;
    const answers = Object.fromEntries(attempt.questions.map((q) => [q.id, 0]));
    const results = await Promise.all(
      [1, 2, 3].map(() =>
        request("/placement", "POST", { token: attempt.token, answers }),
      ),
    );
    assert.ok(results.every((r) => r.status === 200));
    assert.equal(new Set(results.map((r) => r.body.id)).size, 1);
    assert.equal(
      (await db.prepare("SELECT count(*) n FROM placement_results").get()).n,
      1,
    );
  } finally {
    await new Promise((resolve) => server.close(resolve));
    await db.close();
  }
});

test(
  "SQLite import preserves all records, hashes and files, rejects overwrite and survives PostgreSQL reopen",
  { skip: !process.env.TEST_DATABASE_URL },
  async () => {
    const fixture = await databaseFixture(),
      source = openDatabase(":memory:", true);
    let db = await connectDatabase({
      databaseUrl: fixture.url,
      initialize: false,
    });
    try {
      const bytes = Buffer.from("%PDF-1.4\nprivate bytes\n%%EOF");
      source
        .prepare(
          "INSERT INTO materials(classId,title,filename,mime,size,content) VALUES (1,'Private file','lesson.pdf','application/pdf',?,?)",
        )
        .run(bytes.length, bytes);
      source.prepare("UPDATE courses SET tuition=1234567 WHERE id=1").run();
      await db.transaction(async () => {
        await db.exec(
          await readFile(
            new URL("../server/postgres-schema.sql", import.meta.url),
            "utf8",
          ),
        );
        await copySQLite(source, db);
      });
      await assert.rejects(
        db.transaction(() => copySQLite(source, db)),
        /not empty/,
      );
      await db.close();
      db = await connectDatabase({ databaseUrl: fixture.url, demo: false });
      for (const table of tables)
        assert.equal(
          (await db.prepare(`SELECT count(*) n FROM ${table}`).get()).n,
          source.prepare(`SELECT count(*) n FROM ${table}`).get().n,
          table,
        );
      const user = await db
        .prepare("SELECT * FROM users WHERE role='admin'")
        .get();
      assert.ok(verifyPassword("Admin@123456", user.passwordHash));
      assert.deepEqual(
        (await db.prepare("SELECT content FROM materials").get()).content,
        bytes,
      );
      assert.equal(
        (await db.prepare("SELECT tuition FROM courses WHERE id=1").get())
          .tuition,
        1234567,
      );
      const inserted = await db
        .prepare("INSERT INTO users(name,email,passwordHash) VALUES (?,?,?)")
        .run(
          "After restart",
          "after@example.com",
          hashPassword("Test-new-user-secret"),
        );
      assert.ok(inserted.lastInsertRowid > 2);
    } finally {
      source.close();
      await db.close();
      await fixture.close();
    }
  },
);
