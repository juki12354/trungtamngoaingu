import pg from "pg";
import { randomUUID } from "node:crypto";
import { createApp as createApplication } from "../../server/app.js";

export async function createApp(options) {
  if (!process.env.TEST_DATABASE_URL) return createApplication(options);
  const fixture = await databaseFixture();
  try {
    const app = await createApplication({
      ...options,
      databaseUrl: fixture.url,
    });
    const close = app.locals.db.close;
    app.locals.db.close = async () => {
      await close();
      await fixture.close();
    };
    return app;
  } catch (error) {
    await fixture.close();
    throw error;
  }
}

export async function databaseFixture() {
  const control = new pg.Client({
    connectionString: process.env.TEST_DATABASE_URL,
  });
  await control.connect();
  // Never reuse or erase an existing database; each API fixture owns its DB.
  const name = `vec_test_${randomUUID().replaceAll("-", "")}`;
  await control.query(`CREATE DATABASE "${name}"`);
  const url = new URL(process.env.TEST_DATABASE_URL);
  url.pathname = `/${name}`;
  return {
    url: url.href,
    async close() {
      await control.query(`DROP DATABASE "${name}"`);
      await control.end();
    },
  };
}
