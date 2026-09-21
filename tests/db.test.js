import { test } from "node:test";
import assert from "node:assert/strict";
import { mkdtempSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { openDatabase, verifyPassword } from "../server/db.js";

test("file database survives reopening without resetting edited content or users", () => {
  const path = join(
    mkdtempSync(join(tmpdir(), "vec-persistence-")),
    "center.sqlite",
  );
  let db = openDatabase(path, true);
  const admin = db.prepare("SELECT * FROM users WHERE role='admin'").get();
  assert.notEqual(admin.passwordHash, "Admin@123456");
  assert.ok(verifyPassword("Admin@123456", admin.passwordHash));
  db.prepare("UPDATE courses SET tuition=? WHERE id=1").run(4123000);
  db.close();
  db = openDatabase(path, true);
  assert.equal(
    db.prepare("SELECT tuition FROM courses WHERE id=1").get().tuition,
    4123000,
  );
  assert.equal(db.prepare("SELECT COUNT(*) AS n FROM users").get().n, 2);
  db.close();
});
