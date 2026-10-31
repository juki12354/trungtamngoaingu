import { test } from "node:test";
import assert from "node:assert/strict";
import { languages } from "../shared/languages.js";
import { evaluateCompetency, proficiencyFor } from "../shared/proficiency.js";
import { buildCompetencyQuestions } from "../server/competency-seed.js";
import { createApp } from "./helpers/app.js";

test("each language has ordered level bands with vocabulary, grammar and reading; higher isolated answers cannot skip weak foundations", () => {
  for (const language of languages) {
    const questions = buildCompetencyQuestions(language.code).map((q, i) => ({
      ...q,
      id: i + 1,
    }));
    const levels = proficiencyFor(language.code).levels;
    assert.equal(questions.length, levels.length * 3);
    for (const level of levels)
      assert.deepEqual(
        questions.filter((q) => q.levelCode === level.code).map((q) => q.skill),
        ["vocabulary", "grammar", "reading"],
      );
    for (const q of questions) {
      assert.equal(q.options.length, 4);
      assert.equal(new Set(q.options).size, 4);
      assert.ok(
        q.prompt.length <= 500,
        `${language.code} ${q.levelCode}: prompt too long`,
      );
    }
    const wrong = Object.fromEntries(
      questions.map((q) => [q.id, (q.answer + 1) % 4]),
    );
    assert.equal(
      evaluateCompetency(language.code, questions, wrong).recommendedLevel,
      levels[0].code,
    );
    for (const q of questions.filter((q) => q.levelCode !== levels[0].code))
      wrong[q.id] = q.answer;
    assert.equal(
      evaluateCompetency(language.code, questions, wrong).recommendedLevel,
      levels[0].code,
    );
    for (let mastered = 0; mastered <= levels.length; mastered++) {
      const answers = Object.fromEntries(
        questions.map((q) => [
          q.id,
          levels.findIndex((l) => l.code === q.levelCode) < mastered
            ? q.answer
            : (q.answer + 1) % 4,
        ]),
      );
      assert.equal(
        evaluateCompetency(language.code, questions, answers).recommendedLevel,
        levels[Math.min(mastered, levels.length - 1)].code,
      );
    }
  }
});

test("competency attempts grade snapshots and recommend only matching-language, matching-level, open classes with seats", async () => {
  const app = await createApp({ dbPath: ":memory:", demo: true });
  const db = app.locals.db,
    server = app.listen(0, "127.0.0.1");
  await new Promise((r) => server.once("listening", r));
  const url = `http://127.0.0.1:${server.address().port}/api`;
  const call = async (path, body) => {
    const res = await fetch(url + path, {
      method: body ? "POST" : "GET",
      headers: { "Content-Type": "application/json" },
      body: body ? JSON.stringify(body) : undefined,
    });
    return { status: res.status, body: await res.json() };
  };
  try {
    const preview = await call("/questions?language=ja&assessment=competency");
    assert.equal(preview.status, 200);
    assert.equal(preview.body.length, 15);
    assert.ok(
      preview.body.every((q) => q.language === "ja" && q.answer === undefined),
    );
    const attempt = (
      await call("/placement/attempts", {
        language: "ja",
        assessment: "competency",
      })
    ).body;
    const original = await db
      .prepare(
        "SELECT * FROM questions WHERE language='ja' AND assessment='competency'",
      )
      .all();
    const answers = Object.fromEntries(
      original.map((q) => [
        q.id,
        ["N5", "N4"].includes(q.levelCode) ? q.answer : (q.answer + 1) % 4,
      ]),
    );
    await db
      .prepare(
        "UPDATE questions SET answer=(answer+1)%4 WHERE language='ja' AND assessment='competency'",
      )
      .run();
    const result = await call("/placement", {
      token: attempt.token,
      answers,
      language: "en",
      level: "C2",
      score: 999,
    });
    assert.equal(result.status, 200);
    assert.equal(result.body.score, 6);
    assert.equal(result.body.analysis.recommendedLevel, "N3");
    assert.equal(result.body.analysis.foundationLevel, "N4");
    assert.ok(result.body.recommendations.classes.length > 0);
    assert.ok(
      result.body.recommendations.classes.every(
        (c) => c.language === "ja" && c.levelCode === "N3" && c.available > 0,
      ),
    );
    const classId = result.body.recommendations.classes[0].id;
    await db
      .prepare("UPDATE classes SET status='cancelled' WHERE id=?")
      .run(classId);
    const fullId = result.body.recommendations.classes[1].id;
    await db.prepare("UPDATE classes SET capacity=1 WHERE id=?").run(fullId);
    await db
      .prepare(
        "INSERT INTO enrollments(classId,name,email,phone,status) VALUES (?,?,?,?,?)",
      )
      .run(
        fullId,
        "Full class check",
        "full@example.com",
        "0901234567",
        "confirmed",
      );
    const repeated = await call("/placement", { token: attempt.token });
    assert.equal(repeated.body.id, result.body.id);
    assert.ok(
      repeated.body.recommendations.classes.every((c) => c.id !== classId),
    );
    assert.ok(
      repeated.body.recommendations.classes.every((c) => c.id !== fullId),
    );
    const target = result.body.recommendations.courseId;
    await db
      .prepare("UPDATE classes SET status='completed' WHERE courseId=?")
      .run(target);
    const empty = await call("/placement", { token: attempt.token });
    assert.equal(empty.body.recommendations.classes.length, 0);
    assert.equal(empty.body.recommendations.courseId, target);
    assert.equal(
      (await db.prepare("SELECT count(*) n FROM placement_results").get()).n,
      1,
    );
    assert.equal(
      JSON.parse(
        (await db.prepare("SELECT analysis FROM placement_results").get())
          .analysis,
      ).recommendedLevel,
      "N3",
    );
    await db
      .prepare(
        "DELETE FROM questions WHERE language='ja' AND assessment='competency' AND levelCode='N5' AND skill='reading'",
      )
      .run();
    assert.equal(
      (
        await call("/placement/attempts", {
          language: "ja",
          assessment: "competency",
        })
      ).status,
      409,
    );
  } finally {
    await new Promise((r) => server.close(r));
    await db.close();
  }
});
