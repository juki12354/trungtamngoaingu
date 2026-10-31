import { test } from "node:test";
import assert from "node:assert/strict";
import { createApp } from "./helpers/app.js";
import { languages } from "../shared/languages.js";
import { assertScheduleAsync } from "../server/domain.js";
import { mkdtempSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { openDatabase } from "../server/db.js";
import { connectDatabase } from "../server/database.js";

test("upgrading an existing SQLite database preserves accounts, registrations and edits across repeated starts", async () => {
  const path = join(
    mkdtempSync(join(tmpdir(), "vinh-languages-upgrade-")),
    "existing.sqlite",
  );
  const source = openDatabase(path, true);
  source
    .prepare(
      "UPDATE courses SET tuition=1234567,description='Preserved course' WHERE id=1",
    )
    .run();
  source
    .prepare(
      "UPDATE teachers SET achievements='Preserved achievements' WHERE id=1",
    )
    .run();
  const users = source.prepare("SELECT * FROM users ORDER BY id").all();
  const registrations = source
    .prepare("SELECT * FROM enrollments ORDER BY id")
    .all();
  source.close();
  for (let n = 0; n < 2; n++) {
    const db = await connectDatabase({ dbPath: path, demo: true });
    try {
      assert.deepEqual(
        await db.prepare("SELECT * FROM users ORDER BY id").all(),
        users,
      );
      assert.deepEqual(
        await db.prepare("SELECT * FROM enrollments ORDER BY id").all(),
        registrations,
      );
      assert.equal(
        (await db.prepare("SELECT tuition FROM courses WHERE id=1").get())
          .tuition,
        1234567,
      );
      assert.equal(
        (await db.prepare("SELECT achievements FROM teachers WHERE id=1").get())
          .achievements,
        "Preserved achievements",
      );
      assert.equal(
        (await db.prepare("SELECT count(*) n FROM courses").get()).n,
        99,
      );
      assert.equal(
        (await db.prepare("SELECT count(*) n FROM teachers").get()).n,
        24,
      );
    } finally {
      await db.close();
    }
  }
});

test("all 16 languages have courses, qualified teachers, non-overlapping schedules and isolated placement tests", async () => {
  const app = await createApp({ dbPath: ":memory:", demo: true });
  const server = app.listen(0, "127.0.0.1");
  await new Promise((r) => server.once("listening", r));
  const url = `http://127.0.0.1:${server.address().port}/api`;
  const call = async (path, data, cookie, method) => {
    const res = await fetch(url + path, {
      method: method || (data ? "POST" : "GET"),
      headers: {
        "Content-Type": "application/json",
        ...(cookie ? { Cookie: cookie } : {}),
      },
      body: data ? JSON.stringify(data) : undefined,
    });
    return {
      status: res.status,
      data: await res.json(),
      cookie: res.headers.get("set-cookie")?.split(";")[0],
    };
  };
  try {
    const catalog = (await call("/catalog")).data;
    assert.equal(catalog.languages.length, 16);
    assert.equal(catalog.courses.length, 99);
    assert.equal(catalog.teachers.length, 24);
    const admin = (
      await call("/auth/login", {
        email: "admin@vinhenglish.vn",
        password: "Admin@123456",
      })
    ).cookie;
    for (const language of languages) {
      const courses = catalog.courses.filter(
        (c) => c.language === language.code,
      );
      assert.ok(courses.length >= 2, language.code);
      for (const course of courses.filter((c) => c.language !== "en")) {
        const classes = catalog.classes.filter((c) => c.courseId === course.id);
        assert.equal(classes.length, 3);
        for (const cls of classes) {
          assert.ok(
            catalog.teachers
              .find((t) => t.id === cls.teacherId)
              .languages.includes(language.code),
          );
          await assertScheduleAsync(app.locals.db, cls, cls.id);
        }
      }
      const preview = (await call(`/questions?language=${language.code}`)).data;
      assert.equal(preview.length, language.code === "en" ? 25 : 10);
      assert.ok(
        preview.every(
          (q) => q.language === language.code && q.answer === undefined,
        ),
      );
      const attempt = (
        await call("/placement/attempts", { language: language.code })
      ).data;
      const questions = (
        await call("/admin/questions", null, admin)
      ).data.filter(
        (q) => q.language === language.code && q.assessment === "legacy",
      );
      const answers = Object.fromEntries(
        questions.map((q) => [q.id, q.answer]),
      );
      const result = await call("/placement", {
        token: attempt.token,
        answers,
        language: "en",
      });
      assert.equal(result.status, 200);
      assert.equal(result.data.language, language.code);
      assert.equal(result.data.score, preview.length);
      assert.equal(
        catalog.courses.find((c) => c.id === result.data.courseId).language,
        language.code,
      );
      if (language.code !== "en")
        assert.equal(result.data.level, "Có nền tảng từ vựng");
    }
    assert.equal(
      (await call("/placement/attempts", { language: "invalid" })).status,
      400,
    );
    const chinese = catalog.courses.find((c) => c.language === "zh");
    const cls = catalog.classes.find((c) => c.courseId === chinese.id);
    const wrongTeacher = await call(
      `/admin/classes/${cls.id}`,
      { teacherId: 1 },
      admin,
      "PATCH",
    );
    assert.equal(wrongTeacher.status, 400);
    const registration = await call("/enrollments", {
      classId: cls.id,
      name: "Học viên tiếng Trung",
      email: "chinese-test@example.com",
      phone: "0901234567",
      birthday: "",
      note: "Ca sáng",
    });
    assert.equal(registration.status, 201);
  } finally {
    await new Promise((r) => server.close(r));
    await app.locals.db.close();
  }
});
