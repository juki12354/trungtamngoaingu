import { test, expect } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";

test("teacher profiles display achievements and admin edits appear publicly", async ({
  page,
}) => {
  const errors = [];
  page.on("pageerror", (e) => errors.push(e.message));
  await page.goto("/giao-vien");
  await expect(page.locator("article.teacher-card")).toHaveCount(9);
  await expect(
    page.getByText("9 hồ sơ giáo viên minh họa.", { exact: false }),
  ).toBeVisible();
  await page
    .getByRole("heading", { name: "Lê Hoàng Nam", exact: true })
    .getByRole("link")
    .click();
  await expect(
    page.getByRole("heading", { name: "Thành tích & chuyên môn nổi bật" }),
  ).toBeVisible();
  await expect(page.locator(".teacher-achievements li")).toHaveCount(3);
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
      path: `test-results/teacher-profile-${width}.png`,
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
  await page.goto("/dang-nhap");
  await page.getByLabel("Email", { exact: true }).fill("admin@vinhenglish.vn");
  await page.getByLabel("Mật khẩu", { exact: true }).fill("Admin@123456");
  await page.getByRole("button", { name: "Đăng nhập", exact: true }).click();
  await page.getByRole("button", { name: "Giáo viên", exact: true }).click();
  await page.getByLabel("Tìm giáo viên").fill("Lê Hoàng Nam");
  await page.getByRole("button", { name: /^Sửa bản ghi/ }).click();
  await page.getByLabel("Quốc tịch", { exact: true }).fill("Việt Nam");
  await page
    .getByLabel("Thành tích nổi bật")
    .fill(
      "Thành tích cập nhật bằng giao diện\nChuyên đề IELTS Writing nâng cao",
    );
  await page.getByRole("button", { name: "Lưu thông tin" }).click();
  await expect(page.getByRole("dialog")).not.toBeVisible();
  await page.goto("/giao-vien/4");
  await expect(
    page.getByText("Quốc tịch: Việt Nam", { exact: true }),
  ).toBeVisible();
  await expect(
    page.getByText("Thành tích cập nhật bằng giao diện", { exact: true }),
  ).toBeVisible();
  await expect(
    page.getByText("Chuyên đề IELTS Writing nâng cao", { exact: true }),
  ).toBeVisible();
  expect(errors).toEqual([]);
});
