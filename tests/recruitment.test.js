import { test } from "node:test";
import assert from "node:assert/strict";
import { createApp } from "./helpers/app.js";
import { languages } from "../shared/languages.js";
import { proficiencyFor } from "../shared/proficiency.js";

async function setup(t) {
  const app = await createApp({ dbPath: ":memory:", demo: true });
  const server = app.listen(0, "127.0.0.1");
  await new Promise((r) => server.once("listening", r));
  t.after(async () => {
    await new Promise((r) => server.close(r));
    await app.locals.db.close();
  });
  const request = async (path, method = "GET", body, cookie) => {
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
      cookie: res.headers.get("set-cookie")?.split(";")[0],
      body: res.headers.get("content-type")?.includes("json")
        ? await res.json()
        : Buffer.from(await res.arrayBuffer()),
    };
  };
  const login = async (email, password) =>
    (await request("/auth/login", "POST", { email, password })).cookie;
  return {
    request,
    db: app.locals.db,
    admin: await login("admin@vinhenglish.vn", "Admin@123456"),
    candidate: await login("hocvien@example.com", "Student@123456"),
  };
}
const cv = {
  name: "Giáo viên ứng tuyển",
  phone: "0901234567",
  language: "ja",
  levelCode: "N2",
  qualifications: "JLPT N2; bằng sư phạm; thành tích đào tạo",
  experience: 4,
  coverLetter: "Mong muốn giảng dạy tiếng Nhật N2",
  filename: "CV giáo viên.pdf",
  content: Buffer.from("%PDF-1.4\nTeacher CV\n%%EOF").toString("base64"),
};
const issue = {
  language: "ja",
  levelCode: "N2",
  cvVerified: true,
  basis: "Đã đối chiếu JLPT N2 và bốn năm kinh nghiệm trong CV.",
};
const review = {
  decision: "approved",
  cvVerified: true,
  languageUse: 17,
  lessonPlanning: 25,
  feedbackSkill: 16,
  internalNote: "Cần dự giờ thêm; ghi chú nội bộ",
  feedback: "Bài dạy có cấu trúc rõ ràng, hồ sơ được duyệt.",
};

test("teacher CV workflow requires a completed level-specific exam and human evaluation", async (t) => {
  const { request: r, candidate, admin, db } = await setup(t);
  const created = await r("/recruitment/applications", "POST", cv, candidate);
  assert.equal(created.status, 201, JSON.stringify(created.body));
  const root = `/recruitment/applications/${created.body.id}`;
  const manage = `/admin/recruitment/${created.body.id}`;
  assert.equal(
    (await r(`${manage}/review`, "POST", review, admin)).status,
    409,
  );
  assert.equal((await r(`${root}/start`, "POST", {}, candidate)).status, 409);
  assert.equal(
    (await r(`${manage}/assessments`, "POST", issue, admin)).status,
    201,
  );
  const started = await r(`${root}/start`, "POST", {}, candidate);
  assert.equal(started.status, 200);
  assert.equal(started.body.language, "ja");
  assert.equal(started.body.levelCode, "N2");
  assert.ok(started.body.questions.some((q) => q.levelCode === "N2"));
  assert.equal(JSON.stringify(started.body).includes('"answer"'), false);
  const resumed = await r(`${root}/start`, "POST", {}, candidate);
  assert.equal(resumed.body.expires, started.body.expires);
  const detail = (await r(manage, "GET", undefined, admin)).body;
  const exam = detail.assessments[0];
  const answers = Object.fromEntries(
    exam.questions.map((q) => [q.id, q.answer]),
  );
  assert.equal(
    (
      await r(
        `${root}/submit`,
        "POST",
        { assessmentId: exam.id, answers, written: ["", ""] },
        candidate,
      )
    ).status,
    400,
  );
  const submitted = await r(
    `${root}/submit`,
    "POST",
    {
      assessmentId: exam.id,
      answers,
      written: [
        "Giáo án bằng ngôn ngữ ứng tuyển. ".repeat(8),
        "Phản hồi lỗi và hoạt động sửa lỗi. ".repeat(8),
      ],
    },
    candidate,
  );
  assert.equal(submitted.status, 200);
  assert.equal(submitted.body.score, exam.questions.length);
  assert.equal(
    (
      await r(
        `${root}/submit`,
        "POST",
        { assessmentId: exam.id, answers, written: [] },
        candidate,
      )
    ).status,
    409,
  );
  assert.equal(
    (await r(`${manage}/review`, "POST", { ...review, languageUse: 21 }, admin))
      .status,
    400,
  );
  assert.equal(
    (await r(`${manage}/review`, "POST", review, admin)).status,
    200,
  );
  const own = (await r(root, "GET", undefined, candidate)).body;
  assert.equal(own.status, "approved");
  assert.equal(own.evaluation.total, 88);
  assert.equal(JSON.stringify(own).includes("Cần dự giờ"), false);
  assert.equal(JSON.stringify(own).includes('"answer"'), false);
  assert.equal(
    (await r(`${manage}/assessments`, "POST", issue, admin)).status,
    409,
  );
  assert.ok(
    (
      await db
        .prepare(
          "SELECT * FROM audit_logs WHERE resource='teacher_applications'",
        )
        .all()
    ).length >= 3,
  );
});

test("CVs and exam answers stay private; malformed uploads and duplicate applications are rejected", async (t) => {
  const { request: r, candidate, admin } = await setup(t);
  assert.equal((await r("/recruitment/applications", "POST", cv)).status, 401);
  for (const invalid of [
    { filename: "bad.exe" },
    { filename: "../cv.pdf" },
    { content: "AAAA" },
    { language: "ja", levelCode: "HSK4" },
  ])
    assert.equal(
      (
        await r(
          "/recruitment/applications",
          "POST",
          { ...cv, ...invalid },
          candidate,
        )
      ).status,
      400,
    );
  assert.equal(
    (
      await r(
        "/recruitment/applications",
        "POST",
        {
          ...cv,
          content: Buffer.alloc(5 * 1024 * 1024 + 1).toString("base64"),
        },
        candidate,
      )
    ).status,
    413,
  );
  const made = await r("/recruitment/applications", "POST", cv, candidate);
  const path = `/recruitment/applications/${made.body.id}`;
  assert.equal(
    (await r("/recruitment/applications", "POST", cv, candidate)).status,
    409,
  );
  const other = await r("/auth/register", "POST", {
    name: "Khác",
    email: "other-teacher@example.com",
    phone: "0901234568",
    password: "Other@123456",
  });
  for (const suffix of ["", "/cv"])
    assert.equal(
      (await r(path + suffix, "GET", undefined, other.cookie)).status,
      404,
    );
  assert.equal(
    (await r(`${path}/start`, "POST", {}, other.cookie)).status,
    404,
  );
  assert.equal(
    (await r("/admin/recruitment", "GET", undefined, candidate)).status,
    403,
  );
  assert.equal(
    (await r(`${path}/cv`, "GET", undefined, candidate)).body.toString(),
    Buffer.from(cv.content, "base64").toString(),
  );
  assert.equal((await r(`${path}/cv`, "GET", undefined, admin)).status, 200);
  const list = await r(
    "/admin/recruitment?language=ja&status=submitted&page=1",
    "GET",
    undefined,
    admin,
  );
  assert.equal(list.body.total, 1);
  assert.equal(JSON.stringify(list.body).includes(cv.content), false);
  assert.equal(
    JSON.stringify((await r("/catalog")).body).includes(cv.phone),
    false,
  );
});

test("all 16 languages support CV-confirmed levels and reissued exams invalidate old work", async (t) => {
  const { request: r, candidate, admin } = await setup(t);
  for (const language of languages.map((l) => l.code)) {
    const levelCode = proficiencyFor(language).levels.at(-1).code;
    const made = await r(
      "/recruitment/applications",
      "POST",
      { ...cv, language, levelCode },
      candidate,
    );
    assert.equal(made.status, 201);
    const manage = `/admin/recruitment/${made.body.id}`;
    assert.equal(
      (
        await r(
          `${manage}/assessments`,
          "POST",
          { ...issue, language, levelCode, cvVerified: false },
          admin,
        )
      ).status,
      400,
    );
    assert.equal(
      (
        await r(
          `${manage}/assessments`,
          "POST",
          { ...issue, language, levelCode },
          admin,
        )
      ).status,
      201,
    );
    const path = `/recruitment/applications/${made.body.id}`;
    const old = (await r(`${path}/start`, "POST", {}, candidate)).body;
    assert.ok(old.questions.some((q) => q.levelCode === levelCode));
    assert.equal(
      (
        await r(
          `${manage}/assessments`,
          "POST",
          {
            ...issue,
            language,
            levelCode,
            reason: "Điều chỉnh nhiệm vụ theo kinh nghiệm trong CV",
          },
          admin,
        )
      ).status,
      201,
    );
    assert.equal(
      (
        await r(
          `${path}/submit`,
          "POST",
          { assessmentId: old.id, answers: {}, written: [] },
          candidate,
        )
      ).status,
      409,
    );
    assert.equal(
      (await r(`${manage}/review`, "POST", review, admin)).status,
      409,
    );
  }
});

test("server enforces exam expiry and rejects candidate attempts to issue or approve exams", async (t) => {
  const { request: r, candidate, admin, db } = await setup(t);
  const made = await r("/recruitment/applications", "POST", cv, candidate);
  const manage = `/admin/recruitment/${made.body.id}`,
    root = `/recruitment/applications/${made.body.id}`;
  assert.equal(
    (await r(`${manage}/assessments`, "POST", issue, candidate)).status,
    403,
  );
  assert.equal(
    (await r(`${manage}/review`, "POST", review, candidate)).status,
    403,
  );
  await r(`${manage}/assessments`, "POST", issue, admin);
  const exam = (await r(`${root}/start`, "POST", {}, candidate)).body;
  await db
    .prepare("UPDATE teacher_assessments SET expires=? WHERE id=?")
    .run(Date.now() - 1000, exam.id);
  assert.equal((await r(`${root}/start`, "POST", {}, candidate)).status, 409);
  assert.equal(
    (
      await r(
        `${root}/submit`,
        "POST",
        { assessmentId: exam.id, answers: {}, written: [] },
        candidate,
      )
    ).status,
    409,
  );
});

test("CV-specific tasks, saved drafts and new exam requirements persist across reviews", async (t) => {
  const { request: r, candidate, admin } = await setup(t);
  const made = await r("/recruitment/applications", "POST", cv, candidate);
  const manage = `/admin/recruitment/${made.body.id}`,
    root = `/recruitment/applications/${made.body.id}`;
  const tasks = [
    "Thiết kế một bài học N1 dựa trên kinh nghiệm dạy đọc học thuật trong CV, viết bằng tiếng Nhật.",
    "Dựa trên thành tích hướng dẫn viết trong CV, đưa ra lỗi và cách phản hồi học viên N1 bằng tiếng Nhật.",
  ];
  assert.equal(
    (
      await r(
        `${manage}/assessments`,
        "POST",
        { ...issue, levelCode: "N1", tasks },
        admin,
      )
    ).status,
    201,
  );
  const exam = (await r(`${root}/start`, "POST", {}, candidate)).body;
  assert.equal(exam.levelCode, "N1");
  assert.deepEqual(exam.tasks, tasks);
  const answers = { [exam.questions[0].id]: 1 },
    written = ["Bản nháp chưa hoàn chỉnh", ""];
  assert.equal(
    (
      await r(
        `${root}/draft`,
        "PUT",
        { assessmentId: exam.id, answers, written },
        candidate,
      )
    ).status,
    200,
  );
  const resumed = (await r(`${root}/start`, "POST", {}, candidate)).body;
  assert.deepEqual(resumed.answers, answers);
  assert.deepEqual(resumed.written, written);
  assert.deepEqual(resumed.questions, exam.questions);
  const completeAnswers = Object.fromEntries(
    exam.questions.map((q) => [q.id, 0]),
  );
  await r(
    `${root}/submit`,
    "POST",
    {
      assessmentId: exam.id,
      answers: completeAnswers,
      written: [
        "Giải thích kiến thức và hoạt động trong giáo án. ".repeat(6),
        "Phản hồi bài làm và hướng dẫn sửa lỗi của học viên. ".repeat(6),
      ],
    },
    candidate,
  );
  assert.equal(
    (
      await r(
        `${manage}/review`,
        "POST",
        { ...review, decision: "review" },
        admin,
      )
    ).status,
    200,
  );
  assert.equal(
    (
      await r(
        `${manage}/assessments`,
        "POST",
        {
          ...issue,
          reason: "Cần kiểm tra lại cấp độ đúng theo bằng cấp trong CV.",
        },
        admin,
      )
    ).status,
    201,
  );
  assert.equal(
    (await r(`${manage}/review`, "POST", review, admin)).status,
    409,
  );
  assert.equal(
    (
      await r(
        `${root}/draft`,
        "PUT",
        { assessmentId: exam.id, answers, written },
        candidate,
      )
    ).status,
    409,
  );
  const own = (await r(root, "GET", undefined, candidate)).body;
  assert.deepEqual(own.evaluation, {});
  assert.equal(own.status, "test_assigned");
  assert.equal(
    (
      await r(
        `${manage}/review`,
        "POST",
        {
          decision: "rejected",
          cvVerified: true,
          feedback: "Thông tin bằng cấp chưa được xác minh đầy đủ.",
        },
        admin,
      )
    ).status,
    200,
  );
  assert.equal((await r(`${root}/start`, "POST", {}, candidate)).status, 409);
  assert.equal(
    (await r("/recruitment/applications", "POST", cv, candidate)).status,
    201,
  );
});
