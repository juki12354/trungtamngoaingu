import { connectDatabase } from "../server/database.js";
const db = await connectDatabase({
  databaseUrl: process.env.DATABASE_URL,
  dbPath: process.env.DB_PATH || "data/center.sqlite",
  demo: process.env.NODE_ENV !== "production",
});
try {
  const counts = {};
  for (const table of ["courses", "teachers", "classes", "questions"])
    counts[table] = (
      await db.prepare(`SELECT count(*) n FROM ${table}`).get()
    ).n;
  counts.languages = (
    await db.prepare("SELECT count(DISTINCT language) n FROM courses").get()
  ).n;
  console.log(JSON.stringify(counts));
} finally {
  await db.close();
}
