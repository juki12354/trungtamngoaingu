import { test } from "node:test";
import assert from "node:assert/strict";
import { openDatabase } from "../server/db.js";
import { assertSchedule } from "../server/domain.js";
import { addClassOptions } from "../scripts/add-class-options.mjs";

test("additional classes offer four schedules per course without overlaps or duplicate reruns", () => {
  const db = openDatabase(":memory:", true);
  try {
    const before = db.prepare("SELECT * FROM enrollments").all();
    const first = addClassOptions(db);
    assert.equal(first.added.length, 18);
    const rows = db.prepare("SELECT * FROM classes").all();
    for (let courseId = 1; courseId <= 6; courseId++)
      assert.equal(rows.filter((c) => c.courseId === courseId).length, 4);
    for (const row of rows.filter((c) => c.name.includes("-OPT-"))) {
      const weekdays = JSON.parse(row.weekdays);
      assert.ok(
        weekdays.includes(
          new Date(`${row.startDate}T00:00:00Z`).getUTCDay() || 7,
        ),
      );
      assert.ok(
        weekdays.includes(
          new Date(`${row.endDate}T00:00:00Z`).getUTCDay() || 7,
        ),
      );
      assertSchedule(db, { ...row, weekdays }, row.id);
      let sessions = 0;
      for (
        const date = new Date(`${row.startDate}T00:00:00Z`);
        date.toISOString().slice(0, 10) <= row.endDate;
        date.setUTCDate(date.getUTCDate() + 1)
      )
        if (weekdays.includes(date.getUTCDay() || 7)) sessions++;
      assert.equal(
        sessions,
        db.prepare("SELECT lessons FROM courses WHERE id=?").get(row.courseId)
          .lessons,
      );
    }
    assert.equal(addClassOptions(db).added.length, 0);
    assert.deepEqual(db.prepare("SELECT * FROM enrollments").all(), before);
  } finally {
    db.close();
  }
});

test("legacy sample collisions are corrected only for unregistered sample classes", () => {
  const db = openDatabase(":memory:", true);
  try {
    db.exec(
      "UPDATE classes SET schedule='Thứ 2, Thứ 4 · 18:30 – 20:30',weekdays='[1,3]',startTime='18:30',endTime='20:30' WHERE id=5; UPDATE classes SET weekdays='[2,4]',startTime='19:00',endTime='21:00' WHERE id=6;",
    );
    const before = db.prepare("SELECT * FROM classes WHERE id=1").get();
    addClassOptions(db);
    assert.equal(
      db.prepare("SELECT startTime FROM classes WHERE id=5").get().startTime,
      "16:00",
    );
    assert.equal(
      db.prepare("SELECT startTime FROM classes WHERE id=6").get().startTime,
      "17:00",
    );
    assert.deepEqual(
      db.prepare("SELECT * FROM classes WHERE id=1").get(),
      before,
    );
  } finally {
    db.close();
  }
});

test("adding options does not move a sample class with an existing registration", () => {
  const db = openDatabase(":memory:", true);
  try {
    db.exec(
      "UPDATE classes SET weekdays='[1,3]',startTime='18:30',endTime='20:30' WHERE id=5; INSERT INTO enrollments(userId,classId,name,email,phone) VALUES(2,5,'Existing learner','hocvien@example.com','0901234567');",
    );
    const before = db.prepare("SELECT * FROM classes WHERE id=5").get();
    addClassOptions(db);
    assert.deepEqual(
      db.prepare("SELECT * FROM classes WHERE id=5").get(),
      before,
    );
  } finally {
    db.close();
  }
});
