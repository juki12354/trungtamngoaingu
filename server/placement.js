import { createHash, randomBytes } from "node:crypto";
import { fail } from "./domain.js";
const digest = (token) => createHash("sha256").update(token).digest("hex");
export function mountPlacement(app, { db, submitLimit, all, write }) {
  app.post("/api/placement/attempts", submitLimit, (req, res) => {
    const questions = all("questions").reverse();
    if (!questions.length) throw fail(409, "Bài kiểm tra đang được cập nhật.");
    db.prepare("DELETE FROM placement_attempts WHERE expires < ?").run(
      Date.now() - 86400000,
    );
    const token = randomBytes(32).toString("hex"),
      expiresAt = Date.now() + 30 * 60 * 1000;
    db.prepare(
      "INSERT INTO placement_attempts(token,userId,questions,expires) VALUES (?,?,?,?)",
    ).run(
      digest(token),
      req.user?.id ?? null,
      JSON.stringify(questions),
      expiresAt,
    );
    res
      .status(201)
      .json({
        token,
        expiresAt,
        questions: questions.map(({ answer, ...q }) => q),
      });
  });
  app.post("/api/placement", submitLimit, (req, res) => {
    const { token, answers } = req.body || {};
    if (typeof token !== "string" || !/^[a-f0-9]{64}$/.test(token))
      throw fail(400, "Vui lòng bắt đầu một lượt kiểm tra mới.");
    const attempt = db
      .prepare("SELECT * FROM placement_attempts WHERE token=?")
      .get(digest(token));
    if (!attempt) throw fail(404, "Không tìm thấy lượt kiểm tra.");
    if (attempt.userId !== null && attempt.userId !== req.user?.id)
      throw fail(403, "Lượt kiểm tra thuộc tài khoản khác.");
    if (attempt.result) return res.json(JSON.parse(attempt.result));
    if (attempt.expires < Date.now())
      throw fail(
        409,
        "Lượt kiểm tra đã hết hạn sau 30 phút. Vui lòng bắt đầu lại.",
      );
    const questions = JSON.parse(attempt.questions);
    if (
      !answers ||
      typeof answers !== "object" ||
      Array.isArray(answers) ||
      Object.keys(answers).length !== questions.length ||
      questions.some(
        (q) =>
          !Number.isInteger(answers[q.id]) ||
          answers[q.id] < 0 ||
          answers[q.id] > 3,
      )
    )
      throw fail(400, "Vui lòng trả lời đủ tất cả câu hỏi.");
    const score = questions.filter((q) => q.answer === answers[q.id]).length,
      ratio = score / questions.length;
    const level =
      ratio < 0.4 ? "A1" : ratio < 0.7 ? "A2" : ratio < 0.9 ? "B1" : "B2";
    const category =
      ratio < 0.4 ? "Căn bản" : ratio < 0.7 ? "Giao tiếp" : "IELTS";
    const course =
      db
        .prepare("SELECT id FROM courses WHERE category=? ORDER BY id LIMIT 1")
        .get(category) ||
      db.prepare("SELECT id FROM courses ORDER BY id LIMIT 1").get();
    const review = questions.map((q) => ({
      id: q.id,
      prompt: q.prompt,
      options: q.options,
      answer: q.answer,
      selected: answers[q.id],
    }));
    db.exec("BEGIN IMMEDIATE");
    try {
      const id = write("placement_results", {
        userId: attempt.userId,
        score,
        total: questions.length,
        level,
        review,
      });
      const result = {
        id,
        score,
        total: questions.length,
        level,
        courseId: course?.id ?? null,
        review,
      };
      db.prepare("UPDATE placement_attempts SET result=? WHERE token=?").run(
        JSON.stringify(result),
        digest(token),
      );
      db.exec("COMMIT");
      res.json(result);
    } catch (e) {
      db.exec("ROLLBACK");
      throw e;
    }
  });
}
