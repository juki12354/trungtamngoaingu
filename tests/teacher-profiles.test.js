import { test } from "node:test";
import assert from "node:assert/strict";
import { openDatabase } from "../server/db.js";
import { addTeacherProfiles } from "../scripts/add-teacher-profiles.mjs";

test("teacher profiles enrich legacy data without overwriting edits or class assignments", () => {
  const db = openDatabase(":memory:", true);
  try {
    db.exec(
      "DELETE FROM teachers WHERE id>3; UPDATE teachers SET achievements='' WHERE id<=3; UPDATE teachers SET achievements='Thành tích do Admin cập nhật',description='Giới thiệu đã sửa' WHERE id=1;",
    );
    const classes = db.prepare("SELECT * FROM classes").all();
    assert.deepEqual(addTeacherProfiles(db), { added: 6, enriched: 2 });
    assert.equal(db.prepare("SELECT count(*) n FROM teachers").get().n, 9);
    assert.equal(
      db.prepare("SELECT achievements FROM teachers WHERE id=1").get()
        .achievements,
      "Thành tích do Admin cập nhật",
    );
    assert.equal(
      db.prepare("SELECT description FROM teachers WHERE id=1").get()
        .description,
      "Giới thiệu đã sửa",
    );
    assert.deepEqual(addTeacherProfiles(db), { added: 0, enriched: 0 });
    assert.deepEqual(db.prepare("SELECT * FROM classes").all(), classes);
  } finally {
    db.close();
  }
});
