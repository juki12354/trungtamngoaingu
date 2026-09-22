import { resolve } from "node:path";
import { pathToFileURL } from "node:url";
import { openDatabase } from "../server/db.js";
import { teachers } from "../server/seed.js";
import { schemas } from "../server/schemas.js";

export function addTeacherProfiles(db) {
  const result = { added: 0, enriched: 0 };
  db.exec("BEGIN IMMEDIATE");
  try {
    for (const profile of teachers) {
      const existing = db
        .prepare("SELECT * FROM teachers WHERE name=?")
        .get(profile.name);
      if (existing) {
        if (!existing.achievements.trim()) {
          db.prepare("UPDATE teachers SET achievements=? WHERE id=?").run(
            profile.achievements,
            existing.id,
          );
          result.enriched++;
        }
        continue;
      }
      const data = schemas.teachers.parse(profile),
        columns = Object.keys(data);
      db.prepare(
        `INSERT INTO teachers(${columns.join(",")}) VALUES(${columns.map(() => "?").join(",")})`,
      ).run(...columns.map((key) => data[key]));
      result.added++;
    }
    db.exec("COMMIT");
    return result;
  } catch (error) {
    db.exec("ROLLBACK");
    throw error;
  }
}
if (
  process.argv[1] &&
  import.meta.url === pathToFileURL(resolve(process.argv[1])).href
) {
  const db = openDatabase(process.env.DB_PATH || "data/center.sqlite", false);
  try {
    const result = addTeacherProfiles(db);
    console.log(
      `Đã thêm ${result.added} giáo viên, bổ sung thành tích cho ${result.enriched} hồ sơ.`,
    );
  } finally {
    db.close();
  }
}
