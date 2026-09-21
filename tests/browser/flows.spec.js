import { test, expect } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";
const adminEmail = "admin@vinhenglish.vn";
async function login(page, email, password) {
  await page.goto("/dang-nhap");
  await page.getByLabel("Email", { exact: true }).fill(email);
  await page.getByLabel("Mật khẩu", { exact: true }).fill(password);
  await page.getByRole("button", { name: "Đăng nhập", exact: true }).click();
}
test("course search and registration persist through admin confirmation into student portal", async ({
  page,
}) => {
  const errors = [];
  page.on("pageerror", (e) => errors.push(e.message));
  const email = `learner-${Date.now()}@example.com`;
  await page.goto("/dang-nhap");
  await page.getByRole("button", { name: "Đăng ký ngay" }).click();
  await page.getByLabel("Họ và tên", { exact: true }).fill("Học viên E2E");
  await page.getByLabel("Số điện thoại", { exact: true }).fill("0981234567");
  await page.getByLabel("Email", { exact: true }).fill(email);
  await page.getByLabel("Mật khẩu", { exact: true }).fill("TestStudent@1234");
  await page
    .getByRole("button", { name: "Tạo tài khoản", exact: true })
    .click();
  await expect(page).toHaveURL(/hoc-vien/);
  await page.goto("/khoa-hoc");
  await page
    .getByRole("searchbox", { name: "Tìm khóa học" })
    .count()
    .then(async (n) => {
      if (n)
        await page
          .getByRole("searchbox", { name: "Tìm khóa học" })
          .fill("IELTS");
      else
        await page.getByRole("textbox", { name: "Tìm khóa học" }).fill("IELTS");
    });
  await expect(page.locator(".course-card")).toHaveCount(1);
  await page
    .getByRole("heading", { name: "IELTS Foundation" })
    .getByRole("link")
    .click();
  await page
    .getByRole("link", { name: "Đăng ký khóa học", exact: true })
    .click();
  await page.getByLabel("Lớp, ca học và cơ sở *").selectOption("1");
  await page.getByRole("checkbox").check();
  await page.getByRole("button", { name: "Gửi đăng ký khóa học" }).click();
  await expect(
    page.getByRole("heading", { name: "Đăng ký thành công!" }),
  ).toBeVisible();
  await page.getByRole("link", { name: "Xem đăng ký của tôi" }).click();
  await expect(page.getByText("Chờ xác nhận", { exact: true })).toBeVisible();
  await page.getByRole("button", { name: "Đăng xuất", exact: true }).click();
  await login(page, adminEmail, "Admin@123456");
  await page
    .getByRole("button", { name: "Đăng ký & điểm", exact: true })
    .click();
  await page.getByRole("textbox", { name: "Tìm đăng ký & điểm" }).fill(email);
  await page.getByRole("button", { name: /^Sửa bản ghi/ }).click();
  await page.getByLabel("Trạng thái").selectOption("confirmed");
  await page.getByLabel("Listening (0–10)").fill("8");
  await page.getByRole("button", { name: "Lưu thông tin" }).click();
  await expect(page.getByRole("dialog")).not.toBeVisible();
  await page.getByRole("button", { name: "Đăng xuất", exact: true }).click();
  await login(page, email, "TestStudent@1234");
  await expect(page.getByText("Đã xác nhận", { exact: true })).toBeVisible();
  await page.getByRole("button", { name: "Kết quả học tập" }).click();
  await expect(
    page.getByRole("cell", { name: "8", exact: true }),
  ).toBeVisible();
  await page.getByRole("button", { name: "Tài liệu", exact: true }).click();
  const download = page.waitForEvent("download");
  await page.getByRole("button", { name: "Tải tài liệu" }).click();
  expect((await download).suggestedFilename()).toBe("tai-lieu-1.txt");
  expect(errors).toEqual([]);
});
test("placement navigation, complete scoring, and course recommendation", async ({
  page,
}) => {
  await page.goto("/kiem-tra");
  await page.getByRole("button", { name: "Bắt đầu kiểm tra" }).click();
  for (let i = 0; i < 15; i++) {
    await page.getByRole("radio").nth(1).check();
    if (i < 14)
      await page.getByRole("button", { name: "Câu tiếp theo" }).click();
  }
  await page.getByRole("button", { name: "Nộp bài & xem kết quả" }).click();
  await expect(page.getByText("Thêm một bước hiểu chính mình!")).toBeVisible();
  await expect(
    page.getByRole("link", { name: "Xem khóa học phù hợp" }),
  ).toBeVisible();
});
test("admin creates, updates, and removes a course", async ({ page }) => {
  await login(page, adminEmail, "Admin@123456");
  await page.getByRole("button", { name: "Khóa học", exact: true }).click();
  await page.getByRole("button", { name: "Thêm mới" }).click();
  await page.getByLabel("Tên khóa học *").fill("Khóa học kiểm thử trình duyệt");
  await page
    .getByLabel("Giới thiệu *")
    .fill("Khóa học kiểm thử chức năng quản trị.");
  await page.getByRole("button", { name: "Lưu thông tin" }).click();
  await expect(page.getByRole("dialog")).not.toBeVisible();
  await page
    .getByRole("textbox", { name: "Tìm khóa học" })
    .fill("Khóa học kiểm thử trình duyệt");
  await page.getByRole("button", { name: /^Sửa bản ghi/ }).click();
  await page.getByLabel("Tên khóa học *").fill("Khóa học đã chỉnh sửa");
  await page.getByRole("button", { name: "Lưu thông tin" }).click();
  await expect(page.getByRole("dialog")).not.toBeVisible();
  await page
    .getByRole("textbox", { name: "Tìm khóa học" })
    .fill("Khóa học đã chỉnh sửa");
  await expect(
    page.getByRole("cell", { name: "Khóa học đã chỉnh sửa" }),
  ).toBeVisible();
  page.on("dialog", (d) => d.accept());
  await page.getByRole("button", { name: /^Xóa bản ghi/ }).click();
  await expect(page.getByText("Không có bản ghi phù hợp.")).toBeVisible();
});
test("contact form is delivered to admin inbox", async ({ page }) => {
  await page.goto("/lien-he");
  await page.getByLabel("Họ và tên", { exact: true }).fill("Người cần tư vấn");
  await page
    .getByLabel("Email", { exact: true })
    .fill("contact-e2e@example.com");
  await page.getByLabel("Số điện thoại", { exact: true }).fill("0901234567");
  await page
    .getByLabel("Bạn cần tư vấn điều gì?")
    .fill("Cần tư vấn lớp IELTS buổi tối.");
  await page.getByRole("button", { name: "Gửi lời nhắn" }).click();
  await expect(
    page.getByRole("heading", { name: "Đã nhận lời nhắn của bạn!" }),
  ).toBeVisible();
  await login(page, adminEmail, "Admin@123456");
  await expect(page.getByText("Cần tư vấn lớp IELTS buổi tối.")).toBeVisible();
});
test("pages fit mobile, tablet and desktop without runtime errors", async ({
  page,
}) => {
  const errors = [];
  page.on("pageerror", (e) => errors.push(e.message));
  for (const width of [320, 768, 1024, 1440]) {
    await page.setViewportSize({ width, height: 1000 });
    for (const path of [
      "/",
      "/khoa-hoc",
      "/khoa-hoc/1",
      "/giao-vien",
      "/lich-khai-giang",
      "/dang-ky",
      "/kiem-tra",
      "/dang-nhap",
      "/tin-tuc",
      "/lien-he",
      "/gioi-thieu",
    ]) {
      await page.goto(path);
      await expect(page.locator("h1")).toBeVisible();
      expect(
        await page.evaluate(
          () => document.documentElement.scrollWidth <= window.innerWidth + 1,
        ),
        `${width}px ${path} overflow`,
      ).toBe(true);
    }
    await page.goto("/");
    await expect(page.locator(".hero-photo img")).toBeVisible();
    await page.screenshot({
      path: `test-results/home-${width}.png`,
      fullPage: true,
    });
  }
  expect(errors).toEqual([]);
});
test("home, registration, quiz and admin meet automated accessibility checks", async ({
  page,
}) => {
  for (const path of ["/", "/dang-ky", "/kiem-tra"]) {
    await page.goto(path);
    await expect(page.locator("h1")).toBeVisible();
    const result = await new AxeBuilder({ page })
      .withTags(["wcag2a", "wcag2aa", "wcag21aa"])
      .analyze();
    expect(
      result.violations.map((v) => ({
        id: v.id,
        nodes: v.nodes.map((n) => n.target),
      })),
      path,
    ).toEqual([]);
  }
  await login(page, adminEmail, "Admin@123456");
  await expect(
    page.getByRole("heading", { name: "Tổng quan", exact: true }),
  ).toBeVisible();
  const result = await new AxeBuilder({ page })
    .withTags(["wcag2a", "wcag2aa", "wcag21aa"])
    .analyze();
  expect(
    result.violations.map((v) => ({
      id: v.id,
      nodes: v.nodes.map((n) => n.target),
    })),
  ).toEqual([]);
});
