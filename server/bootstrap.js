import { z } from "zod";
import { hashPassword } from "./db.js";

export async function bootstrapAdmin(db, env = process.env) {
  return db.transaction(async () => {
    // Restarting must never reset an existing account or its changed password.
    if (
      await db.prepare("SELECT 1 FROM users WHERE role='admin' LIMIT 1").get()
    )
      return false;
    const parsed = z
      .object({
        ADMIN_EMAIL: z.email().transform((s) => s.toLowerCase()),
        ADMIN_PASSWORD: z.string().min(14).max(128),
      })
      .safeParse(env);
    if (!parsed.success)
      throw new Error(
        "Chưa có Admin. Đặt ADMIN_EMAIL hợp lệ và ADMIN_PASSWORD từ 14 đến 128 ký tự trong Environment của hosting.",
      );
    if (
      await db
        .prepare("SELECT 1 FROM users WHERE email=?")
        .get(parsed.data.ADMIN_EMAIL)
    )
      throw new Error(
        "Email Admin đã được sử dụng. Chọn email riêng cho Admin.",
      );
    await db
      .prepare(
        "INSERT INTO users(name,email,passwordHash,role) VALUES (?,?,?,'admin')",
      )
      .run(
        "Quản trị viên",
        parsed.data.ADMIN_EMAIL,
        hashPassword(parsed.data.ADMIN_PASSWORD),
      );
    return true;
  });
}
