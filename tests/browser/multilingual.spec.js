import { test, expect } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";
import { languages } from "../../shared/languages.js";

test("language filters cover all languages, teachers, schedules and registration", async ({
  page,
}) => {
  const errors = [];
  page.on("pageerror", (e) => errors.push(e.message));
  await page.goto("/khoa-hoc");
  for (const language of languages) {
    await page
      .getByLabel("Ngôn ngữ", { exact: true })
      .selectOption(language.code);
    await expect(page.locator(".course-card")).toHaveCount(
      language.code === "en" ? 7 : 2,
    );
    await expect(page).toHaveURL(new RegExp(`language=${language.code}`));
  }
  await page.getByLabel("Ngôn ngữ", { exact: true }).selectOption("zh");
  for (const width of [360, 1440]) {
    await page.setViewportSize({ width, height: 1000 });
    expect(
      await page.evaluate(
        () => document.documentElement.scrollWidth <= innerWidth + 1,
      ),
    ).toBe(true);
    await page.screenshot({
      path: `test-results/multilingual-courses-${width}.png`,
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
  await page.goto("/giao-vien?language=ja");
  await expect(page.locator(".teacher-card")).toHaveCount(1);
  await expect(
    page.getByRole("heading", { name: "Phạm Nhật Minh" }),
  ).toBeVisible();
  await page.goto("/lich-khai-giang?language=ko");
  await expect(page.getByRole("status")).toHaveText("Tìm thấy 6 lớp học");
  await page
    .getByRole("combobox", { name: "Ca học", exact: true })
    .selectOption("evening");
  await expect(page.getByRole("status")).toHaveText("Tìm thấy 2 lớp học");
  await page.goto("/dang-ky");
  await page.getByLabel("Ngôn ngữ muốn học").selectOption("de");
  await expect(page.getByLabel("Khóa học *")).toContainText(
    "Tiếng Đức nhập môn",
  );
  await page.getByLabel("Lớp, ca học và cơ sở *").selectOption({ index: 1 });
  await page
    .getByLabel("Họ và tên *", { exact: true })
    .fill("Học viên tiếng Đức");
  await page.getByLabel("Số điện thoại *", { exact: true }).fill("0901234567");
  await page
    .getByLabel("Email *", { exact: true })
    .fill(`german-${Date.now()}@example.com`);
  await page.getByRole("checkbox").check();
  await page.getByRole("button", { name: "Gửi đăng ký khóa học" }).click();
  await expect(
    page.getByRole("heading", { name: "Đăng ký thành công!" }),
  ).toBeVisible();
  expect(errors).toEqual([]);
});

test("Korean placement and multilingual roadmaps suggest the selected language", async ({
  page,
}) => {
  await page.goto("/kiem-tra");
  await page.getByLabel("Ngôn ngữ kiểm tra").selectOption("ko");
  await expect(page.locator(".test-facts")).toContainText(
    "10Câu hỏi trắc nghiệm",
  );
  await page.getByRole("button", { name: "Bắt đầu kiểm tra" }).click();
  for (let n = 0; n < 10; n++) {
    await expect(page.locator("legend")).toContainText("Tiếng Hàn");
    await page.getByRole("radio").first().check();
    if (n < 9)
      await page.getByRole("button", { name: "Câu tiếp theo" }).click();
  }
  await page.getByRole("button", { name: "Nộp bài & xem kết quả" }).click();
  await expect(page.locator(".recommendation h3")).toContainText("Tiếng Hàn");
  await expect(page.locator(".test-result")).toContainText(
    "không quy đổi sang CEFR",
  );
  await page.goto("/lo-trinh");
  await page.getByLabel("Ngôn ngữ lộ trình").selectOption("it");
  await expect(page.locator(".roadmap-detail")).toContainText(
    "Tiếng Ý nhập môn",
  );
  await expect(page.locator(".roadmap-detail")).not.toContainText("IELTS");
});

test("admin manages course languages and multilingual teacher profiles", async ({
  page,
}) => {
  await page.goto("/dang-nhap");
  await page.getByLabel("Email", { exact: true }).fill("admin@vinhenglish.vn");
  await page.getByLabel("Mật khẩu", { exact: true }).fill("Admin@123456");
  await page.getByRole("button", { name: "Đăng nhập", exact: true }).click();
  await expect(page).toHaveURL(/admin/);
  await page.getByRole("button", { name: "Khóa học", exact: true }).click();
  await page.getByLabel("Ngôn ngữ quản lý").selectOption("fr");
  await expect(page.locator(".admin-table tbody tr")).toHaveCount(2);
  await page
    .getByRole("button", { name: /Sửa bản ghi/ })
    .first()
    .click();
  await expect(page.getByLabel("Ngôn ngữ *", { exact: true })).toHaveValue(
    "fr",
  );
  await page.getByRole("button", { name: "Đóng", exact: true }).click();
  await page.getByRole("button", { name: "Giáo viên", exact: true }).click();
  await page.getByLabel("Ngôn ngữ quản lý").selectOption("zh");
  await page
    .getByRole("button", { name: /Sửa bản ghi/ })
    .first()
    .click();
  await expect(
    page.getByRole("checkbox", { name: "Tiếng Trung", exact: true }),
  ).toBeChecked();
  await page
    .getByRole("button", { name: "Lưu thông tin", exact: true })
    .click();
  await expect(page.getByRole("dialog")).not.toBeVisible();
  await expect(page.locator(".admin-table")).toContainText("Tiếng Trung");
});
