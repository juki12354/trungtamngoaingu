import { test, expect } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";

test("Chinese competency result shows skill breakdown and links to an available HSK 3 class", async ({
  page,
  request,
}) => {
  const errors = [];
  page.on("pageerror", (e) => errors.push(e.message));
  expect(
    (
      await request.post("/api/auth/login", {
        data: { email: "admin@vinhenglish.vn", password: "Admin@123456" },
      })
    ).ok(),
  ).toBe(true);
  const bank = (
    await (await request.get("/api/admin/questions")).json()
  ).filter((q) => q.language === "zh" && q.assessment === "competency");
  await page.goto("/kiem-tra?language=zh");
  await expect(page.getByLabel("Ngôn ngữ kiểm tra")).toHaveValue("zh");
  await expect(page.locator(".level-chips")).toContainText("HSK 7-9");
  const [response] = await Promise.all([
    page.waitForResponse(
      (r) =>
        r.url().endsWith("/api/placement/attempts") &&
        r.request().method() === "POST",
    ),
    page.getByRole("button", { name: "Bắt đầu kiểm tra" }).click(),
  ]);
  const attempt = await response.json();
  expect(attempt.questions).toHaveLength(21);
  for (const [index, question] of attempt.questions.entries()) {
    const source = bank.find((q) => q.id === question.id);
    const answer = ["HSK1", "HSK2"].includes(source.levelCode)
      ? source.answer
      : (source.answer + 1) % 4;
    await page.getByRole("radio").nth(answer).check();
    if (index < attempt.questions.length - 1)
      await page.getByRole("button", { name: "Câu tiếp theo" }).click();
  }
  await page.getByRole("button", { name: "Nộp bài & xem kết quả" }).click();
  await expect(
    page.getByText("Gợi ý học: HSK 3", { exact: true }),
  ).toBeVisible();
  await expect(page.locator(".competency-summary")).toContainText("HSK 2");
  for (const skill of ["Từ vựng", "Ngữ pháp", "Đọc hiểu"])
    await expect(page.getByRole("progressbar", { name: skill })).toBeVisible();
  await expect(page.locator(".recommended-class").first()).toContainText(
    "HSK 3",
  );
  for (const width of [360, 1440]) {
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
      path: `test-results/competency-result-${width}.png`,
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
  const link = page.getByRole("link", { name: "Đăng ký lớp này" }).first();
  const classId = new URL(
    await link.getAttribute("href"),
    "http://localhost",
  ).searchParams.get("class");
  await link.click();
  await expect(page).toHaveURL(new RegExp(`class=${classId}`));
  await expect(page.getByLabel("Lớp, ca học và cơ sở *")).toHaveValue(classId);
  await expect(page.locator(".selected-course h3")).toContainText("HSK 3");
  expect(errors).toEqual([]);
});
