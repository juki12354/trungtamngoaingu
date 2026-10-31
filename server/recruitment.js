import { Router } from "express";
import { z } from "zod";
import { randomInt } from "node:crypto";
import { fail } from "./domain.js";
import { mutation } from "./mutation.js";
import { fileMime } from "./management.js";
import { buildCompetencyQuestions } from "./competency-seed.js";
import { languageCodes, languageName } from "../shared/languages.js";
import { proficiencyFor } from "../shared/proficiency.js";
import { applicationStatuses } from "../shared/recruitment.js";

const languageLevel = z
  .object({ language: z.enum(languageCodes), levelCode: z.string() })
  .refine(
    (v) =>
      proficiencyFor(v.language).levels.some((l) => l.code === v.levelCode),
    { message: "Cấp độ không thuộc ngôn ngữ đã chọn." },
  );
const applicationSchema = languageLevel.extend({
  name: z.string().trim().min(2).max(150),
  phone: z.string().regex(/^[+\d\s()-]{8,20}$/, "Số điện thoại chưa hợp lệ."),
  qualifications: z.string().trim().min(10).max(3000),
  experience: z.number().int().min(0).max(60),
  coverLetter: z.string().trim().max(3000).default(""),
  filename: z
    .string()
    .min(1)
    .max(180)
    .refine(
      (s) => !/[\\/]/.test(s) && [...s].every((c) => c.charCodeAt(0) >= 32),
    ),
  content: z.string().min(1).max(7_000_000),
});
// Keep file bytes out of every list/detail query.
const columns =
  "id,userId,name,email,phone,language,levelCode,qualifications,experience,coverLetter,filename,mime,size,status,feedback,internalNote,evaluation,reviewedBy,reviewedAt,createdAt";
const decode = (row) =>
  row && { ...row, evaluation: JSON.parse(row.evaluation) };
const decodeExam = (e) =>
  e &&
  Object.fromEntries(
    Object.entries(e).map(([k, v]) => [
      k,
      ["questions", "tasks", "answers", "written"].includes(k)
        ? JSON.parse(v)
        : v,
    ]),
  );
const terminal = (a) => ["approved", "rejected"].includes(a.status);
function examQuestions(language, levelCode) {
  const levels = proficiencyFor(language).levels;
  const index = levels.findIndex((l) => l.code === levelCode);
  const codes = levels
    .slice(Math.max(0, index - 2), index + 1)
    .map((l) => l.code);
  return buildCompetencyQuestions(language)
    .filter((q) => codes.includes(q.levelCode))
    .map((q, i) => {
      const choices = q.options.map((text, n) => ({
        text,
        correct: n === q.answer,
      }));
      for (let j = choices.length - 1; j > 0; j--) {
        const k = randomInt(j + 1);
        [choices[j], choices[k]] = [choices[k], choices[j]];
      }
      return {
        id: `q${i + 1}`,
        levelCode: q.levelCode,
        skill: q.skill,
        prompt: q.prompt,
        options: choices.map((c) => c.text),
        answer: choices.findIndex((c) => c.correct),
      };
    });
}
function candidateExam(exam) {
  if (!exam) return null;
  const {
    id,
    language,
    levelCode,
    status,
    startedAt,
    expires,
    submittedAt,
    score,
    questions,
    tasks,
    answers,
    written,
  } = exam;
  return {
    id,
    language,
    levelCode,
    status,
    startedAt,
    expires,
    submittedAt,
    score,
    total: questions.length,
    ...(status === "started" && expires > Date.now()
      ? {
          questions: questions.map(({ answer: _answer, ...q }) => q),
          tasks,
          answers,
          written,
        }
      : {}),
  };
}

export function mountRecruitment(
  app,
  { db, requireUser, requireAdmin, write, submitLimit },
) {
  const own = Router(),
    admin = Router();
  app.use("/api/recruitment", requireUser, own);
  app.use("/api/admin/recruitment", requireUser, requireAdmin, admin);
  const get = async (req, adminAccess = false) => {
    const id = z.coerce.number().int().positive().parse(req.params.id);
    const a = decode(
      await db
        .prepare(`SELECT ${columns} FROM teacher_applications WHERE id=?`)
        .get(id),
    );
    if (!a || (!adminAccess && a.userId !== req.user.id))
      throw fail(404, "Không tìm thấy hồ sơ ứng tuyển.");
    return a;
  };
  const exams = async (id) =>
    (
      await db
        .prepare(
          "SELECT * FROM teacher_assessments WHERE applicationId=? ORDER BY id DESC",
        )
        .all(id)
    ).map(decodeExam);
  const last = async (id) =>
    decodeExam(
      await db
        .prepare(
          "SELECT * FROM teacher_assessments WHERE applicationId=? ORDER BY id DESC LIMIT 1",
        )
        .get(id),
    );
  const audit = async (req, action, id) =>
    db
      .prepare(
        "INSERT INTO audit_logs(actorId,action,resource,recordId) VALUES (?,?,?,?)",
      )
      .run(req.user.id, action, "teacher_applications", id);
  const safeApplication = (a) => {
    const { internalNote: _note, reviewedBy: _reviewer, ...rest } = a;
    return rest;
  };
  own.get("/applications", async (req, res) =>
    res.json(
      (
        await db
          .prepare(
            `SELECT ${columns} FROM teacher_applications WHERE userId=? ORDER BY id DESC`,
          )
          .all(req.user.id)
      )
        .map(decode)
        .map(safeApplication),
    ),
  );
  own.post(
    "/applications",
    submitLimit,
    mutation(db, async (req) => {
      const data = applicationSchema.parse(req.body);
      if (
        await db
          .prepare(
            "SELECT id FROM teacher_applications WHERE userId=? AND language=? AND status!='rejected'",
          )
          .get(req.user.id, data.language)
      )
        throw fail(
          409,
          "Bạn đã có hồ sơ đang xử lý hoặc đã được duyệt cho ngôn ngữ này.",
        );
      const content = Buffer.from(data.content, "base64");
      if (content.length > 5 * 1024 * 1024) throw fail(413, "CV tối đa 5 MB.");
      if (!content.length || content.toString("base64") !== data.content)
        throw fail(400, "Dữ liệu tệp không hợp lệ.");
      const mime = await fileMime(data.filename, content);
      const row = {
        ...data,
        userId: req.user.id,
        email: req.user.email,
        mime,
        size: content.length,
        content,
      };
      const keys = Object.keys(row);
      const id = Number(
        (
          await db
            .prepare(
              `INSERT INTO teacher_applications (${keys.join(",")}) VALUES (${keys.map(() => "?").join(",")})`,
            )
            .run(...keys.map((key) => row[key]))
        ).lastInsertRowid,
      );
      await audit(req, "apply", id);
      return { status: 201, body: { id } };
    }),
  );
  own.get("/applications/:id", async (req, res) => {
    const a = await get(req);
    res.json({
      ...safeApplication(a),
      assessment: candidateExam(await last(a.id)),
    });
  });
  own.get("/applications/:id/cv", async (req, res) => {
    const a = await get(req, req.user.role === "admin");
    const row = await db
      .prepare("SELECT content FROM teacher_applications WHERE id=?")
      .get(a.id);
    res
      .set({
        "Content-Type": a.mime,
        "Content-Disposition": `attachment; filename="cv-${a.id}.${a.mime === "application/pdf" ? "pdf" : "docx"}"; filename*=UTF-8''${encodeURIComponent(a.filename).replace(/['()*]/g, (c) => `%${c.charCodeAt(0).toString(16)}`)}`,
      })
      .send(Buffer.from(row.content));
  });
  own.post(
    "/applications/:id/start",
    submitLimit,
    mutation(db, async (req) => {
      const a = await get(req),
        exam = await last(a.id);
      if (
        terminal(a) ||
        !exam ||
        !["assigned", "started"].includes(exam.status)
      )
        throw fail(409, "Chưa có đề hợp lệ để làm. Vui lòng chờ QTV giao đề.");
      if (exam.status === "started" && exam.expires <= Date.now())
        throw fail(
          409,
          "Bài kiểm tra đã hết giờ. Hãy liên hệ QTV để được giao lại đề.",
        );
      if (exam.status === "assigned") {
        exam.startedAt = Date.now();
        exam.expires = exam.startedAt + 60 * 60 * 1000;
        exam.status = "started";
        await write(
          "teacher_assessments",
          {
            startedAt: exam.startedAt,
            expires: exam.expires,
            status: exam.status,
          },
          exam.id,
        );
      }
      return { status: 200, body: candidateExam(exam) };
    }),
  );
  own.post(
    "/applications/:id/submit",
    submitLimit,
    mutation(db, async (req) => {
      const a = await get(req),
        exam = await last(a.id);
      if (
        terminal(a) ||
        !exam ||
        exam.id !== req.body?.assessmentId ||
        exam.status !== "started" ||
        exam.expires <= Date.now()
      )
        throw fail(
          409,
          "Đề không còn hợp lệ, đã nộp hoặc hết giờ. Hãy liên hệ QTV.",
        );
      const data = z
        .object({
          assessmentId: z.number().int().positive(),
          answers: z.record(z.string(), z.number().int().min(0).max(3)),
          written: z
            .array(
              z
                .string()
                .trim()
                .min(80, "Mỗi bài tự luận cần ít nhất 80 ký tự.")
                .max(6000),
            )
            .length(2),
        })
        .parse(req.body);
      if (
        Object.keys(data.answers).length !== exam.questions.length ||
        exam.questions.some((q) => !Object.hasOwn(data.answers, q.id))
      )
        throw fail(400, "Hãy trả lời đủ các câu trắc nghiệm.");
      const score = exam.questions.filter(
        (q) => q.answer === data.answers[q.id],
      ).length;
      await write(
        "teacher_assessments",
        {
          answers: data.answers,
          written: data.written,
          status: "submitted",
          score,
          submittedAt: new Date().toISOString(),
        },
        exam.id,
      );
      await write("teacher_applications", { status: "review" }, a.id);
      await audit(req, "submit-assessment", a.id);
      return { status: 200, body: { score, total: exam.questions.length } };
    }),
  );
  own.put(
    "/applications/:id/draft",
    mutation(db, async (req) => {
      const a = await get(req),
        exam = await last(a.id);
      if (
        terminal(a) ||
        !exam ||
        exam.id !== req.body?.assessmentId ||
        exam.status !== "started" ||
        exam.expires <= Date.now()
      )
        throw fail(409, "Không thể lưu: đề đã đóng, nộp hoặc hết giờ.");
      const data = z
        .object({
          answers: z.record(z.string(), z.number().int().min(0).max(3)),
          written: z.array(z.string().max(6000)).length(2),
        })
        .parse(req.body);
      if (
        Object.keys(data.answers).some(
          (id) => !exam.questions.some((q) => q.id === id),
        )
      )
        throw fail(400, "Câu trả lời không thuộc đề.");
      await write("teacher_assessments", data, exam.id);
      return { status: 200, body: { ok: true } };
    }),
  );
  admin.get("/", async (req, res) => {
    const query = z
      .object({
        page: z.coerce.number().int().min(1).default(1),
        language: z.enum(languageCodes).optional(),
        status: z.enum(Object.keys(applicationStatuses)).optional(),
      })
      .parse(req.query);
    const conditions = [],
      params = [];
    for (const key of ["language", "status"])
      if (query[key]) {
        conditions.push(`${key}=?`);
        params.push(query[key]);
      }
    const where = conditions.length ? ` WHERE ${conditions.join(" AND ")}` : "";
    const total = (
      await db
        .prepare(`SELECT count(*) AS n FROM teacher_applications${where}`)
        .get(...params)
    ).n;
    const rows = (
      await db
        .prepare(
          `SELECT ${columns} FROM teacher_applications${where} ORDER BY id DESC LIMIT 25 OFFSET ?`,
        )
        .all(...params, (query.page - 1) * 25)
    ).map(decode);
    res.json({ rows, total, page: query.page, pageSize: 25 });
  });
  admin.get("/:id", async (req, res) => {
    const a = await get(req, true);
    res.json({ ...a, assessments: await exams(a.id) });
  });
  admin.post(
    "/:id/assessments",
    mutation(db, async (req) => {
      const a = await get(req, true);
      if (terminal(a)) throw fail(409, "Hồ sơ đã có quyết định cuối cùng.");
      const data = languageLevel
        .extend({
          cvVerified: z.literal(true, {
            error: "Cần xác nhận đã đối chiếu CV.",
          }),
          basis: z.string().trim().min(15).max(2000),
          reason: z.string().trim().max(1000).default(""),
          tasks: z
            .array(z.string().trim().min(30).max(2000))
            .length(2)
            .optional(),
        })
        .parse(req.body);
      const previous = await last(a.id);
      if (previous && data.reason.length < 10)
        throw fail(400, "Ghi rõ lý do giao lại đề (ít nhất 10 ký tự).");
      if (previous)
        await write(
          "teacher_assessments",
          { status: "superseded" },
          previous.id,
        );
      const target = `${languageName(data.language)} ${data.levelCode}`;
      const tasks = data.tasks || [
        `Bằng ${languageName(data.language)}, chọn một điểm ngữ pháp hoặc từ vựng ở cấp độ ${data.levelCode}; giải thích kèm ví dụ đúng/sai và lập kế hoạch bài dạy 20 phút cho lớp ${target}. Nêu mục tiêu, hoạt động và cách kiểm tra học viên đạt mục tiêu. Liên hệ kinh nghiệm đã nêu trong CV.`,
        `Bằng ${languageName(data.language)}, tự đưa ra hai lỗi điển hình của người học ${target}; viết phản hồi sửa lỗi, giải thích nguyên nhân và thiết kế một hoạt động luyện tập có cách đánh giá tiến bộ.`,
      ];
      const id = await write("teacher_assessments", {
        applicationId: a.id,
        language: data.language,
        levelCode: data.levelCode,
        basis: data.basis,
        reason: data.reason,
        questions: examQuestions(data.language, data.levelCode),
        tasks,
        createdBy: req.user.id,
      });
      await write(
        "teacher_applications",
        {
          status: "test_assigned",
          evaluation: {},
          feedback: "",
          internalNote: "",
          reviewedBy: null,
          reviewedAt: null,
        },
        a.id,
      );
      await audit(
        req,
        previous ? "reissue-assessment" : "issue-assessment",
        a.id,
      );
      return { status: 201, body: { id } };
    }),
  );
  admin.post(
    "/:id/review",
    mutation(db, async (req) => {
      const a = await get(req, true),
        exam = await last(a.id);
      if (terminal(a)) throw fail(409, "Hồ sơ đã có quyết định cuối cùng.");
      const data = z
        .object({
          decision: z.enum(["review", "approved", "rejected"]),
          cvVerified: z.literal(true, {
            error: "Cần xác nhận đã đối chiếu CV và bằng cấp.",
          }),
          languageUse: z.number().int().min(0).max(20).optional(),
          lessonPlanning: z.number().int().min(0).max(30).optional(),
          feedbackSkill: z.number().int().min(0).max(20).optional(),
          feedback: z.string().trim().min(10).max(3000),
          internalNote: z.string().trim().max(3000).default(""),
        })
        .parse(req.body);
      const complete = exam?.status === "submitted";
      if (data.decision !== "rejected" && !complete)
        throw fail(
          409,
          "Phải hoàn thành bài kiểm tra mới nhất trước khi chấm và duyệt hồ sơ.",
        );
      let evaluation = {};
      if (complete) {
        const scores = [
          data.languageUse,
          data.lessonPlanning,
          data.feedbackSkill,
        ];
        if (scores.some((v) => v === undefined))
          throw fail(400, "Cần chấm đủ ba tiêu chí tự luận.");
        const automatic = Math.round((exam.score / exam.questions.length) * 30);
        evaluation = {
          assessmentId: exam.id,
          cvVerified: true,
          automatic,
          languageUse: data.languageUse,
          lessonPlanning: data.lessonPlanning,
          feedbackSkill: data.feedbackSkill,
          total: automatic + scores.reduce((s, v) => s + v, 0),
        };
      }
      await write(
        "teacher_applications",
        {
          status: data.decision,
          feedback: data.feedback,
          internalNote: data.internalNote,
          evaluation,
          reviewedBy: req.user.id,
          reviewedAt: new Date().toISOString(),
        },
        a.id,
      );
      if (data.decision === "rejected" && exam && !complete)
        await write("teacher_assessments", { status: "superseded" }, exam.id);
      await audit(req, data.decision, a.id);
      return { status: 200, body: { ok: true } };
    }),
  );
}
