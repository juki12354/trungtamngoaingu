import { openDatabase, hashPassword } from "../server/db.js";
import { z } from "zod";
const email = z
  .email()
  .transform((v) => v.toLowerCase())
  .parse(process.env.ADMIN_EMAIL);
const password = z.string().min(14).max(128).parse(process.env.ADMIN_PASSWORD);
if (["Admin@123456", "Student@123456"].includes(password))
  throw new Error("Hãy chọn mật khẩu riêng.");
const db = openDatabase(process.env.DB_PATH || "data/center.sqlite", false);
try {
  const existing = db.prepare("SELECT id FROM users WHERE email=?").get(email);
  if (existing)
    throw new Error(
      "Email đã tồn tại. Dùng chức năng đổi mật khẩu hoặc chọn email Admin mới.",
    );
  db.prepare(
    "INSERT INTO users(name,email,passwordHash,role) VALUES (?,?,?,'admin')",
  ).run("Quản trị viên", email, hashPassword(password));
  console.log(
    "Đã tạo Admin. Xóa ADMIN_PASSWORD khỏi cấu hình sau khi thiết lập.",
  );
} finally {
  db.close();
}
