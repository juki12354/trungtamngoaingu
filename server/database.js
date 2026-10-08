import { AsyncLocalStorage } from "node:async_hooks";
import { readFile } from "node:fs/promises";
import pg from "pg";
import { openDatabase } from "./db.js";
import { addClassOptions } from "../scripts/add-class-options.mjs";

// Keep the existing SQLite SQL/API names at the database boundary. Quoted
// strings and identifiers are tokens, so question marks inside text stay intact.
export function postgresSQL(sql) {
  let parameter = 0;
  return sql.replace(
    /'(?:''|[^'])*'|"(?:""|[^"])*"|--[^\n]*|\/\*[\s\S]*?\*\/|\?|[A-Za-z_][A-Za-z_0-9]*/g,
    (token) => {
      if (token === "?") return `$${++parameter}`;
      if (/^[a-z_][A-Za-z_0-9]*[A-Z][A-Za-z_0-9]*$/.test(token))
        return `"${token}"`;
      return token;
    },
  );
}

export const tables = [
  "users",
  "courses",
  "teachers",
  "classes",
  "enrollments",
  "questions",
  "placement_results",
  "news",
  "contacts",
  "metadata",
  "placement_attempts",
  "materials",
  "audit_logs",
  "sessions",
];
const identityTables = tables.filter(
  (table) => !["metadata", "sessions", "placement_attempts"].includes(table),
);

// One connection per transaction. The advisory lock serializes small-demo writes
// across server instances, including schedule checks and enrollment capacity.
export async function connectDatabase({
  databaseUrl,
  dbPath = ":memory:",
  demo = false,
  initialize = true,
} = {}) {
  const context = new AsyncLocalStorage();
  const postgres = Boolean(databaseUrl);
  const pool = postgres
    ? new pg.Pool({
        connectionString: databaseUrl,
        max: 5,
        connectionTimeoutMillis: 15000,
        idleTimeoutMillis: 10000,
      })
    : null;
  pool?.on("error", (error) =>
    console.error("Database connection error:", error.code || "unknown"),
  );
  const sqlite = postgres ? null : openDatabase(dbPath, demo);
  let queue = Promise.resolve();
  const exclusive = async (callback) => {
    const previous = queue;
    let release;
    queue = new Promise((resolve) => {
      release = resolve;
    });
    await previous;
    try {
      return await callback();
    } finally {
      release();
    }
  };
  const query = async (sql, values = [], mode = "all") => {
    if (!postgres) {
      const run = () =>
        mode === "exec"
          ? sqlite.exec(sql)
          : sqlite.prepare(sql)[mode](...values);
      return context.getStore() ? run() : exclusive(run);
    }
    let text = postgresSQL(sql);
    const insert = /^\s*INSERT\s+INTO\s+(\w+)/i.exec(text);
    if (
      mode === "run" &&
      insert &&
      identityTables.includes(insert[1]) &&
      !/\bRETURNING\b/i.test(text)
    )
      text = text.replace(/;\s*$/, "") + " RETURNING id";
    const result = await (context.getStore() || pool).query(text, values);
    const rows =
      result.rows?.map((row) =>
        Object.fromEntries(
          Object.entries(row).map(([key, value]) => [
            key,
            typeof value === "string" &&
            result.fields.find((field) => field.name === key)?.dataTypeID === 20
              ? Number(value)
              : value,
          ]),
        ),
      ) || [];
    return mode === "get"
      ? rows[0]
      : mode === "run"
        ? { changes: result.rowCount, lastInsertRowid: rows[0]?.id }
        : rows;
  };
  const db = {
    dialect: postgres ? "postgres" : "sqlite",
    prepare: (sql) =>
      Object.fromEntries(
        ["get", "all", "run"].map((mode) => [
          mode,
          (...values) => query(sql, values, mode),
        ]),
      ),
    exec: (sql) => query(sql, [], "exec"),
    close: () => (postgres ? pool.end() : sqlite.close()),
    async transaction(callback) {
      if (context.getStore()) return callback();
      if (!postgres)
        return exclusive(() =>
          context.run(sqlite, async () => {
            sqlite.exec("BEGIN IMMEDIATE");
            try {
              const value = await callback();
              sqlite.exec("COMMIT");
              return value;
            } catch (error) {
              sqlite.exec("ROLLBACK");
              throw error;
            }
          }),
        );
      const client = await pool.connect();
      try {
        await client.query("BEGIN");
        await client.query("SELECT pg_advisory_xact_lock(812326)");
        const value = await context.run(client, callback);
        await client.query("COMMIT");
        return value;
      } catch (error) {
        await client.query("ROLLBACK");
        throw error;
      } finally {
        client.release();
      }
    },
  };
  if (postgres && initialize) {
    try {
      await db.transaction(async () => {
        await db.exec(
          await readFile(
            new URL("./postgres-schema.sql", import.meta.url),
            "utf8",
          ),
        );
        if (
          !(await db.prepare("SELECT 1 FROM metadata WHERE key='seeded'").get())
        ) {
          const sample = openDatabase(":memory:", demo);
          try {
            if (!demo) addClassOptions(sample);
            await copySQLite(sample, db);
          } finally {
            sample.close();
          }
        }
      });
    } catch (error) {
      await db.close();
      throw error;
    }
  }
  return db;
}

// Destination must be empty. Call inside a transaction; preserve IDs and hashes.
export async function copySQLite(source, target) {
  for (const table of tables) {
    if (await target.prepare(`SELECT 1 FROM ${table} LIMIT 1`).get())
      throw new Error(`Destination is not empty: ${table}`);
    for (const row of source.prepare(`SELECT * FROM ${table}`).all()) {
      const keys = Object.keys(row);
      await target
        .prepare(
          `INSERT INTO ${table} (${keys.join(",")}) VALUES (${keys.map(() => "?").join(",")})`,
        )
        .run(
          ...keys.map((key) =>
            row[key] instanceof Uint8Array ? Buffer.from(row[key]) : row[key],
          ),
        );
    }
  }
  for (const table of identityTables)
    await target.exec(
      `SELECT setval(pg_get_serial_sequence('${table}', 'id'), COALESCE(MAX(id), 1), MAX(id) IS NOT NULL) FROM ${table}`,
    );
}
