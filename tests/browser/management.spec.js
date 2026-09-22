import { test, expect } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";
async function login(
  page,
  email = "admin@vinhenglish.vn",
  password = "Admin@123456",
) {
  await page.goto("/dang-nhap");
  await page.getByLabel("Email", { exact: true }).fill(email);
  await page.getByLabel("Mật khẩu", { exact: true }).fill(password);
  await page.getByRole("button", { name: "Đăng nhập", exact: true }).click();
  await expect(page).toHaveURL(/admin|hoc-vien/);
}
test("guest intake, approval, document upload and password change work together", async ({
  page,
}) => {
  const email = `intake-${Date.now()}@example.com`,
    errors = [];
  page.on("pageerror", (e) => errors.push(e.message));
  const response = await page.request.post("/api/enrollments", {
    data: {
      classId: 2,
      name: "Khách tiếp nhận E2E",
      email,
      phone: "0901234567",
    },
  });
  expect(response.status()).toBe(201);
  await login(page);
  await page
    .getByRole("button", { name: "Đăng ký & điểm", exact: true })
    .click();
  await page.getByLabel("Tìm đăng ký & điểm").fill(email);
  await page.getByRole("button", { name: "Tiếp nhận", exact: true }).click();
  await page.getByLabel("Mật khẩu ban đầu").fill("IntakeStudent@123");
  await page.getByRole("checkbox").check();
  await page.getByRole("button", { name: "Xác nhận tiếp nhận" }).click();
  await expect(page.getByRole("dialog")).not.toBeVisible();
  await page.getByRole("button", { name: /^Sửa bản ghi/ }).click();
  await page.getByLabel("Trạng thái").selectOption("confirmed");
  await page.getByRole("button", { name: "Lưu thông tin" }).click();
  await expect(page.getByRole("dialog")).not.toBeVisible();
  await page.getByRole("button", { name: "Tài liệu lớp", exact: true }).click();
  await page
    .getByRole("combobox", { name: "Lớp học", exact: true })
    .selectOption("2");
  await page.getByLabel("Tên tài liệu").fill("Bài tập buổi 1");
  await page.getByLabel("Buổi học / chủ đề").fill("Grammar");
  await page.getByLabel("Tệp PDF hoặc DOCX").setInputFiles({
    name: "lesson.pdf",
    mimeType: "application/pdf",
    buffer: Buffer.from(
      "%PDF-1.4\n1 0 obj\n<< /Type /Catalog >>\nendobj\n%%EOF",
    ),
  });
  await page
    .getByRole("button", { name: "Tải lên tài liệu", exact: true })
    .click();
  await expect(
    page.getByRole("cell", { name: "Bài tập buổi 1 Grammar" }),
  ).toBeVisible();
  await page.getByRole("button", { name: "Đăng xuất", exact: true }).click();
  await login(page, email, "IntakeStudent@123");
  await page.getByText("Lịch học hàng tuần", { exact: true }).click();
  await expect(page.locator(".week-grid")).toBeVisible();
  await page.getByRole("button", { name: "Tài liệu", exact: true }).click();
  const pending = page.waitForEvent("download");
  await page.getByRole("button", { name: "Tải tệp", exact: true }).click();
  expect((await pending).suggestedFilename()).toBe("lesson.pdf");
  await page.getByRole("button", { name: "Đổi mật khẩu", exact: true }).click();
  await page.getByLabel("Mật khẩu hiện tại").fill("IntakeStudent@123");
  await page
    .getByLabel("Mật khẩu mới", { exact: true })
    .fill("ChangedStudent@123");
  await page.getByLabel("Nhập lại mật khẩu mới").fill("ChangedStudent@123");
  await page
    .locator("form")
    .getByRole("button", { name: "Đổi mật khẩu", exact: true })
    .click();
  await expect(page).toHaveURL(/changed=1/);
  await login(page, email, "ChangedStudent@123");
  expect(errors).toEqual([]);
});
test("consultation workflow, reporting export and admin layouts", async ({
  page,
}) => {
  const contact = await page.request.post("/api/contact", {
    data: {
      name: "Tư vấn quản lý",
      email: "workflow@example.com",
      phone: "0901234567",
      message: "Tư vấn lớp cuối tuần.",
    },
  });
  expect(contact.status()).toBe(201);
  await login(page);
  await page.getByRole("button", { name: "Tư vấn", exact: true }).click();
  await page.getByLabel("Tìm tư vấn").fill("workflow@example.com");
  await page.getByRole("button", { name: /^Sửa bản ghi/ }).click();
  await page
    .getByRole("dialog")
    .getByLabel("Trạng thái tư vấn")
    .selectOption("contacted");
  await page.getByLabel("Ghi chú tư vấn").fill("Đã hẹn kiểm tra trình độ.");
  await page.getByRole("button", { name: "Lưu thông tin" }).click();
  await expect(page.getByRole("dialog")).not.toBeVisible();
  await page.getByLabel("Lọc trạng thái tư vấn").selectOption("contacted");
  await expect(
    page.getByText("Đã liên hệ · Đã hẹn kiểm tra trình độ."),
  ).toBeVisible();
  await page
    .getByRole("button", { name: "Báo cáo & Excel", exact: true })
    .click();
  await expect(
    page.getByRole("heading", { name: "Sĩ số lớp hiện tại" }),
  ).toBeVisible();
  const pending = page.waitForEvent("download");
  await page.getByRole("button", { name: "Xuất Excel" }).click();
  expect((await pending).suggestedFilename()).toBe("bao-cao-vinh-english.xlsx");
  for (const section of [
    "Báo cáo & Excel",
    "Tài liệu lớp",
    "Tư vấn",
    "Lớp & lịch học",
  ]) {
    await page.getByRole("button", { name: section, exact: true }).click();
    await expect(
      page.getByRole("heading", { name: section, exact: true }),
    ).toBeVisible();
    for (const width of [360, 1440]) {
      await page.setViewportSize({ width, height: 1000 });
      expect(
        await page.evaluate(
          () => document.documentElement.scrollWidth <= innerWidth + 1,
        ),
        section,
      ).toBe(true);
    }
    const result = await new AxeBuilder({ page })
      .withTags(["wcag2a", "wcag2aa", "wcag21aa"])
      .analyze();
    expect(
      result.violations.map((v) => ({
        id: v.id,
        nodes: v.nodes.map((n) => n.target),
      })),
    ).toEqual([]);
  }
  await page.evaluate(() => {
    document.activeElement?.blur();
    window.scrollTo(0, 0);
  });
  await page.screenshot({
    path: "test-results/admin-classes.png",
    fullPage: true,
  });
});
test("structured class editor rejects teacher conflicts", async ({ page }) => {
  await login(page);
  await page
    .getByRole("button", { name: "Lớp & lịch học", exact: true })
    .click();
  await page.getByRole("button", { name: "Thêm mới" }).click();
  await page.getByLabel("Mã lớp").fill("UI-SCHEDULE");
  await page
    .getByRole("combobox", { name: "Khóa học *", exact: true })
    .selectOption("1");
  await page.getByLabel("Giáo viên *").selectOption("1");
  const catalog = await (await page.request.get("/api/catalog")).json(),
    cls = catalog.classes.find((c) => c.id === 1);
  await page.getByLabel("Ngày khai giảng").fill(cls.startDate);
  await page.getByLabel("Ngày kết thúc").fill(cls.endDate);
  await page.getByLabel("Phòng học").fill("UI-ROOM");
  await page.getByRole("button", { name: "Lưu thông tin" }).click();
  await expect(page.getByRole("alert")).toContainText("giáo viên");
  await page.getByLabel("Giờ bắt đầu").fill("06:00");
  await page.getByLabel("Giờ kết thúc").fill("07:00");
  await page.getByRole("button", { name: "Lưu thông tin" }).click();
  await expect(page.getByRole("dialog")).not.toBeVisible();
  await page.getByLabel("Tìm lớp & lịch học").fill("UI-SCHEDULE");
  await expect(
    page.getByRole("cell", { name: "UI-SCHEDULE", exact: true }),
  ).toBeVisible();
});
