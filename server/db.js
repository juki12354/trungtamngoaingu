import { DatabaseSync } from "node:sqlite";
import { randomBytes, scryptSync, timingSafeEqual } from "node:crypto";
import { mkdirSync } from "node:fs";
import { dirname } from "node:path";
import * as seed from "./seed.js";
import { migrate } from "./migrations.js";

export function hashPassword(password) {
  const salt = randomBytes(16).toString("hex");
  return `${salt}:${scryptSync(password, salt, 64).toString("hex")}`;
}
export function verifyPassword(password, hash) {
  const [salt, encoded] = hash.split(":");
  return timingSafeEqual(
    Buffer.from(encoded, "hex"),
    scryptSync(password, salt, 64),
  );
}
export const safeUser = (user) =>
  user
    ? {
        id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        birthday: user.birthday,
        role: user.role,
      }
    : null;
export function openDatabase(path, demo) {
  if (path !== ":memory:") mkdirSync(dirname(path), { recursive: true });
  const db = new DatabaseSync(path);
  db.exec(`PRAGMA foreign_keys = ON; PRAGMA journal_mode = WAL;
    CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT NOT NULL, email TEXT UNIQUE NOT NULL, phone TEXT NOT NULL DEFAULT '', birthday TEXT NOT NULL DEFAULT '', passwordHash TEXT NOT NULL, role TEXT NOT NULL DEFAULT 'student' CHECK(role IN ('student','admin')));
    CREATE TABLE IF NOT EXISTS sessions (token TEXT PRIMARY KEY, userId INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE, expires INTEGER NOT NULL);
    CREATE TABLE IF NOT EXISTS courses (id INTEGER PRIMARY KEY, name TEXT NOT NULL, category TEXT NOT NULL, level TEXT NOT NULL, duration INTEGER NOT NULL, tuition INTEGER NOT NULL, lessons INTEGER NOT NULL, audience TEXT NOT NULL, image TEXT NOT NULL, description TEXT NOT NULL, material TEXT NOT NULL DEFAULT '');
    CREATE TABLE IF NOT EXISTS teachers (id INTEGER PRIMARY KEY, name TEXT NOT NULL, degree TEXT NOT NULL, experience INTEGER NOT NULL, specialty TEXT NOT NULL, image TEXT NOT NULL, description TEXT NOT NULL, achievements TEXT NOT NULL DEFAULT '');
    CREATE TABLE IF NOT EXISTS classes (id INTEGER PRIMARY KEY, courseId INTEGER NOT NULL REFERENCES courses(id), teacherId INTEGER NOT NULL REFERENCES teachers(id), name TEXT UNIQUE NOT NULL, startDate TEXT NOT NULL, endDate TEXT NOT NULL, schedule TEXT NOT NULL, campus TEXT NOT NULL, capacity INTEGER NOT NULL);
    CREATE TABLE IF NOT EXISTS enrollments (id INTEGER PRIMARY KEY, userId INTEGER REFERENCES users(id), classId INTEGER NOT NULL REFERENCES classes(id), name TEXT NOT NULL, email TEXT NOT NULL, phone TEXT NOT NULL, birthday TEXT NOT NULL DEFAULT '', note TEXT NOT NULL DEFAULT '', status TEXT NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','confirmed','cancelled')), grades TEXT NOT NULL DEFAULT '{}', createdAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
    CREATE UNIQUE INDEX IF NOT EXISTS active_enrollment ON enrollments(email, classId) WHERE status != 'cancelled';
    CREATE TABLE IF NOT EXISTS questions (id INTEGER PRIMARY KEY, prompt TEXT NOT NULL, options TEXT NOT NULL, answer INTEGER NOT NULL);
    CREATE TABLE IF NOT EXISTS placement_results (id INTEGER PRIMARY KEY, userId INTEGER REFERENCES users(id) ON DELETE SET NULL, score INTEGER NOT NULL, total INTEGER NOT NULL, level TEXT NOT NULL, createdAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
    CREATE TABLE IF NOT EXISTS news (id INTEGER PRIMARY KEY, title TEXT NOT NULL, category TEXT NOT NULL, date TEXT NOT NULL, image TEXT NOT NULL, excerpt TEXT NOT NULL, content TEXT NOT NULL);
    CREATE TABLE IF NOT EXISTS contacts (id INTEGER PRIMARY KEY, name TEXT NOT NULL, email TEXT NOT NULL, phone TEXT NOT NULL, message TEXT NOT NULL, createdAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
    CREATE TABLE IF NOT EXISTS metadata (key TEXT PRIMARY KEY, value TEXT NOT NULL);
  `);
  if (!db.prepare("SELECT 1 FROM metadata WHERE key='seeded'").get()) {
    db.exec("BEGIN");
    try {
      for (const table of [
        "courses",
        "teachers",
        "classes",
        "news",
        "questions",
      ]) {
        for (const row of seed[table]) {
          const keys = Object.keys(row);
          db.prepare(
            `INSERT INTO ${table} (${keys.join(",")}) VALUES (${keys.map(() => "?").join(",")})`,
          ).run(
            ...keys.map((k) =>
              typeof row[k] === "object" ? JSON.stringify(row[k]) : row[k],
            ),
          );
        }
      }
      db.prepare("INSERT INTO metadata VALUES ('seeded', '1')").run();
      db.exec("COMMIT");
    } catch (error) {
      db.exec("ROLLBACK");
      throw error;
    }
  }
  if (demo && !db.prepare("SELECT 1 FROM users LIMIT 1").get()) {
    db.prepare(
      "INSERT INTO users (name,email,passwordHash,role) VALUES (?,?,?,?)",
    ).run(
      "Quản trị viên",
      "admin@vinhenglish.vn",
      hashPassword("Admin@123456"),
      "admin",
    );
    const user = db
      .prepare(
        "INSERT INTO users (name,email,phone,passwordHash,role) VALUES (?,?,?,?,?)",
      )
      .run(
        "Nguyễn Hoàng An",
        "hocvien@example.com",
        "0901234567",
        hashPassword("Student@123456"),
        "student",
      );
    db.prepare(
      "INSERT INTO enrollments (userId,classId,name,email,phone,status,grades) VALUES (?,1,?,?,?,'confirmed',?)",
    ).run(
      Number(user.lastInsertRowid),
      "Nguyễn Hoàng An",
      "hocvien@example.com",
      "0901234567",
      JSON.stringify({ listening: 7, reading: 8, writing: 6.5, speaking: 7 }),
    );
  }
  migrate(db);
  return db;
}
