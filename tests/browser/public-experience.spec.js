import { test, expect } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";

test("find campus, combine class filters, and register interest in a trial", async ({
  page,
}) => {
  const errors = [];
  page.on("pageerror", (e) => errors.push(e.message));
  await page.goto("/co-so");
  await page.getByLabel("Tỉnh / thành").selectOption("Nghệ An");
  await page.getByLabel("Chọn cơ sở").selectOption("Cơ sở Lê Lợi");
  await expect(page.locator(".campus-card")).toHaveCount(1);
  await page.getByRole("link", { name: "Xem lịch tại cơ sở" }).click();
  await expect(page.getByLabel("Lọc theo cơ sở")).toHaveValue("Cơ sở Lê Lợi");
  await page
    .getByLabel("Lọc theo khóa học")
    .selectOption({ label: "TOEIC 650+" });
  await page
    .getByRole("combobox", { name: "Ca học", exact: true })
    .selectOption("evening");
  await page.getByLabel("Chỉ lớp còn nhận đăng ký").click();
  await expect(page.getByLabel("Chỉ lớp còn nhận đăng ký")).toBeChecked();
  await page.getByLabel("Học phí tối đa").selectOption("3000000");
  await expect(page.getByText("Tìm thấy 0 lớp học")).toBeVisible();
  await page.getByLabel("Học phí tối đa").selectOption("4000000");
  await expect(page.locator("tbody tr")).toHaveCount(1);
  await expect(page.locator("tbody")).toContainText("TOEIC-TOI-01");
  await page.reload();
  await expect(page.locator("tbody tr")).toHaveCount(1);
  await page.getByLabel("Khai giảng từ ngày").fill("2099-01-01");
  await expect(page.getByText("Tìm thấy 0 lớp học")).toBeVisible();
  await page.getByLabel("Khai giảng từ ngày").fill("");
  await page.getByRole("link", { name: "Đăng ký", exact: true }).click();
  await expect(page.getByLabel("Lớp, ca học và cơ sở *")).not.toHaveValue("");
  await page.goto(
    "/hoc-thu?course=7&campus=" + encodeURIComponent("Cơ sở Lê Lợi"),
  );
  await expect(page.getByLabel("Khóa học quan tâm")).toHaveValue("7");
  await page.getByLabel("Họ và tên").fill("Học thử E2E");
  await page.getByLabel("Số điện thoại").fill("0901234567");
  await page.getByLabel("Email", { exact: true }).fill("trial-e2e@example.com");
  await page.getByLabel("Độ tuổi").fill("22");
  await page.getByLabel("Mục tiêu học tập").fill("Luyện TOEIC cho công việc");
  await page.getByRole("button", { name: "Gửi yêu cầu học thử" }).click();
  await expect(page.getByText("Đã nhận yêu cầu học thử!")).toBeVisible();
  await page.goto("/dang-nhap");
  await page.getByLabel("Email", { exact: true }).fill("admin@vinhenglish.vn");
  await page.getByLabel("Mật khẩu", { exact: true }).fill("Admin@123456");
  await page.getByRole("button", { name: "Đăng nhập", exact: true }).click();
  await page.getByRole("button", { name: "Tư vấn", exact: true }).click();
  const row = page
    .getByRole("row")
    .filter({ hasText: "trial-e2e@example.com" });
  await expect(row).toContainText("Đăng ký học thử");
  await expect(row).toContainText("22 tuổi");
  await expect(row).toContainText("TOEIC 650+");
  await expect(row).toContainText("Cơ sở Lê Lợi");
  expect(errors).toEqual([]);
});

test("roadmaps and discovery pages work on mobile and desktop with accessible controls", async ({
  page,
}) => {
  const errors = [];
  page.on("pageerror", (e) => errors.push(e.message));
  await page.goto("/lo-trinh");
  await page.getByRole("button", { name: "Tiếng Anh cho công việc" }).click();
  await page.getByRole("link", { name: "TOEIC 650+", exact: true }).click();
  await expect(page.getByRole("heading", { level: 1 })).toHaveText(
    "TOEIC 650+",
  );
  await page.goto("/tin-tuc");
  await page.getByLabel("Tìm bài viết").fill("zz-no-article");
  await expect(page.getByText("0 bài viết", { exact: true })).toBeVisible();
  await page.getByLabel("Tìm bài viết").fill("IELTS");
  await expect(page.locator(".news-card")).toHaveCount(1);
  for (const route of ["/co-so", "/lo-trinh", "/hoc-thu", "/lich-khai-giang"]) {
    await page.goto(route);
    await expect(page.getByRole("heading", { level: 1 })).toBeVisible();
    for (const width of [320, 768, 1440]) {
      await page.setViewportSize({ width, height: 1000 });
      expect(
        await page.evaluate(
          () => document.documentElement.scrollWidth <= innerWidth + 1,
        ),
      ).toBe(true);
    }
    expect(
      (
        await new AxeBuilder({ page })
          .withTags(["wcag2a", "wcag2aa", "wcag21aa"])
          .analyze()
      ).violations,
    ).toEqual([]);
    await page.screenshot({
      path: `test-results/discovery-${route.slice(1)}.png`,
      fullPage: true,
    });
  }
  expect(errors).toEqual([]);
});
