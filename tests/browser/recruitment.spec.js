import { test, expect } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";

test("candidate uploads a CV, completes a CV-confirmed exam, and admin evaluates and approves privately", async ({
  page,
  browser,
  request,
}) => {
  test.setTimeout(90000);
  const errors = [];
  page.on("pageerror", (e) => errors.push(e.message));
  const email = `teacher-${Date.now()}@example.com`;
  await page.goto("/ung-tuyen");
  await expect(
    page.getByRole("link", { name: "Đăng nhập / tạo tài khoản" }),
  ).toBeVisible();
  await page.getByRole("link", { name: "Đăng nhập / tạo tài khoản" }).click();
  await page.getByRole("button", { name: "Đăng ký ngay" }).click();
  await page.getByLabel("Họ và tên", { exact: true }).fill("Ứng viên kiểm thử");
  await page.getByLabel("Số điện thoại", { exact: true }).fill("0901234567");
  await page.getByLabel("Email", { exact: true }).fill(email);
  await page.getByLabel("Mật khẩu", { exact: true }).fill("Teacher@123456");
  await page
    .getByRole("button", { name: "Tạo tài khoản", exact: true })
    .click();
  await expect(page).toHaveURL(/\/ung-tuyen$/);
  await page.getByLabel("Ngôn ngữ ứng tuyển").selectOption("ja");
  await page.getByLabel("Cấp độ trong CV").selectOption("N2");
  await page.getByLabel("Kinh nghiệm giảng dạy (năm)").fill("4");
  await page
    .getByLabel("Bằng cấp, chứng chỉ và thành tích liên quan")
    .fill("JLPT N2; bốn năm kinh nghiệm dạy tiếng Nhật, bằng sư phạm.");
  await page.getByLabel("CV (PDF hoặc DOCX, tối đa 5 MB)").setInputFiles({
    name: "CV giảng viên.pdf",
    mimeType: "application/pdf",
    buffer: Buffer.from("%PDF-1.4\nTeacher CV\n%%EOF"),
  });
  for (const width of [320, 768, 1024, 1440]) {
    await page.setViewportSize({ width, height: 1000 });
    expect(
      await page.evaluate(
        () => document.documentElement.scrollWidth <= innerWidth + 1,
      ),
    ).toBe(true);
  }
  await page.getByRole("button", { name: "Gửi hồ sơ ứng tuyển" }).click();
  await expect(
    page.getByText("Đã nhận hồ sơ.", { exact: false }),
  ).toBeVisible();
  await request.post("/api/auth/login", {
    data: { email: "admin@vinhenglish.vn", password: "Admin@123456" },
  });
  const rows = (
    await (await request.get("/api/admin/recruitment?language=ja")).json()
  ).rows;
  const application = rows.find((r) => r.email === email);
  expect(application).toBeTruthy();

  const adminContext = await browser.newContext({
    baseURL: new URL(page.url()).origin,
  });
  const admin = await adminContext.newPage();
  admin.on("pageerror", (e) => errors.push(e.message));
  await admin.goto("/dang-nhap");
  await admin.getByLabel("Email", { exact: true }).fill("admin@vinhenglish.vn");
  await admin.getByLabel("Mật khẩu", { exact: true }).fill("Admin@123456");
  await admin.getByRole("button", { name: "Đăng nhập", exact: true }).click();
  await admin
    .getByRole("button", { name: "Tuyển dụng giáo viên", exact: true })
    .click();
  await admin
    .getByRole("button", { name: `Xem hồ sơ #${application.id}`, exact: true })
    .click();
  const downloadPromise = admin.waitForEvent("download");
  await admin
    .getByRole("button", { name: "Tải CV · CV giảng viên.pdf", exact: true })
    .click();
  expect((await downloadPromise).suggestedFilename()).toBe("CV giảng viên.pdf");
  await expect(
    admin.getByRole("button", { name: "Duyệt hồ sơ", exact: true }),
  ).toBeDisabled();
  await admin
    .getByLabel("Căn cứ giao đề từ CV")
    .fill("Đã đối chiếu JLPT N2 và bốn năm kinh nghiệm trong CV của ứng viên.");
  await admin
    .getByLabel("Tôi đã đọc CV và đối chiếu căn cứ để chọn đề này.")
    .check();
  await admin
    .getByRole("button", { name: "Giao bài kiểm tra", exact: true })
    .click();
  await expect(admin.getByText("Đã giao đề.", { exact: false })).toBeVisible();
  await page.reload();
  await page
    .getByRole("button", { name: "Bắt đầu bài kiểm tra", exact: true })
    .click();
  await expect(
    page.getByRole("heading", { name: "Tiếng Nhật · N2", exact: true }),
  ).toBeVisible();
  const exam = (
    await (await request.get(`/api/admin/recruitment/${application.id}`)).json()
  ).assessments[0];
  for (const [i, q] of exam.questions.entries())
    await page
      .locator("fieldset.teacher-question")
      .nth(i)
      .getByRole("radio")
      .nth(q.answer)
      .check();
  const writing =
    "授業の目的を明確にし、例文と練習を通して学習者の理解を確認します。間違いについては理由を説明し、具体的なフィードバックを提供します。".repeat(
      5,
    );
  await page.getByLabel("Bài tự luận 1 (80–6.000 ký tự)").fill(writing);
  await page.getByLabel("Bài tự luận 2 (80–6.000 ký tự)").fill(writing);
  await expect(
    page.getByRole("status").filter({ hasText: "Đã lưu nháp" }),
  ).toBeVisible();
  await page.reload();
  await expect(page.getByLabel("Bài tự luận 1 (80–6.000 ký tự)")).toHaveValue(
    writing,
  );
  await expect(
    page
      .locator("fieldset.teacher-question")
      .first()
      .getByRole("radio")
      .nth(exam.questions[0].answer),
  ).toBeChecked();
  expect(
    (
      await new AxeBuilder({ page })
        .withTags(["wcag2a", "wcag2aa", "wcag21aa"])
        .analyze()
    ).violations,
  ).toEqual([]);
  await page
    .getByRole("button", { name: "Nộp bài kiểm tra giáo viên", exact: true })
    .click();
  await expect(
    page.getByText("Đã nộp · Trắc nghiệm:", { exact: false }),
  ).toBeVisible();
  await admin
    .getByRole("button", { name: "Cập nhật hồ sơ này", exact: true })
    .click();
  await expect(
    admin.getByRole("button", { name: "Duyệt hồ sơ", exact: true }),
  ).toBeEnabled();
  await admin.getByLabel("Diễn đạt ngôn ngữ (0–20)").fill("17");
  await admin.getByLabel("Thiết kế bài dạy (0–30)").fill("25");
  await admin.getByLabel("Phản hồi học viên (0–20)").fill("16");
  await admin
    .getByLabel("Phản hồi cho ứng viên", { exact: true })
    .fill("Bài dạy có cấu trúc rõ ràng. Hồ sơ được duyệt.");
  await admin
    .getByLabel("Ghi chú nội bộ (chỉ QTV)")
    .fill("Ghi chú riêng của QTV không công khai.");
  await admin
    .getByLabel(
      "Tôi đã đối chiếu CV, bằng cấp và bài làm hiện có để đưa ra đánh giá.",
    )
    .check();
  await admin.getByRole("button", { name: "Duyệt hồ sơ", exact: true }).click();
  await expect(
    admin.getByRole("heading", { name: "Quyết định · Đã duyệt", exact: true }),
  ).toBeVisible();
  await page.reload();
  await expect(
    page.getByText("Tổng điểm: 88/100", { exact: true }),
  ).toBeVisible();
  await expect(
    page.getByText("Ghi chú riêng của QTV", { exact: false }),
  ).toHaveCount(0);
  for (const width of [320, 1440]) {
    await page.setViewportSize({ width, height: 1000 });
    await page.evaluate(() => {
      document.activeElement?.blur();
      window.scrollTo({ top: 0, left: 0, behavior: "instant" });
    });
    expect(
      await page.evaluate(
        () => document.documentElement.scrollWidth <= innerWidth + 1,
      ),
    ).toBe(true);
    await page.screenshot({
      path: `test-results/recruitment-${width}.png`,
      fullPage: true,
    });
  }
  expect(
    (
      await new AxeBuilder({ page })
        .withTags(["wcag2a", "wcag2aa", "wcag21aa"])
        .analyze()
    ).violations,
  ).toEqual([]);
  expect(errors).toEqual([]);
  await adminContext.close();
});
