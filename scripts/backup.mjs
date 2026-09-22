import { DatabaseSync } from "node:sqlite";
import { mkdirSync, existsSync } from "node:fs";
import { resolve, dirname } from "node:path";
const source = resolve(process.env.DB_PATH || "data/center.sqlite");
if (!existsSync(source)) throw new Error("Chưa có cơ sở dữ liệu để sao lưu.");
const target = resolve(
  dirname(source),
  "backups",
  `center-${new Date().toISOString().replaceAll(":", "-")}.sqlite`,
);
mkdirSync(dirname(target), { recursive: true });
const db = new DatabaseSync(source);
db.prepare("VACUUM INTO ?").run(target);
db.close();
console.log(`Đã sao lưu: ${target}`);
