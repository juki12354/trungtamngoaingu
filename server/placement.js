import { mutation } from "./mutation.js";
import { createHash, randomBytes } from "node:crypto";
import { fail } from "./domain.js";
import { languageCodes } from "../shared/languages.js";
import {
  evaluateCompetency,
  proficiencyFor,
  skillLabels,
} from "../shared/proficiency.js";
import { recommendClasses } from "./placement-recommendations.js";
const digest = (token) => createHash("sha256").update(token).digest("hex");
export function mountPlacement(app, { db, submitLimit, all, write }) {
  app.post(
    "/api/placement/attempts",
    submitLimit,
    mutation(db, async (req, _res) => {
      const language = req.body?.language || "en";
      const assessment = req.body?.assessment || "legacy";
      if (!["legacy", "competency"].includes(assessment))
        throw fail(400, "Loại bài kiểm tra không hợp lệ.");
      if (!languageCodes.includes(language))
        throw fail(400, "Ngôn ngữ không hợp lệ.");
      const questions = (await all("questions"))
        .reverse()
        .filter((q) => q.language === language && q.assessment === assessment);
      if (!questions.length)
        throw fail(409, "Bài kiểm tra đang được cập nhật.");
      if (assessment === "competency") {
        const { levels } = proficiencyFor(language),
          skills = Object.keys(skillLabels);
        if (
          levels.some((l) =>
            skills.some(
              (s) =>
                !questions.some((q) => q.levelCode === l.code && q.skill === s),
            ),
          ) ||
          questions.some(
            (q) =>
              !levels.some((l) => l.code === q.levelCode) ||
              !skills.includes(q.skill),
          )
        )
          throw fail(
            409,
            "Bộ đề năng lực chưa đủ cấp độ và kỹ năng. Vui lòng quay lại sau hoặc liên hệ tư vấn.",
          );
        questions.sort(
          (a, b) =>
            levels.findIndex((l) => l.code === a.levelCode) -
              levels.findIndex((l) => l.code === b.levelCode) ||
            skills.indexOf(a.skill) - skills.indexOf(b.skill) ||
            a.id - b.id,
        );
      }
      await db
        .prepare("DELETE FROM placement_attempts WHERE expires < ?")
        .run(Date.now() - 86400000);
      const token = randomBytes(32).toString("hex"),
        expiresAt = Date.now() + 30 * 60 * 1000;
      await db
        .prepare(
          "INSERT INTO placement_attempts(token,userId,questions,expires,language,assessment) VALUES (?,?,?,?,?,?)",
        )
        .run(
          digest(token),
          req.user?.id ?? null,
          JSON.stringify(questions),
          expiresAt,
          language,
          assessment,
        );
      return {
        status: 201,
        body: {
          token,
          expiresAt,
          language,
          assessment,
          questions: questions.map(({ answer, ...q }) => q),
        },
      };
    }),
  );
  app.post(
    "/api/placement",
    submitLimit,
    mutation(db, async (req, _res) => {
      const { token, answers } = req.body || {};
      if (typeof token !== "string" || !/^[a-f0-9]{64}$/.test(token))
        throw fail(400, "Vui lòng bắt đầu một lượt kiểm tra mới.");
      const attempt = await db
        .prepare("SELECT * FROM placement_attempts WHERE token=?")
        .get(digest(token));
      if (!attempt) throw fail(404, "Không tìm thấy lượt kiểm tra.");
      if (attempt.userId !== null && attempt.userId !== req.user?.id)
        throw fail(403, "Lượt kiểm tra thuộc tài khoản khác.");
      if (attempt.result)
        return {
          status: 200,
          body: await refreshResult(JSON.parse(attempt.result)),
        };
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
      const language = attempt.language || "en";
      if (attempt.assessment === "competency") {
        const analysis = evaluateCompetency(language, questions, answers);
        const review = questions.map((q) => ({
          id: q.id,
          prompt: q.prompt,
          options: q.options,
          answer: q.answer,
          selected: answers[q.id],
          skill: q.skill,
          levelCode: q.levelCode,
        }));
        const id = await write("placement_results", {
          userId: attempt.userId,
          language,
          score,
          total: questions.length,
          level: analysis.level,
          review,
          analysis,
        });
        const result = await refreshResult({
          id,
          score,
          total: questions.length,
          language,
          level: analysis.level,
          review,
          analysis,
        });
        await db
          .prepare("UPDATE placement_attempts SET result=? WHERE token=?")
          .run(JSON.stringify(result), digest(token));
        return { status: 200, body: result };
      }
      const level =
        language === "en"
          ? ratio < 0.4
            ? "A1"
            : ratio < 0.7
              ? "A2"
              : ratio < 0.9
                ? "B1"
                : "B2"
          : ratio < 0.7
            ? "Nhập môn"
            : "Có nền tảng từ vựng";
      const category =
        language === "en"
          ? ratio < 0.4
            ? "Căn bản"
            : ratio < 0.7
              ? "Giao tiếp"
              : "IELTS"
          : ratio < 0.7
            ? "Căn bản"
            : "Giao tiếp";
      const course =
        (await db
          .prepare(
            "SELECT id FROM courses WHERE category=? AND language=? ORDER BY id LIMIT 1",
          )
          .get(category, language)) ||
        (await db
          .prepare(
            "SELECT id FROM courses WHERE language=? ORDER BY id LIMIT 1",
          )
          .get(language));
      const review = questions.map((q) => ({
        id: q.id,
        prompt: q.prompt,
        options: q.options,
        answer: q.answer,
        selected: answers[q.id],
      }));
      const id = await write("placement_results", {
        userId: attempt.userId,
        language,
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
        language,
        review,
      };
      await db
        .prepare("UPDATE placement_attempts SET result=? WHERE token=?")
        .run(JSON.stringify(result), digest(token));
      return {
        status: 200,
        body: result,
      };
    }),
  );
  async function refreshResult(result) {
    if (result.analysis?.version !== "competency-v1") return result;
    const recommendations = await recommendClasses(
      db,
      result.language,
      result.analysis.recommendedLevel,
    );
    return { ...result, courseId: recommendations.courseId, recommendations };
  }
}
