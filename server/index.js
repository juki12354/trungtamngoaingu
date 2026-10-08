import { createApp } from "./app.js";
import { bootstrapAdmin } from "./bootstrap.js";
if (process.env.RENDER && !process.env.DATABASE_URL) {
  throw new Error(
    "Render cần DATABASE_URL PostgreSQL. Không lưu SQLite trên ổ đĩa tạm.",
  );
}
const port = Number(process.env.PORT || 3001);
const app = await createApp({
  databaseUrl: process.env.DATABASE_URL,
  ...(process.env.DB_PATH
    ? {
        dbPath: process.env.DB_PATH,
      }
    : {}),
});
if (process.env.NODE_ENV === "production") {
  try {
    if (await bootstrapAdmin(app.locals.db))
      console.log(
        "Đã tạo Admin. Hãy xóa ADMIN_PASSWORD khỏi Environment sau khi đăng nhập thành công.",
      );
  } catch (error) {
    await app.locals.db.close();
    throw error;
  }
}
const host = process.env.HOST || "127.0.0.1";
const server = app.listen(port, host, () =>
  console.log(`Vinh English API: http://${host}:${port}`),
);
function stop() {
  server.close(async () => {
    await app.locals.db.close();
    process.exit();
  });
}
process.on("SIGINT", stop);
process.on("SIGTERM", stop);
