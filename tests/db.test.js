import { test } from "node:test";
import assert from "node:assert/strict";
import { mkdtempSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { openDatabase, verifyPassword } from "../server/db.js";
import { DatabaseSync } from "node:sqlite";
import { migrate } from "../server/migrations.js";

test("legacy migration preserves registrations and is safe to run again", () => {
  const db = new DatabaseSync(":memory:");
  try {
    db.exec(
      `CREATE TABLE teachers(id INTEGER PRIMARY KEY,name TEXT); CREATE TABLE users(id INTEGER PRIMARY KEY); CREATE TABLE classes(id INTEGER PRIMARY KEY,schedule TEXT); CREATE TABLE enrollments(id INTEGER PRIMARY KEY,userId INTEGER,classId INTEGER,email TEXT,status TEXT); CREATE TABLE contacts(id INTEGER PRIMARY KEY,message TEXT); CREATE TABLE placement_results(id INTEGER PRIMARY KEY,score INTEGER); CREATE TABLE metadata(key TEXT PRIMARY KEY,value TEXT); INSERT INTO users VALUES (1); INSERT INTO classes VALUES(1,'Thứ 2, Thứ 4 · 18:30 – 20:30'); INSERT INTO enrollments VALUES(1,1,1,'old@example.com','pending'); INSERT INTO contacts VALUES(1,'Lời nhắn cần giữ'); INSERT INTO placement_results VALUES(1,10);`,
    );
    migrate(db);
    assert.equal(
      db.prepare("SELECT email FROM enrollments").get().email,
      "old@example.com",
    );
    assert.equal(
      db.prepare("SELECT message FROM contacts").get().message,
      "Lời nhắn cần giữ",
    );
    assert.deepEqual(
      JSON.parse(db.prepare("SELECT weekdays FROM classes").get().weekdays),
      [1, 3],
    );
    db.prepare(
      "UPDATE classes SET room='P101',weekdays='[2,4]' WHERE id=1",
    ).run();
    migrate(db);
    assert.equal(db.prepare("SELECT room FROM classes").get().room, "P101");
    assert.equal(
      db.prepare("SELECT weekdays FROM classes").get().weekdays,
      "[2,4]",
    );
    assert.throws(
      () =>
        db
          .prepare(
            "INSERT INTO enrollments VALUES(2,1,1,'changed@example.com','pending',NULL,NULL)",
          )
          .run(),
      /UNIQUE/,
    );
  } finally {
    db.close();
  }
});

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
