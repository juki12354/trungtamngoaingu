import { DatabaseSync } from "node:sqlite";
import { mkdirSync, existsSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { execFileSync } from "node:child_process";
if (process.env.DATABASE_URL) {
  const url = new URL(process.env.DATABASE_URL);
  const target = resolve(
    "data/backups",
    `postgres-${new Date().toISOString().replaceAll(":", "-")}.dump`,
  );
  mkdirSync(dirname(target), { recursive: true });
  execFileSync(
    process.env.PG_DUMP_PATH || "pg_dump",
    ["--format=custom", "--no-owner", "--no-acl", "--file", target],
    {
      env: {
        ...process.env,
        PGHOST: url.hostname,
        PGPORT: url.port || "5432",
        PGUSER: decodeURIComponent(url.username),
        PGPASSWORD: decodeURIComponent(url.password),
        PGDATABASE: decodeURIComponent(url.pathname.slice(1)),
        PGSSLMODE: url.searchParams.get("sslmode") || "prefer",
      },
      stdio: "inherit",
      windowsHide: true,
    },
  );
  console.log(`Đã sao lưu PostgreSQL: ${target}`);
  process.exit(0);
}
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
