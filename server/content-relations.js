// Source IDs are optional: the immutable snapshot survives source-bank deletion.
export async function linkAttemptQuestions(db, token, questions, review = []) {
  const sources = new Set(
    (await db.prepare("SELECT id FROM questions").all()).map((q) => q.id),
  );
  const existing = new Set(
    (
      await db
        .prepare(
          "SELECT position FROM placement_attempt_questions WHERE attemptToken=?",
        )
        .all(token)
    ).map((q) => q.position),
  );
  for (const [index, q] of questions.entries()) {
    if (existing.has(index + 1)) continue;
    const selected = review.find((r) => r.id === q.id)?.selected;
    await db
      .prepare(
        "INSERT INTO placement_attempt_questions(attemptToken,questionId,position,snapshot,selected) VALUES (?,?,?,?,?)",
      )
      .run(
        token,
        sources.has(q.id) ? q.id : null,
        index + 1,
        JSON.stringify(q),
        Number.isInteger(selected) && selected >= 0 && selected <= 3
          ? selected
          : null,
      );
  }
}

export async function backfillQuestionLinks(db) {
  for (const a of await db
    .prepare(
      "SELECT a.token,a.questions,a.result FROM placement_attempts a WHERE NOT EXISTS(SELECT 1 FROM placement_attempt_questions q WHERE q.attemptToken=a.token)",
    )
    .all()) {
    const questions = JSON.parse(a.questions),
      review = a.result ? JSON.parse(a.result).review || [] : [];
    await linkAttemptQuestions(db, a.token, questions, review);
  }
}

export async function recordContentUpdate(db, table, actorId) {
  const now = new Date().toISOString();
  await db
    .prepare(
      "INSERT INTO metadata(key,value,updatedBy,updatedAt) VALUES (?,?,?,?) ON CONFLICT(key) DO UPDATE SET value=excluded.value,updatedBy=excluded.updatedBy,updatedAt=excluded.updatedAt",
    )
    .run(`content:${table}`, now, actorId, now);
}
