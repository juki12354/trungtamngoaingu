export function migrate(db) {
  const add = (table, column, definition) => {
    if (
      !db
        .prepare(`PRAGMA table_info(${table})`)
        .all()
        .some((c) => c.name === column)
    )
      db.exec(`ALTER TABLE ${table} ADD COLUMN ${column} ${definition}`);
  };
  db.exec("BEGIN IMMEDIATE");
  try {
    add("teachers", "achievements", "TEXT NOT NULL DEFAULT ''");
    add("teachers", "nationality", "TEXT NOT NULL DEFAULT ''");
    add("classes", "weekdays", "TEXT NOT NULL DEFAULT '[]'");
    add("classes", "startTime", "TEXT NOT NULL DEFAULT ''");
    add("classes", "endTime", "TEXT NOT NULL DEFAULT ''");
    add("classes", "room", "TEXT NOT NULL DEFAULT ''");
    add("classes", "status", "TEXT NOT NULL DEFAULT 'enrolling'");
    add("enrollments", "verifiedAt", "TEXT");
    add("enrollments", "verifiedBy", "INTEGER REFERENCES users(id)");
    add("contacts", "status", "TEXT NOT NULL DEFAULT 'new'");
    add("contacts", "note", "TEXT NOT NULL DEFAULT ''");
    add("contacts", "kind", "TEXT NOT NULL DEFAULT 'consultation'");
    add("contacts", "age", "INTEGER");
    add(
      "contacts",
      "courseId",
      "INTEGER REFERENCES courses(id) ON DELETE SET NULL",
    );
    add("contacts", "campus", "TEXT NOT NULL DEFAULT ''");
    add("placement_results", "review", "TEXT NOT NULL DEFAULT '[]'");
    db.exec(`
      CREATE TABLE IF NOT EXISTS placement_attempts (token TEXT PRIMARY KEY, userId INTEGER REFERENCES users(id), questions TEXT NOT NULL, expires INTEGER NOT NULL, result TEXT);
      CREATE TABLE IF NOT EXISTS materials (id INTEGER PRIMARY KEY, classId INTEGER NOT NULL REFERENCES classes(id), title TEXT NOT NULL, lesson TEXT NOT NULL DEFAULT '', filename TEXT NOT NULL, mime TEXT NOT NULL, size INTEGER NOT NULL, content BLOB NOT NULL, createdAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
      CREATE TABLE IF NOT EXISTS audit_logs (id INTEGER PRIMARY KEY, actorId INTEGER REFERENCES users(id) ON DELETE SET NULL, action TEXT NOT NULL, resource TEXT NOT NULL, recordId INTEGER, createdAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
      CREATE INDEX IF NOT EXISTS enrollments_user_class ON enrollments(userId,classId);
      CREATE TRIGGER IF NOT EXISTS unique_student_enrollment_insert BEFORE INSERT ON enrollments WHEN NEW.userId IS NOT NULL AND NEW.status!='cancelled' AND EXISTS(SELECT 1 FROM enrollments WHERE userId=NEW.userId AND classId=NEW.classId AND status!='cancelled') BEGIN SELECT RAISE(ABORT, 'UNIQUE constraint failed: enrollments.userId, enrollments.classId'); END;
      CREATE TRIGGER IF NOT EXISTS unique_student_enrollment_update BEFORE UPDATE OF userId,classId,status ON enrollments WHEN NEW.userId IS NOT NULL AND NEW.status!='cancelled' AND EXISTS(SELECT 1 FROM enrollments WHERE userId=NEW.userId AND classId=NEW.classId AND status!='cancelled' AND id!=NEW.id) BEGIN SELECT RAISE(ABORT, 'UNIQUE constraint failed: enrollments.userId, enrollments.classId'); END;
    `);
    if (
      !db
        .prepare("SELECT 1 FROM metadata WHERE key='structured-schedules-v1'")
        .get()
    ) {
      for (const row of db.prepare("SELECT * FROM classes").all()) {
        const weekdays = [...row.schedule.matchAll(/Thứ ([2-7])/g)].map(
          (m) => Number(m[1]) - 1,
        );
        if (/Chủ nhật|CN/.test(row.schedule)) weekdays.push(7);
        const times = row.schedule.match(/\d{2}:\d{2}/g) || [];
        db.prepare(
          "UPDATE classes SET weekdays=?,startTime=?,endTime=? WHERE id=?",
        ).run(
          JSON.stringify([...new Set(weekdays)]),
          times[0] || "",
          times[1] || "",
          row.id,
        );
      }
      db.prepare(
        "INSERT INTO metadata VALUES ('structured-schedules-v1','1')",
      ).run();
    }
    db.exec("COMMIT");
  } catch (e) {
    db.exec("ROLLBACK");
    throw e;
  }
}
