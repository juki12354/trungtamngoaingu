import { DatabaseSync } from "node:sqlite";
import { existsSync } from "node:fs";
import { readFile } from "node:fs/promises";
import { connectDatabase, copySQLite, tables } from "../server/database.js";

if (!process.env.DATABASE_URL)
  throw new Error("Đặt DATABASE_URL trong .env trước khi chuyển dữ liệu.");
const sourcePath = process.env.DB_PATH || "data/center.sqlite";
if (!existsSync(sourcePath))
  throw new Error(
    "Không tìm thấy SQLite nguồn. Không tạo database rỗng thay thế.",
  );
const source = new DatabaseSync(sourcePath, { readOnly: true });
source.exec("BEGIN");
const destination = await connectDatabase({
  databaseUrl: process.env.DATABASE_URL,
  initialize: false,
});
try {
  await destination.transaction(async () => {
    await destination.exec(
      await readFile(
        new URL("../server/postgres-schema.sql", import.meta.url),
        "utf8",
      ),
    );
    await copySQLite(source, destination);
    for (const table of tables) {
      const expected = source
        .prepare(`SELECT count(*) n FROM ${table}`)
        .get().n;
      const actual = (
        await destination.prepare(`SELECT count(*) n FROM ${table}`).get()
      ).n;
      if (actual !== expected)
        throw new Error(`Số bản ghi không khớp: ${table}`);
    }
  });
  console.log(
    "Đã chuyển và đối chiếu 14 bảng. SQLite nguồn được giữ nguyên. Khởi động hosting với DATABASE_URL này.",
  );
} finally {
  source.exec("ROLLBACK");
  source.close();
  await destination.close();
}
